inputFile = 'noisySignal.wav';
Fs = 8000;
inputSig = audioread(inputFile);
[inputSigSize, numSig] = size(inputSig);
%%
cleanFile = 'cleanSignal.wav';
cleanSig = audioread(cleanFile);
%%
%Wiener Noise Reduction Technique
%Using Two Step Noise Reduction (TSNR) Method and Harmonic Regeneration Noise
%Reduction (HRNR) Method
[esTSNR, esHRNR] = WienerNoiseReduction(inputSig, Fs);
%%
%Wiener-TSNR Method Output
sound(esTSNR, Fs);
audiowrite('wTSNRoutput.wav', esTSNR, Fs);
%%
%Wiener-HRNR Method Output
sound(esHRNR, Fs);
audiowrite('wHRNRoutput.wav', esHRNR, Fs);
%%
%Spectral Signal Subtraction (SSS) Method Output
sssOut = SpectralSignalSubtraction(inputSig, Fs);
audiowrite('sssOutputSignal.wav', sssOut, Fs);
%%
%Mean Square Error (MSE) Calculations for each method
wTSNRmse = sum(sqrt(((esTSNR - cleanSig).^2)/inputSigSize));
wHRNRmse = sum(sqrt(((esHRNR - cleanSig).^2)/inputSigSize));
sssOUTmse = sum(sqrt(((sssOut - cleanSig(1:length(sssOut))).^2)/length(sssOut)));
%%
%Peak Signal-To-Noise Ratio (PSNR) Calculations for each method
wTSNRpsnr = 20*log10(max(abs(esTSNR))/wTSNRmse);
wHRNRpsnr = 20*log10(max(abs(esHRNR))/wHRNRmse);
sssOUTpsnr = 20*log10(max(abs(sssOut))/sssOUTmse);
%%
figure(1);
plot(inputSig, 'blue');
hold on;
plot(cleanSig, 'green');
hold off;
title('Clean Signal vs Input Signal');

figure(2);
plot(inputSig, 'blue');
hold on;
plot(esTSNR, 'green');
hold off;
title('Wiener-TSNR Output vs Input Signal');

figure(3);
plot(inputSig, 'blue');
hold on;
plot(esHRNR, 'green');
hold off;
title('Wiener-HRNR Output vs Input Signal');

figure(4);
plot(inputSig, 'blue');
hold on;
plot(sssOut, 'green');
hold off;
title('SSS Output vs Input Signal');