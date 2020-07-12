numberOfIterations = 50;

timeTakenOriginal = 0;
for i = 1:numberOfIterations
   
    tic
    branchBound(testWaypoints);
    timeTakenOriginal = timeTakenOriginal + toc;
    
end

timeTakenImproved = 0;
for i = 1:numberOfIterations
   
    tic
    branchBoundImproved(testWaypoints);
    timeTakenImproved = timeTakenImproved + toc;
    
end

averageTimeOriginal = timeTakenOriginal/numberOfIterations;
averageTimeImproved = timeTakenImproved/numberOfIterations;

multiplicativeIncrease = averageTimeOriginal/averageTimeImproved;
disp(['Improved solution is on average x' num2str(multiplicativeIncrease) ' faster']);

