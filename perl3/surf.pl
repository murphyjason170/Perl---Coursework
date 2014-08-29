#!/usr/bin/perl
use strict;
use warnings;

my @match_array;

my $source = "The surf crashed against the Seal Beach rocks\n";

@match_array = ($source =~ m!(s[au][tr]f)!);

print @match_array . "\n";

my $var = @match_array;
print "$var\n";
