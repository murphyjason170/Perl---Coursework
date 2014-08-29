#!/usr/bin/perl
use strict;
use warnings;

$| = 1;
my @spinner = qw!- \ | /!;
 
for ( 1 .. 100 )
{
	long_operation( $_ );
 	spin_city();
}

sub long_operation
{
	my $arg = shift;
	print "Processing element $arg\n" unless $arg % 15;
	sleep 1;
}
 
sub spin_city
{
 	print "$spinner[$_ % 4]\r"; 
}

