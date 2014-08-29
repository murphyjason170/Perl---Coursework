#!/usr/bin/perl
use strict;
use warnings;

my @words = ('rap', 'scrape', 'trap', 'rappel');

foreach my $word ( @words ){
	print "'$word' is a match\n"
	if $word =~ /\brap\b/;
}