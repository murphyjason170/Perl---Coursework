#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;
  
my @guitars = ("jason");

print @guitars;

pop @guitars;
print @guitars;

pop @guitars;
shift @guitars;
print @guitars;
