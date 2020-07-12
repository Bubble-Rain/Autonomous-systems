load('logical_occupancy_map');

%% Define polyshape

% Use intersections to define shape
maxRow = 41-1;
maxCol = 52-1;

yLimit = 41; 

% Store the co-ordinates of the intersections with walls
xArray = [];
yArray = [];


% Populate arrays
for i = 1:maxRow
    
   for j = 1:maxCol
       
       containsWall = sum(map_logical_values(i:i+1,j:j+1),'all') > 0;

       if containsWall
           
            x = j * 0.5;
            y = 0.5*(yLimit - i);
            xArray = [xArray x];
            yArray = [yArray y];
           
       end    
       
   end
   
   
end

%% Manually define the polyshape

% Create the outermost boundary
outerBoundaryX = [ 0 26 26 0 0];
outerBoundarY = [ 20.5 20.5 0 0 20.5];

shape = polyshape(outerBoundaryX,outerBoundarY);

plot(xArray,yArray,'.')
hold on

% Create the innermost boundary
innerBoundaryX = [0.5 0.5 7 7 0.5 0.5  7  7 0.5 0.5 2.5 2.5 0.5 0.5 4.5 4.5 7 7 5 5 9 9 12.5 12.5 9.5 9.5 14.5 14.5 15 15 20 20 17 17 20.5 20.5 25.5 25.5 17 17 20 20 20.5 20.5 25.5 25.5 15 15 14.5 14.5 9.5 9.5 12.5 12.5 9 9 0.5];
innerBoundaryY = [20  16  16 15.5 15.5 6 6 5.5 5.5 3.5 3.5 3 3 0.5 0.5 3.5 3.5 3 3 0.5 0.5 3.5 3.5 3 3 0.5 0.5 3.5 3.5 0.5 0.5 3 3 3.5  3.5 0.5 0.5 5.5 5.5 6 6 8 8 6 6 20 20 15.5 15.5 20 20 16 16 15.5 15.5 20 20];

% Create the walls in the top right corner
upsideDownTx = [ 20 20 17 17  23.5 23.5 20.5 20.5];
upsideDownTy = [ 18.5 16 16 15.5 15.5 16 16 18.5];

% Create the walls in the middle
middleX = [ 2.5 9 9 12.5 12.5 9.5 9.5 14.5 14.5 15 15 20.5 20.5 17 17 20 20 15 15 14.5 14.5 9.5 9.5 12.5 12.5 9 9  5  5 7 7 4.5 4.5 2.5];
middleY = [ 10 10 5.5 5.5 6 6 10 10 5.5 5.5 10 10 13.5 13.5 13 13 10.5 10.5 13.5 13.5 10.5 10.5 13 13 13.5 13.5 10.5 10.5 13 13 13.5 13.5 10.5 10.5];

x = [outerBoundaryX innerBoundaryX];
y = [outerBoundarY innerBoundaryY];
mazeShape = polyshape(x,y);
mazeShape = addboundary(mazeShape, upsideDownTx, upsideDownTy);
mazeShape = addboundary(mazeShape, middleX, middleY); 
plot(mazeShape)

save('mazePolyshape.mat','mazeShape');