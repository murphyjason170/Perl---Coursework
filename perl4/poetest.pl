#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";
use POE qw(Wheel::FollowTail);

my $file = shift or die "Usage: $0 <file>\n";
# {  open my $fh, '<', $file or die "Cannot open $file: $!\n"; }

POE::Session->create(
  inline_states => {
    _start => sub {
      $_[HEAP]{tailer} = POE::Wheel::FollowTail->new(
        Filename 	=> $_[ARG0],
        InputEvent 	=> 'handle_input',
        ErrorEvent	=> 'handle_error',
        SeekBack	=> 0,
      );
    },
    handle_input => sub { print "Input: $_[ARG0]\n" },
    handle_error => sub { warn shift },
  },
  args => [$file],
);

$poe_kernel->run();


