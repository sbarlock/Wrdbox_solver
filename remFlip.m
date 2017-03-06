function [mutwrd] = remFlip(mutwrd)
% remFlip  Removes equivalent transforations of the first word placed in a
% rectangular wordbox
% 
%   [mutwrd] = remFlip(mutwrd)
% 


cleanmut{1} = mutwrd{1};

for i=2:length(mutwrd)
    
    present=0;
    
    for j=1:length(cleanmut)
        tst = isequaln(fliplr(cleanmut{j}),mutwrd{i})...
            | isequaln(rot90(cleanmut{j},2),mutwrd{i})... %rot90(A,2) performs a 180 degree rotation
            | isequaln(flipud(cleanmut{j}),mutwrd{i});
        
        if(tst)
            present=1;
            break;
        end
        
    end
    
    if(~present)
        cleanmut{end+1} = mutwrd{i};
    end
    
end

mutwrd = cleanmut;

end