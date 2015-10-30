close all;
Path = [1 1];
Initial_Position = [-80 -100];
Initial_Heading = -pi/4;
Initial_Position_O = [100 300];
Initial_Position_O = [-300 -200];
K_eta = 0.21;
 lambda_vec_0 = Initial_Position_O - Initial_Position;
 lambda_0 = atan2(lambda_vec_0(2),lambda_vec_0(1));

rangethresh = 50;


sim('PathFollowComp.slx')

Xr = Rabbit.signals.values(:,1);
Yr = Rabbit.signals.values(:,2);

Xt = Cdc.signals.values(:,1);
Yt = Cdc.signals.values(:,2);

Xa = AlphaBased.signals.values(:,1);
Ya = AlphaBased.signals.values(:,2);

Xo = Obstacle.signals.values(:,1);
Yo = Obstacle.signals.values(:,2);


Xnr = NewRabbit.signals.values(:,1);
Ynr = NewRabbit.signals.values(:,2);

jump = 20;
time = Rabbit.time;
%%
start = 15000;
figure;
for k=(20000/jump):length(Rabbit.signals.values(:,1))/jump
j = k*jump;
plot(Xnr(start:j),Ynr(start:j),'m')
 hold on;
 if flag(j) == 0
plot(Xt(start:j),Yt(start:j),'r')
 else
     plot(Xt(start:j),Yt(start:j),'r--')
 end
 
 
if flag2(j) == 0
    plot(Xa(start:j),Ya(start:j),'g')
elseif flag2(j) == 1
    plot(Xa(start:j),Ya(start:j),'g--')
else
    plot(Xa(start:j),Ya(start:j),'g--','LineWidth',2.5)
end
plot(Xr(start:j),Yr(start:j),'b--')
plot(Xo(start:j),Yo(start:j),'k')
axis([-300 300 -300 300])
%axis([-150 0 -200 150])
text(0,300,['t =',num2str(time(j),'%4.1f'),'s'],...
            'VerticalAlignment','middle',...
            'HorizontalAlignment','center',...
            'FontSize',14,...
            'BackgroundColor','w',...
            'Color','k',...
            'EdgeColor','k',...
            'FontAngle','italic',...
            'Margin',4,'LineWidth',2)
        
        text(0,-300,['eta =',num2str(180*eta1(j)/pi,'%4.1f'),'s'],...
            'VerticalAlignment','middle',...
            'HorizontalAlignment','center',...
            'FontSize',14,...
            'BackgroundColor','w',...
            'Color','k',...
            'EdgeColor','k',...
            'FontAngle','italic',...
            'Margin',4,'LineWidth',2)
        
            text(-200,-300,['Range =',num2str(Range(j,2),'%4.1f'),'m'],...
            'VerticalAlignment','middle',...
            'HorizontalAlignment','center',...
            'FontSize',14,...
            'BackgroundColor','w',...
            'Color','k',...
            'EdgeColor','k',...
            'FontAngle','italic',...
            'Margin',4,'LineWidth',2)
        hold off;
        pause(0.01)
end


