package Moosp::Nil;

=head1 NAME

Moosp::Nil - Nil object

=cut

use MooseX::Singleton;

with 'Moosp::Sexp';

=head2 str

=cut

sub str {"NIL"}

__PACKAGE__->meta->make_immutable;

no MooseX::Singleton;

1;
