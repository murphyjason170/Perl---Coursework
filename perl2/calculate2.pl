#!/usr/local/bin/perl
use strict;
use warnings;

my $INVALID = "Invalid statement\n";
my $Accumulator;


while ( print( "> " ) && defined( my $line = <> ) )
{
  chomp $line;
  my $ok;
  ($ok, $Accumulator) = execute( $line, $Accumulator );
  if ( $ok )
  {
    print "OK\n";
  }
  else
  {
    warn $INVALID;
  }
}

sub execute
{
  my ($line, $current) = @_;

  if ( length $line == 0 )
  {
    return;
  }
  my $operator_length = index $line, ' ';
  if ( $operator_length < 0 )
  {
    return monadic( $line, $current );
  }
  else
  {
    my $operator = substr $line, 0, $operator_length;
    my $operand = substr $line, $operator_length + 1;
    return dyadic ( $operator, $operand, $current );
  }
}

sub monadic
{
  my ($operator, $current) = @_;

  if ( $operator eq 'EQUALS' )
  {
    if ( defined $current )
    {
      print " = $current\n";
    }
    else
    {
      print " (undefined)\n";
    }
    return ( 1, $current );
  }
  elsif ( $operator eq 'CLEAR' )
  {
    return ( 1, 0 );
  }
  return;
}

sub dyadic
{
  my ( $operator, $operand, $current) = @_;

  # Jason's mods
  # Modify it to check that the number entered is a valid integer or floating point number, 
  # optionally prefixed by a plus or minus sign, and output an error if it does not match. 
  # NOTE: THE ORDER OF THE EVALUATION MATTERS - DO NOT FORGET THIS!!
  if ( $operand =~ m![~`_&%@\\#<>,/:;"a-zA-Z\{\}\[\]\(\)\?\^\!\$\*]! ){	
     print "Please enter a valid integer\n";
        next;
  }
  elsif ( $operand =~ m!\+*\-*\d\w{0,}! ){
  	# print "Matched on the plus sign and digit\n";
  }
  else {
  	print "Please enter a valid integer\n";
  	next;  
  }
  
  if ( $operator eq 'PLUS' )
  {
    return ( 1, $current + $operand );
  }
  elsif ( $operator eq 'MINUS' )
  {
    return ( 1, $current - $operand );
  }
  elsif ( $operator eq 'TIMES' )
  {
    return ( 1, $current * $operand );
  }
  elsif ( $operator eq 'OVER' )
  {
    return ( 1, $current / $operand );
  }
  return;
}