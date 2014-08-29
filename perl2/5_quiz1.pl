#!/usr/bin/perl
use strict;
use warnings;

# Canadian Postal Code
# A0A 0A0,
# No postal code includes the letters D, F, I, O, Q, or U
# The letters W and Z are used, but are not currently used as the  first letter 
 
while ( defined( my $line = <DATA> ) )
{
	chomp $line;

	my $first_letter =  "a-ceghj-npr-tvxyA-CEGHJ-NPR-TVXY";
	my $other_letters = "a-ceghj-npr-tv-zA-CEGHJ-NPR-TV-Z";

	print "'$line' contains a Canadian Code\n"    
		if $line =~ m![$first_letter][0-9][$other_letters][0-9[\s][0-9][$other_letters][0-9]! ;	 	
}	

__END__
Data:

A9A9A9
B6B6B6
Z6B6B6
B6B6I6



 