package Moosp::Function::Quote;

=head1 NAME

Moosp::Function::Quote - System Function Quote

=cut

use Moose;

extends 'Moosp::Function';
with 'Moosp::Sexp';

=head2 fun

=cut

sub fun {
  my ($self, $arguments) = @_;
  return $arguments;
}

=head2 str

=cut

sub str {
  my $self = shift;
  return "<SystemFunction: " . ref($self) . ">";
}

no Moose;

1; # End of Moosp::Function::Quote
