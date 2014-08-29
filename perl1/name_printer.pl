#!/usr/bin/perl
use strict;
use warnings;
 
# 
# |               |               | 
# |Penelope       |Aloysius Parker| 
# |Creighton-Ward |               | 


my $boss_first_name = "bossfirst";
my $boss_last_name = "bosslast";

my $butler_first_name = "butlerfirst";
my $butler_last_name = "butlerlast";

my $field_width = 15;

print '|', ' 'x$field_width, '|', ' 'x$field_width, "|\n";


if (  (length("$boss_first_name $boss_last_name")) <= $field_width  && length("$butler_first_name $butler_last_name") <= $field_width    )
{
	print '|', "$boss_first_name $boss_last_name", ' 'x($field_width - length("$boss_first_name $boss_last_name")), '|'; 	
  	print "$butler_first_name $butler_last_name", ' 'x($field_width - length("$butler_first_name $butler_last_name")), '|', "\n"; 
}
elsif  ( length("$boss_first_name $boss_last_name") > $field_width && length("$butler_first_name $butler_last_name") > $field_width ) 
{
	print '|', "$boss_first_name", ' 'x($field_width - length($boss_first_name)), '|';
	print "$butler_first_name", ' 'x($field_width - length($butler_first_name)), '|';
	print "\n";
		 	
	print '|', "$boss_last_name", ' 'x($field_width - length($boss_last_name)), '|';
	print "$butler_last_name", ' 'x($field_width - length($butler_last_name)), '|';
	print "\n";
}
elsif  ( length("$boss_first_name $boss_last_name") > $field_width && length("$butler_first_name $butler_last_name") <= $field_width )
{
	print '|', "$boss_first_name", ' 'x($field_width - length($boss_first_name)), '|';
   	print "$butler_first_name $butler_last_name", ' 'x($field_width - length("$butler_first_name $butler_last_name")), '|', "\n"; 
 		 	
	print '|', "$boss_last_name", ' 'x($field_width - length($boss_last_name)), '|';
	print ' 'x$field_width, "|\n";
 }
elsif ( length("$boss_first_name $boss_last_name") <= $field_width && length("$butler_first_name $butler_last_name") > $field_width )
{
	print '|', "$boss_first_name $boss_last_name", ' 'x($field_width - length("$boss_first_name $boss_last_name")), '|'; 	
    	print "$butler_first_name", ' 'x($field_width - length($butler_first_name)), '|', "\n"; 
 		 	
	print '|', ' 'x$field_width, "|";
	print "$butler_last_name", ' 'x($field_width - length($butler_last_name)), '|';
	print "\n";	
}
else
{
	print "Sorry I did not account for your situation!";
}
print '|', ' 'x$field_width, '|', ' 'x$field_width, "|\n";

