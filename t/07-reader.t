#!perl -T

use Test::More qw/no_plan/;
use Moosp::Reader;

BEGIN {
	use_ok( 'Moosp::Reader' );
}

{
my $reader = Moosp::Reader->new();
isa_ok($reader,'Moosp::Reader','Moosp Reader');

can_ok($reader,'readFromString');

my $nil = $reader->readFromString(" ");
isa_ok($nil,'Moosp::Nil','Nil');
}

{
my $reader = Moosp::Reader->new();
my $int = $reader->readFromString("3");
isa_ok($int,'Moosp::Integer','Integer');
is($int->serialize, '3', 'Integer 3');
}

{
my $reader = Moosp::Reader->new();
my $int = $reader->readFromString("12345");
isa_ok($int,'Moosp::Integer','Integer');
is($int->serialize, '12345', 'Integer 12345');
}

{
my $reader = Moosp::Reader->new();
my $int = $reader->readFromString("-5");
isa_ok($int,'Moosp::Integer','Integer');
is($int->serialize, '-5', 'Integer -5');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString("NIL");
isa_ok($str,'Moosp::Nil','Symbol Nil');
is($str->serialize, 'NIL', 'NIL');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString("nil");
isa_ok($str,'Moosp::Nil','Symbol Nil');
is($str->serialize, 'NIL', 'NIL');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString("T");
isa_ok($str,'Moosp::T','Symbol');
is($str->serialize, 'T', 'T');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString("abc");
isa_ok($str,'Moosp::Symbol','Symbol');
is($str->serialize, 'ABC', 'Symbol ABC');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString("-123a");
isa_ok($str,'Moosp::Symbol','Symbol');
is($str->serialize, '-123A', 'Symbol -123A');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString("123a");
isa_ok($str,'Moosp::Symbol','Symbol');
is($str->serialize, '123A', 'Symbol 123A');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString('(1 2 3a)');
isa_ok($str,'Moosp::List','List');
is($str->serialize, '(1 2 3A)', 'List (1 2 3A)');
isa_ok($str->car,'Moosp::Integer','Integer');
isa_ok($str->cdr->car,'Moosp::Integer','Integer');
isa_ok($str->cdr->cdr->car,'Moosp::Symbol','Symbol');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString('(1 . 3)');
isa_ok($str,'Moosp::List','List');
is($str->serialize, '(1 . 3)', 'List (1 . 3)');
isa_ok($str->car,'Moosp::Integer','Integer');
isa_ok($str->cdr,'Moosp::Integer','Integer');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString('()');
isa_ok($str,'Moosp::Nil','Nil');
is($str->serialize, 'NIL', 'List () NIL');
}

{
my $reader = Moosp::Reader->new();
my $str = $reader->readFromString('(lambda () (+ 3 5))');
isa_ok($str,'Moosp::List','List');
is($str->serialize, '(LAMBDA NIL (+ 3 5))', 'lambda');

}


###
#can_ok($reader,'read');

