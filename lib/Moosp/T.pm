package Moosp::T;

=head1 NAME

Moosp::T - T object

=cut

use MooseX::Singleton;

#extends 'Moosp::Atom';
with 'Moosp::Sexp';

=head2 str

=cut

sub str {"T"}

__PACKAGE__->meta->make_immutable;

no MooseX::Singleton;

1; # End of Moosp::T


