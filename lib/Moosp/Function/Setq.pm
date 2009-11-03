package Moosp::Function::Setq;

=head1 NAME

Moosp::Function::Car - System Function Car

=cut

use Moose;

extends 'Moosp::Function';
with 'Moosp::Sexp';

=head2 fun

=cut

sub fun {
  my ($self, $arguments) = @_;
  my $arg1 = $self->eval->eval($arguments->cdr)->car;
  my $sym = $arguments->car;
  $sym->value($arg1);
  $self->env->put($sym,$sym->name);
  return $arg1;
}

=head2 str

=cut

sub str {
  my $self = shift;
  return "<SystemFunction: " . ref($self) . ">";
}

no Moose;

1; # End of Moosp::Function::Car
