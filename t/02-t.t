#!perl -T

use Test::More qw/no_plan/;

BEGIN {
	use_ok( 'Moosp::T' );
}

#diag( "Testing Moosp $Moosp::T::VERSION, Perl $], $^X" );

my $nil = Moosp::T->new();

is($nil->serialize(), "T", "serialize nil");

can_ok($nil,'print');
