$(document).ready(function () {

    function setDefaultRow() {
        var grid = $('#OperList').data('kendoGrid');
        if (grid != null) {
            grid.select("tr:eq(1)");
        }
    }

    var tabstrip = $("#tabstrip").kendoTabStrip({
        animation: { open: { effects: "fadeIn" } }
    }).data("kendoTabStrip").select(0);


    function updateInfoTab() {
        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());
        var infoBox = $("#infoBox");
        if (record) {
            infoBox.show();
            var template = kendo.template($("#info-template").html());
            infoBox.html(template(record));
        } else {
            infoBox.hide();
        }


        /*var operItem = new kendo.data.DataSource({
            transport: {
                read: {
                    url: bars.config.urlContent("/admin/api/oper/"),
                    dataType: "json",
                    type: "GET",
                    data: getCurrentOperId,
                    success: function (model) {
                        // convert the JSON to observable object
                        var viewModel = kendo.observable(model);
                        // bind the model to the container
                        kendo.bind(template, viewModel);
                    }
                }
            }
        });
        operItem.read();
        operItem.refresh();*/
    }

    var dataMask =
    [
        { ID: "1", NAZN: "Рахунок А/для СПЛАТИ", ACC_MASK: "", KV: "", BANK: "*", KP: "*" },
        { ID: "2", NAZN: "Рахунок Б/для СПЛАТИ", ACC_MASK: "", KV: "", BANK: "*", KP: "" },
        { ID: "3", NAZN: "Рахунок банку А/для ВВОДУ", ACC_MASK: "", KV: "*", BANK: "*", KP: "*" },
        { ID: "4", NAZN: "Рахунок банку Б/для ВВОДУ", ACC_MASK: "", KV: "*", BANK: "", KP: "*" },
        { ID: "5", NAZN: "Рахунок валютної позиції", ACC_MASK: "", KV: "*", BANK: "*", KP: "*" },
        { ID: "6", NAZN: "Рахунок маржинальних прибутків", ACC_MASK: "", KV: "*", BANK: "*", KP: "*" },
        { ID: "7", NAZN: "Рахунок маржинальних витрат", ACC_MASK: "", KV: "*", BANK: "*", KP: "*" }
    ];

    var currentOperData = [
        { NAZN: "Формула суми-А документу", VAL: "" },
        { NAZN: "Формула суми-Б документу", VAL: "" },
        { NAZN: "Призначення сплати за замовченням", VAL: "" },
        { NAZN: "Приорітет транзакції", VAL: "" }
    ];;

    function updateChildGrid() {
        var grid = $("#OperList").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());

        if (!!currentRow) {
            var dkDropList = $("#dropdown_transactionType").data("kendoDropDownList");
            var fliDropList = $("#dropdown_transactionView").data("kendoDropDownList");
            dkDropList.select(currentRow.DK);
            fliDropList.select(currentRow.FLI);

            if (currentRow.FLC === 1) {
                $("#hardTransaction").prop("checked", true);
                $("#RelatedTransactionsGrid").show();
                tabstrip.enable(tabstrip.tabGroup.children().eq(2), true);
            } else if (currentRow.FLC === 0) {
                $("#hardTransaction").prop("checked", false);
                $("#RelatedTransactionsGrid").hide();
                tabstrip.enable(tabstrip.tabGroup.children().eq(2), false);
            }

            if (currentRow.FLV === 1) {
                $("#multiTransaction").prop("checked", true);
            } else if (currentRow.FLV === 0) {
                $("#multiTransaction").prop("checked", false);
            }
            
            $("#FlagsGrid").data("kendoGrid").dataSource.read();
            $("#FlagsGrid").data("kendoGrid").refresh();

            $("#PropsGrid").data("kendoGrid").dataSource.read();
            $("#PropsGrid").data("kendoGrid").refresh();

            $("#BalanceAccountsGrid").data("kendoGrid").dataSource.read();
            $("#BalanceAccountsGrid").data("kendoGrid").refresh();

            $("#RelatedTransactionsGrid").data("kendoGrid").dataSource.read();
            $("#RelatedTransactionsGrid").data("kendoGrid").refresh();

            $("#VobGrid").data("kendoGrid").dataSource.read();
            $("#VobGrid").data("kendoGrid").refresh();

            $("#MonitoringGroupGrid").data("kendoGrid").dataSource.read();
            $("#MonitoringGroupGrid").data("kendoGrid").refresh();

            $("#FoldersGrid").data("kendoGrid").dataSource.read();
            $("#FoldersGrid").data("kendoGrid").refresh();

            updateInfoTab();

            // dataSource for AccountGrid
            // row ID = 1
            dataMask[0].ACC_MASK = currentRow.NLSM;
            dataMask[0].KV = currentRow.KV;
            // row ID = 2
            dataMask[1].ACC_MASK = currentRow.NLSK;
            dataMask[1].KV = currentRow.KVK;
            dataMask[1].KP = currentRow.SK;
            // row ID = 3
            dataMask[2].ACC_MASK = currentRow.NLSA;
            // row ID = 4
            dataMask[3].ACC_MASK = currentRow.NLSB;
            dataMask[3].BANK = currentRow.MFOB;
            // row ID in (5, 6, 7)
            dataMask[4].ACC_MASK = currentRow.S3800;
            dataMask[5].ACC_MASK = currentRow.S6201;
            dataMask[6].ACC_MASK = currentRow.S7201;

            $("#AccountGrid").data("kendoGrid").dataSource.read();
            $("#AccountGrid").data("kendoGrid").refresh();

            // dataSource for AccountGridOptions 
            currentOperData[0].VAL = currentRow.S;
            currentOperData[1].VAL = currentRow.S2;
            currentOperData[2].VAL = currentRow.NAZN;
            currentOperData[3].VAL = currentRow.RANG;

            $("#AccountGridOptions").data("kendoGrid").dataSource.read();
            $("#AccountGridOptions").data("kendoGrid").refresh();

            //flagConverter(currentRow.FLAGS);
        }
    }

    function closeAndRefreshWindow() {
        // all windows
        $(":input").val("");

        // groups only
        var element = document.getElementById("charge-dropdown");
        if (element.tagName === "select") {
            var dropdownlist = $("#charge-dropdown").data("kendoDropDownList");
            dropdownlist.select(1);
        }
        if ($(":checkbox")) {
            $(":checkbox").attr("checked", false);
            $("#sql-box").hide();
        }

        // prop only
        if ($(":radio")) {
            $("#opt_M").checked = true;
            $("#labM").addClass("btn btn-default active");

            $("#opt_O").checked = false;
            $("#labO").removeClass("btn btn-default active").addClass("btn btn-default");;
        }

        $(this).closest("[data-role=window]").kendoWindow("close");
    }

    /*function flagDropDownEditor(container, options) {
        $("<input id='flagDropDown' required style='width: 100%;' data-text-field='NAME' data-value-field='CODE' data-bind='value:" + options.field + "'/>")
            .appendTo(container)
            .kendoDropDownList({
                dataTextField: "NAME",
                dataValueField: "CODE",
                index: 1,
                dataSource: [
                        { NAME: "Вид ЭЦП при вводе(0-Отсут, 1-Внутр, 2-СЭП, 3-Внутр+СЭП)", CODE: "1" }
                ]
            });
    }*/

    function createObjectModel() {
        var grid = $("#OperList").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());

        var dkDropList = $("#dropdown_transactionType").data("kendoDropDownList");
        var fliDropList = $("#dropdown_transactionView").data("kendoDropDownList");

        var displayedAccountData = $("#AccountGrid").data().kendoGrid.dataSource.view();
        var displayedAccOptionData = $("#AccountGridOptions").data().kendoGrid.dataSource.view();

        return {
            TT: currentRow.TT,
            DK: dkDropList.value(),
            FLAGS: currentRow.FLAGS, // *
            FLC: $("#hardTransaction").prop("checked") ? 1 : 0,
            FLI: fliDropList.value(),
            FLR: currentRow.FLR, // *
            FLV: $("#multiTransaction").prop("checked") ? 1 : 0,
            KV: displayedAccountData[0].KV,
            KVK: displayedAccountData[1].KV,
            MFOB: displayedAccountData[3].BANK,
            NAME: currentRow.NAME,
            NAZN: displayedAccOptionData[2].VAL,
            NLSA: displayedAccountData[2].ACC_MASK,
            NLSB: displayedAccountData[3].ACC_MASK,
            NLSK: displayedAccountData[1].ACC_MASK,
            NLSM: displayedAccountData[0].ACC_MASK,
            NLSS: currentRow.NLSS, // *
            PROC: currentRow.PROC, // *
            RANG: displayedAccOptionData[3].VAL,
            S: displayedAccOptionData[0].VAL,
            S2: displayedAccOptionData[1].VAL,
            S3800: displayedAccountData[4].ACC_MASK,
            S6201: displayedAccountData[5].ACC_MASK,
            S7201: displayedAccountData[6].ACC_MASK,
            SK: displayedAccountData[1].KP
        }
    }

    var remoteDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/oper/GetOperGrid")
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    TT: { type: "string", validation: { required: { message: "ID операції є обов'язковою!" }, min: 1 } },
                    DK: { type: "number" },
                    FLAGS: { type: "string" },
                    FLC: { type: "number"  },
                    FLI: { type: "number" },
                    FLR: { type: "number" },
                    FLV: { type: "number" },
                    KV: { type: "number" },
                    KVK: { type: "number" },
                    MFOB: { type: "string" },
                    NAME: { type: "string", validation: { required: { message: "Найменування операції є обов'язковим!" }, min: 1 } },
                    NAZN: { type: "string" },
                    NLSA: { type: "string" },
                    NLSB: { type: "string" },
                    NLSK: { type: "string" },
                    NLSM: { type: "string" },
                    NLSS: { type: "string" },
                    PROC: { type: "number" },
                    RANG: { type: "number" },
                    S: { type: "string" },
                    S2: { type: "string" },
                    S3800: { type: "number" },
                    S6201: { type: "number" },
                    S7201: { type: "number" },
                    SK: { type: "number" }
                }
            }
        }
    });

    var operGrid = $("#OperList").kendoGrid({
        autoBind: true,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: true,
        //toolbar: kendo.template($("#template").html()),
        toolbar: ["create"],
        editable: {
            mode: "popup",
            window: {
                title: "Створення нової операції",
                width: "600px"
            }
        },
        save: function (e) {

            var that = this;
            $.ajax({
                type: 'POST',
                url: bars.config.urlContent("/api/admin/oper/operitemupdate"),
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify(e.model),
                success: function (data) {
                    //alert(data);
                    that.refresh();
                },
                error: function (data) {
                    //alert(data);
                    that.cancelRow();
                }

            });

        },
        columns: [
            {
                field: "TT",
                title: "Код",
                width: "200px"
            },
            {
                field: "NAME",
                title: "Назва банківської операції",
                width: "500px"
            }/*,
            {
                hidden: true,
                field: "DK",
                title: "Признак<br/>дебета/кредита",
                width: "100px"
            },
            {
                hidden: true,
                field: "FLAGS",
                editor: flagDropDownEditor,
                title: "Настроечные технологические<br/>флаги",
                width: "400px"
            },
            {
                hidden: true,
                field: "FLC",
                title: "Признак<br/>Forced Payment",
                width: "100px"
            },
            {
                hidden: true,
                field: "FLI",
                title: "0	Внутрибанковский<br/>1	Межбанковский - СЭП НБУ<br/>2	Межбанковский - SWIFT<br/>3	Процессинг - СЭП НБУ",
                width: "200px"
            },
            {
                hidden: true,
                field: "FLR",
                title: "_FLR",
                width: "100px"
            },
            {
                hidden: true,
                field: "FLV",
                title: "Признак<br/>мультивалютной<br/>операции",
                width: "100px"
            },
            {
                hidden: true,
                field: "KV",
                title: "Код<br/>валюты1",
                width: "100px"
            },
            {
                hidden: true,
                field: "KVK",
                title: "Код<br/>валюты2",
                width: "100px"
            },
            {
                hidden: true,
                field: "MFOB",
                title: "МФО<br/>корреспондента",
                width: "100px"
            },
            {
                hidden: true,
                field: "NAZN",
                title: "Для дефолтного<br/>текста назначения <br/>платежа в карточке<br/>операции",
                width: "500px"
            },
            {
                hidden: true,
                field: "NLSA",
                title: "Счет основной<br/>для ввода",
                width: "100px"
            },
            {
                hidden: true,
                field: "NLSB",
                title: "Счет корреспондента<br/>для ввода",
                width: "100px"
            },
            {
                hidden: true,
                field: "NLSK",
                title: "Счет корреспондента<br/>для оплаты",
                width: "100px"
            },
            {
                hidden: true,
                field: "NLSM",
                title: "Счет основной<br/>для оплаты",
                width: "100px"
            },
            {
                hidden: true,
                field: "NLSS",
                title: "Счет<br/>SUSPEND (902)",
                width: "100px"
            },
            {
                hidden: true,
                field: "PROC",
                title: "_PROC",
                width: "100px"
            }*/
        ],
        dataSource: remoteDataSource,
        filterable: true,
        change: updateChildGrid,
        dataBound: function() {
            //console.log("databound opergrid");
            setDefaultRow();
        }
    });

    function getCurrentOperId() {
        var grid = $("#OperList").data("kendoGrid")
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow) {
            return { tt: currentRow.TT };
        }
        return null;
    }

// FlagsProps_Tab ***

    function flagConverter() {
        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());
        var flag = record.FLAGS;
        if (flag) {
            var arrIn = [];
            var arrOut = [];
            arrIn = flag.split("");
            for (var i = 0; i < arrIn.length; i++) {
                if (arrIn[i] !== "0") {
                    arrOut.push(i);
                }
            }
            if (arrOut.length > 0) {
                /*$.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/oper/GetFlags"), // try to use api
                    dataType: "json",
                    traditional: true,
                    data: { "flags": arrOut }
                }).done(function (result) {
                    var response = result.Data;
                    var str = "";
                    for (var i = 0; i < response.length; i++) {
                        str += response[i].CODE + " - " + response[i].NAME + "<br/>";
                    }
                    $("#info-flags").html(str);
                });*/
                return { "flags": arrOut , "tt" : record.TT };
            } else {
                arrOut.push(1); //  DEFAULT '01'
                return { "flags": arrOut , "tt": record.TT};
            }
        }
    }
    
    var remoteFlagsDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                type: "POST",
                url: bars.config.urlContent("/admin/oper/GetFlags"),
                data: flagConverter
            }
        },
        requestEnd: function (e) {
            var response = e.response.Data;
            var str = "";
            var rw = [];
            for (var i = 0; i < response.length; i++) {
                str += response[i].FCODE + " - " + response[i].NAME + "<br/>";
                rw.push(response[i].VALUE);
            }
            $("#info-flags").html(str);
            if (rw.indexOf(1) >= 0) {
                var canWrite = "Оперція доступна на внесення.";
                $("#info-rw").html(canWrite);
            } else {
                var noWrite = "Операція недоступна на внесення";
                $("#info-rw").html(noWrite);
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    /*CODE: { type: "number" },
                    NAME: { type: "string" },
                    EDIT: { type: "number" },
                    OPT: { type: "number" }*/
                    FCODE: { type: "number" },
                    NAME: { type: "string" },
                    VALUE: { type: "number" }
                }
            }
        }
    });

    function removeFlagFromGrid() {
        $("#FlagsGrid").data("kendoGrid").tbody.find("button[name='removeFlag']").click(function (e) {
            var gview = $("#FlagsGrid").data("kendoGrid");
            var dataItem = gview.dataItem($(e.currentTarget).closest("tr"));

            //alert("FCODE : " + dataItem.FCODE);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте видалити флаг<br/>" + dataItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                var flagCode = dataItem.FCODE;
                var flagStr = record.FLAGS;
                var operTT = record.TT;

                var arrIn = [];

                arrIn = flagStr.split("");
                for (var i = 0; i < arrIn.length; i++) {
                    if (i === flagCode) {
                        arrIn[i] = 0;
                    }
                }
                var newFlag = arrIn.join([separator = ""]);
                var model = createObjectModel();
                model["FLAGS"] = newFlag;
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/oper/operitemupdate"),
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(model),
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#FlagsGrid").data("kendoGrid").dataSource.read();
                    $("#FlagsGrid").data("kendoGrid").refresh();
                });
            });
        });
    }

    var flagsGrid = $("#FlagsGrid").kendoGrid({
        autoBind: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: true,
        toolbar: kendo.template($("#addFlags-template").html()),
        columns: [
            {
                field: "FCODE",
                title: "Код",
                width: "200px"
            },
            {
                field: "NAME",
                title: "Назва флагу",
                width: "200px"
            },
            {
                field: "VALUE",
                title: "Значення",
                width: "200px"
            },
            {
                command: [
                  {
                      template: "<button name='removeFlag' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>"
                  }
                ],

                title: "Дії над<br/>флагом<br/>",
                width: "100px"
            }
        ],
        dataSource: remoteFlagsDataSource,
        filterable: true,
        change: function () {
            //
        },
        dataBound: removeFlagFromGrid
    });

    var flags = $("#flags-grid").kendoGrid({
        filterable: true,
        autoBind: false,
        selectable: "row",
        hight: "500px",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 7
        },
        columns: [
            {
                field: "CODE",
                width: "100px",
                title: "Код"
            },
            {
                field: "NAME",
                width: "200px",
                title: "Назва"
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
                    url: bars.config.urlContent("/admin/oper/GetFlagsHandbook"),
                    data: flagConverter
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        CODE: { type: "number" },
                        NAME: { type: "string" },
                        EDIT: { type: "number" },
                        OPT: { type: "number" }
                    }
                }
            }
        }
    });

    flags.hide();
    $("#flag-tbl").hide();

    function flagsHandbook() {

        $("#flags-grid").data("kendoGrid").dataSource.read();
        $("#flags-grid").data("kendoGrid").refresh();

        var flagsWindow = $("#flags-window").kendoWindow({
            title: "Флаги",
            visible: false,
            width: "600px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"]
        });

        flags.show();

        var window = flagsWindow.data("kendoWindow");
        window.center().open();

        var flagAddWindow = $("#flag-add-window").kendoWindow({
            title: "Додавання флагу ",
            visible: false,
            width: "600px",
            scrollable: false,
            resizable: false,
            modal: true,
            actions: ["Close"]
        });

        function addFlag(tt, flag) {
            var model = createObjectModel();
            model["FLAGS"] = flag;
            
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/operitemupdate"),
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(model),
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#flags-grid").data("kendoGrid").dataSource.read();
                $("#flags-grid").data("kendoGrid").refresh();
                $("#FlagsGrid").data("kendoGrid").dataSource.read();
                $("#FlagsGrid").data("kendoGrid").refresh();
            });
        }

        $("#flags-grid").on("dblclick", "tbody > tr", function () {
            var gview = $("#flags-grid").data("kendoGrid");
            var selectedItem = gview.dataItem(gview.select());
            //alert("Обраний флаг. CODE : " + selectedItem.CODE + "NAME : " + selectedItem.NAME);

            var grid = $("#OperList").data("kendoGrid");
            var record = grid.dataItem(grid.select());

            var window = flagAddWindow.data("kendoWindow");
            window.title("Опції флагу : <b> " + selectedItem.NAME + "</b>");

            window.center().open();
            $("#flag-tbl").show();

            $("#flag-add").on("click", function () {
                var flagCode = selectedItem.CODE;
                var flagValue = $("#fVal").val();
                var flagStr = record.FLAGS;
                var operTT = record.TT;

                var arrIn = [];

                arrIn = flagStr.split("");
                for (var i = 0; i < arrIn.length; i++) {
                    if (i === flagCode) {
                        arrIn[i] = flagValue;
                    }
                }
                var newFlag = arrIn.join([separator = ""]);
                addFlag(operTT, newFlag);
                window.close();
            });
        });
    }

    $("#fVal").keyup(function () {
        this.value = this.value.replace(/[^0-9\.]/g, '');
    });

    $("#FlagsGrid").on("dblclick", "tbody > tr", flagsHandbook);

    $("#btn_addFlag").on("click", flagsHandbook);

    $("#flag-cencel").on("click", closeAndRefreshWindow);
    
    //***
    var remotePropsDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                type: "GET",
                url: bars.config.urlContent("/admin/oper/GetProps"),
                data: getCurrentOperId
            }
        },
        requestEnd: function (e) {
            var response = e.response.Data;
            var str = "";
            for (var i = 0; i < response.length; i++) {
                str += response[i].TAG + " - " + response[i].NAME + "<br/>";
            }
            $("#info-props").html(str);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    TAG: { type: "string" },
                    NAME: { type: "string" },
                    OPT: { type: "string" },
                    USED4INPUT: { type: "number" },
                    ORD: { type: "number" },
                    VAL: { type: "string" }
                }
            }
        }
    });

    function propOptions() {
        // remove option
        $("#PropsGrid").data("kendoGrid").tbody.find("button[name='removeProp']").click(function (e) {
            var gview = $("#PropsGrid").data("kendoGrid");
            var dataItem = gview.dataItem($(e.currentTarget).closest("tr"));

            //alert("TAG : " + dataItem.TAG);
            bars.ui.confirm({
                text: "Ви дійсно бажаєте видалити реквізит<br/>" + dataItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/oper/updateprop?id=" + record.TT + "&tag=" + dataItem.TAG + "&opt=" + dataItem.OPT + "&used=" + dataItem.USED4INPUT + "&ord=" + dataItem.ORD + "&val=" + dataItem.VAL),
                    dataType: "json",
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#PropsGrid").data("kendoGrid").dataSource.read();
                    $("#PropsGrid").data("kendoGrid").refresh();
                });
            });
        });

        // checkboxs event
        $('.opt').on("click", function () {
            var grid = $("#OperList").data("kendoGrid");
            var record = grid.dataItem(grid.select());

            var row = $(this).closest("tr");
            var gridProp = $("#PropsGrid").data("kendoGrid");
            var dataItem = gridProp.dataItem(row);

            if (this.checked) {
                dataItem.OPT = "M";
            } else {
                dataItem.OPT = "O";
            }

            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/updateprop?id=" + record.TT + "&tag=" + dataItem.TAG + "&opt=" + dataItem.OPT + "&used=" + dataItem.USED4INPUT + "&ord=" + dataItem.ORD + "&val=" + dataItem.VAL),
                dataType: "json",
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#PropsGrid").data("kendoGrid").dataSource.read();
                $("#PropsGrid").data("kendoGrid").refresh();
            });
        });

        $('.used').on("click", function () {
            var grid = $("#OperList").data("kendoGrid");
            var record = grid.dataItem(grid.select());

            var row = $(this).closest("tr");
            var gridProp = $("#PropsGrid").data("kendoGrid");
            var dataItem = gridProp.dataItem(row);

            if (this.checked) {
                dataItem.USED4INPUT = 1;
            } else {
                dataItem.USED4INPUT = 0;
            }

            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/updateprop?id=" + record.TT + "&tag=" + dataItem.TAG + "&opt=" + dataItem.OPT + "&used=" + dataItem.USED4INPUT + "&ord=" + dataItem.ORD + "&val=" + dataItem.VAL),
                dataType: "json",
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#PropsGrid").data("kendoGrid").dataSource.read();
                $("#PropsGrid").data("kendoGrid").refresh();
            });
        });
    }

    var propsGrid = $("#PropsGrid").kendoGrid({
        autoBind: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: true,
        toolbar: kendo.template($("#addProps-template").html()),
        columns: [
            {
                field: "TAG",
                title: "Код",
                width: "200px"
            },
            {
                field: "NAME",
                title: "Назва реквізиту",
                width: "200px"
            },
            {
                field: "OPT",
                title: "Обов'язковість<br/>реквізиту",
                template: "<input class='opt' name='opt' type='checkbox' #: OPT === 'M' ? 'checked=checked' : '' # ></input>",
                width: "200px"
            },
            {
                field: "USED4INPUT",
                title: "Використовувати<br/>для вводу",
                template: "<input class='used' name='used' type='checkbox' #: USED4INPUT === 1 ? 'checked=checked' : '' #></input>",
                width: "200px"
            },
            {
                field: "ORD",
                title: "Номер<br/>реквізиту(для сортування)",
                width: "200px"
            },
            {
                field: "VAL",
                title: "Значення<br/>за замовчуванням",
                width: "200px"
            },
            {
                command: [
                  {
                      template: "<button name='removeProp' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>"
                  }
                ],

                title: "Дії над<br/>реквізитом<br/>",
                width: "100px"
            }
        ],
        dataSource: remotePropsDataSource,
        filterable: true,
        change: function () {
            //
        },
        dataBound: propOptions
    });

    var props = $("#props-grid").kendoGrid({
        filterable: true,
        autoBind: false,
        selectable: "row",
        hight: "500px",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 7
        },
        columns: [
            {
                field: "TAG",
                width: "100px",
                title: "Код"
            },
            {
                field: "NAME",
                width: "200px",
                title: "Назва"
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
                    url: bars.config.urlContent("/admin/oper/GetPropsHandbook"),
                    data: getCurrentOperId
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        TAG: { type: "string" },
                        NAME: { type: "string" }
                    }
                }
            }
        }
    });

    props.hide();
    $("#prop-tbl").hide();

    function propsHandbook() {

        $("#props-grid").data("kendoGrid").dataSource.read();
        $("#props-grid").data("kendoGrid").refresh();

        var flagsWindow = $("#props-window").kendoWindow({
            title: "Реквізити",
            visible: false,
            width: "600px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"]
        });

        props.show();

        var window = flagsWindow.data("kendoWindow");
        window.center().open();

        var propAddWindow = $("#prop-add-window").kendoWindow({
            title: "Додавання реквізиту ",
            visible: false,
            width: "600px",
            scrollable: false,
            resizable: false,
            modal: true,
            actions: ["Close"]
        });

        function addProperty(tt, tag, obj) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/updateprop?id=" + tt + "&tag=" + tag + "&" + obj),
                dataType: "json",
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#props-grid").data("kendoGrid").dataSource.read();
                $("#props-grid").data("kendoGrid").refresh();
                $("#PropsGrid").data("kendoGrid").dataSource.read();
                $("#PropsGrid").data("kendoGrid").refresh();
            });
        }

        $("#props-grid").on("dblclick", "tbody > tr", function () {
            var gview = $("#props-grid").data("kendoGrid");
            var selectedItem = gview.dataItem(gview.select());
            //alert("Обраний реквізит. TAG: " + selectedItem.TAG + "NAME : " + selectedItem.NAME);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати реквізит<br/>" + selectedItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                var window = propAddWindow.data("kendoWindow");
                window.title("Опції реквізиту : <b> " + selectedItem.NAME + "</b>");

                window.center().open();
                $("#prop-tbl").show();

                $("#prop-add").on("click", function () {
                    var obj = $("#prop-form").serialize();
                    var tag = selectedItem.TAG;
                    tag = tag.replace(/\s+/g, '');
                    addProperty(record.TT, tag, obj);
                    window.close();
                });
            });

        });
    }

    $("#PropsGrid").on("dblclick", "tbody > tr", propsHandbook);

    $("#btn_addProp").on("click", propsHandbook);

    $("#prop-cencel").on("click", closeAndRefreshWindow);

// End FlagsProps_Tab

// Balance Accounts Tab

    var remoteBalanceAccsDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/oper/GetBalanceAccounts"),
                data: getCurrentOperId
            }
        },
        requestEnd: function (e) {
            /*var response = e.response;
            var str = "";
            for (var i = 0; i < response.Data.length; i++) {
                str += response.Data[i].NAME + "<br/>";
            }
            $("#info-transactions").html(str);*/
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    NBS: { type: "string" },
                    NAME: { type: "string" },
                    OB22: { type: "string" },
                    DK: { type: "number" }
                }
            }
        }
    });

    function removeAccFromBalanceGrid() {
        $("#BalanceAccountsGrid").data("kendoGrid").tbody.find("button[name='removeAccount']").click(function (e) {
            var gview = $("#BalanceAccountsGrid").data("kendoGrid");
            var dataItem = gview.dataItem($(e.currentTarget).closest("tr"));
            //alert("NBS : " + dataItem.NBS);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте видалити рахунок<br/>" + dataItem.NAME + " ?"
            }, function() {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/oper/deleteacc?id=" + record.TT + "&nbs=" + dataItem.NBS + "&dk=" + dataItem.DK + "&ob=" + dataItem.OB22),
                    dataType: "json",
                    traditional: true
                }).done(function(result) {
                    bars.ui.alert({ text: result });
                    $("#BalanceAccountsGrid").data("kendoGrid").dataSource.read();
                    $("#BalanceAccountsGrid").data("kendoGrid").refresh();
                });
            });
        });
    }

    var balanceAccGrid = $("#BalanceAccountsGrid").kendoGrid({
        autoBind: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: true,
        toolbar: kendo.template($("#addBalAccounts-template").html()),
        columns: [
            {
                field: "NBS",
                title: "Номер рахунку",
                width: "200px"
            },
            {
                field: "NAME",
                title: "Назва балансового рахунку",
                width: "200px"
            },
            {
                field: "DK",
                title: "Д/К",
                width: "200px"
            },
            {
                field: "OB22",
                title: "OB22",
                width: "200px"
            },
            {
                command: [
                  {
                      template: "<button name='removeAccount' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>"
                  }
                ],

                title: "Дії над<br/>рахунком<br/>",
                width: "100px"
            }
        ],
        dataSource: remoteBalanceAccsDataSource,
        filterable: true,
        change: function () {
            //
        },
        dataBound: removeAccFromBalanceGrid
    });

    var accounts = $("#accs-grid").kendoGrid({
        filterable: true,
        autoBind: false,
        selectable: "row",
        hight: "500px",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 7
        },
        columns: [
            {
                field: "NBS",
                width: "100px",
                title: "Код"
            },
            {
                field: "NAME",
                width: "200px",
                title: "Назва"
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
                    url: bars.config.urlContent("/admin/oper/GetAccountsHandbook"),
                    data: getCurrentOperId
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        NBS: { type: "string" },
                        NAME: { type: "string" }
                    }
                }
            }
        }
    });

    accounts.hide();
    $("#acc-tbl").hide();

    function accountsHandbook() {

        $("#accs-grid").data("kendoGrid").dataSource.read();
        $("#accs-grid").data("kendoGrid").refresh();

        var transactionsWindow = $("#accs-window").kendoWindow({
            title: "Рахунки",
            visible: false,
            width: "600px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"]
        });

        accounts.show();

        var window = transactionsWindow.data("kendoWindow");
        window.center().open();

        var accAddWindow = $("#acc-add-window").kendoWindow({
            title: "Додавання рахунку ",
            visible: false,
            width: "600px",
            scrollable: false,
            resizable: false,
            modal: true,
            actions: ["Close"]
        });

        function addAccount(tt, nbs, obj) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/insertacc?id=" + tt + "&nbs=" + nbs + "&" + obj),
                dataType: "json",
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#accs-grid").data("kendoGrid").dataSource.read();
                $("#accs-grid").data("kendoGrid").refresh();
                $("#BalanceAccountsGrid").data("kendoGrid").dataSource.read();
                $("#BalanceAccountsGrid").data("kendoGrid").refresh();
            });
        }

        $("#accs-grid").on("dblclick", "tbody > tr", function () {
            var gview = $("#accs-grid").data("kendoGrid");
            var selectedItem = gview.dataItem(gview.select());
            //alert("Обраний рахунок. NBS : " + selectedItem.NBS + "NAME : " + selectedItem.NAME);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати рахунок<br/>" + selectedItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                var window = accAddWindow.data("kendoWindow");
                window.title("Опції рахунку : <b> " + selectedItem.NAME + "</b>");

                window.center().open();
                $("#acc-tbl").show();

                $("#acc-add").on("click", function () {
                    var obj = $("#acc-form").serialize();
                    var nbs = selectedItem.NBS;
                    nbs = nbs.replace(/\s+/g, '');
                    addAccount(record.TT, nbs, obj);
                    window.close();
                });
            });
        });
    }

    $("#BalanceAccountsGrid").on("dblclick", "tbody > tr", accountsHandbook);

    $("#btn_addAcc").on("click", accountsHandbook);

    $("#acc-cencel").on("click", closeAndRefreshWindow);

// End Balance Accounts Tab

// RelatedTransaction_Tab ***
    
    var remoteRelatedTransactionDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/oper/GetRelatedTransactionGrid"),
                data: getCurrentOperId
            }
        },
        requestEnd: function (e) {
            //alert("remoteRelatedTransactionDataSource");
            var response = e.response;
            var str = "";
            for (var i = 0; i < response.Data.length; i++) {
                str += response.Data[i].NAME + "<br/>";
            }
            $("#info-transactions").html(str);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    TTAP: { type: "string" },
                    NAME: { type: "string" },
                    DK: { type: "number" }
                }
            }
        }
    });

    function removeTransactionFromRelated() {
        $("#RelatedTransactionsGrid").data("kendoGrid").tbody.find("button[name='removeTransaction']").click(function (e) {
            var gview = $("#RelatedTransactionsGrid").data("kendoGrid");
            var dataItem = gview.dataItem($(e.currentTarget).closest("tr"));

            //alert("TTAP : " + dataItem.TTAP);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте видалити операцію <br/>" + dataItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/oper/deletetransaction?id=" + record.TT + "&ttap=" + dataItem.TTAP),
                    dataType: "json",
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#RelatedTransactionsGrid").data("kendoGrid").dataSource.read();
                    $("#RelatedTransactionsGrid").data("kendoGrid").refresh();
                });
            });
        });
    }

    var relatedTransactionsGrid = $("#RelatedTransactionsGrid").kendoGrid({
        autoBind: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: true,
        toolbar: kendo.template($("#addTransaction-template").html()),
        columns: [
            {
                field: "TTAP",
                title: "Код операції",
                width: "200px"
            },
            {
                field: "NAME",
                title: "Назва пов'язаної операції",
                width: "200px"
            },
            {
                field: "DK",
                title: "Інверсія Д/К",
                width: "200px"
            },
            {
                command: [
                  {
                      template: "<button name='removeTransaction' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>"
                  }
                ],

                title: "Дії над<br/>пов'язаною<br/>операцією",
                width: "100px"
            }
        ],
        dataSource: remoteRelatedTransactionDataSource,
        filterable: true,
        change: function() {
            //
        },
        dataBound: removeTransactionFromRelated
    });

    var transactions = $("#transactions-grid").kendoGrid({
        filterable: true,
        autoBind: false,
        selectable: "row",
        hight: "500px",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 7
        },
        columns: [
            {
                field: "TT",
                width: "100px",
                title: "Код"
            },
            {
                field: "NAME",
                width: "200px",
                title: "Назва"
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
                    url: bars.config.urlContent("/admin/oper/GetTransactionsHandbook"),
                    data: getCurrentOperId
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        TT: { type: "string" },
                        NAME: { type: "string" }
                    }
                }
            }
        }
    });

    transactions.hide();
    $("#transaction-tbl").hide();

    function transactionsHandbook() {

        $("#transactions-grid").data("kendoGrid").dataSource.read();
        $("#transactions-grid").data("kendoGrid").refresh();

        var transactionsWindow = $("#transactions-window").kendoWindow({
            title: "Операції",
            visible: false,
            width: "600px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"]
        });

        transactions.show();

        var window = transactionsWindow.data("kendoWindow");
        window.center().open();

        var transactionAddWindow = $("#transaction-add-window").kendoWindow({
            title: "Додавання пов'язаної операції ",
            visible: false,
            width: "600px",
            scrollable: false,
            resizable: false,
            modal: true,
            actions: ["Close"]
        });

        function addTransaction(tt, ttap, obj) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/inserttransaction?id=" + tt + "&ttap=" + ttap + "&" + obj),
                dataType: "json",
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#transactions-grid").data("kendoGrid").dataSource.read();
                $("#transactions-grid").data("kendoGrid").refresh();
                $("#RelatedTransactionsGrid").data("kendoGrid").dataSource.read();
                $("#RelatedTransactionsGrid").data("kendoGrid").refresh();
            });
        }

        $("#transactions-grid").on("dblclick", "tbody > tr", function () {
            var gview = $("#transactions-grid").data("kendoGrid");
            var selectedItem = gview.dataItem(gview.select());
            //alert("Обрана операція. TT : " + selectedItem.TT + "NAME : " + selectedItem.NAME);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати операцію <br/>" + selectedItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                var window = transactionAddWindow.data("kendoWindow");
                window.title("Опції операції : <b> " + selectedItem.NAME + "</b>");

                window.center().open();
                $("#transaction-tbl").show();

                $("#transaction-add").on("click", function () {
                    var obj = $("#transaction-form").serialize();
                    addTransaction(record.TT, selectedItem.TTAP, obj);
                    window.close();
                });
            });
        });
    }

    $("#RelatedTransactionsGrid").on("dblclick", "tbody > tr", transactionsHandbook);

    $("#btn_addTransaction").on("click", transactionsHandbook);

    $("#transaction-cencel").on("click", closeAndRefreshWindow);

// End RelatedTransaction_Tab ***


// VOB_Tab ***

    var remoteVobDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/oper/GetVobGrid"),
                data: getCurrentOperId
            }
        },
        requestEnd: function (e) {
            var response = e.response;
            var str = "";
            for (var i = 0; i < response.Data.length; i++) {
                str += response.Data[i].NAME + "<br/>";
            }
            $("#info-docs").html(str);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    VOB: { type: "number" },
                    NAME: { type: "string" },
                    REP_PREFIX: { type: "string" },
                    ORD: { type: "number" }
                }
            }
        }
    });

    function removeDocFromVob() {
        $("#VobGrid").data("kendoGrid").tbody.find("button[name='removeDoc']").click(function (e) {
            var gview = $("#VobGrid").data("kendoGrid");
            var dataItem = gview.dataItem($(e.currentTarget).closest("tr"));
            
            //alert("VOB : " + dataItem.VOB);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте видалити документ<br/>" + dataItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/oper/deletevob?id=" + record.TT + "&vobId=" + dataItem.VOB),
                    dataType: "json",
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#VobGrid").data("kendoGrid").dataSource.read();
                    $("#VobGrid").data("kendoGrid").refresh();
                });
            });
        });
    }

    var vobGrid = $("#VobGrid").kendoGrid({
        autoBind: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: true,
        toolbar: kendo.template($("#vobAddDoc-template").html()),
        columns: [
            {
                field: "VOB",
                title: "Код",
                width: "200px"
            },
            {
                field: "NAME",
                title: "НаВиди банківських документівзва",
                width: "200px"
            },
            {
                field: "REP_PREFIX",
                title: "Файл шаблону",
                width: "200px"
            },
            {
                field: "ORD",
                title: "Порядок",
                width: "200px"
            },
            {
                command: [
                  {
                      template: "<button name='removeDoc' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>"
                  }
                ],
                
                title: "Дії над документом",
                width: "100px"
            }
        ],
        dataSource: remoteVobDataSource,
        filterable: true,
        change: function() {
            //
        },
        dataBound: removeDocFromVob
    });

    var bankDocs = $("#bankDocs-grid").kendoGrid({
        filterable: true,
        autoBind: false,
        selectable: "row",
        hight: "500px",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 7
        },
        columns: [
            {
                field: "VOB",
                width: "100px",
                title: "Код"
            },
            {
                field: "NAME",
                width: "200px",
                title: "Назва"
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
                    url: bars.config.urlContent("/admin/oper/GetBankDocsHandbook"),
                    data: getCurrentOperId
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        VOB: { type: "number" },
                        NAME: { type: "string" }
                    }
                }
            }
        }
    });

    bankDocs.hide();
    $("#vob-tbl").hide();

    function bankDocsHandbook() {

        $("#bankDocs-grid").data("kendoGrid").dataSource.read();
        $("#bankDocs-grid").data("kendoGrid").refresh();

        var bankDocsWindow = $("#bankDocs-window").kendoWindow({
            title: "Документи",
            visible: false,
            width: "600px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"]
        });

        bankDocs.show();

        var window = bankDocsWindow.data("kendoWindow");
        window.center().open();

        var vobOrderNumber = $("#vob-order-window").kendoWindow({
            title: "Новий документ операції",
            visible: false,
            width: "400px",
            scrollable: false,
            resizable: false,
            modal: true,
            actions: ["Close"]
        });

        function addVob(tt, vobId, vobOrd) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/insertvob?id=" + tt + "&vobId=" + vobId + "&vobOrd=" + vobOrd),
                dataType: "json",
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#bankDocs-grid").data("kendoGrid").dataSource.read();
                $("#bankDocs-grid").data("kendoGrid").refresh();
                $("#VobGrid").data("kendoGrid").dataSource.read();
                $("#VobGrid").data("kendoGrid").refresh();
            });
        }

        $("#bankDocs-grid").on("dblclick", "tbody > tr", function() {
            var gview = $("#bankDocs-grid").data("kendoGrid");
            var selectedItem = gview.dataItem(gview.select());
            //alert("Обраний документ. ID : " + selectedItem.VOB + "NAME : " + selectedItem.NAME);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати документ<br/>" + selectedItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                var window = vobOrderNumber.data("kendoWindow");
                window.center().open();
                $("#vob-tbl").show();

                $("#vob-add").on("click", function () {
                    var ord = $("#vob-order").val();
                    addVob(record.TT, selectedItem.VOB, ord);
                    window.close();
                });
            });
        });
    }

    $("#VobGrid").on("dblclick", "tbody > tr", bankDocsHandbook);
    
    $("#btn_addDoc").on("click", bankDocsHandbook);

    $("#vob-cencel").on("click", closeAndRefreshWindow);

// End VOB Tab ***

// MonitoringGroup Tab

    var remoteMonitoringGroupDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/oper/GetMonitoringGroupsGrid"),
                data: getCurrentOperId
            }
        },
        requestEnd: function (e) {
            var response = e.response;
            var str = "";
            for (var i = 0; i < response.Data.length; i++) {
                str += response.Data[i].NAME + "<br/>";
            }
            $("#info-groups").html(str);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    IDCHK: { type: "number" },
                    NAME: { type: "string" },
                    F_IN_CHARGE: { type: "number" },
                    PRIORITY: { type: "number" },
                    SQLVAL: { type: "string" },
                    FLAGS: { type: "number" }
                }
            }
        }
    });

    function removeGroupFromGrid() {
        $("#MonitoringGroupGrid").data("kendoGrid").tbody.find("button[name='removeGroup']").click(function (e) {
            var gview = $("#MonitoringGroupGrid").data("kendoGrid");
            var dataItem = gview.dataItem($(e.currentTarget).closest("tr"));

            //alert("IDCHK : " + dataItem.IDCHK);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте видалити групу<br/>" + dataItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/oper/deletegroup?id=" + record.TT + "&gId=" + dataItem.IDCHK),
                    dataType: "json",
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#MonitoringGroupGrid").data("kendoGrid").dataSource.read();
                    $("#MonitoringGroupGrid").data("kendoGrid").refresh();
                });
            });
        });
    }

    var monitoringGroupsGrid = $("#MonitoringGroupGrid").kendoGrid({
        autoBind: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: true,
        toolbar: kendo.template($("#addGroup-template").html()),
        columns: [
            {
                field: "IDCHK",
                hidden: true,
                title: "_IDCHK",
                width: "200px"
            },
            {
                field: "NAME",
                title: "Групи контролю",
                width: "200px"
            },
            {
                field: "F_IN_CHARGE",
                title: "_F_IN_CHARGE",
                width: "200px"
            },
            {
                field: "PRIORITY",
                title: "Приорітет",
                width: "200px"
            },
            {
                field: "SQLVAL",
                title: "_SQLVAL",
                width: "200px"
            },
            {
                field: "FLAGS",
                title: "_FLAGS",
                width: "200px"
            },
            {
                command: [
                  {
                      template: "<button name='removeGroup' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>"
                  }
                ],

                title: "Дії над групою",
                width: "100px"
            }
        ],
        dataSource: remoteMonitoringGroupDataSource,
        filterable: true,
        change: function() {
            //
        },
        dataBound: removeGroupFromGrid
    });

    var groups = $("#groups-grid").kendoGrid({
        filterable: true,
        autoBind: false,
        selectable: "row",
        hight: "500px",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 7
        },
        columns: [
            {
                field: "IDCHK",
                width: "100px",
                title: "Код"
            },
            {
                field: "NAME",
                width: "200px",
                title: "Назва"
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
                    url: bars.config.urlContent("/admin/oper/GetGroupsHandbook"),
                    data: getCurrentOperId
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        VOB: { type: "number" },
                        NAME: { type: "string" }
                    }
                }
            }
        }
    });

    /*var remoteGroupsSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/oper/GetGroupsHandbook"),
                data: getCurrentOperId
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    IDCHK: { type: "number" },
                    NAME: { type: "string" }
                }
            }
        }
    });*/

    groups.hide();
    $("#groups-tbl").hide();

    function groupsHandbook() {

        $("#groups-grid").data("kendoGrid").dataSource.read();
        $("#groups-grid").data("kendoGrid").refresh();

        var groupsWindow = $("#groups-window").kendoWindow({
            title: "Доступні групи",
            visible: false,
            width: "600px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"]
        });

        groups.show();

        /*$("#groups-dropdown").kendoDropDownList({
            dataSource: remoteGroupsSource,
            dataTextField: "NAME",
            dataValueField: "IDCHK",
            index: 0
        });*/ 

        //var dropdownlist = $("#groups-dropdown").data("kendoDropDownList");

        var groupAddWindow = $("#group-add-window").kendoWindow({
            title: "Додавання групи ",
            visible: false,
            width: "600px",
            scrollable: false,
            resizable: false,
            modal: true,
            actions: ["Close"]
        });

        $("#charge-dropdown").kendoDropDownList({
            dataSource: [
              { id: 0, name: "Відсутній" },
              { id: 1, name: "Внутрішній" },
              { id: 2, name: "СЕП" },
              { id: 3, name: "Внутрішній + СЕП" }
            ],
            dataTextField: "name",
            dataValueField: "id",
            index: 0
        });
        var changeDrop = $("#charge-dropdown").data("kendoDropDownList");

        var window = groupsWindow.data("kendoWindow");
        window.center().open();

        function addGroup(tt, idchk, obj) {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/insertgroup?id=" + tt + "&gId=" + idchk + "&" + obj),
                dataType: "json",
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#groups-grid").data("kendoGrid").dataSource.read();
                $("#groups-grid").data("kendoGrid").refresh();
                $("#MonitoringGroupGrid").data("kendoGrid").dataSource.read();
                $("#MonitoringGroupGrid").data("kendoGrid").refresh();
            });
        }

        $("#groups-grid").on("dblclick", "tbody > tr", function () {
            var gview = $("#groups-grid").data("kendoGrid");
            var selectedItem = gview.dataItem(gview.select());
            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати групу<br/>" + selectedItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                var window = groupAddWindow.data("kendoWindow");
                window.title("Опції групи : <b> " + selectedItem.NAME + "</b>");

                window.center().open();
                $("#groups-tbl").show();

                $("#chk-add").on("click", function () {
                    var chk = $("#groups-checkbox").is(":checked");
                    if (!chk) {
                        $("#sql").val("");
                    }
                    var obj = $("#group-form").serialize();
                    addGroup(record.TT, selectedItem.IDCHK, obj);
                    window.close();
                });
            });
        });

        $("#groups-checkbox").click(function () {
            var $this = $(this);
            if ($this.is(":checked")) {
                $("#sql-box").show();
            } else {
                $("#sql-box").hide();
            }
        });
    }

    $("#MonitoringGroupGrid").on("dblclick", "tbody > tr", groupsHandbook);

    $("#btn_addGroup").on("click", groupsHandbook);

    $("#chk-cencel").on("click", closeAndRefreshWindow);

// End MonitoringGroup Tab

// Info Tab

// End Info Tab

// Folder Tab

    var remoteFoldersDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/oper/GetFolderGrid"),
                data: getCurrentOperId
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    IDFO: { type: "number" },
                    NAME: { type: "string" }
                }
            }
        }
    });

    function removeFolderFromGrid() {
        $("#FoldersGrid").data("kendoGrid").tbody.find("button[name='removeFolder']").click(function (e) {
            var gview = $("#FoldersGrid").data("kendoGrid");
            var dataItem = gview.dataItem($(e.currentTarget).closest("tr"));
            //alert("IDFO : " + dataItem.IDFO);

            bars.ui.confirm({
                text: "Ви дійсно бажаєте видалити директорію<br/>" + dataItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/oper/deletefolder?id=" + record.TT + "&idfo=" + dataItem.IDFO),
                    dataType: "json",
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#FoldersGrid").data("kendoGrid").dataSource.read();
                    $("#FoldersGrid").data("kendoGrid").refresh();
                });
            });
        });
    }
    
    var foldersGrid = $("#FoldersGrid").kendoGrid({
        autoBind: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: true,
        toolbar: kendo.template($("#addFolder-template").html()),
        columns: [
            {
                field: "IDFO",
                title: "Код",
                width: "200px"
            },
            {
                field: "NAME",
                title: "Назва",
                width: "200px"
            },
            {
                command: [
                  {
                      template: "<button name='removeFolder' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>"
                  }
                ],
                title: "Дії над директорією",
                width: "100px"
            }
        ],
        dataSource: remoteFoldersDataSource,
        filterable: true,
        change: function () {
            //
        },
        dataBound: removeFolderFromGrid
    });

    var folders = $("#folders-grid").kendoGrid({
        filterable: true,
        autoBind: false,
        selectable: "row",
        hight: "500px",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 7
        },
        columns: [
            {
                field: "IDFO",
                width: "100px",
                title: "Код"
            },
            {
                field: "NAME",
                width: "200px",
                title: "Назва"
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
                    url: bars.config.urlContent("/admin/oper/GetOutFolderGrid"),
                    data: getCurrentOperId
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        IDFO: { type: "number" },
                        NAME: { type: "string" }
                    }
                }
            }
        }
    });

    folders.hide();

    function foldersHandbook() {

        $("#folders-grid").data("kendoGrid").dataSource.read();
        $("#folders-grid").data("kendoGrid").refresh();

        var groupsWindow = $("#folders-window").kendoWindow({
            title: "Директорії",
            visible: false,
            width: "600px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"]
        });

        folders.show();

        var window = groupsWindow.data("kendoWindow");
        window.center().open();

        $("#folders-grid").on("dblclick", "tbody > tr", function () {
            var gview = $("#folders-grid").data("kendoGrid");
            var selectedItem = gview.dataItem(gview.select());
            //alert("Обрана директорія. IDFO : " + selectedItem.IDFO + "NAME : " + selectedItem.NAME);
            
            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати директорію<br/>" + selectedItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());
                
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/oper/insertfolder?id=" + record.TT + "&idfo=" + selectedItem.IDFO),
                    dataType: "json",
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#folders-grid").data("kendoGrid").dataSource.read();
                    $("#folders-grid").data("kendoGrid").refresh();
                    $("#FoldersGrid").data("kendoGrid").dataSource.read();
                    $("#FoldersGrid").data("kendoGrid").refresh();
                });
            });
        });
    }

    $("#FoldersGrid").on("dblclick", "tbody > tr", foldersHandbook);

    $("#btn_addFolder").on("click", foldersHandbook);


// End Folder Tab

// MainGrid Change Evet and others...
    function updateOperItem() {
        var model = createObjectModel();

        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/admin/oper/operitemupdate"),
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(model),
            traditional: true
        }).done(function (result) {
            bars.ui.alert({ text: result });
            $("#OperList").data("kendoGrid").dataSource.read();
            $("#OperList").data("kendoGrid").refresh();
        });
    }

    //Card Toolbar 
    $("#CardToolbar").kendoToolBar({
        items: [
            { template: "<input id='dropdown_transactionType' style='width: 250px;'/>", overflow: "never" },
            { type: "separator" },
            { template: "<input id='dropdown_transactionView' style='width: 250px;'/>", overflow: "never" },
            { type: "separator" },
            { template: "<div class='checkbox'><label><input id='hardTransaction' type='checkbox'> Cкадна транзакція </label></div>" },
            { type: "separator" },
            { template: "<div class='checkbox'><label><input id='multiTransaction' type='checkbox'> Мультивалютна транзакція </label></div>" }
        ]
    });

    $("#dropdown_transactionType").kendoDropDownList({
        dataSource: {
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/admin/oper/interbankhandbook")
                }
            },
            schema: {
                data: "Data"
            }
        },
        change: function(e) {
            var value = this.value();
            updateOperItem();
        },
        dataTextField: "NAME",
        dataValueField: "FLI"
    });

    $("#dropdown_transactionView").kendoDropDownList({
        dataSource: {
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/admin/oper/dkhandbook")
                }
            },
            schema: {
                data: "Data"
            }
        },
        change: function (e) {
            var value = this.value();
            updateOperItem();
        },
        dataTextField: "NAME",
        dataValueField: "DK"
    });

    $("#hardTransaction").change(function () {
        if ($(this).is(":checked")) {
            tabstrip.enable(tabstrip.tabGroup.children().eq(2), true);
            $("#RelatedTransactionsGrid").show();

            updateOperItem();
        } else {
            tabstrip.enable(tabstrip.tabGroup.children().eq(2), false);
            $("#RelatedTransactionsGrid").hide();

            updateOperItem();
        }
    });

    $("#multiTransaction").change(function () {
        if ($(this).is(":checked")) {
            updateOperItem();
        } else {
            updateOperItem();
        }
    });

    // local dataSource for CardGrid#1
    var localAccountGrid = new kendo.data.DataSource({
        transport: {
            read: function(options) {
                options.success(dataMask);
            },
            update: function (e) {
                var item = e.data;
                //alert("ID = " + item.ID + " mask = " + item.ACC_MASK);

                updateOperItem();
            }
        },
        schema: {
            model: {
                id: "ID",
                fields: {
                    ID: { editable: false },
                    NAZN: { editable: false },
                    ACC_MASK: { type: "number" },
                    KV: { type: "number", validation: { required: { message: "Не введено значення!" }, min: 1 } },
                    BANK: { type: "number", validation: { required: { message: "Не введено значення!" }, min: 1 } },
                    KP: { type: "number", validation: { required: { message: "Не введено значення!" }, min: 1 } }
                }
            }
        }
    });

    function nonEditAllRows(e) {
        var cellKv = e.container.find("input[name=KV]");
        cellKv.prop("disabled", true);
        $('td[data-container-for="KV"]').find("span.k-widget.k-numerictextbox").hide();
        cellKv.removeAttr("required");

        var cellBank = e.container.find("input[name=BANK]");
        cellBank.prop("disabled", true);
        $('td[data-container-for="BANK"]').find("span.k-widget.k-numerictextbox").hide();
        cellBank.removeAttr("required");

        var cellKp = e.container.find("input[name=KP]");
        cellKp.prop("disabled", true);
        $('td[data-container-for="KP"]').find("span.k-widget.k-numerictextbox").hide();
        cellKp.removeAttr("required");
    }

    var accGrid = $("#AccountGrid").kendoGrid({
        selectable: "row",
        columns: [
            { field: "ID", width: "10%", hidden: true },
            { field: "NAZN", title: "Призначення рахунку", width: "30%" },
            { field: "ACC_MASK", title: "Маска/Формула рахунку", width: "10%" },
            { field: "KV", title: "Код Валюти", width: "10%" },
            { field: "BANK", title: "Код Банку", width: "10%" },
            { field: "KP", title: "Симв. КП", width: "10%" },
            { command: ["edit"], title: "Редагування", width: "20%" }
        ],
        editable: "inline",
        edit: function (e) {
            var rowid = e.model["ID"];
            switch (rowid) {
                case "1":
                    var cellBank = e.container.find("input[name=BANK]");
                    cellBank.prop("disabled", true);
                    $('td[data-container-for="BANK"]').find("span.k-widget.k-numerictextbox").hide();
                    cellBank.removeAttr("required");

                    var cellKp = e.container.find("input[name=KP]");
                    cellKp.prop("disabled", true);
                    $('td[data-container-for="KP"]').find("span.k-widget.k-numerictextbox").hide();
                    cellKp.removeAttr("required");

                    break;
                case "2":
                    var cellBank = e.container.find("input[name=BANK]");
                    cellBank.prop("disabled", true);
                    $('td[data-container-for="BANK"]').find("span.k-widget.k-numerictextbox").hide();
                    cellBank.removeAttr("required");

                    break;
                case "3":
                    nonEditAllRows(e);
                    break;
                case "4":
                    var cellKv = e.container.find("input[name=KV]");
                    cellKv.prop("disabled", true);
                    $('td[data-container-for="KV"]').find("span.k-widget.k-numerictextbox").hide();
                    cellKv.removeAttr("required");

                    var cellKp = e.container.find("input[name=KP]");
                    cellKp.prop("disabled", true);
                    $('td[data-container-for="KP"]').find("span.k-widget.k-numerictextbox").hide();
                    cellKp.removeAttr("required");
                    break;
                case "5":
                    nonEditAllRows(e);
                    break;
                case "6":
                    nonEditAllRows(e);
                    break;
                case "7":
                    nonEditAllRows(e);
                    break;
            }
        },
        dataSource: localAccountGrid
    });
    
    var localAccountOptionGrid = new kendo.data.DataSource({
        transport: {
            read: function (options) {
                options.success(currentOperData);
            },
            update: function (e) {
                var item = e.data;
                //alert("ID = " + item.ID + " mask = " + item.ACC_MASK);

                updateOperItem();
            }
        },
        schema: {
            model: {
                id: "NAZN",
                fields: {
                    NAZN: { editable: false },
                    VAL: { type: "string" }
                }
            }
        }
    });

    $("#AccountGridOptions").kendoGrid({
        autoBind: false,
        selectable: "row",
        columns: [
            {
                field: "NAZN",
                title: "Параметр",
                width: "20%"
            },
            {
                field: "VAL",
                title: "Значення",
                width: "80%"
            },
            { command: ["edit"], title: "Редагування", width: "20%" }
        ],
        editable: "inline",
        dataSource: localAccountOptionGrid
    });

});