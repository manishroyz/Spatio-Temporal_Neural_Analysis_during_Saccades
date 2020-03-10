function y = gauss_smooth(x,win)
% win = FWHM
sigma = win/2*sqrt(2*log(2));
k = (1/sqrt(2*pi)/sigma)*exp(-1/(2*sigma^2)*(linspace(-5*win,5*win,10*win+1)).^2);
k = k./sum(k);
conv_value = conv(x,k,'full');
y = conv_value(5*win+1:length(conv_value)-5*win );
end








