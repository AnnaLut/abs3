var EPC_TYPE_DESTROY = 1; // default block type
var KEY_CODE_ENTER = 13;
var record = 0;
var isGridInited = false;

function getSearchData(qv) {
    var searchDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 12,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/api/pfu/filesgrid/SearchDestroyedEpc?qv=" + toHex(JSON.stringify(qv)))
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    NAME_PENSIONER: { type: "string" },
                    TAX_REGISTRATION_NUMBER: { type: "string" },
                    NLS: { type: "string" },
                    EPP_NUMBER: { type: "string" },
                    EPP_EXPIRY_DATE: { type: "date" },
                    KILL_DATE: { type: "date" },
                    KILL_TYPE: { type: "number" }
                }
            }
        }
    });

    searchDataSource.fetch(function () {
        //var data = this.data();
        isGridInited = true;
    });

    var isRegional = getParam('regional');
    var _toolbar = null;
    if (isRegional == 'ru') {//Проверка на запуск из регионов
        _toolbar = kendo.template($("#destroyEpc-template").html())
    }

    var searchSettings = {
        autoBind: true,
        resizable: true,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true
        },
        toolbar: _toolbar,
        columns: [
            //{
            //    field: "block",
            //    title: " ",
            //    filterable: false,
            //    template: "<input type='checkbox' class='checkbox' style='margin-left: 26%;' />",
            //    width: 30
            //},
            {
                title: "№ п/п",
                template: "#= ++record #",
                width: 50
            },
            {
                field: "NAME_PENSIONER",
                title: "ПІБ Клієнта",
                width: 220,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "TAX_REGISTRATION_NUMBER",
                title: "ІПН Клієнта",
                width: 100
            },
            {
                field: "NLS",
                title: "Номер рахунка",
                width: 110
            },
            {
                field: "EPP_NUMBER",
                title: "Номер ЕПП",
                width: 120
            },
            {
                field: "EPP_EXPIRY_DATE",
                title: "Строк дії ЕПП",
                width: 110,
                template: "<div style='text-align:center;'>#=(EPP_EXPIRY_DATE == null) ? ' ' : kendo.toString(EPP_EXPIRY_DATE,'dd.MM.yyyy')#</div>"
            },
            {
                field: "KILL_DATE",
                title: "Дата знищення ЕПП",
                width: 110,
                template: "<div style='text-align:center;'>#=(KILL_DATE == null) ? ' ' : kendo.toString(KILL_DATE,'dd.MM.yyyy')#</div>"
            },
            {
                field: "KILL_TYPE",
                title: "Причина знищення",
                template: "#= getDDNameById(KILL_TYPE) #",
                width: 200
            }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataSource: searchDataSource,
        dataBinding: function() {
            record = (this.dataSource.page() -1) * this.dataSource.pageSize();
        },
        dataBound: function () {
            kendo.ui.progress($(".search-box"), false);
        },
        filterable: true
    };

    $("#gridSearchBox").kendoGrid(searchSettings);
}

//***** drop down for grid
var DropDownData = null;
// get list for DropDown
function GetDropDownData() {
    if (DropDownData == null) {
        var dataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/pfu/filesgrid/GetSignsEPC")
                }
            },
            schema: {
                data: "Data",
                model: {
                    fields: {
                        ID_TYPE: { type: "number" },
                        NAME: { type: "string" }
                    }
                }
            }
        });
        dataSource.fetch(function () {
            DropDownData = this.data();
        });
    }
}

function getDDNameById(value) {
    if (DropDownData != null) {
        for (var i = 0; i < DropDownData.length; i++) {
            if (parseInt(DropDownData[i].ID_TYPE) == parseInt(value)) {
                return DropDownData[i].NAME;
            }
        }
    }
    return "";      // bad case :(
}

// (fill data for dropdown )
function renderDropDown(container, options) {
    $('<input required  name="' + options.field + '"/>')
          .appendTo(container)
          .kendoDropDownList({
              dataTextField: "NAME",
              dataValueField: "ID_TYPE",
              dataSource: { data: DropDownData }
          });
}
//**************

function confirmDestroyEpc() {
    var query = [];
    var dataSource = $("#gridDestroyEpc").data("kendoGrid").dataSource;
    var data = dataSource.data();

    for (var i = 0; i < data.length; i++) {
        var item = data[i];
        var pensioner = { EPP_NUMBER: item.EPP_NUMBER, KILL_TYPE: item.KILL_TYPE };
        query.push(pensioner);
    }

    $.ajax({
        type: "POST",
        dataType: "json",
        data: JSON.stringify(query),
        contentType: 'application/json; charset=utf-8',
        url: bars.config.urlContent("/api/pfu/filesgrid/destroyEpc")
    }).done(function () {
        $('#dialogDestroyEpc').data('kendoWindow').close();
        $('#gridSearchBox').data('kendoGrid').dataSource.read();
        $('#gridSearchBox').data('kendoGrid').refresh();
    }).always(function () {
        $('#dialogDestroyEpc').data('kendoWindow').close();
    });
}

function buildUI2DestroyEpc() {
    if (isGridInited == false) { return; }       // fix for IE (Enter pressed...)

    var pensioners = [];
    var grid = $("#gridSearchBox").data("kendoGrid");
    var dataSource = grid.dataSource;    

    //grid.tbody.find("input:checked").closest("tr").each(function (index) {
    //    var uid = $(this).attr('data-uid');
    //    var item = dataSource.getByUid(uid);
    //    var pensioner = { id: item.id, nmk: item.nmk, ID_TYPE: EPC_TYPE_DESTROY };
    //    pensioners.push(pensioner);
    //});

    var selectedItem = grid.dataItem(grid.select());
    if (selectedItem != undefined) {
        var item = dataSource.getByUid(selectedItem.uid);
        if (item.KILL_TYPE != null) {
            bars.ui.error({ title: 'Помилка!', text: 'ЕПП вже знищено!' });
            return;
        }

        pensioners.push({ EPP_NUMBER: item.EPP_NUMBER, NAME_PENSIONER: item.NAME_PENSIONER, KILL_TYPE: EPC_TYPE_DESTROY });
    }

    if (pensioners.length == 0) {
        bars.ui.error({ title: 'Помилка!', text: 'Документи не відмічені!' });
        return;
    }

    var gridData = new kendo.data.DataSource({
        pageSize: 12,
        schema: {
            model: {
                fields: {
                    EPP_NUMBER: { type: "string" },
                    NAME_PENSIONER: { type: "string", editable: false },
                    KILL_TYPE: { type: "number" }
                }
            }
        },
        data: pensioners
    });

    var gridSettings = {
        columns: [
            {
                field: "NAME_PENSIONER",
                title: "ПІБ Клієнта",
                width: 220,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "KILL_TYPE",
                title: "Причина знищення",
                editor: renderDropDown,
                template: "#= getDDNameById(KILL_TYPE) #"
            }
        ],
        resizable: true,
        editable: true,
        dataSource: gridData
    };

    $('#gridDestroyEpc').kendoGrid(gridSettings);
    $('#dialogDestroyEpc').data('kendoWindow').center().open();
}

function SearchPensioners() {
    kendo.ui.progress($(".search-box"), true);
    var qv = {};
    qv.EPP_NUMBER = NullOrValue($("#searchEPC").val());
    qv.TAX_REGISTRATION_NUMBER = NullOrValue($("#searchInn").val());
    qv.NAME_PENSIONER = NullOrValue($("#searchName").val());
    qv.NLS = NullOrValue($("#searchNls").val());

    getSearchData(qv);
}

$(document).ready(function () {
    GetDropDownData();

    InitGridWindow({windowID: "#dialogDestroyEpc", srcSettings: {title: "Знищення ЕПП"}});

    $('#SearchPensioner').click(SearchPensioners);

    $('body').on('click', '#confirmDestroy', confirmDestroyEpc);
    $('body').on('click', '#destroyEpc', buildUI2DestroyEpc);    

    $(document.body).keydown(function (e) { if (e.keyCode == KEY_CODE_ENTER) {
        e.preventDefault(); // Stops IE from triggering the button to be clicked
        SearchPensioners();
    } });
});