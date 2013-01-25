As an extension to CSS, LESS is not only backwards compatible with CSS, but the extra features it adds use <em>existing</em> CSS syntax. This makes learning LESS a <em>breeze</em>, and if in doubt, lets you fall back to CSS.

Variables
---------

These are pretty self-explanatory:

    @nice-blue: #5B83AD;
    @light-blue: (@nice-blue + #111);

    #header { color: @light-blue; }

Outputs:

    #header { color: #6c94be; }

It is also possible to define variables with a variable name:

    @fnord: "I am fnord.";
    @var: 'fnord';
    content: @@var;

Which compiles to:

    content: "I am fnord.";

When defining a variable twice, the last definition of the variable is used, searching from the current scope upwards. For instance:

	@var: 0;
	.class1
      @var: 1;
	  .class {
	    @var: 2;
	    three: @var;
		@var: 3;
	  }
	  one: @var;
	}

Compiles to:

    .class1 .class {
	  three: 3;
	}
	.class {
	  one: 1;
	}

This is similar to css itself where the last property inside a definition is used to determine the value.

Mixins
------

In LESS, it is possible to include a bunch of properties from one ruleset into another ruleset. So say we have the following class:

    .bordered {
      border-top: dotted 1px black;
      border-bottom: solid 2px black;
    }

And we want to use these properties inside other rulesets. Well, we just have to drop in the name of
the class in any ruleset we want to include its properties, like so:

    #menu a {
      color: #111;
      .bordered;
    }
    .post a {
      color: red;
      .bordered;
    }

The properties of the `.bordered` class will now appear in both `#menu a` and `.post a`:

    #menu a {
      color: #111;
      border-top: dotted 1px black;
      border-bottom: solid 2px black;
    }
    .post a {
      color: red;
      border-top: dotted 1px black;
      border-bottom: solid 2px black;
    }

Any CSS *class* or *id* ruleset can be mixed-in that way.

Note: Variables are also mixed in, so variables from a mixin will be placed into the current scope. This is contentious and may change in the future.

Parametric Mixins
-----------------

LESS has a special type of ruleset which can be mixed in like classes, but accepts parameters. Here's the canonical example:

    .border-radius (@radius) {
      border-radius: @radius;
      -moz-border-radius: @radius;
      -webkit-border-radius: @radius;
    }

And here's how we can mix it into various rulesets:

    #header {
      .border-radius(4px);
    }
    .button {
      .border-radius(6px);
    }

Parametric mixins can also have default values for their parameters:

    .border-radius (@radius: 5px) {
      border-radius: @radius;
      -moz-border-radius: @radius;
      -webkit-border-radius: @radius;
    }

We can invoke it like this now:

    #header {
      .border-radius;
    }

And it will include a 5px border-radius.

You can also use parametric mixins which don't take parameters. This is useful if you want to hide the ruleset from the CSS output,
but want to include its properties in other rulesets:

    .wrap () {
      text-wrap: wrap;
      white-space: pre-wrap;
      white-space: -moz-pre-wrap;
      word-wrap: break-word;
    }

    pre { .wrap }

Which would output:

    pre {
      text-wrap: wrap;
      white-space: pre-wrap;
      white-space: -moz-pre-wrap;
      word-wrap: break-word;
    }

### The `@arguments` variable

`@arguments` has a special meaning inside mixins, it contains all the arguments passed, when the mixin was called. This is useful
if you don't want to deal with individual parameters:

    .box-shadow (@x: 0, @y: 0, @blur: 1px, @color: #000) {
      box-shadow: @arguments;
      -moz-box-shadow: @arguments;
      -webkit-box-shadow: @arguments;
    }
    .box-shadow(2px, 5px);

Which results in:

      box-shadow: 2px 5px 1px #000;
      -moz-box-shadow: 2px 5px 1px #000;
      -webkit-box-shadow: 2px 5px 1px #000;

### Advanced arguments and the `@rest` variable

You can use `...` if you want your mixin to take a variable number of arguments. Using this after a variable name will assign those arguments to the variable.

    .mixin (...) {        // matches 0-N arguments
    .mixin () {           // matches exactly 0 arguments
    .mixin (@a: 1) {      // matches 0-1 arguments
    .mixin (@a: 1, ...) { // matches 0-N arguments
    .mixin (@a, ...) {    // matches 1-N arguments

Furthermore:

    .mixin (@a, @rest...) {
       // @rest is bound to arguments after @a
       // @arguments is bound to all arguments
    }

## Pattern-matching and Guard expressions

Sometimes, you may want to change the behaviour of a mixin,
based on the parameters you pass to it. Let's start with something
basic:

    .mixin (@s, @color) { ... }

    .class {
      .mixin(@switch, #888);
    }

Now let's say we want `.mixin` to behave differently, based on the value of `@switch`,
we could define `.mixin` as such:

    .mixin (dark, @color) {
      color: darken(@color, 10%);
    }
    .mixin (light, @color) {
      color: lighten(@color, 10%);
    }
    .mixin (@_, @color) {
      display: block;
    }

Now, if we run:

    @switch: light;

    .class {
      .mixin(@switch, #888);
    }

We will get the following CSS:

    .class {
      color: #a2a2a2;
      display: block;
    }

Where the color passed to `.mixin` was lightened. If the value of `@switch` was `dark`,
the result would be a darker color.

Here's what happened:

- The first mixin definition didn't match because it expected `dark` as the first argument.
- The second mixin definition matched, because it expected `light`.
- The third mixin definition matched because it expected any value.

Only mixin definitions which matched were used. Variables match and bind to any value.
Anything other than a variable matches only with a value equal to itself.

We can also match on arity, here's an example:

    .mixin (@a) {
      color: @a;
    }
    .mixin (@a, @b) {
      color: fade(@a, @b);
    }

Now if we call `.mixin` with a single argument, we will get the output of the first definition,
but if we call it with *two* arguments, we will get the second definition, namely `@a` faded to `@b`.

### Guards

Guards are useful when you want to match on *expressions*, as opposed to simple values or arity. If you are
familiar with functional programming, you have probably encountered them already.

In trying to stay as close as possible to the declarative nature of CSS, LESS has opted to implement
conditional execution via **guarded mixins** instead of if/else statements, in the vein of `@media`
query feature specifications.

Let's start with an example:

    .mixin (@a) when (lightness(@a) >= 50%) {
      background-color: black;
    }
    .mixin (@a) when (lightness(@a) < 50%) {
      background-color: white;
    }
    .mixin (@a) {
      color: @a;
    }

The key is the **`when`** keyword, which introduces a guard sequence (here with only one guard). Now if we run the following
code:

    .class1 { .mixin(#ddd) }
    .class2 { .mixin(#555) }


Here's what we'll get:

    .class1 {
      background-color: black;
      color: #ddd;
    }
    .class2 {
      background-color: white;
      color: #555;
    }

The full list of comparison operators usable in guards are: **`> >= = =< <`**. Additionally, the keyword `true`
is the only truthy value, making these two mixins equivalent:

    .truth (@a) when (@a) { ... }
    .truth (@a) when (@a = true) { ... }

Any value other than the keyword `true` is falsy:

    .class {
      .truth(40); // Will not match any of the above definitions.
    }

Guards can be separated with a comma '`,`'--if any of the guards evaluates to true, it's
considered as a match:

    .mixin (@a) when (@a > 10), (@a < -10) { ... }

Note that you can also compare arguments with each other, or with non-arguments:

    @media: mobile;

    .mixin (@a) when (@media = mobile) { ... }
    .mixin (@a) when (@media = desktop) { ... }

    .max (@a, @b) when (@a > @b) { width: @a }
    .max (@a, @b) when (@a < @b) { width: @b }

Lastly, if you want to match mixins based on value type, you can use the *is\** functions:

    .mixin (@a, @b: 0) when (isnumber(@b)) { ... }
    .mixin (@a, @b: black) when (iscolor(@b)) { ... }

Here are the basic type checking functions:

- `iscolor`
- `isnumber`
- `isstring`
- `iskeyword`
- `isurl`

If you want to check if a value, in addition to being a number, is in a specific unit, you may use one of:

- `ispixel`
- `ispercentage`
- `isem`

Last but not least, you may use the **`and`** keyword to provide additional conditions inside a guard:

    .mixin (@a) when (isnumber(@a)) and (@a > 0) { ... }

And the **`not`** keyword to negate conditions:

    .mixin (@b) when not (@b > 0) { ... }

Nested rules
------------

LESS gives you the ability to use *nesting* instead of, or in combination with cascading.
Lets say we have the following CSS:

    #header { color: black; }
    #header .navigation {
      font-size: 12px;
    }
    #header .logo {
      width: 300px;
    }
    #header .logo:hover {
      text-decoration: none;
    }

In LESS, we can also write it this way:

    #header {
      color: black;

      .navigation {
        font-size: 12px;
      }
      .logo {
        width: 300px;
        &:hover { text-decoration: none }
      }
    }

Or this way:

    #header        { color: black;
      .navigation  { font-size: 12px }
      .logo        { width: 300px;
        &:hover    { text-decoration: none }
      }
    }

The resulting code is more concise, and mimics the structure of your `DOM tree`.

Notice the `&` combinator--it's used when you want a nested selector to be concatenated to its parent selector, instead
of acting as a descendant. This is especially important for pseudo-classes like `:hover` and `:focus`.

For example:

    .bordered {
      &.float {
        float: left;
      }
      .top {
        margin: 5px;
      }
    }

Will output

    .bordered.float {
      float: left;
    }
    .bordered .top {
      margin: 5px;
    }

Nested Media Queries
--------------------

Media queries can be nested in the same way as selectors e.g.

    .one {
	    @media (width: 400px) {
			font-size: 1.2em;
		    @media print and color {
			    color: blue;
            }			
		}
	}

Will output

	@media (width: 400px) {
	  .one {
		font-size: 1.2em;
	  }
	}
	@media (width: 400px) and print and color {
	  .one {
		color: blue;
	  }
	}
	
Advanced Usage of &
-------------------

The & symbol can be used in selectors in order to reverse the ordering of the nesting and to multiply classes.

For example:

    .child, .sibling {
	    .parent & {
		    color: black;
		}
		& + & {
		    color: red;
		}
	}
	
Will output

    .parent .child,
    .parent .sibling {
	    color: black;
	}
	.child + .child,
    .child + .sibling,
	.sibling + .child,
	.sibling + .sibling {
	    color: red;
	}
	
You can also use & in mixins in order to reference nesting that is outside of your mixin.

Operations
----------

Any number, color or variable can be operated on. Operations should be performed
within parentheses. Here are a couple of examples:

    @base: 5%;
    @filler: (@base * 2);
    @other: (@base + @filler);

    color: (#888 / 4);
    background-color: (@base-color + #111);
    height: (100% / 2 + @filler);

The output is pretty much what you expect—LESS understands the difference between colors and units. If a unit is used in an operation, like in:

    @var: (1px + 5);

LESS will use that unit for the final output—`6px` in this case.

Extra parentheses are also authorized in operations:

    width: ((@var + 5) * 2);

Functions
---------

LESS provides a variety of functions which transform colors, manipulate strings and do maths. 
They are documented fully in the function reference.

Using them is pretty straightforward. The following example uses percentage to convert 0.5 to 50%, 
increases the saturation of a base color by 5% and then sets the background color to one that is lightened by
25% and spun by 8 degrees:

    @base: #f04615;
	@width: 0.5;

    .class {
	  width: percentage(0.5); // returns `50%`
      color: saturate(@base, 5%);
      background-color: spin(lighten(@base, 25%), 8);
    }

Namespaces
----------

Sometimes, you may want to group your variables or mixins, for organizational purposes, or just to offer some encapsulation.
You can do this pretty intuitively in LESS—say you want to bundle some mixins and variables under `#bundle`, for later re-use, or for distributing:

    #bundle {
      .button () {
        display: block;
        border: 1px solid black;
        background-color: grey;
        &:hover { background-color: white }
      }
      .tab { ... }
      .citation { ... }
    }

Now if we want to mixin the `.button` class in our `#header a`, we can do:

    #header a {
      color: orange;
      #bundle > .button;
    }

Scope
-----

Scope in LESS is very similar to that of programming languages. Variables and mixins are first looked up locally,
and if they aren't found, the compiler will look in the parent scope, and so on.

    @var: red;

    #page {
      @var: white;
      #header {
        color: @var; // white
      }
    }

    #footer {
      color: @var; // red
    }

Comments
--------

CSS-style comments are preserved by LESS:

    /* Hello, I'm a CSS-style comment */
    .class { color: black }

Single-line comments are also valid in LESS, but they are 'silent',
they don't show up in the compiled CSS output:

    // Hi, I'm a silent comment, I won't show up in your CSS
    .class { color: white }

Importing
---------

You can import both css and less files. Only less files import statements are processed, css file import statements are kept as they are. If you want to import a CSS file, and don't want LESS to process it, just use the `.css` extension:

    @import "lib.css";

Compilation makes only one change to css file imports: top level css file imports are moved on top of the sheet, right after @charset declarations. 

<table class="code-example" cellpadding="0">
<tr><td><pre class="less-example"><code>// LESS input
h1 { color: green; }
@import-once "import/official-branding.css?urlParameter=23";
</code></pre></td><td><pre class="css-output"><code>// CSS output
@import "import/official-branding.css?urlParameter=23";
h1 { color: green; }
</code></pre></td></tr>
</table>

Any file that does not end with `.css` is considered less file and processed. In addition, if the file name has no extension or parameters, the ".less" suffix is added on the end. Both of these are equivalent:

    @import "lib.less";
    @import "lib";

Content of imported less file is copied into importing style sheet and compiled together with it. Importing and imported files share all mixins, namespaces, variables and other structures. In addition, if the import statement had media queries, imported content is enclosed in @Media declaration.

Imported "library.less":

    @importedColor: red; //define variable
    h1 {color: green; } //ruleset

Main file imports the above library.less file:

    @import-multiple "library.less" screen and (max-width: 400px); // import with media queries
    @import-multiple "library.less"; // import without media queries
    .class {
      color: @importedColor; // use imported variable
    }

Compiled file:

    //corresponds to import with media queries
    @media screen and (max-width: 400px) {
      h1 { color: green; }
    }
    //corresponds to import without media queries
    h1 { color: green; }
    .class {
      //use imported variable
      color: #ff0000;
    }

Less file import statement does not have to be located on top of the style sheet. It can be placed also inside rulesets, mixins or other less structures.

Import into ruleset:

    pre {
      @import "library.less";
      color: @importedColor;
    }

both variable and ruleset defined in "library.less" have been copied into the `pre` ruleset:

    pre {
      color: #ff0000; // variable defined in library.less was available
    }
    pre h1 { //ruleset defined in library.less was nested into 'pre' ruleset
      color: green;
    }

Less supports three different @import statements:
* `@import-once`,
* `@import-multiple` - available only for 1.4.0 or higher versions,
* `@import`.

If you want to import a file only if it has not been imported already, use `@import-once`:

    @import-once "lib.less";
    @import-once "lib.less"; // will be ignored
    @import-once "lib.less" handheld; // will be ignored
    pre {
      @import-once "lib.less"; // will be ignored
    }

If you want to import a file whether it was already imported or not, use `@import-multiple`

    @import-once "lib.less";
    @import-multiple "lib.less"; // will be imported
    @import-multiple "lib.less" handheld; // will be imported
    pre {
      @import-multiple "lib.less"; // will be imported
    }

The statement `@import` acts differently before and after 1.4.0. It acts as `@import-multiple` in all older versions and as `@import-once` in all less.js versions after 1.4.0. 

String interpolation
--------------------

Variables can be embeded inside strings in a similar way to ruby or PHP, with the `@{name}` construct:

    @base-url: "http://assets.fnord.com";
    background-image: url("@{base-url}/images/bg.png");

Escaping
--------

Sometimes you might need to output a CSS value which is either not valid CSS syntax,
or uses proprietary syntax which LESS doesn't recognize.

To output such value, we place it inside a string prefixed with `~`, for example:

    .class {
      filter: ~"ms:alwaysHasItsOwnSyntax.For.Stuff()";
    }

This is called an "escaped value", which will result in:

    .class {
      filter: ms:alwaysHasItsOwnSyntax.For.Stuff();
    }
	
Selector Interpolation
----------------------

If you want to use less variables inside selectors, you can do this by referencing the variable using `@{selector}` as 
in string interpolation. For example:

    @name: blocked;
	.@{name} {
	    color: black;
	}
	
will output

    .blocked {
	    color: black;
	}
	
Note: prior to less 1.3.1 a `(~"@{name}")` type of selector was supported. Support for this will be removed in 1.4.0.

JavaScript evaluation
---------------------

JavaScript expressions can be evaluated as values inside .less files. We reccomend using caution with this feature
as the less will not be compilable by ports and it makes the less harder to mantain. If possible, try to think of a
function that can be added to achieve the same purpose and ask for it on github. We have plans to allow expanding the
default functions available. However, if you still want to use JavaScript in .less, this is done by wrapping the expression
with back-ticks:

    @var: `"hello".toUpperCase() + '!'`;

Becomes:

    @var: "HELLO!";

Note that you may also use interpolation and escaping as with strings:

    @str: "hello";
    @var: ~`"@{str}".toUpperCase() + '!'`;

Becomes:

    @var: HELLO!;

It is also possible to access the JavaScript environment:

    @height: `document.body.clientHeight`;

If you want to parse a JavaScript string as a hex color, you may use the `color` function:

    @color: color(`window.colors.baseColor`);
    @darkcolor: darken(@color, 10%);


