#!/usr/bin/perl
use strict;
use warnings;

while (<DATA>)
{
	print "Before: $_";
	while ( my $result = s/(['"])(\w+)(['"])/{$2}/g )
	{	
		print " Made $result change(s)\n";
	}
	print "After: $_";
}
__END__
In this text, "some" words are "quoted", like this: 'quoted'.
That means they're surrounded by either 'single' quotes
or "double" quotes. But an "apostrophe" in a word like "don't"
doesn't "count".