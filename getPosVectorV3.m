function [combinations] = getPosVectorV3(grid,Allpos,wrd1,wrd2,maxidx)
% getPosVectorV3  Finds valid combinations of two words and stores it in a
% way that optimises later analysis
% 
%   [combinations] = getPosVectorV3(grid,Allpos,wrd1,wrd2,maxidx)
% 
%   grid: Empty wordbox, must be filled with NaNs
% 
%   Allpos: Contains the input vector for all the words (i.e. all possible
%   mutations and positions where to place the word)
% 
%   wrd1: Index of the 1st word to compare
%   wrd2: Index of the 2nd word to compare
% 
%   maxidx: length of the combination vector - determined by the word with
%   the longer Allpos entry
%
%   combinations: cell array containing the list of valid combinations

fprintf('%d vs %d\n',wrd2,wrd1);


for i=1:length(Allpos{wrd1})
    
    if(mod(i,1000)==0)
        fprintf('%d/%d\n',i,length(Allpos{wrd1}));
    end
    
    %Select word1 data
    line_st = Allpos{wrd1}{i}{2};
    col_st = Allpos{wrd1}{i}{3};
    test_wrd = Allpos{wrd1}{i}{1};
    
    comp_grid = grid;
    comp_grid(line_st:line_st+size(test_wrd,1)-1,col_st:col_st+size(test_wrd,2)-1) = test_wrd;
    tmp_combi = [];
    index=1;
    
    
    posallw2 = Allpos{wrd2};
    
    for j=1:length(Allpos{wrd2})
        %Select word2 data
        line_st = posallw2{j}{2};
        col_st = posallw2{j}{3};
        test_wrd = posallw2{j}{1};
        
        %Check if selected word2 is compatible with selected word1
        aoi_grid = comp_grid(line_st:line_st+size(test_wrd,1)-1,col_st:col_st+size(test_wrd,2)-1);
        isvalid = (aoi_grid-test_wrd);
        isvalid = all(isnan(isvalid(:)) | isvalid(:)==0);

        %If yes store the index of word2
        if(isvalid)
            tmp_combi(index,:) = j;         
            index=index+1;
        end
    end
    
    %Store all posible word2 index for the current word1 index
    A = zeros(1,maxidx); A(tmp_combi) = 1 ; A=logical(A);
    combinations{i} = A;
end

end