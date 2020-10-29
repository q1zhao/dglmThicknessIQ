function NewColorMap=AdjustColorMap(OriginalColorMap,NullColor,NMax,NMin,PMin,PMax)
% Adjust the colormap to leave blank to values under threshold, the orginal color map with be set into [NMax NMin] and [PMin PMax]. Written by YAN Chao-Gan, 111023
% Input: OriginalColorMap - the original color map
%        NullColor - The values between NMin and PMin will be set to this color (leave blank)
%        NMax, NMin, PMin, PMax - set the axis of colorbar (the orginal color map with be set into [NMax NMin] and [PMin PMax])
% Output: NewColorMap - the generated color map, a 1000 by 3 matrix.

NewColorMap = repmat(NullColor,[1000 1]);
ColorLen=size(OriginalColorMap,1);
% NegativeColorSegment = fix(1000*(NMin-NMax)/(PMax-NMax)/6);
% for iColor=1:fix(ColorLen/2)
%     NewColorMap((iColor-1)*NegativeColorSegment+1:(iColor)*NegativeColorSegment,:) = repmat(OriginalColorMap(iColor,:),[NegativeColorSegment 1]);
% end
% PositiveColorSegment = fix(1000*(PMax-PMin)/(PMax-NMax)/6);
% for iColor=ColorLen:-1:ceil(ColorLen/2+1)
%     NewColorMap(end-(ColorLen-iColor+1)*PositiveColorSegment+1:end-(ColorLen-iColor)*PositiveColorSegment,:) = repmat(OriginalColorMap(iColor,:),[PositiveColorSegment 1]);
% end
if NMax >= 0 || NMax >= NMin %%% Edited by Mingrui Xia 20111027, use linear sampling method.
    ColorIndex = round(linspace(fix(ColorLen/2)+1,ColorLen,999));
    NewColorMap(2:end,:) = OriginalColorMap(ColorIndex,:);
elseif PMax <= 0 || PMax <= PMin
    ColorIndex = round(linspace(1,fix(ColorLen/2),999));
    NewColorMap(1:end-1,:) = OriginalColorMap(ColorIndex,:);
else
    NegativeColorSegment = fix(1000*(NMin-NMax)/(PMax-NMax));
    if NegativeColorSegment == 0
        NegativeColorSegment = 1;
    end
    NegativeIndex = round(linspace(1,fix(ColorLen/2),NegativeColorSegment));
    NewColorMap(1:NegativeColorSegment,:) = OriginalColorMap(NegativeIndex,:);
    PositiveColorSegment = fix(1000*(PMax-PMin)/(PMax-NMax));
    if PositiveColorSegment == 0
        PositiveColorSegment = 1;
    end
    PositiveIndex = round(linspace(fix(ColorLen/2)+1,ColorLen,PositiveColorSegment));
    NewColorMap(end-PositiveColorSegment+1:end,:) = OriginalColorMap(PositiveIndex,:);
    
end