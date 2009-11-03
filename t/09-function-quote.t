#!perl -T

use Test::More qw/no_plan/;
use Moosp::Function::Quote;
use Moosp::List;
use Moosp::Integer;
use Moosp::Eval;
use Moosp::Env;

BEGIN {
	use_ok( 'Moosp::Function::Quote' );
}

my $eval = Moosp::Eval->new();
my $env = Moosp::Env->new();
my $fun = Moosp::Function::Quote->new(eval => $eval, env => $env);

isa_ok($fun,'Moosp::Function::Quote','Moosp Funtion::Quote');

can_ok($fun, 'serialize');
is($fun->serialize, '<SystemFunction: Moosp::Function::Quote>', "serialize ok");

my $int1 = Moosp::Integer->new(value=> 3);
my $int2 = Moosp::Integer->new(value=> 5);

my $list = Moosp::List->new();
$list->car($int1);
my $list2 = Moosp::List->new();
$list2->car($int2);
$list->cdr($list2);

is($list->car->value,3, 'Moosp List car value is 3');
is($list->serialize , '(3 5)', '(3 5)');

is($fun->fun($list)->serialize, '(3 5)', 'quote (3 5)');
