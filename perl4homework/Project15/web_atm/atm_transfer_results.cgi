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

my $account_number_source = param( 'account_number_source' );
my $account_number_destination = param( 'account_number_destination' );

my ($account_source) = Bank::Account->search( account_number => $account_number_source );
my ($account_destination) = Bank::Account->search( account_number => $account_number_destination );

my $amount_transferred = param('amount');
##############################################################
#
# Have some fun with the accounts in here (i.e. 
#   1. Performing performing the credit/debit - NOT_COMPLETED
#   2. Logging the transaction - NOT_COMPLETED
#
$account_source->add_transaction('debit', $amount_transferred);
$account_destination->add_transaction('credit', $amount_transferred);
#
#
#
##############################################################

$template->param( owners_source => join ', ', map { $_->first_name . " " . $_->last_name } $account_source->owners );
$template->param( owners_destination => join ', ', map { $_->first_name . " " . $_->last_name } $account_destination->owners );

$template->param( account_number_source => $account_number_source, balance_source => $account_source->get( 'balance' ) );
$template->param( account_number_destination => $account_number_destination, balance_destination => $account_destination->get( 'balance' ) );

my @ATTRS_Source = qw(transaction_date type amount new_balance);
my @transactions_source = map { my $t = $_; +{ map { $_, $t->$_ } @ATTRS_Source } }
                       $account_source->transactions;
$template->param( transaction_loop => \@transactions_source );


my @ATTRS_Destination = qw(transaction_date type amount new_balance);
my @transactions_destination = map { my $t = $_; +{ map { $_, $t->$_ } @ATTRS_Destination } }
                       $account_destination->transactions;
$template->param( transaction_loop => \@transactions_destination );



# Print out the output to the browser
print $template->html_output;


=head1 NAME

   atm_transfer_results.cgi file

=head1 USAGE

   Point browser at: http://jmurphy3.userworld.com/perl4homework/Project15/web_atm/atm_login.cgi
   On the main menu click Bank Teller Functions
   Then click Transfer Between Accounts
   This file will then trigger on the submit
      
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