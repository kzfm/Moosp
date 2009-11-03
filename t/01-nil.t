#!perl -T

use Test::More qw/no_plan/;

BEGIN {
	use_ok( 'Moosp::Nil' );
}

my $nil = Moosp::Nil->new();

is($nil->serialize(), "NIL", "serialize nil");

can_ok($nil,'print');
