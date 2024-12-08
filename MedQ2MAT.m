% Valentin Siderskiy
% MATLAB R2021a
% requires Text Analytics Toolbox.

%Select PDF File

filterspec = '*.pdf';
Title = 'Pick PDF file with medical screening questionnaire:';
original_path = pwd;
[infile,pathname] = uigetfile(filterspec,Title);

if infile == 0
    return;
end

infile_pathname = [pathname infile];


%Read PDF
MedQ = readPDFFormData(infile_pathname);

%Save PDF
%% Create dir to save all files

Question = 'An output file already exists. Overwrite it?';
Qtitle= 'Data Cleaning Analysis';
name = infile_pathname;
folder_name = [infile(1:end-4)];

for i = 0: length(name)
    if name(end-i) ~= '\'
    elseif name(end-i) == '\'
        cont =i;
        break,
    end
end
name(end-cont:end)=[];

% chking if file originally exist

cd(name);
check_exist = exist(folder_name, 'file');
if check_exist >0
    ButtonName = questdlg(Question,Qtitle);
    switch ButtonName,
        case 'Yes',
            
            folder = mkdir (name,folder_name);
            new_dir=[name '\' folder_name];
            cd(new_dir)
            outfile_clean = [folder_name '.mat'];
            save([new_dir '\' outfile_clean])
            
            
        case 'No',
            new_name = inputdlg('Rename File', 'Qtitle', 1,{folder_name});
            new_name=cell2str (new_name);
            new_name(1)=[];
            new_name(end)=[];
            folder = mkdir (name , new_name);
            new_dir=[name '\' new_name];
            cd(new_dir)
            outfile = [folder_name '.mat'];
            save([new_dir '\' outfile])
            
        case 'Cancel',
            STATUS = 0;
            return;
    end
    
    
    
elseif check_exist ==0
    folder = mkdir (name,folder_name);
    new_dir=[name '\' folder_name];
    cd(new_dir)
    
end

outfile = [folder_name '.mat'];
save([pathname folder_name '\' outfile],'MedQ')