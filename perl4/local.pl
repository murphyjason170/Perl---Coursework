#!/usr/local/bin/perl
use strict;
use warnings;

my @WORDS = qw(boil roast flambe saute fry poach toast bake steam sear);

my @ints = (0 .. 9);

for ( @ints )
{
	mypack::create_report( $_ );
}

print "Before: @ints\n";
for ( @ints )
{
	print "$_: ";
	mypack::print_report( $_ );
}
print "After: @ints\n";
unlink glob "*.rpt";

package mypack;

sub print_report
{
	my $file = shift;
	
	local $_;
	
	local @ARGV = "$file.rpt";
	while ( <> )
	{
		print;
	}
}

sub create_report
{
	my $file = shift;
	print "\$file is $file\n";
	
	open my $fh, '>', "$file.rpt" or die $!;
	print {$fh} "$WORDS[$file]\n";
}

