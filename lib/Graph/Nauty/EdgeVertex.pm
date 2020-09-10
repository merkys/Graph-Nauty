package Graph::Nauty::EdgeVertex;

use strict;
use warnings;

# VERSION

use Data::Dumper;

$Data::Dumper::Sortkeys = 1;

use overload '""' => sub { return Dumper $_[0]->{attributes} };

sub new {
    my( $class, $attributes ) = @_;
    return bless { attributes => $attributes }, $class;
};

1;
