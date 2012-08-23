Testing
=======

Test runner
-----------

    vows [FILE, ...] [options]

### Running tests #

    $ vows test-1.js test-2.js
    $ vows tests/*

Watch mode

    $ vows -w
    $ vows --watch

### Options #

<table cellspacing="10">
  <tr>
    <td><code>-v</code>, <code>--verbose</code></td>
    <td>Verbose mode</td>
  </tr>
  <tr>
    <td><code>-w</code>, <code>--watch</code></td>
    <td>Watch mode</td>
  </tr>
  <tr>
    <td><code>-m STRING</code></td>
    <td>String matching: Only run tests with <code>STRING</code> in their title</td>
  </tr>
  <tr>
    <td><code>-r REGEXP</code></td>
    <td>Regexp matching: Only run tests with <code>REGEXP</code> in their title</td>
  </tr>
  <tr>
    <td><code>--json</code></td>
    <td>Use JSON reporter</td>
  </tr>
  <tr>
    <td><code>--spec</code></td>
    <td>Use Spec reporter</td>
  </tr>
  <tr>
    <td><code>--dot-matrix</code></td>
    <td>Use Dot-Matrix reporter</td>
  </tr>
  <!-- <tr> -->
  <!--   <td><code>-no-color</code></td> -->
  <!--   <td>Don't use terminal colors</td> -->
  <!-- </tr> -->
  <tr>
    <td><code>--version</code></td>
    <td>Show version</td>
  </tr>
  <tr>
    <td><code>-s</code>, <code>--silent</code></td>
    <td>Don't report</td>
  </tr>
  <tr>
    <td><code>--help</code></td>
    <td>Show help</td>
  </tr>
</table>

Assertion functions
-------------------

### equality #

    assert.equal          (4, 4);
    assert.strictEqual    (4 > 2, true);

    assert.notEqual       (4, 2);
    assert.strictNotEqual (1, true);

### type #

    assert.isFunction (function () {});
    assert.isObject   ({goo:true});
    assert.isString   ('goo');
    assert.isArray    ([4, 2]);
    assert.isNumber   (42);
    assert.isBoolean  (true);

    assert.typeOf     (42, 'number');
    assert.instanceOf ([], Array);

### truth #

    assert.isTrue  (true);
    assert.isFalse (false);

### null, undefined, NaN #

    assert.isNull      (null);
    assert.isNotNull   (undefined);

    assert.isUndefined ('goo'[9]);
    assert.isNaN       (0/0);

### inclusion #

    assert.include ([4, 2, 0], 2);
    assert.include ({goo:true}, 'goo');
    assert.include ('goo', 'o');

### regexp matching #

    assert.match ('hello', /^[a-z]+/);

### length #

    assert.length ([4, 2, 0], 3);
    assert.length ('goo', 3);

### emptiness #

    assert.isEmpty ([]);
    assert.isEmpty ({});
    assert.isEmpty ("");

### exceptions #

- assert.throws
- assert.doesNotThrow


