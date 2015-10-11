
in_bedpe=$1
out=$2
output_type=$3
GRAPHLET_NODES=$4

if [[ "$#" -lt 1 ]]
then
    echo "USAGE: bedpe_to_graphlet_counts.sh <in_bedpe> <out> <output_type>"
    echo "Assumes the graph is given as it is. So if you want to set a value threshold, you need to do it outside of this code"
    echo "in_bedpe"
    echo "out = prefix."
    echo "output_type = can be fascia or orca, depening on which software will be used. For now, only orca is supported."
    echo "GRAPHLET_NODES = can be 4 or 5 for orca"
    exit
fi

out_graph=${out}.${output_type}.graph
out_counts=${out}.${output_type}.counts
out_plot=${out}.${output_type}.plot

#make the graph
echo "making graph"
bedpe_to_graph.sh ${in_bedpe} ${out} ${output_type} 

#count the graphlets
echo "counting graphlets"
orca.exe ${GRAPHLET_NODES} ${out_graph} ${out_counts}

#plot the graphlets
echo "plotting graphlet counts"
Rscript /srv/scratch/oursu/code/genome_utils/3Dutils/reproducibility/graphlets/plot_graphlet_counts.R ${out_counts} ${out_plot}

echo "DONE graphlet analysis"
