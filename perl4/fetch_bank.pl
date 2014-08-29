#!/usr/local/bin/perl
use strict;
use warnings;
 
use lib qw(/users/jmurphy3/mylib/lib/perl5);
use WWW::Mechanize;

my $mech = WWW::Mechanize->new;

my $me = $ENV{USER};
$mech->get( "http://$me.oreillystudent.com/perl4/atm_select.cgi" );
$mech->success or die $mech->res->message;
my $content = $mech->content;
$content =~ /Account number:/ or die "Page contents mismatch";
$content =~ /First Bank of (.*?)</ and print "Ready to log on to <$1>!\n";

$mech->set_visible(10001);
$mech->submit->is_success or die $mech->res->message;

for ($content = $mech->content )
{
  s/<.*?>/ /g;
  s/\s+/ /g;
  s/(.{1,65})\s/$1\n/g;
  print;
}
