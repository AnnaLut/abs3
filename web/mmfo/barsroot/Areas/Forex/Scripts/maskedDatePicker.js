//maskedDatePicker.js
(function ($) {
    var kendo = window.kendo,
        ui = kendo.ui,
        Widget = ui.Widget,
        proxy = $.proxy,
        CHANGE = "change",
        PROGRESS = "progress",
        ERROR = "error",
        NS = ".generalInfo";

    var MaskedDatePicker = Widget.extend({
        init: function (element, options) {
            var that = this;
            Widget.fn.init.call(this, element, options);

            $(element).kendoMaskedTextBox({ mask: that.options.dateOptions.mask || "00/00/0000" })
            .kendoDatePicker({
                format: that.options.dateOptions.format || "MM/dd/yyyy",
                parseFormats: that.options.dateOptions.parseFormats || ["MM/dd/yyyy", "MM/dd/yy"]
            })
            .closest(".k-datepicker")
            .add(element)
            .removeClass("k-textbox");

            that.element.data("kendoDatePicker").bind("change", function () {
                that.trigger(CHANGE);
            });
        },
        options: {
            name: "MaskedDatePicker",
            dateOptions: {}
        },
        events: [
          CHANGE
        ],
        destroy: function () {
            var that = this;
            Widget.fn.destroy.call(that);

            kendo.destroy(that.element);
        },
        value: function (value) {
            var datepicker = this.element.data("kendoDatePicker");

            if (value === undefined) {
                return datepicker.value();
            }

            datepicker.value(value);
        }
    });

    ui.plugin(MaskedDatePicker);

})(window.kendo.jQuery);