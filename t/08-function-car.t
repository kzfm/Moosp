#!perl -T

use Test::More qw/no_plan/;
use Moosp::Function::Car;
use Moosp::List;
use Moosp::Integer;
use Moosp::Eval;
use Moosp::Env;

BEGIN {
	use_ok( 'Moosp::Function::Car' );
}

my $eval = Moosp::Eval->new();
my $env = Moosp::Env->new();
my $fun = Moosp::Function::Car->new(eval => $eval, env => $env);

isa_ok($fun,'Moosp::Function::Car','Moosp Funtion::Car');

can_ok($fun, 'serialize');
is($fun->serialize, '<SystemFunction: Moosp::Function::Car>', "serialize ok");

my $int1 = Moosp::Integer->new(value=> 3);
my $int2 = Moosp::Integer->new(value=> 5);

my $list = Moosp::List->new();

$list->car($int1);
is($list->car->value,3, 'Moosp List car value is 3');
is($list->serialize , '(3)', '(3)');

is($fun->fun($list)->serialize, '3', 'Car is a 3');
