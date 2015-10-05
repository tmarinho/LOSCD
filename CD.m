close all;
video = 0 ;
%% Simulation Setup Parameters


%Robot

%% Control Parameters

rho_d = 10;
K_eta = 100;
ton  = 0;
toff = 10;
V_obs_max = 15;
%% Dialog
prompt = {'Predefined Case (1 for none)'};
dlg_title = 'Case select';
num_lines = 1;
def = {'1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
test = str2double(answer{:});
% Test cases
switch test
    
    case 1
        K_eta = 1;
        kpomega=1;
        kiomega=0;
        kdomega=1.5;
        Vr = 1;
        Initial_Position = [0,0] %[xo,yo]
        Destination = [1000,1000] % [xf,yf]
        Initial_Heading = -pi/4; %psio
        AutoPilot = tf([1],[1 1]);
        V_obs_max =20;
        
        %Obstacle
        Initial_Pos_Obs = [0,500] %[xo,yo]
        Destination_Obs = [1000,0] % [xf,yf]
        Initial_Head_Obs = -3*pi/4; %psio
        lambda_vec_0 = Initial_Pos_Obs - Initial_Position;
        lambda_0 = atan2(lambda_vec_0(2),lambda_vec_0(1));
        
    case 2
        K_eta = 0.5;
        kpomega=1;
        kiomega=0;
        kdomega=1.5;
        Vr = 1;
        Initial_Position = [0,0] %[xo,yo]
        Destination = [1000,1000] % [xf,yf]
        Initial_Heading = -pi/4; %psio
        AutoPilot = tf([1],[1 1]);
          V_obs_max =15;
        
        %Obstacle
        Initial_Pos_Obs = [500,500] %[xo,yo]
        Destination_Obs = [1000,000] % [xf,yf]
        Initial_Head_Obs = -pi/4-pi/2; %psio
        lambda_vec_0 = Initial_Pos_Obs - Initial_Position;
        lambda_0 = atan2(lambda_vec_0(2),lambda_vec_0(1));
        
                
    case 3
        K_eta = 0.5;
        kpomega=1;
        kiomega=0;
        kdomega=1.5;
        Vr = 1;
        Initial_Position = [0,0] %[xo,yo]
        Destination = [1000,1000] % [xf,yf]
        Initial_Heading = -pi/4; %psio
        AutoPilot = tf([1],[1 1]);
          V_obs_max =15;
        
        %Obstacle
        Initial_Pos_Obs = [500,500] %[xo,yo]
        Destination_Obs = [0,0] % [xf,yf]
        Initial_Head_Obs = -pi/4-pi/2; %psio
        lambda_vec_0 = Initial_Pos_Obs - Initial_Position;
        lambda_0 = atan2(lambda_vec_0(2),lambda_vec_0(1));
        
end
%%
CosOn = 0;
sim('CollisionSim.slx')
Yr = XYr(:,2);
Xr = XYr(:,1);
Yo = XYo(:,2);
Xo = XYo(:,1);


figure
Xmax = 1000
Ymax = 1000
axis([0 Xmax 0 Ymax])
%%
if 1
    
    jump=5;
    if video==1 
    writerObj = VideoWriter('CA_1Obj','Motion JPEG AVI');
    writerObj.FrameRate = 36;
    open(writerObj);
    winsize = [100 100 1240 620];
    hfig_vid = figure('Position',winsize);
    set(hfig_vid,'NextPlot','replacechildren')
    end
    %%
    flaglatch = 0;
    flaglatchoff = 0;
    for k=1:floor(length(Yr)/jump)
        k=k*jump;
        % plot(Xr(1:k),Yr(1:k),'b')
        % hold on
        if flag(k) == 0
            if flaglatchoff ==1
                CAoff = time(k);
                k
               flaglatchoff = 0; 
               CAoffpos = [Xr(k),Yr(k), Xo(k),Yo(k)];
            end
            plot(Xr(1:k),Yr(1:k),'b')
            hold on
            plot(Xr(k),Yr(k),'b*')
        else
            if flaglatch ==0
               CAon = time(k); 
               flaglatch = 1;
               flaglatchoff = 1;
            end
            plot(Xr(1:k),Yr(1:k),'g')
            hold on
            plot(Xr(k),Yr(k),'g*')
        end
        
        plot(Xo(1:k),Yo(1:k),'r')
        plot(Xo(k),Yo(k),'r*')
        axis([0 Xmax 0 Ymax])
        
        hold off
        
        text(0,Ymax,['t =',num2str(time(k),'%4.1f'),'s'],...
            'VerticalAlignment','middle',...
            'HorizontalAlignment','center',...
            'FontSize',14,...
            'BackgroundColor','w',...
            'Color','k',...
            'EdgeColor','k',...
            'FontAngle','italic',...
            'Margin',4,'LineWidth',2)
        text(Xmax,Ymax,['\eta =',num2str(180*eta(k)/pi,'%4.1f'),'deg'],...
            'VerticalAlignment','middle',...
            'HorizontalAlignment','center',...
            'FontSize',14,...
            'BackgroundColor','w',...
            'Color','k',...
            'EdgeColor','k',...
            'FontAngle','italic',...
            'Margin',4,'LineWidth',2)
        
        text(Xmax,0,['R =',num2str(range(k),'%4.1f'),'m'],...
            'VerticalAlignment','middle',...
            'HorizontalAlignment','center',...
            'FontSize',14,...
            'BackgroundColor','w',...
            'Color','k',...
            'EdgeColor','k',...
            'FontAngle','italic',...
            'Margin',4,'LineWidth',2)
        
        text(0,0,['ldh =',num2str(lambdothat(k),'%4.5f'),'u'],...
            'VerticalAlignment','middle',...
            'HorizontalAlignment','center',...
            'FontSize',14,...
            'BackgroundColor','w',...
            'Color','k',...
            'EdgeColor','k',...
            'FontAngle','italic',...
            'Margin',4,'LineWidth',2)
        
        pause(0.001)
          if video==1 
            Movmat=getframe(hfig_vid);
            writeVideo(writerObj,Movmat);
          end
        k=k/jump;
    end
      if video==1 
     close(writerObj);
      end
end

%%






if 0
    %%
    figure
    title('psdot')
    plot(time,psdot1)
    
    
end