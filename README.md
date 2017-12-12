## EEG analysis pipeline
This repo contains a pipeline for:
1. Preprocessing
2. Statistical analysis

of ERP data. The pipeline is implemented in MATLAB and depends on the freely available EEGLab for preprocessing and Fieldtrip for statistical analysis.

### Pre-processing
1. Re-referencing
2. Epoching
3. Removing bad epochs
3. Baseline removal
4. Bandpass filtering
5. Semi-automatic artifact removal (signal reconstruction) using ICA

### Statistical Analysis
1. Grand average of epochs
2. Non-parametric statistical testing
