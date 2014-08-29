#!/usr/bin/perl
use strict;
use warnings;

# Part I of program

my @chars = 'a' .. 'z';
my @indices;

push @indices, rand @chars for 1 .. shift || 10;
# This is the array slice
print join( ', ' => @chars[ @indices]), "\n"; 
 
# Part II of program

my @beasts = qw(cat hound frog cuckoo);
my @noises = qw(miao bay ribbit cuckoo);

my %sound;
# This is the hash slice
@sound{@beasts}=@noises;

print "A $_ $sound{$_}s\n" for keys %sound;

# Part III of program
my ($hr, $min, $sec) = (localtime)[2,1,0];
printf "The time is %02d:%02d:%02d\n", $hr, $min, $sec;

 







