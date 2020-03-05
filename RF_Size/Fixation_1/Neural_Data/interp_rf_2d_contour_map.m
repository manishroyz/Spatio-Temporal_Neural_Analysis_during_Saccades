function [XoB_interp, YoB_interp, rf_map_interp] = interp_rf_2d_contour_map(rf_map, XoB, YoB, interp_rate)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    % Interpolate XoB & YoB
    %interp_rate = 36;
    X_upsampled = linspace( min(XoB(:)), max(XoB(:)),interp_rate);
    Y_upsampled = linspace( min(YoB(:)), max(YoB(:)),interp_rate);
    X_upsampled = X_upsampled';    
    XoB_interp = repmat(X_upsampled,1,interp_rate);
    YoB_interp = repmat(Y_upsampled,interp_rate,1);

    rf_map_interp = interp2(YoB,XoB,rf_map,YoB_interp,XoB_interp);    

end

