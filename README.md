# landsat-gifworks
A bash tool (script) to generate animated (gif) temporal progressions of land cover with inputs of lat, long, and start/end dates (for now change dates in the code). Requires landsat-util, GNU parallel, and imagemagick. Still under construction!

- this is a work in progress. If you know enough to fiddle with it, it's all there!

![](https://farm8.staticflickr.com/7611/16715437298_feb4759969_o.gif)
Boston, MA from August 2014 through March 2015. If you didn't hear.. this was a [record year for Boston snowfall!](http://www.theatlantic.com/photo/2015/02/winter-storms-bury-freeze-northeastern-us/385566/)

to get this gif I used:


    (venv)alex@alex-laptop:~/Documents/for_fun$ bash land-gif.sh 42 -71
    
- I included a date range of **-s "august 30 2014" -e "march 23 201**, but since the script is still under construction.. I ended up removing the first TIF (as it was too dark) from the displayed product.
- Any time you want to remove an image from the final product, identify which TIF(s) you don't want, delete them from the working folder, and run the final convert command again. Make sure to replace the filename in that final command so that it reflects the path/row 3+3=6digit ID (in this example case it was 011031).


Dependencies
-
- [landsat-util](https://github.com/developmentseed/landsat-util) by [developmentseed](https://developmentseed.org/)
- imagemagick
- GNU parallel


To Do List:
-
- make less bootleg
- fix gdal_translate line so that script crops based on designated subset size (allowing for zoomed in, more place specific gifs)
- allow for user designated dates, input of rescale factor (from original landsat-util processed output size)
- remove all working files after its done (these add up quick, keep that in mind)
- comments
- fix the final imagemagick convert command so that manual entry of the path/row ID numbers do not need to be entered every time.
