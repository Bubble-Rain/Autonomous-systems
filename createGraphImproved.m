load('logicalMap');

%% Create mathematical Graph for the intersection of squares

maxRow = 41-1;
maxCol = 52-1;

mazeGraphImproved = graph;

% Array for checking which intersections have walls
wallArray = zeros(maxRow,maxCol);


yLimit = 41; 

% Create the nodes for the Graph

xArray = [];
yArray = [];

for i = 1:maxRow
    
   for j = 1:maxCol
       
       containsWall = sum(logicalMap(i:i+1,j:j+1),'all') > 0;

       if containsWall
           
           wallArray(i,j) = 1;
           
       else
          
           x = j * 0.5;
           y = 0.5*(yLimit - i);
           
           xArray = [xArray x];
           yArray = [yArray y];
           
           nodeName = [ num2str(x) ',' num2str(y) ];          
      
           mazeGraphImproved = addnode(mazeGraphImproved,nodeName);
           
       end    
       
   end
end

% Create the edges

dimArray = size(xArray);
length = dimArray(2);

for i = 1:length-1
    
   for j = i+1:length
      
        x1 =  xArray(i);
        y1 =  yArray(i);
        x2 =  xArray(j);
        y2 =  yArray(j);

        if pathViable(x1,y1,x2,y2)
            
            coOrdsToLookAt = [x1 y1; x2 y2];
            distance = pdist(coOrdsToLookAt);
            
            nodeName  = [ num2str(x1) ',' num2str(y1) ];
            nodeName2 = [ num2str(x2) ',' num2str(y2) ];

            mazeGraphImproved = addedge(mazeGraphImproved,nodeName,nodeName2,distance);

        end
       
   end
end

save('mazeGraphImproved.mat','mazeGraphImproved');
save('viableWaypoints','xArray','yArray');