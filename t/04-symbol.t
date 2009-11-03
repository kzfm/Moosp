#!perl -T

use Test::More qw/no_plan/;
use Moosp::Nil;
use Moosp::Integer;

BEGIN {
	use_ok( 'Moosp::Symbol' );
}


my $symbol = Moosp::Symbol->new({name => "tsymbol"});
is($symbol->serialize(), "tsymbol", "serialize symbol");
can_ok($symbol,'print');
is($symbol->value, undef, "default value of symbol");

my $nil = $symbol->value(Moosp::Nil->new);
isa_ok($symbol->value, 'Moosp::Nil', "set symbol");

my $int = $symbol->value(Moosp::Integer->new(value => 3));
isa_ok($symbol->value, 'Moosp::Integer', "set symbol");
