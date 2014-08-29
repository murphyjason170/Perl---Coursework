#!/usr/bin/perl
use strict;
use warnings;

######################################################################
# 
# Course:		Perl III
# 			Lesson 4 - Objective 1
# Date:			3/5/2014
# Student:		Jason Murphy
# Instructor:		Ben Hengst
#
######################################################################

######################################################################
#
# Variable and Array Declarations
#
my @line_array;				# Stores all values after delimited on space and commas
my @money_array;			# Stores all valid money values
my $total_amount_of_money = 0;		# Keeps track of money total

######################################################################
#
# This section reads in and prints everything properly
#
while ( <> )
{ 
	# foreach line
	foreach ($_)
	{
		chomp($_);
		
		# Do REGEXing and substitution to print out money with a dollar sign and the value
		s/\$?(\d+\.\d\d) /\$$1 /g;
		
		# Print out the newly substituted line
		print "$_\n";
		
		# For each line split into tokens with delimiters of commas or spaces
		@line_array = split(/, /, $_);
	}

	# Push candidates from @line_array onto the @money_array
	foreach (@line_array)
	{
		push(@money_array, $1) if (m!(\d\d\d\d\.\d\d)! || m!(\d\d\d\.\d\d)! || m!(\d\d\.\d\d)! || m!\$(\d\d\d) !);
	}			
}  


# Loop through the @money_array and add each scalar to the $total_amount_of_money
foreach my $number (@money_array)
{
	$total_amount_of_money = $total_amount_of_money + $number;
}	
	
# Print out the total amount:
print "\nTotal = \$$total_amount_of_money\n";
#
#
######################################################################
