#!/usr/bin/perl
use strict;
use warnings;

my $text = "I HAVE THREE APPLES AND FOUR ORANGES";
$text =~ /apple/i and print "Found an apple/\n";

$text = "I have two tomatoes and one zucchini";
$text =~ m{apple}i or print "Didn't find an apple\n";

