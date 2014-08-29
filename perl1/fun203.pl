#!/usr/bin/perl
use strict;
use warnings;

# my @my_array = qw ( 'Alpha' 10 'Beta' 20 'Charlie' 30 );

my %hash = @ARGV;

# my %hash = ( 'Alpha' => 10, 'Beta' => 20, 'Charlie' => 30 );

 
foreach my $my_key ( keys %hash )
{
	print $my_key;
}


