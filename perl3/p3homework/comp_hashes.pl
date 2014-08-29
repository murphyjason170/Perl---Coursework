#!/usr/bin/perl
use strict;
use warnings;
# use Data::Dumper;

################################################################
#
# Course: 	Perl III
# Objective:    Lab 8, Objective 1 	
# Student:	Jason Murphy
# Instructor:	Ben Hengst
#
#################################################################

######################################################################################################################
#
#  Table
#  %first							%second				Result
#  -------------------------------------------------------------------------------------------------------------------
# (Wallace=>1, Gromit=>2)					(Gromit=>2, Wallace=>1)		True
# (Kirk=>'Captain', Spock=>'First Officer', McCoy=>'Doctor'	(Spock=>'First Officer', McCoy=>'Doctor'	False
# ()								()				True
# (Wallace=>1, Gromit=>2)					(Wallace=>2,Gromit=>1)		False
# (Wallace=>1, Gromit=>2)					(Wallace=>1,Gromit=>2, Shawn=>3)False
#
######################################################################################################################

#####################################################################
#
# Hash Declarations
# Reference declarations and assignment 
#

# Original Hashes
my %first = (Wallace=>1, Gromit=>2);
my %second = (Gromit=>2, Wallace=>1 );

# Create a reference for the entire hash table
my $first_reference = \%first;
my $second_reference = \%second;
#
#
#
#####################################################################

#####################################################################
#
# Function call to compareHashesViaReferences
print compareHashesViaReferences($first_reference, $second_reference);
print "\n";
#
#####################################################################


sub compareHashesViaReferences
{
	#####################################################################
	#
	# Reference declarations and assignment 
	#
	# Shift the references off of the subroutine call
	my $local_first_hash_ref = shift;
	my $local_second_hash_ref = shift;
	#
	#
	#####################################################################

	#####################################################################
	#
	#
	# Compare the number of keys in each hash. If not equal then return 'false'
	#
	# Get the number of the keys in both hashes
	my $local_first_hash_count = keys %$local_first_hash_ref;		
	my $local_second_hash_count = keys %$local_second_hash_ref;

	# If number of keys do not match then this is an immediate deal-breaker - DONE
	if ($local_first_hash_count ne $local_second_hash_count)
	{
		return 'false';
	}
	#
	#
	#####################################################################
	
	#####################################################################
	#
	# The Hash Compare
	#
	foreach my $key ( keys %{ $local_first_hash_ref } )
	{
		if 
		(
			# Tests to true/false that the key which exists in the first hash also exists in the second hash 
			exists $local_second_hash_ref->{$key}	
			&&
			# Tests to true/false for value sameness in both hashes
			#(${$local_second_hash_ref}{$key} eq ${$local_first_hash_ref}{$key}) 	
			($$local_first_hash_ref{$key} eq $$local_second_hash_ref{$key} )
		)
		{
			# We're good here since the return is assumed 'true' unless
			# a false condition trips the return to 'false'
		}
		else 
		{
			# The two tests did not evaluate to true so that's why we're in
			# this block of code.
			return 'false';
			last;
		}
	}
	return 'true';
	#
	#
	#####################################################################
}


	#####################################################################
	#
	# Debug code
	#
	# Prints out from the first hash
	# print "key: $key, value: ${$local_first_hash_ref}{$key}\n";
	#
	# print "Dumper to print out \$local_first_hash_ref:\n";
	# print Dumper %$local_first_hash_ref;
	# print "\n";
	
	# print "Dumper to print out \$local_second_hash_ref:\n";
	# print Dumper %$local_second_hash_ref;
	# print "\n";

	# Debug fun - just print out the first pair from each hash
	# print "Attempt to print out a value and key from a referenced hash: ";
	# print $$local_first_hash_ref{'Gromit'};    # prints out the value 200
	# print "\n";
	# print "Attempt to print out a value and key from a referenced hash: ";
	# print $$local_first_hash_ref{'Wallace'};    # prints out the value 100
	# print "\n\n";
	# foreach my $key ( keys %{ $local_second_hash_ref } )
	# {
	#	print "key: $key, value: ${$href}{$key}\n";
	# }
	#
	#
	#
	#####################################################################
