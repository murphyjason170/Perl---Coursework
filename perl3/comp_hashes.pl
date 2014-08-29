#!/usr/bin/perl
use strict;
use warnings;



#
#
#
#
#

my %first = { Wallace => 1, Gromit => 2);
my %second = { Gromit => 2, Wallace => 1);

# Rule 1 
# Rule 1: A simple scalar (like $array_ref) containing a reference to that kind of thing; or
print "Cost of third item from \$furn_ref is: ", 
	$$cost_ref{$$furn_ref[2] },
	"\n";
	
# Rule 2: A block containing anything other than a simple scalar that evaluates to a reference to that kind of thing.
my $alt_furn_ref = [ qw(bed rug rocker stool) ];
my $alt_cost_ref = { bed => 3000, rug => 75, rocker => 450, stool => 125 };
my @refs = ($cost_ref, $alt_cost_ref);

print "Cost of third item in \$alt_furn_ref from second reference in array is: ",
	${ $refs[1]}{ $$alt_furn_ref[2]},
	"\n";
	