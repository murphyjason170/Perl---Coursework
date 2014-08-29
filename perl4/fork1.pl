#!/usr/local/bin/perl
use strict;
use warnings;

print "Before fork\n";

my $pid = fork;
if ($pid)		# Parent
{
  print "Parent forked child process $pid\n";
  for ( my $count = 10; $count; $count-- )
  {
   # $$ prints the current process ID
    print "Parent ($$) $count\n";
    sleep 1;
  }
}
elsif ( defined( $pid ) ) 	# Child
{
  for ( my $count = 5; $count; $count--)
  {
   # $$ prints the current process ID
    print "\tChild ($$) $count\n";
    sleep 1;
  }
}
else
{
  die "Error in fork: $!\n";
}
