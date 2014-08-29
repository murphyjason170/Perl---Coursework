#!/usr/local/bin/perl
use strict;
use warnings;

use Time::Piece;
use Time::Seconds;
use LWP::Simple;

use lib "$ENV{HOME}/mylib/lib/perl5";

###################################################
#
# Usage info:
#

if (!$ARGV[0]) 
{
  print "Invalid format\n";
  print "\tUsage    ./dl_page HH:MM\n";
  print "\tExample: ./dl_page 19:30\n";
  die;
}
#
#
###################################################


###################################################
#
# Setup 2 Time::Piece objects
# One will represent the user entered time
# The other will represent the "current time" 
# 
my $user_entered_time = shift;
chomp($user_entered_time);
my ($user_entered_hour, $user_entered_minute) = split(':', $user_entered_time);


my $default_time = Time::Piece->new();
my ($day, $month, $day_number, $default_hour, $default_minute, $default_second, $year) = split(/[ :]/, $default_time);                                
my $zero_second = '0';                     
my $t = Time::Piece->strptime("$day $month $day_number $user_entered_hour:$user_entered_minute:$zero_second $year",
                                "%a %b %d %H:%M:%S %Y");

my $current_time = Time::Piece->new();

my $result = ($t - $current_time) + 18000;

# Put in a check to verify that number of seconds is a positive integer
if ($result < 0)
{
  print "Please enter an hour:minute that exists in the future\n";
  print "Make it a time greater than: ", $current_time,  "\n";
  die;
}
else
{
  print "Child will run in $result seconds\n";
}
#
#
###################################################

###################################################
#
# Main program logic
#
#
my $pid = fork;

# Parent
if ($pid)		
{  
  my @counter = (1 .. 200);
  for my $count (@counter)
  {
  	print "$count - Proving this program can do other things meanwhile\n";
  	sleep 1; 
  }
}
# Child
elsif ( defined( $pid ) ) 	
{
  sleep $result;      
  print "Child has woken up\n";
  my $url      = " http://perlcourse.ecorp.net/ost-mirror/index.html";
  my $filename = "some-file.html";
  my $result_code = getstore($url, $filename);
  print "Result code is $result_code\n";
  exit 7;
}
else
{
  die "Error in fork: $!\n";
}
# 
# 
###################################################
 