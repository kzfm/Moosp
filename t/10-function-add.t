#!perl -T

use Test::More qw/no_plan/;
use Moosp::Function::Add;
use Moosp::List;
use Moosp::Integer;
use Moosp::Eval;
use Moosp::Env;

BEGIN {
	use_ok( 'Moosp::Function::Add' );
}

my $eval = Moosp::Eval->new();
my $env = Moosp::Env->new();

my $fun = Moosp::Function::Add->new(eval => $eval, env => $env);
isa_ok($fun,'Moosp::Function::Add','Moosp Funtion::Add');

can_ok($fun, 'serialize');
is($fun->serialize, '<SystemFunction: Moosp::Function::Add>', "serialize ok");

{
  my $int1 = Moosp::Integer->new(value=> 3);
  my $int2 = Moosp::Integer->new(value=> 5);
  
  my $list = Moosp::List->new();
  $list->car($int1);
  my $list2 = Moosp::List->new();
  $list2->car($int2);
  $list->cdr($list2);
  
  is($fun->fun($list)->serialize, '8', 'int 8');
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

  
  is($fun->fun($list)->serialize, '10', 'int 10');
}
