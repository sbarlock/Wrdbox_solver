function populateGrid_Naive(Allpos,grid,wrd_idx,max_wrd)
% populateGrid_Naive  Simple non optimised implementation of a wordbox
% solver
%
%   populateGrid_Naive(Allpos,grid,wrd_idx,max_wrd)
%
%   Allpos: contains all possible word rotations
%   grid: previous state of the wordbox contains the words already placed
%   wrd_idx: index of the current tested word
%   max_wrd: total number of words to place



% Select all mutation posibilities for current word
cur_wrd = Allpos{wrd_idx};

% Try all those mutation turn per turn
for k=1:length(cur_wrd)
    
    % Add some display to show progress the verbosity can be changed
    % put wrd_idx < 1 for no display
    if(wrd_idx<2)
        fprintf('%d/%d\n',k,length(cur_wrd));
    end
    
    % Extract the text (test_wrd) and position where to place the word (line_st,col_st)
    test_wrd = cur_wrd{k}{1};
    line_st = cur_wrd{k}{2};
    col_st = cur_wrd{k}{3};
    
    
    %check if the word can be placed with the current settings (mutation+position)
    
    %Extract the bit of the wordbox where we are trying to place the word
    %and compare with the letters already placed if this compatible
    aoi_grid = grid(line_st:line_st+size(test_wrd,1)-1,col_st:col_st+size(test_wrd,2)-1);
    isvalid = (aoi_grid-test_wrd);
    isvalid = all(isnan(isvalid(:)) | isvalid(:)==0);
    
    
    % If the current combination works and the grid is valid then we found
    % a solution that we can display.
    if(wrd_idx == max_wrd && isvalid)
        fprintf('SOLUTION FOUND \n')
        grid(line_st:line_st+size(test_wrd,1)-1,col_st:col_st+size(test_wrd,2)-1) =...
            max(test_wrd,aoi_grid);
        
        %display the solution
        char(grid)
        %Stop the timer
        toc;
        
        %If all the words have been placed but they are empty spaces in the
        %grid we warn the user
        if(sum(isnan(grid(:)))>0)
            fprintf('Grid uncomplete, better solution may exist\n\n')
        end
        error('Well done!\n');
    
    % If the current combination works but we are not placing the last word
    % we call this function again to place the word N+1.
    elseif isvalid
        %Create a new instance of grid where the new word has been placed
        newgrid = grid;
        newgrid(line_st:line_st+size(test_wrd,1)-1,col_st:col_st+size(test_wrd,2)-1) =...
            max(test_wrd,aoi_grid);
        
        %Send the updated grid to the function and ask it to place the next
        populateGrid_Naive(Allpos,newgrid,wrd_idx+1,max_wrd);

    end

end

end