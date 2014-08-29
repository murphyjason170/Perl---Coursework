#!/usr/bin/perl
use strict;
use warnings;

 
# Telephone #s must match either +1 DDD-DDD-DDDD or (DDD) DDD-DDDD. 

while ( defined( my $line = <DATA> ) )
{
	chomp $line;

	print "'$line' contains a phone number +1 DDD-DDD-DDDD\n"
		if $line =~ m!\+1\s\d\d\d\-\d\d\d\-\d\d\d\d! ;	
 	
	print "'$line' contains a phone number (DDD) DDD-DDDD\n"
		if $line =~ m!\(\d\d\d\)\s\d\d\d\-\d\d\d\d! ;		
}	

__END__
Data:
(123)
+3454 723-7483
+1 432-422-2342
(343) 348-4284
9847367289
(2322) 3423-34234
My number is (800) 998-9938, extension 7187
+2 823-238-3732
+1 (352) 235-8476