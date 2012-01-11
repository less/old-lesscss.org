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
  border-radius: @radius;
  -webkit-border-radius: @radius;
  -moz-border-radius: @radius;
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
  border-radius: 5px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
}
#footer {
  border-radius: 10px;
  -webkit-border-radius: 10px;
  -moz-border-radius: 10px;
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
giving you the power to create complex relationships between properties.
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
  color: @base-color * 3;
  border-left: @the-border;
  border-right: @the-border * 2;
}
#footer { 
  color: @base-color + #003300;
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

