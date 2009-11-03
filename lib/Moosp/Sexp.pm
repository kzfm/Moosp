package Moosp::Sexp;

=head1 NAME

Moosp::Sexp - S expression

=cut

use Moose::Role;

requires 'str';

=head2 print

=cut

sub print { 
  my $self = shift;
  print $self->str;

}

=head2 serialize

=cut

sub serialize {
  my $self = shift;
  return $self->str;
}

no Moose::Role;

1;
