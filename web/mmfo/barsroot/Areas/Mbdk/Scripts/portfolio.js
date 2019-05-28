var fin_list = [];
var obs23_list = [];
var kat23_list = [];
var kv_list = [];
var edit_uid = "";
var wrapper; 
var header;
$(document).ready(function () {
    var preventCloseOnSave = false;
    var grid = $("#gridPortfolio").kendoGrid({
        toolbar: [
            { name: "btAdd", type: "button", text: "<span class='pf-icon pf-16 pf-add_button'></span> Додати" },
            { name: "btEdit", type: "button", text: "<span class='pf-icon pf-16 pf-gears'></span> Редагувати" },
            { name: "btDelete", type: "button", text: "<span class='pf-icon pf-16 pf-delete'></span> Видалити" },
            { name: "btVKR", type: "button", text: "<span class='pf-icon pf-16 pf-gears'></span> Редагування ВКР" },
            { name: "btPRVNIX", type: "button", text: "<span class='pf-icon pf-16 pf-accept_doc'></span> Дод. параметри МСФЗ9" },
            { name: "btDefault", type: "button", text: "<span class='pf-icon pf-16 pf-info'></span> Ознака події дефолту (пост. 351)" },
            { name: "btToExcel", type: "button", text: "<span class='pf-icon pf-16 pf-exel'></span> Експорт в MS Excel" }
        ],
        filterable: true,
        resizable: true,
        selectable: true,
        sortable: true,
        scrollable: true,
        selectable: "row",
        navigatable: true,
        editable: {
            mode: "popup",
            template: kendo.template($("#popup-editor").html()),
            update: true
        },  
        pageable: {
            refresh: true,
            pageSize: 25,
            pageSizes: [25, 50, 100, 200]
        },
        columns: [
        {
            title: "Реф Суб.угоди\n1 РАХУНОК",
            width: 105,
            nullable: true,
            field: "NDI",
            template: "<a href='/barsroot/customerlist/custacc.aspx?type=3&nd=${NDI}' onclick='window.open(this.href); return false;'>${NDI}</a>"
        },
         {
             title: "Реф УГОДИ\nм/в РАХУНОК ",
             width: 100,
             field: "ND",
             template: "<a href='/barsroot/customerlist/custacc.aspx?type=3&nd=${ND}' onclick='window.open(this.href); return false;'>${ND}</a>",
         },
          {
              title: "РНК",
              width: 80,
              nullable: true,
              field: "RNK",
              template: "<a href='/barsroot/clientregister/registration.aspx?readonly=0&rnk=${RNK}' onclick='window.open(this.href); return false;'>${RNK}</a>"
          },
          {
              title: "Найм. контрагента",
              width: 150,
              nullable: true,
              field: "NMK"
          },
          {
              title: "Вал",
              width: 40,
              nullable: true,
              field: "KV"
          },
          {
              title: "Назва Вал",
              width: 150,
              nullable: true,
              field: "KV_NAME"
          },
         {
             title: "Рахунок\nКартка",
             width: 120,
             nullable: true,
             field: "NLS",
             template: "<a href='/barsroot/viewaccounts/accountform.aspx?type=2&acc=${ACC}&rnk=${RNK}&accessmode=1' onclick='window.open(this.href); return false;'>${NLS}</a>"
         },
          {
              title: "МФО",
              width: 65,
              nullable: true,
              field: "MFO"
          },
          {
              title: "BIC",
              width: 120,
              nullable: true,
              field: "BIC",
              template: "<a onclick=' window.open(BicUrl(${ND})); return false;'>${BIC}</a>"
          },
          {
              title: "№ угоди\n(BIC,VOSTRO)",
              width: 120,
              nullable: true,
              field: "CC_ID"
          },
          {
              title: "Дата почат дії",
              width: 90,
              field: "SDATE",
              nullable: true,
              format: "{0:dd.MM.yyyy}"
          },
          {
              title: "Дата завер дії",
              width: 90,
              field: "WDATE",
              nullable: true,
              format: "{0:dd.MM.yyyy}"
            },
            {
                title: "Номер договору",
                width: 120,
                nullable: true,
                field: "NKD"
            },
            {
                title: "Дата договору",
                width: 90,
                field: "DKD",
                nullable: true
            },
           {
               title: "Клас боржника\n(пост.351)",
               width: 80,
               nullable: true,
               field: "FIN_351"
           },
           {
               title: "PD",
               width: 65,
               nullable: true,
               field: "PD"
           },
           {
               title: "Ліміт\nовер",
               width: 120,
               nullable: true,
               field: "LIMIT",
               format: "{0:n}"
           },
           //{
           //    title: "Фін\nстан",
           //    width: 60,
           //    nullable: true,
           //    field: "FIN23"
           //},
           {
               title: "Фін\nстан",
               width: 60,
               nullable: true,
               field: "FIN_NAME",
               //  filterable: { extra: false, ui: FinFilter, operators: { string: { eq: "Дорівнює", neq: "Не дорівнює" } } }
               filterable: {
                   extra: false,
                   ui: function (element) { SetDataSourceFilter(element, fin_list); },
                   operators: { string: { eq: "Дорівнює", neq: "Не дорівнює" } }
               }
           },
           //{
           //    title: "Фін\nстан",
           //    width: 60,
           //    nullable: true,
           //    field: "OBS23"
           //},
           {
               title: "Обсл\nборг",
               width: 86,
               nullable: true,
               field: "OBS_NAME",
               filterable: {
                   extra: false,
                   ui: function (element) { SetDataSourceFilter(element, obs23_list); },
                   operators: { string: { eq: "Дорівнює", neq: "Не дорівнює" } }
               }
           },
           //{
           //    title: "Кат\nриз",
           //    width: 60,
           //    nullable: true,
           //    field: "KAT23"
           //},
           {
               title: "Кат\nриз.",
               width: 100,
               nullable: true,
               field: "KAT_NAME",
               filterable: {
                   extra: false,
                   ui: function (element) { SetDataSourceFilter(element, kat23_list); },
                   operators: { string: { eq: "Дорівнює", neq: "Не дорівнює" } }
               }
           },
           {
               title: "Коєф.\nпоказн.\nриз.",
               width: 60,
               nullable: true,
               field: "K23"
           },
           {
               title: "Стан",
               width: 60,
               nullable: true,
               field: "SOS"
           },
           {
               title: "IR",
               width: 50,
               nullable: true,
               field: "IR"
           },
           {
               title: "SDOG",
               width: 86,
               nullable: true,
               field: "SDOG"
           },
           {
               title: "Бранч",
               width: 120,
               nullable: true,
               field: "BRANCH"
           },
           {
               title: "Код\nпрод",
               width: 80,
               nullable: true,
               field: "PROD"
           }       
        ],
        dataBound: function (e) {
            wrapper = this.wrapper,
            header = wrapper.find(".k-grid-toolbar");
            $(window).scroll(scrollFixed);
            DisabledButtons();

            var grid = this;
            grid.items().each(function () {
                if (grid.dataItem(this).ND == edit_uid) 
                    grid.select(this);
            });
        },
        change: function (e) {

            DisabledButtons();
        },
        edit: function (e) {
            var editWindow = this.editable.element.data("kendoWindow");
            editWindow.wrapper.css({ width: 450 });


            if (e.model.isNew()) {
                $(".edit_nostro").hide();
                $(".edit_field").attr("required", false);
                $(".new_nostro").show();
                $(".new_field").attr("required", true);

                $('.k-window-title').text("Додавання:");
                $(e.container).parent().find(".k-grid-update").html('<span class="k-icon k-update"></span>Додати');
                $("#KV").kendoDropDownList({ dataSource: kv_list, dataTextField: "Value", dataValueField: "Key", filter: "contains" });
                $("#KV").data("kendoDropDownList").value(980);
            }
            else {
                edit_uid = this.dataItem(this.select()).ND;
                $(".new_nostro").hide();
                $(".new_field").attr("required", false);
                $(".edit_nostro").show();
                $(".edit_field").attr("required", true);

                editWindow.bind("close", onWindowEditClose);
                $('.k-window-title').text("Редагування:");
                $(e.container).parent().find(".k-grid-update").html('<span class="k-icon k-update"></span>Редагувати');
                $("#SDATE").kendoDatePicker({ format: "dd.MM.yyyy", culture: "en-GB" });
                $("#WDATE").kendoDatePicker({ format: "dd.MM.yyyy", culture: "en-GB" });
                $("#FIN23").kendoDropDownList({ dataSource: fin_list, dataTextField: "Value", dataValueField: "Key" });
                $("#FIN23").data("kendoDropDownList").value(e.model.FIN23);

                $("#OBS23").kendoDropDownList({ dataSource: obs23_list, dataTextField: "Value", dataValueField: "Key" });
                $("#OBS23").data("kendoDropDownList").value(e.model.OBS23);

                $("#KAT23").kendoDropDownList({ dataSource: kat23_list, dataTextField: "Value", dataValueField: "Key" });
                $("#KAT23").data("kendoDropDownList").value(e.model.KAT23);

                $("#ND").kendoNumericTextBox({ spinners: false, format: "#" });
                $("#LIMIT").kendoNumericTextBox({ spinners: false, format: "#" });
                $("#SOS").kendoNumericTextBox({ spinners: false, format: "#" });
                $("#FIN_351").kendoNumericTextBox({ spinners: false, format: "#" });
            }
        },
        save: function(e) {
            if (e.model.isNew()) {
                var new_data = {
                    KV: $("#KV").data("kendoDropDownList").value(),
                    NLS: $("#NLS").val()
                };

                var nbs_loro = ["1600", "1602", "1608"];
                if (nbs_loro.indexOf(new_data.NLS.substring(0,4)) !== -1) {
                    bars.ui.error({ text: "Заборонено зберігати ЛОРО-рахунки: " + nbs_loro.join(" , ")});
                    e.preventDefault();
                    return;
                }
                
                QueryFactory('InsertNostro', JSON.stringify(new_data), "Успішно створена угода з рахунком <b>" + $("#NLS").val() + "</b>", true, '.k-edit-form-container');
            }
            else {
                preventCloseOnSave = true;
                var update_data = {
                    ND: e.model.ND,
                    CC_ID: e.model.CC_ID,
                    SDATE: $("#SDATE").data("kendoDatePicker").value(),
                    WDATE: $("#WDATE").data("kendoDatePicker").value(),
                    LIMIT: e.model.LIMIT,
                    FIN23: $("#FIN23").data("kendoDropDownList").value(),
                    OBS23: $("#OBS23").data("kendoDropDownList").value(),
                    KAT23: $("#KAT23").data("kendoDropDownList").value(),
                    SOS: e.model.SOS,
                    FIN_351: e.model.FIN_351,
                    PD: e.model.PD
                };
                QueryFactory('UpdateNostro', JSON.stringify(update_data), "Дані по угоді № <b>" + e.model.CC_ID + "</b> успішно оновлені", true, '.k-edit-form-container');
            }
        },
        excel: {
            fileName: "Портфель НОСТРО-рахунків.xlsx",
            proxyURL: bars.config.urlContent('/EscrExcelExport/ExcelExport_Save/'),
            allPages: true
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            sheet.columns.autoWidth = true;
            for (var i = 2; i < sheet.rows.length; i++) {
                var row = sheet.rows[i];
                row.cells[9].format = row.cells[10].format = "#,##0.00";
            }
        }
    }).data("kendoGrid");

    var onWindowEditClose = function (e) {
        if (preventCloseOnSave) {
            e.preventDefault();
            preventCloseOnSave = false;
        }
    };

    $(".k-grid-cancel").on("mousedown", function (e) {
        preventCloseOnSave = false;
    });


    ///start
    GetDataList();


    //buttons
    $(".k-grid-btPRVNIX").click(function () {
        var grid = $("#gridPortfolio").data().kendoGrid;

        SetPul(grid.dataItem(grid.select()).ND, function () {
            window.open(GetUrlMetaTable("V_DOPPARAM_MSFZ", 0, "", ""), '_blank');
        });
    });

    $(".k-grid-btDefault").click(function () {
        var grid = $("#gridPortfolio").data().kendoGrid;

        SetPul(grid.dataItem(grid.select()).ND, function () {
            window.open(GetUrlMetaTable("V_OZNAKA_351", 2, "", ""), '_blank');
        });
    });

    $(".k-grid-btVKR").click(function () {
        var grid = $("#gridPortfolio").data().kendoGrid;
        SetPul(grid.dataItem(grid.select()).ND, function () {
            window.open(GetUrlMetaTable("ND_DREC", 2, "", ""), '_blank');
        });
    });

    $(".k-grid-btToExcel").click(function () {
        $("#gridPortfolio").data("kendoGrid").saveAsExcel();
    });


    $(".k-grid-btDelete").click(function () {
        var grid = $("#gridPortfolio").data().kendoGrid;
        var selected_item = grid.dataItem(grid.select());
        var _nd = selected_item.ND;
        bars.ui.confirm({
            text: "Остаточно видалити угоду реф = <b> " + _nd + " </b> ,<br> BIC = <b>" + selected_item.BIC + "</b> , <br> № угоди = <b>" + selected_item.CC_ID + "</b>  ?",
            func: function () {
                QueryFactory('DeleteNostro', JSON.stringify(_nd.toString()), "Угода <b>" + _nd + "</b> успішно видалена", true, '#gridPortfolio');
            }
        });
    });

    $(".k-grid-btEdit").click(function () {
        var grid = $("#gridPortfolio").data().kendoGrid;
        grid.editRow(grid.select());
    });

    $(".k-grid-btAdd").click(function () {
        $("#gridPortfolio").data().kendoGrid.addRow();
    });

    var data = $("#gridPortfolio").data('kendoGrid');
    var arrows = [38, 40];
    data.table.on("keydown", function (e) {
        if (arrows.indexOf(e.keyCode) >= 0) {
            var selected = $("#gridPortfolio tbody").find("tr.k-state-selected");
            selected.removeClass("k-state-selected");

            data.select($("#gridPortfolio_active_cell").closest("tr"));
        }
    });
});


function createNostroList() {
    var grid = $("#gridPortfolio").data("kendoGrid");
    var dataSource = new kendo.data.DataSource({
        requestStart: function () {
            bars.ui.loader('#gridPortfolio', true);
        },
        requestEnd: function () {
            bars.ui.loader('#gridPortfolio', false);
        },
        type: "webapi",
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent('/api/mbdk/NostroPortfolio/GetNostroList/'),
            }
        },
        batch: true,
        schema: {
            data: "Data",
            total: "Total",
            error: function (data) {
                bars.ui.error({ text: data.responseJSON });
            },
            model: {
                id: 'ND',
                fields: {
                    NDI: { type: "number", editable: false },
                    ND: { type: "number" },
                    RNK: { type: "number", editable: false },
                    KV: { type: "number", editable: false },
                    NLS: { type: "string", editable: false },
                    MFO: { type: "string", editable: false },
                    BIC: { type: "string", editable: false },
                    CC_ID: { type: "string" },
                    SDATE: { type: "date" },
                    WDATE: { type: "date" },
                    FIN_351: { type: "number" },
                    PD: { type: "number" },
                    LIMIT: { type: "number" },
                    ACC: { type: "number", editable: false },
                    FIN23: { type: "number" },
                    OBS23: { type: "number" },
                    KAT23: { type: "number" },
                    K23: { type: "number", editable: false },
                    SOS: { type: "number" },
                    IR: { type: "number", editable: false },
                    SDOG: { type: "number", editable: false },
                    BRANCH: { type: "string", editable: false },
                    PROD: { type: "number", editable: false },
                    KV_NAME: { type: "string", editable: false },
                    FIN_NAME: { type: "string", editable: false },
                    OBS_NAME: { type: "string", editable: false },
                    KAT_NAME: { type: "string", editable: false },
                    NMK: { type: "string" },
                    NKD: { type: "string", editable: false },
                    DKD: { type: "string", editable: false }
                }
            }
        },
        pageSize: 25,
        sort: [
           { field: "RNK", dir: "asc" },
           { field: "ND", dir: "asc" }
        ]
    });
    grid.setDataSource(dataSource);
}


function SetPul(_nd, func) {
    $.ajax({
        beforeSend: function() { bars.ui.loader('#gridPortfolio', true); },
        complete: function () { bars.ui.loader('#gridPortfolio', false); },
        type: "POST",
        contentType: 'application/json; charset=utf-8',
        url: bars.config.urlContent('/api/mbdk/NostroPortfolio/SetMasIni/'),
        data: JSON.stringify(_nd.toString()),
        success: function (data) {
            func.call();
        },
        error: function (data) {
            bars.ui.error({ text: data.responseJSON });
        }
    });
}

function GetDataList() {
    $.ajax({
        beforeSend: function () { bars.ui.loader('#gridPortfolio', true); },
        complete: function () { bars.ui.loader('#gridPortfolio', false); },
        type: "GET",
        contentType: 'application/json; charset=utf-8',
        url: bars.config.urlContent('/api/mbdk/NostroPortfolio/GetDataList'),
        success: function (data) {
            fin_list = data.Data.FIN;
            obs23_list = data.Data.OBS23;
            kat23_list = data.Data.KAT23;
            kv_list = data.Data.KV;
            createNostroList();
        },
        error: function (data) {
            bars.ui.error({ text: data.responseJSON });
        }
    });
}

function DisabledButtons() {
    disabledButtons($("#gridPortfolio").data("kendoGrid").select().length === 1,
        [".k-grid-btEdit", ".k-grid-btDelete", ".k-grid-btVKR", ".k-grid-btPRVNIX", ".k-grid-btDefault"]);
}

function disabledButtons(condition, array_buttons) {

    array_buttons.forEach(function (id) {
        if (condition) {
            $(id).removeAttr("disabled");
        } else {
            $(id).attr("disabled", "disabled");
        }
    });
}

function BicUrl(nd) { 
    return bars.config.urlContent('/ndi/referencebook/GetRefBookData/?sParColumn=2&nativeTabelId=8503&jsonSqlParams=[{"Name":"ND","Type":"N","Value": ' + nd + '}]'); //meta tables T_T
}

function GetUrlMetaTable(tabname, accessCode, jsonSqlParams, filterCode) {
    return bars.config.urlContent('/ndi/referencebook/GetRefBookData/?accessCode=') + accessCode + '&tableName=' + tabname + '&jsonSqlParams=' + jsonSqlParams + '&filterCode=' + filterCode;
}

function QueryFactory(method_name, _data, _text, reload, loader) {
    $.ajax({
        beforeSend: function () { bars.ui.loader(loader, true); },
        complete: function () { bars.ui.loader(loader, false); },
        type: "POST",
        contentType: 'application/json; charset=utf-8',
        url: bars.config.urlContent('/api/mbdk/NostroPortfolio/' + method_name),
        data: _data,
        success: function (data) {
            bars.ui.alert({ text: _text });
            if (reload) {
                bars.ui.loader("#gridPortfolio", true);
                var filters = $("#gridPortfolio").data("kendoGrid").dataSource.filter();
                $("#gridPortfolio").data("kendoGrid").dataSource.read();
                $("#gridPortfolio").data("kendoGrid").refresh();
                $("#gridPortfolio").data("kendoGrid").dataSource.filter(filters);
                bars.ui.loader("#gridPortfolio", false);
            }
        }
    });
}

function SetDataSourceFilter(element, ds) {
    element.kendoDropDownList({
        dataTextField: "Value",
        dataValueField: "Value",
        dataSource: ds,
        optionLabel: false
    });
}

function scrollFixed() {
    var offset = $(this).scrollTop(),
        tableOffsetTop = wrapper.offset().top,
        tableOffsetBottom = tableOffsetTop + wrapper.height() - header.height();
    if (offset < tableOffsetTop || offset > tableOffsetBottom) {
        header.removeClass("fixed-header");
    } else if (offset >= tableOffsetTop && offset <= tableOffsetBottom && !header.hasClass("fixed")) {
        header.addClass("fixed-header");
    }
}