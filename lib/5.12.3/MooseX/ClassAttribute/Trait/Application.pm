package MooseX::ClassAttribute::Trait::Application;
BEGIN {
  $MooseX::ClassAttribute::Trait::Application::VERSION = '0.21';
}

use strict;
use warnings;

use namespace::autoclean;
use Moose::Role;

after apply_attributes => sub {
    shift->_apply_class_attributes(@_);
};

1;

# ABSTRACT: A trait that supports role application for roles with class attributes



=pod

=head1 NAME

MooseX::ClassAttribute::Trait::Application - A trait that supports role application for roles with class attributes

=head1 VERSION

version 0.21

=head1 DESCRIPTION

This trait is used to allow the application of roles containing class
attributes.

=head1 BUGS

See L<MooseX::ClassAttribute> for details.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Dave Rolsky.

This is free software, licensed under:

  The Artistic License 2.0

=cut


__END__

