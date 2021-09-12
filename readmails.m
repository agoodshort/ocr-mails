function readmails(file,imgExt)

arguments
    file string
    imgExt string = ".png" % PDF2Img generates PNG images
end

[~,~,fileExt] = fileparts(file);
if fileExt == ".pdf"
    disp("Location provided is a PDF file, converting PDF to images...")
    file = PDF2Img(file);
    disp("Running readmails(" + file + ")...")
end


%% Recurse ocrmails() if input is a folder
if isfolder(file)
    disp("Location provided is a folder...")
    disp("Looking for files with extension " + fileExt + "...")
    allImages = file + filesep + "*" + imgExt;
    fileStruct = dir(allImages);
    if length(fileStruct) < 1
        disp("Folder does not contain " + imgExt + " files")
    end
    for j = 1:length(fileStruct)
        fileAbsolutePath = string(fileStruct(j).folder) + filesep + string(fileStruct(j).name);
        disp("Starting ocrmails on file " + string(fileStruct(j).name))
        ocrmails(fileAbsolutePath)
    end
else
    ocrmails(file)
end



%% Main function
    function ocrmails(picture)
        %% Read image and rotate
        mailList = imread(picture);
        %mailList = imrotate(mailList,-90);
        
        %% Request user to select a zone and run Optical Character Recognition on this zone
        %         fig = figure;
        %         imshow(mailList);
        %         roi = round(getPosition(imrect)); %#ok<IMRECT>
        %         close(fig);
        ocrResults = ocr(mailList);
        
        %% Create Array
        mailArr = split(string(ocrResults.Text));
        
        %% Attempt to fix misinterpration
        for i = 1 : numel(mailArr)
            if contains(mailArr(i),"@gma")
                mailArr(i) = extractBefore(mailArr(i),"@");
                mailArr(i) = mailArr(i) + "@gmail.com";
                
            elseif ~contains(mailArr(i),"@")
                mailArr(i) = "";
                
            elseif contains(mailArr(i),"@out")
                mailArr(i) = extractBefore(mailArr(i),"@");
                mailArr(i) = mailArr(i) + "@outlook.com";
            
            elseif contains(mailArr(i),"@hot")
                mailArr(i) = extractBefore(mailArr(i),"@");
                mailArr(i) = mailArr(i) + "@hotmail.com";
            end
            
            % Letter "L" was not recognized properly
            if contains(mailArr(i),"|")
                mailArr(i) = strrep(mailArr(i),"|","l");
            end
        end
        
        %% Remove empty rows from array
        mailArr = mailArr(~cellfun('isempty',mailArr));
        
        %% write to file
        outputFile = 'listOfMails.txt';
        fid = fopen(outputFile,'a+');
        fprintf(fid,'%s\n',mailArr);
        fclose(fid);
        
        [~,name,ext] = fileparts(picture);
        
        disp("Mails from " + name + ext + " appended to " + outputFile)
    end
end