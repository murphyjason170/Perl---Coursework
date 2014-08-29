#!/usr/bin/perl
use strict;
use warnings;
 
print("The Perl print function overrides my locally defined print subroutine\n");
 
sub print
{
	printf("My print subroutine wins!");
}
