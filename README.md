# ocr-mails
A MATLAB function reading emails from PNG images and prints the email addresses to a text file.
This function was used for a school project where I needed to send a survey to students of my university, but for GDPR reason the university would not email me the mailing list but only give me a printed version of it.

## Disclaimer
This is not the most robust Optical Character Recognition function. If you plan to use it, review the code to make sure that it does what you want it to do.

## Usage
`>> readmails("PATH_TO_FILE_OR_FOLDER")`

`>> readmails("PATH_TO_FILE_OR_FOLDER","IMAGE_EXTENSION")`

IMAGE_EXTENSION can be used to specify a different image type (e.g. ".jpg")

run `>> help readmails` for additional details on usage

If a folder location is provided, it will run `ocrmails` (nested function) on every PNG files in the folder.

### Additional functionality

1. Some parts in [readmails](readmails.m) are commented and could allow the user to be prompted with their image(s) and has to draw a rectangle around the text they want ocr to read.
2. the [PDF2Img](PDF2Img.m) will be called if the file provided is a PDF. This function will convert the PDF into PNG image.

## Comments

[readmails](readmails.m) file uses [nested functions](https://www.mathworks.com/help/matlab/matlab_prog/nested-functions.html).

## Required Toolboxes
- MATLAB
- Image Processing Toolbox
- Computer Vision Toolbox

## MATLAB Release
This function was written in R2020b.
