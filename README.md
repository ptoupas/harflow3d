[![DOI](https://zenodo.org/badge/625183669.svg)](https://zenodo.org/badge/latestdoi/625183669)
<div>
<a href="https://www.fccm.org/artifact-evaluation-2023/" title="FCCM Artifact Evaluation Badge"><img src="https://github.com/ptoupas/harflow3d/blob/main/resources/ORO_FCCM_badge.png" width="30px" alt="ORO badge"></a> FCCM'23 Artifact Evaluation ORO Badge
</div>
<div>
<a href="https://www.fccm.org/artifact-evaluation-2023/" title="FCCM Artifact Evaluation Badge"><img src="https://github.com/ptoupas/harflow3d/blob/main/resources/ROR_FCCM_badge.png" width="30px" alt="ROR badge"></a> FCCM'23 Artifact Evaluation ROR Badge
</div>

# HARFLOW3D

A tool for automated mapping and optimization of 3D-CNNs for HAR onto FPGA devices

<div align="center">
  <img src="https://github.com/ptoupas/harflow3d/blob/main/resources/dataflow_harflow3d.png" width="500px"/><br>
    <p style="font-size:1.5vw;">High level description of the HARFLOW3D framework and its connections to other tools and frameworks</p>
</div>


<div align="center">
  <img src="https://github.com/ptoupas/harflow3d/blob/main/resources/resource_performance_pareto.gif" width="500px"/><br>
    <p style="font-size:1.5vw;">Resources (LUT, DSP, FF, BRAM) against Latency graphs during the Design Space Exproration</p>
</div>

## Cloning the repository
In order to clone the repository, you can use the following command:

```
git clone --recurse-submodules https://github.com/ptoupas/harflow3d.git
```

## Requirements

To use this tool, you will need to meet the following requirements:

- Python 3.9 or higher
- Install python packages listed in `requirements.txt`
- Install fpgaconvnet-optimiser and fpconvnet-model packages as described in the relevant section below

## Python dependencies

To install the necessary Python packages, you can use `pip`. Navigate to the root directory of the repository and execute the following command:

```
cd harflow3d
pip install -r requirements.txt
```

This will install all the required Python packages specified in the `requirements.txt` file.


## Installing fpgaconvnet-optimiser and fpgaconvnet-model

The `harflow3d` tool uses the `fpgaconvnet-optimiser` and `fpgaconvnet-model` packages to map and optimize 3D-CNNs for HAR onto FPGA devices. These packages are included as submodules in the `harflow3d` repository. To install them, you should first initialize the submodules (in case you haven't cloned the repository with the `--recurse-submodules` flag):
```
git submodule update --init --recursive
```

Then, (from the root directory) navigate to the `fpgaconvnet-optimiser` directory and install the package:
```
cd fpgaconvnet-optimiser
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

The models will be stored in the correct folder of the `fpgaconvnet-optimiser` submodule, which is located in the `fpgaconvnet-optimiser/examples/models` directory.

To run the script, simply navigate to the root directory of the `harflow3d` repository and execute the following command:

```
./get_onnx_models.sh
```

### Step 2 (optional but **highly recommended**): Initialize wandb

The `harflow3d` tool uses [wandb](https://wandb.ai/site) to store the results of the optimization process. For the best experience and visualization of the results, we recommend that you use wandb. It will provide you with a dashboard with very detailed information about the optimization process and the interpretation of the results.
To use wandb, you need to create an account and initialize it. After you have created an account, you can initialize wandb by running the following command:

```
wandb login or wandb init
```
This will promt you to enter your wandb API key. You can find your API key by clicking on your profile picture in the top right corner of the wandb dashboard and then clicking on the "Settings" button. You can find more information about wandb initialization [here](https://docs.wandb.ai/quickstart). Note that this step **only needs to be done once**.

### Step 3 (optional): Re-configure the opimizer configuration

The `fpgaconvnet-optimiser` package provides a configuration file that allows you to specify the mapping and optimization parameters. The configuration file is located in the `fpgaconvnet-optimiser/examples/` directory. The default configuration file is named `latency_optimiser_example.toml`. You can edit this file to change the mapping and optimization parameters.

### Step 4: Run the optimiser

To run the optimiser you should navigate to the fpconvnet-optimiser directory and run the following command:

```
cd fpgaconvnet-optimiser
./run_optimiser.sh
```
The `run_optimiser.sh` script will run the optimiser with the default configuration file (the one described in step 2). The script accepts the following arguments:

- `-p`. This argument allows you to specify the target FPGA platform to use. The default value is `zcu104`. You can define more than one device and the optimiser will generate one design for each FPGA platform defined. You can do that as follows ``` -p "zcu104 zcu102"```. The supported FPGA platforms are the following:
    - `vus440`
    - `vc707`
    - `vc709`
    - `zc706`
    - `zcu102`
    - `zcu104`
- `-m`. This argument allows you to specify the model to use. The default value is `c3d`. You can define more than one model and the optimiser will generate one design for each model defined. You can do that as follows ``` -m "x3d_m c3d"```. The supported models are the following:
    - `x3d_m`
    - `c3d`
    - `slowonly`
    - `r2plus1d_18`
    - `r2plus1d_34`
- `-n`. This argument allows you to specify the number of times each pair of FPGA-Model will be executed. The default value is `1`. For each pair of FPGA-Model, the optimiser will generate a design and run it `n` times.

### Step 5: Review the results
The results of the optimization process will be stored in a wandb project named after the name of the tool (harflow3d) followed by the name of the model with a postfix "latency". For example, if you run the optimiser for c3d model, the results will be stored in a wandb project named `harflow3d-c3d-latency`. The wandb project can be accessed by clicking [here](https://wandb.ai/fpgaconvnet/projects). You can find your run by using the filters and tools provided by wandb. For example, you can filter the runs by model name, platform name, etc. You can also use the wandb tools to compare the results of different runs.

### Step 6 (optional): Obtaining FPGA Bitstream and Host Code
After the final configuration of the 3D CNN model is produced by the optimizer, you can request the bitstream and host code necessary to execute the model on a specific FPGA device. To obtain these files, you will need to provide us with the configuration file which can be found under the `fpgaconvnet-optimizer/outputs/{model_name}/{platform_name}/config.json` or the link of the specific run from the `wandb` project page.

Upon request we will generate the bitstream and host code for you using our closed-source backend tool that translates the given configuration of the layers into hardware IPs. We integrate the layers IPs into our proposed Vivado design and provide the final bitstream. Please note that this service is provided on a best-effort basis, and the timeframe for generating the bitstream and host code may vary depending on the complexity of the model and the current workload.

If you are interested in obtaining the bitstream and host code for your model, please contact us at [p.toupas21@imperial.ac.uk or alexander.montgomerie-corcoran15@imperial.ac.uk].

# Docker setup

Alternatively, you can use Docker to run this tool. Docker allows you to run the tool in a self-contained environment without worrying about dependencies or system configuration.

To use this tool with Docker, follow these steps:

1. Install Docker on your system (if you haven't already).
2. Clone the repository and navigate to the root folder `harflow3d`.
3. Download the ONNX model files (see step 1 above).
4. Build the Docker image:

```
docker build -t harflow3d -f docker/Dockerfile .
```

This will build a Docker image named `harflow3d` using the `Dockerfile` in the `docker` directory.

5. Run the Docker image:

To run the Docker image, you can use the following command:

```
docker run -it --rm harflow3d /bin/bash
```

This will start a container and give you access to a shell inside the container. From there, you can run the `harflow3d` tool as usual (see step 4 above). Remember that you will need to initialize wandb inside the container with your API key as explained above in step 2.

# Citation

If you find this project useful in your research, please consider cite:

```BibTeX
@inproceedings{toupas2023harflow3d,
  title={HARFLOW3D: A Latency-Oriented 3D-CNN Accelerator Toolflow for HAR on FPGA Devices}, 
  author={Toupas, Petros and Montgomerie-Corcoran, Alexander and Bouganis, Christos-Savvas and Tzovaras, Dimitrios},
  booktitle={2023 IEEE 31st Annual International Symposium on Field-Programmable Custom Computing Machines (FCCM)}, 
  year={2023},
  pages={144-154},
  doi={10.1109/FCCM57271.2023.00024}
}
```
