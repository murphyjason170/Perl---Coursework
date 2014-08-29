#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use Business::ISBN;

print Business::ISBN->new('0201795264')->as_string, "\n";


