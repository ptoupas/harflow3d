# HARFLOW3D

A tool for automated mapping and optimization of 3D-CNNs for HAR onto FPGA devices

## Cloning the repository
In order to clone the repository, you can use the following command:

```
git clone --recurse-submodules https://github.com/ptoupas/harflow3d.git
```

## Requirements

To use this tool, you will need to meet the following requirements:

- Python 3.9 or higher
- Install python packages listed in `requirements.txt`
- Install system dependencies listed in the relevant section below
- Install fpgaconvnet-optimizer and fpconvnet-model packages as described in the relevant section below

## Python dependencies

To install the necessary Python packages, you can use `pip`. Navigate to the root directory of the repository and execute the following command:

```
pip install -r requirements.txt
```

This will install all the required Python packages specified in the `requirements.txt` file.

## System dependencies
`update this section`

## Installing fpgaconvnet-optimizer and fpgaconvnet-model

The `harflow3d` tool uses the `fpgaconvnet-optimizer` and `fpgaconvnet-model` packages to map and optimize 3D-CNNs for HAR onto FPGA devices. These packages are included as submodules in the `harflow3d` repository. To install them, you should first initialize the submodules (in case you haven't cloned the repository with the `--recurse-submodules` flag):
```
git submodule update --init --recursive
```

Then, (from the root directory) navigate to the `fpgaconvnet-optimizer` directory and install the package:
```
cd fpgaconvnet-optimizer
pip install .
```

Finally, (from the root directory) navigate to the `fpgaconvnet-model` directory and install the package:
```
cd fpgaconvnet-model
pip install .
```

## Usage

Once you have installed the necessary dependencies or set up Docker, you can use the `harflow3d` tool to map and optimize 3D-CNNs for HAR onto FPGA devices.

### Step 1: Download ONNX model files

To use the `harflow3d` tool, you first need to download the necessary ONNX model files. We have provided a script named `get_onnx_models.sh` to help you with this. The script will download the following models:

- x3d_m
- c3d
- slowonly
- r2plus1d_18
- r2plus1d_34

The models will be stored in the correct folder of the `fpgaconvnet-optimizer` submodule, which is located in the `fpgaconvnet-optimiser/examples/models` directory.

To run the script, simply navigate to the root directory of the `harflow3d` repository and execute the following command:

```
./get_onnx_models.sh
```

### Step 2 (optional): Re-configure the opimizer configuration

The `fpgaconvnet-optimizer` package provides a configuration file that allows you to specify the mapping and optimization parameters. The configuration file is located in the `fpgaconvnet-optimiser/examples/` directory. The default configuration file is named `latency_optimiser_example.toml`. You can edit this file to change the mapping and optimization parameters.

### Step 3: Run the optimizer

To run the optimizer you should navigate to the fpconvnet-optimizer directory and run the following command:

```
cd fpgaconvnet-optimizer
./run_optimizer.sh
```
The `run_optimizer.sh` script will run the optimizer with the default configuration file (the one described in step 2). The script accepts the following arguments:

- `-p`. This argument allows you to specify the target FPGA platform to use. The default value is `zcu104`. You can define more than one device and the optimizer will generate one design for each FPGA platform defined. You can do that as follows ``` -p "zcu104 zcu102"```. The supported FPGA platforms are the following:
    - `vus440`
    - `vc707`
    - `vc709`
    - `zc706`
    - `zcu102`
    - `zcu104`
- `-m`. This argument allows you to specify the model to use. The default value is `c3d`. You can define more than one model and the optimizer will generate one design for each model defined. You can do that as follows ``` -m "x3d_m c3d"```. The supported models are the following:
    - `x3d_m`
    - `c3d`
    - `slowonly`
    - `r2plus1d_18`
    - `r2plus1d_34`
- `-n`. This argument allows you to specify the number of times each pair of FPGA-Model will be executed. The default value is `1`. For each pair of FPGA-Model, the optimizer will generate a design and run it `n` times.

### Step 4: Review the results
The results of the optimization process will be stored in a wandb project named after the name of the tool (harflow3d) followed by the name of the model with a postfix "latency". For example, if you run the optimizer for c3d model, the results will be stored in a wandb project named `harflow3d-c3d-latency`. The wandb project can be accessed by clicking [here](https://wandb.ai/fpgaconvnet/projects). You can find your run by using the filters and tools provided by wandb. For example, you can filter the runs by model name, platform name, etc. You can also use the wandb tools to compare the results of different runs.

# Docker setup

Alternatively, you can use Docker to run this tool. Docker allows you to run the tool in a self-contained environment without worrying about dependencies or system configuration.

To use this tool with Docker, follow these steps:

1. Install Docker on your system (if you haven't already).
2. Clone the repository and navigate to the docker folder `./docker`.
3. Build the Docker image:

```
docker build -t harflow3d .
```

This will start a container and give you access to a shell inside the container. From there, you can run the `harflow3d` tool as usual.

Note: If you need to mount a local directory inside the container (for example, to access input data or output files), you can use the `-v` flag when running the `docker run` command. See the Docker documentation for more information.
