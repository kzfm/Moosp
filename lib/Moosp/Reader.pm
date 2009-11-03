package Moosp::Reader;

=head1 NAME

Moosp::Reader - Reader

=cut

use Moose;
use Moosp::Nil;
use Moosp::T;
use Moosp::List;
use Moosp::Integer;
use Moosp::Symbol;
use Moosp::Env;

has env => ( is => 'rw', isa => 'Moosp::Env', default => sub { Moosp::Env->new });
has index => (is => 'rw', isa => 'Int', default => 0 );
has strings => (is => 'rw', isa => 'Str');
has char => (is => 'rw', isa => 'Str');

=head2 get_char

=cut

sub get_char {
  my $self = shift;
  my $index = $self->index;
  $self->char(substr($self->strings,$index,1));
  $self->index($index + 1);
  return $self->char;
}

=head2 next_char

=cut

sub next_char {
  my $self = shift;
  $self->char(substr($self->strings,$self->index,1));
  return $self->char;
}

=head2 getSexpPrepare

=cut

sub getSexpPrepare {
  my $self = shift;
  $self->getSexpPrepareString(@_);
}

=head2 readFromString

=cut

sub readFromString {
  my ($self, $input) = @_;
  $self->getSexpPrepareString($input);
  $self->getSexp;
}

=head2 getSexpPrepareString

=cut

sub getSexpPrepareString {
  my ($self, $input) = @_;
  $self->index(0);
  $self->strings($input);
}

=head2 getSexp

=cut

sub getSexp {
  my $self = shift;
  while (my $ch = $self->get_char()) {
    if    ($ch eq '(')  { return $self->makeList(); }
    elsif ($ch eq '\'') { return $self->makeQuote(); }
    elsif ($ch eq '-')  { return $self->makeMinusNumber(); }
    else  {
      if ($ch =~ /\s/)  { last; }
      if ($ch =~ /\d/)   { return $self->makeNumber($ch); }
      return $self->makeSymbol($ch);
    }
  }
  return Moosp::Nil->instance;
}

=head2 makeList

=cut

sub makeList {
  my $self = shift;
  if ($self->next_char eq ')'){
    $self->get_char;
    $self->get_char;
    return Moosp::Nil->new();
  }

  my $top = Moosp::List->new();
  my $list = $top;
  my $ch;
  while(1) {
    $list->car($self->getSexp());
    $ch =  $self->char;
    last if ($ch eq ')');
    return Moosp::Nil->instance if ($ch eq '');
    if ($self->next_char eq '.') {
      $ch = $self->get_char();
      $ch = $self->get_char();
      $list->cdr($self->getSexp());
      return $top;
    }
    $list->cdr(Moosp::List->new());
    $list = $list->cdr();
  }
  $ch = $self->get_char();
  return $top;
}

=head2 makeNumber

=cut

sub makeNumber {
  my ($self, $str) = @_;
  while (my $ch = $self->get_char()) {
    last if $ch eq '(' || $ch eq ')';
    last if $ch =~ /\s/;
    unless ($ch =~ /\d/) {
      $self->index($self->index - 1);
      return $self->makeSymbolInternal($str);
    }
    $str .= $ch;
  }
  return Moosp::Integer->new({value => $str});
}

=head2 makeSymbol

=cut

sub makeSymbol {
  my ($self, $ch) = @_;
  return $self->makeSymbolInternal($ch);
}

=head2 makeSymbolInternal

=cut

sub makeSymbolInternal {
  my ($self, $str) = @_;
  while (my $ch = $self->get_char()) {
    last if ($ch eq '(' || $ch eq ')');
    last if $ch =~ /\s/;
    $str .= $ch;
  }
  $str = uc $str;
  return Moosp::T->instance if ($str eq 'T');
  return Moosp::Nil->instance if ($str eq "NIL");

  my $sym = $self->env->get_symbol($str);
  return $self->env->put(Moosp::Symbol->new(name => $str)) if $sym->isa('Moosp::Nil');
  return $sym;
}

=head2 makeMinusNumber

=cut

sub makeMinusNumber {
  my $self = shift;
  my $nch = $self->next_char();
  return $self->makeSymbolInternal("-") unless $nch =~ /\d/;
  return $self->makeNumber("-");
}

=head2 makeQuote

=cut

sub makeQuote {
  my $self = shift;
  my $top = Moosp::List->new();
  my $list = $top;
  $list->car($self->env->symbol->{"QUOTE"});
  $list->cdr(Moosp::List->new);
  $list = $list->cdr;
#  $self->get_char();
  $list->car($self->getSexp());
  return $top;
}

1; # End of Moosp::Reader
