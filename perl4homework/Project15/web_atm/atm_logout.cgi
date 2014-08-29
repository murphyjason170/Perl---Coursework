#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use CGI qw(:all);
use CGI qw/:standard -debug/;

use CGI::Carp qw(fatalsToBrowser);

use MyTemplate;
use Date::Parse;
use Bank;

my $template = MyTemplate->new;

unlink glob "confirmation.txt";

print $template->html_output;


__END__

=head1 NAME

   atm_logout.cgi file

=head1 USAGE

   Point browser at: http://jmurphy3.userworld.com/perl4homework/Project15/web_atm/atm_login.cgi
   Click logout on the main menu and this file will be triggered.   

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











