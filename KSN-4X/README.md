# Beispiele zur Modulation
## Zusammenfassung mit grafischen Animationen
https://www.elttam.com/blog/intro-sdr-and-rf-analysis/

## Amplitudenmodulation (AM)
https://www.elektroniktutor.de/signalkunde/am.html

## Frequenzmodulation (FM)
https://www.elektroniktutor.de/signalkunde/fm.html  
Suche dir die Formel zur Frequenzmodulation aus dem Grundlagenartikel heraus.  
*Tipp: Für das in der Formel vorkommende Integral verwende die Funktion `cumsum(x)` in Matlab.*

Stereo-Multiplex-Signal:  
https://www.st-andrews.ac.uk/~www_pa/Scots_Guide/RadCom/part21/page1.html

## Digitale Modulationsarten

### Grundlegendes

Bei den hier besprochenen digitalen Modulationsarten ist der Träger stets analog (d.h. sinusförmig), das Basisbandsignal dagegen digital. Der Einfachheit halber simulieren wir mit einer Zeichenfolge 10101010..., dadurch ergibt sich ein Rechtecksignal. Dafür gibt es eine eigene Matlab-Funktion:

```
ub=square(2*pi*fb*t);
```

Das Problem dabei: Ein ideales Rechtecksignal `square(x)` hat unendlich steile Flanken und somit auch ein unendlich breites Fourierspektrum. Real ist so etwas nicht möglich, außerdem entsteht bei der Simulation ein asymmetrisches Spektrum aufgrund von Aliasing-Fehlern - das Shannon-Theorem wird verletzt. Um die Flankensteilheit zu verringern, gibt es zwei Möglichkeiten:

- Verwendung einer Fourier-Reihe anstelle der Funktion `square(x)`, wobei man beispielsweise nach dem dritten Reihenglied abbricht
- Filterung mittels Tiefpass:

```
LPF_ASK=designfilt('lowpassfir', 'PassbandFrequency', 2000, 'StopbandFrequency', 4000, 'PassbandRipple', 1, 'StopbandAttenuation', 80, 'SampleRate', fs); 
 
ub=filter(LPF_ASK,ub);
```
Die Parameter müssen passend zu den bearbeiteten Signalen gewählt werden. Erklärung <https://www.mathworks.com/help/signal/ref/designfilt.html>

Im ersten Durchgang verwenden wir nur zweiwertige Modulationsarten, ein Übertragungsschritt des modulierten Signals enthält ein Bit.

### Details Amplitude Shift Keying (ASK)
https://www.elektroniktutor.de/signalkunde/ask.html  
Life-Beispiel: https://www.youtube.com/watch?v=WqAqPEXZs-Q&t=17380s  
 
Meist wird diese Modulationsart als reines On-Off-Keying (OOK) realisiert, dabei wird beispielsweise dem Logikzustand 0 der Wert "off" und dem Logikzustand 1 der Wert "on" zugeordnet. Zur Erzeugung des OOK-Signals wird das Trägersignal uc mit dem Basisbandsignal ub multipliziert, welches eine Amplitude zwischen 0 und 1 aufweist.

### Details Binary Phase Shift Keying (BPSK)
https://www.elektroniktutor.de/signalkunde/pm.html  
Dieses Signal wird ähnlich wie OOK erzeugt, allerdings wird einem der beiden Logikzustände eine Phasendrehung von 180° zugeordnet. Daher muss das Basisbandsignal ub Amplitudenwerte zwischen -1 (logisch 0) und +1 (logisch 1) aufweisen.

### Details Frequency Shift Keying (FSK)
https://www.elektroniktutor.de/signalkunde/fsk.html  
Den beiden Logikzuständen des Basisbandsignals (Amplitude -1 ... +1) werden zwei Kennfrequenzen des modulierten Signals zugewiesen. Der Abstand der Kennfrequenzen voneinander heißt Frequenzhub (delta_f):
```
delta_f=0.1; 
um = cos(2*pi*t*fc.*(1 + delta_f*ub));
```
