function [ list_mutations ] = generateMutationsV2( input_word )
% generateMutationsV2  Generate all ways to write a word in a wordbox
% 
%   [ list_mutations ] = generateMutationsV2( input_word )
% 
%   input_word -- Word to mutate as a string of char
%


% Get word length
lengword = length(input_word);

% Generate all the possible mutations incrementaly
% case of the first letter
[ fin_idx,list_mut ] = mutate1let( double(input_word(1)),1,double(input_word(2)));

% Apply mutation for each additional added letter
for i=2:lengword-1
    stpres = []; stpidx = [];
    for j=1:length(fin_idx)
        [ tmpfin_idx,tmplist_mut ] = mutate1let( list_mut{j},fin_idx(j),double(input_word(i+1)));
        stpres = [stpres tmplist_mut];
        stpidx = [stpidx tmpfin_idx]; 
    end
    fin_idx = stpidx;
    list_mut = stpres;
end

list_mutations = list_mut;

% Remove repetitions
cleanmut{1} = list_mutations{1};
for i=2:length(list_mutations)
    present=0;
    for j=1:length(cleanmut)
        if(isequaln(list_mutations{i},cleanmut{j}))
            present=1;
            break;
        end
    end
    if(~present)
        cleanmut{end+1} = list_mutations{i};
    end
end

list_mutations = cleanmut;


end


