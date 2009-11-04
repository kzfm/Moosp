#!perl -T

use Test::More qw/no_plan/;
use Moosp::Function::Ge;
use Moosp::List;
use Moosp::Integer;
use Moosp;
use Moosp::Eval;
use Moosp::Env;

BEGIN {
	use_ok( 'Moosp::Function::Ge' );
}

my $moosp = Moosp->new();
Moosp::Function::Add->new(env => $moosp->env, eval => $moosp->eval)->regist('+');
Moosp::Function::Ge->new(env => $moosp->env, eval => $moosp->eval)->regist('>=');

my $eval = Moosp::Eval->new();
my $env = Moosp::Env->new();
my $fun = Moosp::Function::Ge->new(eval => $eval, env => $env);
isa_ok($fun,'Moosp::Function::Ge','Moosp Funtion::Ge');

can_ok($fun, 'serialize');
is($fun->serialize, '<SystemFunction: Moosp::Function::Ge>', "serialize ok");

{
  my $sexp = $moosp->reader->readFromString("(>= 3 5)");
  is($sexp->serialize, '(>= 3 5)', "serialize ok");
  is($fun->fun($sexp->cdr)->serialize, 'NIL', '>= 3 5 NIL');
}

{
  my $sexp = $moosp->reader->readFromString("(>= 7 1)");
  is($sexp->serialize, '(>= 7 1)', "serialize ok");
  is($fun->fun($sexp->cdr)->serialize, 'T', '>= 7 1 True');
}

