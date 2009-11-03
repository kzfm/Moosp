#!perl -T

use Test::More qw/no_plan/;
use Moosp::Function::Mul;
use Moosp::List;
use Moosp::Integer;
use Moosp::Eval;
use Moosp::Env;

BEGIN {
	use_ok( 'Moosp::Function::Mul' );
}

my $eval = Moosp::Eval->new();
my $env = Moosp::Env->new();

my $fun = Moosp::Function::Mul->new(eval => $eval, env => $env);
isa_ok($fun,'Moosp::Function::Mul','Moosp Funtion::Mul');

can_ok($fun, 'serialize');
is($fun->serialize, '<SystemFunction: Moosp::Function::Mul>', "serialize ok");

{
  my $int1 = Moosp::Integer->new(value=> 3);
  my $int2 = Moosp::Integer->new(value=> 5);
  
  my $list = Moosp::List->new();
  $list->car($int1);
  my $list2 = Moosp::List->new();
  $list2->car($int2);
  $list->cdr($list2);
  
  is($fun->fun($list)->serialize, '15', 'int 15');
}

{
  my $int1 = Moosp::Integer->new(value=> 3);
  my $int2 = Moosp::Integer->new(value=> 5);
  my $int3 = Moosp::Integer->new(value=> 2);
  
  my $list = Moosp::List->new();
  $list->car($int1);
  my $list2 = Moosp::List->new();
  $list2->car($int2);
  $list->cdr($list2);
  my $list3 = Moosp::List->new();
  $list3->car($int3);
  $list2->cdr($list3);

  
  is($fun->fun($list)->serialize, '30', 'int 30');
}
