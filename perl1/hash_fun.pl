#!/usr/bin/perl
use strict;
use warnings;

my @tree_names = qw(larch pine oak birch fir palm manzanita);
my %is_a_tree;
foreach my $tree (@tree_names)
{
  $is_a_tree{$tree} = 1;
}

my $tree_to_test = 'manzanita';
if ( $is_a_tree{$tree_to_test} )
{
  print "Yup... it's a tree\n";
}
else
{
  print "Not a tree... sure it's not a bush?\n";
}


 