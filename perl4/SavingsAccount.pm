package SavingsAccount;

# Insert statements here to make this module work
use Moose;


# 4-21-2014
extends 'BankAccount';

my $Interest_Rate = 0.015;

sub set_interest_rate
{
  my $new_rate = pop or die "No rate provided";

  $Interest_Rate = $new_rate;
}

sub add_interest
{
  my $self = shift;
  my $pct = $Interest_Rate * 100;
  $self->transact( "Interest at $pct%", $self->balance * $Interest_Rate );
}

1;