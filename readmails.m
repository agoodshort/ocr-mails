function readmails(file)
%% If folder recurse
if isfolder(file)
    allImages = file + filesep + "*.jpg";
    fileStruct = dir(allImages);
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
        mailList = imrotate(mailList,-90);
        
        %% Request user to select a zone and run Optical Character Recognition on this zone
        fig = figure;
        imshow(mailList);
        roi = round(getPosition(imrect)); %#ok<IMRECT>
        close(fig);
        ocrResults = ocr(mailList,roi);
        
        %% Create Array
        mailArr = split(string(ocrResults.Text));
        
        for i = 1 : numel(mailArr)
            if contains(mailArr(i),"@gma")
                mailArr(i) = extractBefore(mailArr(i),"@");
                mailArr(i) = mailArr(i) + "@gmail.com";
                
            elseif ~contains(mailArr(i),"@")
                mailArr(i) = "";
                
            elseif contains(mailArr(i),"@out")
                mailArr(i) = extractBefore(mailArr(i),"@");
                mailArr(i) = mailArr(i) + "@outlook.com";
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
        
        disp("Mails from " + string(fileStruct(j).name) + " appended to " + outputFile)
    end
end