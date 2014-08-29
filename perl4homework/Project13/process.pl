#!/usr/local/bin/perl
use strict;
use warnings;
use lib "$ENV{HOME}/mylib/lib/perl5";
use WWW::Mechanize;


use Socket;
use IO::Handle;


socketpair(CHILD, PARENT, AF_UNIX, SOCK_STREAM, PF_UNSPEC)
  ||  
die "socketpair: $!";

CHILD->autoflush(1);
PARENT->autoflush(1);

my $html_code;

my $pid = fork;

# Parent
if ($pid)		
{
  my $html_code_parent;
  my $pid_found = wait;

  die "wait error" if $pid_found < 0;
  
  die "Found a different child process $pid_found!" if $pid_found != $pid;
    local $SIG{CHLD} = sub {
  	print "In handler, calling wait\n";
  	my $pid_found = wait;
  	die "wait error" if $pid_found < 0;
  	die "Found a different child process $pid_found!" if $pid_found != $pid;
  	printf "Child exited with code $? (%x) = %d\n", $?, $? >> 8;
  };	

  chomp($html_code_parent = <CHILD>);

  print "Code = $html_code_parent\n";
}
# Child
elsif ( defined( $pid ) ) 	
{
  my $html_code_child;
  my $URL = 'http://perlcourse.ecorp.net/oscon-mirror/';
  my $mech = WWW::Mechanize->new;

  $mech->get( $URL );
  
  # Put the status code into the scalar
  $html_code_child = $mech->status();
  print PARENT "$html_code_child\n";
 
  exit 7;
}
else
{
  die "Error in fork: $!\n";
}

