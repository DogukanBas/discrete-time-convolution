clc;clear all;close all;
opt=input("Soru 1 icin 1 \nSoru 2 icin 2\nSoru 3 icin 3:");
if(opt==1)
    [x,n,indexOfFirstElX,y,m,indexOfFirstElY,output,timeAxis] = soru1();
    stem(timeAxis,output);

elseif(opt==2)
    soru2();
elseif(opt==3)
    [x,output,builtinConvOutput,hArray] = soru3(); 
end



function [x,n,indexOfFirstElX,y,m,indexOfFirstElY,output,timeAxis] =soru1()

    
    n=input("Ilk dizinin boyutu:");
    disp("Sırasıyla elemanları");
    x=zeros(1,n);
    for i=1:n
        x(i)=input("");
    end
    indexOfFirstElX=input("x isaretinin ilk elemanının indisi kaçtır?");

    m=input("Ikinci dizinin boyutu:");
    y=zeros(1,m);
    disp("Sırasıyla elemanları");
    for i=1:m
        y(i)=input("");
    end
    indexOfFirstElY=input("Y isaretinin ilk elemanının indisi kaçtır?");
   
    [output,indexOfFirstEl] = myConv(x ,n,indexOfFirstElX,y,m,indexOfFirstElY);
    
    timeAxis=zeros(1,n+m-1);
    for i=1:n+m-1
        timeAxis(i)= i+indexOfFirstEl-1;
    end
  

end

function [] = soru2()
    [x,n,indexOfFirstElX,y,m,indexOfFirstElY,output,timeAxis]=soru1();
    builtInOutput=conv(x,y);
    timeAxisX=zeros(1,n);
    timeAxisY=zeros(1,m);
    for i=1:n
        timeAxisX(i)= i+indexOfFirstElX-1;
    end
    for i=1:m
        timeAxisY(i)= i+indexOfFirstElY-1;
    end

    t = tiledlayout(4,1);   
   
    nexttile
    stem(timeAxisX,x);
    title('x[n]')
    
    nexttile    
    stem(timeAxisY,y);
    title('y[n]') 
    
    nexttile
    stem(timeAxis,output);
    title('My Convolution x[n]∗y[n]')

    nexttile()
    stem(timeAxis,builtInOutput);
    title("Built-in convolution x[n]∗y[n]")

   
    display(x)
    display(timeAxisX)
    display(y)
    display(timeAxisY)
    display(output)
    display(builtInOutput)

end

function [x,output,builtinConvOutput,hArray] = soru3()
    A=input("A degerini giriniz:");
    m1=input("M aralığının ilk degerini giriniz (tek bir m değeri icin islem yapmak icin ilk ve son degeri aynı giriniz):");
    m2=input("M aralığının son değerini giriniz:");
    seconds=input("Kac saniye ses kaydedeceksiniz? (5,10)");

        



          
    recObj = audiorecorder(8000,16,1); %% kayıt başlatma nesnesi
    disp('Start speaking.') %% ekrana mesaj
    recordblocking(recObj, seconds); %% kayıt işlemi
    disp('End of Recording.'); %% ekrana mesaj
    x = getaudiodata(recObj); %% kaydedilen sesi x değişkenine saklama
    x=x.';
    
    
    for m=m1:m2
        hArray=zeros(1,m*400+1);
        hArray(1)=1;
        for k=1:m
             hArray(400*k+1)=A*k;
        end
        [output,~] = myConv(x ,8000*seconds,0,hArray,m*400+1,0);
        builtinConvOutput = conv(x,hArray);
    
        figure(m-1);
        t = tiledlayout(4,1);   
       
        nexttile
        stem(hArray);
        title('h[n]')
        
        nexttile    
        stem(x);
        title('Input Audio') 
        
        nexttile
        stem(output);
        title('My Convolution')
    
        nexttile()
        stem(builtinConvOutput);
        title("Built-in convolution")
    end
    
       
        
    
end



function [output,indexOfFirstEl] = myConv(x ,n,indexOfFirstElX,y,m,indexOfFirstElY)
    newLength=n+m-1;
    output=zeros(1,newLength);
    indexOfFirstEl=indexOfFirstElX+indexOfFirstElY;

    for i=1:newLength
        toplam=0;
        for k=1:i
            if(k<=n) && (i-k+1<=m)
                toplam=toplam+(x(k)*y(i-k+1));
            end
        end
        output(i)=toplam;
    end

end

