#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use DBI;

my $DBFILE = "bank.sqlite";

my $ACCOUNT_NUM = 10000;
my $dbh = DBI->connect( "dbi:SQLite:dbname=$DBFILE");

create_account( 'Richie Rich', 1000000);
create_account( 'Mr. Magoo', 50 );

sub create_account
{
  my ($owner, $balance) = @_;
  my $sql = <<'EOSQL';
  INSERT INTO account (account_number, owner, balance)
  VALUES (?,?,?)
EOSQL
  $dbh->do( $sql, undef, $ACCOUNT_NUM++, $owner, $balance );
}