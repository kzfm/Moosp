package Moosp::Symbol;

=head1 Moosp::Symbol

Moosp::Symbol - Symbol object

=cut

use Moose;

extends 'Moosp::Atom';

has 'name'  => ( is => 'ro', isa => 'Str', required => 1 );
has 'value' => ( is => 'rw', does => 'Moosp::Sexp', default => undef );

=head2 intern

=cut

sub intern {
  my ($self, $env) = @_;
  return $env->put($self);
}

=head2 unintern

=cut

sub unintern {
  my ($self, $env) = @_;
  return $env->remove($self);
}

=head2 unbound

=cut

sub unbound {
  my $self = shift;
  $self->value(undef);
  return $self;
}

=head2 print

=cut

sub print {
  my $self = shift;
  print $self->name;
}

=head2 serialize

=cut

sub serialize {
  my $self = shift;
  return $self->name;
}

__PACKAGE__->meta->make_immutable;

no Moose;

1; # End of Moosp::Symbol
