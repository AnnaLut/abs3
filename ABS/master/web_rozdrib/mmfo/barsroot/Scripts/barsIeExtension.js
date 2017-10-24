// Add ECMA262-5 method binding if not supported natively
//
if (!('bind' in Function.prototype)) {
    Function.prototype.bind = function (owner) {
        var that = this;
        if (arguments.length <= 1) {
            return function () {
                return that.apply(owner, arguments);
            };
        } else {
            var args = Array.prototype.slice.call(arguments, 1);
            return function () {
                return that.apply(owner, arguments.length === 0 ? args : args.concat(Array.prototype.slice.call(arguments)));
            };
        }
    };
}

// Add ECMA262-5 string trim if not supported natively
//
if (!('trim' in String.prototype)) {
    String.prototype.trim = function () {
        return this.replace(/^\s+/, '').replace(/\s+$/, '');
    };
}

// Add ECMA262-5 Array methods if not supported natively
//
if (!('indexOf' in Array.prototype)) {
    Array.prototype.indexOf = function (find, i /*opt*/) {
        if (i === undefined) i = 0;
        if (i < 0) i += this.length;
        if (i < 0) i = 0;
        for (var n = this.length; i < n; i++)
            if (i in this && this[i] === find)
                return i;
        return -1;
    };
}
if (!('lastIndexOf' in Array.prototype)) {
    Array.prototype.lastIndexOf = function (find, i /*opt*/) {
        if (i === undefined) i = this.length - 1;
        if (i < 0) i += this.length;
        if (i > this.length - 1) i = this.length - 1;
        for (i++; i-- > 0;) /* i++ because from-argument is sadly inclusive */
            if (i in this && this[i] === find)
                return i;
        return -1;
    };
}

if (!('forEach' in Array.prototype)) {
    Array.prototype.forEach = function (fn, scope) {
        for (var i = 0, len = this.length; i < len; ++i) {
            if (i in this) {
                fn.call(scope || this, this[i], i, this);
            }
        }
    }
}

if (!('map' in Array.prototype)) {
    Array.prototype.map = function (mapper, that /*opt*/) {
        var other = new Array(this.length);
        for (var i = 0, n = this.length; i < n; i++)
            if (i in this)
                other[i] = mapper.call(that, this[i], i, this);
        return other;
    };
}
if (!('filter' in Array.prototype)) {
    Array.prototype.filter = function (filter, that /*opt*/) {
        var other = [], v;
        for (var i = 0, n = this.length; i < n; i++)
            if (i in this && filter.call(that, v = this[i], i, this))
                other.push(v);
        return other;
    };
}
if (!('every' in Array.prototype)) {
    Array.prototype.every = function (tester, that /*opt*/) {
        for (var i = 0, n = this.length; i < n; i++)
            if (i in this && !tester.call(that, this[i], i, this))
                return false;
        return true;
    };
}
if (!('some' in Array.prototype)) {
    Array.prototype.some = function (tester, that /*opt*/) {
        for (var i = 0, n = this.length; i < n; i++)
            if (i in this && tester.call(that, this[i], i, this))
                return true;
        return false;
    };
}

/*
//fix ie < 8
if (!window.Element || !window.Element.prototype || !window.Element.prototype.hasAttribute) {
  $(function() {
    (function() {

      function hasAttribute(attrName) {
        return typeof this[attrName] !== 'undefined'; // You may also be able to check getAttribute() against null, though it is possible this could cause problems for any older browsers (if any) which followed the old DOM3 way of returning the empty string for an empty string (yet did not possess hasAttribute as per our checks above). See https://developer.mozilla.org/en-US/docs/Web/API/Element.getAttribute
      }

      var inputs = document.getElementsByTagName('*');
      for (var i = 0; i < inputs.length; i++) {
        inputs[i].hasAttribute = hasAttribute;
      }
    }());
  });
}*/
// для ie7 document.querySelector()
(function () {
    if (typeof document.createStyleSheet == 'undefined') {
        return
    }
    var
		style = document.createStyleSheet(),
		select = function (selector, maxCount) {
		    var
				all = document.all,
				l = all.length,
				i,
				resultSet = [];

            selector = selector.replace('\\', '').replace('\\', '')
            alert(selector)
		    style.addRule(selector, "foo:bar");
		    for (i = 0; i < l; i += 1) {
		        if (all[i].currentStyle.foo === "bar") {
		            resultSet.push(all[i]);
		            if (resultSet.length > maxCount) {
		                break;
		            }
		        }
		    }
		    style.removeRule(0);
		    return resultSet;

		};

    //  be rly sure not to destroy a thing!
    if (document.querySelectorAll || document.querySelector) {
        return;
    }

    document.querySelectorAll = function (selector) {
        return select(selector, Infinity);
    };
    document.querySelector = function (selector) {
        return select(selector, 1)[0] || null;
    };
}());