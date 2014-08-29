#!/usr/bin/perl
use lib "$ENV{HOME}/mylib/lib/perl5";
use strict;
use HTML::Tree;
use LWP::Simple;

# Set the URL
my $url = "http://perlcourse.ecorp.net/conf-mirror/conferences.oreillynet.com/speakers.html";

# Get the $URL 
my $content = get($url);

# Build a tree object
my $tree = HTML::Tree->new();

# Have the tree object parse the web content
$tree->parse($content);

# Dump a tags into a candidates array
my @candidates = $tree->look_down( '_tag', 'a');

# This hash will hold the speaker and the number of sessions heading up or participating in
my %speaker_hash;

# A scalar to hold the name of a speaker
my $speaker;

foreach my $candidate (@candidates)
{
	if ($candidate->as_text eq "Click here")
	{
		next;
	}
	else
	{
		# Pluck out a speaker:
		# <a href="http://conferences.oreillynet.com/cs/os2002/view/e_spkr/1295">Ben Trott</a>
		if ($candidate->as_HTML =~ /e_spkr/)
		{
			$speaker = $candidate->as_text;
			$speaker_hash{$speaker} = 0;
		}
		
		# Pluck out a session:
		# <li><b>Session: <a href="http://conferences.oreillynet.com/cs/os2002/view/e_sess/3273">YAML: A New Language for Data</a></b></li>
		if ($candidate->as_HTML =~ /e_sess/)
		{
			$speaker_hash{$speaker}++;
		}
	}
}

my $counter = 0;

foreach my $name (sort { $speaker_hash{$b} <=> $speaker_hash{$a} } keys %speaker_hash) 
{
	if ($counter == 3)
	{
		last;
	}
	else
	{
		printf "%-8s (%s)\n", $name, $speaker_hash{$name};
		$counter++;
	}	
}



