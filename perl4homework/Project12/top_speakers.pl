#!/usr/bin/perl
use strict;
use HTML::Tree;
use LWP::Simple;
use Data::Dumper;

use lib "$ENV{HOME}/mylib/lib/perl5";


my $url = "http://perlcourse.ecorp.net/conf-mirror/conferences.oreillynet.com/speakers.html";

my $content = get($url);

my $tree = HTML::Tree->new();

$tree->parse($content);

my @titles = $tree->look_down( '_tag', 'a');

my %speaker_hash;
my $speaker;

foreach my $t (@titles)
{
	if ($t->as_text eq "Click here")
	{
		next;
	}
	else
	{
		# Pluck out a speaker:
		# <a href="http://conferences.oreillynet.com/cs/os2002/view/e_spkr/1295">Ben Trott</a>
		if ($t->as_HTML =~ /e_spkr/)
		{
			$speaker = $t->as_text;
			$speaker_hash{$speaker} = 0;
		}
		
		# Pluck out a session:
		# <li><b>Session: <a href="http://conferences.oreillynet.com/cs/os2002/view/e_sess/3273">YAML: A New Language for Data</a></b></li>
		if ($t->as_HTML =~ /e_sess/)
		{
			$speaker_hash{$speaker}++;
		}
	}
}


my @speakers;

foreach my $name (sort { $speaker_hash{$b} <=> $speaker_hash{$a} } keys %speaker_hash) 
{	
	  my $line = "$name, $speaker_hash{$name} ";
	  push (@speakers, $line);
}

my $to = 'jmurphy89@hotmail.com';

# This puts together the sender’s email address
chomp( my $from = "$ENV{USER}\@" . 'hostname' );

# Read into one string all of the data below the __END__ marker
my $msg = join '', <DATA>;

# eval it so that variables replacement takes place and email  
$msg = eval qq{"$msg"};

# Open a file handle and pipe it to sendmail
open my $fh, "|-", "sendmail -t" or die "Can't pipe to sendmail: $!\n";

# This prints the message to the sendmail file handle
print {$fh} $msg;

__END__
From: $from
To: $to
Subject: Speaker List

@speakers


Jason Murphy


