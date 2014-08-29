#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";
use HTML::TableParser;
use WWW::Mechanize;

my $URL = 'http://perlcourse.ecorp.net/oscon-mirror/';

my $mech = WWW::Mechanize->new;
$mech->get( $URL );

my @reqs = ( { 
		cols => qr/Portland/, 
		hdr => \&hdr, 
		row => \&row 
	     } );
my %opts = ( DecodeNBSP => 1, Trim => 1, Chomp => 1, MultiMatch => 1 );
my $tp = HTML::TableParser->new( \@reqs, \%opts );
$tp->parse( $mech->content );

my @Rooms;

sub hdr
{
  my (undef, undef, $cols) = @_;
  # @$cols contains room names right before we get to session content
  @Rooms = @$cols;
}

sub row
{
  my ( undef, undef, $cols )  = @_;
  for my $index ( 0 .. $#$cols )
  {
    next unless $cols->[$index] =~ /Peter Scott/;
    print "Found course author at $cols->[0] in $Rooms[$index]\n";
  }
}

