#!/usr/bin/perl
use strict;
use warnings;

my %sold;
if ( @ARGV > 2 && shift eq "-s" )
{
  my $sales_file = shift;
  my ( @saved_argv ) = @ARGV;
  @ARGV = $sales_file;

  # First cut through the sales_report_sales file
  while ( defined( my $line = <> ) )
  {
    chomp $line;
        
    my ($quantity, $item) = split " ", $line, 2;
    $sold{$item} = $quantity;
  }
  
  # Now, dump the store_report.csv aka the inventory into the @ARGV array
  @ARGV = @saved_argv;
}
else
{
  die "Usage: $0 -s sales_file inventory file...\n";
}

my (%item_cost, %inventory);
while ( defined( my $line = <> ) )
{
  chomp $line;
  
  # This logic replaces my other string eq logic 
  if ( $. == 1 )
  {
  	next ;
  }
   

  my ($cost, $quantity, $item) = split ",", $line, 3;
  $item_cost{$item} = $cost;
  $inventory{$item} = $quantity;
  
  	    if ( $inventory{$item} < 0 )
	    {
	    	print "Please stock up on $item look at line " . $. . " of the inventory report where the quantity is negative\n\n";
 	    }

}

 
foreach my $item ( keys %sold )
{ 
  if ( exists $inventory{$item} )
  {
	    $inventory{$item} -= $sold{$item};
  }
  else
  {
    warn "*** Sold $sold{$item} of $item, which were not in inventory\n";
  }
}

foreach my $item ( sort keys %item_cost )
{


  printf "%5.2f %6d %s\n", $item_cost{$item}, $inventory{$item}, $item;
}



