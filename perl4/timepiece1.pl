#!/usr/local/bin/perl
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;

my $user_entered_time = shift;
chomp($user_entered_time);
my ($user_entered_hour, $user_entered_minute) = split(':', $user_entered_time);


my $default_time = Time::Piece->new();

#     Tue    Apr     29       17:                  07:              55           2014
my ($day, $month, $day_number, $default_hour, $default_minute, $default_second, $year) = split(/[ :]/, $default_time);

                                
my $t = Time::Piece->strptime("$day $month $day_number $user_entered_hour:$user_entered_minute:$default_second $year",
                                "%a %b %d %H:%M:%S %Y");

$t += $t->localtime->tzoffset;

print $t->strftime();
print "\n"; 

my $current_time = Time::Piece->new();
$current_time += $current_time->localtime->tzoffset;
print $current_time->strftime();
print "\n";

print "The offset is: ";
print $current_time->tzoffset;
print "\n"; 


my $result = ($current_time - $t) - 18000;
print "The result is: $result\n";


sleep $result;      
my $url      = " http://perlcourse.ecorp.net/ost-mirror/index.html";
my $filename = "some-file.html";
my $result_code = getstore($url, $filename);
if (is_error($result_code)) {
#  die "getstore of <$url> failed with $result_code";
# }
    