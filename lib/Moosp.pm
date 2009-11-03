package Moosp;

use Moose;
use Moosp::Env;
use Moosp::Eval;
use Moosp::Reader;
use Term::ReadLine;
use Moosp::Function::Add;
use Moosp::Function::Car;
use Moosp::Function::Quote;
use Moosp::Function::Setq;

=head1 NAME

Moosp - lisp for Moose

=head1 VERSION

Version 0.01

=cut

our $VERSION = 0.01;

has 'env'    => (is => 'rw', isa => 'Moosp::Env', required => 1, default => sub { Moosp::Env->new });
has 'eval'   => (is => 'rw', isa => 'Moosp::Eval',   lazy => 1, required => 1, builder => 'build_eval');
has 'reader' => (is => 'rw', isa => 'Moosp::Reader', lazy => 1, required => 1, builder => 'build_reader');

=head2 build_eval

=cut

sub build_eval {
  my $self = shift;
  Moosp::Eval->new(env => $self->env);
}

=head2 build_reader

=cut

sub build_reader {
  my $self = shift;
  Moosp::Reader->new(env => $self->env);
}

=head2 run

run repl

=cut

sub run {
  my $self = shift;

  Moosp::Function::Add->new(env => $self->env, eval => $self->eval)->regist('+');
  Moosp::Function::Car->new(env => $self->env, eval => $self->eval)->regist('CAR');
  Moosp::Function::Quote->new(env => $self->env, eval => $self->eval)->regist('QUOTE');
  Moosp::Function::Setq->new(env => $self->env, eval => $self->eval)->regist('SETQ');

  my $term = new Term::ReadLine 'Simple LISP REPL';
  my $prompt = "Moosp> ";
  my $OUT = $term->OUT || \*STDOUT;

  while ( defined ($_ = $term->readline($prompt)) ) {
    my $sexp = $self->reader->readFromString($_);
    $sexp = $self->eval->eval($sexp);
#    $self->env->dump;
    warn $@ if $@;
    print $OUT $sexp->serialize(), "\n" unless $@;
  }

}

__PACKAGE__->meta->make_immutable;

no Moose;


1; # End of Moosp
