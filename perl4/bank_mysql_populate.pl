#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use DBI;
use MySQL_Common qw( $USER $PASS $SERVER $DB );

my $CUSTOMER_ID = 1000;
my $ACCOUNT_NUM = 10000;
my $TRANSACTION_ID = 10;

my $dbh = DBI->connect( "dbi:mysql:database=$DB;host=$SERVER", $USER, $PASS );

my %Person = ( 
		me 	=> { first_name => 'Peter', last_name => 'Scott' },
		wife 	=> { first_name => 'Grace', last_name => 'Scott' }
	);
	
my %Person_id;

$Person_id{$_} =  create_person( $Person{$_} ) for keys %Person;

my $own 	= create_account( persons => [ 'me'	], balance => 1000 );
my $joint 	= create_account( persons => [ 'me', 'wife' ], balance => 5000 );

add_transaction( $own, 	 credit => 100 );
add_transaction( $joint, debit  => 200 );

sub create_person
{
  my %spec = %{ shift() };
  
  $dbh->do( 'INSERT INTO person (first_name, last_name) VALUES (?,?)',
             undef, @spec{qw(first_name last_name) } );
  return $dbh->{mysql_insertid};
}
 	

sub create_account
{
  my %spec = @_;
  
  my @owners    = @{ $spec{persons} };
  my @owner_ids = @Person_id{ @owners };
  $dbh->do( 'INSERT INTO customers (id, person_id) VALUES (?,?)',
            undef, $CUSTOMER_ID, $_) for @owner_ids;
  my $sql = <<'EOSQL';
INSERT INTO account (account_number, customers_id, balance, transactions_id)
             VALUES (?,?,?,?)
EOSQL
  $dbh->do( $sql, undef, $ACCOUNT_NUM++, $CUSTOMER_ID++, $spec{balance},
          $TRANSACTION_ID++ );
  return $dbh->{mysql_insertid};
}


sub add_transaction
{
  my ($acct_id, $type, $amount) = @_;
  
  my $sql = 'SELECT id FROM transaction_type WHERE name = ?';
  my ($transaction_type_id) = $dbh->selectrow_array( $sql, undef, $type );
  $sql = 'SELECT balance, transactions_id FROM account WHERE id = ?';
  my ($previous_balance, $acct_trans_id) = $dbh->selectrow_array( $sql, undef, $acct_id );
  my $new_balance = $previous_balance + ($type eq 'credit' ? 1 : -1) * $amount;
  $sql = <<'EOSQL';
    INSERT INTO single_transaction
     (amount, transaction_type_id, previous_balance, new_balance)
    VALUES (?,?,?,?)
EOSQL
  $dbh->do( $sql, undef, $amount, $transaction_type_id, $previous_balance,
                         $new_balance );
  my $this_trans_id = $dbh->{mysql_insertid};
  $dbh->do( 'INSERT INTO transactions (id, single_transaction_id) VALUES (?,?)', undef,
            $acct_trans_id, $this_trans_id );
  $dbh->do( 'UPDATE account SET balance = ? WHERE id = ?', undef,
             $new_balance, $acct_id );
}