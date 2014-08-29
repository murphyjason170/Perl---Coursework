#!/usr/local/bin/perl
use strict;
use warnings;
use lib "$ENV{HOME}/mylib/lib/perl5";
use WWW::Mechanize;

# Commenting out use lib since I am writing this on my
# home machine and not on cold1
#
# use lib qw(/users/jmurphy3/mylib/lib/perl5);

my $URL = 'http://perlcourse.ecorp.net/ost-mirror/';
chomp $URL;

my $mech = WWW::Mechanize->new;

# Go to the URL 
$mech->get( $URL );
$mech->success or die $mech->res->message;

# Get the current content off the page
my $content = $mech->content;

# Follow the link for 'Contact'
$mech->follow_link( text => 'Contact' );
$mech->success or die $mech->res->message;
$content = $mech->content;

# Find the name field
my @webforms = $mech->forms();

#Examine each form 
foreach my $form (@webforms) 
{
    my @inputfields = $form->param;
    
	#Examine each input field
    foreach my $inputfield (@inputfields) {
        if($inputfield =~ /(name)/) 
		{
			$mech->set_fields( $inputfield => 'Jason Murphy');
        }
	}
}

# Click the Submit button
$mech->submit ;
die $mech ->res->status_line unless $mech ->success ;

# Set the content again post-submittal
$content = $mech->content;

# Print out the content:
my $riddle_answer;
for ($content = $mech->content )
{
  print;
  if (/<B>(.*)</)
  {
	$riddle_answer = $1;
  }
}

print "\nThe riddle answer is: $riddle_answer\n";






