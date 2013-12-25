1.5.0
-----

Under the hood less changed quite a bit (e.g. nodes no longer have a toCSS function), but we haven't made any breaking changes to the language. These are highlights, so please see the <a href="https://github.com/less/less.js/blob/master/CHANGELOG.md">changelog</a> for a full list of changes.

In usage, we do no longer support the yui-compress option due to a bug in ycssmin which was not getting fixed. We have switched to clean-css. If you use this option it will use clean-css and output a warning. The new option is called --clean-css.

We now have sourcemap support, meaning you can compile your less and then use developer tools to see where in your less file a particular piece of CSS comes from. You can enable this with the --source-map=filename option. There are other options, help is available if you run lessc without arguments. For instance, if you use the --source-map-less-inline --source-map-map-inline options then your sourcemap and all less files will be embedded into your generated CSS file.

You can now import your CSS files into the output by doing

    @import (inline) "file.css";

This will not make selectors available to your less, it will just blindly copy that file into the output. It will not be compressed unless you use the clean-css option.

We have another import option - reference. This means that any variables or mixins or selectors will be imported, but never output.

e.g. if you have

    .a {
      color: green;
    }

in a file and import it

    @import (reference) "file.less";

then that file will not be output, but you could do

    .b {
      .a;
    }

and color: green; would be output inside the .b selector only. This also works with extends, so you can use extends to bring complex selector groups from a less or CSS file into your main file. One use-case might be to grab a set of selectors from bootstrap without including the whole library.

We now have property merging, meaning you can do this

    .a() {
      transform+: rotateX(30deg);
    }
    .b {
      transform+: rotateY(20deg);
      .a();
    }

and you will get

    .b {
      transform: rotateY(20deg), rotateX(30deg);
    }

Note: although convention is to space separate we believe all browsers support comma separated for transform and other properties where this is useful are comma separated, so the feature always comma separates joined values.

And lastly... you can now put guards on CSS selectors. so instead of doing this

    .a() when (@ie8 = true) {
       color: black;
    }
    .a {
       .a;
    }

you can do this

    .a when (@ie8 = true) {
        color: black;
    }

which does the same thing. Note: this doesn't work with multiple selectors because of ambiguities between the guard syntax and CSS.

You may also use & on its own to enclose multiple selectors e.g. instead of

    .ie8() when (@ie8 = true) {
       .b {
         color: white;
       }
       // ... etc
    }
    .ie8();

you can write.

    & when (@ie8 = true) {
       .b {
         color: white;
       }
       // ... etc
    }

1.4.0
-----

We have released 1.4.0. This includes new features such as extends, the data-uri function and more maths functions. See the [changelog](https://github.com/cloudhead/less.js/blob/master/CHANGELOG.md) for a full list of changes.

There are some known <span class="warning">breaking changes</span>.

`@import-once` is removed and is now default behavior for `@import`.

`(~".myclass_@{index}") { ...` selector interpolation is deprecated, do this instead `.myclass_@{index} { ...`. This works in 1.3.1 onwards.

The browser version no longer bundles a version of es5-shim.js - the version we previously used was inaccurate and the new version is significantly larger. Please include your choice of es-5 shim or only use on modern browsers.

We have introduced a optional strictMath mode, where math is required to be in parenthesis, e.g.

    (1 + 1)  // 2
    1 + 1    // 1+1

In 1.4.0 this option is turned off, but we intend to turn this on by default. We recommend you upgrade code and switch on the option (--strict-math=on in the command line or strictMath: true in JavaScript). Code written with brackets is backwards compatible with older versions of the less compiler.

We also added a strict units option (strictUnits: true or strict-units=on) and this causes lessc to validate the units used are valid (e.g. 4px/2px = 2, not 2px and 4em/2px throws an error). There are no longer any plans to switch this option on permanently, but some users will find it useful for bug finding.

Unit maths is done, so `(4px * 3em) / 4px` used to equal `3px` and it now equals `3em`. However we do not cancel units down to unitless numbers unless strict units is on.
The selector interpolation, maths and units changes can be made to your less now and will compile fine with less 1.3.3.
