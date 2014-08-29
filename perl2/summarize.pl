#!/usr/bin/perl
use strict;
use warnings;

my $artist;
my $song_title;
 
my $line;
my $song_length = 0;
my $song_genre;

# The Hash which will hold the artist as the key, the song length total as the value
my %song_running_length_hash;
  
while (<>)
{  
	my ($discard1, $discard2, $discard3, $discard4, $the_rest) = split "/", $ARGV, 5;
	  
	($artist, $song_title) = split "-", $the_rest, 2; 

	if ( exists $song_running_length_hash{$artist} ) {    
		$line = $_;		
		($song_title, $song_length, $song_genre) = split ":", $line, 3;  
        
		$song_running_length_hash{$artist} += $song_length;
	}
	else {
		$line = $_;		
		($song_title, $song_length, $song_genre) = split ":", $line, 3;  
		$song_running_length_hash{$artist} = $song_length;
	}
}

foreach my $current (keys %song_running_length_hash)
{
	print $current . " has a total of " . $song_running_length_hash{$current} . " in music\n";
}

