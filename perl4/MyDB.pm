package MyDB;
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use DBI;
use Cwd;

my ($USER) = (cwd() =~ m!/.*?/(.*?)/!);
my $PASS =  'bond007';
my $SERVER = 'sql';
my $DB = $USER;

my $dbh = DBI->connect( "dbi:mysql:database=$DB;host=$SERVER", $USER, $PASS );

sub get_accounts
{
  my $ar = $dbh->selectall_arrayref( 'SELECT * FROM account', { Slice => {} } );
  return @$ar;
}

sub get_account
{
  my $acct_num = pop;
  
  my $ar = $dbh->selectall_arrayref( 'SELECT * FROM account WHERE account_number = ?', { Slice => {} }, $acct_num );
  my ($account) = @$ar;
  my @transactions = get_transactions( $account->{transactions_id} );
  $account->{transactions} = [ map { { line => $_ } } @transactions ];
  $account->{owners} = get_owners( $account->{customers_id} );
  return $account;
}


sub get_owners
{
  my $customers_id = shift;
  
  my $sql = <<'EOSQL';
    SELECT CONCAT(p.first_name, ' ', p.last_name)
      FROM person p
      JOIN customers c ON p.id = c.person_id
     WHERE c.id =?
EOSQL
  my $ar = $dbh->selectcol_arrayref( $sql, undef, $customers_id );
  return join ', ' => @$ar;
}


sub get_transactions
{
  my $transactions_id = shift;
  
  my $sql = <<'EOSQL';
    SELECT s.transaction_date, type.name, s.amount, s.new_balance
      FROM transactions t
      JOIN single_transaction s ON t.single_transaction_id = s.id
      JOIN transaction_type type ON s.transaction_type_id = type.id
     WHERE t.id = ?
EOSQL
  my $ar = $dbh->selectall_arrayref( $sql, undef, $transactions_id );
  my @lines;
  for ( @$ar )
  {
    my ($date, $type, $amount, $new_balance) = @$_;
    push @lines, "$date\t$type\t$amount\t$new_balance";
  }
  return @lines;
}


1;

