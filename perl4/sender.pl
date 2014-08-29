#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";
use Email::Sender::Simple;
use Email::Simple;
use Email::Simple::Creator;
use Sys::Hostname;

print "Enter your email address: ";
chomp( my $to = <STDIN> );
my $user = $ENV{USER};
my $gecos = (getpwnam $user)[6];
my $from = "$user\@" . hostname();
my $email = Email::Simple->create(
	header => [
		To	=>	qq{"$gecos" <$to>},
		From	=>	qq{"$gecos" <$from>},
		Subject =>	qq{"Welcome to the next level",
	],
	body => "Congratulations, you're now sending mail with Perl modules!\n";
	);
	
Email::Sender::Simple->send( $email );





