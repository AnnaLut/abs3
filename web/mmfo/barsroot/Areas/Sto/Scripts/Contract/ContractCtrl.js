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

    function showActualGrpData() {
        currentRowData();
        //debugger;
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
        scrollable: true,
        sortable: true,
        height: (height).toString() + "px",
        toolbar: kendo.template($("#template").html()),
        columns: [
            {
                field: "IDS",
                title: "Реф. Договору",
                width: "5%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "RNK",
                title: "РНК",
                width: "15%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "NAME",
                title: "Деталі Договору",
                width: "30%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
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
                title: "Відділення",
                width: "25%",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",                   
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

    $("#Contract").on("dblclick", "tr.k-state-selected", function () {
        var grid = $("#Contract").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        bars.ui.dialog({
            content: "/barsroot/clientregister/registration.aspx?readonly=1&rnk=" + selectedItem.RNK,
            iframe: true,
            maximize: true
        });
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
                global_idg = value;
            } else {
                contractGrid.data("kendoGrid").dataSource.filter({});
                global_idg = -1;
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
        height: (height).toString() + "px",
        columns: [ 
            {
                field: "IDD",              
                title: "Ід.<br/>договору",
                width: "80px",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "STATUS_ID",               
                title: "Статус<br/>рег.плат",
                width: "125px",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "DISCLAIM_ID",                
                title: "Ід. відмови<br/>(0 - пітдверджено)",
                width: "125px",
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "STATUS_DATE",
                title: "Дата та час<br />обробки<br/>в бек-офісі",                
                template: "#= STATUS_DATE != null ? kendo.toString(kendo.parseDate(STATUS_DATE, 'dd/MM/yyyy'), 'dd/MM/yyyy') : '' #"
            },
            {
                field: "STATUS_UID",
                width: "170px",
                title: "Користувач,<br />що обробив запит<br /> в бек-офисе"                ,                
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "ORD",
                width: "50px",
                title: "Порядок<br/>виконання",               
                attributes: { "class": "table-cell", style: "text-align: left; font-size: 12px" }
            },
            {
                field: "TT",
                width: "50px",
                title: "Код<br/>операцiї"
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
                title: "Рах<br/>вiдправника"
            },
            {
                field: "KVA",
                width: "100px",
                title: "Вал A"
            },
            {
                field: "NLSB",
                width: "150px",
                title: "Рах<br/>отримувача"
            },
            {
                field: "KVB",
                width: "50px",
                title: "Вал B"
            },
            {
                field: "MFOB",
                width: "90px",
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
                width: "400px",
                title: "Формула<br/>суми"
            },
            {
                field: "OKPO",
                width: "90px",
                title: "ОКПО<br/>отримувача"
            },
            {
                field: "DAT0",
                width: "90px",
                title: "Дата<br/>пред.платежy",
                //format: "{0:dd/MM/yyyy}",
                template: "#= DAT0 != null ? kendo.toString(kendo.parseDate(DAT0, 'dd/MM/yyyy'), 'dd/MM/yyyy') : '' #"
            },
            {
                field: "WEND",
                width: "50px",
                title: "Вих<br/>(-1 або +1)"
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
                width: "90px",
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
        filterable: false,
        resizable: true,
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
            }
        ]        
    });
    Redirect = function () {
        var grid = $('#ContractDet').data('kendoGrid');
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow) {
            var calendarUrl = window.location.href;            
            calendarUrl =calendarUrl.substring(0, calendarUrl.indexOf('barsroot')) + "barsroot/tools/sto/sto_calendar.aspx?IDD=" + currentRow.IDD + "&mode=RW";
            window.location = calendarUrl;
        } else {
           alert('Оберіть платіж для перегляду календаря!' );
        }
    }
    var stoToolbar = $("#sto-toolbar").kendoToolBar({
        items: [
            { type: 'separator' },           
            {
                id: "create",
                type: "button",
                //spriteCssClass: "pf-icon pf-16 pf-ok",
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
                //spriteCssClass: "pf-icon pf-16 pf-ok",
                text: '<i class="pf-icon pf-16 pf-reload_rotate" title="Перечитати"></i>',
                title: "Перечитати",
                click: function () {
                    reloadGrids();
                },
                enable: !doThis()
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

    var tts_list = kendo.data.Model.define({
        id: tts_list,
        fields: { TT: { type: "string" }, NAME_: {type:"string"} }
    });

    var tts_data = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: { read: { dataType: 'json', url: bars.config.urlContent('/sto/Contract/GetTTS')} },
        schema: { data: "data", model: tts_list }
    });

    $('#ttsddl').kendoDropDownList({
        dataSource: tts_data,
        filters: "contain",
        dataTextField: "NAME_",
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
            $('#from').val(kendo.toString(kendo.parseDate(today, 'dd/MM/yyyy'), 'dd/MM/yyyy'));
            $('#from').val(null);
            $('#nazn').val(null);
            $('#mfo_b').val(null);
            $('#nls_b').val(null);
            $('#okpo_b').val(null);
            $('#name_b').val(null);
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

                var kv_a_data = new kendo.data.DataSource({
                    type: "aspnetmvc-ajax",
                    transport: { read: { dataType: 'json', url: bars.config.urlContent('/sto/Contract/GetKVs?RNK=' + currentRowData.RNK) } },
                    schema: { data: "data", model: nls_list }
                });

                $('#kv_a').kendoDropDownList({
                    dataSource: kv_a_data,
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

                var kv_b_data = new kendo.data.DataSource({
                    type: "aspnetmvc-ajax",
                    transport: { read: { dataType: 'json', url: bars.config.urlContent('/sto/Contract/GetKVs?RNK=' + null) } },
                    schema: { data: "data", model: nls_list }
                });

                $('#kv_b').kendoDropDownList({
                    dataSource: kv_b_data,
                    dataTextField: "NAME",
                    dataValueField: "KV",
                    filter: "contains",
                    change: function () {
                    },
                    select: function (e) {
                        selected_kv_b = this.dataItem(e.item).KV;
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
        else alert('Оберіть платника в верхньому списку!');
    }
    prepareNewSto = function () {
        var wnd_stolst = $("#wnd_stolst").data("kendoWindow");
        var grid = $("#Contract").data("kendoGrid");               
        if (global_idg >= 1) {
            var today = new Date();
            $('#from_ids').val(kendo.toString(kendo.parseDate(today, 'dd/MM/yyyy'), 'dd/MM/yyyy'));
            wnd_stolst.center().open();
        }
        else { alert('Оберіть групу платежів з випадаючого списку вгорі!');}
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
    $('#kvddl').kendoDropDownList({
        dataTextField: "name",
        dataValueField: "kv",
        dataSource: {
            data: [
                { kv: 980, name: "Гривня Украіни" },
                { kv: 840, name: "Доллар США" },
                { kv: 978, name: "Євро" }
            ]
        }
    });
    $("#NPP").kendoNumericTextBox({
        width: "100px",
        maxlength: "5",
        readonly: false,
        spinners: true,
        format: "d",
        min:1
    });
    $("#summ").kendoNumericTextBox({
        width: "100px",
        maxlength: "15",
        readonly: false,
        spinners: true,
        format: "d",
        placeholder: "Введіть суму"
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
    $("#RNK").kendoMaskedTextBox({
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


    validatePayment = function () {
        var $stoFrm = $('#wnd_stodet');        
        if ($stoFrm.find('#NPP').val() == null) { alert('Введіть порядок виконання платежу'); return false; }
        else {
            return true;          
        }        
    }
    validateIDS = function () {
        var $stoFrm = $('#wnd_stolst');
        if ($stoFrm.find('#RNK_LIST').val() == null) { alert('Оберіть клієнта'); return false; }
        else {
            return true;
        }
    }

    collectPayment = function () {
        var $stoFrm = $('#wnd_stodet');      
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
            nazn :$stoFrm.find('#nazn').val(),
            fsum :$stoFrm.find('#summ').val(),
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
            status_text : ""}
    }
    collectIDS = function () {
        var $stoFrm = $('#wnd_stolst');
        return {
            RNK: $stoFrm.find('#RNK_LIST').val(),
            NAME :$stoFrm.find('#name_ids').val(),
            SDAT :$stoFrm.find('#from_ids').val(),
            IDG : global_idg
        }
    }
    saveIDS = function () {
        if (validateIDS()) {
            collectIDS();
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/sto/Contract/AddIDS'),
                data: collectIDS(),
                success: function (data) {
                    if (data.status == 'error' && data.message != 'Sequence contains no elements') {
                        alert('Не збережено!     ' + data.message);
                    } else {
                        alert('Збережено!')
                    }
                },
                error: function (data) { alert(data.message); }
            });
        }
    };

    savePayment = function () {
        if (validatePayment()) {
            collectPayment();
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent('/sto/Contract/AddPayment'),
                    data: collectPayment(),
                    success: function (data) {
                        if (data.status == 'error' && data.message != 'Sequence contains no elements') {
                            alert('Не збережено!     ' + data.message);
                        } else {
                            alert('Збережено!')
                        }
                    },
                    error: function (data) { alert(data.message);}
                });
        }
    };
    $("#buttonsave").kendoButton();
    var button = $("#buttonsave").data("kendoButton");
    button.bind("click", function (e) {
        var wnd = $("#wnd_stodet").data("kendoWindow");
        savePayment();
        wnd.refresh();
        showActualGrpData();
    });

    $("#buttonSearch").kendoButton();
    var buttonSearchRNK = $("#buttonSearch").data("kendoButton");
    buttonSearchRNK.bind("click", function (e) {
        var $stoFrm = $('#wnd_stolst');        
        var OKPO = $stoFrm.find('#RNK').val();
        var rnk_list = kendo.data.Model.define({
            id: rnk_list,
            fields: { RNK: { type: "int" }, NMK: { type: "string" } }
        });

        var rnk_data = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            transport: { read: { dataType: 'json', url: bars.config.urlContent('/sto/Contract/GetRNKLIST?OKPO=' + OKPO) } },
            schema: { data: "data", model: rnk_list }
        });

        $('#RNK_LIST').kendoDropDownList({
            dataTextField: "NMK",
            dataValueField: "RNK",
            dataSource: rnk_data
        });
        }
    );
    $("#buttonsaveids").kendoButton();
    var buttonIDS = $("#buttonsaveids").data("kendoButton");
    buttonIDS.bind("click", function (e) {
        var wnd = $("#wnd_stolst").data("kendoWindow");
        saveIDS();
        wnd.refresh();
        $('#Contract').data('kendoGrid').dataSource.read();
        $('#Contract').data('kendoGrid').refresh();
        showActualGrpData();
    });
    $("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{ size: "60%" }, {}]
    })
});