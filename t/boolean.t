#!/usr/bin/perl

use 5.14.0;
use strict;
use warnings FATAL => 'all';
use Test::More tests => 12;

use Attribute::Boolean;
use JSON;

require_ok('Attribute::Boolean');

my $bool : Boolean;

is($bool, 'false', 'stringifies as false');
ok($bool == 0, 'has value of zero');

$bool = 123;
ok($bool != 123, "doesn't keep its assigned value");
ok($bool == 1, 'has value of one');
is($bool, 'true', 'stringifies as true');

eval { $bool++; };
like($@, qr/not possible/, 'addition check');
eval { my $a = $bool - 1 };
like($@, qr/not possible/, 'subtraction check');

ok(true eq 'true', 'check true');
ok(false eq 'false', 'check false');

$bool = true;
$bool = not $bool;
is($bool, 'false', "not works");

my $json = new JSON;
$json->convert_blessed;
my $b : Boolean;
my %hash = (
    value => $b,
    me    => true,
);
is($json->encode(\%hash), '{"value":false,"me":true}', 'Check JSON');
