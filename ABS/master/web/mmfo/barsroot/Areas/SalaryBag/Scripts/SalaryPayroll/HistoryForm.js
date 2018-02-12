function historyForm(zpDealId, payrollId, isView, func) {
    func = func || function () { };
    var gridSelector = '#historySearchModalGrid';

    var kendoWindow = $('<div />').kendoWindow({
        actions: ["Close"],
        title: 'Перегляд історії ЗП відомостей',
        resizable: false,
        modal: true,
        draggable: true,
        //width: "900px",
        width: "70%",
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'left', close: 'right' } }),
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        close: function () {
            func();
        },
        activate: function () {
            kendoWindow.find(gridSelector).kendoGrid(gridOptions).end();
            //kendoWindow.find(':input:enabled:visible:first').focus();
            kendoWindow.data("kendoWindow").refresh();
        },
        refresh: function () {
            this.center();
        }
    });

    var totalTemplate = getTemplate();

    var template = kendo.template(totalTemplate);

    kendoWindow.data("kendoWindow").content(template({}));

    var pageInitalCount = 10;

    var dataSourceObj = {
        requestStart: function () {
            kendo.ui.progress(kendoWindow, true);
        },
        requestEnd: function () {
            kendo.ui.progress(kendoWindow, false);
        },
        type: "webapi",
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SearchPayrollHistory"),
                dataType: "json",
                data: {
                    zpDealId: zpDealId
                }
            }
        },
        pageSize: pageInitalCount,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    id: { type: "number" },
                    pr_date: { type: "date" },
                    deal_name: { type: "string" },
                    cnt: { type: "number" },
                    s: { type: "number" },
                    cms: { type: "number" },
                    src_name: { type: "string" },
                    payroll_num: { type: "string" }
                }
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        dataSource: gridDataSource,
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            buttonCount: 5,
            pageSizes: [pageInitalCount, 25, 50, "All"]
        },
        reorderable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        filterable: true,
        columns: [
            { field: "payroll_num", title: "№", width: "80px" },
            { field: "pr_date", title: "Дата відомості", width: "125px", template: "<div style='text-align:center;'>#=(pr_date == null) ? ' ' : kendo.toString(pr_date,'dd.MM.yyyy')#</div>" },
            { field: "deal_name", title: "Назва ЗП договору", width: "200px" },
            { field: "cnt", title: "Кількість", width: "100px", sortable: false },
            { field: "s", title: "Загальна сума, &#8372;", width: "150px", template: "<div style='text-align:right;'>#= convertToMoneyStr(s)#</div>" },
            { field: "cms", title: "Сума комісії, &#8372;", width: "150px", template: "<div style='text-align:right;'>#= convertToMoneyStr(cms)#</div>" },
            { field: "src_name", title: "Джерело", width: "150px", sortable: false }
        ],
        selectable: "row",
        editable: false,
        scrollable: false,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function () {
            kendoWindow.data("kendoWindow").refresh();
        }
    };

    //kendoWindow.find(gridSelector).kendoGrid(gridOptions).end();

    kendoWindow.find("#btnCancel").click(function () {
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find("#btnClone").click(function () {
        var grid = $(gridSelector).data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null || selectedItem === undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };

        bars.ui.confirm(
            {
                text: 'Копіювати документи відомості від "<b>' + kendo.toString(selectedItem.pr_date, 'dd.MM.yyyy') + '</b>" в поточну ?'
            },
            function () {
                sendCloneRequest(selectedItem);
            });

    }).end();

    $('#historySearchModalGrid').on('dblclick', 'tr:not(:first)', dblClickEventHandler);

    kendoWindow.data("kendoWindow").center().open();
    if (isView) {
        kendoWindow.find('#btnClone').remove();
    }
    bars.ui.loader(kendoWindow, true);

    function sendCloneRequest(selectedItem) {
        bars.ui.loader(kendoWindow, true);

        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/ClonePayrollDocuments"),
            data: {
                idFrom: +selectedItem.id,
                idTo: +payrollId
            },
            success: function (data) {
                bars.ui.loader(kendoWindow, false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    bars.ui.alert({ text: 'Копіювання даних пройшло успішно.' });
                    kendoWindow.data("kendoWindow").close();
                }
            }
        });
    };

    function dblClickEventHandler() {
        var grid = $('#historySearchModalGrid').data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null || selectedItem === undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };

        showPayrollDetails(selectedItem);
    };

    function getTemplate() {
        return '<div id="historySearchModalGrid" tabindex="-1"></div><label>Подвійне натискання лівою кнопкою миші по рядку відкриє на перегляд деталі відомості</label><br/>' + templateButtons();
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="105"><span class="k-icon k-cancel"></span>Закрити</a>'
            + '         <a id="btnClone" class="k-button k-button-icontext k-primary k-grid-update modal-buttons-left" tabindex="104"> Клонувати документи </a>'
            + '     </div>'
            + ' </div>'
            + '<div id="dialog"></div>';
    };

    function showPayrollDetails(selected) {
        var info = {
            formType: 0,
            mode: 3,
            dealId: zpDealId,
            payRollId: selected.id,
            payrollNumber: selected.payroll_num,
            modalView: true,
            sos: 5
        };

        var strInfo = encodeURI(JSON.stringify(info));
        var url = encodeURI('/barsroot/SalaryBag/SalaryBag/Salarypayroll?cfg=' + strInfo);

        var dH = $(document).height();
        var dW = $(document).width();

        var historyDetailsWindow = $('<div id="historyWindow_1"/>').kendoWindow({
            iframe: true,
            content: url,
            width: dW * 0.9,
            height: dH * 0.9,
            actions: ["Close"],
            title: 'Перегляд відомості',
            animation: getAnimationForKWindow({ animationType: { open: 'left', close: 'right' } }),
            deactivate: function () {
                this.destroy();
            }
        });
        historyDetailsWindow.data("kendoWindow").center().open();
    };
};