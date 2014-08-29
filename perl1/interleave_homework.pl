#!/usr/bin/perl
use strict;
use warnings;
 	 
my @first = qw(Can unlock secret);
my @second = qw(you the code?);
 
my @mixed = interleave_words( scalar(@first), @first, @second );
 
print "Result: @mixed\n";

sub interleave_words
{ 
	my $array_length = shift @_ ; 		
	my @results;
 	my @array1 = splice( @_ , 0, $array_length);
	my @array2 = splice (@_, 0, $array_length);
	
	if ( @array1 != @array2 )
	{
		die "We need both arrays to be the same length!\n";
	}
		
	my $index = 0;
	   
	while ( $index < $array_length * 2 ) 
	{   		
		$results[ $index++ ] = shift @array1;
		$results[ $index ] = shift @array2;
		$index++;				
 	}  		
	return @results;
} # end sub

 
	