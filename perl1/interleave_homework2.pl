#!/usr/bin/perl
use strict;
use warnings;
 	
my @first = qw(Can unlock secret);
my @second = qw(you the code?);

#  my @first = qw(We you merry we you merry);
#  my @second = qw(wish a christmas wish a christmas);
  
my @mixed = interleave_words( scalar(@first), scalar(@second), @first, @second );
print "Result: @mixed\n";


sub interleave_words
{ 
	my @results;
	
	###############################################################
	# Sum up the total number of indexes being passed:
	my $count1 = shift @_ ; 
	my $count2 = shift @_ ;
	my $total_count = $count1 + $count2;
	
	if ( $count1 != $count2 ) {
		die "Both arrays must be of the same length!\n";
	}
	else
	{
		print "Both array lengths are the same\n";
	}
	
	my $count = $count1 + $count2 - 1;
	print "Count is currently $count\n";

	###############################################################3

	
	my @array1 = splice( @_ , 0, $count1);
 	
	my $index = 0;		
	my $skip = 0;

	while ( @array1 ) 
	{   		
		$results[ $skip ] = shift @array1;		 	
	 	$skip = $skip + 2;	
	}
	
	my $skip2 = 1;
	
	my @array2 = splice (@_, 0, $count2);
	while ( @array2 ) 
	{
		$results[ $skip2 ] = shift @array2;
  	 	$skip2 = $skip2 + 2;	
	}
 		
	return @results;

}	# end subroutine	

 
	