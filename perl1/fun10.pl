#!/usr/bin/perl
use strict;
use warnings;
# 3

# my ( %count, %cost );

# $count{'guitars'}	= 5;
# $count{'drums'}	= 6;

# $cost{'guitars'}	= 200;
# $cost{'drums'}	= 300;

# my $instrument = 'guitars';

# print "The math on $instrument is ", $count{$instrument} * $cost{$instrument}, "\n";

my %sold;
$sold{'drums'}	= 1;
$sold{'guitars'} = 2;
$sold{'bass'} = 3;

foreach my $hash_key ( keys %sold )
{
   print "$hash_key \n";
   
   if ($hash_key eq 'drums') 
   {
   	print "$hash_key matches the string drums \n";
   }
}


