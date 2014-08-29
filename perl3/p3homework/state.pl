#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

################################################################
#
# Course: 		Perl III
# Objective:    Lab 10, Objective 1 
# Student:		Jason Murphy
# Instructor:	Ben Hengst
#
################################################################

################################################################
# For future reference - how to run this program
#
# Valid permuations:
# cold1:~/p3homework$ ./state.pl /software/Perl3/state_no_header.data VA  
# cold1:~/p3homework$ ./state.pl /software/Perl3/state_no_header.data VA name 
#
# Invalid permuations:
# cold1:~/p3homework$ ./state.pl    
# cold1:~/p3homework$ ./state.pl /software/Perl3/state_no_header.data   

my %state;
my @names;


################################################################
#
# Handling args passed in via CLI - the souce file name
#
if (!$ARGV[0])
{
	print "Mandatory argument missing - the file name\n";
	print_usage();
	die;
}

if (!$ARGV[1])
{
	print "Mandatory argument missing - the state abbreviation\n";
	print_usage();
	die;
}
#
################################################################


################################################################
#
# Handling args passed in via command line - the attribute
# 
#

my $user_indicated_attribute;
my $attribute_optioned = 'false';
if ($ARGV[1] && $ARGV[2])
{
	$user_indicated_attribute = pop;
	chomp $user_indicated_attribute;
	$attribute_optioned = 'true';
}
#
################################################################

################################################################
#
# Handling args passed in via CLI - the 2-letter state 
#
my $user_indicated_state; 
my $state_optioned = 'false';
if ($ARGV[1])
{
	$user_indicated_state = pop;
	chomp $user_indicated_state;
	$user_indicated_state = uc($user_indicated_state);
	$state_optioned = 'true';
}
#
################################################################


################################################################
#
# This section creates the hash data structure
# Reads line by line and splits the line into tokens
# and assigns the tokens into scalar vars.
# Then maps the scalar vars into the state hash
#
while (<>)
{
	chomp;
	my ($abbreviation, $full_state, $capital, $largest_city, $bird, $flower) = split /\s*\|\s*/;
	
	$state{$abbreviation} = { name => $full_state, capitol => $capital, largest_city => $largest_city, 
		bird=> $bird, flower => $flower };
}
#
################################################################

################################################################
#
# Logic when the user does not provide a state in the CLI
#
if ($state_optioned eq 'false')
{	
	my $limit;

	# Sort the outer hash for the 2-letter state
	for my $abbr (sort keys %state)
	{
		print "State: $abbr\n";
		# Sort through the sub-hash
		for my $key (sort keys %{ $state{$abbr} } )
		{
			# Print out the attribute
			print "\t$key: $state{$abbr}{$key}\n";
		}
		print "\n";
		exit if ++$limit >= 50;
	}
}
#
################################################################


################################################################
#
# Logic when the user does provide a state in the CLI
#
my $state_found_flag = 'false';

if ($state_optioned eq 'true')
{	
	# Sort the outer hash for the 2-letter state
	for my $abbr (sort keys %state)
	{	
		# If the user indicated state is found
		if ($abbr eq $user_indicated_state)
		{
			$state_found_flag = 'true';
			print "State: $abbr\n";
			
			# If an attribute was not specified on the command line
			if ($attribute_optioned eq 'false')
			{
				for my $key (sort keys %{ $state{$user_indicated_state} } )
				{
					print "\t$key: $state{$user_indicated_state}{$key}\n";
				}
				print "\n";
			}
			
			my $attribute_found_flag = 'false';
			
			# If an attribute was specified on the command line
			if ($attribute_optioned eq 'true')
			{
				for my $key (sort keys %{ $state{$user_indicated_state} } )
				{
					if ($key eq $user_indicated_attribute)
					{
						print "\t$key: $state{$user_indicated_state}{$key}\n";
						$attribute_found_flag = 'true';
					}
				}
					
				print "\n";
				
				# Assess is the user specified attribute was found and if not print a helpful
				# message 
				if ($attribute_found_flag eq 'false')
				{
					print "The attribute $user_indicated_attribute was not found\n";
				}
				# If the 2-letter state was not found in the outer hash
				if ($state_found_flag eq 'false')
				{
					print "The state $user_indicated_state was not found\n";
					die;
				}
			}
		}
	}
}
	
	

sub print_usage
{
	print "Argument 1 (Mandatory) is a file name.\n";
	print "Argument 2 (Mandatory) is a 2-letter state name\n";
	print "Argument 3 (Optional) is an attribute\n";
	print "\t(i.e. name, capital, largest_city, bird, flower)\n";
	print "\nExample usage:\n";
	print "\tstate.pl state_no_header.data CA\n\n";
}

#
################################################################