#!/usr/bin/perl
use strict;
use warnings;

my %first = (Wallace=>1, Gromit=>2);
my %second = (Gromit=>2, Wallace=>1);
compare( \%first, \%second);

%first  = ( Kirk => 'Captain', Spock => 'First Officer', McCoy => 'Doctor' );
%second = ( Spock => 'First Officer', McCoy => 'Doctor' );
compare( \%first, \%second );

%first  = ();
%second = ();
compare( \%first, \%second );

%first  = ( Wallace => 1, Gromit => 2 );
%second = (Wallace => 2, Gromit => 1);
compare( \%first, \%second );

%first = (Wallace => 1, Gromit => 2);
%second= (Wallace => 1, Gromit => 2, Shawn => 3);
compare( \%first, \%second );

sub compare
{
	print "Hashes are ", compare_hashes( @_ ) ? "EQUAL" : "NOT EQUAL", "\n";
}


sub compare_hashes
{
	my ($h1_ref, $h2_ref) = @_;
	
	# Unequal # of elements will return 0
	return 0 if keys %$h1_ref != keys %$h2_ref; 	
	

	for ( keys %$h1_ref )
	{
		return 0 if ! exists $h2_ref->{$_} || $h1_ref->{$_} ne $h2_ref->{$_};
	}
	return 1;
}	
	
	