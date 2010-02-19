#!/usr/bin/perl
use strict; use warnings;
$|++;

use WWW::RapidShare;

my $url = 'http://rapidshare.com/files/some_file.rar';

my $rapid = WWW::RapidShare->new();

$rapid->url($url);
$rapid->account_id('xxx');
$rapid->password('xxx');
$rapid->download_file;

