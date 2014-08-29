#!/usr/bin/perl
use strict;
use warnings;

$_ = join ' ', <DATA>;

print "Words not followed by punctuation at the end of the line:\n";
print "\t$_\n" for  /(\w+)$/mg;

print "Second words of lines started by the word 'Now':\n";
print "\t$_\n" for /^Now\s+(\w+)/mg;

print "Words followed by a period at the end of the line:\n";
print "\t$_\n" for /(\w+)\.$/mg;

__END__
Now is the winter of our discontent
Made glorious summer by this sun of York;
And all the clouds that lour'd upon our house
In the deep bosom of the ocean buried.
Now are our brows bound with victorious wreaths;
Our bruised arms hung up for monuments;
Our stern alarums changed to merry meetings,
Our dreadful marches to delightful measures.