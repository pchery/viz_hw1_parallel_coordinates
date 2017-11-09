# Topics in Visualization: Homework 1 Parallel Coordinates Visualization
###### Authors: Ayoub Belemlih, Paul Chery
###### Date: 10 November 2017

## Storyboards and Sketches:

## Visualization Screenshots:
Screenshot of the visualization when first opened:
![alt text](https://github.com/pchery/viz_hw1_parallel_coordinates/blob/master/images/viz1.png)

View of axis after being clicked and highlighted, ready to be moved around the screen:
![alt text](https://github.com/pchery/viz_hw1_parallel_coordinates/blob/master/images/viz3.png)

View of highlighted axis after being dragged to a new location:
![alt text](https://github.com/pchery/viz_hw1_parallel_coordinates/blob/master/images/viz2.png)

View of filtered data: 
![alt text](https://github.com/pchery/viz_hw1_parallel_coordinates/blob/master/images/viz4.png)

## Discussion of Design:

The axes only dislay the range of each variable as opposed to a typical graph where the range goes from 0 to above the maximum value. We made this decision so that the points along the axis would be more spread out and we could distinguish more easily between separate lines.  

We decided to allow the user to move the axes to any horizontal location on the screen instead of having them snap in place in defined locations, which is what we originally intended to do. This allows the user more flexibility in choosing what axes they want to look at. Instead of snapping into place, if you drag an axis close to another axis the nonhighlighted axis will move to leave room for the highlighted axis to settle. 

Due to time constraints and our class decomposition, we were unable to implement the highlighting of a specific row. In order to implement this we would need to add a row class. 

## User Manual:

* Rearranging axes:

In order to move an axis, you must first click on the axis of your choice. The axis will become red once highlighted. Then, you are able to drag the axis horizontally to any new location. Once you release the axis, it becomes unhighlighted and you can no longer drag it until you click on it again. You can rearrange the axes in any order and the data will dynamically rearrange itself.

The highlighting of the axis in red when clicked tells the user that the axis is highlighted and it is ready to be moved. Red pops out compared to the other darker hues used in the visualization.

* Filtering along an axis:

To filter what data is displayed along a particular variable axis, you can drag the square widget at the bottom of the axis to filter from the bottom or the square widget at the top of the axis to filter from the top. As you drag the widgets, the data that is above the top widget and the data that is below the bottom widget is displayed in a color with a lower luminance value. 

Changing the luminance of the data when filtered is effective at showing the categorical difference of filtered versus unfiltered because luminance is a highly perceived visual channel. The movement of the squares along the axis is intuitive because we are able to perceive difference in position along an axis very well.

* Exiting the visualization:

Press escape to exit the visualization. 

* Future work:

Given more time, we would like to add the ability to highlight a row of the data, changing the hue of the highlighted line so it pops out and displaying the name of the row by clicking on any part of one of the lines. In order to implement this feature, we would need to create a row class and an array to hold all of the rows of the table. This would facilitate the selection and isolation of a specific row. We would also improve the way the titles are show so they don't overlap. Finally, we could implement a button or key shortcut to reset the visualization to its original configuration. 



