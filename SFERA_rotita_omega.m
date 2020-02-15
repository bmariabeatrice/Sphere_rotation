%% Initializarea parametrilor
close all
omega       = 0.1; %grade/unitatea de timp 
T_total     = 1000; %unitati de timp (s,min,h)

angle_min   = 0; %grade
angle_max   = omega*T_total; % nu e util in cazul de fata, dar poate fi folosit in cazul for - ului comentat
delta_angle = angle_max - angle_min;
step_t      = 5;
t0          = 0;

%% Alegerea modelului

sph = 'Earth_detailed';'Earth_sky';'Transparent';
%  -> Earth_detailed afiseaza Pamantul luand in considerare si relieful
%  -> Transparent afiseaza o sfera transparenta
%  -> Earth_sky afiseaza Pamantul ca un solid uniform inglobat intr-o sfera
%  transparenta 

%% Afisarea rezultatelor
figure
axesm('globe');

switch sph
    case 'Transparent'
        gridm('GLineStyle','-','Gcolor',[.7 .8 .9],'Grid','on')

        set(gca,'Box','off','Projection','perspective')
        axis off;
        for i = t0:step_t:T_total
            view(i*omega,0);     
            drawnow
        end

    case 'Earth_sky'
        gridm('GLineStyle','-','Gcolor',[.7 .8 .9],'Grid','on')

        set(gca,'Box','off','Projection','perspective')
        axis off
        base = zeros(180,360);
        baseR = georefcells([-90 90],[0 360],size(base));
        copperColor = [0.62 0.38 0.24];
        hs = geoshow(base,baseR,'FaceColor',copperColor);

        setm(gca,'Galtitude',0.025);
        axis vis3d


        for i = t0:step_t:T_total
            view(i*omega,23.5);     %  Axa Pamantului se inclina cu 23.5 grade
            drawnow
        end

    case 'Earth_detailed'
        
        load topo
        topo = topo / (earthRadius('km')* 20);
        hs = meshm(topo,topolegend,size(topo),topo);
        demcmap(topo)

        set(gcf,'color','black');
        axis off;
          camlight right

        for i = t0:step_t:T_total
            view(i*omega,23.5);    %  Axa Pamantului se inclina cu 23.5 grade
            drawnow
        end


end
