#!/usr/bin/perl

use strict;
use warnings;

my @names;
my $first_name;
my $middle_name;
my $last_name;


my $name = "Charles Francis Xavier";
&sanitizer;

$name = "Hiram K. Hackenbacker";
&sanitizer;

$name = "James Moriarty";
&sanitizer;

$name = "Samuel Finley Breese Morse";
&sanitizer;

 

##################################
# 
# The Sanitizer Function - scrub the data so that "first_name middle_initial last_name"

sub  sanitizer {
 
@names = split ' ', $name;
my $first_name = shift @names;
my $last_name = pop @names;

 
# This is all the middle name logic:
my $arraySize = @names;
$arraySize = scalar (@names);
$arraySize = $#names + 1;

if ( $arraySize != 0 )
{
	$middle_name = shift @names;
	$middle_name = substr($middle_name, 0, 1) . '.';
}
else
{	
	$middle_name = 'X';
}

# The Output
print "$first_name $middle_name $last_name\n";
}
##################################
