#!/usr/bin/perl
use strict;
use warnings;


open my $fh, '<', '/usr/share/dict/words' or die "Couldn't open file: $!\n";

# Requirements:
# Write a program that uses map and grep to populate a hash with a key for every word in the file /usr/share/dict/words
# Each key should be converted to lowercase. - COMPLETED   
# Ignore any line that does not consist solely of letters. - COMPLETED 
# Populate this hash with a single statement after opening a filehandle. - COMPLETED

# Make sure that  the %word hash is populated with every word
my %word = map{(lc($_), 1)} grep{/\w+/ && !/[-\.\']/} grep{s/\n//} my @dictionary=<$fh>;

# DEBUG CODE: Print out the %word hash
# my ($key, $value);
#while (($key, $value)=each(%word))
# {
#  print "Word: $key  Value: $value\n";
# }

print "Verification: the following words should be in the hash:\n";
print "$_: ", $word{$_} ? 'PASS' : 'FAIL', "\n" for qw(wolf schumpeter saltpeter);
print "Verification: the following words should not be in the hash:\n";
print "$_: ", $word{$_} ? 'FAIL' : 'PASS', "\n" for qw(wolfsmilk Schumpeter peter-penny);