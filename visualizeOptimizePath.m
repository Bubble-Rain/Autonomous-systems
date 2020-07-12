function [optimalPath,distanceTravelled] = visualizeOptimizePath(path)

%% Setup

    optimalPath = [ path(1,1) ; path(2,1)];
    
    sizePath = size(path);
    numCols = sizePath(2);
    totalNodesToCheck = numCols-1;
    
    currentNode = 1;
    i = 2;
    notOptimized = true;
   
    
%% Optimize path by removing waypoints that are not needed
    while notOptimized
        
        x1 =  path(1,currentNode);
        y1 =  path(2,currentNode);
        x2 =  path(1,i+1);
        y2 =  path(2,i+1);
        
        % Check if the current waypoint could traverse to n+1 waypoint
        if visualizePathViable(x1,y1,x2,y2) == false

            optimalPath =  [optimalPath(1,:) path(1,i) ; optimalPath(2,:) path(2,i)];
            currentNode = i;
            
        end
        
        i = i+1;
        
        if i > totalNodesToCheck
            notOptimized = false;
        end
        
    end
    
    % Add in the the original end waypoint
    optimalPath =  [optimalPath(1,:) path(1,numCols) ; optimalPath(2,:) path(2,numCols)];

%% Calculate Total distance travelled

    sizePath = size(optimalPath);
    numCols = sizePath(2);
    totalDistToAdd = numCols-1;

    distanceTravelled = 0;
    
    for i = 1:totalDistToAdd
        
        coOrdsToLookAt = [ optimalPath(1,i) optimalPath(2,i); optimalPath(1,i+1) optimalPath(2,i+1)];
        nodeDistance = pdist(coOrdsToLookAt);
        distanceTravelled = distanceTravelled + nodeDistance;

    end
       
end
