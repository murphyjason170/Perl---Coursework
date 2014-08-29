#!/usr/local/bin/perl
use strict;
use warnings;

# File Manipulation Related
my $DATA_FILE = '/software/Perl2/songz.txt';	# This is the file we are reading in

my $DESTINATION_FILE;				# This is the file we are writing to
my $fh2;	# Destination filehandle

# Scalars related to the vars/data we are working with
my $artist = 'test';
my $song_title = 'test';
my $album_title = 'test';
my $song_length = 0;
my $song_genre = 'test';

my $line;

open my $fh, '<', $DATA_FILE or die "Couldn't open $DATA_FILE: $!\n";
while ( $line = <$fh> )
{
	chomp($line);
        
	# Split out everything with a colon delimiter. Assign all fields to unique
	# scalars in the event we want to do more stuff in the future.
	($artist, $song_title, $album_title, $song_length, $song_genre) = split ":", $line, 5; 

	# Assign to destination file name of the file - the artist dash song title
	$DESTINATION_FILE = $artist . "-" . $song_title ;
	
	# open it up and write it in this naked block
   	{
		open $fh2, '>', $DESTINATION_FILE or die "Couldn't open $DATA_FILE: $!\n";
		print {$fh2} "$album_title:$song_length:$song_genre";
		close $fh2;
	}
}
	