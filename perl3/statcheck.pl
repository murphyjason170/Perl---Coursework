#!/usr/bin/perl
use  strict;
use warnings;

################################################################
#
# Lesson 2 - Objective 1
# Class:	Perl III
# Student:	Jason Murphy
# Instructor:	Ben Hengst
#
# Program Description: This program reads the filename ($0) into 
# a user-defined variable ($file)
#
# Then the subroutine check_if_executable is defined which simply
# determines if the file is executable using the -x and -X operators
################################################################

my $file = $0;

sub check_if_executable()
{
	if (-x $file  && -X $file)
	{
		print "$file is executable\n";	
	}
	elsif (! -x $file && -X $file)
	{
		print "$file is not executable\n";	
	}
}	


check_if_executable();



