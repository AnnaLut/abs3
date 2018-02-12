function dealChangesHistoryForm(zpDealId, zpDealNumber) {

    var gridSelector = '#dealChangeHistoriGrid';

    var kendoWindow = $('<div />').kendoWindow({
        actions: ["Close"],
        title: 'Історія змін параметрів ЗП договору № <b>' + zpDealNumber + '</b>',
        resizable: false,
        modal: true,
        draggable: true,
        //width: "900px",
        width: "65%",
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'up', close: 'down' } }),
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        close: function () {
        },
        activate: function () {
            kendoWindow.find(gridSelector).kendoGrid(gridOptions);
            kendoWindow.find('.k-pager-info.k-label').remove();

            $("#dealChangeHistoriGrid .k-grid-content").css("max-height", 500);

            kendoWindow.data("kendoWindow").refresh();
        },
        refresh: function () {
            this.center();
        }
    });

    var totalTemplate = getTemplate();

    var template = kendo.template(totalTemplate);

    kendoWindow.data("kendoWindow").content(template({}));

    var resData = [];
    var gridOptions = {
        dataSource: {
            data: resData,
            group: { field: "upd_date", dir: "desc" }
        },
        pageable: {
            info: false,
            refresh: false,
            pageSize: false,
            previousNext: false,
            numeric: false
        },
        scrollable: true,
        reorderable: false,
        resizable: false,
        filterable: false,
        columns: [
            { field: 'upd_date', title: 'Дата', hidden: true },
            { field: 'upd_time', title: 'Час', width: '150px' },
            { field: 'upd_user_fio', title: 'Ініціатор' },
            { field: 'updatedFieldsStr', title: 'Які параметри змінено' },
            { title: ' ', width: '50px', template: '<a class="btn btn-primary custom-btn search-btn details-small-btn" title="Деталі" tabindex="-1"></a>' }
        ],
        selectable: "row",
        editable: false,
        noRecords: {
            template: '<hr class="modal-hr"/>Договір №<b>' + zpDealNumber + '</b> не редагувався<hr class="modal-hr"/>'
        },
        dataBound: function (e) {
            var groupsToCollapse = e.sender.tbody.find(".k-grouping-row");
            groupsToCollapse.each(function (idx, item) {
                if (idx > 0)
                    e.sender.collapseGroup(item);
                else
                    $(item).addClass('k-state-selected');
            });

            kendoWindow.data("kendoWindow").refresh();
        }
    };

    bars.ui.loader('body', true);
    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetDealHistory?id=" + zpDealId),
        success: function (data) {
            bars.ui.loader('body', false);

            var arr = data.ResultObj;
            if (arr.length <= 1) {
                bars.ui.alert({ text: 'Даний договір не редагувався.' });
                kendoWindow.data("kendoWindow").destroy();
                return;
            } else {
                kendoWindow.data("kendoWindow").center().open();
            }

            //////////////////////
            arr = arr.sort(compareASC);

            var ignoreList = ['upd_time', 'upd_date', 'upd_user_fio'];

            for (var i = 1; i < arr.length; i++) {
                var tmp = {
                    upd_date: arr[i].upd_date,
                    upd_time: arr[i].upd_time,
                    upd_user_fio: arr[i].upd_user_fio,
                    updatedFieldsStr: '',
                    updatedFields: []
                };

                for (var prop in arr[i]) {
                    if (+ignoreList.indexOf(prop) == -1) {
                        if (arr[i - 1][prop] != arr[i][prop]) {
                            tmp.updatedFieldsStr += prop + ', ';
                            tmp.updatedFields.push({
                                name: prop,
                                oldVal: checkVal(arr[i - 1][prop]),
                                newVal: checkVal(arr[i][prop])
                            });
                        }
                    }
                }

                tmp.updatedFieldsStr = tmp.updatedFieldsStr.slice(0, -2);
                resData.push(tmp);
            }

            resData.reverse();

            function checkVal(val) {
                if (val === undefined || val === null) return '';
                return val;
            };
            function compareASC(a, b) {
                var _a = stringToDate(a.upd_date, a.upd_time);
                var _b = stringToDate(b.upd_date, b.upd_time);

                if (_a == _b) return 0;
                return _a > _b ? 1 : -1;
            }
            function stringToDate(a, t) {
                var _a = a.split('.');
                var _t = t.split(':');
                return new Date(_a[2], _a[1] - 1, _a[0], _t[0], _t[1], _t[2], 0);
            };
            //////////////////////            
        },
        error: function () {
            bars.ui.loader('body', false);
        }
    });

    kendoWindow.on('click', '.details-small-btn', function () {
        var mainGrid = $(gridSelector).data('kendoGrid');
        var row = $(this).closest("tr");
        var dataItem = mainGrid.dataItem(row);

        var trInTbodyArr = $(gridSelector).find("tr");
        if (trInTbodyArr.length <= 1) return;

        for (var i = 0; i < trInTbodyArr.length; i++) {
            $(trInTbodyArr[i]).removeClass('k-state-selected');
        }

        $(row).addClass('k-state-selected');

        showOneEditionDetails(dataItem, zpDealNumber);
    });

    kendoWindow.on('click', '.k-grouping-row', function (e) {
        var isCurrentExpanded = $(this).find('[aria-expanded="true"]').length;
        console.log(isCurrentExpanded);

        var a = $(gridSelector).find(".k-grouping-row");

        for (var i = 0; i < a.length; i++) {
            var cnt = $(a[i]).find('[aria-expanded="true"]').length;

            if (cnt > 0)
                $(a[i]).find('td > p > a').click();
        }

        if (isCurrentExpanded <= 0)
            $(this).find('.k-icon.k-i-expand').click();

        kendoWindow.data("kendoWindow").refresh();
    });

    kendoWindow.find("#btnCancel").click(function () {
        kendoWindow.data("kendoWindow").close();
    });

    function getTemplate() {
        return '<div id="dealChangeHistoriGrid" tabindex="-1"></div><br/>' + templateButtons();
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="105"><span class="k-icon k-cancel"></span>Закрити</a>'
            + '     </div>'
            + ' </div>'
            + '<div id="dialog"></div>';
    };
};

function showOneEditionDetails(details, zpId) {

    details.updatedFields = details.updatedFields.sort(function (a, b) {
        if (a.name == 'Стан договору') return -1;
        if (b.name == 'Стан договору') return 1;

        return 0;
    });

    var gridSelector = '#changeDetailsGrid';

    var changeDetailsWindow = $('<div />').kendoWindow({
        actions: ["Close"],
        title: 'ЗП договір № <b>' + zpId + '</b> - зміни від <b>' + details.upd_date + ' ' + details.upd_time + '</b>',
        resizable: false,
        modal: true,
        draggable: true,
        //width: "900px",
        width: "65%",
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'down', close: 'up' } }),
        deactivate: function () {
            this.destroy();
        },
        activate: function () {
            changeDetailsWindow.data("kendoWindow").refresh();
        },
        refresh: function () {
            this.center();
        }
    });

    var totalTemplate = getTemplate();

    var template = kendo.template(totalTemplate);

    changeDetailsWindow.data("kendoWindow").content(template({}));

    var gridOptions = {
        dataSource: {
            data: details.updatedFields
        },
        pageable: {
            info: false,
            refresh: false,
            pageSize: false,
            previousNext: false,
            numeric: false
        },
        scrollable: true,
        reorderable: false,
        resizable: false,
        sortable: false,
        filterable: false,
        columns: [
            { field: 'name', title: 'Параметр', width: '200px' },
            {
                title: 'Змінено значення',
                columns: [
                    { field: 'oldVal', title: 'З' },
                    { field: 'newVal', title: 'На' }
                ]
            }
        ],
        selectable: "row",
        editable: false,
        dataBound: function (e) {
            changeDetailsWindow.data("kendoWindow").refresh();
        }
    };

    changeDetailsWindow.find(gridSelector).kendoGrid(gridOptions);
    changeDetailsWindow.find('.k-pager-info.k-label').remove();

    changeDetailsWindow.data("kendoWindow").center().open();

    $("#changeDetailsGrid .k-grid-content").css("max-height", 500);

    changeDetailsWindow.find("#btnCancel").click(function () {
        changeDetailsWindow.data("kendoWindow").close();
    });

    function getTemplate() {
        return '<div id="changeDetailsGrid" tabindex="-1"></div><br/>' + templateButtons();
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="105"><span class="k-icon k-cancel"></span>Закрити</a>'
            + '     </div>'
            + ' </div>'
            + '<div id="dialog"></div>';
    };
};