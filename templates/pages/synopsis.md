1.4.0 Beta
----------

We have released a beta of 1.4.0. This includes new features such as extends, the data-uri function and more maths functions. See the [changelog](https://github.com/cloudhead/less.js/blob/master/CHANGELOG.md) for a full list of changes.

There are four known <span class="warning">breaking changes</span>. 

`@import-once` is removed and is now default behaviour for `@import`. 

`(~".myclass_@{index}") { ...` selector interpolation is deprecated, do this instead `.myclass_@{index} { ...`. This works in 1.3.1 onwards.

Maths is required to be in parenthesis, e.g.

    (1 + 1)  // 2
    1 + 1    // 1+1

units must be consistent e.g.

    1px + 1em  // error
    1px + unit(1em,px) // 2px

The selector interpolation, maths and units changes can be made to your less now and will compile fine with less 1.3.3. If you need to use 1.4.0 with older less, the old behaviour of maths and units can be achieved using --strict-units-off and --strict-maths-off.

in JavaScript,

    less = {strictUnits: false, strictMaths: false};

You can install the beta with npm

    npm install -g less@beta

and for development, the [browser version is at github](https://github.com/cloudhead/less.js/blob/master/dist/less-1.4.0-beta.js).

Variables
---------

Variables allow you to specify widely used values in a single place, and then re-use them throughout the style sheet,
making global changes as easy as changing one line of code.

<table class="code-example" cellpadding="0">
  <tr><td>
  <pre class="less-example">
  <code>// LESS

@color: #4D926F;

#header {
  color: @color;
}
h2 {
  color: @color;
}</code></pre>
  </td><td>
  <pre class="css-output"><code>/* Compiled CSS */

#header {
  color: #4D926F;
}
h2 {
  color: #4D926F;
}</code></pre></td>
  </tr>
</table>

Mixins
------

Mixins allow you to embed all the properties of a class into another class by
simply including the class name as one of its properties. It's just like variables,
but for whole classes. Mixins can also behave like functions, and take arguments,
as seen in the example below.

<table class="code-example" cellpadding="0">
  <tr><td>
  <pre class="less-example"><code>// LESS

.rounded-corners (@radius: 5px) {
  -webkit-border-radius: @radius;
  -moz-border-radius: @radius;
  -ms-border-radius: @radius;
  -o-border-radius: @radius;
  border-radius: @radius;
}

#header {
  .rounded-corners;
}
#footer {
  .rounded-corners(10px);
}</code></pre></td>

<td>
  <pre class="css-output"><code>/* Compiled CSS */

#header {
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  -ms-border-radius: 5px;
  -o-border-radius: 5px;
  border-radius: 5px;
}
#footer {
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
  -ms-border-radius: 10px;
  -o-border-radius: 10px;
  border-radius: 10px;
}</code></pre>
  </td></tr>
</table>

Nested Rules
------------

Rather than constructing long selector names to specify inheritance,
in Less you can simply nest selectors inside other selectors.
This makes inheritance clear and style sheets shorter.

<table class="code-example" cellpadding="0">
  <tr><td>
  <pre class="less-example">
<code>// LESS

#header {
  h1 {
    font-size: 26px;
    font-weight: bold;
  }
  p { font-size: 12px;
    a { text-decoration: none;
      &:hover { border-width: 1px }
    }
  }
}

</code></pre></td>

<td>
  <pre class="css-output"><code>/* Compiled CSS */

#header h1 {
  font-size: 26px;
  font-weight: bold;
}
#header p {
  font-size: 12px;
}
#header p a {
  text-decoration: none;
}
#header p a:hover {
  border-width: 1px;
}

</code></pre>
  </td></tr>
</table>

Functions & Operations
----------------------

Are some elements in your style sheet proportional to other elements?
Operations let you add, subtract, divide and multiply property values and colors,
giving you the power to create complex relationships between properties. Operations
should only be performed within parentheses in order to ensure compatibility with CSS.
Functions map one-to-one with JavaScript code, allowing you to manipulate values however
you want.

<table class="code-example" cellpadding="0">
  <tr><td>
  <pre class="less-example">
<code>// LESS

@the-border: 1px;
@base-color: #111;
@red:        #842210;

#header {
  color: (@base-color * 3);
  border-left: @the-border;
  border-right: (@the-border * 2);
}
#footer {
  color: (@base-color + #003300);
  border-color: desaturate(@red, 10%);
}

</code></pre></td>

<td>
  <pre class="css-output"><code>/* Compiled CSS */

#header {
  color: #333;
  border-left: 1px;
  border-right: 2px;
}
#footer {
  color: #114411;
  border-color: #7d2717;
}

</code></pre>
  </td></tr>
</table>

