package SavingsAccount;
use strict;
use warnings;

my $Interest_Rate = 0.015;
use BankAccount;

BEGIN{ our @ISA = qw(BankAccount) }

# Change it to provide a class method, set_interest_rate, 
# that allows the caller to set the interest rate.

# Expected Output:
# cold:~/perl4homework/Project04$ ./usebank.pl
# 5100

# Call from usebank.pl on this class method
# SavingsAccount->set_interest_rate( 0.02 );
sub set_interest_rate
{
	my $discard = shift;			# shifts SavingsAccount off of @_
	my $new_interest_rate = shift;		# shifts the new user specified rate off
	$Interest_Rate = $new_interest_rate;  	# sets the interest rate
}

sub jojo
{
	my $local = @_;
	print "This is the jojo method\n";
	return;
}

sub add_interest
{
 my $self = shift;
 my $pct = $Interest_Rate * 100;
 $self->transact( "Interest at $pct%", $self->balance * $Interest_Rate );
}

1;