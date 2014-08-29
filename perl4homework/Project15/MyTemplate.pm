package MyTemplate;
use strict;
use warnings;

use base 'HTML::Template';

use CGI qw(header);
use File::Basename;

sub new
{
  # gets the basename of the file and saves it into $basename
  my ($basename) = fileparse( $0, '.cgi' );  
  
  # calls the HTML::Template superclass new method and passes it 2 arguments
  return shift->SUPER::new( 
  			    filename		=> "$basename.tmpl",
  			    die_on_bad_params 	=> 0 
  			  );
}

# Overrides the HTML::Template html_output method and calls the superclass
# output method. 
# output does all of the <TMPL_VAR NAME=name> replacements in the atm_select.tmpl file
sub html_output
{
	# returns the final format of the template
	return header() . (shift->SUPER::output);
}

1;
  			    
  			    