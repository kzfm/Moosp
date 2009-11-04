package Moosp::Function::Ge;

use Moose;
use Moosp::Integer;
use Moosp::T;
use Moosp::Nil;

=head1 NAME

Moosp::Function::Ge - system function greater or equal

=cut

extends 'Moosp::Function';
with 'Moosp::Sexp';

=head2 fun

=cut

sub fun {
  my ($self, $arguments) = @_;
  die "too few arguments" if ($arguments->isa('Moosp::Nil'));
  return $arguments->car->ge($arguments->cdr->car);
}

=head2 str

=cut

sub str {
  my $self = shift;
  return "<SystemFunction: " . ref($self) . ">";
}

no Moose;

1; # End of Moosp::Function::Ge
