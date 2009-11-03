package Moosp::Function::Add;

use Moose;
use Moosp::Integer;

=head1 NAME

Moosp::Function::Add - system function add

=cut

extends 'Moosp::Function';
with 'Moosp::Sexp';

=head2 fun

=cut

sub fun {
  my ($self, $arguments) = @_;
  my $arg1;
  my $ret =  Moosp::Integer->new(value => 0);
  return $ret if ($arguments->isa('Moosp::Nil'));

  while (1) {
    $arg1 = $self->eval->eval($arguments->car);
    $ret = $ret->add($arg1);
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

1; # End of Moosp::Function::Add
