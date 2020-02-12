#!/usr/bin/env bash

cd "${BASH_SOURCE%/*}" || exit

# Synthetic:
python PrepareDatasets.py SYN_DATA --dataset-name noisy_triangle_classification_dataset --use-one --outer-k 10
python PrepareDatasets.py SYN_DATA --dataset-name balanced_triangle_classification_dataset --use-one --outer-k 10

# Chemical:
python PrepareDatasets.py DATA --dataset-name NCI1 --outer-k 10
python PrepareDatasets.py DATA --dataset-name DD --outer-k 10
python PrepareDatasets.py DATA --dataset-name PROTEINS --outer-k 10

# Social:
python PrepareDatasets.py DATA --dataset-name REDDIT-BINARY --use-one --outer-k 10
python PrepareDatasets.py DATA --dataset-name IMDB-BINARY --use-one --outer-k 10
