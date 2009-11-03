#!perl -T

use Test::More qw/no_plan/;
use Moosp::Function::Sub;
use Moosp::List;
use Moosp::Integer;
use Moosp::Eval;
use Moosp::Env;

BEGIN {
	use_ok( 'Moosp::Function::Sub' );
}

my $eval = Moosp::Eval->new();
my $env = Moosp::Env->new();

my $fun = Moosp::Function::Sub->new(eval => $eval, env => $env);
isa_ok($fun,'Moosp::Function::Sub','Moosp Funtion::Sub');

can_ok($fun, 'serialize');
is($fun->serialize, '<SystemFunction: Moosp::Function::Sub>', "serialize ok");

{
  my $int1 = Moosp::Integer->new(value=> 5);
  my $int2 = Moosp::Integer->new(value=> 2);
  
  my $list = Moosp::List->new();
  $list->car($int1);
  my $list2 = Moosp::List->new();
  $list2->car($int2);
  $list->cdr($list2);
  is($list->serialize, '(5 2)', 'list');
  is($fun->fun($list)->serialize, '3', 'int 3');
}
