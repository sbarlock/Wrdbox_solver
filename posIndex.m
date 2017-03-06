function [allidx,newmuts] = posIndex(Allmuts,grid_dims)
% posIndex  Finds 
% 
%   [ list_mutations ] = posIndex(Allmuts,grid_dims)
% 
%   Allmuts -- Cell array of all possible mutations for a word
%   grid_dims -- 1x2 double, size of the wordbox

newmuts = {};idx=1;
for j=1:length(Allmuts)
    %compare word size to grid size to find allowable indices
    szwrd = size(Allmuts{j});
    maxl = grid_dims(1) - szwrd(1) +1;
    maxc = grid_dims(2) - szwrd(2) +1;
    
    curpos = nan(1,maxl*maxc);
    
    for k=1:maxl
        for kk=1:maxc
            curpos((k-1)*maxc+kk) = sub2ind(grid_dims,k,kk);            
        end
    end    
    
    %Add the word only if possible with the chosen wordbox size
    %and save the possible indices for each possible mutation
    if(~isempty(curpos))
        allidx{idx} = curpos;
        newmuts{idx} = Allmuts{j};
        idx = idx+1;
    end
end

end


