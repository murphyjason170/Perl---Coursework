#!/usr/local/bin/perl
use strict;
use warnings;

use lib "../mylib/lib/perl5";
use CGI qw(header);
use HTML::TreeBuilder;
use LWP::Simple;

my $SOURCE = 'http://perlcourse.ecorp.net/ost-mirror/courses/index.html';
my $TARGET = 'http://perlcourse.ecorp.net/conf-mirror/conferences.oreillynet.com/';

my $tree = HTML::TreeBuilder->new;
$tree->parse( get ( $SOURCE ) );

my @elements = $tree->look_down( _tag => "a", \&in_list );

my $container = find_list_parent( $elements[0] );

my $new_tree = HTML::TreeBuilder->new;
$new_tree->parse( get( $TARGET ));

my $h3 = $new_tree->look_down( _tag => "h3",
		sub { shift->as_text eq "O'Reilly Conference News" } );
my $target_element = $h3->parent;
$target_element->delete_content;
$target_element->push_content( $container );

# print header, $new_tree->as_HTML;

sub find_list_parent
{
  my $element = shift;
  
  my ($list_element) = $element->look_up( _tag => 'ul' );
  return $list_element->parent;
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

