# Autonomous Systems Path/Route Planning

For our autonomous systems assignment, we were given the task of simulating a robot navigating a maze. From the given starting point (blue dot) the robot needs to visit all five randomly generated waypoints (red asterisks) as quickly as possible. Along the way, there are pre-planned obstacles that the robot initially doesn't know exists. Obstacles are instead avoided using the robot's onboard sensor.

My part of the project was to design the pathing system for the robot in reaction to the randomly generated waypoints but without considering the obstacles. Also included is an improved solution that I thought of after the assignment was completed.

For anyone who'd like to learn in depth about my thought processes for this project, you can read the corresponding article at this link https://www.linkedin.com/pulse/finding-opportunities-creative-stem-assignment-jericho-limpin.


## Getting Started

Nothing extra needs to be installed in order to run this code, the uploaded code uses all inbuilt MATLAB functions.


### Compare the Heuristic and Optimized solution for a path (compareHeuristicOptimized.m)

As long as the nodes are viable, you can change the node start name and end name by changing the number. It will display a visualization of the heuristic and optimized path.

### Visualize the Optimization of a path (visualizeOptimization.m)

As long as the nodes are viable, you can change the node start name and end name by changing the number. It will display a visualization of optimization by displaying the paths that are tested.

### Compare the Original and Improved solution for a set of waypoints (compareSolutions.m)

To test the example from the article, comment out the generateWaypoints line and uncomment the testWaypoints line. Otherwise the waypoints are randomly generated.

### Empirical test the average time taken (empiricalTesting.m)

Change the numberOfIterations variable to determine how much closer to the true average you want to find. In the end the multiplciative increase is in the double digits.

## Built With

[MATLAB](https://au.mathworks.com/) - The programming language used


## Authors

* **Jericho Limpin** [Bubble Rain](https://github.com/Bubble-Rain)
