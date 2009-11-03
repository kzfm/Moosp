#!perl -T

use Test::More qw/no_plan/;

BEGIN {
	use_ok( 'Moosp::Integer' );
}

my $i = Moosp::Integer->new({value => 5});

is($i->serialize, "5", "serialize");

my $j = Moosp::Integer->new({value => 10});

is($i->add($j)->serialize, "15", "add 5 + 10");
is($i->subt($j)->serialize, "-5", "subt 5 - 10");
is($i->mul($j)->serialize, "50", "mul 5 * 10");
is($i->div($j)->serialize, "0", "div 5 / 10");

can_ok($i,'print');
