#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

################################################################
#
# Course: 	Perl III
# Objective:    Lab 9, Objective 1 	
# Date:		March 21, 2014
# Student:	Jason Murphy
# Instructor:	Ben Hengst
#
#################################################################


my $board_ref;

main(@ARGV);

sub main
{
	data_import();
	user_interface();
} 	


sub data_import	
{
	my @board;				
	$board_ref = \@board;

	while (<DATA>) 
	{
		push (@$board_ref, split (m!\s|\d!, $_)); 	
		chomp(@$board_ref);
	} 	
}


sub user_interface
{
	print "=========================\n";
    	print "Welcome to the Chess Game\n\n";
	print "=========================\n";
	print "|\n";
	print "| To quit type 'q' on any input line\n";
	print "|\n";
	print "|\n";
	
    my $continue_game = 'yes';
	
	while ($continue_game eq 'yes')
	{
		print "Current board is:\n";
		print_board($board_ref);
		print "\n";

		print ("Enter the 'from' tile (1-64):");
		print (">");
		my $user_from = <STDIN>;
		chomp($user_from);
		
		if ($user_from eq 'q')
		{
			print "Leaving game\n";
			exit;		
		}
		
		print ("Enter the 'to' tile (1-64):");
		print (">");
		my $user_to = <STDIN>;
		chomp($user_to);
		if ($user_to eq 'q')
		{
			print "Leaving game\n";
			exit;		
		}

		if ($user_from =~ /\d+/ && $user_to =~ /\d+/)  
		{
			move($board_ref, $user_from, $user_to);
		}		
	}
}

sub move
{
	print "\n";
  
	my ($bref, $from, $to) = @_;

	# Bring the user input number back to a zero-based array number
	$from--;
	$to--;
	
	if ($bref->[$to] eq '--')
	{
		print "\n";
		print "-----------------\n";
		print "Chess Piece Moved\n";
		print "-----------------\n";
		$bref->[$to] = $bref->[$from];
		$bref->[$from] = '--';
	}	 
	else
	{
		print "\n";
		print "-----------------------------------------------\n";
		print "Invalid move, tile is occupied by another piece\n";
		print "-----------------------------------------------\n";
	}
}
    
sub print_board
{
	my $counter = 0;	
	my $item;

	foreach $item (@$board_ref)
	{
	  if ($counter < 7)
	  {
	     print $item;
		 print " ";
		 $counter++;
	  }
	  else
	  {
	    print $item;
	    print "\n";
		$counter = 0;
	  } 
	}
}

__END__
Br Bk Bb BQ BK Bb Bk Br
Bp Bp Bp Bp Bp Bp Bp Bp
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
Wp Wp Wp Wp Wp Wp Wp Wp
Wr Wk Wb WK WQ Wb Wk Wr
