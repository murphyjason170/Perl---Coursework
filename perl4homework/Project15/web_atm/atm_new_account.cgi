#!/usr/local/bin/perl
use strict;
use warnings;
use lib qw(/users/jmurphy3/mylib/lib/perl5);
use CGI::Carp qw(fatalsToBrowser);

use MyTemplate;
use Bank;

# atm_select.cgi file as $0 is sent as MyTemplate constructor
# What is assigned back to this template is an existing file named atm_select.tmpl
# atm_new_account.tmpl is returned
my $template = MyTemplate->new;

# Print out the html_output which now has all the substitutions completed. 
print $template->html_output;

__END__

=head1 NAME

   atm_new_account.cgi file

=head1 USAGE

   Point browser at: http://jmurphy3.userworld.com/perl4homework/Project15/web_atm/atm_login.cgi
   On the main menu click create new account and this file will be triggered 

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



