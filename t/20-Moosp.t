#!perl -T

use Test::More qw/no_plan/;
use Moosp;

BEGIN {
	use_ok( 'Moosp' );
}

my $moosp = Moosp->new();

isa_ok($moosp,'Moosp','Moosp');

can_ok($moosp, 'run');
