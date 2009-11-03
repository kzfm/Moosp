#!perl -T

use Test::More qw/no_plan/;
use Moosp::List;
use Moosp::Integer;
use Moosp::Symbol;
use Moosp::Env;
use Moosp::Nil;

BEGIN {
	use_ok( 'Moosp::List' );
}

my $nil = Moosp::Nil->instance;

my $list = Moosp::List->new($nil, $nil);
isa_ok($list,'Moosp::List','Moosp List');

can_ok($list,'car');
can_ok($list,'cdr');

isa_ok($list->car,'Moosp::Nil','Moosp List car');
isa_ok($list->cdr,'Moosp::Nil','Moosp List cdr');

my $int3 = Moosp::Integer->new(value => 3);
my $int5 = Moosp::Integer->new(value => 5);
$list->car($int3);
$list->cdr($int5);

isa_ok($list->car,'Moosp::Integer','Moosp List car');
isa_ok($list->cdr,'Moosp::Integer','Moosp List cdr');
is($list->car->value,3, 'Moosp List car value is 3');
is($list->cdr->value,5, 'Moosp List cdr value is 5');
is($list->serialize,'(3 . 5)',"Moosp serialize");

my $list2 = Moosp::List->new();
$list2->car($int3);
$list2->cdr($list);

isa_ok($list2->car,'Moosp::Integer','Moosp List car');
isa_ok($list2->cdr,'Moosp::List','Moosp List cdr');
is($list2->car->value,3, 'car value is 3');
is($list2->cdr->car->value,3, 'cadr value is 3');
is($list2->cdr->car->value,3, 'cddr value is 5');

#TODO:{
#is($list2->serialize,'(3 (3 . 5))',"Moosp serialize");
#}

my $list3 = Moosp::List->new();
$list3->car($int3);

is($list3->serialize,'(3)',"serialize (3)");

{
  my $list1 = Moosp::List->new();
  my $list2 = Moosp::List->new();
  my $list3 = Moosp::List->new();
  my $list4 = Moosp::List->new();
  $list1->car($int3);
  $list2->car($int3);
  $list3->car($int3);
  $list4->car($int3);
  $list1->cdr($list2);
  $list2->cdr($list3);
  $list3->cdr($list4);
  is($list1->serialize,'(3 3 3 3)',"serialize (3 3 3 3)");
}
