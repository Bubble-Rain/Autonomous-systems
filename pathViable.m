function [pathIsViable] = pathViable(x1,y1,x2,y2)

%% Setup

    pathIsViable = true;

    % Calculate gradient
    if x2 == x1
        m = 0;
    else
        m = (y2 - y1)/(x2 - x1);
    end


    % Check if it's a quadrilateral or a rectangle
    divBy0 = m == 0;

    % Radius of the robot * 1.5
    d = 0.25*1.5;

 %% Calculate the 4 points for the quadrilateral
 
    % To create the path the robot would move, we look
    % for the 4 points that define the quadrilateral

    if divBy0

        xEqls0 = x1 == x2;
        if xEqls0
            % Orthogonal line at co-ordinate 1
            cornerAx = x1 + d;
            cornerAy =  y1;
            cornerBx = x1 - d;
            cornerBy =  y1;

            % Orthogonal line at co-ordinate 2
            cornerCx = x1 + d;
            cornerCy = y2;
            cornerDx = x1 - d;
            cornerDy = y2;
        else

            % Orthogonal line at co-ordinate 1
            cornerAx = x1;
            cornerAy =  y1 + d;
            cornerBx = x1;
            cornerBy =  y1- d;

            % Orthogonal line at co-ordinate 2
            cornerCx = x2;
            cornerCy = y2 + d;
            cornerDx = x2;
            cornerDy = y2 - d;

        end

    else

        % After doing algebra with simultaneous equations to find x
        % The divisor turns into this 
        divisor = (1+1/(m^2));

        % Orthogonal line at co-ordinate 1
        cornerAx = sqrt(d^2/divisor)+x1;
        cornerAy = -1/m * (cornerAx - x1) + y1;
        cornerBx = -sqrt(d^2/divisor)+x1;
        cornerBy =  -1/m * (cornerBx - x1) + y1;

        % Orthogonal line at co-ordinate 2
        cornerCx = sqrt(d^2/divisor)+x2;
        cornerCy = -1/m * (cornerCx - x2) + y2;
        cornerDx = -sqrt(d^2/divisor)+x2;
        cornerDy =  -1/m * (cornerDx - x2) + y2;
    end

    path = polyshape([cornerAx cornerBx cornerDx cornerCx],[cornerAy cornerBy cornerDy cornerCy]);
    
    %plot(path)
    
    global mazePolyshape;

    wallCollision = sum(overlaps([path mazePolyshape]),'all') == 4;


    if wallCollision
        pathIsViable = false;
    end
   

end