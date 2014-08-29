#!/usr/bin/perl
use strict;
use warnings;

# 0, l, I, and 0 are not used in airline ticket locators to avoid ambiguity in pring
my $pc = '[A-HJ-NP-Z2-9]';

while ( defined( my $line = <DATA> ) )
{
	chomp $line;
	print "'$line' contains a phone number\n"
	  if $line =~ m{[\d\d\d]-[\d\d\d]-[\d\d\d\d]} ;
#
	print "'$line' contains a date\n"
#	  if $line =~ s{\d\d/\d\d\/\d\d}(*****);
#	print "'$line' contains a zip code\n"
#	  if $line =~ s/\d\d\d\d\d/*****/;
#	print "'$line' contains a variable declaration\n"
#	  if $line =~ s/my\s[\$\@\%][A-Za-z]/*****/;
#	print "'$line' contains a air ticket locator\n"
#	  if $line =~ s/$pc$pc$pc$pc$pc$pc/*****/;
}	

__END__
Data:
+3454 723-7483
+1 432-422-2342
(343) 348-4284
9847367289
(2322) 3423-34234
My number is (800) 998-9938, extension 7187
+2 823-238-3732
+1 (352) 235-8476