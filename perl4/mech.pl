#!/usr/local/bin/perl
use strict;
use warnings;
 
use lib qw(/users/jmurphy3/mylib/lib/perl5);
use WWW::Mechanize;

# Create a mechanize object named $mech
my $mech = WWW::Mechanize->new;

# $me gets set to jmurphy3
my $me = $ENV{USER};

# $mech  scrapes for a web file
$mech->get( "http://$me.oreillystudent.com/perl4/atm_select.cgi" );

# $mech  test for success. If not succesful die out with a response message
$mech->success or die $mech->res->message;

# Set the $content to the web page that mech scraped
my $content = $mech->content;

# In the $content if the string literal ‘Account Number:’ isn’t there then die out
$content =~ /Account number:/ or die "Page contents mismatch";

# In $content scrape for the REGEX below - save the $1 var and print out a customized message
$content =~ /First Bank of (.*?)</ and print "Ready to log on to <$1>!\n";