package Music::Song;

use lib qw(/users/jmurphy3/mylib/lib/perl5);

use Moose;

has artist => 	( isa => 'Str', is=> 'rw', required => 1 );
has title => 	( isa => 'Str', is => 'rw', required => 1 );
has length => 	( isa => 'Num', is=> 'rw', required => 1);
has id => 	( isa => 'Int', is => 'ro' );

with 'StringFuncs';

1;



