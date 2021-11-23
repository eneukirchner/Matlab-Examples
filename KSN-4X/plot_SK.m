    function plot_SK(x,varargin)
%% Shift Keying Darstellung

%% Variablen
% Defaultwerte
if ~exist('type','var')
   type='ASK';
end
if ~exist('fs','var')
    fs=96e3; % Abtastfrequenz
end

if ~exist('f_T','var')
   f_T=8e3; % Trägerfrequenz
end

if ~exist('mode','var')
  mode='time'; % Darstellungsform
end

if ~exist('BR','var')
  BR=2e3; % Default - Symbolrate
end
if ~exist('eta','var')
    eta=1; % Default-Modulationsindex
end
if ~exist('m','var')
   m=0.5; % Modulationsgrad
end
if ~exist('u_T','var')
 u_T=1; % Default- Trägeramplitude
end

nr=nargin-1;
for i=1:nr
    switch varargin{i}
        case 'type'
            type=varargin{i+1};
        case 'mode'
            mode=varargin{i+1};
        case 'fs'
            fs=varargin{i+1};    
        case 'BR'
            BR=varargin{i+1};    
        case 'f_T'
            f_T=varargin{i+1}; 
        case 'u_T'
            u_T=varargin{i+1}; 
        case 'eta'
            eta=varargin{i+1};
        case 'm'
            m=varargin{i+1};
    end  
end

U_T_min=(1-m)*u_T; % Minimalwert der Trägeramplitude bei ASK
delta_f=eta*BR; % Abstand der Trägerfrequenzen bei FSK  

[~,nb]=size(x); % Anzahl der Bits 
max_num=2^nb-1; % größter Zahlenwert
[n,~]=size(x); % Anzahl der Zeichen in Eingangsfolge

if strcmp('FSK',type) && strcmp('constellation',mode)
        error('Bei FSK muss mode=time gewählt werden');
end


%% Symbole in unterschiedlichen Formaten
% Legende
% in: Eingangsfolge
% sym: alle möglichen Symbole
% dez: Dezimalzeichen
% char: Charakterzeichen
% _gray: Graycode 
% _nocopy: alle Elemente nur einmal
% _pos: Position

symdez=0:max_num; % alle Symbole im Dezimalsystem
symdez_gray=bin2gray(symdez,'pam',2^nb);  % alle Symbole im Graycode (dezimal)
symchar_gray=dec2bin(symdez_gray,nb);  % alle Symbole im Graycode (char) 
% Eingangsfolge in unterschiedlichen Formaten
indez=bin2dec(x); % Eingangsfolge (dezimal)
indez_nocopy=unique(indez,'stable'); % sortierte Eingangsfolge (dezimal)
inchar_gray=dec2bin(bin2gray(indez,'pam',2^nb),nb); % Eingangsfolge im Graycode (char)
 
[~ ,in_pos]=ismember(indez_nocopy,symdez);
in_pos=unique(in_pos,'stable'); % Position der vorkommenden Eingangswerte

% Zeitvektor für jedes Symvol
t=zeros(fs/BR,n); % Initialisierung
n_sym=length(t); % Anzahl der Elemente pro Symbol
for i=1:n
   t(:,i)=(i-1)/BR:1/fs:i/BR-1/fs; 
end

switch type
    case 'ASK'
    % Berechnungen für Konstellationsdiagramm
    dr=(u_T-U_T_min)/max_num; % Amplitudenschritte
    r=symdez*dr+U_T_min; % alle möglichen Amplituden (sortiert)
    phi=zeros(size(r)); % alle mögliche Phasen sind Null 
    % Berechnungen für zeitlichen Verlauf
    A= indez'/max_num*(u_T-U_T_min)+U_T_min;
    df=0;
    d_phi=0;
   
    case {'PSK'}
    % Berechnungen für Konstellationsdiagramm 
    dphi=2*pi/2^nb; % Phasenschritte
    phi=symdez*dphi; % alle möglichen Phasen (sortiert)
    dr=u_T;
    r=u_T*ones(size(phi)); % alle möglichen Amplituden sind U_T_max
    % Berechnungen für zeitlichen Verlauf 
    A=u_T;
    df=0;
    d_phi=phi(indez+1);
     
    case {'DPSK'}
    % Berechnungen für Konstellationsdiagramm 
    dphi=2*pi/2^nb; % Phasenschritte
    phi=symdez*dphi; % alle möglichen Phasenänderungen (sortiert)
    dr=u_T;
    r=u_T*ones(size(phi)); % alle möglichen Amplituden sind U_T_max
    % Berechnungen für zeitlichen Verlauf 
    A=u_T;
    df=0;
    d_phi=zeros(1,n);
    phi_in=phi(indez+1);
    for i=1:n
        d_phi(i)=mod(sum(phi_in(1:i)),2*pi); % Phasenwinkel zur Trägerfrequenz
    end
    
    case 'FSK'
    % kein Konstellationsdiagramm 
    % Berechnungen für zeitlichen Verlauf  
    f_min=-delta_f*max_num/2;
    delta_f=f_min+symdez*delta_f; % alle möglichen Frequenzabweichung von Trägerfrequenz (sortiert)
    df=delta_f(indez+1); % alle vorkommenden Frequenzabweichungen
    d_phi=0; % alle vorkommenden Phasen
    A=u_T; % alle vorkommenden Amplituden
    otherwise
         error('I donŽt know this SK-type!')
end

%% Darstellung  
figure();
switch mode
%% zeitlicher Signalverlauf
case 'time'
    y_NF=u_T/max_num.*(indez').*ones(length(t),1); % Modulationssignal 
    y_NF=y_NF(:);
    y_HF=A.*sin(2*pi*(f_T+df).*t+d_phi); % moduliertes Signal
    y_HF=y_HF(:);
    t=t(:);
    y_T=u_T*sin(2*pi*f_T*t);

hold off
    plot(t,y_NF,'r','LineWidth',1)
    hold on
    plot(t,y_HF,'k-','LineWidth',1)
    plot(t,y_T,'b--')
    grid on

    % Beschriftung
    legend('Nachricht','moduliertes Signal','Träger','location','southeast');
    xlabel('Zeit (Sekunden)');
    ylabel('u_{MOD} (Volt)');   
    if nb==1
        txt=[]; % keine Graycode-Beschriftung wenn Symbolbreite 1 Bit
    else
        txt='Werte im Gray-Code';
    end
    title({[type ': zeitlicher Verlauf'],txt});
    xt=(1:length(indez))'*n_sym/(fs)-n_sym/(1.5*fs); % Beschriftung ungefähr in Signalmitte
    yt=zeros(length(indez),1);
    text(xt,yt,inchar_gray,'Color','blue')
    

%% Konstellationsdiagramm
case 'constellation'
   hold off
   l=1:2^nb;
   polarplot(phi(l),r(l),'ko','MarkerSize',10)
   hold on    
   [XT,YT]=pol2cart(phi(l),r(l));
   YT=YT-0.1*u_T; % Offset für Symbolbeschriftung
   [PT,RT]=cart2pol(XT,YT);
   ht=text(PT,RT,num2str(symchar_gray(l,:)),'Color','blue');
   set(ht,'Rotation',-90)
   polarplot(phi(in_pos),r(in_pos),'rx','MarkerSize',10)     
   txt={[type ': Konstellationsdiagramm']};
   
   if nb>1
        txt(2)={'Werte im Gray-Code'};       
   end
   if strcmp(type,'DPSK')
        txt(2)={'(Winkeländerungen)'};
   end
   
    title(txt)
    % Beschriftung Winkel
    ticks=0:30:330;
    thetaticks(ticks);
    tlabel=num2cell(ticks);
    tlabel(1)={''}; tlabel(7)={''};
    thetaticklabels(tlabel);

    % Beschriftung Radien
    ticks=0:dr:u_T;
    rlim([0,u_T]);
    rticks(ticks);
    rlabel=char(' '.*ones(size(ticks))); % erzeuge Beschriftungsarry mit Leerzeichen
    rticklabels(rlabel);
end
end
