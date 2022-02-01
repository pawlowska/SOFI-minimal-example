function my_saving(im, template, suffix, normalize)
    if normalize==true
        normed_im=uint16(65535 * im./max(im,[], 'all'));
    else
        normed_im=uint16(im);
    end
    imwrite(normed_im, [template,suffix], 'WriteMode','overwrite');
end