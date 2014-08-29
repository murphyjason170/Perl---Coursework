package TiedDir;
use strict;
use warnings;

# Replace this comment with the correct method name
sub TIEARRAY 
{
  my ($class, $dir) = @_;
  opendir my $dh, $dir or die "can't open directory: $dir: $!";  
  bless [ sort readdir $dh ], $class;
}

sub FETCH
{
  my ($self, $index) = @_;
  return $self->[$index];
}


sub FETCHSIZE 
{
  scalar @{$_[0]}
};


1;