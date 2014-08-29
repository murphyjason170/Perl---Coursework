#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use CGI qw(:all);
use CGI qw/:standard -debug/;

use CGI::Carp qw(fatalsToBrowser);

use MyTemplate;
use Date::Parse;
use Bank;

# Stores the atm_timed.tmpl file
my $template = MyTemplate->new;

# Put the hand-offs from the atm_choose page into a hash.
# map is called to map the key values into the hash 
# The hash would look something like this
# account_number	12345
# type			credit
# time			2
# amount		100 
my %param = map { $_, param( $_ ) } qw(account_number type time amount);

my $time = str2time( $param{time} ) or die "Cannot parse '$param{time}'";
my $to_sleep = $time - time;
die "time is no good\n" if $to_sleep < 0 || $to_sleep > 3600;

$param{time} = localtime $time;
$template->param( %param );
print $template->html_output;

my ($account_number, $type, $amount) = @param{ qw(account_number type amount) };
unless ( fork )   # child
{
  close STDIN;    # This prevents the web server from holding the
  close STDOUT;   # connection open the whole time we're sleeping
  close STDERR;
  
  # Disable the sleep so I can work on getting this squared away
  sleep $to_sleep;

  # This is a Bank::Account object that is set to thee retrieved account_number
  my ($account) = Bank::Account->search( account_number => $account_number );
  
  # The Bank::Account object then calls the add_transaction method
  $account->add_transaction( $type, $amount );

  exit;
}















