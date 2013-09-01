Client-side usage
=================

Client-side is the easiest way to get started and good for developing your LESS. For production and especially
if performance is important, we recommend pre-compiling using node or one of the many third party tools.

Link your `.less` stylesheets with the `rel` set to "`stylesheet/less`":

    <link rel="stylesheet/less" type="text/css" href="styles.less" />

Then download `less.js` from the top of the page, and include it in the `<head>` element of your page, like so:

    <script src="less.js"></script>

Make sure you include your stylesheets *before* the script.

You can set options by setting things on a global LESS object before the script. E.g.

    <script>
        less = {
            env: "development",     // or "production"
            async: false,           // load imports async
            fileAsync: false,       // load imports async when in a page under
                                    // a file protocol
            poll: 1000,             // when in watch mode, time in ms between polls
            functions: {},          // user functions, keyed by name
            dumpLineNumbers: "comments", // or "mediaQuery" or "all"
            relativeUrls: false,    // whether to adjust url's to be relative
                                    // if false, url's are already relative to the
                                    // entry less file
            rootpath: ":/a.com/"    // a path to add on to the start of every url
                                    // resource
        };
    </script>
    <script src="less.js"></script>

Watch mode
----------

*Watch mode* is a client-side feature which enables your styles to refresh automatically as they are changed.

To enable it, append '`#!watch`' to the browser URL, then refresh the page. Alternatively, you can
run `less.watch()` from the console.

Modify variables
----------------

*modifyVars* enables modification of LESS variables in run-time. When called with new values, the LESS file
is recompiled without reloading. Simple basic usage:

    less.modifyVars({
        '@buttonFace': '#5B83AD',
        '@buttonText': '#D9EEF2'
    });

Debugging
---------

It is possible to output rules in your CSS which allow tools to locate the source of the rule.

Either specify the option `dumpLineNumbers` as above or add `!dumpLineNumbers:mediaQuery` to the url.

You can use the "comments" option with [FireLESS](https://addons.mozilla.org/en-us/firefox/addon/fireless/) and
the "mediaQuery" option with FireBug/Chrome dev tools (it is identical to the SCSS media query debugging format).

Server-side usage
=================

Installation
------------

The easiest way to install LESS on the server, is via [npm](http://github.com/isaacs/npm), the node package manager, as so:

    $ npm install -g less

Command-line usage
------------------

Once installed, you can invoke the compiler from the command-line, as such:

    $ lessc styles.less

This will output the compiled CSS to `stdout`, you may then redirect it to a file of your choice:

    $ lessc styles.less > styles.css

To output minified CSS, simply pass the `-x` option. If you would like more involved minification,
the [YUI CSS Compressor](http://developer.yahoo.com/yui/compressor/css.html) is also available with
the `--yui-compress` option.

To see all the command line options run lessc without parameters.

Usage in Code
-------------

You can invoke the compiler from node, as such:

    var less = require('less');

    less.render('.class { width: (1 + 1) }', function (e, css) {
        console.log(css);
    });

which will output

    .class {
      width: 2;
    }

you may also manually invoke the parser and compiler:

    var parser = new(less.Parser);

    parser.parse('.class { width: (1 + 1) }', function (err, tree) {
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

    parser.parse('.class { width: (1 + 1) }', function (e, tree) {
        tree.toCSS({ compress: true }); // Minify CSS output
    });

Third Party Tools
-----------------

There are a selection of tools available to run in your particular environment and these are documented in the Github wiki.

<a href="https://github.com/cloudhead/less.js/wiki/Command-Line-use-of-LESS">Command Line Tools</a>

<a href="https://github.com/cloudhead/less.js/wiki/GUI-compilers-that-use-LESS.js">GUI Tools</a>
