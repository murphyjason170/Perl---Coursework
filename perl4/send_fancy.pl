#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";
use Email::Stuff;
use LWP::Simple;
use HTML::TreeBuilder;
use Sys::Hostname;

print "Enter your email address: ";
chomp( my $to = <STDIN> );
my $from	= "$ENV{USER}\@" . hostname();
my $subject	= 'Multimedia email test from Perl 4 course';
my $text 	= <<"EOT";
This is the text part of the message. Your mail reader may not
even show it to you until you explicitly request it
EOT

my $url = 'http://perlcourse.ecorp.net/ost-mirror/courses/index.html';
my $tree = HTML::TreeBuilder->new;
$tree->parse( get( $url ));

my $target_element = $tree->look_down( _tag => 'div', class=> 'right-content' );
my $html = $target_element->as_HTML;

Email::Stuff->to( $to )
		->from( $from)
		->subject( $subject )
		->text_body( $text )
		->html_body( $html )
		->attach_file( 'illinois.jpg' )
		->send;
		