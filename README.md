# AGNs

## Description

This repo contains an implementation of the *Adversarial Generative 
Nets (AGNs)*, from the paper referenced in the documentation.

## Data and models

Before you can run the code, you need to download the missing models and place them in the models folder (link: 
<https://www.dropbox.com/sh/ue7q46qwdtk1jy9/AACYb3pgApEDB5vJfT5iXPkja?dl=0>)


## Instructions for running

The attack code (see under `code/agn*.m`) takes as input face images that are 
aligned to VGG's canonical pose. For physical attacks, the aligned 
images should also contain green marks that are used for aligning the 
eyeglasses to the face image (see examples in `data/demo-data2/`).
See `demo.m` for examples of how to run attacks. 

For the purpose of the demo, aligned images are provided with the code.
To align new images, you can use the face- and landmark- detection, and 
face-alignment code under `dependencies/image-registration/`. Before
running the code, you need to update the paths in the files
`face_landmark_detection.m` and `openface_align.m`.  See `align_demo.m` 
for a face-alignment example.

## Reference

If you use the code, please cite our paper:

```
@article{Sharif19AGNs,
  author =       {Mahmood Sharif and Sruti Bhagavatula and 
  					  Lujo Bauer and Michael K. Reiter},
  title =        {A general framework for adversarial examples 
  					  with objectives},
  journal =      {ACM Transactions on Privacy and Security},
  year =         2019
}
```
