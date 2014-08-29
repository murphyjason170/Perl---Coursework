#!/usr/bin/perl
use strict;
use warnings;

my $arg1;
my $arg2;

#    -v negates the match; print only lines that do not match the regex.
#    -i makes it case-insensitive; match regardless of case.

if ( $ARGV[0] eq '-v' || $ARGV[0] eq '-i') {
	$arg1 = shift; 
}

if ( $ARGV[0] eq '-v' || $ARGV[0] eq '-i') {
	$arg2 = shift;
}

my $regex = shift;

while ( $_ = <> )
{	
	# handle purely an -i only
	if ( (defined $arg1) && ($arg1 eq "-i") && (! defined $arg2 )){
 	        if (($_) =~ /$regex/i ) {
 	        	print $_ . "\n";
 	        }	
 	       next;
	}
	# handle purely an -v only
	elsif ( (defined $arg1) && ($arg1 eq "-v") && (! defined $arg2) ) {
		if ( $_ =~ /$regex/ ){
			next;
		}
		else {
			print $_ ;
		}
	} 				
	# arg1 or arg2 is a -v 
	#  arg1 or arg2 is a -i  
	#  and both args are defined
	elsif ( ( (defined $arg1) && ($arg1 eq "-v") && ($arg2 eq "-i") && (defined $arg2) )  || ( (defined $arg1) && ($arg1 eq "-i") && ($arg2 eq "-v") && (defined $arg2)) ) 
	 {
		if ( $_ =~ /$regex/i ){
			next;
		}
		else {
			print $_ ;
		}
	} 	
 	else {
 		print if $_ =~ /$regex/;
 	}
}

