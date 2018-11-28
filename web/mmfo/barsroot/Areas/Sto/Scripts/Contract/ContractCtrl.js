function correctFSumOutput(fSum) {

    var result = parseInt(fSum) / 100;

    if (isNaN(result))
        return fSum;
    else 
        return result;
}


function openDopRekvViewWindow(rowIdd) {

    var window = $("#ViewDopRekvWindow").data("kendoWindow");
    window.title(" Додаткові реквізити платежу №" + rowIdd);
    window.center().open();

    //Read only doprekvs grid:
    $("#ContractDopRekvGrid").kendoGrid({
        columns: [
            {
                field: "RekvName",
                title: "Назва реквізиту",
                width: 200
            },
            {
                field: "RekvValue",
                title: "Значення реквізиту",
                width: 100
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    type: "GET",
                    dataType: 'json',
                    url: bars.config.urlContent('/sto/Contract/GetDopRekvForPayment'),
                    data: { paymentIdd: rowIdd },
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                error: "Errors",
                model: {
                    fields: {
                        RekvName: { type: "string" },
                        RekvValue: { type: "string" }
                    }
                }
            },
            error: function (e) {
                alert(e.errorThrown);
            },
            pageSize: 10,
            serverPaging: true,
        },
        autobind: false,
        filterable: false,
        resizable: false,
        pageable: {
            refresh: true,
            pageSizes: [10, 20],
            buttonCount: 3
        },
        height: "270px",
        noRecords: {
            template: '<div class="k-label" style="color:grey; margin:20px 20px;"> Відсутні додаткові реквізити для даного платежу! </div>'
        },
    });

    $("#ContractDopRekvGrid").data('kendoGrid').dataSource.read();
    $("#ContractDopRekvGrid").data('kendoGrid').refresh();
}

function openGovCodesReferenceWindow() {

    $("#AddGovCodeWindow").kendoWindow({
        height: "350px",
        width: "450px",
        title: "Довідник кодів державної закупівлі:",
        visible: false,
        dragable: false,
        resizable: false,
        actions: ["Close"],
    });

    var window = $("#AddGovCodeWindow").data("kendoWindow");
    window.center().open();

    $("#GovCodesGrid").kendoGrid({
        columns: [
            {
                field: "GovCode",
                title: "Код",
                width: 100
            },
            {
                field: "GovCodeText",
                title: "Опис коду",
                width: 300
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    type: "GET",
                    dataType: 'json',
                    url: bars.config.urlContent('/sto/Contract/GetGovCodesValues'),
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                error: "Errors",
                model: {
                    fields: {
                        GovCode: { type: "string" },
                        GovCodeText: { type: "string" }
                    }
                }
            },
            error: function (e) {
                alert(e.errorThrown);
            },
            pageSize: 10,
            serverPaging: true,
            serverFiltering:true
        },
        autobind: true,
        filterable: true,
        selectable: "row",
        resizable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 20],
            buttonCount: 3
        },
    });

    var selectedGovCodeValue = null;

    $("#GovCodesGrid").on("dblclick", "tr.k-state-selected", function () {
        var codesGrid = $("#GovCodesGrid").data("kendoGrid"),
            selectedGovCodeValue = codesGrid.dataItem(codesGrid.select());

        window.close();
        $("#govCodeField").val(selectedGovCodeValue.GovCode);
    });
}

$(document).ready(function () {    
    html = document.documentElement;
    var height = Math.max(html.clientHeight, html.scrollHeight, html.offsetHeight);
    var global_idg = -1;
    function currentRowData() {
        var grid = $('#Contract').data('kendoGrid');
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow)
            return { ids: currentRow.IDS };
        else
            return null;
    }

    var dopRekvViewWindow = $('#ViewDopRekvWindow').kendoWindow({
        title: "Додаткові реквізити платежу ",
        visible: false,
        height: "300px",
        width: "600px",
        scrollable: true,
        resizable: false,
        modal: true,
        actions: ["Close"]
    });

    function showActualGrpData() {
        currentRowData();
        $('#ContractDet').data('kendoGrid').dataSource.read();
        $('#ContractDet').data('kendoGrid').refresh();

        var detGridContent = detGrid.find(".k-grid-content");
        detGridContent.css("overflow", "auto");
    }

    function setDefaultRow() {
        var grid = $('#Contract').data('kendoGrid');
        if (grid != null) {
            grid.select("tr:eq(1)");
        }

        var detGridContent = detGrid.find(".k-grid-content");
        detGridContent.css("overflow", "auto");
    }

    var contractGrid = $('#Contract').kendoGrid({
        autobind: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        resizable: true,
        //height: (height).toString() + "px",  //
        toolbar: kendo.template($("#ContractGridTemplate").html()),
        excel: {
            allPages: true,
            fileName: "Договори на регулярні платежі.xlsx",
            proxyURL: bars.config.urlContent("/sto/Contract/ExportToExcel")
        },
        columns: [
            {
                field: "IDS",
                title: "Реф. договору",
                width: "10%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "RNK",
                title: "РНК",
                width: "15%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "NMK",
                title: "Назва клієнта",
                width: "20%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "Name",
                title: "Деталі договору",
                width: "20%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "SDat",
                title: "Дата договору",
                width: "10%",
                template: "#= (SDat!=null) ? kendo.toString(kendo.parseDate(SDat, 'dd/MM/yyyy'), 'dd/MM/yyyy') :'' #"

            },
            /*{
                field: "IDG",
                title: "Ід. Групи"
            },
            {
                field: "KF",
                title: "_KF"
            },*/
            {
                field: "Branch",
                title: "Відділення",
                width: "15%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "ClosingDate",
                title: "Дата закриття",
                width: "10%",
                template: "#= (ClosingDate!=null) ? kendo.toString(kendo.parseDate(ClosingDate, 'dd/MM/yyyy'), 'dd/MM/yyyy') : '' #"
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",                   
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/sto/Contract/GetContractList'),
                    data: function () {
                        var id = -1;
                        var grpDropdown = $("#grp").data("kendoDropDownList");
                        if (grpDropdown != undefined && grpDropdown.value() != "")
                            id = parseInt(grpDropdown.value());
                        return { group_id: id };
                    }
                }
            },
            serverFiltering: true,
            serverSorting: true,
            schema: {
                data: "data.Data",
                total: "data.Total",
                model: {
                    fields: {
                        IDS: { type: "number" },
                        RNK: { type: "number" },
                        NMK: {type: "string"},
                        Name: { type: "string" },
                        SDat: { type: "date" },
                        KF: { type: "string" },
                        IDG: { type: "number" },
                        BRANCH: { type: "string" },
                        ClosingDate: { type: "date" },
                    }
                }
            }
        },
        filterable: true,
        change: showActualGrpData,
        dataBound: setDefaultRow,
        excelExport: function (e) {
            var columns = e.workbook.sheets[0].columns;
            columns.forEach(function (column) {
                delete column.width;
                column.autoWidth = true;
            });
        }
        //pageable: {
        //    alwaysVisible: false,
        //    pageSizes: [5, 10, 20, 100]
        //},
    });

    function showClientCard() {
        var grid = $("#Contract").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow) {
            bars.ui.dialog({
                content: "/barsroot/clientregister/registration.aspx?readonly=1&rnk=" + currentRow.RNK,
                iframe: true,
                maximize: true
            });
        }
        else {
            bars.ui.alert({ text: 'Оберіть запис!' });
        }
    }

    $("#Contract").on("dblclick", "tr.k-state-selected", function () {
        showClientCard();
    });

    var dropDown = contractGrid.find("#grp").kendoDropDownList({
        dataTextField: "Name",
        dataValueField: "IDG",
        autoBind: false,
        optionLabel: "Оберіть групу для відображення договорів...",
        dataSource: {
            severFiltering: true,
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/sto/Contract/GetGroupList')
                }
            },
            schema: {
                data: "Data",
                total: "Total"
            }
        },
        change: function () {
            var value = this.value();
            if (value) {
                global_idg = parseInt(value);
            } else {
                global_idg = -1;
            }
            contractGrid.data("kendoGrid").dataSource.read({ group_id: global_idg });
        }
    });

    function markRow() {
        var grid = $('#ContractDet').data('kendoGrid');
        var row = grid.dataItem(grid.select());
        grid.tbody.find('>tr').each(function () {
            var dataItem = grid.dataItem(this);
            if (dataItem.STATUS_ID === "Новий" && dataItem.STATUS_ID != row) {
                $(this).addClass('k-row-isNeedToConfirm');
            }
            if (dataItem.STATUS_ID === "Відхилений" && dataItem.STATUS_ID != row) {
                $(this).addClass('k-row-isReject');
            }
        });
    }

    function AllowNumericOnly(jqelement) {
        jqelement.keydown(function (e) {
            var key = e.charCode || e.keyCode || 0;
            // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
            // home, end, period, and numpad decimal
            return ((
                key == 8 ||
                key == 9 ||
                key == 13 ||
                key == 46 ||
                key == 110 ||
                key == 190 ||
                (key >= 35 && key <= 40) ||
                (key >= 48 && key <= 57) ||
                (key >= 96 && key <= 105))
            );
        });
    }

    $("#SumCheckBox").change(function () {
        if ($(this)[0].checked) {
            $("#summFormula").val("");
            $("#summNumber").data("kendoNumericTextBox").wrapper.hide();
            $("#summFormula").show();
        }
        else {
            $("#summNumber").data("kendoNumericTextBox").value("");
            $("#summNumber").data("kendoNumericTextBox").wrapper.show();
            $("#summFormula").hide();
        }
    });

    var detGrid = $('#ContractDet').kendoGrid({
        autobind: false,
        selectable: "row",
        //scrollable: true,
        sortable: true,
        resizable: true,
        //height: (height).toString() + "px",
        toolbar: kendo.template($("#ContractDetGridTemplate").html()),
        excel: {
            allPages: true,
            fileName: "Шаблони регулярних платежів по договору.xlsx",
            proxyURL: bars.config.urlContent("/sto/Contract/ExportToExcel")
        },
        columns: [
            {
                field: "IDD",
                title: "Ід. договору",
                width: "80px",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px; white-space:normal;" }
            },
            {
                field: "STATUS_ID",
                title: "Статус рег.плат",
                width: "125px",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px; white-space: normal" }
            },
            {
                field: "DISCLAIM_ID",
                title: "Ід. відмови (0 - пітдверджено)",
                width: "125px",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px; white-space: normal" }
            },
            {
                field: "STATUS_DATE",
                title: "Дата та час обробки в бек-офісі",
                width: "50px",
                template: "#= STATUS_DATE != null ? kendo.toString(kendo.parseDate(STATUS_DATE, 'dd/MM/yyyy'), 'dd/MM/yyyy') : '' #",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "STATUS_UID",
                width: "170px",
                title: "Користувач, що обробив запит в бек-офисе",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px;white-space: normal;" }
            },
            {
                field: "ORD",
                width: "50px",
                title: "Порядок виконання",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px;white-space: normal;" }
            },
            {
                field: "TT",
                width: "50px",
                title: "Код операцiї",
            },
            {
                field: "DAT1",
                width: "90px",
                title: "Дата 'З'",
                template: "#= kendo.toString(kendo.parseDate(DAT1, 'dd/MM/yyyy'), 'dd/MM/yyyy') #"
            },
            {
                field: "DAT2",
                width: "90px",
                title: "Дата 'По'",
                template: "#= kendo.toString(kendo.parseDate(DAT2, 'dd/MM/yyyy'), 'dd/MM/yyyy') #"
            },
            {
                field: "FREQ",
                width: "90px",
                title: "Перiодичнiсть"
            },
            {
                field: "NLSA",
                width: "150px",
                title: "Рах вiдправника",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "KVA",
                width: "100px",
                title: "Вал A"
            },
            {
                field: "NLSB",
                width: "150px",
                title: "Рах отримувача",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "KVB",
                width: "50px",
                title: "Вал B"
            },
            {
                field: "MFOB",
                width: "90px",
                title: "Банк отримувача",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "POLU",
                width: "300px",
                title: "Назва отримувача",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "NAZN",
                width: "400px",
                title: "Призначення платежу",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "FSUM",
                width: "400px",
                title: "Формула суми",
                template: "#= correctFSumOutput(FSUM) #",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "OKPO",
                width: "90px",
                title: "ОКПО отримувача",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "DAT0",
                width: "90px",
                title: "Дата пред.платежy",
                //format: "{0:dd/MM/yyyy}",
                template: "#= DAT0 != null ? kendo.toString(kendo.parseDate(DAT0, 'dd/MM/yyyy'), 'dd/MM/yyyy') : '' #",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "WEND",
                width: "50px",
                title: "Вих (-1 або +1)",
                attributes: { style: "white-space: normal" }
            },
            /*{
                field: "STMP",
                width: "200px",
                title: "_STMP",
                //format: "{0:dd/MM/yyyy}",
                template: "#= kendo.toString(kendo.parseDate(STMP, 'dd/MM/yyyy'), 'dd/MM/yyyy') #"
            },
            {
                field: "KF",
                width: "200px",
                title: "_KF"
            },
            {
                field: "DR",
                width: "200px",
                title: "_DR"
            */
            {
                field: "BRANCH",
                width: "200px",
                title: "Бранч для бюджету",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "BRANCH_MADE",
                width: "200px",
                title: "Відділення, де створено рег.плат",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "DATETIMESTAMP",
                width: "90px",
                title: "Дата та час створення",
                //format: "{0:dd/MM/yyyy}",
                template: "#= DATETIMESTAMP != null ? kendo.toString(kendo.parseDate(DATETIMESTAMP, 'dd/MM/yyyy'), 'dd/MM/yyyy') : '' #",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "BRANCH_CARD",
                width: "200px",
                title: "Відділення карткового рахунку",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "USERID_MADE",
                width: "200px",
                title: "Номер користувача, що створив рег.плат бек-офісі",
                attributes: { style: "white-space: normal" }
            },
            {
                field: "OPERW_EXISTANCE",
                width: "100px",
                title: "Дод. рекв-ти",
                template: function (dataItem) {
                    var dopRekvButton = "";
                    if (dataItem.OPERW_EXISTANCE == 1)
                        dopRekvButton = "<a class='k-button' onclick='openDopRekvViewWindow(" + dataItem.IDD + ")'>...</a>";
                    return dopRekvButton;
                },
                attributes: { style: "white-space: normal" }
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            pageSize: 100,
            serverPaging: false,
            serverFiltering: false,
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/sto/Contract/GetContractDetList'),
                    data: currentRowData
                }
            },
            schema: {
                data: "data.Data",
                total: "data.Total",
                model: {
                    fields: {
                        IDS: { type: "number" },
                        IDD: { type: "number" },
                        STATUS_ID: { type: "string" },
                        DISCLAIM_ID: { type: "string" },
                        STATUS_DATE: { type: "date" },
                        STATUS_UID: { type: "string" },
                        ORD: { type: "number" },
                        TT: { type: "string" },
                        DAT1: { type: "date" },
                        DAT2: { type: "date" },
                        FREQ: { type: "string" },
                        NLSA: { type: "string" },
                        KVA: { type: "number" },
                        NLSB: { type: "string" },
                        KVB: { type: "number" },
                        MFOB: { type: "string" },
                        POLU: { type: "string" },
                        NAZN: { type: "string" },
                        FSUM: { type: "string" },
                        OKPO: { type: "string" },
                        DAT0: { type: "date" },
                        WEND: { type: "number" },
                        BRANCH: { type: "string" },
                        BRANCH_MADE: { type: "string" },
                        DATETIMESTAMP: { type: "date" },
                        BRANCH_CARD: { type: "string" },
                        USERID_MADE: { type: "string" },
                        OPERW_EXISTANCE: { type: "number" }

                        /*VOB: { type: "number" },
                        DK: { type: "number" },
                        STMP: { type: "date" },
                        KF: { type: "string" },
                        DR: { type: "string" },
                        USERID: { type: "number" }*/
                    }
                }
            }
        },
        filterable: false,
        resizable: true,
        scrollable: true,
        dataBound: function () {
            markRow();
            this.element.find('tbody tr:first').addClass('k-state-selected');
        }
    });

    function confirm(procType) {
        var grid = $('#ContractDet').data('kendoGrid');
        var currentRow = grid.dataItem(grid.select());

        if (!!currentRow) {
            switch (procType) {
                case 0:
                    var disId = $("#ConfirmReason").data("kendoDropDownList").value();
                    if (disId != "") {
                        $.get(urlClaim, { idd: currentRow.IDD, statusId: "-1", disclaimId: disId }).done(function (result) {
                            bars.ui.alert({ text: result.message });
                            $('#ContractDet').data('kendoGrid').dataSource.read();
                            $('#ContractDet').data('kendoGrid').refresh();
                        });
                    }
                    break;
                case 1:
                    $.get(urlClaim, { idd: currentRow.IDD, statusId: "1", disclaimId: "0" }).done(function (result) {
                        bars.ui.alert({ text: result.message });
                        $('#ContractDet').data('kendoGrid').dataSource.read();
                        $('#ContractDet').data('kendoGrid').refresh();
                    });
                    break;
            }
        } else {
            bars.ui.alert({ text: 'Оберіть запис, що потребує підтвердження!' });
        }
    }

    function showWindow() {

        var dfd = new jQuery.Deferred();
        var result = false;

        $("<div id='popupWindow'></div>")
        .appendTo("body")
        .kendoWindow({
            width: "300px",
            modal: true,
            resizable: false,
            title: "Підтвердження відхилення",
            visible: false,
            close: function (e) {
                this.destroy();
                dfd.resolve(result);
            }
        }).data('kendoWindow').content($('#confirmationTemplate').html()).center().open();

        function onChange() {
            $('#popupWindow .confirm_yes').removeAttr('disabled');
        }

        var comfirmDrop = $("#ConfirmReason").kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "ID",
            autoBind: false,
            select: onChange,
            //optionLabel: "Всі",
            dataSource: {
                type: "odata",
                severFiltering: true,
                transport: {
                    read: {
                        dataType: 'json',
                        url: bars.config.urlContent('/sto/Contract/GetDisclaimerList')
                    }
                },
                requestEnd: function (e) {
                    //is this how I set this after the request is successful? why doesn't it set it here?
                    //$("#ConfirmReason").data('kendoDropDownList').select(0);
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            }
        });

        $('#popupWindow .confirm_yes').val('OK');
        $('#popupWindow .confirm_yes').attr('disabled', true);

        $('#popupWindow .confirm_no').val('Відмінити');

        $('#popupWindow .confirm_no').click(function () {
            $('#popupWindow').data('kendoWindow').close();
        });

        $('#popupWindow .confirm_yes').click(function () {
            result = true;
            var procType = 0;
            confirm(procType);
            $('#popupWindow').data('kendoWindow').close();
        });

        return dfd.promise();
    }

    function rowInfo() {
        var grid = $('#ContractDet').data('kendoGrid');
        var currentRow = grid.dataItem(grid.select());
        var idd = { idd: currentRow.IDD };

        var infoGrid = $('#info-grid').kendoGrid({
            //filterable: true,
            autobind: false,
            selectable: "row",
            hight: "500px",
            scrollable: true,
            sortable: true,
            pageable: {
                refresh: true,
                buttonCount: 5
            },
            columns: [
                {
                    field: "IDD",
                    width: "100px",
                    title: "Ід.<br />рег. платежу",
                },
                {
                    field: "ACTION",
                    width: "130px",
                    title: "Дія"
                },
                {
                    field: "DISCLAIM",
                    width: "200px",
                    title: "Причина відмови<br />в реєстрації<br />договору"
                },
                {
                    field: "STATUS",
                    width: "100px",
                    title: "Статус<br />договору"
                },
                {
                    field: "STATUS_DATE",
                    width: "150px",
                    format: "{0:dd/MM/yyyy}",
                    title: "Дата початку дії<br />статусу договору"
                },
                {
                    field: "USER_CLAIMED",
                    width: "200px",
                    title: "Користувач<br />що виконав дію"
                },
                {
                    field: "USER_MADE",
                    width: "200px",
                    title: "Користувач,<br />що створив доручення"
                },
                {
                    field: "WHEN",
                    width: "150px",
                    //format: "{0:dd/MM/yyyy}",
                    title: "Дата та час<br />виконання дії"
                }
            ],
            dataSource: {
                type: "aspnetmvc-ajax",
                pageSize: 5,
                serverPaging: true,
                serverFiltering: true,
                transport: {
                    read: {
                        dataType: "json",
                        url: bars.config.urlContent('/sto/Contract/GetDetListRowInfo'),
                        data: idd
                    }
                },
                schema: {
                    data: "data.Data",
                    total: "data.Total",
                    model: {
                        fields: {
                            ACTION: { type: "string" },
                            DISCLAIM: { type: "string" },
                            IDD: { type: "number" },
                            STATUS: { type: "string" },
                            STATUS_DATE: { type: "date" },
                            USER_MADE: { type: "string" },
                            USER_CLAIMED: { type: "string" },
                            WHEN: { type: "string" }
                        }
                    }
                }
            }
        });

        var infoWindow =  $('#info-window').kendoWindow({
            title: "Історія змін статусу регулярного платежа бек-офісом",
            visible: false,
            width: "1000px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"]
        });
        
        var window = infoWindow.data("kendoWindow");
        window.center().open();
    }

    function doThis() {
        if (mode === "user") {
            return false;
        } else {
            return true;
        }
    }

    var dToolbar = $("#det-toolbar").kendoToolBar({
        items: [           
            {
                id: "confirm",
                type: "button",
                //spriteCssClass: "pf-icon pf-16 pf-ok",
                text: '<i class="pf-icon pf-16 pf-ok" title="Підтвердити"></i>',
                title: "Підтвердити",
                click: function () {
                    var procType = 1;
                    confirm(procType);
                },
                enable: doThis(), overflow: "never"
            },
            {
                id: "create",
                type: "button",
                //spriteCssClass: "pf-icon pf-16 pf-ok",
                text: '<i class="pf-icon pf-16 pf-add" title="Додати"></i>',
                title: "Додати",
                click: function () {
                    prepareNewStoDet();
                },
                enable: !doThis(), overflow: "never"
            },{
                id: "calendar",
                type: "button",
                //spriteCssClass: "pf-icon pf-16 pf-ok",
                text: '<i class="pf-icon pf-16 pf-calendar" title="Календар"></i>',
                title: "Додати",
                click: function () {
                    Redirect();
                },
                enable: !doThis(), overflow: "never"
            },
            {
                id: "reject",
                type: "button",
                //spriteCssClass: "pf-icon pf-16 pf-delete",
                text: '<i class="pf-icon pf-16 pf-delete" title="Відхилити"></i>',
                title: "Відхилити",
                click: function () {
                    var grid = $('#ContractDet').data('kendoGrid');
                    var currentRow = grid.dataItem(grid.select());
                    if (!!currentRow) {
                        showWindow();
                    } else {
                        bars.ui.alert({ text: 'Оберіть запис, що потребує відхилення!' });
                    }
                }, overflow: "never"
            },           
            { template: "<label>Фільтр за станом:</label>" },
            {
                template: "<input id='viewFormat' style='width: 200px;' />",
                overflow: "never"
            },           
            {
                id: "info",
                type: "button",
                //spriteCssClass: "pf-icon pf-16 pf-ok",
                text: '<i class="pf-icon pf-16 pf-info" title="Довідка"></i>',
                title: "Довідка",
                click: function () {
                    var grid = $('#ContractDet').data('kendoGrid');
                    var currentRow = grid.dataItem(grid.select());
                    if (!!currentRow) {
                        rowInfo();
                    } else {
                        bars.ui.alert({ text: 'Оберіть запис!' });
                    }
                }, overflow: "never"
            }, 
            {
                id: "excel",
                type: "button",
                text: '<span class="k-icon k-i-excel"></span>Вивантажити в Excel',
                //text: 'Вивантажити в Excel',
                title: "Вивантажити в Excel",
                click: function () {
                    $('#ContractDet').data('kendoGrid').saveAsExcel();
                }, overflow: "never"
            },
        ]        
    });

    Redirect = function () {
        var grid = $('#ContractDet').data('kendoGrid');
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow) {

            var docUrl = bars.config.urlContent("tools/sto/sto_calendar.aspx?IDD=" + currentRow.IDD + "&mode=RW");

            $('#schedule-window').kendoWindow({
                title: "Графік платежів",
                modal: true,
                resizable: true,
                width: 1000,
                height: 870,
                content: docUrl,
                iframe: true,
                visible: false,
                close: function () {
                    grid.dataSource.read();
                    //setTimeout(function () {
                    //    $('#schedule-window').kendoWindow('destroy');
                    //}, 200);
                }
            });

            $('#schedule-window').data('kendoWindow').center().open();

            //var calendarUrl = window.location.href;            
            //calendarUrl =calendarUrl.substring(0, calendarUrl.indexOf('barsroot')) + "barsroot/tools/sto/sto_calendar.aspx?IDD=" + currentRow.IDD + "&mode=RW";
            //window.location = calendarUrl;

            ////var docUrl = bars.config.urlContent("tools/sto/sto_calendar.aspx?IDD=" + currentRow.IDD + "&mode=RW");
            //var newWindow = window.open(docUrl, '', 'modal=yes, toolbar=no, location=no, directories=no, status=no, menubar=no, resizable=yes, copyhistory=no, width=' + 1000 + ', height=' + 870 + ', top=' + 50 + ', left=' + 500);
            //newWindow.onbeforeunload = function () {
            //    grid.dataSource.read();
            //}
        } else {
            bars.ui.alert({ text: 'Оберіть платіж для перегляду календаря!' });
        }
    }

    function refreshContractDetGrid() {
        $('#ContractDet').data('kendoGrid').refresh();
    }

    var stoToolbar = $("#sto-toolbar").kendoToolBar({
        items: [
            { type: 'separator' },           
            {
                id: "create",
                type: "button",
                text: '<i class="pf-icon pf-16 pf-add" title="Додати платника в групу договорів"></i>',
                title: "Додати",
                click: function () {
                    prepareNewSto();
                },
                enable: !doThis()
            },
            { type: 'separator' },
            {
                id: "reload",
                type: "button",
                text: '<i class="pf-icon pf-16 pf-reload_rotate" title="Перечитати"></i>',
                title: "Перечитати",
                click: function () {
                    reloadGrids();
                },
                enable: !doThis()
            },
            {
                id: "delete",
                type: "button",
                text: '<i class="pf-icon pf-16 pf-delete" title="Видалити/Закрити договір"></i>',
                title: "Видалити/Закрити договір",
                click: function () {
                    deleteContract();
                },
                enable: !doThis()
            },
            {
                id: "info",
                type: "button",
                text: '<i class="pf-icon pf-16 pf-info" title="Детальна інформація по клієнту"></i>',
                title: "Довідка",
                click: function () {
                    showClientCard();
                }, overflow: "never"
            }, 
            {
                id: "excel",
                type: "button",
                text: '<span class="k-icon k-i-excel"></span>Вивантажити в Excel',
                title: "Вивантажити в Excel",
                click: function () {
                    $('#Contract').data('kendoGrid').saveAsExcel();
                }, overflow: "never"
            },
        ]
    });

    $("#viewFormat").kendoDropDownList({
        optionLabel: "Всі",
        dataTextField: "text",
        dataValueField: "value",
        dataSource: [
            { text: "Лише нові", value: 0 },
            { text: "Лише актуальна дата", value: "date" }
        ],
        change: function () {
            var value = this.value();
            if (value) {
                if (value === "date") {
                    var today = new Date();
                    detGrid.data("kendoGrid").dataSource.filter({ field: "DAT2", operator: "gt", value: today });
                } else {
                    detGrid.data("kendoGrid").dataSource.filter({ field: "STATUS_ID", operator: "eq", value: value === "0" ? "Новий" : value });
                }      
            } else {
                detGrid.data("kendoGrid").dataSource.filter({});
            }
        }
    });

    $("#ContractDet").on("dblclick", "tr.k-state-selected", function () {
        rowInfo();
    });

    var tts_list = kendo.data.Model.define({
        id: tts_list,
        fields: { TT: { type: "string" }, NAME: {type:"string"} }
    });

    var tts_data = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: { read: { dataType: 'json', url: bars.config.urlContent('/sto/Contract/GetTTS')} },
        schema: { data: "data", model: tts_list }
    });

    $('#ttsddl').kendoDropDownList({
        dataSource: tts_data,
        filters: "contain",
        dataTextField: "NAME",
        dataValueField: "TT",
        filter: "contains"
    });
   
    reloadGrids = function () {
        $('#Contract').data('kendoGrid').dataSource.read();
        $("#ContractDet").data("kendoGrid").dataSource.read();
    }

    prepareNewStoDet = function () {
        var selected_kv_a = null;
        var wnd_stodet = $("#wnd_stodet").data("kendoWindow");
        var grid = $("#Contract").data("kendoGrid");
        var grid_det = $("#ContractDet").data("kendoGrid");
        var currentRowData = null;
        var today = new Date();
        if (grid.select().length > 0) {
            currentRowData = grid.dataItem(grid.select());
            wnd_stodet.center().open();
            $('#from').val(kendo.toString(kendo.parseDate(today, 'dd/MM/yyyy'), 'dd.MM.yyyy'));
            $('#till').val(null);
            $('#nazn').val(null);
            $('#mfo_b').val(null);
            $('#nls_b').val(null);
            $('#okpo_b').val(null);
            $('#name_b').val(null);
            $("#summNumber").data("kendoNumericTextBox").value("");
            $("#summFormula").val("");
            $("#govCodeField").val(null);
            $("#NPP").data("kendoNumericTextBox").value(grid_det._data.length + 1);
            $('input[name=week][value=-1]').prop('checked', true);
            if (currentRowData.RNK != null) {
                var nls_list = kendo.data.Model.define({
                    id: nls_list,
                    fields: { nls: { type: "string" } }
                });

                var nls_data = new kendo.data.DataSource({
                    type: "aspnetmvc-ajax",
                    transport: 
                        { 
                            read: 
                            { 
                                dataType: 'json', 
                                url: bars.config.urlContent('/sto/Contract/GetNLS'),
                                data: function ()
                                {
                                    return { RNK: currentRowData.RNK, KV: selected_kv_a}
                                }
                            } 
                        },
                    schema: { data: "data", model: nls_list }
                });

                $('#nls_a').kendoDropDownList({                    
                    dataSource: nls_data,                    
                    filter: "contains"
                });


                //get datasource for KVs based on client's rnk, initialize ddls with currencies
                //Sender's and receiver's currency should be the same according to requirement
                $.ajax({
                    type: "GET",
                    url: bars.config.urlContent('/sto/Contract/GetKVs?RNK=' + currentRowData.RNK),
                    success: function (result) {
                        if (result.status == "error") {
                            bars.ui.error({ text: 'Помилка при отриманні валюти платника: ' + result.message });
                        }
                        else {
                            $('#kv_a').kendoDropDownList({
                                dataSource: result.data,
                                dataTextField: "NAME",
                                dataValueField: "KV",
                                filter: "contains",
                                change: function () {
                                    dropdown_nls = angular.element("#nls_a").data("kendoDropDownList");
                                    dropdown_nls.dataSource.read();
                                },
                                select: function (e) {
                                    selected_kv_a = this.dataItem(e.item).KV;
                                }
                            });

                            $('#kv_b').kendoDropDownList({
                                dataSource: result.data,
                                dataTextField: "NAME",
                                dataValueField: "KV",
                                filter: "contains",
                                change: function () {
                                },
                                select: function (e) {
                                    selected_kv_b = this.dataItem(e.item).KV;
                                }
                            });
                        }
                    },
                    error: function () {
                        bars.ui.error({ text: 'Помилка: '+ result.message });
                    }
                });

                $.get(bars.config.urlContent('/sto/Contract/GetNMK?RNK='+currentRowData.RNK)).done(function (result) {
                    if (result.status == "ok") {
                        $('#name_a').val(result.data);
                    }
                });
                $.get(bars.config.urlContent('/sto/Contract/AvaliableNPP?IDS=' + currentRowData.IDS)).done(function (result) {
                    if (result.status == "ok") {
                        $("#NPP").data("kendoNumericTextBox").value(result.data);
                    }
                });
                
            }
            else {
                $("#nls_a").kendoMaskedTextBox({
                    mask: "00000000000000"
                });
            }
        }
        else
            bars.ui.alert({ text: 'Оберіть платника в верхньому списку!' });
    }

    clearNewContractWindowData = function () {
        $("#OKPO").val("");
        $("#RNK").val("");

        if ($("#RNK_LIST").data("kendoDropDownList")) {
            $("#RNK_LIST").data("kendoDropDownList").select(0);
            $("#RNK_LIST").data("kendoDropDownList").wrapper.hide();
            $("#RNK_List_Label").hide();
        };

        $("#name_ids").val("");
    }

    prepareNewSto = function () {
        var wnd_stolst = $("#wnd_stolst").data("kendoWindow");
        var grid = $("#Contract").data("kendoGrid");               
        if (global_idg >= 1) {
            var today = new Date();
            $('#from_ids').val(kendo.toString(kendo.parseDate(today, 'dd/MM/yyyy'), 'dd.MM.yyyy'));
            wnd_stolst.center().open();
            clearNewContractWindowData();
        }
        else {
            bars.ui.alert({ text: 'Оберіть групу платежів з випадаючого списку вгорі!'});
        }
    }
    
    deleteContract = function () {
        var grid = $('#Contract').data('kendoGrid');
        var currentRow = grid.dataItem(grid.select());

        if (currentRow == null) {
            bars.ui.alert({ text: 'Оберіть рядок з договором!' });
        }
        else {
            bars.ui.confirm({ text: "Ви дійсно бажаєте видалити усі макети платежів та закрити договір?" }, function () {
                $.ajax({
                    type: "Get",
                    url: bars.config.urlContent('/sto/Contract/Delete_Contract?ids=' + currentRow.IDS),
                    success: function (result) {
                        if (result.status == 'error') {
                            bars.ui.error({ text: result.message });
                        } else {
                            grid.dataSource.read();
                            grid.refresh();
                            bars.ui.alert({ text: result.data });
                        }
                    },
                    error: function (result) {
                        bars.ui.error({ text: result.message });
                    }
                });
            });
        }
    }

    var freq_list = kendo.data.Model.define({
        id: freq_list,
        fields: { FREQ: { type: "int" }, NAME: { type: "string" } }
    });

    var freq_data = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: { read: { dataType: 'json', url: bars.config.urlContent('/sto/Contract/GetFREQ') } },
        schema: { data: "data", model: freq_list }
    });

    $('#freqddl').kendoDropDownList({
        dataTextField: "NAME",
        dataValueField: "FREQ",
        dataSource: freq_data
    });
    
    $("#from_ids").kendoDatePicker({
        format: "dd/MM/yyyy"
    });

    $("#NPP").kendoNumericTextBox({
        width: "100px",
        maxlength: "5",
        readonly: false,
        spinners: true,
        format: "d",
        min:1
    });

    $("#nazn").kendoMaskedTextBox({
      //  mask: "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&",        
        required: true,
        placeholder: "Введіть призначення"
    });
    $("#name_a").kendoMaskedTextBox({
       // mask: "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    });    
    $("#name_ids").kendoMaskedTextBox({
       // mask: "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    });
    $("#name_b").kendoMaskedTextBox({
       // mask: "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    });
    $("#nls_b").kendoMaskedTextBox({
        mask: "00000000000000"
    });
    $("#mfo_b").kendoMaskedTextBox({
        mask: "000000"
    });
    $("#okpo_b").kendoMaskedTextBox({
        mask: "0000000000"
    });

    AllowNumericOnly($("#RNK"));
    AllowNumericOnly($("#OKPO"));
    //AllowNumericOnly($("#summ"));

    $("#summNumber").kendoNumericTextBox({
        width: "250px",
        maxlength: "15",
        readonly: false,
        spinners: false,
        format: "#.00",
    });

    validatePayment = function () {
        var $stoFrm = $('#wnd_stodet');        
        if ($stoFrm.find('#NPP').val() == null) {
            bars.ui.alert({ text: 'Введіть порядок виконання платежу' });
            return false;
        }
        else {
            return true;          
        }        
    }
    validateIDS = function () {
        var $stoFrm = $('#wnd_stolst');
        if (($stoFrm.find('#RNK_LIST')!= undefined && $stoFrm.find('#RNK_LIST').val() == "")) {
            bars.ui.alert({ text: 'Оберіть клієнта' });
            return false;
        }
        else {
            if ($("#name_ids").val() == "") {
                bars.ui.alert({ text: 'Введіть найменування договору!' });
                return false;
            } 
            else 
                return true;
        }
    }

    collectPayment = function () {
        var $stoFrm = $('#wnd_stodet');
        var sumValue=0;
        if ($("#SumCheckBox")[0].checked) {
            sumValue = $("#summFormula").val();
        }
        else {
            sumValue = $("#summNumber").data("kendoNumericTextBox").value()*100;
        }
        return {
            IDS: currentRowData().ids,
            ord: $stoFrm.find('#NPP').val(),
            tt: $stoFrm.find('#ttsddl').val(),
            vob : 6,
            dk  : 1,
            nlsa: $stoFrm.find('#nls_a').val(),
            kva :$stoFrm.find('#kv_a').val(),
            nlsb: $stoFrm.find('#nls_b').val().replace("_", ""),
            kvb :$stoFrm.find('#kv_b').val(),
            mfob :$stoFrm.find('#mfo_b').val(),
            polu: $stoFrm.find('#name_b').val().replace("_", ""),
            nazn: $stoFrm.find('#nazn').val(),
            fsum: sumValue,
            okpo: $stoFrm.find('#okpo_b').val().replace("_", ""),
            DAT1: $stoFrm.find('#from').val(),
            DAT2: $stoFrm.find('#till').val(),
            FREQ :$stoFrm.find('#freqddl').val(),
            WEND :$stoFrm.find('input[name=week]:checked').val(),
            DR  : null,
            nd   : null,
            sdate: null,
            idd: 0,
            status: 0,
            status_text: "",
            govBuyCode: $stoFrm.find("#govCodeField").val()
        }
    }
    collectIDS = function () {
        var $stoFrm = $('#wnd_stolst');
        return {
            RNK: $stoFrm.find('#RNK_LIST').val(),
            NAME :$stoFrm.find('#name_ids').val(),
            SDat :$stoFrm.find('#from_ids').val(),
            IDG : global_idg
        }
    }

    savePayment = function () {
        if (validatePayment()) {
            collectPayment();
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent('/sto/Contract/AddPayment'),
                    data: collectPayment(),
                    success: function (data) {
                        if (data.status == 'error' && data.message != 'Sequence contains no elements') {
                            bars.ui.alert({ text: 'Не збережено!     ' + data.message });
                        } else {
                            bars.ui.alert({ text: 'Збережено!' });
                            $("#wnd_stodet").data("kendoWindow").close();
                        }
                    },
                    error: function (data) {
                        bars.ui.error({ text: data.message });
                    }
                });
        }
    };

    var AddContractWindow = $("#wnd_stolst");
    AddContractWindow.kendoWindow({
        height: "350px",
        width: "450px",
        title: "Новий договір на регулярні платежі",
        visible: false,
        //content: docUrl,
        //iframe: true,
        dragable: true,
        resizable: false,
        actions: ["Close"],
    });


    $("#buttonsave").kendoButton();
    var button = $("#buttonsave").data("kendoButton");
    button.bind("click", function (e) {
        var wnd = $("#wnd_stodet").data("kendoWindow");
        savePayment();
        wnd.refresh();
        showActualGrpData();
    });

    var AddDopRekvWindow = $("#AddDopRekvWindow").kendoWindow({
        height: "350px",
        width: "450px",
        title: "Додавання додаткових реквізитів платежу",
        visible: false,
        dragable: true,
        resizable: false,
        actions: ["Close"],
    });

    var dopRekvOpenButton = $("#dopRekvButton").kendoButton();
    dopRekvOpenButton.bind("click", function (e) {
        $("#AddDopRekvWindow").data("kendoWindow").center.open();
    });

    var addGovCodeButton = $("#addGovCodeButton").kendoButton();
    addGovCodeButton.bind("click", openGovCodesReferenceWindow);

    $("#buttonSearch").kendoButton();
    var buttonSearchRNK = $("#buttonSearch").data("kendoButton");
    buttonSearchRNK.bind("click", function (e) {
        var $stoFrm = $('#wnd_stolst');
        var OKPO = $stoFrm.find('#OKPO').val();
        var RNK = $stoFrm.find('#RNK').val();
        if (OKPO == "" && RNK == "") {
            bars.ui.alert({ text: " Заповніть хоча б один критерій пошуку: ІНН або РНК !" });
            return;
        }

        $.ajax({
            type: "POST",
            url: bars.config.urlContent('/sto/Contract/GetRNKLIST?OKPO=' + OKPO + "&RNK=" + RNK),
            success: function (result) {
                if (result.status == 'error') {
                    bars.ui.error({ text: result.message });
                } else
                    if (result.data.length == 0) {
                        bars.ui.alert({ text: "Жодного клієнта не знайдено за заданими умовами пошуку!" });
                    }
                    else {

                        $("#RNK_List_Label").show();
                        $('#RNK_LIST').kendoDropDownList({
                            dataTextField: "NMK",
                            dataValueField: "RNK",
                            dataSource: result.data,
                            template: '<span style="font-size:0.8em">#:NMK#</span>'
                        });
                    }
            },
            error: function (data) {
                bars.ui.error({ text: data.message });
            }
        });

    });

    $("#buttonSaveContractInfo").kendoButton();
    var buttonIDS = $("#buttonSaveContractInfo").data("kendoButton");
    buttonIDS.bind("click", function (e) {
        var newClientWindow = $("#wnd_stolst").data("kendoWindow");
        if (validateIDS()) {
            collectIDS();

            //Write new Contract into in DB:
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/sto/Contract/AddIDS'),
                data: collectIDS(),
                success: function (data) {
                    if (data.status == 'error' && data.message != 'Sequence contains no elements') {
                        bars.ui.alert({ text: 'Не збережено!     ' + data.message });
                    }
                    else {
                        bars.ui.alert({ text: 'Збережено!' });

                        $('#Contract').data('kendoGrid').dataSource.read();
                        $('#Contract').data('kendoGrid').refresh();
                        showActualGrpData();
                        newClientWindow.close();
                    }
                },
                error: function (data) {
                    bars.ui.error({ text: data.message });
                }
            });
        }
    });

    $("#buttonCancelNewContractInfo").on("click", function () {
        var newClientWindow = $("#wnd_stolst").data("kendoWindow");
        newClientWindow.close();
    });

    var splitter =  $("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{ size: "60%" }, { size: "40%" }],
        resize: function (e) {

            if (contractGrid !== undefined) {
                var contractGridHeight = $(".panel-primary").height();
                contractGrid.height(contractGridHeight);
                var contractContentHeight = contractGridHeight - contractGrid.find(".k-grid-header").height() - contractGrid.find(".k-grid-toolbar").height() - $(".k-splitbar").outerHeight();
                contractGrid.find(".k-grid-content").css("height", contractContentHeight);
            }

            if (detGrid !== undefined) {
                var detGridHeight = $(".panel-info").height();
                detGrid.height(detGridHeight);
                var detContentHeight = detGridHeight - detGrid.find(".k-grid-header").height() - detGrid.find(".k-grid-toolbar").height() - $(".k-splitbar").outerHeight();
                var detGridContent = detGrid.find(".k-grid-content");
                detGridContent.css("height", detContentHeight);
            }
        }
    })

});