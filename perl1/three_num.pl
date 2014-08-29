#!/usr/bin/perl
use strict;
use warnings;

 
print add_three_numbers( 12, 592, 2928 );
print add_three_numbers( 9, 2, 4, 5, 10 );

sub add_three_numbers
{
	# make sure exactly three params are passed to the subroutine
	# otherwise die if there are not 3 params passed
	
	# add up the number
	if ( @_ == 3 )
	{
	my ($number_1, $number_2, $number_3) = @_ ;		
	my $total_of_three_numbers = $number_1 + $number_2 + $number_3;
	return $total_of_three_numbers; 	
	}
	else
	{
		die "The add_three_numbers function requires exactly 3 arguments. Thank you!\n";
	}	
}
