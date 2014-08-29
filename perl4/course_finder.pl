#!/usr/local/bin/perl
use strict;
use warnings;

use lib "$ENV{HOME}/mylib/lib/perl5";
use HTML::TreeBuilder;
use LWP::Simple;

my $URL = 'http://perlcourse.ecorp.net/ost-mirror/courses/index.html';

my $tree = HTML::TreeBuilder->new;
$tree->parse( get ( $URL ) );

my @elements = $tree->look_down( _tag => "a", \&in_list );
for my $element ( @elements )
{
  print $element->as_text, "\n";
}

sub in_list
{
  my $element = shift;
  
  my ($parent_tag) = $element->lineage_tag_names;
  $parent_tag eq 'li' && ! $element->look_up( _tag => 'div', \&is_nav );
}


sub is_nav
{
  my $element = shift;
  my $attr = $element->attr( 'id' ) || $element->attr( 'class' );
  return $attr && $attr =~ /nav/;
}

