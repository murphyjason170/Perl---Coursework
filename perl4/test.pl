#!/usr/local/bin/perl
use HTML::Template;

my $template = HTML::Template->new(filename => 'test.tmpl');

$template->param(HOME => $ENV{HOME});
$template->param(PATH => $ENV{PATH});

print "Content-Type: text/html\n\n", $template->output;

