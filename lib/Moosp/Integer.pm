package Moosp::Integer;

=head1 NAME

Moosp::Integer - Integer object

=cut

use Moose;

extends 'Moosp::Number';
with 'Moosp::Sexp';

has 'value' => (is => 'rw',isa => 'Int');

=head2 add

=cut

sub add {
  my ($self, $i) = @_;
  my $new_value = $self->value + $i->value;
  __PACKAGE__->new({value => $new_value});
}

=head2 subt

=cut

sub subt {
  my ($self, $i) = @_;
  my $new_value = $self->value - $i->value;
  __PACKAGE__->new({value => $new_value});
}

=head2 mul

=cut

sub mul {
  my ($self, $i) = @_;
  my $new_value = $self->value * $i->value;
  __PACKAGE__->new({value => $new_value});
}

=head2 div

=cut

sub div {
  my ($self, $i) = @_;
  my $new_value = int($self->value / $i->value);
  __PACKAGE__->new({value => $new_value});
}

=head2 ge

=cut

sub ge {
  my ($self, $i) = @_;
  if ($self->value >= $i->value){
    return Moosp::T->new();
  }
  else {
    return Moosp::Nil->new();
  }
}

=head2 str

=cut

sub str {
  my $self = shift;
  return $self->value;
}

__PACKAGE__->meta->make_immutable;
no Moose;

1; # End of Moosp::Integer
