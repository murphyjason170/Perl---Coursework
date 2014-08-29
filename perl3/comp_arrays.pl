#!/usr/bin/perl
use strict;
use warnings;
################################################################
#
# 
# Course: 	Perl III
# Objective:    Lab 7, Objective 1 	
# Student:	Jason Murphy
# Instructor:	Ben Hengst
#
####################################################################


####################################################################
#       Sample Table:
#
#	@first			@second			Result
#	Wallace, Gromit		Wallace Gromit Shawn	False
#	3,4,5			5,4,3			False
#	()			()			True
#	Kirk, Spock, McCoy	Kirk, Spock		False
#	1,2,3			'1', '2', '3'		True
####################################################################

# Arrays @first and @second are defined and initialized
my @first = (1,2,3);
my @second = ('1', '2', '3');

# Reference variables created and assign the arrays 
my $first_reference = \@first;
my $second_reference = \@second;

# Call the compareTwoArrays function - pass it the references
print compareTwoArrays($first_reference, $second_reference);
print "\n";

sub compareTwoArrays
{
	my $counter = 0;

	# Plug in the references to local references
	my ($first_ref, $second_ref) = @_;
	
	# Compare the number of elements in each array
	# if not of the same length then return false
	if ( @$first_ref ne @$second_ref)
	{
	 	# deal-breaker, not a match!
		return 'false';  
	}

	# Step through each elements and compare the literal value
	else
	{
		# Here determine the number of elements in the array
		my $number_of_elements = @$first_ref;
		
		while ($counter < $number_of_elements)
		{
			# Here is the de-referenced literal comparison
			if ($$first_ref[$counter] ne $$second_ref[$counter])
			{
				#deal-breaker, not a match!
				return 'false'; 
			}

			$counter++;
		}
		
		# Cleared the hurdles
		return 'true';	
	}
}
