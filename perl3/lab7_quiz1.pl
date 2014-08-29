#!/usr/bin/perl
use strict;
use warnings;

my @squares = map { $_**2 } 1..10; 
# my @squares = map { $_ } 1..10; 

print "Prior to function call: @squares\n\n";

foo(@squares);

print "After function call: @squares\n\n";
   
sub foo 
{ 
	my @a_ref = @_; 
	print "\@a_ref is: @a_ref\n";
	
	# $_/=2 and print for @$a_ref;
	$_/=2 and print for @a_ref;
	print "\n";
}



