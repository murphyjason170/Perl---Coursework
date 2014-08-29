#!/usr/bin/perl
use strict;
use warnings;
 	
my @first = qw(Can unlock secret);
my @second = qw(you the code?);

# Good start! It doesn't seem the program has become "both shorter and faster". You have a lot of the pieces, 
# but just make it so that it has the original calling structure: 
# interleave_words( scalar(@first), @first, @second ); 
# and that it's *shorter* than the original interleave.pl. You have the use of splice() solidly in place: 
# my @array1 = splice( @_ , 0, $count1); 
# But don't use extra variables or two while loops. You should be able to shorten the original interleave.pl. by using one foreach loop (or if you still prefer, a while loop). Message me if you have further questions and I look forward to the next submission! :-) 

  
my @mixed = interleave_words( scalar(@first), @first, @second );
# my @mixed = interleave_words( scalar(@first), scalar(@second), @first, @second );

print "Result: @mixed\n";


sub interleave_words
{ 
	my @results;
 	
 	my @array1 = splice( @_ , 0;
	my @array2 = splice (@_, 0);
 	
	my $index = 0;		
	my $skip = 0;
	my $skip2 = 1;

	while ( @array1 ) 
	{   		
		$results[ $skip ] = shift @array1;		 	
		$results[ $skip2 ] = shift @array2;
	 	$skip = $skip + 2;	
  	 	$skip2 = $skip2 + 2;	
	}  		
	return @results;
} # end sub

 
	