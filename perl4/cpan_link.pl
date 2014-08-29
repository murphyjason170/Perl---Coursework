#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";
use WWW::Mechanize;

my $URL = 'http://www.cpan.org/';  # Only goes to right place from OST student machine
my $mech = WWW::Mechanize->new;
$mech->get( $URL );
my @links = $mech->find_all_links( url_regex => qr/~/ );
print $_->text, "\n" for @links;

