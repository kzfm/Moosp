package Moosp::List;

=head1 NAME

Moosp::List - List object

=cut

use Moose;
use Moosp::Nil;
extends 'Moosp::Cell';

=head2 BUILD

=cut

sub BUILD {
  my ($self, $args) = @_;
  if($args->{car}) {
    $self->car($args->{car});
  }
  else {
    $self->car(Moosp::Nil->instance);
  }
  if($args->{cdr}){
    $self->cdr($args->{cdr});
  }
  else {
    $self->cdr(Moosp::Nil->instance);
  }
  return $self;
}

=head2 serialize

=cut

sub serialize {
  my $self = shift;
  my $str = "(";
  while(1){
    $str .= $self->car->serialize;

    if ($self->cdr->isa('Moosp::Nil')) {
      $str .= ")";
      last;
    }
    elsif ($self->cdr->isa('Moosp::Atom')) {
      $str .= " . " . $self->cdr->serialize . ")";
      last;
    }
    else {
      $self = $self->cdr;
      $str .= " ";
    }
  }
  return $str;
}

1; # End of Moosp::List
