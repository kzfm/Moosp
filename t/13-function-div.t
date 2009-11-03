#!perl -T

use Test::More qw/no_plan/;
use Moosp::Function::Div;
use Moosp::List;
use Moosp::Integer;
use Moosp::Eval;
use Moosp::Env;

BEGIN {
	use_ok( 'Moosp::Function::Div' );
}

my $eval = Moosp::Eval->new();
my $env = Moosp::Env->new();

my $fun = Moosp::Function::Div->new(eval => $eval, env => $env);
isa_ok($fun,'Moosp::Function::Div','Moosp Funtion::Div');

can_ok($fun, 'serialize');
is($fun->serialize, '<SystemFunction: Moosp::Function::Div>', "serialize ok");

{
  my $int1 = Moosp::Integer->new(value=> 5);
  my $int2 = Moosp::Integer->new(value=> 2);
  
  my $list = Moosp::List->new();
  $list->car($int1);
  my $list2 = Moosp::List->new();
  $list2->car($int2);
  $list->cdr($list2);
  is($list->serialize, '(5 2)', 'list');
  is($fun->fun($list)->serialize, '2', 'int 2');
}
