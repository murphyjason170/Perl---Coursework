package Bank;
use strict;
use warnings;
use Data::Dumper;


# Move the code between the sleep and the exit calls from atm_timed.cgi 
# to a method add_transaction in Bank::Account such that the code in 
# atm_timed.cgi can be replaced with the following and still work:

# Code Fragment
# sleep $to_sleep;
# my ($account) = Bank::Account->search( account_number => $account_number );
# $account->add_transaction( $type, $amount );
# exit;

# Next, insert code in the add_transaction method that will email you if the 
# balance on an account drops below zero. You can hard-code your email address in.


use CGI::Carp qw(fatalsToBrowser);

use base 'Class::DBI';

# Class::DBI Documentation
# http://search.cpan.org/~tmtm/Class-DBI-v3.0.17/lib/Class/DBI.pm#retrieve_all

# ------------------------------
# Available Class::DBI functions:
# ------------------------------

# insert()  		insert new data into the database and create an object representing the newly inserted row
# find_or_create()  	checks if something can be found to match the information passed, and if not inserts it.
# delete()		Deletes this object from the database and from memory
# retrieve()		Given key values it will retrieve the object with that key from the database
# retrieve_all()	Retrieves objects for all rows in the database.
# search()		simple search for all objects where the columns specified are equal to the values specifie
#
# get()
# 	$value = $obj->get($column_name);
#	@values = $obj->get(@column_names);

#

use Cwd;

my ($USER) = (cwd() =~ m!/.*?/(.*?)/!);
my $PASSWORD = 'bond007';   # XXX  Change to your password
my $SERVER   = 'sql';

# This sets up a database connection with the given information
#					      jmurphy3   sql     jmurphy3  bond007
__PACKAGE__->connection( "dbi:mysql:database=$USER;host=$SERVER", $USER, $PASSWORD );

package Bank::Account;


use base 'Bank';
#mysql> describe account;
# +----------------+---------+------+-----+---------+----------------+
# | Field          | Type    | Null | Key | Default | Extra          |
# +----------------+---------+------+-----+---------+----------------+
# | id             | int(11) | NO   | PRI | NULL    | auto_increment |
# | account_number | int(11) | YES  |     | NULL    |                |
# | balance        | double  | YES  |     | NULL    |                |
# +----------------+---------+------+-----+---------+----------------+

# mysql> select * from account;
# +----+----------------+---------+
# | id | account_number | balance |
# +----+----------------+---------+
# |  1 |          10001 |   15400 |
# |  2 |          10002 |    5200 |
# +----+----------------+---------+

# Class::DBI isn't very smart it is as if it can't see the database without
# you telling it what is there:

# This tells Class::DBI what table you are using for this class
__PACKAGE__->table( 'account' );

# This tells Class::DBI the structure of your table listing the primary key first
__PACKAGE__->columns( All => qw(id account_number balance) );

#
__PACKAGE__->has_many( owners => [ 'Bank::Customer' => 'person' ] );
__PACKAGE__->has_many( transactions => [ 'Bank::Transactions' => 'single_transaction' ] );
 
# Turn autoupdating on for this object.
# Each accessor call causes the new value to immediately be written.
 __PACKAGE__->autoupdate( 1 );


sub add_transaction
{

  my $self = shift;
  my $account = $self->id; 
  my $account_number = $self->account_number;
    
  my $type =  shift;
  my $amount = shift;

   
  # Get the balance and store it 
  # ORIG: my $balance = $account->get( 'balance' );
  # 
  my $balance = $self->balance;
   
  # Searches the database for the type as being a valid type 
  # ORIG: my ($trans_type) = Bank::Transaction::Type->search( name => $type );
  my ($trans_type) = Bank::Transaction::Type->search( name => $type );
  
  # This is the math to calculate what the new_balance will be:
  # ORIG: my $new_balance = $balance + ($type eq 'credit' ? 1 : -1) * $amount;
  my $new_balance = $balance + ($type eq 'credit' ? 1 : -1) * $amount;
  
  # Insert the transaction into the single_transaction table
  # Note: 'insert' is a superclass Class::DBI function
  my $single_trans = Bank::Transaction::Single->insert( 
  				     { 
  					amount => $amount,
                                    	transaction_type => $trans_type,
                                     	previous_balance => $balance,
                                    	new_balance => $new_balance,
                                     } );
                                 
  # Insert the single_transaction and account binding into the transactions table
  Bank::Transactions->insert( 
   				{ 
   				single_transaction => $single_trans,
                                account => $account,
                             	} 
                            );
                                    
   # ORIG: $account->set( balance => $new_balance );
   $self->set(balance => $new_balance);

   #==========================================================
   #
   # Email fun:
   #
   my $temp_balance = $self->get('balance');
   
   if ($temp_balance < 0)
   {
     my $to = 'jmurphy72@yahoo.com';
     my $from = 'jmurphy3@useractive.com';   
     my $msg = join '', <DATA>;			# put the message together - go to __END__ to see the data
     $msg = eval qq{"$msg"};			# Evaluate and do the variable replacements

     open my $fh, "|-", "sendmail -t" or die "Can't pipe to sendmail: $!\n";
     # print {$fh} $msg;
     print {$fh} ("From: $from\n");
     print {$fh} ("To: $to\n");
     print {$fh} ("Subject: Your balance has dropped sub-zero\n");
     print {$fh} ("\n");
     print {$fh} ("Your balance is sub-zero\n");
   }
   #
   #
   #
   #==========================================================

}



package Bank::Customer;
use base 'Bank';
# mysql> describe customer
# +---------+---------+------+-----+---------+-------+
# | Field   | Type    | Null | Key | Default | Extra |
# +---------+---------+------+-----+---------+-------+
# | account | int(11) | YES  |     | NULL    |       |
# | person  | int(11) | YES  |     | NULL    |       |
# +---------+---------+------+-----+---------+-------+

# mysql> select * from customer;
# +---------+--------+
# | account | person |
# +---------+--------+
# |       1 |      1 |
# |       1 |      2 |
# |       2 |      3 |
# +---------+--------+

__PACKAGE__->table( 'customer' );
__PACKAGE__->columns( Primary => qw(account person) );
__PACKAGE__->has_a( person => 'Bank::Person' );
__PACKAGE__->has_a( account => 'Bank::Account' );


package Bank::Person;
use base 'Bank';
# mysql> describe person;
# +------------+---------+------+-----+---------+----------------+
# | Field      | Type    | Null | Key | Default | Extra          |
# +------------+---------+------+-----+---------+----------------+
# | id         | int(11) | NO   | PRI | NULL    | auto_increment |
# | first_name | text    | YES  |     | NULL    |                |
# | last_name  | text    | YES  |     | NULL    |                |
# +------------+---------+------+-----+---------+----------------+

# mysql> select * from person;
# +----+------------+-----------+
# | id | first_name | last_name |
# +----+------------+-----------+
# |  1 | Emily      | Dickinson |
# |  2 | Robert     | Frost     |
# |  3 | Walt       | Whitman   |
# +----+------------+-----------+
__PACKAGE__->table( 'person' );
__PACKAGE__->columns( All => qw(id first_name last_name) );
__PACKAGE__->has_many( accounts => [ 'Bank::Customer' => 'account' ] );


package Bank::Transactions;
use base 'Bank';
# mysql> describe transactions;
# +--------------------+---------+------+-----+---------+-------+
# | Field              | Type    | Null | Key | Default | Extra |
# +--------------------+---------+------+-----+---------+-------+
# | account            | int(11) | YES  |     | NULL    |       |
# | single_transaction | int(11) | YES  |     | NULL    |       |
# +--------------------+---------+------+-----+---------+-------+

# mysql> select * from transactions;
# +---------+--------------------+
# | account | single_transaction |
# +---------+--------------------+
# |       1 |                  1 |
# |       2 |                  2 |
# |       1 |                  3 |
# |       2 |                  4 |
# +---------+--------------------+

__PACKAGE__->table( 'transactions' );
__PACKAGE__->columns( Primary => qw(account single_transaction) );
__PACKAGE__->has_a( single_transaction => 'Bank::Transaction::Single' );
__PACKAGE__->has_a( account => 'Bank::Account' );


package Bank::Transaction::Single;
use base 'Bank';
# mysql> describe single_transaction;
# +------------------+-----------+------+-----+-------------------+----------------+
# | Field            | Type      | Null | Key | Default           | Extra          |
# +------------------+-----------+------+-----+-------------------+----------------+
# | id               | int(11)   | NO   | PRI | NULL              | auto_increment |
# | amount           | double    | YES  |     | NULL              |                |
# | transaction_type | int(11)   | YES  |     | NULL              |                |
# | previous_balance | double    | YES  |     | NULL              |                |
# | new_balance      | double    | YES  |     | NULL              |                |
# | transaction_date | timestamp | NO   |     | CURRENT_TIMESTAMP |                |
# +------------------+-----------+------+-----+-------------------+----------------+

# mysql> select * from single_transaction;
# +----+--------+------------------+------------------+-------------+---------------------+
# | id | amount | transaction_type | previous_balance | new_balance | transaction_date    |
# +----+--------+------------------+------------------+-------------+---------------------+
# |  1 |    100 |                1 |            10000 |       10100 | 2011-04-04 00:00:00 |
# |  2 |    200 |                2 |             5000 |        4800 | 2011-04-05 00:00:00 |
# |  3 |    300 |                1 |            10100 |       10400 | 2011-05-01 00:00:00 |
# |  4 |    400 |                1 |             4800 |        5200 | 2011-04-06 00:00:00 |
# +----+--------+------------------+------------------+-------------+------
                                    	
__PACKAGE__->table( 'single_transaction' );
__PACKAGE__->columns( All => qw(id amount transaction_type previous_balance new_balance transaction_date) );
__PACKAGE__->has_a( transaction_type => 'Bank::Transaction::Type' );
__PACKAGE__->has_many( accounts => [ 'Bank::Transactions' => 'account' ] );

sub type
{
  return shift->get( 'transaction_type' )->name;
}

package Bank::Transaction::Type;

use base 'Bank';
# mysql> describe transaction_type;
# +-------+---------+------+-----+---------+----------------+
# | Field | Type    | Null | Key | Default | Extra          |
# +-------+---------+------+-----+---------+----------------+
# | id    | int(11) | NO   | PRI | NULL    | auto_increment |
# | name  | text    | YES  |     | NULL    |                |
# +-------+---------+------+-----+---------+----------------+

# mysql> select * from transaction_type;
# +----+--------+
# | id | name   |
# +----+--------+
# |  1 | credit |
# |  2 | debit  |
# +----+--------+

__PACKAGE__->table( 'transaction_type' );
__PACKAGE__->columns( All => qw(id name) );

1;

