#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use CGI::Carp qw(fatalsToBrowser);

use MyTemplate;
use Bank;

my $template = MyTemplate->new;

# Source Stuff
my @acct_nums_source = map { $_->get( 'account_number' ) } Bank::Account->retrieve_all;
$template->param( account_loop_source => [ map { { account_number_source => $_ } } @acct_nums_source ] );

# Destination Stuff
my @acct_nums_destination = map { $_->get( 'account_number' ) } Bank::Account->retrieve_all;
$template->param( account_loop_destination => [ map { { account_number_destination => $_ } } @acct_nums_destination ] );

print $template->html_output;

=head1 NAME

   atm_transfer.cgi file

=head1 USAGE

   Point browser at: http://jmurphy3.userworld.com/perl4homework/Project15/web_atm/atm_login.cgi
   On the main menu click Bank Teller Functions
   Then click Transfer Between Accounts
   
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