#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use CGI qw(:all);
use CGI qw/:standard -debug/;
use CGI::Carp qw(fatalsToBrowser);
use MyTemplate;
use Bank;



my $first_name;
my $last_name;
my $password ;

# Get these params from atm_new_account.cgi
# First name needs to have at least one letter
if ( param('first_name') =~ m!\w+! )
{ 
  $first_name = param( 'first_name' );
}
else
{
  die "You must enter a first name\n";
}

if ( param('last_name') =~ m!\w+!)
{
  $last_name = param('last_name');
}
else
{
  die "You must enter a last name\n";
}

if ( param('password') =~ m!\w\w\w\w\w\w\w+!)
{
  $password = param('password');	
}	
else
{
  die "You must enter a password 7 alpha-numerics or greater\n";
}


################################################################
#
# Talk to Bank.pm
#
my $assigned_account_number = Bank::Account->create_account($first_name, $last_name, $password);


################################################################
#
# stuff to write out to the template:
#
#
# atm_select.cgi file as $0 is sent as MyTemplate constructor
# What is assigned back to this template is an existing file named atm_select.tmpl
# atm_new_account.tmpl is returned
my $template = MyTemplate->new;

$template->param( first_name => $first_name );
$template->param( last_name => $last_name );
$template->param( account_number => $assigned_account_number );

# Print out the html_output which now has all the substitutions completed. 
print $template->html_output;