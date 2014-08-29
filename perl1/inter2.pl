#!/usr/bin/perl
# 1
use strict;
use warnings;

  	
my @first = qw(Can unlock secret);
my @second = qw(you the code?);

# my @first = qw(On first of my love to);
# my @second = qw(the day Christmas true said me);

my @mixed = interleave_words( scalar(@first), scalar(@second), @first, @second );
print "Result: @mixed\n";


sub interleave_words
{ 
	my @results;

	# Sum up the total number of indexes being passed:
	my $count1 = shift @_ ; 
	my $count2 = shift @_ ;
	
	if ( $count1 != $count2 ) {
		die "Both arrays must be of the same length!\n";
	}
	else
	{
		print "Both array lengths are the same\n";
	}
	
	my $count = $count1 + $count2 - 1;
	print "Count is currently $count\n";
	
		
	while ( @_ )
	{
	
	my $counter1 = 0;
	
	while ( $counter1 <= $count) 
	{
		if ( $counter1 % 2 == 0 )
 		{	
			$results[ $counter1 ] = 	splice(@first, 0, 1);
 		}	
		else
		{
 			$results[ $counter1 ] = 	splice(@second, 0, 1);
 		} 
 
 		$counter1++;
	}	# end while

	 	
	return @results;
}	# end subroutine	

}	# end this program

	