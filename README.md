# landsat-gifworks
A bash tool (script) to generate animated (gif) temporal progressions of land cover with inputs of lat, long, and start/end dates. Requires landsat-util, GNU parallel, and imagemagick. Still under construction!

- this is a work in progress. If you know enough to fiddle with it, it's all there!

![](https://farm8.staticflickr.com/7611/16715437298_feb4759969_o.gif)
Boston, MA from August 2014 through March 2015. If you didn't hear.. this was a [record year for Boston snowfall!](http://www.theatlantic.com/photo/2015/02/winter-storms-bury-freeze-northeastern-us/385566/)


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
