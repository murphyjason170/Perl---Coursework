#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";

use DateTime::Format::Natural;
my $parser = DateTime::Format::Natural->new( time_zone => 'local' );

while ( my $str = prompt() )
{
  if ( my $time = $parser->parse_datetime( $str ) and $parser->success )
  {
    print "$str => $time\n";
  }
  else
  {
    warn "Unable to parse '$str\n";
  }
}

sub prompt
{
  my $line;
  {
    print "Enter a date (q to quit): ";
    chomp( $line = <STDIN> );
    redo unless length $line;
    exit if lc $line eq 'q';
  }
  return $line;
}

__END__
-head1 NAME

parsedate - Demonstration of L<DateTime::Format::Natural> date parsing.

=head1 USAGE
	./parsedate.pl
	Enter a date (q to quit): 2 weeks from now
	2 weeks from now => 2011-05-18T20:43:09

=head1 DESCRIPTION

This program was written as a demonstration of
L<DateTime::Format::Natural> date parsing for the
less on timestamps in the O'Reilly School of Technology
B<Applied Perl> course.

The C<parse_datetime> method is used to parse timestamps
of almost arbitrary format.

=head1 AUTHOR

Written by I<Jason Murphy>.

=head1 DEPENDENCIES

L<DateTime::Format::Natural>.

=head1 LICENSE AND COPYRIGHT

This section describes the license that applies
to your code. Whenever you release anything for
the world at large to use you need to tell them
under what terms they are permitted to use it,
modify it, incorporate it in commercial products,
or redistribute it.

=cut


