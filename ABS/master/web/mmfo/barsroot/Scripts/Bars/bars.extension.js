if (!('bars' in window)) window['bars'] = {};
bars.extension = bars.extension || {};
bars.ext = bars.extension; 

// для IE8. в нем нет функции Array.indexOf()
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (obj, start) {
        for (var i = (start || 0), j = this.length; i < j; i++) {
            if (this[i] === obj) { return i; }
        }
        return -1;
    }
}

// для IE7. в нем нет функции console.log()
if (!window.console) {
    window.console = {
        log: function () { }
    };
}

// для IE8. в нем нет функции Array.map()
if (!Array.prototype.map) {

    Array.prototype.map = function (callback, thisArg) {

        var T, A, k;

        if (this == null) {
            throw new TypeError(' this is null or not defined');
        }

        // 1. Let O be the result of calling ToObject passing the |this| 
        //    value as the argument.
        var O = Object(this);

        // 2. Let lenValue be the result of calling the Get internal 
        //    method of O with the argument "length".
        // 3. Let len be ToUint32(lenValue).
        var len = O.length >>> 0;

        // 4. If IsCallable(callback) is false, throw a TypeError exception.
        // See: http://es5.github.com/#x9.11
        if (typeof callback !== 'function') {
            throw new TypeError(callback + ' is not a function');
        }

        // 5. If thisArg was supplied, let T be thisArg; else let T be undefined.
        if (arguments.length > 1) {
            T = thisArg;
        }

        // 6. Let A be a new array created as if by the expression new Array(len) 
        //    where Array is the standard built-in constructor with that name and 
        //    len is the value of len.
        A = new Array(len);

        // 7. Let k be 0
        k = 0;

        // 8. Repeat, while k < len
        while (k < len) {

            var kValue, mappedValue;

            // a. Let Pk be ToString(k).
            //   This is implicit for LHS operands of the in operator
            // b. Let kPresent be the result of calling the HasProperty internal 
            //    method of O with argument Pk.
            //   This step can be combined with c
            // c. If kPresent is true, then
            if (k in O) {

                // i. Let kValue be the result of calling the Get internal 
                //    method of O with argument Pk.
                kValue = O[k];

                // ii. Let mappedValue be the result of calling the Call internal 
                //     method of callback with T as the this value and argument 
                //     list containing kValue, k, and O.
                mappedValue = callback.call(T, kValue, k, O);

                // iii. Call the DefineOwnProperty internal method of A with arguments
                // Pk, Property Descriptor
                // { Value: mappedValue,
                //   Writable: true,
                //   Enumerable: true,
                //   Configurable: true },
                // and false.

                // In browsers that support Object.defineProperty, use the following:
                // Object.defineProperty(A, k, {
                //   value: mappedValue,
                //   writable: true,
                //   enumerable: true,
                //   configurable: true
                // });

                // For best browser support, use the following:
                A[k] = mappedValue;
            }
            // d. Increase k by 1.
            k++;
        }

        // 9. return A
        return A;
    };
}

if ($.fn.kendoWindow) {

}

String.format = function () {
    // The string containing the format items (e.g. "{0}")
    // will and always has to be the first argument.
    var theString = arguments[0];

    // start with the second argument (i = 1)
    for (var i = 1; i < arguments.length; i++) {
        // "gm" = RegEx options for Global search (more than one instance)
        // and for Multiline search
        var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
        theString = theString.replace(regEx, arguments[i]);
    }
    return theString;
}

//перевод недопереведенных сообщений KendoUI
if (kendo.ui.FilterCell) {
    kendo.ui.FilterCell.prototype.options.operators.string.doesnotcontain = 'не містять';
}

if (kendo.ui.FilterMenu) {
    kendo.ui.FilterMenu.prototype.options.operators.string.doesnotcontain = 'не містять';
    kendo.ui.FilterMenu.prototype.options.messages.or = 'або';
    kendo.ui.FilterMenu.prototype.options.messages.and = 'і';
}

//maskedDatePicker.js
(function ($) {
    var kendo = window.kendo,
        ui = kendo.ui,
        widget = ui.Widget;/*,
        proxy = $.proxy,
        CHANGE = "change",
        PROGRESS = "progress",
        ERROR = "error",
        NS = ".generalInfo";*/

    var MaskedDatePicker = widget.extend({
        init: function (element, options) {
            var that = this;
            var $elem = $(element);

            widget.fn.init.call(this, element, options);
            $elem.kendoMaskedTextBox(that.options)
            .kendoDatePicker(that.options)
            .closest(".k-datepicker")
            .add(element)
            .removeClass("k-textbox");

            $elem.removeClass("k-textbox")
                .on('click', function () {
                    $elem.data('kendoMaskedDatePicker').open();
            });
        },
        options: {
            name: "MaskedDatePicker",
            mask: "00/00/0000",
            format: "{0:MM/dd/yyyy}",
            parseFormats:["MM/dd/yyyy", "MM/dd/yy", 'dd/MM/yyyy', 'dd/MM/yy', 'dd.MM.yyyy', 'dd.MM.yy'],
            dateOptions: {}
        },
        destroy: function () {
            var that = this;
            widget.fn.destroy.call(that);

            kendo.destroy(that.element);
        },
        value: function (value) {
            var datepicker = this.element.data("kendoDatePicker");

            if (value === undefined) {
                return datepicker.value();
            }

            datepicker.value(value);
            return datepicker.value();
        }
    });

    ui.plugin(MaskedDatePicker);

})(window.kendo.jQuery);


//функції розширення kendo
bars.extension.kendo = {};
bars.extension.kendo.grid = {}

bars.extension.kendo.grid.noDataRow = function (e) {
    var grid = e.sender;
    var data = grid.dataSource.data();
    if (data.length === 0) {
        var colCount = grid.columns.length;
        var message = grid.pager ? grid.pager.options.messages.empty
                : kendo.ui.Pager.prototype.options.messages.empty || 'немає записів';
        $(e.sender.wrapper)
            .find('tbody')
            .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + message + '</td></tr>');
    }
    grid.element.height("auto");
    grid.element.find(".k-grid-content").height("auto");
    kendo.resize(grid.element);
}
bars.extension.kendo.grid.uiNumFilter = {
    ui: function(element) {
        element.kendoNumericTextBox({
            min: 0,
            format: "n0"
        });
    }
}


//достать параметер з URL
bars.extension.getParamFromUrl = function (param, url) {
    /// <summary>достать параметер з URL.</summary>
    /// <param name="param" type="String">параметр який шукаємо.</param>
    /// <param name="url" type="String">url</param>  
    /// <returns type="String">значенна параметра або null якщо його не знайдено.</returns>
    if (url === undefined) {
        url = document.location.href;
    }
    url = url.substring(url.indexOf('?') + 1);
    var paramsArray = url.split("&");
    for (var i = 0; i < paramsArray.length; i++) {
        if (paramsArray[i].split("=")[0].toUpperCase() === param.toUpperCase()) {
            return paramsArray[i].split("=")[1];
        }
    }
    return null;
}