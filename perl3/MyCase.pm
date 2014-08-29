package MyCase;
use strict;
use warnings;

sub TIEHASH
{
  return bless { original_key => {}, value => {} }, shift;
}

sub FETCH
{
  my ($self, $key) = @_;
  
  my $original_key = $self->{original_key}{lc $key} or return;
  return $self->{value}{$original_key};
}

sub STORE
{
  my ($self, $key, $value) = @_;
  
  my $store_key = lc $key;
  my $actual_key = $key;
  if ( exists $self->{original_key}{$store_key} )
  {
    $actual_key = $self->{original_key}{$store_key};
  }
  else
  {
    $self->{original_key}{$store_key} = $key;
  }
  return $self->{value}{$actual_key} = $value;
}

1;
