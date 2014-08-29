#!/usr/bin/perl
use strict;
use warnings;

################################################################
#
# 
# Course: 	Perl III
# Objective:    Lab 6, Objective 1 	
# Student:	Jason Murphy
# Instructor:	Ben Hengst
#
# Requirement 1: Accept filenames from command line - 	COMPLETED
# Requirement 2: Properly spelled word:
#   one or more letters A-Z 				COMPLETED
#   ignore any words that are contractions "'";		COMPLETED	
#   ignore casing - i.e. case-insensitive - 		COMPLETED
# Requirement 3: Use the /e modifier			COMPLETED
#
# Test file: Use /software/Perl3/quotes.txt to check
# Dictionary located at: /usr/share/dict/words
#
# user file to feed: 
# ./p3homework/spell.pl /software/Perl3/quotes.txt
#
#################################################################

#################################################################
#
# Put the Dictionary into a hash:
# Dictionary stored at /usr/share/dict/words
#
# Map the words file to a read-only file handle 
my $dictionary_file = "/usr/share/dict/words";
my $fh_dictionary;
open $fh_dictionary, '<', $dictionary_file or die "Could not open $fh_dictionary: $!\n";

my @dictionary_array;		# Array used to hold all words from the $fh_dictionary file handle
my %dictionary_hash;		# The ultimate "database" storage location for the words - a hash
				# Using a hash for quick lookup times
				
chomp(@dictionary_array = <$fh_dictionary>);	

# Use the map function to put the @dictionary_array into the hash  
%dictionary_hash = map { ($_, 1) } @dictionary_array;
#
#
#
#################################################################


#################################################################
#
# Process the User specified file 
#
# 1. split the file into tokens on blank space into the 
#    @current_words array
# 2. shift
#
while (<>)
{
	shift;

	my @current_words = split();
	chomp(@current_words);
	
	foreach (@current_words)
	{
		chomp;
		$_ = lc($_);

		############################################################
		#
		# REGEX filters
		# The goal is to only have viable candidates make it to the 
		# hash lookup
		#
		next if /'/;	# Pass on any contracted words with the single quote
		s/\.//g; 	# Substitution - Remove any periods to shape up a candidate
		s/,//g;		# Substitution - Remove any commmas to shape up a candidate
		#
		#
		############################################################
			
		############################################################
		#
		# Dictionary - Hash lookup
		# The goal is to only have viable candidates make it to the 
		# hash lookup
		#		
		if (exists($dictionary_hash{($_)}))
		{
			print "$_ ";
		}
			else
		{
			# Use the \e modifier to get the output formatted properly
			s!$_!"[$_] "!e;
			print;
		}	
		#
		#	
		############################################################
		
	}
	print "\n";
		
}
#
#
#
#################################################################