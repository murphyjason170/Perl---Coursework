#!/usr/local/bin/perl
use strict;
use warnings;

print "Enter your email address: ";
chomp( my $to = <STDIN> );

chomp( my $from = "$ENV{USER}\@" . 'bigsurf' );
my $msg = join '', <DATA>;
# $msg = eval qq{"$msg"};

open my $fh, "|-", "sendmail -t" or die "Can't pipe to sendmail: $!\n";

print {$fh} $msg;

__END__
From: $from
To: $to
Subject: Email from Perl 4 Course

Hello, $ENV{USER}! Congratulations on making it this far through
the course! There's more to come!

Sincerely,

The Management.
