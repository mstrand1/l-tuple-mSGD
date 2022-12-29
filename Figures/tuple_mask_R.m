function A_tilde = tuple_mask_R(Ai, p, ell)

% Missing Q-tuples row mask (one row at a time)

% Parameters
    % Ai:  row of A to be masked
    % p: probability that Q-tuple will be blocked out
    % Q: size of missing tuples

% Obtain size of A
n = length(Ai);

% Initialize D binary mask filled with all ones
D = ones([1,n]);

% Loop through D and look at every Q consequtive entries from 1:n-Q-1
% Flip a coin at each pair and if it is 1 w.p. p then keep it, o.w.
% zero out that entry

for j = 1:ell:n-ell+1
    coin = binornd(1,p,1);
    if coin == 0
        D(j:j+ell-1) = 0;
    else
        continue
    end
end

A_tilde =  Ai.*D;