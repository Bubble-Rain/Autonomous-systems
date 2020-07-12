
figure()
hold on

%% Decide which waypoints to use

load('testWaypoints.mat')

% waypoints = testWaypoints;
waypoints = generateWaypoints; % Randomly generated

%% Visualise the waypoints

length = size(waypoints);
plot(2,2,'.','Color','b')
for i = 1:length(1)
    
    plot(waypoints(1,:),waypoints(2,:),'*','Color','red');
    
end

%% Visualize the map
load('mazePolyshape')
plot(mazeShape)

% Gridlines
for i = 0:0.5:20.5
    
    line([0 26],[i i],'Color','#c4c4cc')
    
end

for i = 0:0.5:26
    
    line([i i],[0 20.5],'Color','#c4c4cc')
    
end


%% Generate Paths

[optimizedPathO,distanceTravelledO] = branchBound(waypoints);

lent = size(optimizedPathO);

for i = 1:lent(2)-1
    line([optimizedPathO(1,i) optimizedPathO(1,i+1)],[optimizedPathO(2,i) optimizedPathO(2,i+1)],'Color','b')
end

[optimizedPathI,distanceTravelledI] = branchBoundImproved(waypoints);

lent = size(optimizedPathI);

for i = 1:lent(2)-1
    line([optimizedPathI(1,i) optimizedPathI(1,i+1)],[optimizedPathI(2,i) optimizedPathI(2,i+1)],'Color','r')
end

%% Populate axis,titles,labels,legend

% Only exists to provide a legend
original = line([-5 -90],[-5 -10],'Color','b');
improved = line([-5 -10],[-5 -10],'Color','r');
legend([original improved],{'Original','Improved'})

axis([-0.5 26.5 -0.5 21])
title('Optimal Path Comparison')
xlabel('X[meters]') 
ylabel('Y[meters]') 

disp(['Original Solution takes ' num2str(distanceTravelledO) 'm while Improved Solution takes ' num2str(distanceTravelledI) 'm' ])
