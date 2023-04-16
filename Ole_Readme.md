### Some stuff to help me keep track of the repo

Run information seems to be stored in both the wandb and runs directory.

## What is saved by wandb?

In the 'cloud', wandb saves a `config.yaml` file which contains the hyperparameters used for the run. It also saves a file called `wandb-metadata.json` which contains some git related info. The best model is also saved, along with the model's architecture. There's also a summary of the best performance of the model.

From what I can tell, this is exactly what is saved locally too, so no need to worry about backing this up.

From what I can tell, there is also no pertinent information in the 'runs' folder. The runs folder contains very similar information to the wandb folder, essentially don't think I need to worry about saving it.

## How is information from training experiments saved?

It's all automatically logged to wandb! This includes loss, validation loss, best model, hyper-parameters, task description etc.

If we want to save more information during training, will have to mess around with the wandb logging! Currently seems unlikely, however.

## How is information from analysis experiments saved?

Not logged to wandb! The general setup looks like:
1. All describers we might want to run experiments on are loaded from the wandb directory (by loading the relevant information from the config file, as well as the weights etc.). Describers are filtered by looking at the number of epochs trained for, and whether they have a config file. This is pretty loose, so I think that essentially all describers are loaded. This involves using the 'load_describer' method in the DescribersLoader class, from the describers_utils.py file.

2. The analyse_describers script (in main) uses these loaded describers, alongside the relevant contrastive datasets, before the analysis task of our choice is called.

3. In the example of compute_masked_accuracies.run, the accuracy is computed for each describer, before being added to the self.items variable. If an existing csv file is found, this is loaded from this. The program then works by extending the existinh csv file. (If the accuracy for the describer has already been computed (or some describer with epsilon close masking proportion) in the csv, it is skipped)

4. The csv file is saved in the experiments/contrastive directory I think. I'll leave this as the default for now.

I am going to try to follow as similar a blueprint to this as possilbe for my experiments.

## Stuff I don't know

1. Sometimes json files are mentioned, sometimes csv files. Which are actually used for saving the results of analysis experiments?

2. Workout how to use / format the datasets, especially since we don't need a contrastive dataset for the encodings experiments.

## How to train on GPUs

Need to add lines that look like this to the end of the ~/.bashrc file:

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:<CUDA_PATH>/lib64:<CUDNN_PATH>/lib64
export PATH=$PATH:<CUDA_PATH>/bin

This is because the CUDA libraries are not in the default path. If the training is not occurring on a GPU, should look at CUDA issues!

