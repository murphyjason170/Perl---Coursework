#!/usr/bin/perl

use strict;
use warnings;

my $DATA_FILE = '>songs.data';

my $fh;
# if ( open $fh, '>', $DATA_FILE )
if (open ($fh, $DATA_FILE) ) 
{ 
  print {$fh} qq{2'02" Sgt. Pepper's Lonely Hearts Club Band\n};
  print {$fh} qq{2'44" With A Little Help From My Friends\n};
  print {$fh} qq{3'29" Lucy In The Sky With Diamonds\n};
  # close $fh;
}
else
{
  die "Couldn't open $DATA_FILE: $!\n";
}
