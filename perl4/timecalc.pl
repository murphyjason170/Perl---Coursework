#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";
use DateTime;

my $dt = DateTime->now;
$dt->add( years => 1, months => 2, days => 3, hours => 4, minutes => 5 );
print "1 year, 2 months, 3 days, 4 hours, and 5 minutes from now = $d\n";
my $difference = $dt - DateTime->now;
print "Difference = $difference\n";

