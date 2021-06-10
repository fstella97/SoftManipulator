%% mouse clicked?
close all 
clear all 
clc 

figure(1)
                      hold on 
                      figure('units','normalized','outerposition',[0 0 1 1])
                      patch([0,1,1,0],[0,0,1,1],'r')
                      xlim([0,1])
                      ylim([0,1])

fig = uifigure;
ax = uiaxes('Parent',fig,...
            'Units','pixels',...
            'Position', [104, 123, 300, 201]); 
           
           btn = uibutton(fig,'push',...
               'Position',[420, 218, 100, 22],...
               'ButtonPushedFcn', @(btn,event) plotButtonPushed(btn,ax));

%% 


% 
% DlgH = figure;
% H = uicontrol('Style', 'PushButton', ...
%               'String', 'Contact with Soft Robot', ...
%               'Callback', 'delete(gcbf)');
%           fig = uifigure
% btn = uibutton(fig,'push',...
%                'Position',[420, 218, 100, 22],...
%                'ButtonPushedFcn', @(btn,event) plotButtonPushed(btn,ax))

g=1
       drawnow  
%               while ishandle(H)
%                   if g==1
%                       figure(2)
%                       hold on 
%                       patch([0,1,-1,0],[1,0,0,-1],'g')
%                       xlim([0,1])
%                       ylim([0,1])
%                       g=0
%                          drawnow  
%                   end
%               end
%               disp('sonoqui')
%               figure(2)
%               patch([0,1,-1,0],[1,0,0,-1],'r')
              
              
            function plotButtonPushed(btn,ax)
        figure(1)
        hold on
             figure('units','normalized','outerposition',[0 0 1 1])
              patch([0,1,1,0],[0,0,1,1],'g')
     

end