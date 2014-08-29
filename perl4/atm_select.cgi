#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use CGI qw(:all);
use CGI::Carp qw(fatalsToBrowser);
use HTML::Template;
use MyDB;

my $template = HTML::Template->new( filename => 'atm_select.tmpl', die_on_bad_params => 0 );
my @accounts = MyDB->get_accounts();
$template->param( account_loop => \@accounts );

print header, $template->output;
