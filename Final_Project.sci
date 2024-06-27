function [t,xt,Fs,num_samples]=original_signal(wav)
    [xt,Fs]=wavread(wav)
    num_samples = size(xt,2);
    t = (0:num_samples-1) / Fs;
    disp(Fs)
    subplot(4,1,1)
    plot2d3(t, xt(1, :));
    xlabel('Seconds')
    ylabel('Magnitude')
    title('Original signal')
endfunction
    
function [xn] = FFT_signal(xt,Fs,num_samples)
    xn = fft(xt(1,:))
    xn_abs=abs(xn)
    f = (0:num_samples-1) * (Fs / num_samples);
    subplot(4,1,2)
    plot2d3(f,xn_abs)
    xlabel('Frequency')
    ylabel('Magnitude')
    title('Fourier Transform')
endfunction
    
function [F1]=Filter_signal(xt,Fs)
    flc = 70;
    fhc = 900;
    fhc_norm=fhc/Fs/2
    flc_norm=flc/Fs/2
    hz=iir(3,'bp','butt',[flc_norm fhc_norm],[0.1 0.1])
    [hzm,fr]=frmag(hz,1024)
    x_iir = flts(xt(1,:),hz)
    F1 = fft(x_iir)
    F_abs = abs(F1)
    subplot(4,1,3)
    plot2d3(F_abs)
    xlabel('Frequency')
    ylabel('Magnitude')
    title('Filtered')
endfunction

function [IIRFilteredAudio]=Inverse(t,f_signal,Fs)
    IIRFilteredAudio = ifft(f_signal)
    subplot(4,1,4)
    plot2d3(t,IIRFilteredAudio(1,:))
    xlabel('Frequency')
    ylabel('Magnitude')
    title('Clear Signal')
endfunction


[t,xt,Fs,num_samples]=original_signal("D:\SEMESTER 4\COOLYEAH FINAL PROJECT\PEMSIN\Final_Project\Ori_v1.wav")
[xn] = FFT_signal(xt,Fs,num_samples)
[F1]=Filter_signal(xt,Fs)
[IIRFilteredAudio]=Inverse(t,F1,Fs)
wavwrite(IIRFilteredAudio, Fs, 'ClearAudio.wav');
