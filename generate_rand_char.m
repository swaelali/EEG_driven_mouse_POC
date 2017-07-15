function [first_letter,letters_vector] = generate_rand_char()
alphabet ='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
first_letter = alphabet(round(20*rand(1))+1);
index = find(alphabet==first_letter);
indices= [index, index+1, index+2, index+3];
scrabled_indices = indices(randperm(length(indices)));
letters_vector = [alphabet(scrabled_indices(1)), alphabet(scrabled_indices(2)),alphabet(scrabled_indices(3)),alphabet(scrabled_indices(4))];
%index_of_correct = find(scrabled_indices==min(scrabled_indices));
end
