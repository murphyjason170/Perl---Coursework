#!/usr/bin/perl
use strict;
use warnings;

my %most_popular_scheme;
my %most_popular_servers;

while(my $line = <>){
	if ( $line =~ m!(http:|ftp:|news:|mailto:)! ) {
		$most_popular_scheme{$1}++;
	}
     
	if ( $line =~ m!//(\w+\.\w+\.\w+)/! ) {
		$most_popular_servers{$1}++;
	} 
}

print "==============================================\n";
print "The two most popular schemes are:\n";
my $i = 0;
for my $scheme ( sort { $most_popular_scheme{$b} <=> $most_popular_scheme{$a} } keys %most_popular_scheme ) {
last if $i++ > 1;
print " $scheme ( $most_popular_scheme{$scheme} )\t";
}
print "\n==============================================\n";

 
print "\n==============================================\n";
print "The two most popular servers are:\n";
my $j = 0;
for my $server ( sort { $most_popular_servers{$b} <=> $most_popular_servers{$a} } keys %most_popular_servers ){
last if $j++ > 1;
print " $server ( $most_popular_servers{$server} )\t";
}
print "\n==============================================";
print "\n";


