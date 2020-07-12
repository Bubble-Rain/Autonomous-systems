load('logicalMap');

%% Create mathematical Graph for the intersection of squares

maxRow = 41-1;
maxCol = 52-1;

mazeGraph = graph;

% Array for checking which intersections have walls
wallArray = zeros(maxRow,maxCol);


yLimit = 41; 

% Create the nodes for the Graph

for i = 1:maxRow
    
   for j = 1:maxCol
       
       containsWall = sum(logicalMap(i:i+1,j:j+1),'all') > 0;

       if containsWall
           
           wallArray(i,j) = 1;
           
       else
          
           x = j * 0.5;
           y = 0.5*(yLimit - i);
           nodeName = [ num2str(x) ',' num2str(y) ];          
      
           mazeGraph = addnode(mazeGraph,nodeName);
           
       end    
       
   end
end

% Create the edges

for i = 1:maxRow
    
   for j = 1:maxCol
      
       noWall =  wallArray(i,j) == 0;
       
       % Only need to check to the right and below
       % because the intersection to the left
       % and above would've already been checked
       
       if noWall
              
           rightNoWall = wallArray(i,j+1) == 0;
           belowNoWall  = wallArray(i+1,j) == 0;
           
           % Don't need to check edge cases since
           % we already know the boundary is made up of walls
           
           if rightNoWall
               
               x = j * 0.5;
               x2 = x + 0.5;
               
               y = 0.5*(yLimit - i);
               nodeName  = [ num2str(x)  ',' num2str(y) ];
               nodeName2 = [ num2str(x2) ',' num2str(y) ];
               
               mazeGraph = addedge(mazeGraph,nodeName,nodeName2);
               
           end
           
           if belowNoWall 
               
               x = j * 0.5;
               y = 0.5*(yLimit - i);
               y2 = 0.5*(yLimit - (i+1));
               nodeName  = [ num2str(x)  ',' num2str(y) ];
               nodeName2 = [ num2str(x) ',' num2str(y2) ];
               
               mazeGraph = addedge(mazeGraph,nodeName,nodeName2);
               
           end
           
           
       end    
       
   end
end

save('mazeGraph.mat','mazeGraph');