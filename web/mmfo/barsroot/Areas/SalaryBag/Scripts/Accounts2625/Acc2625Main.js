///*** GLOBALS
var pageInitalCount = 25;
var gridSelector = "#Acc2625MainGrid";
var formOptions = {
    dealId: null,
    dealName: '',
    dealNumber: null
};
///***
function updateMainGrid() {
    var grid = $(gridSelector).data("kendoGrid");
    if (grid) {
        grid.dataSource.read();
        grid.refresh();
    }
}

function updateMainGrid() {
    var grid = $(gridSelector).data("kendoGrid");
    if (grid) {
        grid.dataSource.read();
        grid.refresh();
    }
}

function initMainGrid() {
    var dataSourceObj = {
        type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/Search2625Main"),
                data: {
                    dealId: formOptions.dealId
                },
                dataType: "json"
            }
        },
        pageSize: pageInitalCount,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    acc: { type: "number" },
                    rnk: { type: "number" },
                    id: { type: "number" },
                    okpo: { type: "string" },
                    nmk: { type: "string" },
                    nls: { type: "string" },
                    kv: { type: "number" },
                    code: { type: "string" },
                    name: { type: "string" },
                    ost: { type: "number" },
                    id_bpk_proect: { type: "number" },
                    status: { type: "string" }

                }
            }
        },
        requestEnd: function () {
            bars.ui.loader('body', false);
        },
        serverFiltering: true,
        serverPaging: true,
        serverSorting: true
    };

    var mainGridDataSource = new kendo.data.DataSource(dataSourceObj);

    var mainGridOptions = {
        dataSource: mainGridDataSource,
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSizes: [10, pageInitalCount, 50, 200, 1000, "All"],
            buttonCount: 5
        },
        reorderable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        columns: [
            //{ field: "acc", title: "Рахунок", width: "100px" },
            //{ field: "rnk", title: "РНК", width: "100px" },
            //{ field: "id", title: "ІД", width: "110px" },
            { field: "okpo", title: "ІПН", width: "100px" },
            { field: "nmk", title: "ФІО", width: "150px" },
            { field: "nls", title: "Номер рахунку", width: "150px" },
            { field: "kv", title: "Валюта", width: "65px" },
            { field: "code", title: "Код продукту", width: "150px" },
            { field: "name", title: "Назва карткового продукту", width: "250px" },            
            { field: "ost", title: "Фактичний залишок, &#8372", width: "110px", template: "<div style='text-align:right;'>#=convertToMoneyStr(ost)#</div>" },
            { field: "id_bpk_proect", title: "Ід ЗП проекту БПК", width: "100px" },
            { field: "status", title: "Статус", width: "100px", template: "<div>#=(status == 1 ) ? 'Діючий' : 'Заблокований'#</div>" }
        ],
        selectable: "row",
        editable: false,
        scrollable: true,
        filterable: true,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function () {
            $(".custom-btn").removeAttr('disabled');
        },
        change: function () {
            var data = this.dataItem(this.select());
            var status = +data.status;

            if (status == 0) {
                $('.custom-btn-lock').attr('disabled', 'disabled');
                $(".custom-btn-unlock").removeAttr('disabled');
            } else {
                $('.custom-btn-unlock').attr('disabled', 'disabled');
                $(".custom-btn-lock").removeAttr('disabled');
            }
        }
    };

    $(gridSelector).kendoGrid(mainGridOptions);
};

function addEventListenersToButtons() {
    $(".custom-btn-mirgate").on('click', function () {
        bars.ui.loader('body', true);
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/MigrateAcc"),
            data: {
                dealId: formOptions.dealId
            },
            success: function (data) {
                bars.ui.loader('body', false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    bars.ui.alert({ text: 'Дані по договору "' + formOptions.dealName + '" (№ <b>' + formOptions.dealNumber + '</b>) мігровано!' });
                    updateMainGrid();
                }
            }
        });
    });

    $(".custom-btn-delete-acc").on('click', function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        bars.ui.confirm({ text: "Ви впевнені, що хочете <u>видалити</u> рахунок <b>" + selectedItem.nls + "</b> ?" }, function () {
            setAccSos(selectedItem, -1);
        });
    });

    $(".custom-btn-lock").on('click', function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        bars.ui.confirm({ text: "Ви впевнені, що хочете <u>заблокувати</u> рахунок <b>" + selectedItem.nls + "</b> ?" }, function () {
            setAccSos(selectedItem, 0);
        });
    });

    $(".custom-btn-unlock").on('click', function () {
        var selectedItem = checkIfRowIsSelected();
        if (selectedItem == null) return;

        bars.ui.confirm({ text: "Ви впевнені, що хочете <u>розблокувати</u> рахунок <b>" + selectedItem.nls + "</b> ?" }, function () {
            setAccSos(selectedItem, 1);
        });
    });

    $(".custom-btn-back").on('click', function () {
        goToSomewhere('Index?formType=0');
    });
};

function setAccSos(selected, sos) {
    //Значения для sos : -1 - Видалити, 0 - Заблокувати, 1 - Розблокувати
    var msgWord = 'видалено';
    if (+sos === 0) msgWord = 'заблоковано';
    if (+sos === 1) msgWord = 'розблоковано';

    bars.ui.loader('body', true);
    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SetAccSos"),
        data: {
            acc: selected.acc,
            sos: sos
        },
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                showBarsErrorAlert(data.ErrorMsg);
            } else {
                bars.ui.alert({ text: 'Рахунок <b>' + selected.nls + '</b> ' + msgWord });
                updateMainGrid();
            }
        }
    });
};

function checkIfRowIsSelected() {
    var grid = $(gridSelector).data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select());
    if (selectedItem == null || selectedItem === undefined) {
        bars.ui.alert({ text: "Не вибрано жодного рядка." });
        return null;
    };
    return selectedItem;
};

function changeGridMaxHeight() {
    var a1 = $(".k-grid-content").height();
    var a2 = $(".k-grid-content").offset();
    var a3 = $(document).height();
    var a4 = a3 - a2.top;

    $(".k-grid-content").css("max-height", a4 * 0.9);
};

$(document).ready(function () {
    bars.ui.loader('body', true);

    formOptions.dealId = getUrlParameter("dealId");
    formOptions.dealNumber = getUrlParameter("number");
    formOptions.dealName = getUrlParameter("name");

    $("#title").html('Рахунки 2625 по договору "' + formOptions.dealName + '" (№ <b>' + formOptions.dealNumber + '</b>)');

    initMainGrid();
    changeGridMaxHeight();
    addEventListenersToButtons();
});