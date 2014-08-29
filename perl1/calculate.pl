#!/usr/bin/perl
use strict;
use warnings;

my $current_number; 		# Current number 
my $current_function;		# Current function
my $running_total; 		# This is our accumulator
my $user_input;			# This is for user_input 
my $line;

my $has_arguments = @ARGV;

print "Welcome to the calculator - press Control+c to exit the program\n"; 

	print ">";  
		
while ( <> ) {	
	$line = $_;		
	my @array_to_gather = split " ", uc($line);
    	
    	if ( $has_arguments ){	
		print "$line \n";
	}    		
	if ( @array_to_gather == 1){			
		my_operation_on_a_line();
		print(">");
	}
	elsif ( @array_to_gather == 2){
		my_operation_and_number_on_a_line();
		print(">");
	}
}

sub my_operation_on_a_line {
	$current_function = uc($line);	
	chomp($current_function);
	
	if ($current_function eq 'CLEAR'){
		$running_total = 0;
 	}
	elsif ($current_function eq 'EQUALS'){
		if ( ! defined ($running_total )) {
			print "undefined\n";
		}
		else {
			print "= $running_total\n";
		}
	}
	else {
		my_invalid_input();
		next;
	}					
	print "OK\n";
}

sub my_operation_and_number_on_a_line {
	($current_function, $current_number) = split " ", uc($line);	
	
	if ($current_function eq 'PLUS'){
		$running_total += $current_number;  
 	}
	elsif ($current_function eq 'MINUS'){
		$running_total -= $current_number; 
	}
	elsif ($current_function eq 'TIMES'){
		$running_total *= $current_number; 
	}			
	elsif ($current_function eq 'OVER'){
		$running_total /= $current_number; 
	}
	else {
		my_invalid_input();
	}
		
	print "OK\n";
}

sub my_invalid_input {
	print "Sorry I am expecting either a function or a function and a number in each line\n";
	print "Valid functions are CLEAR EQUALS PLUS MINUS TIMES OVER\n"; 
	print ">";
	next;
} 
   
 
 