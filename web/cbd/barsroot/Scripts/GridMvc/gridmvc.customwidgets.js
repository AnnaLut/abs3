/***
* DateTimeFilterWidget2 - Виджет отличается от стандартного поведением в случае выбора первого типа фильтрации = Дата
* в этом случае фильтрация выполняется по дате без учета времени поля, тоесть дата от начала выбранного дня до начала следующего дня
*/
DateTimeFilterWidget2 = (function ($) {

    function dateTimeFilterWidget2() { }

    dateTimeFilterWidget2.prototype.getAssociatedTypes = function () { return ["DateTimeFilterWidget2"]; };

    dateTimeFilterWidget2.prototype.showClearFilterButton = function () { return true; };

    dateTimeFilterWidget2.prototype.onRender = function (container, lang, typeName, values, applycb, data) {
        this.datePickerIncluded = typeof ($.fn.datepicker) != 'undefined';
        this.cb = applycb;
        this.data = data;
        this.typeName = typeName;
        this.container = container;
        this.lang = lang;
        this.value = values.length > 0 ? values[0] : { filterType: 1, filterValue: "" };
        this.renderWidget();
    };

    dateTimeFilterWidget2.prototype.renderWidget = function () {
        var html = '<div class="form-group">\
                        <label>' + this.lang.filterTypeLabel + '</label>\
                        <select class="grid-filter-type form-control">\
                            <option value="1" ' + (this.value.filterType == "1" ? "selected=\"selected\"" : "") + '>' + this.lang.filterSelectTypes.Equals + '</option>\
                            <option value="5" ' + (this.value.filterType == "5" ? "selected=\"selected\"" : "") + '>' + this.lang.filterSelectTypes.GreaterThan + '</option>\
                            <option value="6" ' + (this.value.filterType == "6" ? "selected=\"selected\"" : "") + '>' + this.lang.filterSelectTypes.LessThan + '</option>\
                        </select>\
                    </div>' +
                        (this.datePickerIncluded ?
                            '<div class="grid-filter-datepicker"></div>'
                            :
                            '<div class="form-group">\
                                <label>' + this.lang.filterValueLabel + '</label>\
                                <input type="text" class="grid-filter-input form-control" value="' + this.value.filterValue + '" />\
                             </div>\
                             <div class="grid-filter-buttons">\
                                <input type="button" class="btn btn-primary grid-apply" value="' + this.lang.applyFilterButtonText + '" />\
                             </div>');
        this.container.append(html);
        //if window.jQueryUi included:
        if (this.datePickerIncluded) {
            var datePickerOptions = this.data || {};
            datePickerOptions.format = datePickerOptions.format || "yyyy-mm-dd";
            datePickerOptions.language = datePickerOptions.language || this.lang.code;

            var $context = this;
            var dateContainer = this.container.find(".grid-filter-datepicker");
            dateContainer.datepicker(datePickerOptions).on('changeDate', function (ev) {
                var type = $context.container.find(".grid-filter-type").val();
                if (type == "1") {
                    var today = ev.format();
                    var todayDate = new Date(ev.date);
                    var tomorrowDate = new Date(todayDate.setDate(todayDate.getDate() + 1));
                    //библиотека jQuery-dateFormat в шаблоне для числового месяца требует MM, в отличие от датапикера
                    var tomorrow = DateFormat.format.date(tomorrowDate, "yyyy-MM-dd");
                    var filterValues = [{ filterType: 7, filterValue: today }, { filterType: 6, filterValue: tomorrow }];
                }
                else {
                    var filterValues = [{ filterType: type, filterValue: ev.format() }];
                }
                $context.cb(filterValues);
            });
            if (this.value.filterValue)
                dateContainer.datepicker('update', this.value.filterValue);
        }
    };
    return dateTimeFilterWidget2;
})(window.jQuery);

/***
* LoginAndUserTypeFilterWidget - позволяет для колонки Логин указать также тип пользователя.
* Использовать можно только на гридах, в которых есть колонка USER_TYPE - айди типа пользователя
* отложил пока, не ясно как добавить условие фильтрации по чужой колонке
*/
function LoginAndUserTypeFilterWidget(userTypesPath) {
    this.getAssociatedTypes = function () { return ["LoginAndUserTypeFilterWidget"]; };
    this.onShow = function () {
        var textBox = this.container.find(".grid-filter-input");
        if (textBox.length <= 0) return;
        textBox.focus();
    };
    
    this.showClearFilterButton = function () { return true; };
    
    this.onRender = function (container, lang, typeName, values, cb) {
        this.cb = cb;
        this.container = container;
        this.lang = lang;
        this.value = values.length > 0 ? values[0] : { filterType: 1, filterValue: "" };
        this.renderWidget();
        this.registerEvents();
        this.buildUserTypesSelect();
    };
    
    this.buildUserTypesSelect = function () {
        $.get(userTypesPath)
        .done(function (data) {
            $.each(data, function (i, item) {
                var option = document.createElement("option");
                option.text = item.descr;
                option.value = item.id;
                var select = document.getElementById("userTypeSelect");
                select.appendChild(option);
            });
        });
    }; 

    this.renderWidget = function () {
        var html = '<div class="form-group">\
                        <label>Тип користувача:</label>\
                        <select id="userTypeSelect" class="form-control"></select>\
                        <label>' + this.lang.filterTypeLabel + '</label>\
                        <select class="grid-filter-type form-control">\
                            <option value="1" ' + (this.value.filterType == "1" ? "selected=\"selected\"" : "") + '>' + this.lang.filterSelectTypes.Equals + '</option>\
                            <option value="2" ' + (this.value.filterType == "2" ? "selected=\"selected\"" : "") + '>' + this.lang.filterSelectTypes.Contains + '</option>\
                            <option value="3" ' + (this.value.filterType == "3" ? "selected=\"selected\"" : "") + '>' + this.lang.filterSelectTypes.StartsWith + '</option>\
                            <option value="4" ' + (this.value.filterType == "4" ? "selected=\"selected\"" : "") + '>' + this.lang.filterSelectTypes.EndsWith + '</option>\
                        </select>\
                    </div>\
                    <div class="form-group">\
                        <label>' + this.lang.filterValueLabel + '</label>\
                        <input type="text" class="grid-filter-input form-control" value="' + this.value.filterValue + '" />\
                    </div>\
                    <div class="grid-filter-buttons">\
                        <button type="button" class="btn btn-primary grid-apply" >' + this.lang.applyFilterButtonText + '</button>\
                    </div>';
        this.container.append(html);
    };
    /***
    * Internal method that register event handlers for 'apply' button.
    */
    this.registerEvents = function () {
        //get apply button from:
        var applyBtn = this.container.find(".grid-apply");
        //save current context:
        var $context = this;
        //register onclick event handler
        applyBtn.click(function () {
            //get selected filter type:
            var type = $context.container.find(".grid-filter-type").val();
            //get filter value:
            var value = $context.container.find(".grid-filter-input").val();
            //invoke callback with selected filter values:
            var filterValues = [{ filterType: type, filterValue: value }];
            $context.cb(filterValues);
        });
        //register onEnter event for filter text box:
        this.container.find(".grid-filter-input").keyup(function (event) {
            if (event.keyCode == 13) { applyBtn.click(); }
            if (event.keyCode == 27) { GridMvc.closeOpenedPopups(); }
        });
    };

    
};








