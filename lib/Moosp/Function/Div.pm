package Moosp::Function::Div;

use Moose;
use Moosp::Integer;

=head1 NAME

Moosp::Function::Div - system function sub

=cut

extends 'Moosp::Function';
with 'Moosp::Sexp';

=head2 fun

=cut

sub fun {
  my ($self, $arguments) = @_;
  my $arg1;
  die "DIV ERROR" if ($arguments->isa('Moosp::Nil'));
  my $ret = $self->eval->eval($arguments->car);
  $arguments = $arguments->cdr;

  while (1) {
    $arg1 = $self->eval->eval($arguments->car);
    $ret = $ret->div($arg1);
    last if ($arguments->cdr->isa('Moosp::Nil'));
    $arguments = $arguments->cdr;
  }
  return $ret;
}

=head2 str

=cut

sub str {
  my $self = shift;
  return "<SystemFunction: " . ref($self) . ">";
}

no Moose;

1; # End of Moosp::Function::Div
