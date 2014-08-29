#!/usr/bin/perl
use strict;
use warnings;

my $author = "Deat St*r";
my $my_string = "$0 was written by $author";

print "my string is: $my_string \n";

if ( $my_string =~ m!($0) was written by (\Q$author\E)! )
{
print "We have a match\n";
print $1 ;
print "\n";
print $2 ;
print "\n"
}
else {
print "We do not have a match\n";
}