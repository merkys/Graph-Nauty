package Graph::Nauty::EdgeNode;

use strict;
use warnings;

use Data::Dumper;

$Data::Dumper::Sortkeys = 1;

use overload '""' => sub { return Dumper $_[0]->{bond} };

sub new {
    my( $class, $bond ) = @_;
    return bless { bond => $bond }, $class;
};

1;
