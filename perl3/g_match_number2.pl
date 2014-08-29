#!/usr/bin/perl
use strict;
use warnings;

my $_ = "01/30/10 17:30:21 trish.oreilly.com ENABLE /perl1 & 02/01/10 09:10:00 tim.oreilly.com ENROLL /perl1";

while (m!([\d/]+)\s+([\d:]+)[^/]*/(\S*)!g )
{
	my ($date, $time, $course) = ($1, $2, $3);
	print "Date: $date; time: $time; course: $course\n";
}

 