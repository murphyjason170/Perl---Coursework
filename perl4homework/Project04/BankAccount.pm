package BankAccount;
use strict;
use warnings;
use POSIX qw(strftime);

{
  my $NEXT_ACCTNO = 10001;
  sub next_acctno
  {
    return $NEXT_ACCTNO++;
  }
}

my %Instance_Data;

sub new
{
  my ($class, %attr) = @_;
  my $ref = \my $dummy;

  bless $ref, $class;
  $ref->account_number( $class->next_acctno);
  $ref->transactions( [] );
  $ref->$_( $attr{$_} ) for keys %attr;
  
  # bless $ref, $class;
  return $ref;
}

BEGIN
{
  sub create_method
  {
    no strict 'refs';
    my ($class, $method) = @_;
    
    *$method = sub {
      my $self = shift;
      
    $Instance_Data{$method}{$self} = shift if @_;
    return $Instance_Data{$method}{$self};
     };
  }
  
  for my $method( qw(balance account_number transactions) )
  {
    __PACKAGE__->create_method( $method );
  }
}

sub DESTROY
{
  my $self = shift;
  delete $Instance_Data{$_}{$self} for keys %Instance_Data;
}


sub transact
{
  my ($self, $type, $amount) = @_;
  
  my %transaction = ( date => time, type => $type, amount => $amount );
  push @{ $self->transactions}, \%transaction;
  $self->balance( $self->balance + $amount );
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
  
  my $str = '';
  for my $trans ( @{ $self->transactions } )
  {
    my ($time, $type, $amount) = @{$trans}{qw(date type amount)};
    $str .= strftime( "%d-%b-%Y", localtime $time ) . "\t$type\t$amount\n";
  }
  $self->transactions([]);
  return $str;
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