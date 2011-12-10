Client-side usage
=================

Link your `.less` stylesheets with the `rel` set to "`stylesheet/less`":

    <link rel="stylesheet/less" type="text/css" href="styles.less">

Then download `less.js` from the top of the page, and include it in the `<head>` element of your page, like so:

    <script src="less.js" type="text/javascript"></script>

Make sure you include your stylesheets *before* the script.

Server-side usage
=================

Installation
------------

The easiest way to install LESS on the server, is via [npm](http://github.com/isaacs/npm), the node package manager, as so:

    $ npm install less

This will get you the latest stable version. If you want the bleeding edge, try:

    $ npm install less@latest

Use
---

Once installed, you can invoke the compiler from node, as such:

    var less = require('less');
    
    less.render('.class { width: 1 + 1 }', function (e, css) {
        console.log(css);
    });

which will output

    .class {
      width: 2;
    }

you can also manually invoke the parser and compiler:

    var parser = new(less.Parser);

    parser.parse('.class { width: 1 + 1 }', function (err, tree) {
        if (err) { return console.error(err) }
        console.log(tree.toCSS());
    });

Configuration
-------------

You may pass some options to the compiler:

    var parser = new(less.Parser)({
        paths: ['.', './lib'], // Specify search paths for @import directives
        filename: 'style.less' // Specify a filename, for better error messages
    });

    parser.parse('.class { width: 1 + 1 }', function (e, tree) {
        tree.toCSS({ compress: true }); // Minify CSS output
    });

Command-line usage
------------------

Less comes with a binary, which lets you invoke the compiler from the command-line, as such:

    $ lessc styles.less

This will output the compiled CSS to `stdout`, you may then redirect it to a file of your choice:

    $ lessc styles.less > styles.css

To output minified CSS, simply pass the `-x` option. If you would like more involved minification,
the [YUI CSS Compressor](http://developer.yahoo.com/yui/compressor/css.html) is also available with
the `--yui-compress` option.

