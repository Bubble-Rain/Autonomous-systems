function spelunkBranch(currentPath,currentOrder,currentOptions,currentDistanceTravelled)

    global waypoints;
    global trueOptimalWaypoints;
    global optimalDistance;
    global Graph;

%% Recursion ends when there are no more options to choose
    if isempty(currentOptions)
        
        trueOptimalWaypoints = currentPath;
        optimalDistance = currentDistanceTravelled;
        
    else
%% Compute Recursion               


        currentWaypoint = currentOrder(end);
        option = currentOptions(1);
            
        branchOrder = [currentOrder option];           
        branchOptions = currentOptions(currentOptions ~= option);
            
        startingPointX = waypoints(1,currentWaypoint);
        startingPointY = waypoints(2,currentWaypoint);
            
        % Node names are of their co-ordinates
         nodeStartName = [ num2str(startingPointX) ',' num2str(startingPointY)]; 
         nodeEndName = [ num2str(waypoints(1,option)) ',' num2str(waypoints(2,option))]; 
         path = shortestpath(Graph,nodeStartName,nodeEndName);

         xArray = startingPointX;
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
            
         heuristicPath = [xArray ; yArray];
         [optimalPath,traversedDistance] = optimizePath(heuristicPath);
            
         optimalPath = optimalPath(:,2:end);
            
         branchPath = [currentPath(1,:) optimalPath(1,:) ; currentPath(2,:) optimalPath(2,:)] ;
         branchDist = currentDistanceTravelled + traversedDistance;

         moreOptimal = branchDist < optimalDistance;
            
         % Any branches not better than the current optimal solution
         % are pruned
         if moreOptimal
               branchOptimal = branchDist;
               spelunkBranch(branchPath,branchOrder,branchOptions,branchDist);
         else 
             branchOptimal = optimalDistance;
         end
        
        numOptions = length(currentOptions);
        
        for i = 2:numOptions
            
            option = currentOptions(i);
            
            branchOrder = [currentOrder option];           
            branchOptions = currentOptions(currentOptions ~= option);
                
            nodeEndName = [ num2str(waypoints(1,option)) ',' num2str(waypoints(2,option))]; 
            path = shortestpath(Graph,nodeStartName,nodeEndName);

            xArray = startingPointX;
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
            
            heuristicPath = [xArray ; yArray];
            [optimalPath,traversedDistance] = optimizePath(heuristicPath);
            
            optimalPath = optimalPath(:,2:end);
            
            branchPath = [currentPath(1,:) optimalPath(1,:) ; currentPath(2,:) optimalPath(2,:)] ;
            branchDist = currentDistanceTravelled + traversedDistance;

            moreOptimal = branchDist < branchOptimal;
            
            % Any branches not better than the current optimal solution
            % are pruned
            if moreOptimal
                branchOptimal = branchDist;
                spelunkBranch(branchPath,branchOrder,branchOptions,branchDist);
            end 

        end   
        
    end

end