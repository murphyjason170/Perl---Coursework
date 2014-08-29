#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use DBI;

my $DBFILE = "bank.sqlite";
my $dbh = DBI->connect( "dbi:SQLite:dbname=$DBFILE" );

$dbh->do( <<'EOSQL' );
CREATE TABLE IF NOT EXISTS account (
	id 		INTEGER PRIMARY KEY,
	account_number	INTEGER,
	owner		TEXT,
	balance		DOUBLE
)
EOSQL

