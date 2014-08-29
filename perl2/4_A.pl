#!/usr/bin/perl
use strict;
use warnings;

# print qq/\\/;

my $fun = q$&$;
print $fun;
print "\n";

$fun =~ /@/ and print "Found it\n";

print "\n";

# my $text = "I HAVE THREE APPLES AND FOUR ORANGES";
# $text =~ /apple/i and print "Found an apple/\n";

# $text = "I have two tomatoes and one zucchini";
# $text =~ m{apple}i or print "Didn't find an apple\n";

