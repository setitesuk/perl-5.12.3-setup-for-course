package Scope::Upper;

use strict;
use warnings;

=head1 NAME

Scope::Upper - Act on upper scopes.

=head1 VERSION

Version 0.12

=cut

our $VERSION;
BEGIN {
 $VERSION = '0.12';
}

=head1 SYNOPSIS

L</reap>, L</localize>, L</localize_elem>, L</localize_delete> and L</WORDS> :

    package Scope;

    use Scope::Upper qw/reap localize localize_elem localize_delete :words/;

    sub new {
     my ($class, $name) = @_;

     localize '$tag' => bless({ name => $name }, $class) => UP;

     reap { print Scope->tag->name, ": end\n" } UP;
    }

    # Get the tag stored in the caller namespace
    sub tag {
     my $l   = 0;
     my $pkg = __PACKAGE__;
     $pkg    = caller $l++ while $pkg eq __PACKAGE__;

     no strict 'refs';
     ${$pkg . '::tag'};
    }

    sub name { shift->{name} }

    # Locally capture warnings and reprint them with the name prefixed
    sub catch {
     localize_elem '%SIG', '__WARN__' => sub {
      print Scope->tag->name, ': ', @_;
     } => UP;
    }

    # Locally clear @INC
    sub private {
     for (reverse 0 .. $#INC) {
      # First UP is the for loop, second is the sub boundary
      localize_delete '@INC', $_ => UP UP;
     }
    }

    ...

    package UserLand;

    {
     Scope->new("top");      # initializes $UserLand::tag

     {
      Scope->catch;
      my $one = 1 + undef;   # prints "top: Use of uninitialized value..."

      {
       Scope->private;
       eval { require Cwd };
       print $@;             # prints "Can't locate Cwd.pm in @INC (@INC contains:) at..."
      }

      require Cwd;           # loads Cwd.pm
     }

    }                        # prints "top: done"

L</unwind> and L</want_at> :

    package Try;

    use Scope::Upper qw/unwind want_at :words/;

    sub try (&) {
     my @result = shift->();
     my $cx = SUB UP; # Point to the sub above this one
     unwind +(want_at($cx) ? @result : scalar @result) => $cx;
    }

    ...

    sub zap {
     try {
      my @things = qw/a b c/;
      return @things; # returns to try() and then outside zap()
      # not reached
     };
     # not reached
    }

    my @stuff = zap(); # @stuff contains qw/a b c/
    my $stuff = zap(); # $stuff contains 3

=head1 DESCRIPTION

This module lets you defer actions I<at run-time> that will take place when the control flow returns into an upper scope.
Currently, you can:

=over 4

=item *

hook an upper scope end with L</reap> ;

=item *

localize variables, array/hash values or deletions of elements in higher contexts with respectively L</localize>, L</localize_elem> and L</localize_delete> ;

=item *

return values immediately to an upper level with L</unwind>, and know which context was in use then with L</want_at>.

=back

=head1 FUNCTIONS

In all those functions, C<$context> refers to the target scope.

You have to use one or a combination of L</WORDS> to build the C<$context> passed to these functions.
This is needed in order to ensure that the module still works when your program is ran in the debugger.
The only thing you can assume is that it is an I<absolute> indicator of the frame, which means that you can safely store it at some point and use it when needed, and it will still denote the original scope.

=cut

BEGIN {
 require XSLoader;
 XSLoader::load(__PACKAGE__, $VERSION);
}

=head2 C<reap $callback, $context>

Adds a destructor that calls C<$callback> (in void context) when the upper scope represented by C<$context> ends.

=head2 C<localize $what, $value, $context>

Introduces a C<local> delayed to the time of first return into the upper scope denoted by C<$context>.
C<$what> can be :

=over 4

=item *

A glob, in which case C<$value> can either be a glob or a reference.
L</localize> follows then the same syntax as C<local *x = $value>.
For example, if C<$value> is a scalar reference, then the C<SCALAR> slot of the glob will be set to C<$$value> - just like C<local *x = \1> sets C<$x> to C<1>.

=item *

A string beginning with a sigil, representing the symbol to localize and to assign to.
If the sigil is C<'$'>, L</localize> follows the same syntax as C<local $x = $value>, i.e. C<$value> isn't dereferenced.
For example,

    localize '$x', \'foo' => HERE;

will set C<$x> to a reference to the string C<'foo'>.
Other sigils (C<'@'>, C<'%'>, C<'&'> and C<'*'>) require C<$value> to be a reference of the corresponding type.

When the symbol is given by a string, it is resolved when the actual localization takes place and not when L</localize> is called.
Thus, if the symbol name is not qualified, it will refer to the variable in the package where the localization actually takes place and not in the one where the L</localize> call was compiled.
For example,

    {
     package Scope;
     sub new { localize '$tag', $_[0] => UP }
    }

    {
     package Tool;
     {
      Scope->new;
      ...
     }
    }

will localize C<$Tool::tag> and not C<$Scope::tag>.
If you want the other behaviour, you just have to specify C<$what> as a glob or a qualified name.

Note that if C<$what> is a string denoting a variable that wasn't declared beforehand, the relevant slot will be vivified as needed and won't be deleted from the glob when the localization ends.
This situation never arises with C<local> because it only compiles when the localized variable is already declared.
Although I believe it shouldn't be a problem as glob slots definedness is pretty much an implementation detail, this behaviour may change in the future if proved harmful.

=back

=head2 C<localize_elem $what, $key, $value, $context>

Introduces a C<local $what[$key] = $value> or C<local $what{$key} = $value> delayed to the time of first return into the upper scope denoted by C<$context>.
Unlike L</localize>, C<$what> must be a string and the type of localization is inferred from its sigil.
The two only valid types are array and hash ; for anything besides those, L</localize_elem> will throw an exception.
C<$key> is either an array index or a hash key, depending of which kind of variable you localize.

If C<$what> is a string pointing to an undeclared variable, the variable will be vivified as soon as the localization occurs and emptied when it ends, although it will still exist in its glob.

=head2 C<localize_delete $what, $key, $context>

Introduces the deletion of a variable or an array/hash element delayed to the time of first return into the upper scope denoted by C<$context>.
C<$what> can be:

=over 4

=item *

A glob, in which case C<$key> is ignored and the call is equivalent to C<local *x>.

=item *

A string beginning with C<'@'> or C<'%'>, for which the call is equivalent to respectiveley C<local $a[$key]; delete $a[$key]> and C<local $h{$key}; delete $h{$key}>.

=item *

A string beginning with C<'&'>, which more or less does C<undef &func> in the upper scope.
It's actually more powerful, as C<&func> won't even C<exists> anymore.
C<$key> is ignored.

=back

=head2 C<unwind @values, $context>

Returns C<@values> I<from> the context pointed by C<$context>, i.e. from the subroutine, eval or format at or just above C<$context>, and immediately restart the program flow at this point - thus effectively returning to an upper scope.

The upper context isn't coerced onto C<@values>, which is hence always evaluated in list context.
This means that

    my $num = sub {
     my @a = ('a' .. 'z');
     unwind @a => HERE;
     # not reached
    }->();

will set C<$num> to C<'z'>.
You can use L</want_at> to handle these cases.

=head2 C<want_at $context>

Like C<wantarray>, but for the subroutine/eval/format at or just above C<$context>.

The previous example can then be "corrected" :

    my $num = sub {
     my @a = ('a' .. 'z');
     unwind +(want_at(HERE) ? @a : scalar @a) => HERE;
     # not reached
    }->();

will rightfully set C<$num> to C<26>.

=head1 CONSTANTS

=head2 C<SU_THREADSAFE>

True iff the module could have been built when thread-safety features.

=head1 WORDS

=head2 Constants

=head3 C<TOP>

Returns the context that currently represents the highest scope.

=head3 C<HERE>

The context of the current scope.

=head2 Getting a context from a context

For any of those functions, C<$from> is expected to be a context.
When omitted, it defaults to the the current context.

=head3 C<UP $from>

The context of the scope just above C<$from>.

=head3 C<SUB $from>

The context of the closest subroutine above C<$from>.
Note that C<$from> is returned if it is already a subroutine context ; hence C<SUB SUB == SUB>.

=head3 C<EVAL $from>

The context of the closest eval above C<$from>.
Note that C<$from> is returned if it is already an eval context ; hence C<EVAL EVAL == EVAL>.

=head2 Getting a context from a level

Here, C<$level> should denote a number of scopes above the current one.
When omitted, it defaults to C<0> and those functions return the same context as L</HERE>.

=head3 C<SCOPE $level>

The C<$level>-th upper context, regardless of its type.

=head3 C<CALLER $level>

The context of the C<$level>-th upper subroutine/eval/format.
It kind of corresponds to the context represented by C<caller $level>, but while e.g. C<caller 0> refers to the caller context, C<CALLER 0> will refer to the top scope in the current context.

=head2 Examples

Where L</reap> fires depending on the C<$cxt> :

    sub {
     eval {
      sub {
       {
        reap \&cleanup => $cxt;
        ...
       }     # $cxt = SCOPE(0), or HERE
       ...
      }->(); # $cxt = SCOPE(1), or UP, or SUB, or CALLER, or CALLER(0)
      ...
     };      # $cxt = SCOPE(2), or UP UP, or UP SUB, or EVAL, or CALLER(1)
     ...
    }->();   # $cxt = SCOPE(3), or SUB UP SUB, or SUB EVAL, or CALLER(2)
    ...

Where L</localize>, L</localize_elem> and L</localize_delete> act depending on the C<$cxt> :

    sub {
     eval {
      sub {
       {
        localize '$x' => 1 => $cxt;
        # $cxt = SCOPE(0), or HERE
        ...
       }
       # $cxt = SCOPE(1), or UP, or SUB, or CALLER, or CALLER(0)
       ...
      }->();
      # $cxt = SCOPE(2), or UP UP, or UP SUB, or EVAL, or CALLER(1)
      ...
     };
     # $cxt = SCOPE(3), or SUB UP SUB, or SUB EVAL, or CALLER(2)
     ...
    }->();
    # $cxt = SCOPE(4), UP SUB UP SUB, or UP SUB EVAL, or UP CALLER(2), or TOP
    ...

Where L</unwind> and L</want_at> point to depending on the C<$cxt>:

    sub {
     eval {
      sub {
       {
        unwind @things => $cxt;
        ...
       }
       ...
      }->(); # $cxt = SCOPE(0 .. 1), or HERE, or UP, or SUB, or CALLER(0)
      ...
     };      # $cxt = SCOPE(2), or UP UP, or UP SUB, or EVAL, or CALLER(1)
     ...
    }->();   # $cxt = SCOPE(3), or SUB UP SUB, or SUB EVAL, or CALLER(2)
    ...

=head1 EXPORT

The functions L</reap>, L</localize>, L</localize_elem>, L</localize_delete>,  L</unwind> and L</want_at> are only exported on request, either individually or by the tags C<':funcs'> and C<':all'>.

The constant L</SU_THREADSAFE> is also only exported on request, individually or by the tags C<':consts'> and C<':all'>.

Same goes for the words L</TOP>, L</HERE>, L</UP>, L</SUB>, L</EVAL>, L</SCOPE> and L</CALLER> that are only exported on request, individually or by the tags C<':words'> and C<':all'>.

=cut

use base qw/Exporter/;

our @EXPORT      = ();
our %EXPORT_TAGS = (
 funcs  => [ qw/reap localize localize_elem localize_delete unwind want_at/ ],
 words  => [ qw/TOP HERE UP SUB EVAL SCOPE CALLER/ ],
 consts => [ qw/SU_THREADSAFE/ ],
);
our @EXPORT_OK   = map { @$_ } values %EXPORT_TAGS;
$EXPORT_TAGS{'all'} = [ @EXPORT_OK ];

=head1 CAVEATS

Be careful that local variables are restored in the reverse order in which they were localized.
Consider those examples:

    local $x = 0;
    {
     reap sub { print $x } => HERE;
     local $x = 1;
     ...
    }
    # prints '0'
    ...
    {
     local $x = 1;
     reap sub { $x = 2 } => HERE;
     ...
    }
    # $x is 0

The first case is "solved" by moving the C<local> before the C<reap>, and the second by using L</localize> instead of L</reap>.

The effects of L</reap>, L</localize> and L</localize_elem> can't cross C<BEGIN> blocks, hence calling those functions in C<import> is deemed to be useless.
This is an hopeless case because C<BEGIN> blocks are executed once while localizing constructs should do their job at each run.
However, it's possible to hook the end of the current scope compilation with L<B::Hooks::EndOfScope>.

Some rare oddities may still happen when running inside the debugger.
It may help to use a perl higher than 5.8.9 or 5.10.0, as they contain some context-related fixes.

=head1 DEPENDENCIES

L<XSLoader> (standard since perl 5.006).

=head1 SEE ALSO

L<perlfunc/local>, L<perlsub/"Temporary Values via local()">.

L<Alias>, L<Hook::Scope>, L<Scope::Guard>, L<Guard>.

L<Continuation::Escape> is a thin wrapper around L<Scope::Upper> that gives you a continuation passing style interface to L</unwind>.
It's easier to use, but it requires you to have control over the scope where you want to return.

L<Scope::Escape>.

=head1 AUTHOR

Vincent Pit, C<< <perl at profvince.com> >>, L<http://www.profvince.com>.

You can contact me by mail or on C<irc.perl.org> (vincent).

=head1 BUGS

Please report any bugs or feature requests to C<bug-scope-upper at rt.cpan.org>, or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Scope-Upper>.
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Scope::Upper

Tests code coverage report is available at L<http://www.profvince.com/perl/cover/Scope-Upper>.

=head1 ACKNOWLEDGEMENTS

Inspired by Ricardo Signes.

Thanks to Shawn M. Moore for motivation.

=head1 COPYRIGHT & LICENSE

Copyright 2008,2009,2010 Vincent Pit, all rights reserved.

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

1; # End of Scope::Upper
