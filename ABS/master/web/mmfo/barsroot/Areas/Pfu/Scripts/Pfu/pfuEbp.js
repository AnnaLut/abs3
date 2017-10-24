var BLOCK_TYPE = 4; // default block type
var KEY_CODE_ENTER = 13;
var isGridInited = false;

function docTypes(res) {
    if (res.items !== undefined) {
        for (var i = 0; i < res.items.length; i++) {
            var docVal = "";
            switch (res.items[i].passp) {
                case 1:
                    docVal = "Паспорт";
                    break;
                case 2:
                    docVal = "Військовий квиток";
                    break;
                case 3:
                    docVal = "Свідоцтво про  народження";
                    break;
                case 4:
                    docVal = "Пенсійне посвідчення";
                    break;
                case 5:
                    docVal = "Тимчасова посвідка";
                    break;
                case 6:
                    docVal = "Пропуск";
                    break;
                case 7:
                    docVal = "Посвідчення";
                    break;
                case 11:
                    docVal = "Закордонний паспорт гр.України";
                    break;
                case 12:
                    docVal = "Дипломатичний паспорт гр.України";
                    break;
                case 13:
                    docVal = "Паспорт нерезидента";
                    break;
                case 14:
                    docVal = "Паспорт моряка";
                    break;
                case 15:
                    docVal = "Тимчасове посвідчення особи";
                    break;
                case 16:
                    docVal = "Посвідчення біженця";
                    break;
                case 99:
                case -1:
                default:
                    docVal = "Інший документ";
            }

            res.items[i].passp = docVal;
        }
    }
}

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
                url: bars.config.urlContent("/api/pfu/filesgrid/searchpensioner?qv=" + toHex(JSON.stringify(qv)))
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    nmk: { type: "string"},
                    bday: { type: "date"},
                    okpo: { type: "string"},
                    passp: { type: "number"},
                    ser: { type: "string"},
                    numdoc: { type: "string"},
                    type_pensioner: { type: "number"},
                    nls: { type: "string"},
                    daos: { type: "date"},
                    cellphone: { type: "string"},
                    kf: { type: "string"},
                    block_type: { type: "number"},
                    block_date: { type: "date"},
                    comm: { type: "string" },
                    is_okpo_well: { type: "number" }
                }
            }
        }
    });

    var isRegional = getParam('regional');
    var _toolbar = null;
    if(isRegional != 'ru') {//Проверка на запуск из регионов
        _toolbar = kendo.template($("#blockPensioner-template").html())
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
        excel: {
            fileName: "Повідомлення про смерть пенсіонерів.xlsx",
            allPages: true,
            filterable: true,
            proxyURL: bars.config.urlContent("/pfu/pfu/ConvertBase64ToFile/")
        },
        columns: [
            {
                field: "block",
                title: " ",
                filterable: false,
                sortable: false,
                template: "<input type='checkbox' class='checkbox' style='margin-left: 26%;' />",
                width: 30
            },
            {
                field: "nmk",
                title: "ПІБ Клієнта",
                width: 220,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "bday",
                title: "Дата<br>народження",
                width: 95,
                template: "<div style='text-align:center;'>#=kendo.toString(bday,'dd.MM.yyyy')#</div>"
            },
            {
                field: "okpo",
                title: "ІПН<br>Клієнта",
                width: 90
            },
            {
                field: "is_okpo_well",
                title: "Результати <br>перевірки ІПН",
                template: "#= getIPN(is_okpo_well) #",
                width: 90
            },
            {
                field: "passp",
                title: "Тип<br>документа",
                width: 90
            },
            {
                field: "ser",
                title: "Серія",
                width: 65
            },
            {
                field: "numdoc",
                title: "Номер",
                width: 70
            },
            {
                field: "type_pensioner",
                title: "Тип<br>клієнта",
                template: "#= getTypePensioner(type_pensioner) #",
                width: 75
            },
            {
                field: "nls",
                title: "Номер<br>рахунка",
                width: 100
            },
            {
                field: "daos",
                title: "Дата<br>відкриття",
                width: 90,
                template: "<div style='text-align:center;'>#=(daos == null) ? ' ' : kendo.toString(daos,'dd.MM.yyyy')#</div>"
            },
            {
                field: "cellphone",
                title: "Моб.тел",
                width: 90
            },
            {
                field: "kf",
                title: "МФО",
                width: 60
            },
            {                
                field: "block_type",
                title: "Тип<br>блокування",
                width: 95,                
                template: "#= getBlockName(block_type) #"
            },
            {
                field: "block_date",
                title: "Дата<br>блокування",
                width: 95,
                template: "<div style='text-align:center;'>#=(block_date == null) ? ' ' : kendo.toString(block_date,'dd.MM.yyyy')#</div>"
            },
            {
                field: "comm",
                title: "Коментар",
                width: 100
            }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataSource: searchDataSource,        
        dataBinding: docTypes,        
        dataBound: function () {
            isGridInited = true;
            kendo.ui.progress($(".search-box"), false);
        },
        filterable: true
    };

    $("#gridSearchBox").kendoGrid(searchSettings);
}

uploadErrorRowsExcel = function () {
    kendo.ui.progress($(".search-box"), true);
    var datsource = $("#gridSearchBox").data("kendoGrid").dataSource;
    var filter = datsource.filter();
    var sort = datsource.sort();
    var dataSourceRequest = "";
    var qv = {};
    qv.Kf = NullOrValue($("#searchKf").val());
    qv.ipn = NullOrValue($("#erroIPN").val());
    qv.Okpo = NullOrValue($("#searchInn").val());
    qv.Nmk = NullOrValue($("#searchName").val());
    qv.Nls = NullOrValue($("#searchNls").val());
    if (sort && sort.length != 0) {
        dataSourceRequest = dataSourceRequest + "?sort=" + sort[0].field + "-" + sort[0].dir;
    }
    else
        dataSourceRequest = dataSourceRequest + "?sort=";
    if (filter && filter != null) {
        dataSourceRequest = dataSourceRequest + "&filter=";
        for (var i = 0; i < filter.filters.length; i++) {
            if (filter.filters[i].filters) {
                dataSourceRequest = dataSourceRequest + "(" + filter.filters[i].filters[0].field + "~" + filter.filters[i].filters[0].operator + "~" + "'" + filter.filters[i].filters[0].value + "'";
                dataSourceRequest = dataSourceRequest + "~" + filter.filters[i].logic + "~";
                dataSourceRequest = dataSourceRequest + filter.filters[i].filters[1].field + "~" + filter.filters[i].filters[1].operator + "~" + "'" + filter.filters[i].filters[1].value + "'" + ")";
            }
            else {
                dataSourceRequest = dataSourceRequest + filter.filters[i].field + "~" + filter.filters[i].operator + "~" + "'" + filter.filters[i].value + "'";
            }
            if (i + 1 < filter.filters.length) {
                dataSourceRequest = dataSourceRequest + "~and~";
            }
        }

    }
    else
        dataSourceRequest = dataSourceRequest + "&filter=";

    var url = bars.config.urlContent('/pfu/pfu/GetEBPRowsFile/') + dataSourceRequest + '&qv=' + toHex(JSON.stringify(qv));
    document.location.href = url;
    kendo.ui.progress($(".search-box"), false);
    return false;
}

//***** drop down for grid
function getTypePensioner(value) {
    if(value == 1){
        return "Військовий пенсіонер";      // todo: get from DB
    }
    return "";
}
function getIPN(value) {
    if (value == 1) {
        return "з помилками";      // todo: get from DB
    }
    if (value == 0) {
        return "без помилок";
    }
    return "";
}

var DropDownData = null;        // global variable: list for all block types
function getBlockName(value) {
    return getNameById(value, DropDownData, 'block_type', 'BlockName');
}

// get list for all block types (dropdown 'Тип блокування')
function GetDropDownData() {
    if (DropDownData == null) {
        var dataSource = CreateKendoDataSource({
            transport: {read:{url: bars.config.urlContent("/api/pfu/filesgrid/blocktypes")}},
            schema: {model: {fields: {block_type: { type: "number" }, BlockName: { type: "string" }}}}
        });
        dataSource.fetch(function () {
            DropDownData = this.data();
        });
    }
}

function SaveExcel() {
    $("#gridSearchBox").getKendoGrid().saveAsExcel();

}
// (fill data for dropdown 'Тип блокування')
function renderDropDown(container, options) {
    $('<input required  name="' + options.field + '"/>')
          .appendTo(container)
          .kendoDropDownList({
              dataTextField: "BlockName",
              dataValueField: "block_type",
              dataSource: { data: DropDownData }
          });
}
//**************

function confirmBlockPensioners() {
    confirmGridWindow({
        windowGridID: "#gridBlockPensioners",
        windowID: '#dialogBlockPensioners',
        srcGridID: '#gridSearchBox',
        srcSettings: {url: bars.config.urlContent("/api/pfu/filesgrid/blockpensioner")},
        grabData: [{key:"id"}, {key:"comment"}, {key:"block_type"}]
    });
}

function buildUI2BlockPensioners() {

    if (isGridInited == false) { return;}       // fix for IE (Enter pressed...)

    var pensioners = [];
    var grid = $("#gridSearchBox").data("kendoGrid");
    var dataSource = grid.dataSource;

    grid.tbody.find("input:checked").closest("tr").each(function (index) {
        var uid = $(this).attr('data-uid');
        var item = dataSource.getByUid(uid);
        var pensioner = { id: item.id, nmk: item.nmk, block_type: BLOCK_TYPE };
        pensioners.push(pensioner);
    });    

    if (pensioners.length == 0) {
        bars.ui.error({ title: 'Помилка!', text: 'Документи не відмічені!' });
        return;
    }

    var blockGridData = new kendo.data.DataSource({
        pageSize: 12,
        schema: {
            model: {
                fields: {
                    id: { type: "number" },
                    nmk: { type: "string", editable: false },
                    comment: { type: "string" },
                    block_type: { type: "number"}
                }
            }
        },
        data: pensioners
    });

    var blockGridSettings = {
        columns: [
            {
                field: "nmk",
                title: "ПІБ Клієнта",
                width: 220,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "comment",
                title: "Коментар"
            },
            {                
                field: "block_type",                
                title: "Тип блокування",
                editor: renderDropDown,
                template: "#= getBlockName(block_type) #"
            }
        ],        
        resizable: true,
        editable: true,
        dataSource: blockGridData
    };

    $('#gridBlockPensioners').kendoGrid(blockGridSettings);
    $('#dialogBlockPensioners').data('kendoWindow').center().open();
}

function SearchPensioners() {
    kendo.ui.progress($(".search-box"), true);
    var qv = {};
    qv.Kf = NullOrValue($("#searchKf").val());
    qv.ipn = NullOrValue($("#erroIPN").val());
    //qv.Ser = NullOrValue($("#searchSer").val());
    //qv.NumDoc = NullOrValue($("#searchNumber").val());
    qv.Okpo = NullOrValue($("#searchInn").val());
    qv.Nmk = NullOrValue($("#searchName").val());
    qv.Nls = NullOrValue($("#searchNls").val());

    //Passp
    getSearchData(qv);
}
function FillIPNDropDown() {
    $("#erroIPN").kendoDropDownList({
        dataSource: {
            data: ["Всі", "Так", "Ні"]
        }
    });
}
$(document).ready(function () {

    GetDropDownData();
    FillIPNDropDown();
    InitGridWindow({windowID: "#dialogBlockPensioners", srcSettings: {title: "Блокування пенсіонерів"}});

    $('#SearchPensioner').click(SearchPensioners);

    $('body').on('click', '#confirmBlock', confirmBlockPensioners);
    $('body').on('click', '#blockPensioner', buildUI2BlockPensioners);//
    $('body').on('click', '#excel', uploadErrorRowsExcel);

    $(document.body).keydown(function (e) { if (e.keyCode == KEY_CODE_ENTER) {
        e.preventDefault(); // Stops IE from triggering the button to be clicked
        SearchPensioners();
    } });

});