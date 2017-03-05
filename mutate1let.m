function [ end_idx,list_mut ] = mutate1let( input_word,strtidx,letter )
% mutate1let  Generate all possible mutations when adding one letter to a given word.
% 
%   [ end_idx,list_mut ] = mutate1let( input_word,strtidx,letter )
% 
%   input_word -- Word to mutate as a matrix double
%
%   strtidx -- Position where to add the new letter from. Need to use
%   linear single index system.
% 
%   letter -- Letter to add. type double
%



list_mut = {};
end_idx = -1;
posible = 1;

% There is always 4 cases to test, they are hardcoded here


%% add right
[idx,idy] = ind2sub(size(input_word),strtidx);
try
    %if a letter is already there
    alr_pres = input_word(idx,idy+1);
    
    %is it a NaN ? then replace it
    if isnan(alr_pres)
        new_wrd = input_word;
        new_wrd(idx,idy+1) = letter;
        list_mut{posible} = new_wrd;
        end_idx(posible) = sub2ind(size(new_wrd),idx,idy+1);
        posible = posible+1;
        
        %is it the same letter ?
    elseif(alr_pres==letter) %if yes ok valid word
        list_mut{posible} = input_word;
        end_idx(posible) = sub2ind(size(input_word),idx,idy+1);
        posible=posible+1;
    end
catch %if no letter there
    new_wrd = [input_word nan(size(input_word,1),1)];
    new_wrd(idx,idy+1) = letter;
    list_mut{posible} = new_wrd;
    end_idx(posible) = sub2ind(size(new_wrd),idx,idy+1);
    posible = posible+1;
end


%% add left
[idx,idy] = ind2sub(size(input_word),strtidx);
try
    %if a letter is already there
    alr_pres = input_word(idx,idy-1);
    
    %is it a NaN ? then replace it
    if isnan(alr_pres)
        new_wrd = input_word;
        new_wrd(idx,idy-1) = letter;
        list_mut{posible} = new_wrd;
        end_idx(posible) = sub2ind(size(new_wrd),idx,idy-1);
        posible = posible+1;
        
    %is it the same letter ?
    elseif(alr_pres==letter) %if yes, ok valid word
        list_mut{posible} = input_word;
        end_idx(posible) = sub2ind(size(input_word),idx,idy-1);
        posible = posible+1;
    end
catch %if no letter there
    new_wrd = [nan(size(input_word,1),1) input_word];
    idy = idy+1;
    new_wrd(idx,idy-1) = letter;
    list_mut{posible} = new_wrd;
    end_idx(posible) = sub2ind(size(new_wrd),idx,idy-1);
    posible = posible+1;
end


%% add top
[idx,idy] = ind2sub(size(input_word),strtidx);
try
    %if a letter is already there
    alr_pres = input_word(idx-1,idy);
    
    %is it a NaN ? then replace it
    if isnan(alr_pres)
        new_wrd = input_word;
        new_wrd(idx-1,idy) = letter;
        list_mut{posible} = new_wrd;
        end_idx(posible) = sub2ind(size(new_wrd),idx-1,idy);
        posible = posible+1;

    %is it the same letter ?
    elseif(alr_pres==letter) %if yes ok valid word
        list_mut{posible} = input_word;
        end_idx(posible) = sub2ind(size(input_word),idx-1,idy);
        posible = posible+1;
    end
catch %if no letter there
    new_wrd = [nan(1,size(input_word,2));input_word];
    idx = idx+1;
    new_wrd(idx-1,idy) = letter;
    list_mut{posible} = new_wrd;
    end_idx(posible) = sub2ind(size(new_wrd),idx-1,idy);
    posible = posible+1;
end


%% add bottom
[idx,idy] = ind2sub(size(input_word),strtidx);
try
    %if a letter is already there
    alr_pres = input_word(idx+1,idy);
    
    %is it a NaN ? then replace it
    if isnan(alr_pres)
        new_wrd = input_word;
        new_wrd(idx+1,idy) = letter;
        list_mut{posible} = new_wrd;
        end_idx(posible) = sub2ind(size(new_wrd),idx+1,idy);
        posible = posible+1;

    %is it the same letter ?
    elseif(alr_pres==letter) %if yes ok valid word
        list_mut{posible} = input_word;
        end_idx(posible) = sub2ind(size(input_word),idx+1,idy);
    end
catch %if no letter there
    new_wrd = [input_word;nan(1,size(input_word,2))];
    new_wrd(idx+1,idy) = letter;
    list_mut{posible} = new_wrd;
    end_idx(posible) = sub2ind(size(new_wrd),idx+1,idy);
end


end


