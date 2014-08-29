#!/usr/bin/perl
use strict;
use warnings;

my $day_ref = make_day_ref('German');

print "Der dritte tag der woche ist $$day_ref[3]\n";

sub make_day_ref
{
	my $language = shift;
	
	if ( $language eq 'English' )
	{
		return qw[(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)];
	}
	elsif ( $language eq 'French')
	{
		return [qw(Dimanche Lundi Mardi Mercredi Jeudi Vendredi Samedi)];
	}
	elsif ( $language eq 'German')
	{
		return [qw(Sonntag Montag Dienstag Mittwoch Donnerstag Freitag Samstag)];
	}
	else
	{
		die "Unrecognized language $language";
	}
}