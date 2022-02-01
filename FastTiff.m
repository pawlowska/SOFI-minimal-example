function data = FastTiff(filename)
%https://www.mathworks.com/matlabcentral/answers/105739-how-to-show-tiff-stacks
    warning('off','all') % Suppress all the tiff warnings
    tstack  = Tiff(filename);
    [I,J] = size(tstack.read());
    K = length(imfinfo(filename));
    data = zeros(I,J,K);
    data(:,:,1)  = tstack.read();
    for n = 2:K
        tstack.nextDirectory()
        data(:,:,n) = tstack.read();
    end
    warning('on','all')
end