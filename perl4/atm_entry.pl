#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use HTML::Template;

my $template = HTML::Template->new( filename => "first.tmpl" );
$template->param( username => $ENV{USER} );
$template->param( saying=> "Ooshee Booshee" );
print $template->output;
print "\n";