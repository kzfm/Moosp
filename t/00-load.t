#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Moosp' );
}

diag( "Testing Moosp $Moosp::VERSION, Perl $], $^X" );
