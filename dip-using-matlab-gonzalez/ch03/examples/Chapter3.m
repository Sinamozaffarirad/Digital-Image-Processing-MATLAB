%3.1
f = imread('breastXray.tif');
%figure, imshow(f);
gl = imadjust(f,[0 1],[1 0]);
%figure, imshow(gl);
g2 = imadjust(f, [0.5 0.75],[0 1]);
%figure, imshow(g2);
g3 = imadjust(f, [],[],2);
%figure, imshow(g3);
g4 = imadjust(f, stretchlim(f), []);
%figure, imshow(g4);
g5 = imadjust(f, stretchlim(f),[1 0]);
%figure, imshow(g5);

%3.2
f = imread('fourier-spectrum.tif');
%figure, imshow(f);
g = im2uint8(mat2gray(log(1 + double(f))));
%figure, imshow(g)

%3.3
f = im2double(imread('bonescan.tif'));
m = mean2(f);
E = 0.9;
%figure, imshow(f)
g = intensityTransformations(f,'stretch',m,E);
%figure, imshow(g)
r = 0:1/255:1;
T = 1./(1 + m./r).^E;
%figure, plot(T)

%3.4
% There is no code for this example and it's discussing about four principal ways to plot histograms in Matlab!

%3.5
% We don't have access to DIPUMe3 support package to use original
% phoenix-land.tif so I used a screenshot instead of it and in the result of that, there's a
% quality drop in output figures!
f = imread('phoenix-land.tif');
%figure, imshow(f); 
g = histeq(f,256);
%figure, imshow(g) 
%figure, imhist(f)
%figure, imhist(g) 
hnorm = imhist(f)/numel(f);
cdf = cumsum(hnorm);
r = linspace(0,1,256);
%figure, plot(r,cdf);

%3.6
f = im2double(imread('chestXray-dark.tif'));
%figure, imshow(f)
%load goldenChestXrayHistogram
%figure, plot(goldenChestXrayHistogram)
%g = histeq(f,goldenChestXrayHistogram);
%figure, imshow(g)
%h = imhist(g)/numel(g);
%figure, plot(h)
% We don't have access to DIPUMe3 support package to load
% goldenChestXrayHistogm file so we cannot get an output from this exercise!

%3.7
% We don't have access to DIPUMe3 support package to use original
% chestXray-dark.tif so I used a screenshot instead of it and in the result of that, there's a
% quality drop in output figures!
f = imread('chestXray-dark.tif');
%figure, imshow(f)
refim = imread('chestXray2-cropped.tif');
%figure, imshow(refim)
g = imhistmatch(f,refim,256);
%figure, imshow(g)
%figure, imhist(f)
%figure, imhist(refim)
%figure, imhist(g)

%3.8
f = imread('hidden-symbols.tif');
%figure, imshow(f)
fe = histeq(f,256);
%figure, imshow(fe) 
g = adapthisteq(f,'ClipLimit',0.4,'Distribution','exponential','NumTiles',[12 12]);
%figure, imshow(g)

%3.9
% We don't have access to DIPUMe3 support package to use original
% phoenix-land.tif so I used a screenshot instead of it and in the result of that, there's a
% quality drop in output figures!
f = im2double(imread('four-squares.tif'));
w = ones(31);
gd = imfilter(f,w);
%imshow(gd,[])
gr = imfilter(f,w,'replicate');
%figure, imshow(gr,[])
gs = imfilter(f,w,'symmetric');
%figure, imshow(gs,[])
gc = imfilter(f,w,'circular');
%figure, imshow(gc,[])
f8 = im2uint8(f);
g8r = imfilter(f8,w,'replicate');
%figure, imshow(g8r,[])

%3.10
f = imread('testpatternl024.tif');
%imshow(f)
[M,N] = size(f);
sig = 0.0025*M;
r = ceil(6*sig);
r = r - 1;
wl = fspecial('gaussian',r,sig);
g1 = imfilter(f,wl,'replicate');
%figure, imshow(g1)
sig = 0.01*M;
r = ceil(6*sig);
r = r - 1;
w2 = fspecial('gaussian', r,sig);
g2 = imfilter(f,w2,'replicate');
%figure, imshow(g2) 
sig = 0.05*M;
r = ceil(6*sig);
r = r - 1;
w3 = fspecial('gaussian',r,sig);
g3 = imfilter(f,w3, 'replicate');
%figure, imshow(g3)

%3.11
w = fspecial('laplacian',0);
f = imread('moon-blurry.tif');
%figure, imshow(f)
gl = imfilter(f,w,'replicate');
%imshow(gl,[])
f2 = im2double(f);
g2 = imfilter(f2,w,'replicate');
%imshow(g2, [])
g = f2 - g2;
%imshow(g),

%3.12
f = im2double(imread('moon-blurry.tif'));
%figure, imshow(f)
w4 = fspecial('laplacian',0);
w8 = [1 1 1;1 -8 1;1 1 1];
g4 = f - imfilter(f,w4,'replicate');
g8 = f - imfilter(f,w8,'replicate');
%figure, imshow(g4)
%figure, imshow(g8)

%3.13
% We don't have access to DIPUMe3 support package to load
% lpkernel1D.txt file so we cannot get an output from this exercise!
%wLP1D = load('lpkernel1D.txt');
%figure, plot(wLP1D)
%W1LP2D = (wLPID*)*wLP1D;
%W2LP2D = ftrans2(wLP1D);
%figure, mesh(w1LP2D(1:2:end,1:2:end))
%figure, mesh(w2LP2D(l:2:end,l:2:end))
%f = im2double(imread('zoneplate.tif'));
%figure, imshow(f)
%gl.Pl = imfilter(f ,w1LP2D, 'replicate');
%gLP2 = imfilter(f,w2LP2D,'replicate');
%figure, imshow(gLPl)
%figure, imshow(gLP2)
%[M,N] = size(w1LP2D);
%impulse2D = zeros(M,N);
%impulse2D(ceil(M/2),ceil(N/2)) = 1;
%W1HP2D = impulse2D - W1LP2D;
%W2HP2D = impulse2D - w2LP2D;
%glHP = imfilter(f,w1HP2D,'replicate');
%g2HP = imfilter(f,w2HP2D,'replicate');
%figure, imshow(glHP,[])
%figure, imshow(g2HP,[])

%3.14
f = imread('girl-blurred.tif');
%imshow(f)
gl = imsharpen(f);
%figure, imshow(gl)
g2 = imsharpen(f,'Radius',5);
%figure, imshow(g2)
g3 = imsharpen(f,'Radius',5,'Amount',1.5);
%figure, imshow(g3) 
g5 = imsharpen(f,'Radius',5,'Amount',2);
%figure, imshow(g5)
g6 = imsharpen(f,'Radius',5,'Amount',2,'Threshold',0.5);
%figure, imshow(g6)

%3.15
f_original = imread('dentalXray-pepper-noise.tif');
if size(f_original, 3) == 3
    f = rgb2gray(f_original);
else
    f = f_original;
end
%figure, imshow(f)
maxfilt = @(A) max(A,[],1);
m = 3; n = 3;
fp = padarray(f,[m n],'replicate');
assert(all([m n] < size(fp)), 'Block size must be smaller than the padded image size.');
try
    g = colfilt(fp,[m n],'sliding', maxfilt);
catch ME
    error('Error using colfilt: %s', ME.message);
end
[M, N] = size(f);
g = g(1:M, 1:N);
%figure, imshow(g)

%3.16
f = imread('circuitboard.tif');
%figure, imshow(f)
fn = imnoise(f,'salt & pepper',0.2);
%figure, imshow(fn)
gm = medfilt2(fn);
%figure, imshow(gm)
gms = medfilt2(fn,'symmetric');
%figure, imshow(gms)

%3.17
% There is no code for this example and it's discussing about Illustration
% of fuzzy set definitions!

%3.18
ulow = @(z) 1 - sigmamf(z,0.27,0.47);
umid = @(z) triangmf(z,0.24,0.50,0.74);
uhigh = @(z) sigmamf(z,0.53,0.73);
fplot(ulow,[0 1])
hold on
fplot(umid,[0 1],'-.');
fplot(uhigh,[0 1],'--');
hold off
title('Input membership functions of Example 3.18')
unorm = @(z) 1 - sigmamf(z,0.18,0.33);
umarg = @(z) trapezmf(z,0.23,0.35,0.53,0.69);
ufail = @(z) sigmamf(z,0.59,0.78);
rules = {ulow; umid; uhigh};
L = lambdafcns(rules);
z = 0.7;
outputmfs = {unorm,umarg,ufail};
Q = implfcns(L,outputmfs,z);
Qa = aggfcn(Q);
final_result = defuzzify(Qa,[0 1]);
F = fuzzysysfcn(rules,outputmfs,[0 1]);
G = approxfcn(F,[0 1]);
fplot(F,[0 1],'k')
hold on
fplot(G,[0 1],'ko')
hold off
f = @() F(0.7); g = @() G(0.7);
tl = timeit(f);
t2 = timeit(g);
t = tl/t2;

%3.19
f = imread('einstein_orig.tif');
%figure, imshow(f)
udark = @(z) 1 - sigmamf(z,0.35,0.5);
ugray = @(z) triangmf(z,0.35,0.5,0.65);
ubright = @(z) sigmamf(z,0.5,0.65);
%fplot(udark,[0 1],20)
hold on
%fplot(ugray, [0 1])
%fplot(ubright,[0 1])
hold off
udarker = @(z) bellmf(z,0.0,0.1);
umidgray = @(z) bellmf(z,0.4,0.5);
ubrighter = @(z) bellmf(z,0.8,0.9);
rules = {udark; ugray; ubright};
outmf = {udarker, umidgray, ubrighter};
F = fuzzysysfcn(rules,outmf, [0 1]);
z = linspace(0,1,256); 
T = F(z);
g = intensityTransformations(f,'specified',T);
%figure, imshow(g)

%3.20
% There is no code for this example and it's discussing about 
% Boundary detection using fuzzy, rule-based spatial filtering.

% NECESSARY FUNCTIONS FOR EXAMPLES:
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