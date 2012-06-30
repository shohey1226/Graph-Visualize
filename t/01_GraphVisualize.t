#===============================================================================
#  FILE: 01_GraphVisualize.t
#  DESCRIPTION: 
#===============================================================================

use strict;
use warnings;

use Test::More tests => 3;                      # last test to print
use lib "lib/";

BEGIN { 
    use_ok( 'Graph' ); 
    use_ok( 'GraphViz2' ); 
    use_ok( 'Graph::Visualize' ); 
}

my $g = new Graph;

$g->add_vertices(qw/a b c d e/);
$g->add_edge('a', 'b');
$g->add_edge('b', 'c');
$g->add_edge('b', 'd');
$g->add_edge('a','a');

my $gv = new Graph::Visualize(graph => $g, filename => 'test', dir => "public/" );
$gv->output;




