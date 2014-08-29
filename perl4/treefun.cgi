#!/usr/local/bin/perl
use strict;
use warnings;

use lib "../mylib/lib/perl5";
use CGI qw(header);
use HTML::TreeBuilder;
use LWP::Simple;

# my $SOURCE = 'http://perlcourse.ecorp.net/ost-mirror/courses/index.html';
my $SOURCE = 'http://www.surfermag.com';

my $tree = HTML::TreeBuilder->new;
$tree->parse( get ( $SOURCE ) );
print header, $tree->as_HTML;



