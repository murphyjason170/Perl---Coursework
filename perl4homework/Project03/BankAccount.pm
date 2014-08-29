	package BankAccount;
use strict;
use warnings;

use Data::Dumper;
use POSIX qw(strftime);

{
  # This is a class variable
  my $NEXT_ACCTNO = 10001;

  # This is a class method
  sub next_acctno
  {
    return $NEXT_ACCTNO++;
  }
}

sub new
{
  my ($class, %attr) = @_;
  
  # This sets the account_number by calling the class method next_acctno
  $attr{account_number} = $class->next_acctno;
  my $ref = \%attr;

  # Make it so  
  bless $ref, $class;
  return $ref;
}

sub balance
{
  # Shift off the object
  my $self = shift;

  # Set the balance IF it is in @_
  $self->{balance} = shift if @_;
  
  return $self->{balance};
}

sub owner
{
  my $self = shift;
  
  if ( @_ )
  {
  	$self->{owner} = @_ > 1 ? [ @_ ] : shift;
  }
  my $current = $self->{owner} or return;
  return ref $current ? @$current : $current;
}


sub overdraft_limit
{
	my $self = shift;
	
	if ( @_ )
	{
	  my $new_limit = shift;
	  warn "Can't have negative overdraft limit!\n" and return if $new_limit < 0;
	  $self->{overdraft_limit} = $new_limit;
	 }
	return $self->{overdraft_limit};
}


sub account_number
{
  my $self = shift;
  $self->{account_number} = shift if @_;
  
  return $self->{account_number};
}


sub transact
{
  my ($self, $type, $amount) = @_;
  my %transaction = ( date => time, type => $type, amount => $amount );
  push @{ $self->{transactions} }, \%transaction;
  $self->{balance} += $amount;
}


sub debit
{
  my ($self, $amount) = @_;
  $self->transact( debit => -$amount );
}


sub credit
{
  my ($self, $amount) = @_;
  $self->transact( credit => $amount );
}

sub transfer
{
  my ($self, $amount, $target_account) = @_;
  my $message = "Transfer to " . $target_account->account_number;
  $self->transact( $message, -$amount );
  $message = "Transfer from " . $self->account_number;
  $target_account->transact( $message, $amount );
}

sub statement
{
	my $self = shift;
		
	my $transaction_hash_ref;
		
	print "\nTransaction History for account: " . $self->account_number . "\n";
			
	# Cycle through array and get at the hash refs 
	foreach $transaction_hash_ref ( @{$self->{transactions}} )
	{
		# 1397309499
		my $epoch_date = $$transaction_hash_ref{date};

		# POSIX::strftime(fmt, sec, min, hour, mday, mon, year, wday = -1, yday = -1, isdst = -1)
		my $converted_date = strftime('%d/%m/%Y', localtime($epoch_date));
		
		# Output from $converted_date - 12/04/2014
		my ($day,$month_number,$year) = split('/', $converted_date);
	
		my @month_array = qw(Jan Feb Mar Apr May Jun Jul Aug Sept Oct Nov Dec);
		$month_number--;	
		my $final_month = $month_array[$month_number];

		# Desired date format - 29-Mar-2011						
		my $final_date = $day . "-" . $final_month . "-" . $year;	
		
		my $type = $$transaction_hash_ref{type};
		my $amount = $$transaction_hash_ref{amount};
		
		printf("%11s\t%-20s\t%10s\n", $final_date, $type, $amount); 
		
	}
	return;
}

1;

__END__

=head1 NAME

  BankAccount - class implementing a bank account

=head1 SYNOPSIS

  use BankAccount;
  my $account = BankAccount->new( <attributes> );

=head1 ATTRIBUTES

=head2 balance

The initial balance.

=head2 account_number

The account number.

=head2 owner

The name of the account owner.

=head1 METHODS

Any of the attributes may be accessed via a method of the same name,
and set by passing an argument to that method.  The following
methods are also defined:

=head2 $account->credit( <amount> )

Add I<amount> to the balance.

=head2 $account->debit( <amount> )

Subtract I<amount> from the balance.

=cut