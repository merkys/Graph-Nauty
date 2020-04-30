package Nausparse;

use 5.026001;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Nausparse ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	SG_MINWEIGHT
	SG_WEIGHT
	SWG_DECL
	SWG_FREE
	SWG_INIT
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	SG_MINWEIGHT
	SG_WEIGHT
	SWG_DECL
	SWG_FREE
	SWG_INIT
);

our $VERSION = '0.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&Nausparse::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
	# Fixed between 5.005_53 and 5.005_61
#XXX	if ($] >= 5.00561) {
#XXX	    *$AUTOLOAD = sub () { $val };
#XXX	}
#XXX	else {
	    *$AUTOLOAD = sub { $val };
#XXX	}
    }
    goto &$AUTOLOAD;
}

require XSLoader;
XSLoader::load('Nausparse', $VERSION);

# Preloaded methods go here.

sub automorphism_group
{
    my( $graph ) = @_;

    my $nauty_graph = {
        nv  => scalar $graph->vertices,
        nde => scalar $graph->edges * 2, # as undirected
        e   => [],
    };
    my $n = 0;
    my $vertices = { map { $_ => { index => $n++, vertice => $_ } }
                         $graph->vertices };

    for my $v (map { $vertices->{$_}{vertice} }
               sort { $vertices->{$a}{index} <=>
                      $vertices->{$b}{index} } keys %$vertices) {
        push @{$nauty_graph->{d}}, scalar $graph->neighbours( $v );
        push @{$nauty_graph->{v}}, scalar @{$nauty_graph->{e}};
        for ($graph->neighbours( $v )) {
            push @{$nauty_graph->{e}}, $vertices->{$_}{index};
        }
    }

    my $statsblk = sparsenauty( $nauty_graph,
                                [ 0..$n-1 ],
                                [ ( 1 ) x $n ],
                                [ ( 0 ) x $n ],
                                1,
                                undef );
    return $statsblk->{grpsize1};
}

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Nausparse - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Nausparse;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Nausparse, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

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
