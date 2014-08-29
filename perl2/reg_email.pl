#!/usr/bin/perl
use strict;
use warnings;

while ( defined ( my $line = <DATA> ) )
{
	chomp $line;
	print "'$line' contains an email address\n"
		if $line =~ s/\w+\@\w+\.\w\w\w/******/;
	
}

__END__
From: peter@psdt.com
To: scott@oreilly.com
Subject: Intermediate Perl lessons
Cc: president@whitehouse.ogv

Hi Scott! I've just uploaded the latest course content for the
Intermediate Perl Course. Barack, I think you'll have fun
with the regular expression lessons. By the way, can we use
your private address of yeswecan2008@h0tmail.com for all 
future correspondence? We're having trouble getting past
the government spam filters. We don't have any problem reaching,
for instance, fred@slateco.ccc, or 
wilma@bedrock.edu . Thanks!


