$(document).ready(function () {
    function currentRowData() {
        var grid = $('#Contract').data('kendoGrid');
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow)
            return { ids: currentRow.IDS };
        else
            return null;
    }

    function showActualGrpData() {
        currentRowData();
        $('#ContractDet').data('kendoGrid').dataSource.read();
        $('#ContractDet').data('kendoGrid').refresh();
    }

    function setDefaultRow() {
        var grid = $('#Contract').data('kendoGrid');
        if (grid != null) {
            grid.select("tr:eq(1)");
        }
    }

    var contractGrid = $('#Contract').kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        pageable: true,
        toolbar: kendo.template($("#template").html()),
        columns: [
            {
                field: "IDS",
                title: "Реф. Договору"
            },
            {
                field: "RNK",
                title: "РНК"
            },
            {
                field: "NAME",
                title: "Деталі Договору"
            },
            {
                field: "SDAT",
                title: "Дата Договору",
                template: "#= kendo.toString(kendo.parseDate(SDAT, 'dd/MM/yyyy'), 'dd/MM/yyyy') #"

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
                field: "BRANCH",
                title: "Відділення"
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            pageSize: 8,
            serverPaging: true,
            serverFiltering: true,
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/sto/Contract/GetContractList')
                }
            },
            schema: {
                data: "data.Data",
                total: "data.Total",
                model: {
                    fields: {
                        IDS: { type: "number" },
                        RNK: { type: "number" },
                        NAME: { type: "string" },
                        SDAT: { type: "date" },
                        IDG: { type: "number" },
                        KF: { type: "string" },
                        BRANCH: { type: "string" }
                    }
                }
            }
        },
        filterable: true,
        change: showActualGrpData,
        dataBound: setDefaultRow
    });

    var dropDown = contractGrid.find("#grp").kendoDropDownList({
        dataTextField: "NAME",
        dataValueField: "IDG",
        autoBind: false,
        optionLabel: "Всі",
        dataSource: {
            type: "odata",
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
                contractGrid.data("kendoGrid").dataSource.filter({ field: "IDG", operator: "eq", value: parseInt(value) });
            } else {
                contractGrid.data("kendoGrid").dataSource.filter({});
            }
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

    var detGrid = $('#ContractDet').kendoGrid({
        autobind: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
            /*{
                field: "IDS",
                width: "150px",
                title: "Код схеми"
            },
            {
                field: "VOB",
                width: "150px",
                title: "Вид документа"
            },
            {
                field: "DK",
                width: "150px",
                title: "Ознака Д/К"
            },*/
            {
                field: "IDD",
                width: "120px",
                title: "Ід.<br/>договору"
            },
            {
                field: "STATUS_ID",
                width: "120px",
                title: "Статус<br/>рег.плат"
            },
            {
                field: "DISCLAIM_ID",
                width: "150px",
                title: "Ід. відмови<br/>(0 - пітдверджено)"
            },
            {
                field: "STATUS_DATE",
                width: "150px",
                title: "Дата та час<br />обробки<br/>в бек-офісі",
                //format: "{0:dd/MM/yyyy}",
                template: "#= STATUS_DATE != null ? kendo.toString(kendo.parseDate(STATUS_DATE, 'dd/MM/yyyy'), 'dd/MM/yyyy') : '' #"
            },
            {
                field: "STATUS_UID",
                width: "170px",
                title: "Користувач,<br />що обробив запит<br /> в бек-офисе"
            },
            {
                field: "ORD",
                width: "150px",
                title: "Порядок<br/>виконання"
            },
            {
                field: "TT",
                width: "150px",
                title: "Код<br/>операцiї"
            },
            {
                field: "DAT1",
                width: "150px",
                title: "Дата 'З'",
                //format: "{0:dd/MM/yyyy}",
                template: "#= kendo.toString(kendo.parseDate(DAT1, 'dd/MM/yyyy'), 'dd/MM/yyyy') #"
            },
            {
                field: "DAT2",
                width: "150px",
                title: "Дата 'По'",
                //format: "{0:dd/MM/yyyy}",
                template: "#= kendo.toString(kendo.parseDate(DAT2, 'dd/MM/yyyy'), 'dd/MM/yyyy') #"
            },
            {
                field: "FREQ",
                width: "150px",
                title: "Перiодичнiсть"
            },
            {
                field: "NLSA",
                width: "200px",
                title: "Рахунок<br/>вiдправника"
            },
            {
                field: "KVA",
                width: "200px",
                title: "Валюта<br/>вiдправника"
            },
            {
                field: "NLSB",
                width: "200px",
                title: "Рахуноак<br/>отримувача"
            },
            {
                field: "KVB",
                width: "200px",
                title: "Валюта<br/>отримувача"
            },
            {
                field: "MFOB",
                width: "200px",
                title: "Банк<br/>отримувача"
            },
            {
                field: "POLU",
                width: "300px",
                title: "Назва<br/>отримувача"
            },
            {
                field: "NAZN",
                width: "400px",
                title: "Призначення<br/>платежу"
            },
            {
                field: "FSUM",
                width: "200px",
                title: "Формула<br/>суми"
            },
            {
                field: "OKPO",
                width: "200px",
                title: "ОКПО<br/>отримувача"
            },
            {
                field: "DAT0",
                width: "200px",
                title: "Дата<br/>пред.платежy",
                //format: "{0:dd/MM/yyyy}",
                template: "#= DAT0 != null ? kendo.toString(kendo.parseDate(DAT0, 'dd/MM/yyyy'), 'dd/MM/yyyy') : '' #"
            },
            {
                field: "WEND",
                width: "200px",
                title: "Вих.день<br/>(-1 або +1)"
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
                title: "Бранч<br/>для бюджету"
            },
            {
                field: "BRANCH_MADE",
                width: "200px",
                title: "Відділення,<br />де створено<br/>рег.плат"
            },
            {
                field: "DATETIMESTAMP",
                width: "200px",
                title: "Дата та час<br/>створення",
                //format: "{0:dd/MM/yyyy}",
                template: "#= DATETIMESTAMP != null ? kendo.toString(kendo.parseDate(DATETIMESTAMP, 'dd/MM/yyyy'), 'dd/MM/yyyy') : '' #"
            },
            {
                field: "BRANCH_CARD",
                width: "200px",
                title: "Відділення<br />карткового<br/>рахунку"
            },
            {
                field: "USERID_MADE",
                width: "200px",
                title: "Номер користувача,<br />що створив рег.плат<br /> бек-офісі"
            }
            /*{
                field: "USERID",
                width: "200px",
                title: "_USERID"
            },*/
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            pageSize: 10,
            serverPaging: true,
            serverFiltering: true,
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
                        USERID_MADE: { type: "string" }

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
        filterable: true,
        dataBound: markRow
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
                    title: "Ід.<br />рег. платежу"
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
                    title: "Користувач<br />бек-офіса"
                },
                {
                    field: "USER_MADE",
                    width: "200px",
                    title: "Користувач,<br />що виконав дію"
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
            { type: 'separator' },
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
                enable: doThis()
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
                }
            },
            { type: 'separator' },
            { template: "<label>Формат відображення:</label>" },
            {
                template: "<input id='viewFormat' style='width: 200px;' />",
                overflow: "never"
            },
            { type: 'separator' },
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
                }
            }
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
});