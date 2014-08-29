#!/usr/bin/perl

use strict;
use warnings;
  
# John  
# Paul 
# George
# Ringo is Drums
# Pete Best is the 5th Beatle - the original drummer

my @Beatles = qw(John Paul George Ringo);
my ($drummer, @vocals);		# This simply declares both the drummer scalar and vocals arrau

 
print "This is the beginning without any manipulations:\n";
print "Beatles array is now: @Beatles\n";
print "Vocals array is now: @vocals\n";
print "\n";

push @vocals, shift @Beatles;	# This inserts at the end of the @vocal array, shift removes the scalar at the beginning of the @Beatles array
				# John is temporarily now on the @vocals array

push @vocals, shift @Beatles;   # push inserts at the end of the @vocals array, shift removes the scalar at the beginning of the @Beatles array
				# Paul is now temporarily on the @vocals array

push @vocals, shift @Beatles; # push inserts at the end of the @vocals array, shift removes the scalar at the beginning of the @Beatles array
				# i.e. goodbye Paul
				
print "The John, Paul and George have shifted off the the Beatles array:\n";
print "Beatles array is now: @Beatles\n";
print "Vocals array is now: @vocals\n";
print "\n";

$drummer = pop @Beatles;	# This removes the element at the end of the @Beatles array and stores into $drummer var

print "Pete Best has rejoined the Beatles, albeit temporarily:\n\n";
push @Beatles, 'Pete Best';	# This inserts 'Pete Best' at the end of the array @Beatles array
shift @Beatles;			# This would remove 1 leading element off of the @Beatles array

												
unshift @Beatles, @vocals;  	#This inserts the elements of the @vocals array into front of the @Beatles array

push @Beatles, $drummer;	# push inserts $drummer scalar at the end of the @Beatles array
				# This puts Ringo back in as the drummer
				

print "Now in the Final State after all manipulations have been performed:\n";
print "Beatles array is now: @Beatles\n";
  

 