function [mutwrd] = remRotationsFlip(mutwrd)
% remRotationsFlip  Removes equivalent transforations of the first word placed in a
% square wordbox
% 
%   [mutwrd] = remFlip(mutwrd)
% 

cleanmut{1} = mutwrd{1};

for i=2:length(mutwrd)
    
    present=0;
    for j=1:length(cleanmut)
        tst = isequaln(rot90(cleanmut{j}),mutwrd{i})...
            | isequaln(flipud(rot90(cleanmut{j})),mutwrd{i})...
            | isequaln(fliplr(rot90(cleanmut{j})),mutwrd{i})...
            | isequaln(rot90(cleanmut{j},2),mutwrd{i})...
            | isequaln(flipud(rot90(cleanmut{j},2)),mutwrd{i})...
            | isequaln(fliplr(rot90(cleanmut{j},2)),mutwrd{i})...
            | isequaln(rot90(cleanmut{j},3),mutwrd{i})...
            | isequaln(flipud(rot90(cleanmut{j},3)),mutwrd{i})...
            | isequaln(fliplr(rot90(cleanmut{j},3)),mutwrd{i});
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