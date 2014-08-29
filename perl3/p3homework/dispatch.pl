#!/usr/bin/perl
use strict;
use warnings;
 
# Notice that the names of the subroutines are only ever used once, in the definition 
# of the dispatch table.
# 
# Now you want the word "slay" to be synonymous with "kill," so the subroutine 
# that gets executed should do exactly the same, except that instead of 
# printing "kill," it should print "slay." 
#
# Your goal is to do this without copying the kill subroutine, but instead, create a 
# closure over the particular verb.

# A closure is a subroutine that uses a variable that is defined outside of the subroutine; 
# the subroutine is said to be closed over the variable. 

# It might help to know that in a double-quoted string, 
# if you want to print a variable followed by letters that would be interpreted 
# as part of the variable name, you can do it with braces: "${verb}ed!" 
# Also, that the escape sequence \u in a double-quoted string uppercases the next letter: "\u$verb..."

# Expected Output:
# cold:~/p3homework$ ./dispatch.pl

# Command: take sword
# Taken

# Command: kill troll 
# Kill who with what?

#Command: kill troll with sword
# Killed!

#Command: quit
#cold:~/p3homework$ ./dispatch.pl

#Command: take sword
# Taken

#Command: slay frog with sword  
# No frog to slay

#Command: slay troll with sword
# Slayed!

 
my %verb = (give => \&give, drop => \&drop,
	take=>\&take, kill=> \&kill,
	look => \&look, have => \&inventory, quit => sub {exit}, slay => \&kill );
	
my %inventory       = ( me => { jewel => 1}, troll => { diamond => 1 } );
my %room_contents   = ( cave => { sword => 1 });
my %location        = ( me => 'cave', troll => 'cave', thief => 'attic' );

my $ref_var;

for ( prompt(); $_ = <STDIN>; prompt() )
{
	chomp;
	next unless /(\S+)(?:\s+(.+))?/;
	$verb{$1} or warn "\tI don't know how to $1\n" and next;
	
	my $var = $1;
	$ref_var = \$var;
	
	$verb{$1}->($2);
}

sub prompt { print "Command: "}


sub give
{
	local $_ = shift;
	/(\S+)\s+to\s+(\S+)/ or return warn "\tGive what to who?\n";
	delete $inventory{me}{$1} or return warn "\tYou don't have a $1\n";
	$inventory{$2}{$1}++;
	print "\tGiven\n";
}

sub drop
{
	my $what = shift;
	delete $inventory{me}{$what} or return warn "\tYou don't have a $what\n";
	my $here = $location{me};
	$room_contents{$here}{$what}++;
	print "\tDropped\n";
}

sub take
{
	my $what = shift;
	my $here = $location{me};
	delete $room_contents{$here}{$what} or return warn "\tThere's no $what here\n";
	$inventory{me}{$what}++;
	print "\tTaken\n";
}

sub inventory
{
	for my $have ( keys %{ $inventory{me} })
	{
		print "\t You have a $have\n";
	}
}

sub look
{
	my $here = $location{me};
	print "\tYou are in the $here\n";
	for my $around ( keys %{ $room_contents{$here} })
	{
		print "\tThere is a $around on the ground\n";
	}
	for my $actor ( keys %location )
	{
		next if $actor eq 'me';
		print "\tThere is a $actor here\n" if $location{$actor} eq $here;
	}
}

sub kill
{	
	local $_ = shift;
	# $_ is 'troll with sword'
	
	/(\S+)\s+with\s+(\S+)/ or return warn "\tKill who with what?\n";
	# $1 is the actor
	# $2 is the inventory / weapon
	
	$inventory{me}{$2} or return warn "\tYou don't have a $2\n";
		
	my $here = $location{me}; 
	
	if ($$ref_var eq 'kill')
	{
		my $its_at = $location{$1} or return warn "\tNo $1 to $$ref_var\n";		
	}
	elsif ($$ref_var eq 'slay')
	{
		my $its_at = $location{$1} or return warn "\tNo $1 to $$ref_var\n";		
	}	
	
	delete $location{$1};
	
	my $had_ref = delete $inventory{$1};
	
	$room_contents{$here}{$_}++ for keys %$had_ref;
	
	if ($$ref_var eq 'kill')
	{
		print "\u$${ref_var}ed!\n";	
	}
	elsif ($$ref_var eq 'slay')
	{
		print "\u$${ref_var}ed!\n";
	}
}


# sub slay
#{
#	print "In slay function: \n";
#	
#	my $val1 = shift;		# $val1 is 'troll with sword'
#	# print "\$val1 is $val1\n"; 
		
#	my $kill_ref = \&kill;	
#	$kill_ref->($val1);
	
#}