var globalID;    
var staticData = [];
var diff_dialog;
var globaltip;
$(document).ready(function () {
        
    globalID = bars.extension.getParamFromUrl('id', location.href);
    globaltip = bars.extension.getParamFromUrl('tip', location.href);
    balance = bars.extension.getParamFromUrl('balance', location.href);
        
    var toolbar = [];
    toolbar.push({ name: "btNew", type: "button", text: "<span class='pf-icon pf-16 pf-add'></span> Додати нове забезпечення" });
    toolbar.push({ name: "btReg", type: "button", text: "<span class='pf-icon pf-16 pf-gear'></span> Редагувати забезпечення",  className: "k-custom-edit" });
    toolbar.push({ name: "btDel", type: "button", text: "<span class='pf-icon pf-16 pf-delete'></span> Від'єднати забезпечення"});
    toolbar.push({ template: " | " });
    toolbar.push({ name: "btReload", type: "button", text: "<span class='pf-icon pf-16 pf-reload_rotate'></span> Оновити"});
    toolbar.push({ template: " | " });
    toolbar.push({name: "btToExcel_Exist", type: "button", text: "<span class='pf-icon pf-16 pf-exel'></span> Експортувати поточну сторінку в MS Excel"});
    toolbar.push({ template: " | " });
    toolbar.push({ name: "btToValidate", type: "button", text: "<span class='pf-icon pf-16 pf-accept_doc'></span> Групове проведення" });
    toolbar.push({ name: "btDiff", type: "button", text: "<span class='pf-icon pf-16 pf-report_open-import'></span> Диференційне проведення" });

    var grid = $("#gridExistProvide").kendoGrid({
        toolbar: toolbar,
        filterable: true,
        resizable: true,
        selectable: true,
        scrollable: true,
        sortable: true,
        selectable: "multiple,row",
        change: function (e) {
            $('tr').find('[type=checkbox]').prop('checked', false);
            $('tr.k-state-selected').find('[type=checkbox]').prop('checked', true);
            ValidateGroupRows();
            onChangeExist();
        },
        pageable: {
            refresh: true,
            pageSize: 100,
            pageSizes: [100,200,500,1000]
        },
        height: 470,
        columns: [
            { 
                headerTemplate: '<input class="checkbox" type="checkbox" id="AllExsist">',
                template: '<input class="checkboxExist" type="checkbox"/>',
                width: 29
            },
        {
            title: "№ п/п",
            width: 48,
            field: "NUM",
            template: "#= ++record #",
            sortable: false
        },
        {
            title: "РНК\nЗаставодавця",
            width: 112,
            field: "RNK"
        },
         {
             title: "Найменування контрагента",
             width: 228,
             field: "NMK"
         },
         {
             title: "Вид забезп",
             width: 79,
             field: "PAWN"
         },
        {
            title: "Найменування виду забезпечення",
            width: 513,
            field: "NAME"
        },
         {
             title: "Рахунок забезпечення",
             width: 120,
             field: "NLS",
             template: "<a href='/barsroot/viewaccounts/accountform.aspx?type=2&acc=${ACC}&rnk=${RNK}&accessmode=1' onclick='window.open(this.href); return false;'>${NLS}</a>"
         },
          {
              title: "Валюта забезпечення",
              width: 92,
              field: "KV"
          },
          {
              title: "Об22",
              width: 68,
              field: "OB22"
          },
        /*  {
              title: "+Дод /\n-Зменш",
              width: 98,
              field: "DEL",
              format: "{0:n2}"
          },*/
          {
              title: "Зал. план",
              width: 117,
              field: "OSTB",
              template: '#=CheckColor(OSTB)#'
          },
         {
             title: "Справ. вартість",
             width: 100,
             field: "SV",
             nullable: true
         },
           {
               title: "Зал. факт",
               width: 117,
               field: "OSTC",
               template: '#=CheckColor(OSTC)#'
           },
          {
              title: "№ дог. заб",
              width: 100,
              nullable: true,
              field: "CC_IDZ"
          },
          {
              title: "Дата дог. заб",
              width: 100,
              field: "SDATZ",
              nullable: true,
              format: "{0:dd.MM.yyyy}"
          },
          {
              title: "План.дата заверш",
              width: 114,
              field: "MDATE",
              nullable: true,
              format: "{0:dd.MM.yyyy}"
          },
          {
              title: "Дата закриття",
              width: 100,
              field: "DAZS",
              nullable: true,
              format: "{0:dd.MM.yyyy}"
          },
           {
               title: "№ в реєстрі",
               width: 100,
               nullable: true,
               field: "NREE"
           },
           {
               title: "№ деп. дог.",
               width: 100,
               nullable: true,
               field: "DEPID"
           },
          {
              title: "Місцезнах.",
              width: 50,
              nullable: true,
              field: "MPAWN"
          },
           {
               title: "Признач.",
               width: 100,
               nullable: true,
               field: "NAZN"
           },
           {
               title: "Призн 1/2",
               width: 100,
               nullable: true,
               field: "PR_12"
           },
            {
                title: "R013",
                width: 100,
                nullable: true,
                field: "R013"
            },

        ],
        edit: function (e) {
            var editWindow = this.editable.element.data("kendoWindow");

            $("#del").kendoNumericTextBox({
                spinners: false
            });
            $("#depid").kendoNumericTextBox({
                spinners: false,
                format: "#"
            });
            $("#pr_12").kendoNumericTextBox({
                spinners: false,
                format: "#"
            });

            TemplateDropDown("#mpawn_list", '/CreditUI/Provide/GetMpawn', "NAME", "MPAWN", null, null);
            TemplateDropDown("#kv_list", '/CreditUI/Provide/GetKV', "NAME", "KV", "startswith",null); 
          
            $("#kv_list").data("kendoDropDownList").list.width(200);
            $("#kv_list").data("kendoDropDownList").value(980);
            if (e.model.isNew()) {
                TemplateDropDown("#pawn_list", '/CreditUI/Provide/GetPawn', "NAME", "PAWN", null, { tip: globaltip == null ? null : globaltip, balance: balance });
                $("#pawn_list").data("kendoDropDownList").list.width(400);
                $("#lbl_del").text("Сума застави");
                $('[name="SV"]').attr("hidden", "hidden");
                $('[name="RNK"]').val(staticData.RNK);
                $("#RNK_name").val(staticData.NMK);
                //$('#NAZN').val("Оприбуткування застави згідно договору <номер договору забезпечення >"+
                //    "від< дата договору забезпечення> для КД <номер КД >від< дата КД>");

                $("#pr_12").data("kendoNumericTextBox").value(1);
                $('.k-window-title').text("Створення забезпечення");

                $(e.container).parent().find(".k-grid-update").html('<span class="k-icon k-update"></span>Створити');

                $("#SDATZ").kendoDatePicker({ format: "dd.MM.yyyy", culture: "en-GB" });
                $("#SDATZ").attr("readonly", true);
                $("#MDATE").kendoDatePicker({ format: "dd.MM.yyyy", culture: "en-GB" });
                $("#MDATE").attr("readonly", true);
            } else {
                TemplateDropDown("#pawn_list", '/CreditUI/Provide/GetPawn', "NAME", "PAWN", null, { nls: e.model.NLS, tip: globaltip == null ? null : globaltip, balance: balance });
                $("#pawn_list").data("kendoDropDownList").list.width(400);

                $("#sv").kendoNumericTextBox({
                    spinners: false
                });
                $('[class="created"]').prop('disabled',true);
                $("#buttonRNK").attr("visibility", "hidden");
                $('.k-window-title').text("Редагування забезпечення");
                $("#SDATZ").kendoDatePicker({ value: e.model.SDATZ, culture: "en-GB" });
                $("#MDATE").kendoDatePicker({ value: e.model.MDATE, culture: "en-GB" });
                    
                $("#kv_list").data("kendoDropDownList").readonly();
                    
                $("#pawn_list").data("kendoDropDownList").value(e.model.PAWN);
                $("#kv_list").data("kendoDropDownList").value(e.model.KV);
                $("#mpawn_list").data("kendoDropDownList").value(e.model.MPAWN);
            }
        },
        editable: {
            mode: "popup",
            template: kendo.template($("#popup-editor").html()),
            update: true
        },
        save: function (e) {

            var provide = {
                RNK: $("#RNK").val(),
                PAWN : $("#pawn_list").data("kendoDropDownList").value(),
                KV : $("#kv_list").data("kendoDropDownList").value(),
                CC_IDZ : e.model.CC_IDZ,
                SDATZ : kendo.toString($("#SDATZ").data("kendoDatePicker").value(), 'dd/MM/yyyy'),
                MDATE : kendo.toString($("#MDATE").data("kendoDatePicker").value(), 'dd/MM/yyyy'),
                MPAWN : $("#mpawn_list").data("kendoDropDownList").value(),
                DEL : e.model.DEL,
                DEPID : e.model.DEPID,
                PR_12 : e.model.PR_12,
                NAZN : e.model.NAZN,
                NREE : e.model.NREE,
                OB22: $("#ob22").val(),
                R013: $("#r013").val(),
                SV: null,
                ACC: null
            };

            if (e.model.isNew()) {
                $.ajax({
                    async: true,
                    type: 'POST',
                    url: bars.config.urlContent('/CreditUI/Provide/AddProvide'),
                    dataType: 'json',
                    data: {
                        provideString: JSON.stringify(provide),
                        id: (globaltip == null  || globaltip == 2)  ? globalID : null,
                        accs: globaltip == null ? null : staticData.ACCS,
                        tip: globaltip == null ? null : globaltip
                    },
                    success: function (data) {
                        if (CatchErrors(data)) {
                            bars.ui.loader('body', true);
                            createExistProvides();
                            bars.ui.loader('body', false);
                            bars.ui.alert({
                                text: "Застава успішно створена"
                            });
                        }
                    }
                });
            }
            else {             
                provide.ACC = e.model.ACC;
                provide.SV = e.model.SV;
                Edit_Provide([provide], "Застава успішно змінена");
            }
        },
        dataBound: function () {
            var grid = $("#gridExistProvide").data("kendoGrid");

            $(".checkboxExist").bind("change", function (e) {
                $(e.target).closest("tr").toggleClass("k-state-selected");
                var check = grid.select().length == 1;
                disabledButtons(check, ".k-grid-btReg");
                disabledButtons(check, ".k-grid-btDel");
                ValidateGroupRows();
            });

            var data = grid.dataSource.data();
            $.each(data, function (i, row) {
                if (row.DAZS != null) {
                    var element = $('tr[data-uid="' + row.uid + '"] ');
                    $(element).addClass("grayRow");
                }
            });
            disabledButtons(false, ".k-grid-btToValidate");
            disabledButtons(false, ".k-grid-btDiff");
            disabledButtons(false, ".k-grid-btReg");
            disabledButtons(false, ".k-grid-btDel");
        },
        cancel: function (e) {
            $('#gridExistProvide').data('kendoGrid').refresh();
        },
        dataBinding: function() {
            record = (this.dataSource.page() -1) * this.dataSource.pageSize();
        },
        excel: {
            fileName: "Забезпечення угоди № " + globalID + ".xlsx"
        },
        excelExport: function(e) {
            var sheet = e.workbook.sheets[0];
            for (var i = 1; i < sheet.rows.length; i++) {
                var row = sheet.rows[i];
                row.cells[7].format = "#,##0.00";
                row.cells[9].format = "#,##0.00";
                row.cells[0].value = i;
            }
                
        }
    }).data("kendoGrid");


    var dialog = $("#dialogSetDEL").kendoWindow({
        title: "Групове проведення",
        modal: true,
        draggable: false,
        visible: false,
        width: "250px" 
    }).data("kendoWindow");
    dialog.center();

    /////////////////////////////////////////////////////////////////////////////////////
    var toolbar = [];
    toolbar.push({ name: "btChange", type: "button", text: "<span class='pf-icon pf-16 pf-add_button'></span> Прив'язати договір забезпечення до КД"});
    toolbar.push({ template: " | " });
    toolbar.push({ name: "btReload_List", type: "button", text: "<span class='pf-icon pf-16 pf-reload_rotate'></span> Оновити"});
    toolbar.push({ template: " | " });
    toolbar.push({ name: "btToExcel_List", type: "button", text: "<span class='pf-icon pf-16 pf-exel'></span> Експортувати поточну сторінку в MS Excel" });

    var grid1 = $("#gridListProvide").kendoGrid({
        toolbar: toolbar,
        filterable: true,
        resizable: true,
        selectable: true,
        scrollable: true,
        sortable: true,
        change: function(e) {
            $('tr').find('[type=checkbox]').prop('checked', false);
            $('tr.k-state-selected').find('[type=checkbox]').prop('checked', true);
            onChangeList();
        },
        pageable: {
            refresh: true,
            pageSize: 50,
            pageSizes: [50, 100, 200, 300, 500]
        },
        height: 340,
        columns: [
            {
                template: '<input class="checkboxList" type="checkbox"/>',
                width: 29
            },
        {
            title: "№ п/п",
            width: 48,
            field: "NUM",
            template: "#= ++record #",
            sortable: false
        },
        {
            title: "РНК Заставодавця",
            width: 112,
            field: "RNK"
        },
         {
             title: "Найменування контрагента",
             width: 228,
             field: "NMK"
         },
         {
             title: "Вид забезп",
             width: 79,
             field: "PAWN"
         },
         {
             title: "Найменування виду забезпечення",
             width: 513,
             field: "NAME"
         },
        {
            title: "Рахунок забезпечення",
            width: 120,
            field: "NLS",
            template: "<a href='/barsroot/viewaccounts/accountform.aspx?type=2&acc=${ACC}&rnk=${RNK}&accessmode=1' onclick='window.open(this.href); return false;'>${NLS}</a>"
        },
          {
              title: "Валюта забезпечення",
              width: 92,
              field: "KV"
          },
          {
              title: "Об22",
              width: 68,
              field: "OB22"
          },
          {
              title: "Зал. факт",
              width: 117,
              field: "OST",
              format: "{0:n2}"
          },
            {
                title: "Назва рахунку\nзабезпечення",
                width: 433,
                field: "NMS"
            }
        /*  {
              title: "ACC",
              width: 149,
              field: "ACC"
          },*/


        ],
        dataBound: function () {
            var grid1 = $("#gridListProvide").data("kendoGrid");
            $(".checkboxList").bind("change", function (e) {
                $(e.target).closest("tr").toggleClass("k-state-selected");
                disabledButtons(e.target.checked, ".k-grid-btChange");
            });
            disabledButtons(false, ".k-grid-btChange");
            
            var grid_ds = grid1.dataSource.total() != 0;
            disabledButtons(grid_ds, ".k-grid-btReload_List");
            disabledButtons(grid_ds, ".k-grid-btToExcel_List");
        },
        dataBinding: function() {
            record = (this.dataSource.page() -1) * this.dataSource.pageSize();
        },
        excel: {
            fileName: "Всі забезпечення.xlsx"
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            for (var i = 1; i < sheet.rows.length; i++) {
                var row = sheet.rows[i];
                row.cells[8].format = "#,##0.00";
                row.cells[0].value = i;
            }
        },
        noRecords: {
            template: "<h1 style='padding-top: 5%;'>Для завантаження всіх договорів забезпечення натисніть сюди</h1>"
        },  
    }).data("kendoGrid");

    ///////buttons grid above
    $('#AllExsist').change(function (ev) {
        var checked = ev.target.checked;
        $('.checkboxExist').each(function (idx, item) {
            var stateSelected = $(item).closest('tr').is('.k-state-selected');
            if ((checked && !stateSelected) || (!checked && stateSelected))  {
                    $(item).click();
               }
        });
        ValidateGroupRows();
    });

    $(".k-grid-btToValidate").click(function () {
        $('#DEL_mess').text("Обрано " + $("#gridExistProvide").data("kendoGrid").select().length + " забезпечень\n");
        $('#DEL_change').kendoNumericTextBox({
            spinners: false
        });
        dialog.open();
    });


    $('#btnOk').click(function () {
        SendGroupToEdit("#gridExistProvide", $('#DEL_change').data("kendoNumericTextBox").value()); 
        dialog.close();
    });

    $(".k-grid-btDiff").click(function () {
        var grid = $("#gridExistProvide").data("kendoGrid");
        var send = [];
        grid.select().each(function () {
            var provide = grid.dataItem($(this));
            send.push(provide);
        });
        createDiffProvides(send);
                    
    });

    $('#btn_diff_Ok').click(function () {
        SendGroupToEdit("#gridDiffProvide", null);
        diff_dialog.close();
    });

    $(".k-grid-btNew").click(function () {
        $("#gridExistProvide").data().kendoGrid.addRow();
    });

    $(".k-grid-btToExcel_Exist").click(function () {
        $("#gridExistProvide").data("kendoGrid").saveAsExcel();
    });

    $(".k-grid-btReload").click(function () {
        $("#gridExistProvide").data("kendoGrid").dataSource.read();
        $("#gridExistProvide").data("kendoGrid").refresh();
    });

    $(".k-grid-btDel").bind("click", function () {
        ChangeProvide("Ви точно бажаєте від'єднати обраний договір забезпечення?", "#gridExistProvide", "/CreditUI/Provide/DeleteProvide/", "Договір успішно від'єднано");
    });

    $(".k-grid-btReg").bind("click", function () {
        var grid = $("#gridExistProvide").data().kendoGrid;
        grid.editRow(grid.select());
    });
    //////////////buttons grid below
    $("#gridListProvide").kendoTooltip({
        filter: "td:nth-child(6)",
        position: "bottom",
        content: function (e) {
            return $("#gridListProvide").data("kendoGrid").dataItem(e.target.closest("tr")).NAME;
        }
    }).data("kendoTooltip");

    $("#gridExistProvide").kendoTooltip({
        filter: "td:nth-child(6)",
        position: "bottom",
        content: function (e) {
            return $("#gridExistProvide").data("kendoGrid").dataItem(e.target.closest("tr")).NAME;
        }
    }).data("kendoTooltip");

    $(".k-grid-btToExcel_List").click(function () {
        $("#gridListProvide").data("kendoGrid").saveAsExcel();
    });

    $(".k-grid-norecords").click(function () {
        createListProvide();
    });

    $(".k-grid-btReload_List").click(function () {
        $("#gridListProvide").data("kendoGrid").dataSource.read();
        $("#gridListProvide").data("kendoGrid").refresh();
    });

    $(".k-grid-btChange").bind("click", function () {
        ChangeProvide("Ви точно бажаєте приєднати обраний договір забезпечення?", "#gridListProvide", "/CreditUI/Provide/JoinProvide/", "Договір успішно приєднано");
    });

    diff_dialog = $("#dialogDiffDel").kendoWindow({
        title: "Диференційне проведення",
        modal: true,
        draggable: false,
        visible: false
    }).data("kendoWindow");

    var grid2 = $("#gridDiffProvide").kendoGrid({
        selectable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            pageSize: 10,
            pageSizes: [10, 20, 100]
        },
        columns: [
        {
            title: "РНК\nЗаставодавця",
            width: 150,
            field: "RNK"
        },
         {
             title: "Найменування контрагента",
             width: 167,
             field: "NMK"
         },
         {
             title: "Рахунок забезпечення",
             width: 150,
             field: "NLS"
         },
          {
              title: "Зал. план",
              width: 117,
              field: "OSTB",
              template: '#=CheckColor(OSTB)#'
          },
           {
               title: "Зал. факт",
               width: 117,
               field: "OSTC",
               template: '#=CheckColor(OSTC)#'
           },
          {
              title: "№ дог. заб",
              width: 100,
              nullable: true,
              field: "CC_IDZ"
          },
          {
              title: "+Дод /\n-Зменш",
              width: 150,
              field: "DEL",
              format: "{0:n2}",
              headerAttributes: { style: 'background-color: #428bca;' }
              }
            ],
            editable: {
                mode: "incell",
            },
            edit: function(e){
                var grid = this;
                var fieldName = grid.columns[e.container.index()].field;
                if (fieldName !== "DEL") {
                    this.closeCell(); // prevent editing
                }
            },
            change: function (e) {
                var grid = $("#gridDiffProvide").data("kendoGrid");
                var gridData = grid.dataSource.view();

                for (var i = 0; i < gridData.length; i++) {
                    if (gridData[i].DEL != 0) {
                        grid.table.find("tr[data-uid='" + gridData[i].uid + "']").addClass("k-state-selected");
                    }
                }
            }
        }).data("kendoGrid");
        GetStatic();
})
/////end ready; 
function onChangeExist()
{
    var check = $("#gridExistProvide").data("kendoGrid").select().length == 1;
    disabledButtons(check, ".k-grid-btReg");
    disabledButtons(check, ".k-grid-btDel");
}
function onChangeList() {
    disabledButtons(($("#gridListProvide").data("kendoGrid").dataItem($(".k-state-selected[role=row]")) !== null), ".k-grid-btChange");
}

/////////////////////////
function GetStatic() {
    var local_url = (globaltip == null || globaltip == 2) ? "/CreditUI/Provide/GetStaticDataKredit/" : "/CreditUI/Provide/GetStaticDataBPK/";
    $.ajax({
        type: "POST",
        async: true,
        dataType: "json",
        url: bars.config.urlContent(local_url),
        data: { id: globalID },
        success: function (data) {
            SetStaticData(data);
        }
    });
}

function SetStaticData(data) {
    staticData = data;
    $("#ref").val(data.ND);
    $("#credit_name").val(data.CC_ID);
    $("#rnk").val(data.RNK);
    $("#rnk_name").val(data.NMK);
    createExistProvides();
}

function createListProvide() {
    TemplateCreateDataSource("#gridListProvide", '/CreditUI/Provide/GetProvideList/', 'ACC',
        { RNK: { type: "number" },
        NMK: { type: "string" },
        NMS: { type: "string" },
        NLS: { type: "string" },
        KV: { type: "number" },
        OST: { type: "number" },
        ACC: { type: "number" },
        PAWN: { type: "number" },
        NAME: { type: "string" },
        OB22: { type: "string" },
    });
}

function createExistProvides() {
    TemplateCreateDataSource("#gridExistProvide", '/CreditUI/Provide/GetProvidePerRef/', 'ACC', columns);
}

function createDiffProvides(dataArray) {
    var grid = $("#gridDiffProvide").data("kendoGrid");
    var dataSource = new kendo.data.DataSource({
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                id: 'ACC',
                fields: columns
            }
        },
        pageSize: 10
    });

    dataArray.forEach(function (item, i, arr) {
        dataSource.add(item);
    });
    grid.setDataSource(dataSource);
    diff_dialog.open().center();
}

var columns = {
    RNK: { type: "number" },
    NMK: { type: "string" },
    PAWN: { type: "number" },
    ACC: { type: "number" },
    NLS: { type: "string" },
    KV: { type: "number" },
    OB22: { type: "string" },
    DEL: { type: "number", nullable: true },
    OSTB: { type: "number" },
    SV: { type: "number", nullable: true },
    OSTC: { type: "number" },
    CC_IDZ: { type: "string" },
    SDATZ: { type: "date", nullable: true },
    MDATE: { type: "date", nullable: true },
    DAZS: { type: "date", nullable: true },
    NREE: { type: "string" },
    DEPID: { type: "number", nullable: true },
    MPAWN: { type: "number" },
    NAZN: { type: "string" },
    PR_12: { type: "number", nullable: true },
    R013: { type: "string", nullable: true },
    NAME: { type: "string" }
}
//////////////////////////////////////

function showReferCust(tabName, showFields, whereClause) {
    bars.ui.handBook(tabName, function (data) {
        $("#RNK").val(data[0].RNK);
        $("#RNK_name").val(data[0].NMK);
    },
    {
        columns: showFields,
        multiSelect: false

    });
}
function showOB22(tabName, showFields, whereClause) {
    var grid = $("#gridExistProvide").data("kendoGrid");
    var selected = grid.select();
    bars.ui.handBook(tabName, function (data) {
        $("#ob22").val(data[0].OB22);
    },
    {
        columns: [{ field: "R020", width: 50 }, { field: "OB22", width: 50 }, { field: "TXT", width: 400 }],
        multiSelect: false,
        clause: selected.length > 0 ? "where r020 = substr(" + grid.dataItem(selected).NLS + ", 1, 4) and d_close is null" :
            "where d_close is null AND r020 = (select NBSZ from cc_pawn where d_Close IS NULL AND pawn = " + $("#pawn_list").data("kendoDropDownList").value() +")",
        ResizedColumns: true

    });
}

function showR013(tabName, showFields, whereClause) {
    var grid = $("#gridExistProvide").data("kendoGrid");
    var selected = grid.select();
    bars.ui.handBook(tabName, function (data) {
        $("#r013").val(data[0].R013);
    },
    {
        columns: [{ field: "R013", width: 50 }, { field: "TXT", width: 450 }],
        multiSelect: false,
        clause: selected.length > 0 ? "where R020 = substr(" + grid.dataItem(selected).NLS + ", 1, 4) and d_close is null" :
            "where d_close is null AND R020 = (select NBSZ from cc_pawn where d_Close IS NULL AND pawn = " + $("#pawn_list").data("kendoDropDownList").value() + ")",
        ResizedColumns: true

    });
}

function ValidateGroupRows() {
    var grid = $("#gridExistProvide").data("kendoGrid");
    var selected = grid.select();
    var row = selected.first();
    var flag = !(grid.dataItem(selected) == null || selected.length == 1);
    if (flag) {
        var firstOB22 = grid.dataItem(row).OB22;
        var firstKV = grid.dataItem(row).KV;
        var firstPAWN = grid.dataItem(row).PAWN;
        selected.each(function () {
            var selectRow = grid.dataItem($(this));
            if ((selectRow.OB22 != firstOB22) || (selectRow.KV != firstKV) || (selectRow.PAWN != firstPAWN)) {
                flag = false;
                return;
            }
        });
    }
    disabledButtons(flag, ".k-grid-btToValidate");
    disabledButtons(!(grid.dataItem(selected) == null || selected.length == 1), ".k-grid-btDiff");
}

function TemplateDropDown(id, url, dataTextField, dataValueField,filter,data)
{
    $(id).kendoDropDownList({
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent(url),
                    data: data == null ? null : data
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors"
            }
        },
        dataTextField: dataTextField,
        dataValueField: dataValueField,
        filter: filter == null ? "none" : filter
    });
}

function TemplateCreateDataSource(id, url, model_id, columns) {
    var grid = $(id).data("kendoGrid");
    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: "json",
                cache: false,
                url: bars.config.urlContent(url),
                data: {
                    id: (globaltip == 3)? staticData.ACCS : globalID,
                    tip: globaltip != null ? globaltip : null,
                    balance: balance
                }
            },
            update: function (o) {
                if (id = "#gridListProvide")
                    createListProvide();
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: function (e) {
                if (e.Status != undefined) {
                    bars.ui.error({
                        title: "Помилка ",
                        text: e.Status,
                        width: '800px',
                        height: '600px'
                    })
                }
            },
            model: {
                id: model_id,
                fields: columns
            }
        },
        pageSize: 50
    });
    grid.setDataSource(dataSource);
}

function Edit_Provide(provide, text) {
    $.ajax({
        async: true,
        type: 'POST',
        url: bars.config.urlContent('/CreditUI/Provide/EditProvide'),
        dataType: 'json',
        data: {
            provideString: JSON.stringify(provide),
            nd: globaltip == null ? globalID : null,
            tip: globaltip == null ? null : globaltip
        },
        success: function (data) {
            if (CatchErrors(data)) {
                bars.ui.alert({
                    text: text
                });
                bars.ui.loader('body', true);
                $("#gridExistProvide").data("kendoGrid").dataSource.read();
                $("#gridExistProvide").data("kendoGrid").refresh();
                var filters = $("#gridExistProvide").data("kendoGrid").dataSource.filter();
                $("#gridExistProvide").data("kendoGrid").dataSource.filter(filters);
                bars.ui.loader('body', false);
            }
        }
    });
}
function ChangeProvide(text_question,id,url,text) {
    var tip = (globaltip == null || globaltip == 2)? 1 : globaltip; //якщо немає типу, то кредит, якщо є, то значення типу
    bars.ui.confirm({
        text: text_question,
        func: function () {
            var grid = $(id).data().kendoGrid;
            var acc_list = [];
            grid.select().each(function () {
                acc_list.push(grid.dataItem($(this)).ACC);
            });
            $.ajax({
                async: true,
                url: bars.config.urlContent(url),
                data: { provideString: JSON.stringify(acc_list), id: globalID, tip: tip },
                success: function (data) {
                    if (CatchErrors(data)) {
                        createExistProvides();
                        $('#gridExistProvide').data('kendoGrid').dataSource.fetch(createListProvide);
                        bars.ui.alert({ text: text });
                    }
                }
            });
        }
    });
}

function SendGroupToEdit(grid,del) {
    var grid = $(grid).data("kendoGrid");
    var list_provide = [];
    grid.select().each(function () {
        var provide = {
            RNK: grid.dataItem($(this)).RNK,
            PAWN: grid.dataItem($(this)).PAWN,
            KV: grid.dataItem($(this)).KV,
            CC_IDZ: grid.dataItem($(this)).CC_IDZ,
            SDATZ: kendo.toString(grid.dataItem($(this)).SDATZ, "dd/MM/yyyy"),
            MDATE: kendo.toString(grid.dataItem($(this)).MDATE, "dd/MM/yyyy"),
            MPAWN: grid.dataItem($(this)).MPAWN,
            DEL: del == null? grid.dataItem($(this)).DEL : del,
            DEPID: grid.dataItem($(this)).DEPID,
            PR_12: grid.dataItem($(this)).PR_12,
            NAZN: grid.dataItem($(this)).NAZN,
            NREE: grid.dataItem($(this)).NREE,
            OB22: grid.dataItem($(this)).OB22,
            R013: grid.dataItem($(this)).R013,
            ACC: grid.dataItem($(this)).ACC,
            SV: grid.dataItem($(this)).SV
        };
        list_provide.push(provide);
    });
    Edit_Provide(list_provide, "Проведення успішно здійснене");
}