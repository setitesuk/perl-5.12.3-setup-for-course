package MooseX::Types::Set::Object;
BEGIN {
  $MooseX::Types::Set::Object::AUTHORITY = 'cpan:NUFFIN';
}
BEGIN {
  $MooseX::Types::Set::Object::VERSION = '0.03';
}
# ABSTRACT: Set::Object type with coercions and stuff.


use MooseX::Types;
use MooseX::Types::Moose qw(Object ArrayRef);

use Set::Object ();
use Scalar::Util ();

class_type "Set::Object"; # FIXME parameterizable

coerce "Set::Object",
    from ArrayRef,
    via { Set::Object->new(@$_) };

coerce ArrayRef,
    from "Set::Object",
    via { [$_->members] };

1;


__END__
=pod

=encoding utf-8

=head1 NAME

MooseX::Types::Set::Object - Set::Object type with coercions and stuff.

=head1 SYNOPSIS

    package Foo;
    use Moose;

    use MooseX::Types::Set::Object;

    has children => (
        isa      => "Set::Object",
        accessor => "transition_set",
        coerce   => 1, # also accept array refs
        handles  => {
            children     => "members",
            add_child    => "insert",
            remove_child => "remove",
            # See Set::Object for all the methods you could delegate
        },
    );

    # ...

    my $foo = Foo->new( children => [ @objects ] );

    $foo->add_child( $obj );

=head1 DESCRIPTION

This module provides Moose type constraints (see
L<Moose::Util::TypeConstraints>, L<MooseX::Types>).

=head1 TYPES

=over 4

=item Set::Object

A subtype of C<Object> that isa L<Set::Object> with coercions to and from the
C<ArrayRef> type.

=back

=head1 SEE ALSO

L<Set::Object>, L<MooseX::AttributeHandlers>, L<MooseX::Types>,
L<Moose::Util::TypeConstraints>

=head1 AUTHOR

Yuval Kogman <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Yuval Kogman.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

