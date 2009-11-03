package Moosp::Function;

use Moose;
use Moosp::Symbol;

=head1 NAME

Moosp::Function - The great new Moosp::Function!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

has 'eval' => (is => 'rw', isa => 'Moosp::Eval', required => 1);
has 'env' => (is => 'rw', isa => 'Moosp::Env', required => 1);

=head2 regist

=cut

sub regist {
  my ($self, $name)  = @_;
  my $sym = Moosp::Symbol->new(name => $name);
  $sym->value($self);
  $self->env->put($sym,$name);
}

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

no Moose;

1; # End of Moosp::Function
