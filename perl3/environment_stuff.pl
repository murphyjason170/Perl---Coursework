#!/usr/bin/perl
use strict;
use warnings;

# perl -le 'my $prog = shift or die; print $_, -x "$_/$prog" ? " <-- HERE" : "" for split /:/, $ENV{PATH}' ls                                                                                                      
# /users/jmurphy3/.gemhome/bin
# /usr/local/bin
# /usr/bin
# /bin <-- HERE
# /usr/games
# /usr/local/sbin
# /usr/sbin
# /sbin

my $prog = shift or die;

my $env_string = $ENV{PATH};
my @env_array = split("[:]" , $env_string);

foreach my $current_candidate_path (@env_array)
{
	if (-x "$current_candidate_path/$prog")
	{
		print "$current_candidate_path/$prog <--HERE\n";
	}
	else
	{
		print "$current_candidate_path\n";
	
	}
}







