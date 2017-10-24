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
            .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + message + ' :(</td></tr>');
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