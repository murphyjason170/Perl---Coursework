#!/usr/bin/perl
use strict;
use warnings;

my @first = qw(Can unlock secret);
my @second = qw(you the code?);

my @mixed = interleave_words( scalar(@first), @first, @second );
print "Result: @mixed\n";

sub interleave_words
{
  my @results;
  
  my $count = shift;
  foreach my $index ( 0 .. $count-1 )
  {
    $results[$index * 2] = shift;
  }
  if ( @_ != $count )
  {
    die "Second array not same size ($count) as the first\n";
  }
  foreach my $index ( 0 .. $count-1 )
  {
    $results[$index * 2 + 1] = shift;
  }

  return @results;
}


