#!/usr/local/bin/perl
use strict;
use warnings;

print "Before fork\n";

my $pid = fork;
if ( $pid )			# Parent
{
  print "Parent forked child process $pid\n";
  for ( my $count = 10000000; $count; $count-- )
  {
    print "Parent ($$) $count\n";
    # sleep 1;
  }
}
elsif ( defined( $pid ))	# Child
{
  sleep 2;
  print "Exec-ing external program\n";
  exec "uname -a";
  die "Exec failed: $!\n";
}
else
{
  die "Error in fork: $!\n";
}

print "Done\n";


