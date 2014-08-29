package Bank;
use strict;
use warnings;

use base 'Class::DBI';

use Cwd;

my ($USER) = (cwd() =~ m!/.*?/(.*?)/!);
my $PASSWORD = 'bond007';   # XXX  Change to your password
my $SERVER   = 'sql';

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

__PACKAGE__->table( 'account' );
__PACKAGE__->columns( All => qw(id account_number balance) );
__PACKAGE__->has_many( owners => [ 'Bank::Customer' => 'person' ] );
__PACKAGE__->has_many( transactions => [ 'Bank::Transactions' => 'single_transaction' ] );
__PACKAGE__->autoupdate( 1 );


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