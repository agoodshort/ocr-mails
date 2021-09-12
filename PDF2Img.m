function folder2go = PDF2Img(fileLocation)
% Function inspired from https://www.mathworks.com/matlabcentral/answers/709623
% Added functionality to create a folder and generate images in the folder

import org.apache.pdfbox.*
import java.io.*

jFile = File(fileLocation);
[filepath,filename,~] = fileparts(fileLocation);

document = pdmodel.PDDocument.load(jFile);
pdfRenderer = rendering.PDFRenderer(document);
count = document.getNumberOfPages();

folderName = filename + "-images";
mkdir(fullfile(filepath,folderName));
folder2go = fullfile(filepath,folderName);
folder2comeback = cd(folder2go);

images = [];
for ii = 1:count
    bim = pdfRenderer.renderImageWithDPI(ii-1, 300, rendering.ImageType.RGB);
    images = [images (filename + "-" +"Page" + ii + ".png")]; %#ok<AGROW>
    tools.imageio.ImageIOUtil.writeImage(bim, filename + "-" +"Page" + ii + ".png", 300);
end
document.close()

cd(folder2comeback)