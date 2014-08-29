#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";
use URI;

while ( <DATA> )
{
  chomp ( my $url = $_ );
  print "Analyzing $url:\n";
  my $uri = URI->new( $url );
  
  for my $method (qw ( scheme host port userinfo path query ))
  {
    printf "%10s\t", $method;
    print defined( $uri->$method) ? $uri->$method : '<unset>', "\n";
  }
}
__END__
http://www.oreillyschool.com/
ftp://ftp.oreillyschool.com/support/perl4/files.tgz
http://www.oreillyschool.com/contact.html
http://user@www.oreillyschool.com/contact.html
https://user:password@www.oreillyschool.com/contact.html
http://www.oreillyschool.com:8080/
http://www.oreillyschool.com/contact.cgi/more/info
http://www.oreillyschool.com/contact.cgi?type=compliment&dest=scott