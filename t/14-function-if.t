#!perl -T

use Test::More qw/no_plan/;
use Moosp::Function::If;
use Moosp::List;
use Moosp::Integer;
use Moosp::Eval;
use Moosp::Env;
use Moosp::T;
use Moosp::Nil;

BEGIN {
	use_ok( 'Moosp::Function::If' );
}

my $eval = Moosp::Eval->new();
my $env = Moosp::Env->new();

my $fun = Moosp::Function::If->new(eval => $eval, env => $env);
isa_ok($fun,'Moosp::Function::If','Moosp Funtion::If');

can_ok($fun, 'serialize');
is($fun->serialize, '<SystemFunction: Moosp::Function::If>', "serialize ok");

{
  my $int1 = Moosp::Integer->new(value=> 3);
  my $int2 = Moosp::Integer->new(value=> 5);
  my $t    = Moosp::T->new();

  my $list1 = Moosp::List->new();
  $list1->car($t);
  my $list2 = Moosp::List->new();
  $list2->car($int1);
  my $list3 = Moosp::List->new();
  $list3->car($int2);

  $list2->cdr($list3);
  $list1->cdr($list2);

  is($fun->fun($list1)->serialize, '3', 'int 3');
}

{
  my $int1 = Moosp::Integer->new(value=> 3);
  my $int2 = Moosp::Integer->new(value=> 5);
  my $nil    = Moosp::Nil->new();

  my $list1 = Moosp::List->new();
  $list1->car($nil);
  my $list2 = Moosp::List->new();
  $list2->car($int1);
  my $list3 = Moosp::List->new();
  $list3->car($int2);

  $list2->cdr($list3);
  $list1->cdr($list2);

  is($fun->fun($list1)->serialize, '5', 'int 5');
}

