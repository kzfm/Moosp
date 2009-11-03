package Moosp::Function::If;

use Moose;

=head1 NAME

Moosp::Function::If - system function add

=cut

extends 'Moosp::Function';
with 'Moosp::Sexp';

=head2 fun

=cut

sub fun {
  my ($self, $arguments) = @_;
  return $self->eval->eval($arguments->cdr->car) if ($arguments->car->isa('Moosp::T'));
  return $self->eval->eval($arguments->cdr->cdr->car) if ($arguments->car->isa('Moosp::Nil'));
  die "Cannnot evaluate If ";
}

=head2 str

=cut

sub str {
  my $self = shift;
  return "<SystemFunction: " . ref($self) . ">";
}

no Moose;

1; # End of Moosp::Function::If
