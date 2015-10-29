close all;
Path = [1 1];
Initial_Position = [-80 -100];
Initial_Heading = -pi/4;
Initial_Position_O = [100 300];
Initial_Position_O = [-300 -200];
K_eta = 0.2;
 lambda_vec_0 = Initial_Position_O - Initial_Position;
 lambda_0 = atan2(lambda_vec_0(2),lambda_vec_0(1));

rangethresh = 150;


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

jump = 50;
time = Rabbit.time;
%%
figure;
for k=1:length(Rabbit.signals.values(:,1))/jump
j = k*jump;
plot(Xnr(1:j),Ynr(1:j),'m')
 hold on;
 if flag(j) == 0
plot(Xt(1:j),Yt(1:j),'r')
 else
     plot(Xt(1:j),Yt(1:j),'r--')
 end
 
 
if flag2(j) == 0
    plot(Xa(1:j),Ya(1:j),'g')
else
    plot(Xa(1:j),Ya(1:j),'g--')
end
plot(Xr(1:j),Yr(1:j),'b--')
plot(Xo(1:j),Yo(1:j),'k')
axis([-300 300 -300 300])
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


