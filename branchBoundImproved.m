function [optimalWaypoints,finalDistance] =  branchBoundImproved(inputWaypoints)

%% Setup
    load('mazeGraphImproved.mat');
    load('mazePolyshape.mat');
    
    global Graph;
    Graph = mazeGraphImproved;
    
    global mazePolyshape;
    mazePolyshape = mazeShape;
    
    global waypoints;
    waypoints = inputWaypoints;
    
    global trueOptimalWaypoints;
    trueOptimalWaypoints = [];
    
    global waypointOptions;
    waypointOptions = [1 2 3 4 5];
    
    global optimalDistance;
    optimalDistance = 100000;
    
    startintPointX = 2;
    startingPointY = 2;
   
 %% Begin branching
 
    for i = 1:5

        
        updatedOptions = waypointOptions(waypointOptions~=i);
        
        % Node names are of their co-ordinates
        nodeStartName = [ num2str(startintPointX) ',' num2str(startingPointY)]; 
        nodeEndName = [ num2str(waypoints(1,i)) ',' num2str(waypoints(2,i))]; 
        [path,traversedDistance] = shortestpath(Graph,nodeStartName,nodeEndName);
        
        xArray = startintPointX;
        yArray = startingPointY;
        len = size(path);
        
        % Destringify the path
        for j = 2:len(2)

            newStr = split(path{j},',');
            nextX  = str2double(newStr{1});
            nextY  = str2double(newStr{2});
            
            xArray = [xArray nextX];
            yArray = [yArray nextY];

        end
        
        optimalPath = [xArray ; yArray];
        order = i;
            
        %Note this function is recursive
        spelunkBranchImproved(optimalPath,order,updatedOptions,traversedDistance)

    end

    optimalWaypoints = trueOptimalWaypoints;
    finalDistance = optimalDistance;

end 

