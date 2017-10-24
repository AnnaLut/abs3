$(document).ready(function () {


    var rowIndex = null;

    function setDefaultRow(index) {
        var grid = $('#OperList').data('kendoGrid');
        if (grid != null && (index === 0 || !index)) {
            grid.select("tr:eq(2)");
        } else if (grid != null && (index || index !== 0)) {
            grid.select("tr:eq(" + (index+2) + ")");
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
        { ID: "5", NAZN: "Рахунок валютної позиції", ACC_MASK: "", KV: "*", BANK: "*", KP: "*" }/*,
        { ID: "6", NAZN: "Рахунок маржинальних прибутків", ACC_MASK: "", KV: "*", BANK: "*", KP: "*" },
        { ID: "7", NAZN: "Рахунок маржинальних витрат", ACC_MASK: "", KV: "*", BANK: "*", KP: "*" }*/
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
            var dkDropList = $("#dropdown_transactionView").data("kendoDropDownList");
            var fliDropList = $("#dropdown_transactionType").data("kendoDropDownList");
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
            //$("#FlagsGrid").data("kendoGrid").refresh();

            $("#PropsGrid").data("kendoGrid").dataSource.read();
            //$("#PropsGrid").data("kendoGrid").refresh();

            $("#BalanceAccountsGrid").data("kendoGrid").dataSource.read();
            //$("#BalanceAccountsGrid").data("kendoGrid").refresh();

            $("#RelatedTransactionsGrid").data("kendoGrid").dataSource.read();
            //$("#RelatedTransactionsGrid").data("kendoGrid").refresh();

            $("#VobGrid").data("kendoGrid").dataSource.read();
            //$("#VobGrid").data("kendoGrid").refresh();

            $("#MonitoringGroupGrid").data("kendoGrid").dataSource.read();
            //$("#MonitoringGroupGrid").data("kendoGrid").refresh();

            $("#FoldersGrid").data("kendoGrid").dataSource.read();
            //$("#FoldersGrid").data("kendoGrid").refresh();

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
            //dataMask[5].ACC_MASK = currentRow.S6201;
            //dataMask[6].ACC_MASK = currentRow.S7201;

            $("#AccountGrid").data("kendoGrid").dataSource.read();
            //$("#AccountGrid").data("kendoGrid").refresh();

            // dataSource for AccountGridOptions 
            currentOperData[0].VAL = currentRow.S;
            currentOperData[1].VAL = currentRow.S2;
            currentOperData[2].VAL = currentRow.NAZN;
            currentOperData[3].VAL = currentRow.RANG;

            $("#AccountGridOptions").data("kendoGrid").dataSource.read();
            //$("#AccountGridOptions").data("kendoGrid").refresh();

            flagConverter(currentRow.FLAGS);
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

        var dkDropList = $("#dropdown_transactionView").data("kendoDropDownList");           
        var fliDropList = $("#dropdown_transactionType").data("kendoDropDownList");

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
            S6201: null, //displayedAccountData[5].ACC_MASK,
            S7201: null, //displayedAccountData[6].ACC_MASK,
            SK: displayedAccountData[1].KP
        }
    }

    var remoteDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        //serverPaging: true,
        serverSorting: true,
        serverFiltering: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/admin/oper/GetOperGrid")
            }
        },
        schema: {
            data: "Data.Data",
            total: "Data.Total",
            model: {
                fields: {
                    TT: { type: "string"/*, validation: { required: { message: "ID операції є обов'язковою!" }, min: 1 }*/ },
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
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        toolbar: kendo.template($("#template").html()),
        //toolbar: ["create"],
        /*editable: {
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
                    //that.dataSource.read();
                    debugger;
                    bars.ui.alert({ text: data });
                    //that.closeCell();
                    //$("#OperList").data("kendoGrid").dataSource.read();
                    debugger;
                },
                error: function (data) {
                    bars.ui.alert({ text: data });
                    that.dataSource.read();
                    that.cancelRow();
                }

            });

        },*/
        columns: [
            {
                field: "TT",
                title: "Код",
                width: "200px",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NAME",
                title: "Назва банківської операції",
                width: "500px",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }      
        ],
        dataSource: remoteDataSource,
        filterable: { mode: "row" },
        change: updateChildGrid,
        dataBound: function() {
            //console.log("databound opergrid");
            setDefaultRow(rowIndex);
        }
    });

    function getCurrentOperId() {
        var grid = $("#OperList").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow) {
            return { tt: currentRow.TT };
        }
        return null;
    }

    // Create new oper:
    $("#CreateOperWindow").kendoWindow({
        title: "Створення нової операції",
        visible: false,
        width: "600px",
        resizable: false,
        actions: ["Close"],
        close: function () {
        }
    });

    var openOperCreateWindow = function() {
        var window = $("#CreateOperWindow").data("kendoWindow");
        window.center();
        window.open();
    }

    var ExportOperationsSQL = function () {
       
        var grid = $("#OperList").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());
        window.location="/barsroot/admin/oper/ExportOperationsSQL" + "?cod=" + currentRow.TT
        //$.ajax({
        //    type: 'GET',
        //    url: bars.config.urlContent("/admin/oper/ExportOperationsSQL") + "?cod=" + currentRow.TT,
        //    success: function () {
        //    },
        //    error: function (data) {
        //        bars.ui.alert({ text: data });
        //    }

        //});
    }

    $("#btn_addOper").on("click", openOperCreateWindow); 
    $("#btn_expSQL").on("click", ExportOperationsSQL);

    $("#btn_delOper").on("click", function () {
        var grid = $("#OperList").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());
        bars.ui.loader('body', true);
        if (currentRow) {
            $.ajax({
                url: bars.config.urlContent('/api/admin/oper/' + currentRow.TT),
                type: 'DELETE',
                //data: { id: currentRow.TT },
                success: function (result) {
                    bars.ui.loader('body', false);
                    if (result.Status === 1) {
                        bars.ui.alert({ text: result.Message });
                    } else {
                        bars.ui.error({ text: result.Message });
                    }
                    grid.dataSource.read();
                }
            });
        } else {
            bars.ui.alert({ text: "Необхідно обрати запис для видалення!"});
        }
    });

    function checkOperCode(currentCode, codeArr) {
        var isExist = false;
        if (codeArr) {
            var i = 0;
            for (i; i < codeArr.length; i++) {
                if (currentCode === codeArr[i].TT) {
                    isExist = true;
                }
            }
        }
        return isExist;
    }

    $("#btnSave").on("click", function () {
            
        var codeCreate = $("#code").val();
        var grid = $("#OperList").data("kendoGrid");

        if (!checkOperCode(codeCreate, grid.dataSource.data())) {
            var window = $("#CreateOperWindow").data("kendoWindow");
            $.ajax({
                type: 'POST',
                url: bars.config.urlContent("/api/admin/oper/operitemupdate"),
                contentType: 'application/json',
                dataType: 'json',
                data: JSON.stringify({
                    TT: codeCreate,
                    DK: 0,
                    FLAGS: '0100000000000000000000000000000000000000000000000000000000000000', // *
                    FLC: 0,
                    FLI: 0,
                    FLR: 0, // *
                    FLV: 0,
                    KV: 0,
                    KVK: 0,
                    MFOB: null,
                    NAME: $("#name").val(),
                    NAZN: null,
                    NLSA: null,
                    NLSB: null,
                    NLSK: null,
                    NLSM: null,
                    NLSS: null, // *
                    PROC: 0, // *
                    RANG: 0,
                    S: null,
                    S2: null,
                    S3800: 0,
                    S6201: null,
                    S7201: null,
                    SK: null
                }),
                success: function(data) {

                    bars.ui.alert({ text: data });

                    $("#OperList").data("kendoGrid").dataSource.read();

                    $("#OperList").data("kendoGrid").dataSource.filter({
                        field: "TT",
                        operator: "eq",
                        value: codeCreate
                    });

                    window.close();
                },
                error: function(data) {
                    bars.ui.error({ text: data });
                    $("#OperList").data("kendoGrid").dataSource.read();
                    
                    window.close();
                }

            });
        } else {
            bars.ui.alert({ text: "Операція з кодом " + codeCreate + " вже існує. Спробуйте інше значення." });
        }
      
    });

    // Edit oper:
    $("#EditOperWindow").kendoWindow({
        title: "Редагування операції",
        visible: false,
        width: "600px",
        resizable: false,
        actions: ["Close"],
        close: function () {
        }
    });

    $("#btn_openEditWin").on("click",
        function () {

            var grid = $("#OperList").data("kendoGrid");
            var currentRow = grid.dataItem(grid.select());

            if (currentRow) {
                $("#editCode").val(currentRow.TT);
                $("#editName").val(currentRow.NAME);
                var window = $("#EditOperWindow").data("kendoWindow");
                window.center();
                window.open();
            } else {
                bars.ui.alert({ text: "Необхідно обрати запис для редагування." });
            }
        });

    $("#btnSaveEdit").on("click", function() {
        var currentOperation = createObjectModel();
        currentOperation["NAME"] = $("#editName").val();
        
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/operitemupdate"),
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(currentOperation),
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });

                var grid = $("#OperList").data("kendoGrid");
                var selection = grid.select();

                rowIndex = selection.index();

                grid.dataSource.read().then(function () {
                    var window = $("#EditOperWindow").data("kendoWindow");
                    window.close();
                });

            });
            
    });

// FlagsProps_Tab ***

    function flagConverter() {
        var grid = $("#OperList").data("kendoGrid");

        var record = grid.dataItem(grid.select());
        var flag = record.FLAGS.replace(/\s/g, '');;
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
        serverSorting: true,
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
            var str = "";
            var rw = [];
            if (e.response) {
                var response = e.response.Data;
                for (var i = 0; i < response.length; i++) {
                    str += response[i].FCODE + " - " + response[i].NAME + "<br/>";
                    rw.push(response[i].VALUE);
                }
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
            data: "Data.Data",
            total: "Data.Total",
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

    

    function functionsFlagFromGrid() {
        $("#FlagsGrid").data("kendoGrid").tbody.find("button[name='removeFlag']").click(function (e) {
            var gview = $("#FlagsGrid").data("kendoGrid");
            var dataItem = gview.dataItem($(e.currentTarget).closest("tr"));

            //alert("FCODE : " + dataItem.FCODE);
            //debugger;
            bars.ui.confirm({
                text: "Ви дійсно бажаєте видалити флаг<br/>\"" + dataItem.NAME + "\" ?"
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
                    
                    var grid = $("#OperList").data("kendoGrid");
                    var selection = grid.select();
                    rowIndex = selection.index();
                    
                    grid.dataSource.read().then(function () {
                        //var returnToRow = grid.tbody.find('tr[data-id="' + selectedOperRowUid + '"]');
                        //grid.select(selectedOperRowUid);

                        $("#FlagsGrid").data("kendoGrid").dataSource.read();
                    });
                    
                });
            });
        });

        $("#flag-edit-window").kendoWindow({
            visible: false,
            width: "600px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"]
        });

        $("#FlagsGrid").data("kendoGrid").tbody.find("button[name='editFlag']").click(function (e) {
            
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
                        template: kendo.template(removeButtons("flag"))
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
        dataBound: functionsFlagFromGrid
    });

    var flags = $("#flags-grid").kendoGrid({
        toolbar: [
            { template: "<button id='addFlagBtn' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span> Додати</button>" }
        ],
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
            serverSorting: true,
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

    var flagsWindow = $("#flags-window").kendoWindow({
            title: "Флаги",
            visible: false,
            width: "600px",
            scrollable: true,
            resizable: true,
            modal: true,
            actions: ["Close"],
            close: function(e) {
                // reset all filters
                $("#flags-grid").data("kendoGrid").dataSource.filter({});
              }
        });

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
            // save row position
            var grid = $("#OperList").data("kendoGrid");
            var selection = grid.select();
            rowIndex = selection.index();

            var model = createObjectModel();
            model["FLAGS"] = flag;
            bars.ui.loader('body', true);
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/oper/operitemupdate"),
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(model),
                traditional: true
            }).done(function (result) {
                bars.ui.loader('body', false);
                //updateChildGrid();
                $("#OperList").data("kendoGrid").dataSource.read();
                $("#FlagsGrid").data("kendoGrid").dataSource.read();
                bars.ui.alert({ text: result });                
            });
        }

    $("#btn_addFlag").on("click", function() {
        $("#flags-grid").data("kendoGrid").dataSource.read(); 
        
        flags.show();      
        flagsWindow.data("kendoWindow").center().open();   
    });

    $("#addFlagBtn").click(function () {
        var gview = $("#flags-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        if(selectedItem) {
            flagAddWindow.data("kendoWindow").title("Опції флагу : <b> " + selectedItem.NAME + "</b>");
            flagAddWindow.data("kendoWindow").center().open();

            $("#flag-tbl").show();  
        } else {
            bars.ui.alert({text: "Оберіть значення, яке потрібно додати!"});
        }
    });

    $("#flag-add").bind("click", function () {
        var gview = $("#flags-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());

        var flagCode = selectedItem.CODE;
        var flagValue = $("#fVal").val();
        var flagStr = record.FLAGS || '0100000000000000000000000000000000000000000000000000000000000000';
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

        $("#flags-grid").data("kendoGrid").dataSource.read();
        
        
        flagAddWindow.data("kendoWindow").close();
        flagsWindow.data("kendoWindow").close();
    });

    $("#fVal").keyup(function () {
        this.value = this.value.replace(/[^0-9\.]/g, '');
    });

    //$("#FlagsGrid").on("dblclick", "tbody > tr", flagsHandbook);

    $("#flag-edit-add").on("click", function () {
        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());

        var gview = $("#FlagsGrid").data("kendoGrid");
        var dataItem = gview.dataItem(gview.select());

        var dropdownlist = $("#flagVal").data("kendoDropDownList");

        var flagCode = dataItem.FCODE;
        var flagValue = dropdownlist.value();
        //var operTT = record.TT;

        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/admin/operflagupdate/flagvalueupdate"),
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify({ tt: record.TT, code: flagCode, value: flagValue }),
            traditional: true
        }).done(function (result) {
            bars.ui.alert({ text: result });
            $("#flag-edit-window").data("kendoWindow").close();
            $("#FlagsGrid").data("kendoGrid").dataSource.read();
        });

    });

    $("#flag-edit-cencel").on("click", function () {
        $("#flag-edit-window").data("kendoWindow").close();
    });

    $("#btn_editFlag").on("click", function() {
        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());
        var gview = $("#FlagsGrid").data("kendoGrid");
        var dataItem = gview.dataItem(gview.select());  // gview.dataItem($(e.currentTarget).closest("tr"));

        //alert("FCODE : " + dataItem.FCODE);

        if (dataItem) {
            $("#flagVal").kendoDropDownList({
                dataSource: {
                    data: [1, 2, 3, 4, 5, 6, 7, 8, 9]
                },
                animation: false
            });

            var dropdownlist = $("#flagVal").data("kendoDropDownList");
            dropdownlist.value(dataItem.VALUE);
            dropdownlist.trigger("change");

            var editflagsWindow = $("#flag-edit-window").data("kendoWindow");

            editflagsWindow.title("Редагування значення флагу, код: " + dataItem.FCODE);

            editflagsWindow.center().open();

            
        } else {
            bars.ui.alert({ text: "Не обрано запис для редагування!" });
        }
    });



    

    $("#flag-cencel").on("click", closeAndRefreshWindow);
    
    //***
    var remotePropsDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverSorting: true,
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
        if (access_mode == "read")
            $("#PropsGrid").data("kendoGrid").tbody.find("input.opt,input.used").attr("disabled", "disabled");
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
                    url: bars.config.urlContent("/api/admin/operremoverules/post"),
                    dataType: "json",
                    data: {
                        id: record.TT,
                        tag: dataItem.TAG.replace(/\s+/g, '')
                    }
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#PropsGrid").data("kendoGrid").dataSource.read();
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
                url: bars.config.urlContent("/api/admin/operprop/updateprop"), // ?id=" + record.TT + "&tag=" + dataItem.TAG + "&opt=" + dataItem.OPT + "&used=" + dataItem.USED4INPUT + "&ord=" + dataItem.ORD + "&val=" + dataItem.VAL
                dataType: "json",
                contentType: "application/json; charset=UTF-8",
                data: JSON.stringify({
                    id: record.TT,
                    tag: dataItem.TAG,
                    opt: dataItem.OPT,
                    used: dataItem.USED4INPUT,
                    ord: dataItem.ORD,
                    val: dataItem.VAL
                })
                //,raditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result.Message });
                $("#PropsGrid").data("kendoGrid").dataSource.read();
                //$("#PropsGrid").data("kendoGrid").refresh();
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
                url: bars.config.urlContent("/api/admin/operprop/updateprop"), // ?id=" + record.TT + "&tag=" + dataItem.TAG + "&opt=" + dataItem.OPT + "&used=" + dataItem.USED4INPUT + "&ord=" + dataItem.ORD + "&val=" + dataItem.VAL
                dataType: "json",
                data: JSON.stringify({
                    id: record.TT,
                    tag: dataItem.TAG,
                    opt: dataItem.OPT,
                    used: dataItem.USED4INPUT,
                    ord: dataItem.ORD,
                    val: dataItem.VAL
                }),
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#PropsGrid").data("kendoGrid").dataSource.read();
                //$("#PropsGrid").data("kendoGrid").refresh();
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
                        template: kendo.template(removeButtons("prop"))
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
        toolbar: [
            { template: "<button id='addProp' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span> Додати</button>" }
        ],
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
            serverSorting: true,
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

    var propsWindow = $("#props-window").kendoWindow({
        title: "Реквізити",
        visible: false,
        width: "600px",
        scrollable: true,
        resizable: true,
        modal: true,
        actions: ["Close"],
            close: function(e) {
                // reset all filters                
                $("#props-grid").data("kendoGrid").dataSource.filter({});
              }
    });

    var propAddWindow = $("#prop-add-window").kendoWindow({
        title: "Додавання реквізиту ",
        visible: false,
        width: "600px",
        scrollable: false,
        resizable: false,
        modal: true,
        actions: ["Close"]
    });

    $("#btn_addProp").on("click", function() {
        propsWindow.data("kendoWindow").center().open();
        $("#props-grid").data("kendoGrid").dataSource.read();
        props.show();
    });

    $("#addProp").click(function() {
        var gview = $("#props-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());
        //alert("Обраний реквізит. TAG: " + selectedItem.TAG + "NAME : " + selectedItem.NAME);

        if (selectedItem) {
            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати реквізит<br/>" + selectedItem.NAME + " ?"
            }, function() {

                var window = propAddWindow.data("kendoWindow");
                window.title("Опції реквізиту : <b> " + selectedItem.NAME + "</b>");

                window.center().open();
                $("#prop-tbl").show();
            });
        } else {
            bars.ui.alert({text: "Оберіть значення, яке потрібно додати!"});
        }
    });

    $("#rekv-edit-window").kendoWindow({
        width: "40%",
        height: "40%",
        title: "Редагування: Ревізит",
        visible: false,
        actions: [
            "Minimize",
            "Maximize",
            "Close"
        ],
    }).data("kendoWindow");

    $("#btn_editPropm").on('click', function () {
        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());
        var gview = $("#PropsGrid").data("kendoGrid");
        var dataItem = gview.dataItem(gview.select());  // gview.dataItem($(e.currentTarget).closest("tr"));

        //alert("FCODE : " + dataItem.FCODE);

        if (dataItem) {

            var editPropsWindow = $("#rekv-edit-window").data("kendoWindow");

            editPropsWindow.title("Редагування ревізиту: код: " + record.TT+ " -> "+ dataItem.TAG);

            editPropsWindow.center().open();

            //refill empty fields
            if (dataItem.USED4INPUT == 1) {
                $("#flag_edit_prop").prop("checked", true);
            } else {
                $("#flag_edit_prop").prop("checked", false)
            }
            if (dataItem.OPT == 'M') {
                $("#ozn_edit_prop").prop("checked", true);
            } else {
                $("#ozn_edit_prop").prop("checked", false);
            }

            $("#edit_ord").val(dataItem.ORD);
            $("#edit_val").val(dataItem.VAL);


        } else {
            bars.ui.alert({ text: "Не обрано запис для редагування!" });
        }
    });
    $("#prop_cencel_edit").click(function () {
        $("#rekv-edit-window").data("kendoWindow").close();
    });

    $("#prop_add_edit").click(function () {
        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());
       
        var gview = $("#PropsGrid").data("kendoGrid");
        var dataItem = gview.dataItem(gview.select());

        //make changes
        dataItem.ORD = parseInt($("#edit_ord").val());
        dataItem.VAL = parseInt($("#edit_val").val());
        if ($("#flag_edit_prop").is(":checked")) {
            dataItem.USED4INPUT = 1;
        } else {
            dataItem.USED4INPUT = 0;
        }
        if ($("#ozn_edit_prop").is(":checked")) {
            dataItem.OPT = 'M';
        } else {
            dataItem.OPT = 'O';
        }


        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/admin/operprop/updateprop"), // ?id=" + record.TT + "&tag=" + dataItem.TAG + "&opt=" + dataItem.OPT + "&used=" + dataItem.USED4INPUT + "&ord=" + dataItem.ORD + "&val=" + dataItem.VAL
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({
                id: record.TT,
                tag: dataItem.TAG,
                opt: dataItem.OPT,
                used: dataItem.USED4INPUT,
                ord: dataItem.ORD,
                val: dataItem.VAL
            })
            //,
            //traditional: true
        }).done(function (result) {
            bars.ui.alert({ text: result.Message });
            $("#PropsGrid").data("kendoGrid").dataSource.read();
            $("#PropsGrid").data("kendoGrid").refresh();
            //$("#PropsGrid").data("kendoGrid").refresh();
        });

        $("#rekv-edit-window").data("kendoWindow").close();
    });

    $("#used").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        dataSource: {
            data: [
                { text: "0", value: 0 },
                { text: "1", value: 1 }
            ]
        },
        animation: false
    });


    $("#ord #edit_ord").keyup(function () {
        this.value = this.value.replace(/[^\d\.]/g, "");
        this.value = this.value.replace(/[\\~#%&*,_+={}/:<>.?|\"-]/gi, "");
        this.value = this.value.toUpperCase();
    });

    $("#prop-add").bind("click", function () {
        var gview = $("#props-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());

        var obj = $("#prop-form").serializeArray();

        if ($('#used').val() === '' && $('#ord').val() === '' && $('#val').val() === '') {
            bars.ui.alert({ text: "Значення полів форми мають бути заповнені!" });
        }
        else {
            var tag = selectedItem.TAG;
            tag = tag.replace(/\s+/g, '');
           
            var url = bars.config.urlContent("/api/admin/operprop/updateprop");
            bars.ui.loader('body', true);
            $.ajax({
                type: "POST",
                url: url,
                dataType: "json",
                data: { id: record.TT, tag: tag, opt: obj[1].value, used: obj[0].value, ord: obj[2].value, val: obj[3].value }
            }).done(function (result) {
                bars.ui.loader('body', false);
                bars.ui.alert({ text: result.Message ? result.Message : result });
                propAddWindow.data("kendoWindow").close();
                $("#props-grid").data("kendoGrid").dataSource.read();
                $("#PropsGrid").data("kendoGrid").dataSource.read();
            });
            flagsWindow.data("kendoWindow").close();
        }
    });

    $("#prop-cencel").on("click", closeAndRefreshWindow);

// End FlagsProps_Tab

// Balance Accounts Tab

    var remoteBalanceAccsDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverSorting: true,
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

                var ob22 = dataItem.OB22 === null ? '' : dataItem.OB22;

                $.ajax({
                    type: "DELETE",
                    url: bars.config.urlContent("/api/admin/oper/deleteacc?id=" + record.TT + "&nbs=" + dataItem.NBS + "&dk=" + dataItem.DK + "&ob=" + ob22),
                    dataType: "json",
                    traditional: true
                }).done(function(result) {
                    bars.ui.alert({ text: result });
                    $("#BalanceAccountsGrid").data("kendoGrid").dataSource.read();
                    //$("#BalanceAccountsGrid").data("kendoGrid").refresh();
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
                        template: kendo.template(removeButtons("account"))
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
        toolbar: [
            { template: "<button id='addAcc' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span> Додати</button>" }
        ],
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
            serverSorting: true,
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

    var accsWindow = $("#accs-window").kendoWindow({
        title: "Рахунки",
        visible: false,
        width: "600px",
        scrollable: true,
        resizable: true,
        modal: true,
        actions: ["Close"],
            close: function(e) {
                // reset all filters                
                $("#accs-grid").data("kendoGrid").dataSource.filter({});
              }
    });

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
        //bars.ui.loader('body', true);
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/admin/oper/insertacc?id=" + tt + "&nbs=" + nbs + "&" + obj),
            dataType: "json",
            traditional: true
        }).done(function (result) {
            //bars.ui.loader('body', false);
            bars.ui.alert({ text: result });

            $("#accs-grid").data("kendoGrid").dataSource.read();
            $("#BalanceAccountsGrid").data("kendoGrid").dataSource.read();
        });
    }

    function accountsHandbook() {
        $("#accs-grid").data("kendoGrid").dataSource.read();
        //$("#accs-grid").data("kendoGrid").refresh();
        accounts.show();
        accsWindow.data("kendoWindow").center().open();
    }


    $("#addAcc").click(function () {
        var gview = $("#accs-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        if (selectedItem) {
            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати рахунок<br/>" + selectedItem.NAME + " ?"
            }, function () {
                accAddWindow.data("kendoWindow").title("Опції рахунку : <b> " + selectedItem.NAME + "</b>");
                accAddWindow.data("kendoWindow").center().open();

                $("#acc-tbl").show();
            });
        } else {
            bars.ui.alert({ text: "Оберіть значення, яке потрібно додати!" });
        }
    });

    $("#acc-add").bind("click", function () {
        var gview = $("#accs-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());

        var obj = $("#acc-form").serialize();
        var nbs = selectedItem.NBS;
        nbs = nbs.replace(/\s+/g, '');

        if ($('#dk').val() === '') {
            bars.ui.alert({ text: "Значення поля \"Д/К\" форми має бути заповнено!"});
        }
        else {
            addAccount(record.TT, nbs, obj);
            accsWindow.data("kendoWindow").close();
            accAddWindow.data("kendoWindow").close();
        }
    });


    /*$("#accs-grid").on("dblclick", "tbody > tr", function () {
        var gview = $("#accs-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());
        //alert("Обраний рахунок. NBS : " + selectedItem.NBS + "NAME : " + selectedItem.NAME);

        
    });*/

    $("#BalanceAccountsGrid").on("dblclick", "tbody > tr", accountsHandbook);

    $("#btn_addAcc").on("click", accountsHandbook);

    $("#acc-cencel").on("click", closeAndRefreshWindow);

// End Balance Accounts Tab

// RelatedTransaction_Tab ***
    
    var remoteRelatedTransactionDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverSorting: true,
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
                    url: bars.config.urlContent("/api/admin/operremovetransaction/post"),
                    dataType: "json",
                    data:{
                        id: record.TT,
                        ttap: dataItem.TTAP
                    }
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#RelatedTransactionsGrid").data("kendoGrid").dataSource.read();
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
                        template: kendo.template(removeButtons("transaction"))
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
        toolbar: [
           { template: "<button id='addTransactions' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span> Додати</button>" }
        ],
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
            serverSorting: true,
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

    var transactionsWindow = $("#transactions-window").kendoWindow({
        title: "Операції",
        visible: false,
        width: "600px",
        scrollable: true,
        resizable: true,
        modal: true,
        actions: ["Close"],
            close: function(e) {
                // reset all filters                
                $("#transactions-grid").data("kendoGrid").dataSource.filter({});
              }
    });

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
        bars.ui.loader('body', true);
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/admin/oper/inserttransaction?id=" + tt + "&ttap=" + ttap + "&dk=" + obj),
            dataType: "json",
            traditional: true
        }).done(function (result) {
            bars.ui.loader('body', false);
            bars.ui.alert({ text: result });

            $("#transactions-grid").data("kendoGrid").dataSource.read();
            $("#RelatedTransactionsGrid").data("kendoGrid").dataSource.read();
        });
    }

    transactions.hide();
    $("#transaction-tbl").hide();

    function transactionsHandbook() {

        $("#transactions-grid").data("kendoGrid").dataSource.read();

        transactions.show();

        transactionsWindow.data("kendoWindow").center().open();
    }

    $("#addTransactions").click(function () {
        var gview = $("#transactions-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        if (selectedItem) {
            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати операцію <br/>" + selectedItem.NAME + " ?"
            }, function () {

                transactionAddWindow.data("kendoWindow").title("Опції операції : <b> " + selectedItem.NAME + "</b>");
                transactionAddWindow.data("kendoWindow").center().open();

                $("#transaction-tbl").show();
            });
        } else {
            bars.ui.alert({ text: "Оберіть значення, яке потрібно додати!" });
        }
    });

    $("#transaction-add").bind("click", function () {
        var gview = $("#transactions-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());

        var obj = $("#transaction-form").serialize();

        if ($('#trnsDk').val() === '') {
            bars.ui.alert({ text: "Значення поля форми має бути заповнено!" });
        } else {
            addTransaction(record.TT, selectedItem.TT, obj.slice(3));

            transactionsWindow.data("kendoWindow").close();
            transactionAddWindow.data("kendoWindow").close();
        }
        
    });

    $("#RelatedTransactionsGrid").on("dblclick", "tbody > tr", transactionsHandbook);

    $("#btn_addTransaction").on("click", transactionsHandbook);

    $("#transaction-cencel").on("click", closeAndRefreshWindow);

// End RelatedTransaction_Tab ***


// VOB_Tab ***

    var remoteVobDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverSorting: true,
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
                title: "Назва виду банківських документів",
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
                        template: kendo.template(removeButtons("doc"))
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
        toolbar: [
           { template: "<button id='addBankDocs' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span> Додати</button>" }
        ],
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
            serverSorting: true,
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

    var bankDocsWindow = $("#bankDocs-window").kendoWindow({
        title: "Документи",
        visible: false,
        width: "600px",
        scrollable: true,
        resizable: true,
        modal: true,
        actions: ["Close"],
            close: function(e) {
                // reset all filters                
                $("#bankDocs-grid").data("kendoGrid").dataSource.filter({});
              }
    });

    var vobOrderNumber = $("#vob-order-window").kendoWindow({
        title: "Новий документ операції",
        visible: false,
        width: "400px",
        scrollable: false,
        resizable: false,
        modal: true,
        actions: ["Close"]
    });

    function bankDocsHandbook() {
        $("#bankDocs-grid").data("kendoGrid").dataSource.read();       

        bankDocs.show();

        bankDocsWindow.data("kendoWindow").center().open();
    }

    function addVob(tt, vobId, vobOrd) {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/admin/oper/insertvob?id=" + tt + "&vobId=" + vobId + "&vobOrd=" + vobOrd),
            dataType: "json",
            traditional: true
        }).done(function (result) {
            bars.ui.alert({ text: result });
        });
    }

    $("#addBankDocs").click(function () {
        var gview = $("#bankDocs-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());
        
        if (selectedItem) {

                bars.ui.confirm({
                    text: "Ви дійсно бажаєте додати документ<br/>" + selectedItem.NAME + " ?"
                }, function () {

                    vobOrderNumber.data("kendoWindow").center().open();
                    $("#vob-tbl").show();
                    
                });
           
        } else {
            bars.ui.alert({ text: "Оберіть значення, яке потрібно додати!" });
        }
    });

    $("#vob-add").bind("click", function () {
        var gview = $("#bankDocs-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());

        var ord = $("#vob-order").val();
        
        if (ord === '') {
            bars.ui.alert({ text: "Значення поля форми має бути заповнено!" });
        }
        else {
            addVob(record.TT, selectedItem.VOB, ord);

            vobOrderNumber.data("kendoWindow").close();
            bankDocsWindow.data("kendoWindow").close();

            $("#bankDocs-grid").data("kendoGrid").dataSource.read();
            $("#VobGrid").data("kendoGrid").dataSource.read();
        }
    });

    $("#VobGrid").on("dblclick", "tbody > tr", bankDocsHandbook);
    
    $("#btn_addDoc").on("click", bankDocsHandbook);

    $("#vob-cencel").on("click", closeAndRefreshWindow);

// End VOB Tab ***

// MonitoringGroup Tab

    var remoteMonitoringGroupDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverSorting: true,
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
                    //$("#MonitoringGroupGrid").data("kendoGrid").refresh();
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
                title: "Підпис",
                width: "200px"
            },
            {
                field: "PRIORITY",
                title: "Приорітет",
                width: "200px"
            },
            {
                field: "SQLVAL",
                title: "SQL",
                width: "200px"
            },
            {
                field: "FLAGS",
                title: "Флаги",
                width: "200px"
            },
            {
                command: [
                    {
                        template: kendo.template(removeButtons("group"))
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
        toolbar: [
           { template: "<button id='addGroups' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span> Додати</button>" }
        ],
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
            serverSorting: true,
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

    var groupsWindow = $("#groups-window").kendoWindow({
        title: "Доступні групи",
        visible: false,
        width: "600px",
        scrollable: true,
        resizable: true,
        modal: true,
        actions: ["Close"],
            close: function(e) {
                // reset all filters                
                $("#groups-grid").data("kendoGrid").dataSource.filter({});
              }
    });

    var groupAddWindow = $("#group-add-window").kendoWindow({
        title: "Додавання групи ",
        visible: false,
        width: "600px",
        scrollable: false,
        resizable: false,
        modal: true,
        actions: ["Close"]
    });

    function addGroup(tt, idchk, obj) {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/admin/oper/insertgroup?id=" + tt + "&gId=" + idchk + "&" + obj),
            dataType: "json",
            traditional: true
        }).done(function (result) {
            $("#groups-grid").data("kendoGrid").dataSource.read();
            $("#MonitoringGroupGrid").data("kendoGrid").dataSource.read();
            bars.ui.alert({ text: result });
        });
    }

    $("#chk-add").on("click", function () {
        var gview = $("#groups-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());

        var chk = $("#groups-checkbox").is(":checked");
        if (!chk) {
            $("#sql").val("");
        }
        var obj = $("#group-form").serialize();

        addGroup(record.TT, selectedItem.IDCHK, obj);

        groupsWindow.data("kendoWindow").close();
        groupAddWindow.data("kendoWindow").close();
    });

    $("#addGroups").click(function () {
        var gview = $("#groups-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        if (selectedItem) {

            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати групу<br/>" + selectedItem.NAME + " ?"
            }, function () {
                

                groupAddWindow.data("kendoWindow").title("Опції групи : <b> " + selectedItem.NAME + "</b>");
                groupAddWindow.data("kendoWindow").center().open();

                $("#groups-tbl").show();
                
            });

        } else {
            bars.ui.alert({ text: "Оберіть значення, яке потрібно додати!" });
        }

    });

    function groupsHandbook() {

        $("#groups-grid").data("kendoGrid").dataSource.read();
        //$("#groups-grid").data("kendoGrid").refresh();

        

        groups.show();

        /*$("#groups-dropdown").kendoDropDownList({
            dataSource: remoteGroupsSource,
            dataTextField: "NAME",
            dataValueField: "IDCHK",
            index: 0
        });*/ 

        //var dropdownlist = $("#groups-dropdown").data("kendoDropDownList");

        

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

        groupsWindow.data("kendoWindow").center().open();

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
        serverSorting: true,
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
                text: "Ви дійсно бажаєте видалити папку<br/>" + dataItem.NAME + " ?"
            }, function () {
                var grid = $("#OperList").data("kendoGrid");
                var record = grid.dataItem(grid.select());

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/operremovefolder/post"),
                    dataType: "json",
                    data: {
                        id: record.TT,
                        idfo: dataItem.IDFO
                    }
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#FoldersGrid").data("kendoGrid").dataSource.read();
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
                        template: kendo.template(removeButtons("folder"))
                    }
                ],
                title: "Дії над папкою",
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
        toolbar: [
          { template: "<button id='addFolder' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-plus' aria-hidden='true'></span> Додати</button>" }
        ],
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
            serverSorting: true,
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

    function addNewFolder(selectedItem)
    {
        var grid = $("#OperList").data("kendoGrid");
        var record = grid.dataItem(grid.select());
        
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/admin/oper/insertfolder?id=" + record.TT + "&idfo=" + selectedItem.IDFO),
            dataType: "json",
            traditional: true
        }).done(function (result) {
            bars.ui.alert({ text: result });

        });
    }

    var foldersWindow = $("#folders-window").kendoWindow({
        title: "Папки",
        visible: false,
        width: "600px",
        scrollable: true,
        resizable: true,
        modal: true,
        actions: ["Close"],
            close: function(e) {
                // reset all filters                
                $("#folders-grid").data("kendoGrid").dataSource.filter({});
              }
    });

    $("#addFolder").click(function () {
        var gview = $("#folders-grid").data("kendoGrid");
        var selectedItem = gview.dataItem(gview.select());

        if (selectedItem) {


            bars.ui.confirm({
                text: "Ви дійсно бажаєте додати папку<br/>" + selectedItem.NAME + " ?"
            }, function () {
                foldersWindow.data("kendoWindow").close();

                addNewFolder(selectedItem);

                $("#folders-grid").data("kendoGrid").dataSource.read();
                $("#FoldersGrid").data("kendoGrid").dataSource.read();
            });

        } else {
            bars.ui.alert({ text: "Оберіть значення, яке потрібно додати!" });
        }
    });

    function foldersHandbook() {

        $("#folders-grid").data("kendoGrid").dataSource.read();
        //$("#folders-grid").data("kendoGrid").refresh();
        
        folders.show();

        var window = foldersWindow.data("kendoWindow");
        window.center().open();
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
            //$("#OperList").data("kendoGrid").refresh();
        });
    }

    //Card Toolbar 
    $("#CardToolbar").kendoToolBar({
        items: [
            { template: "<input id='dropdown_transactionType' style='width: 250px;'/>", overflow: "never" },
            { type: "separator" },
            { template: "<input id='dropdown_transactionView' style='width: 250px;'/>", overflow: "never" },
            { type: "separator" },
            { template: "<div class='checkbox'><label><input id='hardTransaction' type='checkbox'> Cкладна транзакція </label></div>" },
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
        change: function (e) {
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
            read: function (options) {
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
                    ACC_MASK: { type: "string" }, 
                    KV: { type: "number", validation: { required: false } },   // was: required: { message: "Не введено значення!" }, min: 1
                    BANK: { type: "number", validation: { required: false } }, // was: required: { message: "Не введено значення!" }, min: 1
                    KP: { type: "number", validation: {  required: false } }    // was: required: { message: "Не введено значення!" }, min: 1
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
            { field: "NAZN", title: "Призначення рахунку", width: "15%" },
            { field: "ACC_MASK", title: "Маска/Формула рахунку", width: "25%"},
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
        dataSource: localAccountGrid,
        dataBound: function (e) {
            if (access_mode == "read") {
                $("#AccountGrid").find("a.k-button").attr("disabled", "disabled");   
            }
        }
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
            {
                command: ["edit"], title: "Редагування", width: "20%"
            }
        ],
        editable: "inline",
        dataSource: localAccountOptionGrid,
        dataBound: function (e) {
            if (access_mode == "read") {
                $("#AccountGridOptions").find("a.k-button").attr("disabled", "disabled");            
            }
        }
    });

    //if access_mode == "read" we need to disable all buttons
    if (access_mode == "read") {
        $(':button').attr("disabled", "disabled");        
        $("#CardToolbar").attr("disabled", "disabled");
        $("#dropdown_transactionView").data("kendoDropDownList").enable(false);
        $("#dropdown_transactionType").data("kendoDropDownList").enable(false);
    }

    function removeButtons(grid) {
	    var disable = "disabled='disabled' ";
	    var position = 8;

        var buttons = {
            flag: "<button name='removeFlag' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>",
            prop: "<button name='removeProp' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>",
            account: "<button name='removeAccount' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>",
            transaction: "<button name='removeTransaction' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>",
            doc: "<button name='removeDoc' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>",
            group: "<button name='removeGroup' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>",
            folder: "<button name='removeFolder' class='btn btn-danger btn-xs'><span class='glyphicon glyphicon-minus' aria-hidden='true'></span> Видалити</button>"
        }
	
	    var output = buttons[grid];

        if(access_mode == "read"){
		    output = [buttons[grid].slice(0,position), disable, buttons[grid].slice(position)].join('');
        }
        return output;
    }
});