#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;

################################################################
#
# Course: 	Perl III
# Objective:    Lab 14, Objective 1 	
# Date:		April 7, 2014
# Student:	Jason Murphy
# Instructor:	Ben Hengst
#
#################################################################


###########################################################
#
# User-entered Data Integrity
#
if ( (!$ARGV[0]) || (!$ARGV[1]) )
{
	print "Usage:\n";
	print "./chess2.pl from to\n";
	print "\"from\" requires a number from 1-64\n";
	print "\"to\" requires a number from 1-64\n";
	die;
}

if (
	$ARGV[0] =~ /\D+/ 	||	# Verify the entry for $ARGV[0] is numeric	
	$ARGV[1] =~ /\D+/ 	||	# Verify the entry for $ARGV[1] is numeric
	$ARGV[0] < 0  		||	# Verify the entry for $ARGV[0] is greater than 0
	$ARGV[1] < 0  		||	# Verify the entry for $ARGV[1] is greater than 0
	$ARGV[0] > 64 		||	# Verify the entry for $ARGV[0] is not greater than 64
	$ARGV[1] > 64			# Verify the entry for $ARGV[1] is not greater than 64
)
{
	print "Usage:\n";
	print "./chess2.pl from to\n";
	print "\"from\" requires a number from 1-64\n";
	print "\"to\" requires a number from 1-64\n";
	die;
}
#
#
#
###########################################################

my $user_from = $ARGV[0];
my $user_to = $ARGV[1];

chomp $user_from;
chomp $user_to;


print "You are moving from $user_from to $user_to\n";

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
 	print "Current board is:\n";
	print_board($board_ref);

	if ($user_from =~ /\d+/ && $user_to =~ /\d+/)  
	{
		move($board_ref, $user_from, $user_to);
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
		print "Chess Piece Moved\n\n";
		$bref->[$to] = $bref->[$from];
		$bref->[$from] = '--';
	}	 
	else
	{
		print "\n";
		print "Invalid move, tile is occupied by another piece\n\n";
	}
}
    
sub print_board
{
	my $DESTINATION_FILE_1 = 'chessboard.txt';
	open my $fh_chessboard_write, ">", $DESTINATION_FILE_1 or die "Couldn't open $DESTINATION_FILE_1: $!\n";

	my $counter = 0;	
	my $item;

	foreach $item (@$board_ref)
	{
	  if ($counter < 7)
	  {
	     	print $item;
	     	print {$fh_chessboard_write} ("$item");
	     
	     	print " ";
	     	print {$fh_chessboard_write} (" ");
 		$counter++;
	  }
	  else
	  {
	    	print $item;
 	    	print {$fh_chessboard_write} ("$item");
	    	    
	    	print "\n";
 	    	print {$fh_chessboard_write} ("\n");
	    	$counter = 0;
	  } 
	}
	
	close $fh_chessboard_write;
}

print "Post-move the board is:\n";
print_board($board_ref);

__END__
Br Bk Bb BQ BK Bb Bk Br
Bp Bp Bp Bp Bp Bp Bp Bp
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
Wp Wp Wp Wp Wp Wp Wp Wp
Wr Wk Wb WK WQ Wb Wk Wr