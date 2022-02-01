function my_image_showing(im, name)
    figure('Name',name)
    imagesc(im)
    cmap = colormap(hot);
    title(name)
end