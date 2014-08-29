#!/usr/local/bin/perl
use strict;
use warnings;

# Manage a flat file database of historical share quotes (high, low, close).
# Retrieve all quotes for a given stock by ticker symbol and/or
# date range, remove entries by the same criteria, or add new entries.
# To satisfy some external constraints not enumerated here, we need to
# put each symbol's data in a separate file named after the symbol.

# Examples:
# ./review.pl -a -s GOOG -d 2011-02-12 -h 642 -l 610 -c 640   # Add
# ./review.pl    -s ORYL -d 2011-01-10:2011-01-20             # Fetch
# ./review.pl    -s APPL
# ./review.pl            -d 2011-03-11:2011-03-30
# ./review.pl -r -s GOOG -d 2011-04-09:2011-04-15             # Remove
use Getopt::Std;

run();

sub run
{
	my %opt = init();
	load_data();
	
	if ( $opt{a} )
	{
		add_item( @opt{ qw(s d h l c)} );
	}
	else
	{
		( $opt{r} ? \&remove_items : \&display_items ) -> ( @opt{ qw(s d)});
	}
	
	save_data() if $opt{a} || $opt{r};
}

sub init
{
	my $usage =  <<"EOT";
	Usage: $0 [-a -h high -l low -c close|-r] [-s symbol] [-d date|range]
EOT
	getopts( 'ac:d:h:l:rs:', \my %opt ) or die $usage;
	$opt{a} && $opt{f} and die "Can't have both -a and -r\n";
	$opt{s} && $opt{h} && $opt{l} && $opt{c}
		or die "Must have -s, -h,  -l, -c with -a\n" if $opt{a};
	if ( $opt{d} )
	{
		/\A\d{4}-\d{2}-\d{2}\z/ or die "Invalid date format" for split /:/, $opt{d};
	}
	return %opt;
}

sub display_items
{
	my ($symbol, $date) = @_;
	
	my $this_ref = subset_data( $symbol, $date);
	for my $symbol ( sort keys %$this_ref)
	{
		for my $date (sort keys %{ $this_ref->{$symbol} })
		{
			my $value_ref = $this_ref->{$symbol}{$date};
			print "$symbol $date @$value_ref\n";
		}
	}
}

{
	my $data_ref;
	
	sub add_item
	{
	
	my ($symbol, $date, $high, $low, $close) = @_;
	$data_ref->{$symbol}{$date} = [$high, $low, $close];
	}
	
	sub remove_items
	{
		my ($symbol, $date) = @_;
		
		my $this_ref = subset_data( $symbol, $date);
		for my $symbol( keys %$this_ref )
		{
			my @keys = keys %{ $this_ref->{$symbol} };
			delete @{ $data_ref->{$symbol} }{ @keys};
		}
	}
	
	sub subset_data
	{
		my ($symbol, $date) = @_;
		
		my $this_ref;
		
		if ( $symbol )
		{
			$this_ref->{$symbol} = $data_ref->{$symbol};
		}
		else
		{
			$this_ref = { %$data_ref };	#Copy so we can delete elements
		}
		
		if ($date)
		{
			for my $symbol ( keys %$this_ref )
			{
				my ($from, $to)		= date_to_range( $date );
				my @dates		= grep { $_ ge $from && $_ le $to}
					keys %{ $this_ref->{$symbol}};
				$this_ref->{$symbol} = { map { $_, $this_ref->{$symbol}{$_} } @dates};
			}
		}
	  	return $this_ref;
	  }
	  
	  sub load_data
	  {
	  	 for my $file ( data_files() )
	  	 {
	  	 	(my $symbol = $file) =~ s/\.sym//;
	  	 	$data_ref->{$symbol} = read_file( $file );
	  	 }
	  }
	  
	  
	  sub save_data
	  {
	  	unlink data_files();
	  	while ( my ($symbol, $sym_ref) = each %$data_ref )
	  	{
	  		next unless keys %$sym_ref;
	  		open my $fh, '>', "$symbol.sym" or die "Open $symbol.sym: $!\n";
	  		for my $date ( sort keys %$sym_ref )
	  		{
	  			print {$fh} "$date @{ $sym_ref->{$date} }\n";
	  		}
	  	}
	  }
   }
	  
	  sub data_files { return glob "*.sym" }
	  
	  sub date_to_range
	  {
	  	my $date = shift;
	  	
	  	return $date =~ /(.*):(.*)/ ? ($1, $2) : ($date, $date);
	  }
	  
	  sub read_file
	  {
	  	my $filename = shift;
	  	
	  	my %symbol_data;
	  	
	  	open my $fh, '<', $filename or die "open $filename: $!\n";
	  	while ( <$fh> )
	  	{
	  		chomp;
	  		my ($date, $high, $low, $close) = split;
	  		$symbol_data{$date} = [$high, $low, $close];
	  	}
	  	return \%symbol_data;
	  }
	  
	  
	  
	  
	  
	  	
	
			

