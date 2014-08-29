use strict;
use warnings;
use Data::Dumper;

###########################################################
# 
# Course:		Perl 4
# Objective:		Lesson 2, Objective 1
# Date:			April 11, 2014
# Instructor:		Ben Hengst
# Student:		Jason Murphy
#
###########################################################

sub read_report
{
	# This will be the hash that will be the data structure to store the
	# incoming data
	my %account;

	# Shift off the file handle from the caller
	my $fh = shift;

	# These variables store the crucial data to be plucked out by REGEXs
	my $account_number;

	my @fields;				# Array the fields are stored in
	my $total_elements_in_array;
	my %inside_hash;			# Inner hash data structure	
	my %outside_hash;			# Outer hash data structure that will store the inner hash structure
	my $counter = 0;			# A counter to keep track of the fields array count
	my $account_number_location = 0;
	
	my @cleaned_up_array;
	
	my @incoming_file = (<$fh>);
 	chomp @incoming_file;

	# Pluck out the FIELDS line	
	foreach my $line (@incoming_file)
	{
		# Next on any comment lines
		if ( $line =~ /^#/)
		{
			next;
		}
		# If the FIELDS line is encountered then you've got your vars
		elsif ($line =~ /FIELDS:/)
		{
			# Sample FIELDS line:
			# FIELDS: owner, account_number, balance, credit_limit
			my $fields_line = $line;
			$fields_line =~ s/FIELDS: //;			
			@fields = split(',', $fields_line);
			chomp @fields;
			$total_elements_in_array = scalar @fields;
			
			# Remove white space from all elements in the @fields array
			for (@fields)	
			{  
    				s/\s+//;
 			}
			next;
		}
		else
		{
			push (@cleaned_up_array, $line);		
		}			
	}	

	
	# Determine and put the index of the 'account_number' into a variable
	foreach my $field (@fields)
	{	
		chomp $field;

		if ($field eq 'account_number')
		{
			$account_number_location = $counter;
			$counter = 0;
		}
		else
		{
			$counter++;
		}
	}

	# Adjust the array count 	
	$total_elements_in_array--;
	
	my $line_counter = 0;		# For stepping through the lines
	my $hash_time = 'false';	# Assume not ready to hash togther the hashes
	my $temp_account_number; 
	my $cleaned_counter = 0;
				
	# Build the data structures	
	foreach my $line (@cleaned_up_array)
	{			
		# Put this non-account into a hash
		if ($fields[$line_counter] ne 'account_number')
		{			
			$inside_hash{ $fields[$line_counter] } = $line;
		}
		
		# We have our outer hash account_number		
		elsif ($fields[$line_counter] eq 'account_number')
		{
			$temp_account_number = $line;
		}				

		# Let's go hashing!!
		if ($line_counter == $total_elements_in_array)
		{
			$line_counter = 0;
			# print "Establishing the outer hash with: $temp_account_number\n";

			my %temp_inside_hash = %inside_hash;
			$outside_hash{$temp_account_number} = \%temp_inside_hash;			
		}	
		else
		{
			$line_counter++;		
		}
						
	}		
	
	%account = %outside_hash;			
	return %account;
}
1;