#!/usr/bin/perl
use strict;
use warnings;

# if ( $word =~ /\w+\w*\w+/ ){

my $word = "freedom";

if ( $word =~ /(\w+)(\w*)(\w+)/){
	print "$1 \n";
	print "$2 \n";
	print "$3 \n";
}
else {
	print "No match!\n";
}
# 	+ one or more
#	* 0 or more
# 	\w matches [a-zA-Z0-9]

