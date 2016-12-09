function K = colorTransfer(I, J)
%COLORTRANSFER Summary of this function goes here
%   Detailed explanation goes here
%change I
%use J to change I
%K is the final output of I*change
%K = mycolortransfer(I, J)
targetlab = rgb2lab(I);
sourcelab = rgb2lab(J);

Ltarget = targetlab(:,:,1);
Atarget = targetlab(:,:,2);
Btarget = targetlab(:,:,3);

Lsource = sourcelab(:,:,1);
Asource = sourcelab(:,:,2);
Bsource = sourcelab(:,:,3);

%Lout
LsourceSTD = std2(Lsource);
LsourceM = mean2(Lsource);

LtargetSTD = std2(Ltarget);
LtargetM = mean2(Ltarget);

Lout = (LtargetSTD/LsourceSTD)*(Lsource - LsourceM) + LtargetM;

%Aout
AsourceSTD = std2(Asource);
AsourceM = mean2(Asource);

AtargetSTD = std2(Atarget);
AtargetM = mean2(Atarget);

Aout = (AtargetSTD/AsourceSTD)*(Asource - AsourceM) + AtargetM;

%Bout
BsourceSTD = std2(Bsource);
BsourceM = mean2(Bsource);

BtargetSTD = std2(Btarget);
BtargetM = mean2(Btarget);

Bout = (BtargetSTD/BsourceSTD)*(Bsource - BsourceM) + BtargetM;

labout = cat(3, Lout, Aout, Bout);

K = lab2rgb(labout);

end
