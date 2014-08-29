#!/usr/bin/perl
use strict;
use warnings;

# Look at perldoc -f caller. 
# Create a program in your /p3homework folder named whocalled.pl 
# including a subroutine that can tell whether or not it is being called 
# from an eval at any higher level. 

in_eval(); 				# Prints 'No'
eval { in_eval() }; 			# Prints 'Yes'

eval { foo() }; 
sub foo { in_eval() } 			# Prints 'Yes'


# 0 - $package      1 - $filename       2 - $line   
# 3 - $subroutine   4 -	$hasargs	5 - $wantarray
# 6 - $evaltext     7 - $is_require     8 - $hints
# 9 - $bitmask     10 - $hinthash

sub in_eval
{
	# $eval_flag will increment every time it hits code that equals 'eval'
	my $eval_flag = 0;
  	my $advancer = 0;
	
	my @caller_info_array;
	while (@caller_info_array = caller($advancer++)) 
	{
		# We've got a match!
      		if ($caller_info_array[3] eq '(eval)') 
      		{
        		$eval_flag++;
      		}      		
   	 }

	if ($eval_flag > 0)
	{
		print "Yes\n";
	}
	else
	{
		print "No\n";
	}
}



	# print "----------------------------\n";
	# print "In in_eval sub-routine:\n";
	# print "Package is:\t" . caller(0) . "\n" if (caller(0));
	# print "Filename is:\t" . (caller(0))[1] . "\n" if (caller(0))[1];
	# print "Line is:\t" . (caller(0))[2] . "\n" if (caller(0))[2];
	# print "Subroutine is:\t" . (caller(0))[3] . "\n" if (caller(0))[3];
	# print "hasargs is: \t" . (caller(0))[4] . "\n" if (caller(0))[4];
	# print "wantarray is:\t" . (caller(0))[5] . "\n" if (caller(0))[5];
	# print "evaltext:\t" . (caller(0))[6] . "\n" if (caller(0))[6];
	# print "is_require:\t" . (caller(0))[7] . "\n" if (caller(0))[7];
	# print "hints:\t" . (caller(0))[8] . "\n" if (caller(0))[8];
	# print "bitmask:\t" . (caller(0))[9] . "\n" if (caller(0))[9];
	# print "hinthash:\t" . (caller(0))[10] . "\n" if (caller(0))[10];
	# print "----------------------------\n";