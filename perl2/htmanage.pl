#!/usr/bin/perl
use strict;
use warnings;

my $input_file = '.htpasswd';

init( @ARGV );
run();

sub init
{
	my $read_filename;
	
	while ( @_ )
	{
		my $arg = shift;
		if ( $arg eq '-f')
		{
			$read_filename = 1;
		}
		elsif ( $read_filename )
		{
			$input_file = $arg;
			$read_filename = 0;
		}
	}
}

sub run
{
	if ( open my $fh, '<', $input_file )
	{
	}
	else
	{
		print "$input_file does not exist (yet)\n";
	}
}

		
		
		
		
	