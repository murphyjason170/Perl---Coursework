package CheckingAccount;

use Moose;

# 4-21-2014
use BankAccount;
our @ISA = qw(BankAccount);

my $STARTING_CHECK_NUMBER = 100;

has next_check_number => ( isa => 'Int', is => 'rw',
			   default => $STARTING_CHECK_NUMBER );

sub new
{
  my $class = shift;
  my $object = $class->SUPER::new( @_ );
  $object->{next_check_number} = $STARTING_CHECK_NUMBER;
  return $object;
}

sub write_check
{
  my ($self, $recipient, $amount) = @_;

  my $chkno = $self->issue_next_check_number;
  $self->transact( "Check #$chkno to $recipient", -$amount );
}

sub issue_next_check_number
{
  my $self = shift;
  $self->next_check_number( my $next = $self->next_check_number + 1);
  return $next;
}

1;