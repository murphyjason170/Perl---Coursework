#!/usr/local/bin/perl
use strict;
use warnings;
use lib qw(/users/jmurphy3/mylib/lib/perl5);
use HTML::Template;

use CGI qw(:all);
use CGI::Carp qw(fatalsToBrowser); 

use lib qw(/users/jmurphy3/mylib/lib/perl5);

my $template = HTML::Template->new(filename => 'test.tmpl');

$template->param(HOME => $ENV{HOME});
$template->param(PATH => $ENV{PATH});

$template->param(SURFBOARD_TYPE => 'Robert August');

print "Content-Type: text/html\n\n", $template->output;