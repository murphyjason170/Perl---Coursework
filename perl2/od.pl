#!/usr/bin/perl
use strict;
use warnings;

my $mode_of_output = 'hex';
my $file_name_to_work_on = 'placeholder' ;
my $size_of_file = 0;;
my @my_args = @ARGV;

foreach my $my_arg (@my_args)
{
	if ($my_arg eq '-c') 
	{
		print "Found the -c flag that we want to specify octal value ranges\n";
		$mode_of_output = 'octal';
	}
	
	if ($my_arg =~ m!(.*.png)!)
	{
		print "Found the png file we want to operate on $1 \n";
		$file_name_to_work_on = $1;
		$size_of_file = -s $file_name_to_work_on;
		print "The file size is $size_of_file \n";
	}
}

my $buffer = "" ;
my $fh1 ;
 
my $line;
 
open($fh1, '<', $file_name_to_work_on ) or die "Cannot open the file $file_name_to_work_on\n";
binmode($fh1); 
read($fh1, $buffer, $size_of_file );
close($fh1);

my $counter_format = 1;
my $FORMAT_MAX = 10;

foreach (split(//, $buffer)) {
	# Hex representation
	if ( $mode_of_output eq 'hex')
	{
		printf("%04x ", ord($_));
		$counter_format++;
	}
   
	elsif ( $mode_of_output eq 'octal' ) 
	{
		# Valid range 040 through 0176
		if ( ord ($_) >= 32 && ord ($_) <= 126 )
		{
			printf("%-5o ", ord ($_) );
			$counter_format++;
		}
	}
	
	if ($counter_format == $FORMAT_MAX)
	{ 
		print "\n";
		$counter_format = 1;
	}
}

print "\nThe file name is $file_name_to_work_on and I printed it out in $mode_of_output \n";
print "The file size is $size_of_file \n";

 
