#!/usr/local/bin/perl
use strict;
use warnings;

my $state;

my $result;

my $pid = fork;
if ( $pid )
{
 print "in if\n";
 # wait;
}
elsif ( defined( $pid ) )
{
 sleep 5;
 print "In elsif\n";
 $state = 'in child';
 
 # ... result of some processing...
  my $ok = 'success'; 
  $result = $ok ? 'success' : 'failure';
 exit 7;
}
else
{
 die "Error in fork: $!\n";
}
print "Child result = $result\n";