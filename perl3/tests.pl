#!/usr/bin/perl
use strict;
use warnings;

# 
# #2
# -l symbolic link 
# -d is a directory 
# -s the size 
#

my $candidate = shift; 

if (-l $candidate){print "$candidate is a link\n";} else {print "$candidate not a link\n";}
if (-d $candidate){print "$candidate is a directory\n";} else  {print "$candidate not a directory\n";}
my $size = -s $candidate;
if (-s $candidate){print "$candidate size is " . $size . "\n";} else {print "$candidate no size\n";}




 