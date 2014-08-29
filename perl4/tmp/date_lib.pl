sub date_string
{
	my ($epoch, $format) = @_;
	
	$format or warn "Using default format\n" and $format = "%d-%b-%y";
	my @names = qw(S M H d m y w Y I);
	my %part = map { shift @names, $_ } localtime $epoch;
	
	my $i = 0;
	my %month_name = map { ++$i, $_ }
		qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
		
	$part{m}++;
	$part{b} = $month_name{ $part{m} };
	$part{y} += 1900;
	$_ = sprintf "%02d", $_ for @part { qw (S M H d m) };
	$format =~ s/%([SMHdmywb])/$part{$1}/g;
	return $format;
}
1;
