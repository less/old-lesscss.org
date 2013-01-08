#Index

	escape(@string);             // URL encodes a string
	e(@string);             // escape string content
	%(@string, values...);             // formats a string
	
	unit(@dimension, [@unit: ""]); // remove or change the unit of a dimension
	color(@string);				   // parses a string to a color
	
	ceil(@number);               // rounds up to an integer
	floor(@number);              // rounds down to an integer
	percentage(@number);         // converts to a %, e.g. 0.5 -> 50%
	round(number, [places: 0]);	 // rounds a number to a number of places

	rgb(@r, @g, @b);                             // converts to a color
	rgba(@r, @g, @b, @a);                        // converts to a color
	argb(@color);                                // creates a #AARRGGBB
	hsl(@hue, @saturation, @lightness);          // creates a color
	hsla(@hue, @saturation, @lightness, @alpha); // creates a color
	hsv(@hue, @saturation, @value);              // creates a color
	hsva(@hue, @saturation, @value, @alpha);     // creates a color
	
    hue(@color);        // returns the `hue` channel of @color
    saturation(@color); // returns the `saturation` channel of @color
    lightness(@color);  // returns the 'lightness' channel of @color
    red(@color);        // returns the 'red' channel of @color
    green(@color);      // returns the 'green' channel of @color
    blue(@color);       // returns the 'blue' channel of @color
    alpha(@color);      // returns the 'alpha' channel of @color
    luma(@color);       // returns the 'luma' value (perceptual brightness) of @color
	
    saturate(@color, 10%);   // return a color 10% points *more* saturated
    desaturate(@color, 10%); // return a color 10% points *less* saturated
    lighten(@color, 10%);    // return a color 10% points *lighter*
    darken(@color, 10%);     // return a color 10% points *darker*
    fadein(@color, 10%);     // return a color 10% points *less* transparent
    fadeout(@color, 10%);    // return a color 10% points *more* transparent
    fade(@color, 50%);       // return @color with 50% transparency
    spin(@color, 10);        // return a color with a 10 degree larger in hue
    mix(@color1, @color2, [@weight: 50%]);  // return a mix of @color1 and @color2
	greyscale(@color);       // returns a grey, 100% desaturated color
    contrast(@color1, [@darkcolor: black], [@lightcolor: white], [@threshold: 43%]); 
	    // return @darkcolor if @color1 is > 43% luma  
		// otherwise return @lightcolor

	multiply(@color1, @color2);
	screen(@color1, @color2);
	overlay(@color1, @color2);
	softlight(@color1, @color2);
	hardlight(@color1, @color2);
	difference(@color1, @color2);
	exclusion(@color1, @color2);
	average(@color1, @color2);
	negation(@color1, @color2);
	
#String functions
###escape

Applies [URL-encoding](http://en.wikipedia.org/wiki/Percent-encoding) to special characters found in the input string. 

* Following characters are exceptions and not encoded: `,`, `/`, `?`, `@`, `&`, `+`, `'`, `~`, `!` and `$`. 
* Most common encoded characters are: `<space>`, `#`, `^`, `(`, `)`, `{`, `}`, `|`, `:`, `>`, `<`, `;`, `]`, `[` and `=`.

Parameters:

* `string`: A string to escape

Returns: escaped `string` content without quotes.

Example:

    escape('a=1')

Output:

    a%3D1
    
Note: Function behavior if a parameter is non-string parameters is not defined. Current implementation returns `undefined` on color and unchanged input on any other kind of argument. This behaviour should not be relied on and can change in the future.

###e
CSS escaping similar to `~"value"` syntax. It expects string as a parameter and return its content as is, but without quotes. It can be used to output CSS value which is either not valid CSS syntax, or uses proprietary syntax which LESS doesn’t recognize.

Parameters:

* `string`: A string to escape

Returns: `string` content without quotes.

Example:

    filter: ~"ms:alwaysHasItsOwnSyntax.For.Stuff()";

Output:

    filter: ms:alwaysHasItsOwnSyntax.For.Stuff();
    
Note: The function accepts also `~""` escaped values and numbers as parameters. Anything else returns an error.

###% format
The function `%("format", arguments ...)` formats a string. The first argument is string with placeholders. All placeholders start with percentage symbol `%` followed by letter `s`,`S`,`d`,`D`,`a`, or `A`. Remaining arguments contain expressions to replace placeholders. If you need to print the percentage symbol, escape it by another percentage `%%`.

Use uppercase placeholders if you need to escape special characters into their utf-8 escape codes. 
The function escapes all special characters except `()'~!`. Space is encoded as `%20`. Lowercase placeholders leave special characters as they are. 

Placeholders:
* d, D, a, A - can be replaced by any kind of argument (color, number, escaped value, expression, ...). If you use them in combination with string, the whole string will be used - including its quotes. However, the quotes are placed into the string as they are, they are not escaped by "/" nor anything similar.
* s, S - can be replaced by any kind of argument except color. If you use them in combination with string, only the string value will be used - string quotes are omitted.

Parameters:

* `string`: format string with placeholders,
* `anything`* : values to replace placeholders.

Returns: formatted `string`.

Example:

    format-a-d: %("repetitions: %a file: %d", 1 + 2, "directory/file.less");
    format-a-d-upper: %('repetitions: %A file: %D', 1 + 2, "directory/file.less");
    format-s: %("repetitions: %s file: %s", 1 + 2, "directory/file.less");
    format-s-upper: %('repetitions: %S file: %S', 1 + 2, "directory/file.less");


Output:

    format-a-d: "repetitions: 3 file: "directory/file.less"";
    format-a-d-upper: "repetitions: 3 file: %22directory%2Ffile.less%22";
    format-s: "repetitions: 3 file: directory/file.less";
    format-s-upper: "repetitions: 3 file: directory%2Ffile.less";
    
#Misc functions
###color
Parses a color, so a string representing a color becomes a color.

Parameters:

* `string`: A string of the color

Example:

    color("#aaa");

Output:

    #aaa

###unit
Remove or change the unit of a dimension

Parameters:

* `dimension`: A number, with or without a dimension
* `unit`: Optional: the unit to change to, or if omitted it will remove the unit

Example:

    unit(5, px)

Output:

    5px
	
Example:

    unit(5em)

Output:

    5

#Math functions
###ceil
Rounds up to the next highest integer.

Parameters:

* `number`: A floating point number.

Returns: `integer`

Example:

    ceil(2.4)

Output:

    3
###floor
Rounds down to the next lowest integer.

Parameters:

* `number`: A floating point number.

Returns: `integer`

Example:

    floor(2.6)

Output:

    2
###percentage
Converts a floating point number into a percentage string.

Parameters:

* `number`: A floating point number.

Returns: `string`

Example:

    percentage(0.5)

Output:

    50%
###round
Applies rounding.

Parameters:

* `number`: A floating point number.
* `decimalPlaces`: Optional: The number of decimal places to round to. Defaults to 0.

Returns: `number`

Example:

    round(1.67)

Output:

    2
	
Example:

    round(1.67, 1)

Output:

    1.7
#Color functions
##Color definition
###rgb
Creates an opaque color object from decimal red, green and blue (RGB) values. Literal color values in standard HTML/CSS formats may also be used to define colors, for example `#ff0000`.

Parameters:

* `red`: An integer 0-255 or percentage 0-100%.
* `green`: An integer 0-255 or percentage 0-100%.
* `blue`: An integer 0-255 or percentage 0-100%.

Returns: `color`

Example:

    rgb(90, 129, 32)

Output:

    #5a8120
###rgba
Creates a transparent color object from decimal red, green, blue and alpha (RGBA) values.

Parameters:

* `red`: An integer 0-255 or percentage 0-100%.
* `green`: An integer 0-255 or percentage 0-100%.
* `blue`: An integer 0-255 or percentage 0-100%.
* `alpha`: An number 0-1 or percentage 0-100%.

Returns: `color`

Example:

    rgba(90, 129, 32, 0.5)

Output:

    rgba(90, 129, 32, 0.5)
###argb
Creates a hex representation of a color in `#AARRGGBB` format (**NOT** `#RRGGBBAA`!).

Parameters:

* `color`: A color object.

Returns: `string`

Example:

    argb(rgba(90, 23, 148, 0.5));

Output:

    #805a1794
###hsl
Creates an opaque color object from hue, saturation and lightness (HSL) values.

Parameters:

* `hue`: An integer 0-360 representing degrees.
* `saturation`: A percentage 0-100% or number 0-1.
* `lightness`: A percentage 0-100% or number 0-1.

Returns: `color`

Example:

    hsl(90, 100%, 50%)

Output:

    #80ff00
	
This is useful if you want to create a new color based on another color's channel, for example:

    @new: hsl(hue(@old), 45%, 90%);

`@new` will have `@old`'s *hue*, and its own saturation and lightness.
	
###hsla
Creates a transparent color object from hue, saturation, lightness and alpha (HSLA) values.

Parameters:

* `hue`: An integer 0-360 representing degrees.
* `saturation`: A percentage 0-100% or number 0-1.
* `lightness`: A percentage 0-100% or number 0-1.
* `alpha`: A percentage 0-100% or number 0-1.

Returns: `color`

Example:

    hsl(90, 100%, 50%, 0.5)

Output:

    rgba(128, 255, 0, 0.5)
###hsv
Creates an opaque color object from hue, saturation and value (HSV) values. Note that this is not the same as `hsl`.

Parameters:

* `hue`: An integer 0-360 representing degrees.
* `saturation`: A percentage 0-100% or number 0-1.
* `value`: A percentage 0-100% or number 0-1.

Returns: `color`

Example:

    hsv(90, 100%, 50%)

Output:

    #408000

###hsva
Creates a transparent color object from hue, saturation, value and alpha (HSVA) values. Note that this is not the same as `hsla`.

Parameters:

* `hue`: An integer 0-360 representing degrees.
* `saturation`: A percentage 0-100% or number 0-1.
* `value`: A percentage 0-100% or number 0-1.
* `alpha`: A percentage 0-100% or number 0-1.

Returns: `color`

Example:

    hsva(90, 100%, 50%, 0.5)

Output:

    rgba(64, 128, 0, 0.5)

##Color channel information
###hue
Extracts the hue channel of a color object.

Parameters:

* `color`: A color object.

Returns: `integer` 0-360

Example:

    hue(hsl(90, 100%, 50%))

Output:

    90
###saturation
Extracts the saturation channel of a color object.

Parameters:

* `color`: A color object.

Returns: `percentage` 0-100

Example:

    saturation(hsl(90, 100%, 50%))

Output:

    100%
###lightness
Extracts the lightness channel of a color object.

Parameters:

* `color`: A color object.

Returns: `percentage` 0-100

Example:

    lightness(hsl(90, 100%, 50%))

Output:

    50%
###red
Extracts the red channel of a color object.

Parameters:

* `color`: A color object.

Returns: `integer` 0-255

Example:

    red(rgb(10, 20, 30))

Output:

    10
###green
Extracts the green channel of a color object.

Parameters:

* `color`: A color object.

Returns: `integer` 0-255

Example:

    green(rgb(10, 20, 30))

Output:

    20
###blue
Extracts the blue channel of a color object.

Parameters:

* `color`: A color object.

Returns: `integer` 0-255

Example:

    blue(rgb(10, 20, 30))

Output:

    30
###alpha
Extracts the alpha channel of a color object.

Parameters:

* `color`: A color object.

Returns: `float` 0-1

Example:

    alpha(rgba(10, 20, 30, 0.5))

Output:

    0.5
###luma
Calculates the [luma](http://en.wikipedia.org/wiki/Luma_(video)) (perceptual brightness) of a color object. Uses SMPTE C / Rec. 709 coefficients, as recommended in [WCAG 2.0](http://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef). This calculation is also used in the contrast function.

Parameters:

* `color`: A color object.

Returns: `percentage` 0-100%

Example:

    luma(rgb(100, 200, 30))

Output:

    65%
##Color operations
Color operations generally take parameters in the same units as the values they are changing, and percentage are handled as absolutes, so increasing a 10% value by 10% results in 20%, not 11%, and values are clamped to their allowed ranges; they do not wrap around. Where return values are shown, we've also shown formats that make it clear what each function has done, in addition to the hex versions that you will usually be be working with.
###saturate
Increase the saturation of a color by an absolute amount.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    saturate(hsl(90, 90%, 50%), 10%)

Output:

    #80ff00 // hsl(90, 100%, 50%)

###desaturate
Decrease the saturation of a color by an absolute amount.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    desaturate(hsl(90, 90%, 50%), 10%)

Output:

    #80e51a // hsl(90, 80%, 50%)
###lighten
Increase the lightness of a color by an absolute amount.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    lighten(hsl(90, 90%, 50%), 10%)

Output:

    #99f53d // hsl(90, 90%, 60%)
###darken
Decrease the lightness of a color by an absolute amount.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    darken(hsl(90, 90%, 50%), 10%)

Output:

    #66c20a // hsl(90, 90%, 40%)
###fadein
Decrease the transparency (or increase the opacity) of a color, making it more opaque. Has no effect on opaque colours. To fade in the other direction use `fadeout`.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    fadein(hsla(90, 90%, 50%, 0.5), 10%)

Output:

    rgba(128, 242, 13, 0.6) // hsla(90, 90%, 50%, 0.6)
###fadeout
Increase the transparency (or decrease the opacity) of a color, making it less opaque. To fade in the other direction use `fadein`.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    fadeout(hsla(90, 90%, 50%, 0.5), 10%)

Output:

    rgba(128, 242, 13, 0.4) // hsla(90, 90%, 50%, 0.6)
###fade
Set the absolute transparency of a color. Can be applied to colors whether they already have an opacity value or not.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    fade(hsl(90, 90%, 50%), 10%)

Output:

    rgba(128, 242, 13, 0.1) //hsla(90, 90%, 50%, 0.1)
###spin
Rotate the hue angle of a color in either direction. While the angle range is 0-360, it applies a mod 360 operation, so you can pass in much larger (or negative) values and they will wrap around e.g. angles of 360 and 720 will produce the same result. Note that colours are passed through an RGB conversion, which doesn't retain hue value for greys (because hue has no meaning when there is no saturation), so make sure you apply functions in a way that preserves hue, for example don't do this:

    @c: saturate(spin(#aaaaaa, 10), 10%);

Do this instead:

    @c: spin(saturate(#aaaaaa, 10%), 10);
	
Colors are always returned as RGB values, so applying `spin` to a grey value will do nothing.

Parameters:

* `color`: A color object.
* `angle`: A number of degrees to rotate (+ or -).

Returns: `color`

Example:

    spin(hsl(10, 90%, 50%), 20)
    spin(hsl(10, 90%, 50%), -20)

Output:

    #f27f0d // hsl(30, 90%, 50%)
    #f20d33 // hsl(350, 90%, 50%)
###mix
Mix two colors together in variable proportion. Opacity is included in the calculations.

Parameters:

* `color1`: A color object.
* `color1`: A color object.
* `weight`: Optional, a percentage balance point between the two colors, defaults to 50%.

Returns: `color`

Example:

    mix(#ff0000, #0000ff, 50%)
    mix(rgba(100,0,0,1.0), rgba(0,100,0,0.5), 50%)

Output:

    #800080
    rgba(75, 25, 0, 0.75)
###greyscale
Remove all saturation from a color; the same as calling `desaturate(@color, 100%)`. Because the saturation is not affected by hue, the resulting color mapping may be somewhat dull or muddy; `luma` may provide a better result as it extracts perceptual rather than linear brightness, for example `greyscale('#0000ff')` will return the same value as `greyscale('#00ff00')`, though they appear quite different in brightness to the human eye.

Parameters:

* `color`: A color object.

Returns: `color`

Example:

    greyscale(hsl(90, 90%, 50%))

Output:

    #808080 // hsl(90, 0%, 50%)
###contrast
Choose which of two colors provides the greatest contrast with another. This is useful for ensuring that a color is readable against a background, which is also useful for accessibility compliance. This function works the same way as the [contrast function in Compass for SASS](http://compass-style.org/reference/compass/utilities/color/contrast/). In accordance with [WCAG 2.0](http://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef), colors are compared using their luma value, not their lightness.

Parameters:

* `color`: A color object to compare against.
* `dark`: optional - A designated dark color (defaults to black).
* `light`: optional - A designated light color (defaults to white).
* `threshold`: optional - A percentage 0-100% specifying where the transition from "dark" to "light" is (defaults to 43%). This is used to bias the contrast one way or another, for example to allow you to decide whether a 50% grey background should result in black or white text. You would generally set this lower for 'lighter' palettes, higher for 'darker' ones. Defaults to 43%.

Returns: `color`

Example:

    contrast(#aaaaaa)
    contrast(#222222, #101010)
    contrast(#222222, #101010, #dddddd)
    contrast(hsl(90, 100%, 50%),#000000,#ffffff,40%);
    contrast(hsl(90, 100%, 50%),#000000,#ffffff,60%);

Output:

    #000000 // black
    #ffffff // white
    #dddddd
    #000000 // black
    #ffffff // white

##Color blending
These operations are _similar_ as the blend modes found in image editors like Photoshop, Firework or GIMP, so you can use them to make your CSS colors match your images.

###multiply
Multiply two colors. For each two colors their RGB channel are multiplied then divided by 255. The result is a darker color.

Parameters:

* `color1`: A color object to multiply against.
* `color2`: A color object to multiply against.

Returns: `color`

Examples:

    multiply(#ff6600, #000000);
    
![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/000000/ffffff&text=000000)
![Color 3](http://placehold.it/100x40/000000/ffffff&text=000000)
    
    multiply(#ff6600, #333333);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/333333/ffffff&text=333333)
![Color 3](http://placehold.it/100x40/331400/ffffff&text=331400)

    multiply(#ff6600, #666666);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/666666/ffffff&text=666666)
![Color 3](http://placehold.it/100x40/662900/ffffff&text=662900)

    multiply(#ff6600, #999999);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/993d00/ffffff&text=993d00)

    multiply(#ff6600, #cccccc);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/cccccc/000000&text=cccccc)
![Color 3](http://placehold.it/100x40/cc5200/ffffff&text=cc5200)

    multiply(#ff6600, #ffffff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ffffff/000000&text=ffffff)
![Color 3](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)

    multiply(#ff6600, #ff0000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)
![Color 3](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)

    multiply(#ff6600, #00ff00);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/00ff00/ffffff&text=00ff00)
![Color 3](http://placehold.it/100x40/006600/ffffff&text=006600)

    multiply(#ff6600, #0000ff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/0000ff/ffffff&text=0000ff)
![Color 3](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)

###screen
Do the opposite effect from `multiply`. The result is a brighter color.

Parameters:

* `color1`: A color object to _screen_ against.
* `color2`: A color object to _screen_ against.

Returns: `color`

Example:

    screen(#ff6600, #000000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/000000/ffffff&text=000000)
![Color 3](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)

    screen(#ff6600, #333333);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/333333/ffffff&text=333333)
![Color 3](http://placehold.it/100x40/ff8533/ffffff&text=ff8533)

    screen(#ff6600, #666666);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/666666/ffffff&text=666666)
![Color 3](http://placehold.it/100x40/ffa366/ffffff&text=ffa366)

    screen(#ff6600, #999999);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/ffc299/000000&text=ffc299)

    screen(#ff6600, #cccccc);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/cccccc/000000&text=cccccc)
![Color 3](http://placehold.it/100x40/ffe0cc/000000&text=ffe0cc)

    screen(#ff6600, #ffffff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ffffff/000000&text=ffffff)
![Color 3](http://placehold.it/100x40/ffffff/000000&text=ffffff)

    screen(#ff6600, #ff0000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)
![Color 3](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)

    screen(#ff6600, #00ff00);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/ffff00/ffffff&text=ffff00)

    screen(#ff6600, #0000ff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/ff66ff/000000&text=ff66ff)

###overlay
Combines the effect from both `multiply` and `screen`. Conditionally make light channels lighter and dark channels darker. **Note**: The results of the conditions are determined by the first color parameter.

Parameters:

* `color1`: A color object to overlay another. Also it is the determinant color to make the result lighter or darker.
* `color2`: A color object to be _overlayed_.

Returns: `color`

Example:

    overlay(#ff6600, #000000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/000000/ffffff&text=000000)
![Color 3](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)

    overlay(#ff6600, #333333);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/333333/ffffff&text=333333)
![Color 3](http://placehold.it/100x40/ff2900/ffffff&text=ff2900)

    overlay(#ff6600, #666666);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/666666/ffffff&text=666666)
![Color 3](http://placehold.it/100x40/ff5200/ffffff&text=ff5200)

    overlay(#ff6600, #999999);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/ff7a00/ffffff&text=ff7a00)

    overlay(#ff6600, #cccccc);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/cccccc/000000&text=cccccc)
![Color 3](http://placehold.it/100x40/ffa300/ffffff&text=ffa300)

    overlay(#ff6600, #ffffff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ffffff/000000&text=ffffff)
![Color 3](http://placehold.it/100x40/ffcc00/ffffff&text=ffcc00)

    overlay(#ff6600, #ff0000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)
![Color 3](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)

    overlay(#ff6600, #00ff00);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/00ff00/ffffff&text=00ff00)
![Color 3](http://placehold.it/100x40/ffcc00/ffffff&text=ffcc00)

    overlay(#ff6600, #0000ff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/0000ff/ffffff&text=0000ff)
![Color 3](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)

###softlight
Similar to `overlay` but avoid pure black resulting in pure black, and pure white resulting in pure white.

Parameters:

* `color1`: A color object to _soft light_ another.
* `color2`: A color object to be _soft lighten_.

Returns: `color`

Example:

    softlight(#ff6600, #000000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/000000/ffffff&text=000000)
![Color 3](http://placehold.it/100x40/ff2900/ffffff&text=ff2900)

    softlight(#ff6600, #333333);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/333333/ffffff&text=333333)
![Color 3](http://placehold.it/100x40/ff4100/ffffff&text=ff4100)

    softlight(#ff6600, #666666);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/666666/ffffff&text=666666)
![Color 3](http://placehold.it/100x40/ff5a00/ffffff&text=ff5a00)

    softlight(#ff6600, #999999);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/ff7200/ffffff&text=ff7200)

    softlight(#ff6600, #cccccc);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/cccccc/000000&text=cccccc)
![Color 3](http://placehold.it/100x40/ff8b00/ffffff&text=ff8b00)

    softlight(#ff6600, #ffffff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ffffff/000000&text=ffffff)
![Color 3](http://placehold.it/100x40/ffa300/ffffff&text=ffa300)

    softlight(#ff6600, #ff0000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)
![Color 3](http://placehold.it/100x40/ff2900/ffffff&text=ff2900)

    softlight(#ff6600, #00ff00);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/00ff00/ffffff&text=00ff00)
![Color 3](http://placehold.it/100x40/ffa300/ffffff&text=ffa300)

    softlight(#ff6600, #0000ff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/0000ff/ffffff&text=0000ff)
![Color 3](http://placehold.it/100x40/ff2900/ffffff&text=ff2900)

###hardlight
Similar to `overlay` but use the second color to detect light and dark channels instead of using the first color.

Parameters:

* `color1`: A color object to overlay another.
* `color2`: A color object to be _overlayed_. Also it is the determinant color to make the result lighter or darker.

Returns: `color`

Example:

    hardlight(#ff6600, #000000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/000000/ffffff&text=000000)
![Color 3](http://placehold.it/100x40/000000/ffffff&text=000000)

    hardlight(#ff6600, #333333);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/333333/ffffff&text=333333)
![Color 3](http://placehold.it/100x40/662900/ffffff&text=662900)

    hardlight(#ff6600, #666666);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/666666/ffffff&text=666666)
![Color 3](http://placehold.it/100x40/cc5200/ffffff&text=cc5200)

    hardlight(#ff6600, #999999);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/ff8533/ffffff&text=ff8533)

    hardlight(#ff6600, #cccccc);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/cccccc/000000&text=cccccc)
![Color 3](http://placehold.it/100x40/ff2900/ffffff&text=ff2900)

    hardlight(#ff6600, #ffffff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ffffff/000000&text=ffffff)
![Color 3](http://placehold.it/100x40/ffffff/000000&text=ffffff)

    hardlight(#ff6600, #ff0000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)
![Color 3](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)

    hardlight(#ff6600, #00ff00);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/00ff00/ffffff&text=00ff00)
![Color 3](http://placehold.it/100x40/00ff00/ffffff&text=00ff00)

    hardlight(#ff6600, #0000ff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/0000ff/ffffff&text=0000ff)
![Color 3](http://placehold.it/100x40/0000ff/ffffff&text=0000ff)

###difference
Substracts the second color from the first color. The operation is made per RGB channels. The result is a darker color.

Parameters:

* `color1`: A color object to act as the minuend.
* `color2`: A color object to act as the subtrahend.

Returns: `color`

Example:

    difference(#ff6600, #000000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/000000/ffffff&text=000000)
![Color 3](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)

    difference(#ff6600, #333333);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/333333/ffffff&text=333333)
![Color 3](http://placehold.it/100x40/cc3333/ffffff&text=cc3333)

    difference(#ff6600, #666666);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/666666/ffffff&text=666666)
![Color 3](http://placehold.it/100x40/990066/ffffff&text=990066)

    difference(#ff6600, #999999);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/663399/ffffff&text=663399)

    difference(#ff6600, #cccccc);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/cccccc/000000&text=cccccc)
![Color 3](http://placehold.it/100x40/3366cc/ffffff&text=3366cc)

    difference(#ff6600, #ffffff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ffffff/000000&text=ffffff)
![Color 3](http://placehold.it/100x40/0099ff/ffffff&text=0099ff)

    difference(#ff6600, #ff0000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)
![Color 3](http://placehold.it/100x40/006600/ffffff&text=006600)

    difference(#ff6600, #00ff00);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/00ff00/ffffff&text=00ff00)
![Color 3](http://placehold.it/100x40/ff9900/ffffff&text=ff9900)

    difference(#ff6600, #0000ff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/0000ff/ffffff&text=0000ff)
![Color 3](http://placehold.it/100x40/ff66ff/000000&text=ff66ff)

###exclusion
Similar effect to `difference` with lower contrast.

Parameters:

* `color1`: A color object to act as the minuend.
* `color2`: A color object to act as the subtrahend.

Returns: `color`

Example:

    exclusion(#ff6600, #000000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/000000/ffffff&text=000000)
![Color 3](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)

    exclusion(#ff6600, #333333);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/333333/ffffff&text=333333)
![Color 3](http://placehold.it/100x40/cc7033/ffffff&text=cc7033)

    exclusion(#ff6600, #666666);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/666666/ffffff&text=666666)
![Color 3](http://placehold.it/100x40/997a66/ffffff&text=997a66)

    exclusion(#ff6600, #999999);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/668599/ffffff&text=668599)

    exclusion(#ff6600, #cccccc);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/cccccc/000000&text=cccccc)
![Color 3](http://placehold.it/100x40/338fcc/ffffff&text=338fcc)

    exclusion(#ff6600, #ffffff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ffffff/000000&text=ffffff)
![Color 3](http://placehold.it/100x40/0099ff/ffffff&text=0099ff)

    exclusion(#ff6600, #ff0000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)
![Color 3](http://placehold.it/100x40/006600/ffffff&text=006600)

    exclusion(#ff6600, #00ff00);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/00ff00/ffffff&text=00ff00)
![Color 3](http://placehold.it/100x40/ff9900/ffffff&text=ff9900)

    exclusion(#ff6600, #0000ff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/0000ff/ffffff&text=0000ff)
![Color 3](http://placehold.it/100x40/ff66ff/000000&text=ff66ff)

###average
Compute the average of two colors. The operation is made per RGB channels.

Parameters:

* `color1`: A color object.
* `color2`: A color object.

Returns: `color`

Example:

    average(#ff6600, #000000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/000000/ffffff&text=000000)
![Color 3](http://placehold.it/100x40/803300/ffffff&text=803300)

    average(#ff6600, #333333);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/333333/ffffff&text=333333)
![Color 3](http://placehold.it/100x40/994d1a/ffffff&text=994d1a)

    average(#ff6600, #666666);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/666666/ffffff&text=666666)
![Color 3](http://placehold.it/100x40/b36633/ffffff&text=b36633)

    average(#ff6600, #999999);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/cc804d/ffffff&text=cc804d)

    average(#ff6600, #cccccc);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/cccccc/000000&text=cccccc)
![Color 3](http://placehold.it/100x40/e69966/ffffff&text=e69966)

    average(#ff6600, #ffffff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ffffff/000000&text=ffffff)
![Color 3](http://placehold.it/100x40/ffb380/000000&text=ffb380)

    average(#ff6600, #ff0000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)
![Color 3](http://placehold.it/100x40/ff3300/ffffff&text=ff3300)

    average(#ff6600, #00ff00);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/00ff00/ffffff&text=00ff00)
![Color 3](http://placehold.it/100x40/80b300/ffffff&text=80b300)

    average(#ff6600, #0000ff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/0000ff/ffffff&text=0000ff)
![Color 3](http://placehold.it/100x40/803380/ffffff&text=803380)

###negation
Do the opposite effect from `difference`. The result is a brighter color. **Note**: The _opposite_ effect doesn't mean the _inverted_ effect as resulting to an _addition_ operation.

Parameters:

* `color1`: A color object to act as the minuend.
* `color2`: A color object to act as the subtrahend.

Returns: `color`

Example:

    negation(#ff6600, #000000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/000000/ffffff&text=000000)
![Color 3](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)

    negation(#ff6600, #333333);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/333333/ffffff&text=333333)
![Color 3](http://placehold.it/100x40/cc9933/ffffff&text=cc9933)

    negation(#ff6600, #666666);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/666666/ffffff&text=666666)
![Color 3](http://placehold.it/100x40/99cc66/ffffff&text=99cc66)

    negation(#ff6600, #999999);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/999999/ffffff&text=999999)
![Color 3](http://placehold.it/100x40/66ff99/ffffff&text=66ff99)

    negation(#ff6600, #cccccc);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/cccccc/000000&text=cccccc)
![Color 3](http://placehold.it/100x40/33cccc/ffffff&text=33cccc)

    negation(#ff6600, #ffffff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ffffff/000000&text=ffffff)
![Color 3](http://placehold.it/100x40/0099ff/ffffff&text=0099ff)

    negation(#ff6600, #ff0000);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/ff0000/ffffff&text=ff0000)
![Color 3](http://placehold.it/100x40/006600/ffffff&text=006600)

    negation(#ff6600, #00ff00);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/00ff00/ffffff&text=00ff00)
![Color 3](http://placehold.it/100x40/ff9900/ffffff&text=ff9900)

    negation(#ff6600, #0000ff);

![Color 1](http://placehold.it/100x40/ff6600/ffffff&text=ff6600)
![Color 2](http://placehold.it/100x40/0000ff/ffffff&text=0000ff)
![Color 3](http://placehold.it/100x40/ff66ff/ffffff&text=ff66ff)
