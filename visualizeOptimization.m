hold on

%% Decide which nodes to traverse
nodeStartName = [ num2str(2) ',' num2str(2)]; 
nodeEndName = [ num2str(25) ',' num2str(19)]; 

%% Dispaly maze

load('mazeGraph.mat')
length = size(mazeGraph.Nodes);
for i = 1:length(1)
   
    
    newStr = split(mazeGraph.Nodes(i,1).Name,',');
    x = str2double(newStr{1});
    y = str2double(newStr{2});
    plot(x,y,'.');
    

end

load('mazePolyshape')
plot(mazeShape)

for i = 0:0.5:20.5
    
    line([0 26],[i i],'Color','#c4c4cc')
    
end

for i = 0:0.5:26
    
    line([i i],[0 20.5],'Color','#c4c4cc')
    
end

%% Create heuristic path
path = shortestpath(mazeGraph,nodeStartName,nodeEndName);
        
xArray = 2;
yArray = 2;
len = size(path);
        
% Destringify the path
for j = 2:len(2)

    newStr = split(path{j},',');
    nextX  = str2double(newStr{1});
    nextY  = str2double(newStr{2});
            
    xArray = [xArray nextX];
    yArray = [yArray nextY];

end
        
heuristicPath = [xArray ; yArray];

% Display the heuristic path
dimensions = size(heuristicPath);
length = dimensions(2);

for i = 1:length-1
    line([heuristicPath(1,i) heuristicPath(1,i+1)],[heuristicPath(2,i) heuristicPath(2,i+1)])
end

%% Optimize the solution

[optimalPath,traversedDistance] = visualizeOptimizePath(heuristicPath);

% Display the optimized path
dimensions = size(optimalPath);
length = dimensions(2);

for i = 1:length-1
    line([optimalPath(1,i) optimalPath(1,i+1)],[optimalPath(2,i) optimalPath(2,i+1)],'Color','r')
end

%% Display legend, axis, labels

axis([-0.5 26.5 -0.5 21])

title('Visualize optimization')
xlabel('X[meters]') 
ylabel('Y[meters]') 