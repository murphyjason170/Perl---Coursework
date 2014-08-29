#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use DBI;
use MySQL_Common qw( $USER $PASS $SERVER $DB);
use File::Slurp;

my $DB_FILE = 'make_db.mysql';
my $sql = read_file( $DB_FILE );
my $dbh = DBI->connect( "dbi:mysql:database=$DB;host=$SERVER", $USER, $PASS,
			{ mysql_multi_statements => 1 } );
$dbh->do( $sql );



