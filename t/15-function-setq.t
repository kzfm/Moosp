#!perl -T

use Test::More qw/no_plan/;
use Moosp::Function::Setq;
use Moosp::Function::Add;
use Moosp::List;
use Moosp::Integer;
use Moosp;
use Moosp::T;
use Moosp::Nil;
use Moosp::Eval;
use Moosp::Env;
BEGIN {
	use_ok( 'Moosp::Function::Setq' );
}

my $moosp = Moosp->new();
Moosp::Function::Add->new(env => $moosp->env, eval => $moosp->eval)->regist('+');
Moosp::Function::Setq->new(env => $moosp->env, eval => $moosp->eval)->regist('SETQ');

my $eval = Moosp::Eval->new();
my $env = Moosp::Env->new();
my $fun = Moosp::Function::Setq->new(eval => $eval, env => $env);
isa_ok($fun,'Moosp::Function::Setq','Moosp Funtion::Setq');

can_ok($fun, 'serialize');
is($fun->serialize, '<SystemFunction: Moosp::Function::Setq>', "serialize ok");

{
  my $sexp = $moosp->reader->readFromString("(setq a 5)");
  is($sexp->serialize, '(SETQ A 5)', "serialize ok");
  is($fun->fun($sexp->cdr)->serialize, '5', 'setq a 5');
}

{
  my $sexp = $moosp->reader->readFromString("(setq b (+ 3 5))");
  is($sexp->serialize, '(SETQ B (+ 3 5))', "serialize ok");
  is($moosp->eval->eval($sexp)->serialize, '8', "setq b 8");
}

#    $sexp = $self->eval->eval($sexp);
