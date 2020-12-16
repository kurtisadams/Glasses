# AGNs

## Description

This repo contains an implementation of the *Adversarial Generative 
Nets (AGNs)*, from the paper referenced in the documentation.

## Data and models

Before the a pair of glasses can be generated, you need to:
1. Download the missing models and place them in the models folder 
  (link: <https://www.dropbox.com/sh/ue7q46qwdtk1jy9/AACYb3pgApEDB5vJfT5iXPkja?dl=0>).
2. Download and install Matlab on the device. 
3. Install the required dependencies from Matlab that need instillation, 
  (Matlab should prompt you to install the required dependencies.)
4. Run 'init.m' 
5. Run 'demo.m' (this should alert if anything else is needed.)


## Instructions for running

## Alignment

The attack code programs take face images as their inputs. These images need to be 
aligned to VGG's canonical pose. 

When using the physical attack programs, the aligned 
images should also contain green marks that are used for aligning the 
eyeglasses to the face image (see examples below and in `data/demo-data2/`).

![alt text](https://i.imgur.com/XAkQzAU.jpg)

To align the images that will be used for the programs, utilize the align program.
Before running the code, you need to update the paths in the files
`face_landmark_detection.m` and `openface_align.m`.  

![alt text](https://i.imgur.com/3pulOGS.png)

## Processing of Aligned Photos

After running the images through the alignment program. The path to the images must be 
updated within the attack program that you choose to run (shown below).

![alt text](https://i.imgur.com/ndhulO8.png)

The program will generate a visual of the options for glasses.

![alt text](https://i.imgur.com/XA9GfBt.png)

## Generating a Single Pair

The program will also generate a .mat file needed to generate the best pair of glasses via the
'best_pair.m' program.

![alt text](https://i.imgur.com/U9XrJMD.png)

This file is then run through the 'best_pair' program by updating the datapath within the 'best_pair'
program to match the desired .mat file.

![alt text](https://i.imgur.com/nO7EWgL.png)

The program will generate the visual output below. This can then be printed out via high
gloss paper and adheared to a pair of matching frames (Note: the brightest designs seem
to be the most effective. This is possibly due to the design needing to be well illuminated
to be read correctly).

![alt text](https://i.imgur.com/JP9LIVe.png)









## Reference



More info can be found from original GitHub repository (https://github.com/mahmoods01/agns).
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
