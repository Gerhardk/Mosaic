
You can download this image dataset that should work pretty well: http://www.vision.caltech.edu/Image_Datasets/Caltech101/

Program should take a large image, and a folder with tile images as input params
 
1.       Calculate avg RGB for each tile image (Avg R, Avg G, Avg B) - Done

2.       Divide our input image in 20x20 parts. (You can change this however you like) - Done

3.       Calculate the avg RGB for each of the 400 parts in our input image. - Done
 
4.       Calculate the distance between every tile (AVG RGB) and every part of our image (AVG RGB):
 

We don't want to use euclidian distance to calculate our distances between colours since this does not take human colour perception into account
Instead let's use "Delta E* CIE" and then use these transformations to go from RGB-> CIE-L*ab to do the calculation.
 http://www.easyrgb.com/en/math.php

5.       Choose the tiles with the smallest distance, resize them and replace that image part with the tile
6.       Save output image