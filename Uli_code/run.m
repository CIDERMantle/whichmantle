%age1=[0,25:25:175]
age1=[1 9 12];
for i=1:length(age1);
dist1=20000*age1(i)
%pause
VsBurg

vssafe(i,:)=Vs;
Tsafe(i,:)=Te;
end
figure (123)
plot(Tsafe(1,1:end)-273,-delz/1000,'--k','LineWidth',2)
hold on
plot(Tsafe(2,1:end)-273,-delz/1000,'--r','LineWidth',2)
plot(Tsafe(3,1:end)-273,-delz/1000,'b','LineWidth',2)
%plot(Tsafe(4,1:end)-273,-delz/1000,'g','LineWidth',2)

figure(122)

plot(vssafe(1,(1:lz))./1000,-delz/1000,'--k','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
hold on
%plot(vssafe(2,(2:lz))./1000,dk,'LineWidth',2,'Color',[1 .7 0])%,Vsanh(2:lz)/1000,dk,'k')
plot(vssafe(2,(1:lz))./1000,-delz/1000,'--r','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
plot(vssafe(3,(1:lz))./1000,-delz/1000,'b','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
%plot(vssafe(4,(1:lz))./1000,-delz/1000,'g','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
%plot(vssafe(5,(2:lz))./1000,dk,'c','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
%plot(vssafe(6,(2:lz))./1000,dk,'b','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
%plot(vssafe(7,(2:lz))./1000,dk,'m','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
%plot(vssafe(8,(2:lz))./1000,dk,'k','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')

axis([3.8 5 -200 0])

%load ../../../FORT_INV_SP_BIN_WSNR/platemodelT.mat
%T1(1,:)=interp1(zz(:,1),T(:,2),delz./1000)+273;
%T1(2,:)=interp1(zz(:,1),T(:,250),delz./1000)+273;
%T1(3,:)=interp1(zz(:,1),T(:,750),delz./1000)+273;
%T1(4,:)=interp1(zz(:,1),T(:,1000),delz./1000)+273;
%T1(5,:)=interp1(zz(:,1),T(:,1750),delz./1000)+273;

%for i=1:length(age1);
%dist1=50000*age1(i)
%%pause
%VsBurg_plate%

%vssafep(i,:)=Vs;
%Tsafep(i,:)=Te;
%rend

%figure(122)

%plot(vssafep(1,(1:lz))./1000,-delz/1000,'--k','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
%hold on
%%plot(vssafe(2,(2:lz))./1000,dk,'LineWidth',2,'Color',[1 .7 0])%,Vsanh(2:lz)/1000,dk,'k')
%plot(vssafep(2,(1:lz))./1000,-delz/1000,'--r','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
%lot(vssafep(3,(1:lz))./1000,-delz/1000,'--b','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
%plot(vssafep(4,(1:lz))./1000,-delz/1000,'--g','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')
%x=isnan(vssafep(4,:));
%y=find(x==0);
%plot(vssafep(4,(y))./1000,-delz(y)/1000,'--g','LineWidth',2)%,Vsanh(2:lz)/1000,dk,'k')

%figure (123)
%plot(Tsafep(1,1:end)-273,-delz/1000,'--k','LineWidth',2)
%hold on
%plot(Tsafep(2,1:end)-273,-delz/1000,'--r','LineWidth',2)
%plot(Tsafep(3,1:end)-273,-delz/1000,'--b','LineWidth',2)
%plot(Tsafep(4,1:end)-273,-delz/1000,'--g','LineWidth',2)
%xlim([0 1500])
%ylim([-200 0])
