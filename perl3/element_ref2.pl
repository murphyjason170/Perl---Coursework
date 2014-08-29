#!/usr/bin/perl
use strict;
use warnings;

my %country = (
	us => 'USA',
	uk => 'United Kingdom',
	fr => 'France',
	de => 'Germany',
	es => 'Spain',
	mx => 'Mexico',
	jp => 'Japan',
	in => 'India',
	th => 'Thailand');
	
my $hispanic_ref = \$country{mx};

print "\$hispanic_ref = $hispanic_ref\n";
$$hispanic_ref = 'United Mexican States';

print "$_ = $country{$_}\n" for sort keys %country;

