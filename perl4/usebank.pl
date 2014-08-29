#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);


use CheckingAccount;
use SavingsAccount;

my $regular   = CheckingAccount->new( balance => 1000 );
my $piggybank = SavingsAccount->new( balance => 5000 );


$regular->write_check( "Greenpeace" => 250 );
$regular->write_check( "O'Reilly", 395 );
$regular->transfer( 100, $piggybank );
print $regular->statement;
print "\n";

$piggybank->add_interest;
print $piggybank->statement;
