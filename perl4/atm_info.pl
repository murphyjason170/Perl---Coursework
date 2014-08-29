#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use HTML::Template;

my $template = HTML::Template->new( filename => "atm_info.tmpl" );
$template->param( account_number => 10001,
                  single_owner => 'Richie Rich',
                  balance => 450_000 );
print $template->output;

print "\n-------------------\n\n";

$template = HTML::Template->new( filename => "atm_info.tmpl" );
$template->param( account_number => 10002,
                  owner_loop => [ { owner => 'Orphan Annie' },
                                  { owner => 'Sandy',
                                    last => 1 } ],
                  balance => 50 );
print $template->output;