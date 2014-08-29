#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
#############################################################
#
# Lab 11, Objective 1
# 4/2/2014
#
# How to use this program:
# ./state2.pl /software/Perl3/state_full.data
#
#############################################################


# You are correct that you are correctly building the array ref, 
# the issue is that the display, where you are not using the Dumper output but, 
# instead are joining all values thus the new city is appended to the old city. 
# Feel free to skip the big dump of all values and just use the Dumper output for D. 


my %state;
my @names;

##################################################
#
# Die out immediately if no filename is given
#
die "Please provide a file name (i.e. state_full.data)\n" unless ($ARGV[0]);
#
##################################################

##################################################
#
# Load up the hash
#
while ( <> )
{
 chomp;
 my ($abbreviation, @fields) = split /\s*\|\s*/;
 @names = @fields and next if $abbreviation eq 'key';
 @{ $state{$abbreviation} }{@names} = @fields;
}
#
##################################################

##################################################
#
# User Interface
#
my $flag = 'TRUE';

print "Welcome to the State Program\n";

while ($flag eq 'TRUE')
{
	##################################################	
	# 
	# Get user input
	#
	print "Q(uit), (D)ump <abbr>, I(nput) <abbr> <city>:";
	my $input = <STDIN>;
	$input = uc($input);
	chomp $input;
	my @input_array = split(' ', $input);
	chomp @input_array;
		
	print "\n";
	#
	##################################################	
	
	
	##################################################	
	# 
	# If 'Q' is selected - Quitting Time!
	#
	if ($input eq 'Q')
	{
		print "Thank you for visiting!\n";
		$flag = 'FALSE';
	}
	#
	##################################################	
	
	##################################################	
	# 
	# If 'D' is selected - Dump the State information
	#
	if ($input_array[0] eq 'D')
	{
		if (!$input_array[1])
		{
			print "Invalid Command\n";
			exit;
		}
		
		if ($input_array[1])
		{
			my $state_abbr = $input_array[1];
			print "You have entered $state_abbr\n";
			
			print Dumper $state{$state_abbr};
					
		}
	}	
	#
	##################################################	

	##################################################	
	# 
	# If 'I' is selected - Add a city to the database
	#
	if ($input_array[0] eq 'I')
	{		
		# If the required args are missing then flat out bring this one to a close	
		if (!$input_array[1] && !$input_array[2])
		{
			print "Invalid Command\n";
			exit;
		}

		# We have valid input
		if ($input_array[1] && $input_array[2])
		{
			my $state_abbr = $input_array[1];
			my $user_entered_city = $input_array[2];
			
			# print "You have entered $state_abbr\n";
			# print "You have entered $user_entered_city\n";
			##################################################
			#
			# Logic to add another largest_city to the hash
			my $hash_ref = \%state;
			my @combined;

 			for my $value ($hash_ref->{$state_abbr}{largest_city})
			{	
				##################################################
				#
				# We've got an ARRAY reference as a value
				if (ref($value) =~ /ARRAY/)
				{
					# Dump the ARRAY ref values into a local array
					my @local_array = @$value;
					push (@combined, @local_array);
					$hash_ref->{$state_abbr}{largest_city} = [@combined, $user_entered_city];
				}
				#	
				##################################################
				
				##################################################
				#
				# Argument is not an array
				#
				else 
				{
					# Push the value 
					push (@combined, $value);
					$hash_ref->{$state_abbr}{largest_city} = [@combined, $user_entered_city];
				}
				#
				##################################################
				
			}	
			#
			##################################################

			
			##################################################
			#
			# Now print the state out;	
			#
			for my $key (sort keys %{ $state{$state_abbr} } )
			{
				# Add logic to using ref function based on what type of 
				# reference it is		
				if (ref($state{$state_abbr}{$key}) =~ /ARRAY/)
				{
					print Dumper $state{$state_abbr};					
					print "\n";
				}

			}
			#
			##################################################

	#
	##################################################	
		}		
	}	
}