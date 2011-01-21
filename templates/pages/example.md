Write some LESS:

    .box-shadow (@x: 0, @y: 0, @blur: 1px, @alpha) {
      @val: @x @y @blur rgba(0, 0, 0, @alpha);

      box-shadow:         @val;
      -webkit-box-shadow: @val;
      -moz-box-shadow:    @val;
    }
    .box { @base: #f938ab;
      color:        saturate(@base, 5%);
      border-color: lighten(@base, 30%);
      div { .box-shadow(0, 0, 5px, 0.4) }
    }

Include `less.js` with your styles:

    <link rel="stylesheet/less" type="text/css" href="styles.less">
    <script src="less.js" type="text/javascript"></script>


