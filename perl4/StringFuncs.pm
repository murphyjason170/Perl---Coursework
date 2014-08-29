package StringFuncs;

use Moose::Role;

requires 'length';

my $ONE_MINUTE = 60;

sub length_pretty
{
  my $self = shift;
  my $seconds = $self->length;
  my $minutes = int( $seconds / $ONE_MINUTE );
  return sprintf q{%d' %d"}, $minutes, $seconds % $ONE_MINUTE;
}

