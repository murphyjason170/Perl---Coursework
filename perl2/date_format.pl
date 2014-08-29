#!/usr/bin/perl
use strict;
use warnings;
 
while ( my $line = <> )
 {
 	chomp $line;
 	# This line matches for example January 1, 2011 
 	if ( $line =~ /(.*)\s+(\d+),\s+(\d{4})/ )
 	{
 		my $month_num = 12;
 		
 		my ($month, $day, $year) = ($1, $2, $3);
 		
 		$month_num = "1" if ( $month eq "January");
 		$month_num = "2" if ( $month eq "February");
 		$month_num = "3" if ( $month eq "March");
 		$month_num = "4" if ( $month eq "April");
 		$month_num = "5" if ( $month eq "May");
 		$month_num = "6" if ( $month eq "June");
 		$month_num = "7" if ( $month eq "July");
 		$month_num = "8" if ( $month eq "August");
 		$month_num = "9" if ( $month eq "September");
 		$month_num = "10" if ( $month eq "October");
 		$month_num = "11" if ( $month eq "November");
 		$month_num = "12" if ( $month eq "December");
 		
 		print "$year-$month_num-$day\n",
 	}
 }
 

