function A_tilde_batch = tuple_mask_mb(A_batch, p, ell, batch)

% Missing Q-tuples row mask (one row at a time)

% Parameters
    % Ai:  row of A to be masked
    % p: probability that Q-tuple will be blocked out
    % Q: size of missing tuples

% Obtain size of A
n = length(A_batch);

% Initialize D binary mask filled with all ones
D = ones([batch,n]);

% Loop through D and look at every Q consequtive entries from 1:n-Q-1
% Flip a coin at each pair and if it is 1 w.p. p then keep it, o.w.
% zero out that entry
for i = 1:batch
    for j = 1:ell:n-ell+1
        coin = binornd(1,p,1);
        if coin == 0
            D(i,j:j+ell-1) = 0;
        else
            continue
        end
    end
end

A_tilde_batch =  A_batch.*D;