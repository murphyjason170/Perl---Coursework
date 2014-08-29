#!/usr/bin/perl
use strict;
use warnings;

my $temp_file = "$ENV{'HOME'}/.edit.pl.$$";
unlink $temp_file;

my $date = localtime;
{
	open my $fh, '>', $temp_file or die "open $temp_file: $!\n";
	print {$fh} "This file was written on $date by $0 \n";
	print {$fh} "Here's your chance to customize it \n";
}

print "Stand by to edit!\n";
my $editor = $ENV{EDITOR} || 'vi';
system "$editor $temp_file";

print "Contents of $temp_file are now:\n";
{
	open my $fh, '<', $temp_file or die "open $temp_file: $!\n";
	print while <$fh>;
}
unlink $temp_file;
