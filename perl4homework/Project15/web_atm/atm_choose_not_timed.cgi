#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use CGI qw(param);

use CGI::Carp qw(fatalsToBrowser);

use MyTemplate;
use Bank;

# $account is the Bank::Account object
# $template is the MyTemplate object

# Get MyTemplate to return am existing file named atm_choose.tmpl
my $template = MyTemplate->new;

# This is the hand-off from the atm_select script - the user clicks SUBMIT in atm_select and
# The account_number is carried across and lands in this script 

################################################################
#
# Session related:
#
#
my $account_number;

if (param('account_number'))
{
  $account_number = param( 'account_number' );  
}
else
{
  my $fh_login_read;		
  my $LOGIN_FILE = 'confirmation.txt';
  open $fh_login_read, "<", $LOGIN_FILE or die "Please login!\n";
  foreach my $line (<$fh_login_read>)
  {
    chomp $line;
    $account_number = $line;
  }
  close $fh_login_read;
}
#
#
################################################################


# Go to the Bank::Acount and search against the account_number 
# Note that search is a super-class function found in Class::DBI
my ($account) = Bank::Account->search( account_number => $account_number );

# This puts into atm_choose.tmpl the owners field - as returned from the Bank::Account object
$template->param( owners => join ', ', map { $_->first_name . "-" . $_->last_name } $account->owners );

# On the template do the subsitution -  the $account->get is a super-class method in Class::DBI
$template->param( account_number => $account_number, balance => $account->get( 'balance' ) );

my @ATTRS = qw(transaction_date type amount new_balance);
my @transactions = map { my $t = $_; +{ map { $_, $t->$_ } @ATTRS } }
                       $account->transactions;

# Fill in the transaction_loop in the atm_choose template file
$template->param( transaction_loop => \@transactions );

# Print out the output to the browser
print $template->html_output;