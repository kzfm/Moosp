package Moosp::Cell;

use Moosp::Nil;
use Moose;

=head1 NAME

Moosp::Cell - Cell

=cut

has 'car' => (
	      is => 'rw',
	      default => sub{ Moosp::Nil->instance }
);

has 'cdr' => (
	      is => 'rw',
	      default => sub { Moosp::Nil->instance }
);

__PACKAGE__->meta->make_immutable;

no Moose;

1;
