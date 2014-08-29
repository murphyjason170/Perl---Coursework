#!/usr/bin/perl
use strict;
use warnings;

# TASK 1 - create the 676 files named "aa", "ab", ..."ba", "bb", ... through "zz" (hint: perldoc perlop; read more fully about the 
# range operator) each containing contents equal to their uppercased name.
print "=========================\n";
print "TASK 1:\n";
print "=========================\n";

# Make the array:
my @array = ("aa" .. "zz");

foreach (@array) {
	print;
	print "\n";
}
 	
foreach (@array){ 		
	open my $fh, '>', $_ . ".txt" or die "Couldn't open: $!\n";
	print {$fh} uc($_) . "\n";
}
  
print "Task 1 completed - Created many text files\n\n";

sleep 2;

# Task 2: print the contents of each of the files that has a letter q in their name (figure out what those files are
# as though you did not know you had just written them). 
print "=========================\n";
print "TASK 2:\n";
print "=========================\n";

my $file = 'a.txt';
my $fh;
my @data;
my $line;

# go through every q matched text file:
while ( glob "{*q*}.txt" )
{
	$file = $_ ;
	open ($fh, $file) or die ("Unable to open file");
	@data = <$fh>;

	# print the contents of the file that matched	
	foreach $line (@data)
	{
		print $line;
	}	
	close($fh);
}
print "Task 2 completed - printed out contents of all q files\n\n";
sleep 2;


 
# Task 3: delete those files and count and print the number of files left that 
# have two letters in their name (see perldoc -f unlink). 
print "=========================\n";
print "TASK 3:\n";
print "=========================\n";

my @goners;

while ( glob "{*q*}.txt" ){
	push @goners, $_;
} 

unlink (@goners); 
print "Task 3 completed - all q files deleted\n\n";
 
 