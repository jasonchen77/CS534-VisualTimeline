function K = colorTransfer(I, J)
%COLORTRANSFER Summary of this function goes here

%change I
%use J to change I
%K is the final output of I*change
%K = mycolortransfer(I, J)

%conversion from rgb to lab
targetlab = rgb2lab(I);
sourcelab = rgb2lab(J);

%next 6 lines reduce the 3d LAB images to 3x1d matrices corresponding to L,A,B
Ltarget = targetlab(:,:,1);
Atarget = targetlab(:,:,2);
Btarget = targetlab(:,:,3);

Lsource = sourcelab(:,:,1);
Asource = sourcelab(:,:,2);
Bsource = sourcelab(:,:,3);

%using method from paper on color transfer to alter image in LAB form.
%then convert back from LAB to RGB

%Lout
LsourceSTD = std2(Lsource);
LsourceM = mean2(Lsource);

LtargetSTD = std2(Ltarget);
LtargetM = mean2(Ltarget);

%L channel modification output
Lout = (LtargetSTD/LsourceSTD)*(Lsource - LsourceM) + LtargetM;

%Aout
AsourceSTD = std2(Asource);
AsourceM = mean2(Asource);

AtargetSTD = std2(Atarget);
AtargetM = mean2(Atarget);

%A channel modification output
Aout = (AtargetSTD/AsourceSTD)*(Asource - AsourceM) + AtargetM;

%Bout
BsourceSTD = std2(Bsource);
BsourceM = mean2(Bsource);

BtargetSTD = std2(Btarget);
BtargetM = mean2(Btarget);

%B channel modification output
Bout = (BtargetSTD/BsourceSTD)*(Bsource - BsourceM) + BtargetM;

labout = cat(3, Lout, Aout, Bout);

K = lab2rgb(labout);

end
