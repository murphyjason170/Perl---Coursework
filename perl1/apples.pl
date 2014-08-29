#!/usr/bin/perl
use strict;
use warnings;

# Close! However, you don't want to create another variable. 
# Remember the part above where you want to change xxx and yyy 
# "without making any other changes to the code". 
# You only need one print() statement and 'if' statement without 'else'. 


my $apples = 2;
my $got = 'apples';

# xxx
if ($apples == 1){
	$got = 'apple';
}

# yyy
print "I have $apples $got\n";


