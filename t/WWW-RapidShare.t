#!/usr/bin/perl
use strict; use warnings;

use lib 'lib';

use Test::More tests => 5;
#use Test::More qw/ no_plan /;

my $module = 'WWW::RapidShare';

use_ok($module) or die;

my $obj = $module->new;
isa_ok($obj, $module);

$obj->url('http://rapidshare.com/file');
ok ($obj->url eq 'http://rapidshare.com/file', 'url() accessor');

$obj->account_id('100234787');
ok ($obj->account_id eq '100234787', 'account_id() accessor');

$obj->password('89ghaskj');
ok ($obj->password eq '89ghaskj', 'password() accessor');

