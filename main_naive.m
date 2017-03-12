clear
clc

grid_dims = [4 3];

mywords = {'TIGER','STOAT','DODO','FROG','DOG','TIT'};
nb_words = length(mywords);

% Create the grid
grid = nan(grid_dims);
max_grid_idx = length(grid(:));


% Get mutations and search idx
Allmuts={}; Allidx = {};Allpos = {};
for i=1:nb_words
    idx=1;
    
    %Create mutation for each word
    Allmuts{i} = generateMutationsV2(mywords{i});
    
    %For the first word, a rotation of 180deg is equivalent
    %In the case of a square even only 1/4 is considered as the rest is just a
    if(i==1)        
        if(grid_dims(1)==grid_dims(2))
            Allmuts{i}= remRotationsFlip(Allmuts{i});
        else
            Allmuts{i} = remFlip(Allmuts{i});
        end
    end
    
    %Get possible search index
    %Clean mutations not compatible with grid
    [Allidx{i},Allmuts{i}] = posIndex(Allmuts{i},grid_dims);
        
    % Create input vector for V2
    for j=1:length(Allmuts{i})
        for k=1:length(Allidx{i}{j})
            [xp,yp] = ind2sub(grid_dims,Allidx{i}{j}(k));
            Allpos{i}{idx} = {Allmuts{i}{j} xp yp};
            idx = idx+1;
        end
    end
    
end


% Start a timer
tic;
populateGrid_Naive(Allpos,grid,1,nb_words);
