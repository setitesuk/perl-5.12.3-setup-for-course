package MooseX::POE::Aliased;
BEGIN {
  $MooseX::POE::Aliased::VERSION = '0.211';
}
# ABSTRACT: A sane alias attribute for your MooseX::POE objects.
use MooseX::POE::Role;

use overload ();

use POE;

has alias => (
    isa => "Maybe[Str]",
    is  => "rw",
    builder     => "_build_alias",
    clearer     => "clear_alias",
    predicate   => "has_alias",
    trigger => sub {
        my ( $self, $alias ) = @_;
        $self->call( _update_alias => $alias );
    }
);

sub BUILD {
    my ($self) = @_;

    $self->call( _update_alias => $self->alias )
      if $self->has_alias;
}

sub _build_alias {
    my $self = shift;
    overload::StrVal($self);
}

event _update_alias => sub {
    my ( $kernel, $self, $alias ) = @_[KERNEL, OBJECT, ARG0];

    # we need to remove the prev alias like this because we don't know the
    # previous value.
    $kernel->alarm_remove_all();

	$kernel->alias_set($alias) if defined $alias;
};

__PACKAGE__;



=pod

=head1 NAME

MooseX::POE::Aliased - A sane alias attribute for your MooseX::POE objects.

=head1 VERSION

version 0.211

=head1 SYNOPSIS

	use MooseX::POE;

    with qw(MooseX::POE::Aliased);

    my $obj = Foo->new( alias => "blah" );

    $obj->alias("arf"); # previous one is removed, new one is set

    $obj->alias(undef); # no alias set

=head1 DESCRIPTION

This role provides an C<alias> attribute for your L<MooseX::POE> objects.

The attribute can be set, causing the current alias to be cleared and the new
value to be set.

=head1 METHODS

=head2 alias

The alias to set for the session.

Defaults to the C<overload::StrVal> of the object.

If the value is set at runtime the alias will be updated in the L<POE::Kernel>.

A value of C<undef> inhibits aliasing.

=head1 ATTRIBUTES

=head1 AUTHORS

=over 4

=item *

Chris Prather <chris@prather.org>

=item *

Ash Berlin <ash@cpan.org>

=item *

Chris Williams <chris@bingosnet.co.uk>

=item *

Yuval (nothingmuch) Kogman

=item *

Torsten Raudssus <torsten@raudssus.de> L<http://www.raudssus.de/>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Chris Prather, Ash Berlin, Chris Williams, Yuval Kogman, Torsten Raudssus.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__



