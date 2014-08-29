#!/usr/local/bin/perl
use strict;
use warnings;

	use lib "$ENV{HOME}/mylib/lib/perl5";
	use POE qw(Component::Server::TCP);

	sub S_HND { return POE::Wheel::SocketFactory::MY_SOCKET_HANDLE }

	POE::Component::Server::TCP->new( 
  	  ClientInput => sub {
    	    my ($heap, $input) = @_[HEAP, ARG0];
    	    print "Read from client: $input\n";
    	    $heap->{client}->put("You said: $input" );
  	},
  	Started => sub { my $sock = $_[HEAP]{listener}[S_HND];
	   	   my ($port) = Socket::sockaddr_in( getsockname($sock) );
	   	   print "Listening on port $port\n" },
	);

$poe_kernel->run();

    