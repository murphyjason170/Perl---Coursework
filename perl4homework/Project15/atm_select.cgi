#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use CGI::Carp qw(fatalsToBrowser);

use MyTemplate;
use Bank;

# atm_select.cgi file as $0 is sent as MyTemplate constructor
# What is assigned back to this template is an existing file named atm_select.tmpl
my $template = MyTemplate->new;

# The Bank::Account->retrieve_all is called and mapped to the @acct_nums array
# Note that Bank::Account->retrieve_all is a superclass method from Class::DBI
# retrieve_all retrieves objects for all rows in the database
# get() is another Class::DBI method which 
my @acct_nums = map { $_->get( 'account_number' ) } Bank::Account->retrieve_all;

# The atm_select.tmpl template files params (below) get modified 
# i.e. the section 
#	<TMPL_LOOP NAME="account_loop">
#	  <TMPL_VAR NAME="account_number">
$template->param( account_loop => [ map { { account_number => $_ } } @acct_nums ] );

# Print out the html_output which now has all the substitutions completed. 
print $template->html_output;
