#!/usr/bin/perl
use strict;
use warnings;

my @first = qw(Can unlock secret);
my @second = qw(you the code?);

interleave_this(@first, @second);
 
sub interleave_this
{
	my @results;			# This will store the interleaved data
 	
	while ( @_ ) 
	{
		my $tracker = 0;
		
 		my @results = splice( @_, $tracker, 1);
 		
 		$tracker = $tracker + 1;
		print @results;	
		print scalar(@results);
 	}	
 }




# •splice ARRAY or EXPR,OFFSET,LENGTH,LIST 
# •splice ARRAY or EXPR,OFFSET,LENGTH 
# •splice ARRAY or EXPR,OFFSET 
# •splice ARRAY or EXPR 
