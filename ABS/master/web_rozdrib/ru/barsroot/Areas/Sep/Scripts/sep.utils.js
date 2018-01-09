if (!('bars' in window)) window['bars'] = {};
bars.utils = bars.utils || {};
bars.utils.sep = bars.utils.sep || {
    //функция устнавливает доступность кендо кнопки с иконкой класса pureFlat внутри
    enableButton: function(buttonId, enabled) {
        if (typeof (enabled) === 'undefined') {
            enabled = true;
        }
        var $button = $('#' + buttonId);
        $button.data('kendoButton').enable(enabled);
        if (enabled) {
            $button.find('i').removeClass("pf-disabled");
        } else {
            $button.find('i').addClass("pf-disabled");
        }
    },
    getCharForDigit: function(digit) {
        function salNumberToChar(charCode) {
            return String.fromCharCode(charCode);
        } 
        if (!digit || digit < 0 || digit > 35) {
            return '?';
        } else if (digit < 10) {
            return salNumberToChar(digit + 48);
        } else {
            return salNumberToChar(digit + 55);
        }
    }, 
    // Преобразование данных в формате "Дата". Возврата в указанном формате: "dd/MM/yyyy" или "MM/dd/yyyy"
    formatDate: function (d, format) {
        var curr_date = d.getDate();
        var curr_month = d.getMonth() + 1;
        var curr_year = d.getFullYear();
        if (curr_month < 10) {
            curr_month = "0" + curr_month.toString();
        }
        if (format == "dd/MM/yyyy") {
            return curr_date + "/" + curr_month + "/" + curr_year;
        }
        if (format == "MM/dd/yyyy") {
            return curr_month + "/" + curr_date + "/" + curr_year;
        }
        return curr_date + "/" + curr_month + "/" + curr_year;
    },
    // Обновление принятого Kendo UI Grid
    reloadGridfunction: function (grid) {
        grid.dataSource.page(1);
        grid.dataSource.read();
    }
};




