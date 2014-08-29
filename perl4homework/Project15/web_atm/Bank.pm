package Bank;
use strict;
use warnings;
use Data::Dumper;
use CGI::Carp qw(fatalsToBrowser);
use base 'Class::DBI';
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


my $encrypted_password;

###############################################################
#
# check_password
#
sub check_password
{
  my $self = shift;
  my $entered_password = shift;
  chomp($entered_password);
  
  # Pluck out the id for that object
  my $account_id = $self->id;
    	
  # Go into the customer table and get the person id
  my ($customer_object) = Bank::Customer->search( account => $account_id );
  my $person_id = $customer_object->person;
  
    	  	
  my ($person_object) = Bank::Person->search(id => $person_id);
  my $password_in_database = $person_object->password;

  my $encrypted_password_database = $person_object->password;

  if ($encrypted_password_database eq crypt ($entered_password, $encrypted_password_database)) 
  {
  } 
  else 
  {
  	die "Invalid Password!\n";
  }
}

#
#
###############################################################


###############################################################
#
# create_account
#
sub create_account
{
  #
  # Call from atm_create_account is Bank::Account->create_account($first_name, $last_name, $password);
  #
  my $self = shift;
  my $first_name = shift;
  my $last_name = shift;
  my $password = shift;
  chomp($password);
 
  ###########################################
  #
  # Determine an unused account ID
  #
  my @id_to_use_list = map { $_->get( 'id' ) } Bank::Account->retrieve_all;

  my $greatest_number_found = 0;

  foreach my $current (@id_to_use_list)
  {
        
  	if ($current > $greatest_number_found)
  	{
  		$greatest_number_found = $current;
  	}
  }  
    $greatest_number_found = $greatest_number_found + 1;
  my $id_to_use = $greatest_number_found;  
  
  #
  #
  ###########################################


  ###########################################
  #
  #
  # Determine an unused account_number
  my $account_number_to_use = 0;
  
  my @account_to_use_list = map { $_->get( 'account_number' ) } Bank::Account->retrieve_all;

  my $greatest_account_found = 0;

  foreach my $current_account (@account_to_use_list)
  {
        
  	if ($current_account > $greatest_account_found)
  	{
  		$greatest_account_found = $current_account;
  	}
  }  
  $greatest_account_found = $greatest_account_found + 1;

  $account_number_to_use = $greatest_account_found;  
  #
  #
  ###########################################

  
  # Create a new account:
  Bank::Account->insert(
  		{
			id => $id_to_use,
		 	account_number => $account_number_to_use,
  		 	balance => '0',
  		}
  	);
  
  
  ###########################################
  #
  #
  # Determine an unused account_number
  my $person_to_use = 0;
  
  my @person_to_use_list = map { $_->get( 'person' ) } Bank::Customer->retrieve_all;

  my $greatest_person_found = 0;

  foreach my $current_person (@person_to_use_list)
  {
        
  	if ($current_person > $greatest_person_found)
  	{
  		$greatest_person_found = $current_person;
  	}
  }  
  $greatest_person_found = $greatest_person_found + 1;
  $person_to_use = $greatest_person_found;  
  #
  #
  ###########################################
  
  # Create a new customer:
  Bank::Customer->insert(
		{
			account => $id_to_use,
  		 	person => $person_to_use,
  		 }
  	);
  
  # Create a new person:
  # Note that the id will have to increment and be unique
  
  
  # Use crypt to store the password encrypted  
  my $salt = 'zp';
  $encrypted_password = crypt $password, $salt;
  
  Bank::Person->insert(
  		{
  			id => $person_to_use,
  			first_name => $first_name,
  			last_name => $last_name,
  			password => $encrypted_password,
  		}
  	);
  return $account_number_to_use;
}



#
#
###############################################################


###############################################################
#
#
sub add_transaction
{
  my $self = shift;
  my $account = $self->id; 
  my $account_number = $self->account_number;
    
  my $type =  shift;
  my $amount = shift;

  my $balance = $self->balance;
  my ($trans_type) = Bank::Transaction::Type->search( name => $type );  
  my $new_balance = $balance + ($type eq 'credit' ? 1 : -1) * $amount;
  
  my $single_trans = Bank::Transaction::Single->insert( 
  				     { 
  					amount => $amount,
                                    	transaction_type => $trans_type,
                                     	previous_balance => $balance,
                                    	new_balance => $new_balance,
                                     } );
                                 
  Bank::Transactions->insert( 
   				{ 
   				single_transaction => $single_trans,
                                account => $account,
                             	} 
                            );
                                    
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
#
#
###############################################################


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
# +----+------------+-----------+----------+
# | id | first_name | last_name | password |
# +----+------------+-----------+----------+
# |  1 | Emily      | Dickinson | NULL     |
# |  2 | Robert     | Frost     | NULL     |
# |  3 | Walt       | Whitman   | NULL     |
# +----+------------+-----------+----------+

__PACKAGE__->table( 'person' );
# __PACKAGE__->columns( All => qw(id first_name last_name) );
__PACKAGE__->columns( All => qw(id first_name last_name password) );
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

__END__

=head1 NAME

   Bank.pm file

=head1 USAGE

   Point browser at: http://jmurphy3.userworld.com/perl4homework/Project15/web_atm/atm_login.cgi
   This is the heavy hitter of the Web ATM Application
   It functions as the go-between for the database and the CGI scripts
   
   Recommended usage is to create a Bank::Account object and then call the various
   methods. 
   
   Files in this program which make heavy use of Bank.pm (and demonstrate usage) are:
   atm_select.cgi
   atm_choose.cgi
   atm_choose_not_timed.cgi
   atm_create_account.cgi
   atm_login_confirmation.cgi
   atm_timed.cgi
   atm_timed_not.cgi
   atm_transactions.cgi
   atm_transfer.cgi
   atm_transfer_results.cgi
      
=head1 DESCRIPTION

This file is a larger part of the Web-based ATM Machine. This application
uses an SQL database for all data storage.

=head1 AUTHOR

Written by I<Jason Murphy>.

=head1 DEPENDENCIES

None

=head1 LICENSE AND COPYRIGHT

The world may use this free of charge. Enjoy!

=cut