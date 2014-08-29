#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";
use URI;

# my $page			= 'http://www.oreillyschool.com/courses/perl4/faq.html';
# my $url_relative		= '../images/camel.png';

my $page			= 'http://www.cnn.com/courses/perl4/faq.html';
my $url_relative		= '../images/ufo.png';

my $uri = URI->new( $url_relative );
print $uri->abs( $page ), "\n";
