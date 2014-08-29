#!/usr/bin/perl
use strict;
use warnings;

# count hash:
# The KEY:	a word
# The VALUE:	the number of occurrences of the wor
my %count;

my $min_num_chars = 0;
 
# This is the command line logic
if ( @ARGV == 0 ){
	die "Please enter command-line arguments.\n";
}
elsif ( @ARGV >= 1 ){
	$min_num_chars = shift;	
}
 
# This is the text file logic:
while ( $_ = <> ) {	
	my @words = split;
  
	foreach $_ ( @words ){
		if (length $_ < $min_num_chars ) {
			print "the word "; 
			print ;
			print " is less than $min_num_chars and not being added to the hash\n";
		}
		else {
			$count{$_}++;
  		}
	}
}
print "$_: $count{$_}\n" foreach sort keys %count;