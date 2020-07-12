function waypoints = generateWaypoints
    
    load('viableWaypoints');
    dimArray = size(xArray);
    length = dimArray(2);
    
    currentXArray = xArray;
    currentYArray = yArray;

    maxWaypoints = 5;
    waypoints = zeros(2,maxWaypoints);
    numAllocated = 0;

  
    while numAllocated < maxWaypoints
        
        %Generates an integer between 1 and n. 
        randomIndex = randi(length);
        
        x = currentXArray(randomIndex);
        y = currentYArray(randomIndex);
        
        currentXArray(randomIndex) = [];
        currentYArray(randomIndex) = [];
        
        dimArray = size(currentXArray);
        length = dimArray(2);
        
        numAllocated = numAllocated + 1;
        waypoints(1,numAllocated) = x;
        waypoints(2,numAllocated) = y;       

    end
    
    
end