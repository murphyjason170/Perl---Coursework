package Music::CD;

use lib qw(/users/jmurphy3/mylib/lib/perl5);

use Moose;

has songs => (isa => 'ArrayRef[Music::Song]', is => 'rw');
has title => (isa => 'Str', is => 'rw');
has id => (isa => 'Int', is => 'ro' );

with 'StringFuncs';

sub length
{
	my $self = shift;
	my $total = 0;
	for my $song ( @{ $self->songs })
	{
		$total += $song->length;
	}
	return $total;
}

1;
