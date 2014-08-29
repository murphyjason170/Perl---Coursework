#!/usr/bin/perl
use strict;
use warnings;

my $bignum = 7893420000;
my $nice_form = number_suffix($bignum);
print "$bignum = $nice_form\n";

$bignum = 2643400000000;
print "$bignum = ", number_suffix($bignum), "\n";

$bignum = 3460000000000000;
number_suffix($bignum);

number_suffix();

sub number_suffix
{
	unless ( @_ )
	{
		die "number_suffix needs an argument\n";
	}

	my $n = shift;
	
	my $suffix = '';
	my @threshold = ( K => 1E3, M => 1E6, G=> 1E9, T=> 1E12 );
	
	while ( my $divisor = pop @threshold)
	{
		my $l = pop @threshold;
		unless ( $n >= $divisor )
		{
			next;
		}
		$n /= $divisor;
		$suffix = $l;
		last;
	}
	
	if ( wantarray )
	{
		return ($n, $suffix);
	}
	elsif ( defined( wantarray ) )
	{
		return "$n $suffix";
	}
	else
	{
		print "$n, $suffix\n";
	}	
}
