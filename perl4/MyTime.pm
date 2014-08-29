package MyTime;
use strict;
use warnings;

use POSIX qw(strftime);

sub TIESCALAR
{
  my ($class, $format) = @_;
  print "\$class is $class\n";
  print "\$format is $format\n";
  return bless \$format, $class;
}

sub FETCH
{
  my $self = shift;
  print "\$self is $self\n";
  print "De-reffed is $$self \n";
  return strftime $$self, localtime;
}
1;
