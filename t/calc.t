use strict;
use warnings;
use Test::More tests => 1;

use Nausparse;

my $n = 5;
my @e = ( 0 ) x $n;
for (0..$n-1) {
    $e[2*$_]   = ($_ + $n - 1) % $n; # edge i->i-1
    $e[2*$_+1] = ($_ + $n + 1) % $n; # edge i->i+1
}

my $sparse = {
    nv  => $n,
    nde => 2 * $n,
    v   => [ map { 2 * $_ } 0..$n-1 ],
    d   => [ ( 2 ) x $n ],
    e   => \@e,
};
my $arr = [ ( 0 ) x $n ];

Nausparse::sparsenauty( $sparse,
                        [ ( 0 ) x $n ],
                        [ ( 0 ) x $n ],
                        [ ( 0 ) x $n ],
                        1,
                        1,
                        $sparse );
ok( 1 == 1 );
