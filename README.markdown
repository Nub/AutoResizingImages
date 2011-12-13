# Auto Resizing Images

__Usage:__

  UIImage *autoResizingImage = [UIImage autoResizingImageNamed:@"arrow"];


__Explanation:__

Using key pixels you can define UIEdgeInsets and automaticaly generate a -resizableImageWithCapInsets

__Image Structure:__

Images are decoded to 32bit ARGB buffers for value checking.

To create a resiable image all you need to do is increase the width and height by 1px, and bottom right align the image.
Then we need to mark the image in these new pixel rows, starting withthe key signifier pixel by default is to be at the 
[0,0] location in the image and to be the 32bit ARGB color #FFFF00FF. After that we use the first row of pixels to mark 
the X or width or column component insets, and the first column to mark the Y or height or row component insets.
Component insets are marked by a solid black pixel, the 32 ARGB color #FF000000.

__Examples:__

Demo example output

![](http://thayer-remodeling.com/uploads/demooutput.png)

Visual explanation

![](http://thayer-remodeling.com/uploads/visualexample.png)