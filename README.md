# Topics in Visualization: Homework 1 Parallel Coordinates Visualization
###### Authors: Ayoub Belemlih, Paul Chery
###### Date: 10 November 2017

## Storyboards and Sketches:

## Visualization Screenshots:
![alt text] (https://github.com/pchery/viz_hw1_parallel_coordinates/blob/master/images/viz1.png)
![alt text] (https://github.com/pchery/viz_hw1_parallel_coordinates/blob/master/images/viz2.png)
![alt text] (https://github.com/pchery/viz_hw1_parallel_coordinates/blob/master/images/viz3.png)
![alt text] (https://github.com/pchery/viz_hw1_parallel_coordinates/blob/master/images/viz1.png)

## Discussion of Design:


## User Manual:

* Rearranging axes:

In order to move an axis, you must first click on the axis of your choice. The axis will become red once highlighted. Then, you are able to drag the axis horizontally to any new location. Once you release the axis, it becomes unhighlighted and you can no longer drag it until you click on it again. You can rearrange the axes in any order and the data will dynamically rearrange itself.

The highlighting of the axis in red when clicked tells the user that the axis is highlighted and it is ready to be moved. Red pops out compared to the other darker hues used in the visualization.

* Filtering along an axis:

To filter what data is displayed along a particular variable axis, you can drag the square widget at the bottom of the axis to filter from the bottom or the square widget at the top of the axis to filter from the top. As you drag the widgets, the data that is above the top widget and the data that is below the bottom widget is displayed in a color with a lower luminance value. 

Changing the luminance of the data when filtered is effective at showing the categorical difference of filtered versus unfiltered because luminance is a highly perceived visual channel. 


* Exiting the visualization:

Press escape to exit the visualization. 

* Future work:

Given more time, we would like to add the ability to highlight a row of the data by clicking on any part of one of the lines. In order to implement this feature, we would need to create a row class and an array to hold all of the rows of the table. This would facilitate the selection and isolation of a specific row. 



