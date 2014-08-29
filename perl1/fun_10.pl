#!/usr/bin/perl
use strict;
use warnings;

my $count = 0;

foreach my $argument ( @ARGV )
{
if ( index ($argument, "-") == 0 )
{
print "An argument $argument has been passed at the command line\n";
}
else
{
print "$argument is not an argument\n";
} 
}

