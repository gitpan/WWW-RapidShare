#!/usr/bin/perl
use strict; use warnings;
$|++;

use WWW::RapidShare;

my $url = shift or die "specify url";

my $rapid = WWW::RapidShare->new();

$rapid->url($url);
$rapid->account_id('xxx');
$rapid->password('xxx');
$rapid->download_file;

