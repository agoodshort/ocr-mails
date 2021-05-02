# ocr-mails
A MATLAB function reading emails from pictures and prints the email addresses to a text file.
This function was used for a school project where I needed to send a survey to students of my university, but for GDPR reason the university would not email me the mailing list but only give me a printed version of it.

## Disclaimer
This is not the most robust Optical Character Recognition function. If you plan to use it, review the code to make sure that it does what you want it to do.

## Usage

`>> readmails("PATH_TO_FILE_OR_FOLDER");`
[readmails](readmails.m) file uses [nested functions](https://www.mathworks.com/help/matlab/matlab_prog/nested-functions.html).

If folder is provided, it will run `ocrmails` (nested function) through every JPG files in the folder.

User will be prompted with their image(s) and has to draw a rectangle around the text they want ocr to read.

## Required Toolboxes
- MATLAB
- Image Processing Toolbox
- Computer Vision Toolbox

## MATLAB Release
This function was written in R2020b.
