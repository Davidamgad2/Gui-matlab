clear all;
close all;

%definitions of variables
f1=400;             %hertz
f2=800;             %hertz
f3=1200;            %hertz
f4=1600;            %hertz
f5=2000;            %hertz
FS=20000;           %% samples per second
dt=1/FS;            %% seconds per samples
t = -1:dt:1-dt;         %seconds

%the signal
x= cos(2*pi*f1*t) + sin(2*pi*f2*t) + cos(2*pi*f3*t) + sin(2*pi*f4*t) + cos(2*pi*f5*t);

% Q2:audio 
audiowrite('audio file x(t).wav',x,FS);

% Q3-  figure of x(t) versus t 
figure;
plot(t,x);
xlabel('time (sec)');
ylabel('x(t)');
title('x(t) versus time ')

%Q4:energy calculation from x(t)
z= @(t)cos(2*pi*f1*t) + sin(2*pi*f2*t) + cos(2*pi*f3*t) + sin(2*pi*f4*t) + cos(2*pi*f5*t);
en=integral(@(t) z(t).*z(t) ,-1,1);
disp (en);

% Q5: the frequancy spectrum

%%Fourier Transform:
   X = fftshift(fft(x));
   n=length(X);
     
%%Frequency specifications:
   f = -FS/2:FS/n:(FS/2)-(FS/n);     %EDITTTTTT         % hertz
   
%%Q6: Plot the spectrum x(f) :
   figure;
   plot(f,abs(X)/n);
   xlabel('Frequency (in hertz)');
   ylabel('magnitude');
   title(' spectrum of x(f)');
   
%Q7: energy from the spectrum X(f)
energy0 = sum(abs(X).^2/(FS*n));
disp(energy0);

%Q8 :butter worth low pass filter
fc=1250;             %hertz
wn=fc/(FS/2);  %edittttt
[b,a]=butter(20,wn);  %ediiit2

% Q9: bode plot 

%magnitude and phase 
figure;
freqz(b, a);  %edit2 leaving n exists makes nosises

%Q10:making y(t)
y=filter(b,a,x);

%Q11: audio of y(t)
audiowrite('audio file of y(t).wav',y,FS);

%Q12: plot of y(t) versus time  
figure;
plot(t,y);
xlabel('time (sec)');
ylabel('y(t)');

%Q13: the frequency spectrum Y(F)
Y=fftshift(fft(y));
N=length(y);

%Q14:Plotion the magnitude of Y(f)

 figure;
   plot(f,abs(Y)/n);
   xlabel('Frequency (in hertz)');
   ylabel('magnitude');
   title(' spectrum of y(f)');