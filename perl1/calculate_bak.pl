#!/usr/bin/perl
use strict;
use warnings;

my $current_number; 		# Current number 
my $current_function;		# Current function

my $running_total; 		# This is our accumulator

my $user_input;			# This is for user_input 

if ( @ARGV > 0 )
{
 	while ( @ARGV > 0 )
	{		
		while ( defined ( my $line = <> ))
		{		
			chomp ($line);
		 
			($current_function, $current_number) = split " ", $line, 2;
			
			
			# In case we hit a line that has nothing defined
 			if ( ! defined $current_number && ! defined $current_function )
 			{
 				print "We have hit a blank line\n";
 				next;
 			}
 			
			
			# If current number is not defined then let's define it so that we don't
			# run into undefined issues.
			if ( ! defined $current_number)
			{
				$current_number = 0;
 			}
 							 
					if ($current_function eq 'PLUS')
					{
						$running_total += $current_number;
						print "Plus $current_number is $running_total\n";
						print "OK\n\n";
  					}
					elsif ($current_function eq 'MINUS')
					{
						$running_total -= $current_number;
						print "Minus $current_number is $running_total\n";
						print "OK\n\n"
 					}
					elsif ($current_function eq 'TIMES')
					{
						print "Times $current_number\n\n";
						$running_total *= $current_number;  
					}			
					elsif ($current_function eq 'OVER')
					{
						print "Over $current_number\n\n";
						$running_total /= $current_number;
 					}
 					elsif ( $current_function eq 'CLEAR' )
					{
						$running_total = 0;
						print "OK cleared\n\n";
					}
					elsif ( $current_function eq 'EQUALS' )
					{
						print "The running total is $running_total\n\n";		
					}
 					else 
					{
						my_invalid_input();
					}		
   		}		
  	}
			shift @ARGV ;
}			


  	print "Welcome to the calculator - press Control+c to exit the program\n"; 
	while (1)
	{
		print ">";
		$user_input = <STDIN>;
   	
   		my @array_to_gather = split " ", uc($user_input);
   		my $number_of_elements = @array_to_gather;
    		
  		if ($number_of_elements == 1)
  		{
			$current_function = uc($user_input);	
			chomp($current_function);
	
			if ($current_function eq 'CLEAR')
			{
				$running_total = 0;
				print "OK\n";
			}
			elsif ($current_function eq 'EQUALS')
			{	
			 	if ( ! defined ( $running_total ))
			 	{
			 		print "undefined\n";
			 		$running_total = 0;
			 	}
			 	else
			 	{
				print "= $running_total\n";
				}		
			}
 			else 
			{
				my_invalid_input();
			}		
			
		}
  		elsif ($number_of_elements == 2)
  		{
			($current_function, $current_number) = split " ", uc($user_input);	
	
			if ($current_function eq 'PLUS')
			{
				my_plus();
 			}
			elsif ($current_function eq 'MINUS')
			{
				my_minus();
 			}
			elsif ($current_function eq 'TIMES')
			{
				my_times();   
			}			
			elsif ($current_function eq 'OVER')
			{
				my_division();
 			}
 			else 
			{
				my_invalid_input();
			}		
		}
}

 
	
sub my_plus
{
	$running_total = $running_total + $current_number; 
	print "OK\n";
}

sub my_minus
{
	$running_total = $running_total - $current_number; 
	print "OK\n";
}

  
sub my_times
{
	$running_total = $running_total * $current_number; 
	print "OK\n";
}

sub my_division		
{
 	$running_total = $running_total / $current_number; 
	print "OK\n";
}

sub my_invalid_input {
	print "Sorry I am expecting either a function or a function and a number in each line\n";
 	print "Valid functions are CLEAR EQUALS PLUS MINUS TIMES OVER\n"; 
}