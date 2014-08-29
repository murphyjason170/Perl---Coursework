#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

###############################################################
#
# Course:		Perl III
# Assginment		Lab 15, Objective 1
# Date: 		April 9, 2014
# Instructor: 		Ben Hengst
# Student: 		Jason Murphy
#
###############################################################

###############################################################
#
# Data Source:
#
# ./dispatch.pl /software/Perl3/dungeon
#
###############################################################

my %verb = (go => \&go, give => \&give, drop => \&drop,
	take=>\&take, kill=> \&kill,
	look => \&look, have => \&inventory, quit => sub {exit} );
	
my %inventory;		# From dungeon.txt 'me has jewel'                                                                                                      
my %room_contents;	# From dungeon.txt 'pit contains statue'                                                                                                
my %location;		# From dungeon.txt 'troll is in cave'
my %exit;		# From dungeon.txt 'attic down goes to house'


############################################################################
#
# The Hash Machine - the data populates/creates the hash data structures 
# for this game
#
# Read in user-specified file dungeon from the command line
my $line;

# The program goes no further if a source dungeon file is not provided
if (!$ARGV[0])
{
	print "You must provide a source dungeon file\n";
	print "Example:\n";
	print "\tdispatch.pl dungeon\n";
	die;
}

# Read the dungeon file in
while (<>)
{
	$line = $_;
	chomp $line;

	# Populate the inventory hash
	if ($line =~ /(\S+)\s+has\s+(\S+)/)
	{		
		my $count = 1;

		# This logic put things into inventory
		# We might encounter a dungeon file where an actor has multiples
		# of the same object. We need account for this.
		if (exists $inventory{$1}{$2})
		{
			my $current_count = $inventory{$1}{$2};
			$current_count++;
			$inventory{$1}{$2} = $current_count;
		}
		# In this case the actor and item do not yet exist in the hash
		# So, put them in and assign a quantity of 1
		else 
		{
			$inventory{$1}{$2} = '1';
		}
	}
	
	# Populate the room contents hash
	if ($line =~ /(\S+)\s+contains\s+(\S+)/)
	{
		if (exists $room_contents{$1}{$2})
		{
			my $current_count = $room_contents{$1}{$2};
			$current_count++;
			$room_contents{$1}{$2} = $current_count;
		}
		# In this case the location and item do not yet exist in the hash
		# So, put them in and assign a quantity of 1
		else 
		{
			$room_contents{$1}{$2} = '1';
		}
	}
	
	# Populate the location hash
	if ($line =~ /(\S+)\s+is in\s+(\S+)/)
	{
		$location{$1} = $2;	
	}
	
	# Populate the exit hash
	#
	if ($line =~ /(\S+)\s+(\S+)\s+goes to\s+(\S+)/)
	{
		$exit{$1}{$2} = $3;
	} 
}
#
############################################################################



############################################################################
#
# Main User Interface
#
for ( prompt(); $_ = <STDIN>; prompt() )
{
	chomp;
	next unless /(\S+)(?:\s+(.+))?/;
	$verb{$1} or warn "\tI don't know how to $1\n" and next;
	$verb{$1}->($2);
}

sub prompt { print "Command: "}
#
############################################################################


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

sub go
{
	my $valid_location_flag = 0;
	my $direction_actor_wants_to_go = shift;	
	my $here = $location{me};
	
	# Find the directions available to the actor based on the current room
	for my $key (sort keys %exit)
	{	
		for my $var2 (keys %{ $exit{$key} })
		{
			if ($here eq $key)
			{
				if ($direction_actor_wants_to_go eq $var2)
				{
					# Assign the new location to me location:
					$location{me} = $exit{$key}{$var2};			
					
					# Raise the flag that we are have a valid location
					 $valid_location_flag++;
					}
			}
		}
	}	
	# If we do not have a valid user-specified exit than provide an error:
	print "Can't go $direction_actor_wants_to_go from here\n" if ($valid_location_flag == 0);
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

	print "There are exits leading: ";
	for my $key (sort keys %exit)
	{				
		for my $var2 (keys %{ $exit{$key} })
		{
			if ($here eq $key)
			{
				print "$var2 ";
			}
		}
	}
	print "\n";
}

sub kill
{
	local $_ = shift;
	/(\S+)\s+with\s+(\S+)/ or return warn "\tKill who with what?\n";
	$inventory{me}{$2} or return warn "\tYou don't have a $2\n";
	my $here = $location{me};
	my $its_at = $location{$1} or return warn "\tNo $1 to kill\n";
	delete $location{$1};
	my $had_ref = delete $inventory{$1};
	$room_contents{$here}{$_}++ for keys %$had_ref;
	print "Dispatched!\n";
}

 