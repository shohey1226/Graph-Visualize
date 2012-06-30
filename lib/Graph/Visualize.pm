package Graph::Visualize;
#===============================================================================
#  FILE: Visualize.pm
#  DESCRIPTION: 
#===============================================================================
use strict;
use warnings;

#use Graph::Base;
use Graph;
#use Graph::Directed;
#use Graph::Undirected;
use GraphViz2;
use Moose;

has 'graph' => (is => 'rw', isa => 'Graph', required => 1);
has 'format' => (is => 'rw', isa => 'Str', default => 'png');
has 'filename' => (is => 'rw', isa => 'Str', required => 1);
has 'dir' => (is => 'rw', isa => 'Str', default => './');

no Moose;
__PACKAGE__->meta->make_immutable;

sub output {

    my ($self) = @_;

    my $g = $self->graph;

    # Set flag
    my $directed_flag = 0; 
    if ($g->is_directed()) {
        $directed_flag = 1;
    }

    my $gv2 = GraphViz2->new(
        #edge   => {color => 'grey'},
        global => {directed => $directed_flag},
        #graph  => {label => 'Adult', rankdir => 'TB'},
        #logger => $logger,
        #node   => {shape => 'oval'},
    );

    # Add nodes
    for my $node ($g->vertices){
        $gv2->add_node(name => $node);
    }

    # Add edges
    for my $v ($g->vertices){
        my ($s, $t) = $g->in_edges($v);
        if( defined $s && defined $t){
            $gv2->add_edge(from => $s, to => $t);
        }
    }

    # Output to image file
    my $dir = $self->dir;
    my $format = $self->format;
    my $filename = $self->filename;
    $filename .= "\.$format" if($filename !~ /\.$format$/);

    $gv2->run ( format => $format, output_file => "$dir/$filename");



    ##$g->add_node('London');
    ##$g->add_node('Paris', label => 'City of\nlurve');
    ##$g->add_node('New York');

    ##$g->add_edge('London' => 'Paris');
    ##$g->add_edge('London' => 'New York', label => 'Far');
    ##$g->add_edge('Paris' => 'London');

    ##open FILE, ">test.png";
    ##print FILE $g->as_png;
    ##close FILE;
    
}

 
1;
