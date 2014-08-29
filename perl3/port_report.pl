#!/usr/bin/perl
use strict;
use warnings;

# Sample output from netstat -an 
# tcp        0      0 0.0.0.0:875                 0.0.0.0:*                   LISTEN                                                       
# tcp        0      0 0.0.0.0:111                 0.0.0.0:*                   LISTEN                                                       
# tcp        0      0 127.0.0.1:52688             0.0.0.0:*                   LISTEN

open my $fh, '-|', "netstat -an" or die "Can't open pipe: $!\n";
my %unique_ports;
while (<$fh>)
{
	next unless m!LISTEN!;
	
	if
	(
		m!0.0.0.0:(\d+).*LISTEN! ||
		m!127.0.0.1:(\d+).*LISTEN!
	)
	{
		print "Local machine listening on unique port - $1\n" unless $unique_ports{$1}++;
	}
}