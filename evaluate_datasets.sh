#!/usr/bin/env bash

cd "${BASH_SOURCE%/*}" || exit

# All datasets and configs:
datasets="NCI1 PROTEINS DD REDDIT-BINARY IMDB-BINARY"
configs=$(ls ./config_*.yml)

if [ ! -z "$1" ]; then
	configs="config_$1.yml"
fi

if [ ! -z "$2" ]; then
	datasets=$2
fi

function launchExp() {
	echo "Starting experiment with config $1 and dataset $2..."
	python Launch_Experiments.py --config-file $1 --dataset-name $2 --debug
	echo "Completed experiment with config $1 and dataset $2."
}

echo "Launched evalutation."
echo "Configs: $configs"
echo "Datasets: $datasets"

for config in $configs; do
	for dataset in $datasets; do
		launchExp $config $dataset
	done
done

echo "Done."
