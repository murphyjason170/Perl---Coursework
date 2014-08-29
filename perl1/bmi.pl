#!/usr/bin/perl
use strict;
use warnings;

my $b_m_i = 23.4;

if ( $b_m_i < 18.5)
{
	print "Underweight\n";
}
elsif ( $b_m_i >= 18.5 && $b_m_i < 25 )
{
	print "Normal\n";
}
elsif ( $b_m_i >= 25 && $b_m_i < 30 )
{
	print "Overweight\n";
}
elsif ($b_m_i > 30 )
{
	print "Obese\n";
}
else
{
	print "This shouldn't happen!!!\n";
}
