#!/usr/local/bin/perl
use strict;
use warnings;

use File::Basename;

my @suffix_list = qw(.pl .cgi .htm .html);

my $FMT = "%15s %30s %30s\n";
while ( my $path = prompt() )
{
  printf $FMT, '', 'Hardcoded suffix list', 'Regex suffix list';
  my ($filename_h, $directories_h, $suffix_h) = fileparse( $path, @suffix_list );
  my ($filename_r, $directories_r, $suffix_r) = fileparse( $path, qr/\.[^.]*/ );
  printf $FMT, 'Filename:', $filename_h, $filename_r;
  printf $FMT, 'Directories:', $directories_h, $directories_r;
  printf $FMT, 'Suffix:', $suffix_h, $suffix_r;
}


sub prompt
{
  my $line;
  {
    print "Enter a filename (q to quit): ";
    chomp( $line = <STDIN> );
    redo unless length $line;
    exit if lc $line eq 'q';
  }
  return $line;
}