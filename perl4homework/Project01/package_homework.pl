#!/usr/local/bin/perl
use strict;
use warnings;

##########################################################
#
# Course:	Perl 4
# Objective:	Lesson 1
# Date:		April 10, 2014
# Instructor: 	Ben Hengst
# Student:	Jason Murphy	 
#
##########################################################


# Replace the following comments with one or more statements that perform what each comment says.
# The requirement here is to demonstrate that you can use multiple
# ways of accessing the package variables and subroutines wherever they exist.
{
 our @array = qw(Max Headroom);
}

sub first
{
 print "I am in first()\n";
}

package old;

{
 package new;

 our $scalar = "Fred";
}

sub second
{
 print "I am in second()\n";
}
# Do not alter any code above this line.

# Print @array by using 'package' and 'our' - DONE
package main;
our @array;
print @array;

# Print @array by using an explicit package in the variable - DONE
print @main::array;

# Call first() by using 'package' - DONE
package main;
first();	

# Call first() by using an explicit package in its name - DONE
main::first();

# Print $scalar by using 'package' and 'our' - DONE
package new;
our $scalar;
print $scalar;

# Print $scalar by using an explicit package in the variable - DONE
print $new::scalar;

# Call second() by using 'package' - DONE
package old;
second();

# Call second() by using an explicit package in its name - DONE
old::second();

# Debug code
# print "Package name: " . __PACKAGE__ . "\n";	# Package name: old
