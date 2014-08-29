#!/usr/bin/perl
use strict;
use warnings;

 

my $text = <<'END_OF_TEXT';
Love, love me do.		# 2
You know I love you,		# 1
I'll always be true,
So please, love me do.		# 1
Whoa, love me do.		# 1

Love, love me do.		# 2
You know I love you,		# 1
I'll always be true,	
So please, love me do.		# 1
Whoa, love me do.		# 1

Someone to love,		# 1
Somebody new.
Someone to love,		# 1
Someone like you.

Love, love me do.		# 2
You know I love you,		# 1
I'll always be true,		
So please, love me do.		# 1
Whoa, love me do.		# 1

Love, love me do.		# 2
You know I love you,		# 1
I'll always be true,
So please, love me do.		# 1
Whoa, love me do.		# 1
Yeah, love me do.		# 1
Whoa, oh, love me do		# 1
END_OF_TEXT

$text = lc($text);
 
my %count;
foreach my $line ( split "\n", $text )
{
   	# \s is match all whitespace
  	# i means ignore case
  
  	foreach my $word ( split ("[, ]", $line ) )
  	{
		$count{$word}++;
	}		
}

	print "'love' occurs $count{love} times\n";
	print "'love,' occurs $count{'love,'} times\n";


# Comments:
# That'll work in part, but you're misunderstanding alternation: you don't want 'I' or '+' in a character class. 
# Rewrite the regex to match one or more whitespace or comma characters.

# That's still not doing what you're thinking: it now splits on parentheses a literal space and then any whitespace. 
# Any character you place within the brackets of a character class are used. Metacharacters aren't able to be used 
# within a character class. So simplify the split even more to just split on a comma or whitespace.


 


 



