#!/usr/bin/perl
use strict;
use warnings;

#############################################################################################################
#
#	Perl II 	Final Objective 	
#	By: 		Jason Murphy
#	Written:	Feb 19, 2014
#
#############################################################################################################

#############################################################################################################
#
# File Handle Related:
# Place-holder for file to read in
my $SOURCE_DATA_FILE = 'file.txt';
my $fh;
#
#
#############################################################################################################

#############################################################################################################
#
# Variables and Array declarations:
#
#
my $order_directive;						# Scalar to store the order directive
my $order_directive_acceptable = 'false';	# Boolean - assume that the order is not good 
my $order_directive_count = 0;				# Counter - tracks directives and will be used to issue a warning if > 1. 

my $user_input;								# A scalar to store the user entered input 
my @array_user_input;						# Array to store the user inputted IP address or host name

my @denied;									# Array to store REGEX'd elements with "deny from" directive
my @allowed;								# Array to store REGEX'd elements with "allow from" directive

my @array_current_line;						# Array to store the current line from an allow or deny directive

my $is_field_a_number = 'no';						# yes/no value
my $candidate_in_denied_array_matched = 'no';		# yes/no value			
my $candidate_in_allowed_array_matched = 'no';		# yes/no value
my $candidate_octet_no_match = 'yes';				# yes/no value
#
#
#############################################################################################################


		##############################################################################
		# This goes through the @ARGV array one by one 
		# This goes through each file 
		#
		#
		foreach my $current_file (@ARGV)
		{
			$SOURCE_DATA_FILE = $current_file;
			open $fh, '<', $SOURCE_DATA_FILE or die "Could not open $SOURCE_DATA_FILE: $!\n";

			# This loops through the individual lines in the file
			# 
			while (<$fh>)
			{
				#Pluck out the order:
				if (m!order allow,deny!)
				{
					$order_directive = 'allow,deny';
					$order_directive_acceptable = 'true';
					$order_directive_count++;
				}
				if (m!order deny,allow!)
				{
					$order_directive = 'deny,allow';
					$order_directive_acceptable = 'true';
					$order_directive_count++;
				}		
				
				# This puts every line in the current htaccess file into an array by splitting on the newline
				@array_current_line = split(m!\n!, $_);
				
				# Loop through the @array_current_line and put the line in the allow or deny arrays
				foreach my $line (@array_current_line)
				{
					chomp($line);
					# Put the allow directives into the @allowed array
					if ($line =~ m!allow from (.*)!)
					{							
						push(@allowed, $1);
					}		
					# Put the deny directives into the @denied array
					if ($line =~ m!deny from (.*)!)
					{
						push(@denied, $1);
					}	
				}
		}	
		close $fh;
		#
		#
		##############################################################################
	
	
	##############################################################################
	# Order Directive assessment
	#
	#
	if ($order_directive_acceptable eq 'false') {
		die "No order directive in input\n";
	}
	
	# Order Directive count	
	if ($order_directive_count > 1){
		print "Multiple ORDER directives\n";
	}
	#
	#
	##############################################################################

	##############################################################################
	#
	# User interface 
	#
	#
	$user_input = 'test';
	do 
	{
		# Get user input and immediately tokenize into @user_input_array
		print ("Input address to test: ");
		$user_input = <STDIN>;
		chomp($user_input);

		my (@user_input_array) = split("[.]", $user_input);
		
		##############################################
		#
		# Determine if @user_input_array contains 
		# a non-numeric (the if evaluatino) or numeric (the else clause)
		#
		foreach (@user_input_array)
		{
			# Match on a non-number
			if (m!\D+!)
			{
				$is_field_a_number = 'no';	
			}
			# Match on a number 
			else
			{
				$is_field_a_number = 'yes';			
			}		
		}
		#
		#
		##############################################

		my $candidate_counter = 1;
		
		##############################################
		#
		#  If a number then cycle through the arrays 
		#  and look for a match
		#  
		if ($is_field_a_number eq 'yes')
		{		
			my $allow_line_counter = 0;

			######################################################################################################
			#
			# Loop through each line in the allowed array
			#
			#
			foreach my $current_allowed (@allowed)
			{	
				$candidate_octet_no_match = 'yes';

				#Split the ip address or hostname into multiple fields into the @current_allowed_address
				my @current_allowed_address = split "[.]", $current_allowed;
					
				
				for (my $i = 0; $i < @user_input_array; $i++) 
				{
					if (scalar(@user_input_array ) <  scalar(@current_allowed_address))
					{
						$candidate_octet_no_match = 'no';					
						last;
					}
					
					if ( (! exists $user_input_array[$i]) || (! exists $current_allowed_address[$i]) )
					{
						next;
					}
				 
					if ($user_input_array[$i] ne $current_allowed_address[$i])
					{
						$candidate_octet_no_match = 'no';					
						last;
					}															
				}	
							
					if ($candidate_octet_no_match eq 'yes' )
					{
						last;
					}

					$candidate_counter++;					
					$candidate_octet_no_match = 'no';
			} 

			if ($candidate_octet_no_match eq 'yes')
			{
				$candidate_in_allowed_array_matched = 'yes';
			}
			#
			#
			#			
			######################################################################################################

			######################################################################################################
			# 
			#  Set trackers back to defaults
			$candidate_octet_no_match = 'yes';
			$candidate_counter = 1;					
			#
			#
			######################################################################################################


			######################################################################################################
			#
			# Loop through each line in the denied array
			#
			#
			foreach my $current_denied(@denied)
			{			
				$candidate_octet_no_match = 'yes';

				#Split the ip address or hostname into multiple fields into the @current_allowed_address
				my @current_denied_address = split "[.]", $current_denied;
					
							
				for (my $i = 0; $i < @user_input_array; $i++) 
				{
					if (scalar(@user_input_array ) <  scalar(@current_denied_address))
					{
						$candidate_octet_no_match = 'no';					
						next;
					}				
				
					if ( (! exists $user_input_array[$i]) || (! exists $current_denied_address[$i]) )
					{
						last;
					}
				
					if ($user_input_array[$i] ne $current_denied_address[$i])
					{
						# if a non-match is found within the octets then no need to further evaluate other
						# octets within the same address
						$candidate_octet_no_match = 'no';					
						last;
					}															
				}
				
					if ($candidate_octet_no_match eq 'yes')
					{
						# if all octets match then no need to evaluate further
						last;
					}
					
					$candidate_counter++;					
			}

			# Overall address conclusion
			if ($candidate_octet_no_match eq 'yes')
			{
				$candidate_in_denied_array_matched = 'yes';
			}
		}		
		#
		#
		#
		######################################################################################################

				
		######################################################################################################
		#
		# Set trackers back to defaults
		$candidate_octet_no_match = 'yes';
		$candidate_counter = 1;					
		#
		#
		######################################################################################################
		
		
		######################################################################################################
		#
		#  If a text field then cycle through the arrays and look for a match
		#  
		#  
		if ($is_field_a_number eq 'no')
		{		
			my $allow_line_counter = 0;

			######################################################################################################
			# Loop through each line in the allowed array
			foreach my $current_allowed (@allowed)
			{	
				$candidate_octet_no_match = 'yes';

				#Split the ip address or hostname into multiple fields into the @current_allowed_address
				my @current_allowed_address = split "[.]", $current_allowed;
				@current_allowed_address = reverse (@current_allowed_address);
				
				@user_input_array = reverse(@user_input_array);				
				
				for (my $i = 0; $i < @user_input_array; $i++) 
				{
					if (scalar(@user_input_array ) <  scalar(@current_allowed_address))
					{
						$candidate_octet_no_match = 'no';					
						last;
					}
					
					if ( (! exists $user_input_array[$i]) || (! exists $current_allowed_address[$i]) )
					{
						next;
					}
 
					if ($user_input_array[$i] ne $current_allowed_address[$i])
					{
						$candidate_octet_no_match = 'no';					
						last;
					}															
				}	
					
					
					if ($candidate_octet_no_match eq 'yes' )
					{
						last;
					}

					$candidate_counter++;					
					$candidate_octet_no_match = 'no';
			} 

			if ($candidate_octet_no_match eq 'yes')
			{
				$candidate_in_allowed_array_matched = 'yes';
			}
			#
			#			
			######################################################################################################

			######################################################################################################
			#
			# Set trackers back to defaults
			#
			$candidate_octet_no_match = 'yes';
			$candidate_counter = 1;
			#
			#			
			######################################################################################################



			######################################################################################################
			#
			# Loop through each line in the denied array
			#
			foreach my $current_denied(@denied)
			{	
				$candidate_octet_no_match = 'yes';

				#Split the ip address or hostname into multiple fields into the @current_allowed_address
				my @current_denied_address = split "[.]", $current_denied;
				@current_denied_address = reverse (@current_denied_address);
											
				for (my $i = 0; $i < @user_input_array; $i++) 
				{
					if (scalar(@user_input_array ) <  scalar(@current_denied_address))
					{
						$candidate_octet_no_match = 'no';					
						next;
					}				
				
					if ( (! exists $user_input_array[$i]) || (! exists $current_denied_address[$i]) )
					{
						last;
					}
				
					if ($user_input_array[$i] ne $current_denied_address[$i])
					{
						$candidate_octet_no_match = 'no';					
						last;
					}															
				}
											
					if ($candidate_octet_no_match eq 'yes')
					{
						last;
					}
					
					$candidate_counter++;					
			}

			if ($candidate_octet_no_match eq 'yes')
			{
				$candidate_in_denied_array_matched = 'yes';
			}
		}	
		#
		#
		###################################################################################################
		
				
		###################################################################################################
		#
		# The logic for a deny, allow scenario
		#
		if ($order_directive eq 'deny,allow')
		{
			if ( $candidate_in_denied_array_matched eq 'yes' && $candidate_in_allowed_array_matched eq 'yes')
			{
				print "ALLOWED\n";
			}			
			elsif ( $candidate_in_denied_array_matched eq 'yes' && $candidate_in_allowed_array_matched eq 'no')
			{
				print "REJECTED\n";
			}			
			elsif ( $candidate_in_denied_array_matched eq 'no' && $candidate_in_allowed_array_matched eq 'yes')
			{
				print "ALLOWED\n";
			}			

			elsif ( $candidate_in_denied_array_matched eq 'no' && $candidate_in_allowed_array_matched eq 'no')
			{
				print "ALLOWED\n";
			}			
		}	
		#
		#
		###################################################################################################

		###################################################################################################
		#
		# The logic for a allow,deny scenario
		#
		if ($order_directive eq 'allow,deny')
		{			
			if ( $candidate_in_allowed_array_matched eq 'no' && $candidate_in_denied_array_matched eq 'no')
			{
				print "REJECTED\n";
			}			
			
			if ( $candidate_in_allowed_array_matched eq 'yes' && $candidate_in_denied_array_matched eq 'yes')
			{
				print "REJECTED\n";
			}	
		
			if ( $candidate_in_allowed_array_matched eq 'yes' && $candidate_in_denied_array_matched eq 'no')
			{
				print "ALLOWED\n";
			}	

		}	
			# Set back to defaults
			$candidate_in_denied_array_matched = 'no';	
			$candidate_in_allowed_array_matched = 'no';	
		#	
		#
		###################################################################################################
	} while ($user_input ne 'quit');


	###################################################################################################
	#
	# Post- User interface clean-up
	#
	#
	$order_directive_acceptable = 'false';
	#
	#
	###################################################################################################
}