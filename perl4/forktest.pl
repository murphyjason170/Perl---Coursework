#!/usr/local/bin/perl
use strict;
use warnings;

print "Before fork\n";

my $pid = fork;
if ($pid)		# Parent
{
  print "Parent forked child process $pid\n";
  local $SIG{CHLD} = sub {
  	print "In handler, calling wait\n";
  	my $pid_found = wait;
  	die "wait error" if $pid_found < 0;
  	die "Found a different child process $pid_found!" if $pid_found != $pid;
  	printf "Child exited with code $? (%x) = %d\n", $?, $? >> 8;
  };	
  
  for ( my $count = 10; $count; $count-- )
  {
    print "Parent ($$) $count\n";
    sleep 1;
  }

}
elsif ( defined( $pid ) ) 	# Child
{
  for ( my $count = 5; $count; $count--)
  {
    print "\tChild ($$) $count\n";
    sleep 1;
  }
  exit 42;
}
else
{
  die "Error in fork: $!\n";
}
print "After fork, process $$\n";
