FROM python:3.10.11

RUN apt-get update && apt-get install -y git

# Create venv
RUN python3 -m venv /opt/py310
# Enable venv
ENV VIRTUAL_ENV /opt/py310
ENV PATH /opt/py310/bin:$PATH

RUN git clone --recurse-submodules https://github.com/ptoupas/harflow3d.git
WORKDIR /harflow3d

RUN pip3 install -r requirements.txt

RUN cd fpgaconvnet-optimiser && pip3 install .
RUN cd fpgaconvnet-model && pip3 install .

ADD fpgaconvnet-optimiser/examples/models fpgaconvnet-optimiser/examples/models