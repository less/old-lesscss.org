LESS Function Reference
=======================

#String functions
###escape
Applies [URL-encoding](http://en.wikipedia.org/wiki/Percent-encoding) to `=`, `:`, `#`, `;`, `(` and `)` characters.

Parameters:

* `string`: A string to escape

Returns: `string`

Example:

    escape('a=1')

Output:

    'a%3D1'
#Math functions
###round
Applies rounding.

Parameters:

* `number`: A floating point number.

Returns: `integer`

Example:

    round(1.67)

Output:

    2
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
#Color functions
##Color definition
###rgb
Creates an opaque color object from red, green and blue (RGB) values. Literal color values in standard HTML/CSS formats may also be used to define colors, for example '#ff0000'.

Parameters:

* `red`: An integer 0-255.
* `green`: An integer 0-255.
* `blue`: An integer 0-255.

Returns: `color`

Example:

    rgb(0.5, 0.5, 0.5)

Output:

###rgba
Creates a transparent color object from red, green, blue and alpha (RGBA) values.

Parameters:

* `red`: An integer 0-255.
* `green`: An integer 0-255.
* `blue`: An integer 0-255.
* `alpha`: An integer 0-255.

Returns: `color`

Example:

    rgb(0.5, 0.5, 0.5, 0.5)

Output:

###hsl
Creates an opaque color object from hue, saturation and lightness (HSL) values.

Parameters:

* `hue`: An integer 0-360 representing degrees.
* `saturation`: A percentage 0-100%.
* `lightness`: A percentage 0-100%.

Returns: `color`

Example:

    hsl(90, 100%, 50%)

Output:

###hsla
Creates a transparent color object from hue, saturation, lightness and alpha (HSLA) values.

Parameters:

* `hue`: An integer 0-360 representing degrees.
* `saturation`: A percentage 0-100%.
* `lightness`: A percentage 0-100%.
* `alpha`: A floating point number 0-1.

Returns: `color`

Example:

    hsl(90, 100%, 50%, 0.5)

Output:

###hsv
Creates an opaque color object from hue, saturation and value (HSV) values.

Parameters:

* `hue`: An integer 0-360 representing degrees.
* `saturation`: A percentage 0-100%.
* `value`: A percentage 0-100%.

Returns: `color`

Example:

    hsl(90, 100%, 50%)

Output:

###hsva
Creates a transparent color object from hue, saturation, value and alpha (HSVA) values.

Parameters:

* `hue`: An integer 0-360 representing degrees.
* `saturation`: A percentage 0-100%.
* `value`: A percentage 0-100%.
* `alpha`: A floating point number 0-1.

Returns: `color`

Example:

    hsla(90, 100%, 50%, 0.5)

Output:

##Color channel information
###hue
Extracts the hue channel of a color object.

Parameters:

* `color`: A color object.

Returns: `integer` 0-360

Example:

    hue(hsla(90, 100%, 50%))

Output:

    90
###saturation
Extracts the saturation channel of a color object.

Parameters:

* `color`: A color object.

Returns: `percentage` 0-100

Example:

    saturation(hsla(90, 100%, 50%))

Output:

    100%
###lightness
Extracts the lightness channel of a color object.

Parameters:

* `color`: A color object.

Returns: `percentage` 0-100

Example:

    lightness(hsla(90, 100%, 50%))

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
Calculates the [luma](http://en.wikipedia.org/wiki/Luma_(video)) (perceptual brightness) of a color object. Uses SMPTE C / Rec. 709 coefficients, as recommended in [WCAG 2.0](http://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef).

Parameters:

* `color`: A color object.

Returns: `percentage` 0-100%

Example:

    luma(rgb(10, 20, 30))

Output:

    90%
##Color operations
Color operations generally take parameters in the same units as the values they are changing, and percentage are handles as absolutes, so increasing a 10% value by 10% results in 20%, not 11%, and values are clamped to their allowed ranges, they do not wrap around. Where return values are shown, we've used formats that make it clear what each function has done, rather than their RGB(A) hex equivalents that you will actually be working with.
###saturate
Increase the saturation of a color.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    saturate(hsl(90, 90%, 50%), 10%)

Output:

    hsl(90, 100%, 50%)
###desaturate
Decrease the saturation of a color.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    desaturate(hsl(90, 90%, 50%), 10%)

Output:

    hsl(90, 80%, 50%)
###lighten
Increase the lightness of a color.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    lighten(hsl(90, 90%, 50%), 10%)

Output:

    hsl(90, 90%, 60%)
###darken
Decrease the lightness of a color.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    darken(hsl(90, 90%, 50%), 10%)

Output:

    hsl(90, 90%, 40%)
###fadein
Decrease the transparency of a color, making it more opaque. Has no effect on opaque colours.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    fadein(hsla(90, 90%, 50%, 0.5), 10%)

Output:

    hsla(90, 90%, 50%, 0.4)
###fadeout
Increase the transparency of a color, making it less opaque.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    fadeout(hsla(90, 90%, 50%, 0.5), 10%)

Output:

    hsla(90, 90%, 50%, 0.6)
###fade
Set the transparency of a color explicitly.

Parameters:

* `color`: A color object.
* `amount`: A percentage 0-100%.

Returns: `color`

Example:

    fadeout(hsl(90, 90%, 50%), 10%)

Output:

    hsla(90, 90%, 50%, 0.1)
###spin
Rotate the hue angle of a color in either direction. Note that colours are often passed through an RGB conversion, which doesn't retain hue value for greys (because hue has no meaning when there is no saturation), so make sure you apply functions in a way that preserves hue, for example don't do this:

    @c: saturate(spin('#aaaaaa', 10), 10%);

Do this instead:

    @c: spin(saturate('#aaaaaa', 10%), 10);

Parameters:

* `color`: A color object.
* `angle`: A number of degrees to rotate (+ or -).

Returns: `color`

Example:

    spin(hsl(10, 90%, 50%), 20)
    spin(hsl(10, 90%, 50%), -20)

Output:

    hsl(30, 90%, 50%)
    hsl(350, 90%, 50%)
###mix
###greyscale
Remove all saturation from a color; the same as calling `desaturate(@color, 100%)`. Because the saturation is not affected by hue, the resulting color mapping may be somewhat dull or muddy; `luma` may provide a better result as it extracts perceptual rather than linear brightness, for example `greyscale('#0000ff')` will return the same value as `greyscale('#00ff00')`, when they appear quite different in brightness to the human eye.

Parameters:

* `color`: A color object.

Returns: `color`

Example:

    greyscale(hsl(90, 90%, 50%))

Output:

    hsl(90, 0%, 50%)
###contrast
Choose which of two colors provides the greatest contrast with another. This is useful for ensuring that a color is readable against a background, which is also useful for accessibility compliance. This function works the same way as the [contrast function in Compass for SASS](http://compass-style.org/reference/compass/utilities/color/contrast/). In accordance with WCAG 2.0, colors are compared using their luma value, not their lightness.

Parameters:

* `color`: A color object to compare against.
* `dark`: A designated dark color (defaults to black).
* `light`: A designated light color (defaults to white).
* `threshold`: A percentage 0-100% specifying where the transition from "dark" to "light" is (defaults to 43%). This is used to bias the contrast one way or another, for example to allow you to decide whether a 50% grey background should result in black or white text. You would generally set this lower for 'lighter' palettes, higher for 'darker' ones.

Returns: `color`

Example:

    contrast('#aaaaaa')
    contrast('#222222', '#101010')
    contrast('#222222', '#101010', '#dddddd')
    contrast(hsl(90, 100%, 50%), , , 40%)
    contrast(hsl(90, 100%, 50%), , , 60%)

Output:

    'black'
    'white'
    '#dddddd'
    'black'
    'white'
##Color blending
###multiply
###screen
###overlay
###softlight
###hardlight
###difference
###exclusion
###average
###negation