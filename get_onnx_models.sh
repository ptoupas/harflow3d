#!/bin/bash

# Download ONNX models from Google Drive
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Vkt43XSzCZPj5DrxFashsNzFzDoU1yaK' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Vkt43XSzCZPj5DrxFashsNzFzDoU1yaK" -O c3d.onnx && rm -rf /tmp/cookies.txt

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1is02J_nA9hod79visCLDIcSsVUZ7KREG' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1is02J_nA9hod79visCLDIcSsVUZ7KREG" -O slowonly.onnx && rm -rf /tmp/cookies.txt

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1WWasL3dVWoQLUcd5Q_5Gp0GRBklwtdD7' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1WWasL3dVWoQLUcd5Q_5Gp0GRBklwtdD7" -O r2plus1d_18.onnx && rm -rf /tmp/cookies.txt

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1hUcQMCTsS95FtugbsTantYz_s6Jrzu9S' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1hUcQMCTsS95FtugbsTantYz_s6Jrzu9S" -O r2plus1d_34.onnx && rm -rf /tmp/cookies.txt

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1gQLfVPFrChV3Rtx0S2cljvAQc9aADrAs' -O x3d_m.onnx


# Move models to the right directory where optimizer will look for them
mv *.onnx fpgaconvnet-optimiser/examples/models/