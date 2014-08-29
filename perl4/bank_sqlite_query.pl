#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use DBI;

my $DBFILE = "bank.sqlite";

my $dbh = DBI->connect( "dbi:SQLite:dbname=$DBFILE" );

for my $account( get_accounts() )
{
  print "Account #: $account->{account_number}\n";
  print "Owner: $account->{owner}\n";
  print "Balance: $account->{balance}\n\n";
}

sub get_accounts
{
  my $ar = $dbh->selectall_arrayref( 'SELECT * FROM account', { Slice => {} } );
  return @$ar;
}
