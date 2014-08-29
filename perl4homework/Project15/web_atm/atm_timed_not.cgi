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
my %param = map { $_, param( $_ ) } qw(account_number type amount);

#my $time = str2time( $param{time} ) or die "Cannot parse '$param{time}'";
# my $time = 'whocares';

# my $to_sleep = $time - time;
# die "time is no good\n" if $to_sleep < 0 || $to_sleep > 3600;

#$param{time} = localtime $time;
$template->param( %param );
print $template->html_output;

my ($account_number, $type, $amount) = @param{ qw(account_number type amount) };
unless ( fork )   # child
{
  close STDIN;    # This prevents the web server from holding the
  close STDOUT;   # connection open the whole time we're sleeping
  close STDERR;
  
  # Disable the sleep so I can work on getting this squared away
  # sleep $to_sleep;

  # This is a Bank::Account object that is set to thee retrieved account_number
  my ($account) = Bank::Account->search( account_number => $account_number );
  
  # The Bank::Account object then calls the add_transaction method
  $account->add_transaction( $type, $amount );

  exit;
}

__END__

=head1 NAME

   atm_timed_not.cgi file

=head1 USAGE

   Point browser at: http://jmurphy3.userworld.com/perl4homework/Project15/web_atm/atm_login.cgi
   On the main menu click Customer Functions
   Then click Credit or Debit Current Account - Immediate
   When you submit that form atm_timed_not will run
   
=head1 DESCRIPTION

This file is a larger part of the Web-based ATM Machine. This application
uses an SQL database for all data storage.

=head1 AUTHOR

Written by I<Jason Murphy>.

=head1 DEPENDENCIES

None

=head1 LICENSE AND COPYRIGHT

The world may use this free of charge. Enjoy!

=cut











