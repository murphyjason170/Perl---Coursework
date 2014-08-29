#!/usr/bin/perl -w
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);

use HTML::Template;

use CGI::Carp qw(fatalsToBrowser);
use CGI qw(:all);

# open the html template
my $template = HTML::Template->new(filename => 'murph.tmpl');

# fill in some parameters
$template->param(HOME => $ENV{HOME});
$template->param(PATH => $ENV{PATH});

# send the obligatory Content-Type and print the template output
print "Content-Type: text/html\n\n", $template->output;