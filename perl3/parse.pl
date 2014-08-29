#!/usr/bin/perl
use strict;
use warnings;

use Data::Dumper;

# Function parse() takes a string  as an arg and returns a hash reference - i.e. access to the entire data structure

print "------------------------\n";
my (@numbers, @operators);
print "\@numbers is @numbers\n";		# Prints: @numbers is
print @numbers;
print "\n";
print "\@operators is @operators\n";	# Prints: @operators is
print @operators;
print "\n";
print "------------------------\n";

print "------------------------\n";
my $exp = join '', <DATA>;			# Take in the data 5 + 17 * $x - 3 ** 2 and put it in a string	
chomp $exp;
print "Expression is: $exp \n";
print "------------------------\n";

############################################################################3
# 1. call the parse function
#
# This is what is being passed to the parse function - parse("5 + 17 * $x - 3 ** 2")
print "------------------------\n";
my $tree = parse( $exp );				# Returned  is a hash reference- Tree is HASH(0x9c2114)
print "Tree is $tree \n";
print "------------------------\n";

############################################################################3
# 2. Print the $tree hash reference and all of the data it points to using Dumper
#
print Dumper $tree;


my %VARIABLES = ( '$x' => 8 );

############################################################################3
# 3. Call evaluate() function passing the hash tree as an argument.
#
my $result = evaluate( $tree );

$exp =~ s/\Q$_\E/$VARIABLES{$_}/ for keys %VARIABLES;
print "$exp = $result\n";


############################################################################3
#
# Parse function
#

# This lands at the parse function the first time: ("5 + 17 * $x - 3 ** 2")
sub parse
{
  local $_ = shift;			# 

  print "In parse() function:\n";
  
  if ( my ($left, $op, $right) = /(.+)([+-])(.+)/ )
  {
    # Call #1: $left is 5 + 17 * $x  $op is - $right is  3 ** 2
	# Call #2: $left is 5  $op is + $right is  17 * $x
    print "\tIn parse() if statement\n";
	print "\t\$left is $left\n";
	print "\t\$op is $op\n";
	print "\t\$right is $right\n";
	print "\n";
    return make_node( OP => parse($left), $op, parse($right) );		# 
  }
  elsif ( ($left, $op, $right) = m!(.*[^*])([*/])([^*].*)! )
  {
	# Call #4: $left is  17  $op is * $right is  $x
	
    print "\tIn parse() elsif #1 statement\n";
	print "\t\$left is $left\n";
	print "\t\$op is $op\n";
	print "\t\$right is $right\n";
	print "\n";
    return make_node( OP => parse($left), $op, parse($right) );
  }
  elsif ( ($left, $op, $right) = /(.+)(\*\*)(.+)/ )
  {
	# Call #7: $left is  3  $op is ** $right is  2
    print "\tIn parse() elsif #2 statement\n";
	print "\t\$left is $left\n";
	print "\t\$op is $op\n";
	print "\t\$right is $right\n";
	print "\n";
    return make_node( OP => parse($left), $op, parse($right) );
  }
  elsif ( my ($const) = /\A\s*(\d+)\s*\z/ )
  {
	# Call #3: $const is 5
	# Call #5: $const is 17
	# Call #8: $const is 3
	# Call #9: $const is 2
    print "\tIn parse() elsif #3 statement\n";
 	print "\t\$const is $const\n";
	print "\n";
    return make_node( CONST => $const );
  }
  elsif ( my ($var) = /\A\s*(\$\w+)\s*\z/ )
  {
    # Call #6:	$var is $x
    print "\tIn parse() elsif #4 statement\n";
 	print "\t\$var is $var\n";
	print "\n";
    return make_node( VAR => $var );
  }
  else
  {
    die "Error parsing '$_'\n";
  }
}


############################################################################3
#
# Make Node function
#

sub make_node
{
	my $type = shift;

	if ( $type eq 'CONST')
	{
		return shift;
	}
	elsif ( $type eq 'VAR')
	{
		return [ shift ];
	}
	

	my ($left, $op, $right) = @_;
	return { type => $type, left => $left, right => $right, op => $op };
}
#
############################################################################3


############################################################################3
#
# Evaluate function
#

sub evaluate
{
  my $node = shift;

	if (! ref $node )
	{
		return $node;
	}
	elsif ( ref $node eq 'ARRAY')
	{
		return $VARIABLES{ $node->[0]};
	}
	
	
	elsif ( $node->{type} eq 'OP' )
	{
		my ($left, $right) = map { evaluate( $node->{$_} ) } qw(left right);

		if ( $node->{op} eq '+' )
		{
		  return $left + $right;
		}
		elsif ( $node->{op} eq '-' )
		{
		  return $left - $right;
		}
		elsif ( $node->{op} eq '*' )
		{
		  return $left * $right;
		}
		elsif ( $node->{op} eq '/' )
		{
		  return $left / $right;
		}
		elsif ( $node->{op} eq '**' )
		{
		  return $left ** $right;
		}
    die "Unknown operator $node->{op}\n";
  }
  else
  {
    die "Unknown node type $node->{type}\n";
  }
}
#
############################################################################3

__END__
5 + 17 * $x - 3 ** 2