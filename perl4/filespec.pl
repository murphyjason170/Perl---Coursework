#!/usr/local/bin/perl
use strict;
use warnings;

use File::Spec::Functions qw(abs2rel canonpath catfile file_name_is_absolute);

my $messy_path = '/top/.//next/./component/file';
my $clean_path = canonpath( $messy_path );
print "$messy_path => $clean_path\n";

print "$clean_path ", ( file_name_is_absolute( $clean_path ) ? "is" : "isn't" ), " absolute\n";

my $base = "/top";

print "Relative to $base, $clean_path = ", abs2rel( $clean_path, $base ), "\n";

my $part = "/next/level/newfile.txt";
print "Joining $base and $part => ", catfile( $base, $part ), "\n";
