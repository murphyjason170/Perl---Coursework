package MySQL_Common;
use strict;
use warnings;

BEGIN { our @ISA = 'Exporter' }
our @EXPORT_OK = qw( $USER $PASS $SERVER $DB );

our $USER 	= $ENV{USER};
our $PASS	= 'bond007';
our $SERVER	= 'sql';
our $DB		= $USER;

1;



