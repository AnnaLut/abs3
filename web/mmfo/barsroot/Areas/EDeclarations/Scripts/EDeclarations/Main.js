///*** GLOBALS
var PAGE_INITIAL_COUNT = 10;
var PAGEABLE = {
    refresh: true,
    messages: {
        empty: "Дані відсутні",
        allPages: "Всі"
    },
    pageSizes: [PAGE_INITIAL_COUNT, 50, 200, 1000, "All"],
    buttonCount: 5
};
///***

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid) { grid.dataSource.fetch(); }
}

function initMainGrid() {
    Waiting(true);

    fillKendoGrid("#gridMain", {
        type: "webapi",
        //sort: [ { field: "ID", dir: "desc" } ],
        transport: { read: { url: bars.config.urlContent("/api/EDeclarations/EDeclarations/SearchMain") } },
        pageSize: PAGE_INITIAL_COUNT,
        schema: {
            model: {
                fields: {
                    ID: { type: 'string' },
                    OKPO: { type: 'string' },
                    BIRTH_DATE: { type: 'date' },
                    DOC_TYPE: { type: 'number' },
                    DOC_SERIAL: { type: 'string' },
                    DOC_NUMBER: { type: 'string' },
                    DATE_FROM: { type: 'date' },
                    DATE_TO: { type: 'date' },
                    CUST_NAME: { type: 'string' },
					STATE: { type: 'number' },
                    C_STATE: { type: 'string' },
                    CRT_DATE: { type: 'date' },
                    DECL_ID: { type: 'number' },
                    DONEBY_FIO: { typy: 'string' },
                    BRANCH: { type: 'string' }
                }
            }
        }
    }, {
            toolbar: [{ text: "", template: kendo.template($("#grid_toolbar").html()) }],
            pageable: PAGEABLE,
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
            reorderable: true,
            change: function () {
                var grid = this;
                var row = grid.dataItem(grid.select());
            },
            columns: [
                {
                    field: 'DECL_ID',
                    title: 'Номер декларації',
                    width: '10%'
                },
                {
                    field: "OKPO",
                    title: "ІПН",
                    width: "10%"
                },
                {
                    field: "CUST_NAME",
                    title: "ПІБ Клієнта",
                    width: "10%"
                },
                {
                    field: 'DONEBY_FIO',
                    title: 'ПІБ Виконавця',
                    width: '10%'
                },
                {
                    field: "C_STATE",
                    title: "Статус запиту",
                    width: "10%"
                },
                {
                    field: "STATE",
                    hidden: true,
                },
                {
                    template: "<div style='text-align:center;'>#=(CRT_DATE == null) ? ' ' : kendo.toString(CRT_DATE,'dd.MM.yyyy HH:mm:ss')#</div>",
                    field: "CRT_DATE",
                    title: "Дата створення",
                    width: "10%"
                },
                {
                    field: 'BRANCH',
                    title: 'Відділення',
                    width: '10%'
                },
                {
                    template: "<div style='text-align:center;'>#=getButtonOrInfo(DECL_ID, STATE)#</div>",
                    field: "DECL_ID",
                    title: "Завантаження декларації",
                    width: "10%"
                },
                {
                    field: "ID",
                    title: "ID запиту",
                    width: "6%"
                }
                //,
                //{
                //    template: "<div style='text-align:center;'>#=(BIRTH_DATE == null) ? ' ' : kendo.toString(BIRTH_DATE,'dd.MM.yyyy')#</div>",
                //    field: "BIRTH_DATE",
                //    title: "BIRTH_DATE",
                //    width: "10%"
                //},
                //{
                //    field: "DOC_TYPE",
                //    title: "DOC_TYPE",
                //    width: "10%"
                //},
                //{
                //    field: "DOC_SERIAL",
                //    title: "DOC_SERIAL",
                //    width: "10%"
                //},
                //{
                //    field: "DOC_NUMBER",
                //    title: "DOC_NUMBER",
                //    width: "10%"
                //},
                //{
                //    template: "<div style='text-align:center;'>#=(DATE_FROM == null) ? ' ' : kendo.toString(DATE_FROM,'dd.MM.yyyy')#</div>",
                //    field: "DATE_FROM",
                //    title: "DATE_FROM",
                //    width: "10%"
                //},
                //{
                //    template: "<div style='text-align:center;'>#=(DATE_TO == null) ? ' ' : kendo.toString(DATE_TO,'dd.MM.yyyy')#</div>",
                //    field: "DATE_TO",
                //    title: "DATE_TO",
                //    width: "10%"
                //}
            ],
            dataBound: function (e) {
                Waiting(false);
                var grid = this;
                var gridData = grid.dataSource.view();
                for (var i = 0; i < gridData.length; i++) {
                    if (gridData[i].STATE === 3) {
                        grid.table.find("tr[data-uid='" + gridData[i].uid + "']").addClass("row-pink");
                    }
                }
            }
        }, null, null);
    $("#addDeclaration").click(openCreationWindow);
}

function openCreationWindow (e) {

    $("#windowContainer").append("<div id='createWindow'></div>");

    var createWindow = $("#createWindow").kendoWindow({
        width: "710px",//"680px",
        height: "457px", //"500px",
        title: "Створення",
        visible: false,
        actions: ["Close"],
        iframe: true,
        modal: true,
        resizable: false,
        deactivate: function () {
            this.destroy();
            //var grid = $("#gridMain").data("kendoGrid");
            //grid.dataSource.read();
            //grid.refresh();
        },
        content: bars.config.urlContent("/edeclarations/edeclarations/create")
    }).data("kendoWindow");

    createWindow.center().open();
}

function createResultWindow(e) {
    $("#windowContainer").append("<div id='creatClientsWindow'></div>");

    var createWindow = $("#creatClientsWindow").kendoWindow({
        width: "680px",
        height: "320px", //"420px",
        title: "Результати пошуку",
        visible: false,
        actions: ["Close"],
        iframe: true,
        modal: true,
        resizable: false,
        deactivate: function () {
            this.destroy();
            var grid = $("#gridMain").data("kendoGrid");
            grid.dataSource.read();
            grid.refresh();
        },
        content: bars.config.urlContent("/edeclarations/edeclarations/clients?req=") + e,
    }).data("kendoWindow");

    createWindow.center().open();
}

$(document).ready(function () {
    $("#title").html("Електронні Декларації");

    initMainGrid();
});

function SearchDeclaration() {
    var num = $('#search-edecl').val();
    var regex = new RegExp('[0-9]{1,}$');
    if (!regex.test(num))
    {
        bars.ui.error({
            text: 'Введіть номер декларації',
            title: 'Тільки числове значення'
        });
        return;
    }
    else if (num.length < 1) {
        bars.ui.error({
            text: 'Введіть данні для пошуку',
            title: 'Жодних данних не було введено'
        });
        return;
    }
    $("<div class='k-overlay'></div>").appendTo($(document.body));
    $.post('/barsroot/api/edeclarations/edeclarations/CreateSearch/' + num,
        function (response) {            
            bars.ui.alert({
                text: response
            });
        }
    ).always(function () {
        $('.k-overlay').remove();
    })
}

function getButtonOrInfo(decl_id, state) {
    if (decl_id !== null && state == 1)
        return '<a class="k-button k-primary" onclick="downloadFile(' + decl_id + ')">Завантажити</a>';
    //return '<a class="k-button k-primary" onclick="downloadFile(1234567)">Завантажити</a>';
    return '';
}

function downloadFile(id) {
    $("<div class='k-overlay'></div>").appendTo($(document.body));
    //$.ajax({
    window.location = '/barsroot/edeclarations/edeclarations/downloaddeclaration/' + id;
    $('.k-overlay').remove();
    //    type: 'post',
    //    success: function (e) {
    //        window.location = e;
    //        $('.k-overlay').remove();
    //    },
    //    error: function (err) {
    //        $('.k-overlay').remove();
    //        //window.parent.$('.k-overlay').css('z-index', '10002');
    //        //bars.ui.error({
    //        //    text: 'Виникла помилка',
    //        //    close: function (err) {

    //        //    }
    //        //})
    //    }
    //});
    //window.location = '/barsroot/edeclarations/edeclarations/downloaddeclaration/' + id;
 }
