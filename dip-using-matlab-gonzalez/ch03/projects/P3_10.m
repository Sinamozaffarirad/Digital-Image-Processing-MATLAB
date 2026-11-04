f = imread('input.tif'); 
% Scaling image intensities to the range [0,1]
f = mat2gray(f); 
% Defining fuzzy membership functions for dark, gray, and bright intensities
udark = @(z) 1 - sigmamf(z, 0.35, 0.5);
ugray = @(z) triangmf(z, 0.35, 0.5, 0.65);
ubright = @(z) sigmamf(z, 0.5, 0.65);
% Defining output membership functions
udarker = @(z) bellmf(z, 0.0, 0.1);
umidgray = @(z) bellmf(z, 0.4, 0.5);
ubrighter = @(z) bellmf(z, 0.8, 0.9);
% Defining the fuzzy rules
rules = {udark; ugray; ubright};
outmf = {udarker, umidgray, ubrighter};
% Combining the rules into a fuzzy system
F = fuzzysysfcn(rules, outmf, [0 1]);
% Generating the transformation function, T
z = linspace(0, 1, 256);
T = F(z);
% Applying the transformation function to the image
g = intensityTransformations(f, 'specified', T);
% results:
figure, 
subplot(1, 2, 1), imshow(f), title('Original Image');
subplot(1, 2, 2), imshow(g), title('Fuzzy Intensity Transformed Image');

% NECESSARY FUNCTIONS:
function g = intensityTransformations(f,method,varargin)
    narginchk(2,4)
    if strcmp(method,'log')
        g = logTransform(f,varargin{:});
        return;
    end
    if isfloat(f) && (max(f(:)) > 1 || min(f(:)) < 0)
        f = mat2gray(f);
    end
    [f,revertclass] = tofloat(f);
    
    switch method
    case 'neg'
        g = imcomplement(f);
    case 'gamma'
        g = gammaTransform(f,varargin{:});
    case 'stretch'
        g = stretchTransform(f,varargin{:});
    case 'specified'
        g = specifiedTransform(f, varargin{:});
    otherwise
        error('Unknown enhancement method.')
    end
    g = revertclass(g);
    end
    
    function g = gammaTransform(f, gamma)
    g = imadjust(f,[ ],[ ],gamma);
    end
    
    function g = stretchTransform(f, varargin)
    if isempty(varargin)
        m = mean2(f);
        E = 4.0;
    elseif length(varargin) == 2
        m = varargin{1};
        E = varargin{2};
    else
        error("Incorrect number of inputs for the 'stretch' method.")
    end
    g = 1./(1 + (m./f).^E);
    end
    
    function g = specifiedTransform(f,txfun)
    txfun = txfun(:);
    if any(txfun) > 1 || any(txfun) <= 0
       error('All elements of txfun must be in the range [0 1].')
    end
    T = txfun;
    X = linspace(0,1,numel(T))';
    g = interp1(X,T,f); 
    end
    
    function g = logTransform(f,varargin)
    [f,revertclass] = tofloat(f);
    if numel(varargin) >= 2
        if strcmp(varargin{2},'uint8')
        revertclass = @im2uint8;
        elseif strcmp(varargin{2},'uintl6')
            revertclass = @im2uintl6;
        else
            error("Unsupported CLASS option for 'log' method.")
        end
    end
    if numel(varargin) < 1
        C = 1;
    else
        C = varargin{l};
    end
    g = C * (log(1 + f));
    g = revertclass(g);
    end
    
    function [out, revertClass] = tofloat(in)
    identity = @(x) x;
    todouble = @im2double;
    converter_table = {'uint8',   todouble, @im2uint8
       'uint16',  todouble, @im2uint16
       'int16',   todouble, @im2int16
       'logical', todouble, @logical
       'double',  identity, identity
       'single',  identity, identity};
    
    classIndex = find(strcmp(class(in), converter_table(:, 1)));
    if isempty(classIndex)
       error('Unsupported input image class.');
    end
    out = converter_table{classIndex, 2}(in);
    revertClass = converter_table{classIndex, 3};
    end

function L = lambdafcns(inmf,op)
    if nargin < 2
       op = @min;
    end
    
    num_rules = size(inmf,1);
    L = cell(1,num_rules);
    
    for i = 1:num_rules
       L{i} = @(varargin) ruleStrength(i,varargin{:});
    end
       function lambda = ruleStrength(i,varargin)
          Z = varargin;
          memberfcn = inmf{i,1};
          lambda = memberfcn(Z{1});
          for j = 2:numel(varargin)
             memberfcn = inmf{i,j};
             lambda = op(lambda,memberfcn(Z{j}));
          end
       end
    
    end
    
    function Q = implfcns(L,outmf,varargin)
    Z = varargin;
    
    num_rules = numel(L);
    Q = cell(1,numel(outmf));
    lambdas = zeros(1,num_rules);
    
    for i = 1:num_rules
       lambdas(i) = L{i}(Z{:});
    end
    
    for i = 1:num_rules
       Q{i} = @(v) implication(i,v);
    end
    
    if numel(outmf) == (num_rules + 1)
       Q{num_rules + 1} = @elseRule;
    end
    
       function q = implication(i,v)
          q = min(lambdas(i),outmf{i}(v));
       end
    
       function q = elseRule(v)
          lambda_e = min(1 - lambdas);
          q = min(lambda_e,outmf{end}(v));
       end
    end
    
    function Qa = aggfcn(Q)
    Qa = @aggregate;
    
        function q = aggregate(v)
            q = Q{1}(v);
            for i = 2:numel(Q)
                q = max(q, Q{i}(v));
            end
        end
    end
    
    function mu = sigmamf(z,a,b)
    mu = trapezmf(z,a,b,Inf,Inf);
    end
    
    function mu = trapezmf(z,a,b,c,d)
    mu = zeros(size(z));
    up_ramp_region = (a <= z) & (z < b);
    top_region = (b <= z) & (z < c);
    down_ramp_region = (c <= z) & (z < d);
    mu(up_ramp_region) = 1 - (b - z(up_ramp_region))./(b - a);
    mu(top_region) = 1;
    mu(down_ramp_region) = 1 - (z(down_ramp_region) - c)./(d - c);
    end
    
    function mu = triangmf(z,a,b,c)
    mu = zeros(size(z));
    low_side  = (a <= z) & (z < b);
    high_side = (b <= z) & (z < c);
    mu(low_side)  = (z(low_side) - a)./(b - a);
    mu(high_side) = 1 - (z(high_side) - b)./(c - b);
    end
    
    function out = defuzzify(Qa,vrange)
    v1 = vrange(1);
    v2 = vrange(2);
    v = linspace(v1,v2,100);
    Qv = Qa(v);
    out = sum(v .* Qv) / sum(Qv);
    if isnan(out)
       out = mean(vrange);
    end
    end
    
    function F = fuzzysysfcn(inmf,outmf,vrange,op)
    if nargin < 4
       op = @min;
    end
    L = lambdafcns(inmf,op);
    
    F = @fuzzyOutput;
    
        function out = fuzzyOutput(varargin)
          Z = varargin;
          Zk = cell(1,numel(Z));
          out = zeros(size(Z{1}));
          for k = 1:numel(Z{1})
             for p = 1:numel(Zk)
                Zk{p} = Z{p}(k);
             end
             Q = implfcns(L,outmf,Zk{:});
             Qa = aggfcn(Q);
             out(k) = defuzzify(Qa,vrange);
          end
       end
    end
    
    
    function G = approxfcn(F,range)
    num_inputs = size(range,1);
    max_table_elements = 10000;
    max_table_dim = 100;
    table_dim = min(floor(max_table_elements^(1/num_inputs)), ...
       max_table_dim);
    inputs = cell(1,num_inputs);
    grid = cell(1,num_inputs);
    for k = 1:num_inputs
       grid{k} = linspace(range(k,1),range(k,2),table_dim);
    end
    if num_inputs > 1
       [inputs{:}] = ndgrid(grid{:});
    else
       inputs = grid;
    end
    table = zeros(size(inputs{1}));
    bar = waitbar(0,'Working...');
    Zk = cell(1,num_inputs);
    L = numel(inputs{1});
    waitbar_update_interval = ceil(0.02 * L);
    
    for p = 1:L
       for k = 1:num_inputs
          Zk{k} = inputs{k}(p);
       end
       table(p) = F(Zk{:});
       if (rem(p,waitbar_update_interval) == 0)
          waitbar(p/L);
       end
    end
    close(bar)
    G = @tableLookupFcn;
    
       function out = tableLookupFcn(varargin)
          if num_inputs > 1
             out = interpn(grid{:},table,varargin{:});
          else
             out = interp1(grid{1},table,varargin{1});
          end
       end
    end
    
    function mu = bellmf(z,a,b)
    mu = zeros(size(z));
    left_side = z < b;
    mu(left_side) = smf(z(left_side),a,b);
    right_side = z >= b;
    mu(right_side) = smf(2*b - z(right_side),a,b);
    end
    
    function mu = smf(z,a,b)
    mu = zeros(size(z));
    p = (a + b)/2;
    low_range = (a <= z) & (z < p);
    mu(low_range) = 2*( (z(low_range) - a)./(b - a) ).^2;
    mid_range = (p <= z) & (z < b);
    mu(mid_range) = 1 - 2*( (z(mid_range) - b)./(b - a) ).^2;
    high_range = (b <= z);
    mu(high_range) = 1;
    end