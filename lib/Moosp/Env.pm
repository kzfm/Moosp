package Moosp::Env;

use Moose;
use MooseX::AttributeHelpers;
use Moosp::Symbol;
use Moosp::Nil;

=head1 NAME

Moosp::Env - Environment

=cut

has symbol => (
	       is => 'rw',
	       isa => 'HashRef[Moosp::Symbol]',
	       default => sub{{}},
	       );

=head2 BUILD

=cut

sub BUILD {
  my $self = shift;
}


=head2 put

=cut

sub put {
  my ($self, $sym, $name) = @_;
  $name = $sym->serialize unless $name;
  $self->symbol->{$name} = $sym;
  return $sym;
}

=head2 get_symbol

=cut

sub get_symbol {
  my ($self, $sym) = @_;

  if (ref($sym)) {
    return $self->get_symbol($sym->serialize) if $sym->isa('Moosp::Symbol');
  } else {
    my $symbol = $self->symbol->{$sym};
    if($symbol) {
      return $symbol;
    }
    else {
      return Moosp::Nil->new;
    }
  }
}


=head2 set_symbol

=cut

sub set_symbol {
  my ($self, $sym) = @_;
  $self->symbol->{$sym->serialize} = $sym;
  return $sym;
}

=head2 remove

=cut

sub remove {
  my ($self, $sym) = @_;
  undef($self->symbol->{$sym->serialize});
  return $sym->value;
}

=head2 dump

=cut

sub dump {
  my $self = shift;

  while ( my ($key, $sym) = each(%{$self->symbol}) ) {
    print $key . " " . $sym->name . " " . $sym->value->serialize . "\n";
  }
}

__PACKAGE__->meta->make_immutable;

no Moose;

1; # End of Moosp::Env
