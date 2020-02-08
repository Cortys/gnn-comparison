#!/usr/bin/env bash

cd "${BASH_SOURCE%/*}" || exit

# All datasets and configs:
datasets="NCI1 PROTEINS DD REDDIT-BINARY IMDB-BINARY"
# configs=$(ls ./config_*.yml)
configs="baseline config_GIN.yml"

if [ ! -z "$1" ]; then
	if [[ "$1" == "baseline" ]]; then
		configs="baseline"
	else
		configs="config_$1.yml"
	fi
fi

if [ ! -z "$2" ]; then
	datasets=$2
fi

function launchExp() {
	local config=$1;
	local ds=$2

	if [ "$config" == "baseline" ]; then
		if [ "$ds" == REDDIT* ]; then
			config="config_BaselineSocial.yml"
		elif [ "$ds" == IMDB* ]; then
			config="config_BaselineIMDB.yml"
		elif [ "$ds" == "ENZYMES" ]; then
			config="config_BaselineENZYMES.yml"
		else
			config="config_BaselineChemical.yml"
		fi
	fi

	echo "Starting experiment with config $config and dataset $ds..."
	python Launch_Experiments.py --config-file $config --dataset-name $ds --debug
	echo "Completed experiment with config $config and dataset $ds."
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
