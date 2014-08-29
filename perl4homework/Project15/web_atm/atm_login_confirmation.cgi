#!/usr/local/bin/perl
use strict;
use warnings;

use lib qw(/users/jmurphy3/mylib/lib/perl5);
use CGI qw(:all);
use CGI qw/:standard -debug/;
use CGI::Carp qw(fatalsToBrowser);
use MyTemplate;
use Bank;

my $template = MyTemplate->new;

my $account_number;
my $password;

my $session_written = 'false';

################################################################
#
# Session related:
#
#
my $account_number;

if (param('account_number'))
{
  $account_number = param( 'account_number' ); 
  # $password = param('password');
  
  # A high level screen to make sure that there are at least 7 alpha-numerics 
  # If not then die out since it is required when the account is created to create
  # a password of at least 7 alpha-numerics
  if ( param('password')  =~ m!\w\w\w\w\w\w\w+!) 
  {
    $password = param('password');	
  }	
  else
  {
    die "Password must be at least 7 alpha-numerics long\n";
  }
}
else
{
  my $fh_login_read;		
  my $LOGIN_FILE = 'confirmation.txt';
  open $fh_login_read, "<", $LOGIN_FILE or die "Please login!\n";
  foreach my $line (<$fh_login_read>)
  {
    chomp $line;
    $account_number = $line;
  }
  close $fh_login_read;
  
  $session_written = 'true';

}
#
#
################################################################




################################################################
#
# Talk to Bank.pm
#
if ( $session_written eq 'false')
{
  my ($account) = Bank::Account->search( account_number => $account_number );
  if (!$account)
  {
    die "Account not found, please try again\n";
  }
  $account->check_password($password);
}

################################################################
#
# Create a session that will carry across:
#
#
if ( $session_written eq 'false')
{
  my $fh_login_write;		
  my $LOGIN_FILE = 'confirmation.txt';
  open $fh_login_write, ">", $LOGIN_FILE or die "Couldn't open $LOGIN_FILE: $!\n";
  print {$fh_login_write}("$account_number\n");
  close $fh_login_write;
}


# Print out the html_output which now has all the substitutions completed. 
print $template->html_output;


__END__

=head1 NAME

   atm_login_confirmation.cgi file

=head1 USAGE

   Point browser at: http://jmurphy3.userworld.com/perl4homework/Project15/web_atm/atm_login.cgi
   and atm_login_confirmation is triggered by logging in.   

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