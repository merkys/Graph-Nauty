package Graph::Nauty;

use strict;
use warnings;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw( automorphism_group orbits );

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Graph::Nauty', $VERSION);

# Preloaded methods go here.

sub _nauty_graph
{
    my( $graph, $color_sub ) = @_;

    $color_sub = sub { "$_[0]" } unless $color_sub;

    my $nauty_graph = {
        nv  => scalar $graph->vertices,
        nde => scalar $graph->edges * 2, # as undirected
        e   => [],
    };

    my $n = 0;
    my $vertices = { map { $_ => { index => $n++, vertice => $_ } }
                     sort { $color_sub->( $a ) cmp $color_sub->( $b ) ||
                            $a cmp $b}
                         $graph->vertices };

    my @breaks;
    my $prev;
    for my $v (map { $vertices->{$_}{vertice} }
               sort { $vertices->{$a}{index} <=>
                      $vertices->{$b}{index} } keys %$vertices) {
        push @{$nauty_graph->{d}}, scalar $graph->neighbours( $v );
        push @{$nauty_graph->{v}}, scalar @{$nauty_graph->{e}};
        push @{$nauty_graph->{original}}, $v;
        for ($graph->neighbours( $v )) {
            push @{$nauty_graph->{e}}, $vertices->{$_}{index};
        }
        if( defined $prev ) {
            push @breaks, int($color_sub->( $prev ) eq $color_sub->( $v ));
        }
        $prev = $v;
    }
    push @breaks, 0;

    return ( $nauty_graph, [ 0..$n-1 ], \@breaks, [ ( 0 ) x $n ] );
}

sub automorphism_group
{
    my( $graph, $color_sub ) = @_;

    my $statsblk = sparsenauty( _nauty_graph( $graph, $color_sub ),
                                1,
                                undef );
    return $statsblk->{grpsize1};
}

sub orbits
{
    my( $graph, $color_sub ) = @_;

    my( $nauty_graph, $labels, $breaks, $orbits ) =
        _nauty_graph( $graph, $color_sub );
    my $statsblk = sparsenauty( $nauty_graph, $labels, $breaks, $orbits,
                                1,
                                undef );
    my @orbits;
    for my $i (0..$#{$statsblk->{orbits}}) {
        push @{$orbits[$statsblk->{orbits}[$i]]},
             $nauty_graph->{original}[$i];
    }
    return grep { defined } @orbits;
}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Graph::Nauty - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Graph::Nauty;

=head1 DESCRIPTION

Stub documentation for Graph::Nauty, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

=head2 EXPORT

None by default.

=head2 Exportable constants

  SG_MINWEIGHT
  SG_WEIGHT
  SWG_DECL
  SWG_FREE
  SWG_INIT



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Andrius Merkys, E<lt>merkys@Ecpan.org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2020 by Andrius Merkys

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.26.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
