#!/usr/local/bin/perl
use strict;
use warnings;

use Time::Piece;
use Time::Seconds;

my $FORMAT = '%FT%T';

my $last;
while ( <DATA> )
{
  chomp;
  if ( my $tp = eval { Time::Piece->strptime( $_, $FORMAT ) } )
  {
    print "$_		=> $tp\n";
  
    if ( $last )
    {
      print $tp - $last, " seconds since $last\n";
    }
    $last = $tp;
    $tp += ONE_DAY;
    print "$_ + ONE_DAY = $tp\n";
  }
  else
  {
    warn "Unable to parse '$_'\n";
  }
}

__END__
2001-03-17T03:04:05
1999-12-31T23:59:59
2005-05-21T07:00:00
2009-02-29T12:00:00
1968-01-01T00:00:00
