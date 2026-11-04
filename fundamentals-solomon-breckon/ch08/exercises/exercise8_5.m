A = [
    12 13 11;
     7 14  8;
    10  9 10
];

b = [
    0 1 0;
    1 1 1;
    0 1 0
];

vb = [
    0 3 0;
    3 1 3;
    0 3 0
];

padded_A = padarray(A, [1 1], inf);

eroded_image = inf(size(A));
for i = 2:size(padded_A, 1)-1
    for j = 2:size(padded_A, 2)-1
        if b(2, 2) == 1 
            region = padded_A(i-1:i+1, j-1:j+1) - vb;
            eroded_image(i-1, j-1) = min(region(b == 1));
        end
    end
end

dilated_image = -inf(size(A));
for i = 2:size(padded_A, 1)-1
    for j = 2:size(padded_A, 2)-1
        if b(2, 2) == 1 
            region = padded_A(i-1:i+1, j-1:j+1) + vb;
            dilated_image(i-1, j-1) = max(region(b == 1));
        end
    end
end

disp('Eroded Image (A ⊖ B):');
disp(eroded_image);

disp('Dilated Image (A ⊕ B):');
disp(dilated_image);
