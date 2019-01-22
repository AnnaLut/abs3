var error = error || {};
$(document).ready(function () {
    var userType = (function () {
        var state; //private variable, save current type

        var pub = {}; //public object for access prop

        pub.setType = function (type) {
            if (type === "oper")
                state = 0;
            else if (type === "control")
                state = 1;
        };
        pub.getType = function () {
            return state;
        }
        return pub;
    }());
    var url = window.location.href;
    url = url.split("/");
    userType.setType(url[6]);


    $("#toolbar").kendoToolBar({
        items: [
            { template: "<button type='button' class='k-button right-pos' id='visaBtn'><span class='k-sprite pf-icon pf-16 pf-key'></span> Візування</button>" },
            { template: "<button type='button' class='k-button right-pos' id='stornoBtn'><span class='k-sprite pf-icon pf-16 pf-arrow_left'></span> Повернути виконавцю</button>" },
            { template: "<button type='button' class='k-button right-pos' id='stornoAllBtn'><span class='k-sprite pf-icon pf-16 pf-delete'></span> Повернути та сторнувати</button>" },
            //{ template: "<button type='button' class='k-button right-pos' id='errorBtn'><span class='k-sprite pf-icon pf-16 pf-undo_green'></span> Виявлена помилка</button>" },

            { template: "<div class='legend-green'></div><label class='legend-label-nonact'>- існують виплати</label>" },
            { template: "<div class='legend-red'></div><label class='legend-label-nonact'>- повернені операції</label>" }
        ]
    });

    var getCountOperations = function () {
        $.ajax({
            data: { userType: userType.getType() },
            url: bars.config.urlContent("/api/crkr/sight/count"),
            type: "GET",
            success: function (data) {                
                    $("#tab0").text(data[0]);
                    $("#tab1").text(data[1]);
                    $("#tab2").text(data[2]);
                    $("#tab3").text(data[3]);
                    $("#tab4").text(data[4]);
                    $("#tab5").text(data[5]);
                    $("#tab6").text(data[6]);

                if (userType.getType() === 0) {
                    $(".legend-green").hide().next().hide();
                }
            }
        });
    }

    function deposit(e) {
        return "<a class='link-color' href='/barsroot/crkr/depositprofile/depositinventory?depoid=" + e.ID + "&flag=1'>" + e.ID + "</a>";
    }

    function userProfile(e) {
        if (userType.getType() === 1)
            return "<a class='link-color' href='/barsroot/crkr/clientprofile/index?rnk=" + e.RNK + "&button=true'>" + e.FIO_ACT + "</a>";
        else if (userType.getType() === 0)
            return "<a class='link-color' href='/barsroot/crkr/clientprofile/index?rnk=" + e.RNK + "'>" + e.FIO_ACT + "</a>";
        else
            return e.FIO_ACT;
    }

    function canceledDepo(e) {
        if (userType.getType() === 1) {
            var grid = $("#cancelactual").data("kendoGrid");
            if (grid !== undefined)
                grid.tbody.find(">tr").each(function () {
                    var dataItem = grid.dataItem(this);
                    if (dataItem.IS_PAY_DEP_DONE === 1) {
                        $(this).css("background-color", "#93ecaa");
                    }
                });
        }
        else if (userType.getType() === 0) {
            var gird = this;
            gird.tbody.find('>tr').each(function () {
                var dataItem = gird.dataItem(this);
                if (dataItem.IS_CHANGE_STATE === 1) {
                    $(this).css("background-color", "#ffa3a3");
                }
            });

        }
    }


    $("#opersightact, #opersightfun, #opersighther, #replenishment, #cancelactual").kendoGrid({
        autobind: false,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        pageable: {
            buttonCount: 5
        },
        columns: [
             {
                 headerTemplate: "<input type='checkbox' id='checkAll' class='checkbox' name='checkRow'/>",
                 filterable: false,
                 template: '<input type="checkbox" class="checkbox" name="checkRow"/>',
                 width: "2em"
             },
             { field: "RNK", hidden: true },
            {
                field: "OPER_ID",
                title: "ID",
                width: "5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "TEXT",
                title: "Операція",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "MSG",
                title: "Повідомлення",
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "FIO",
                title: "ПІБ",
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "NSC",
                title: "Номер книжки",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "OST",
                title: "Залишок",
                width: "8em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "FIO_ACT",
                title: "ПІБ клієнта",
                template: userProfile,
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "AMOUNT",
                title: "Сума",
                width: "6em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "REGDATE",
                title: "Дата",
                template: "<div>#= kendo.toString(kendo.parseDate(REGDATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(REGDATE),'dd.MM.yyyy')#</div>",
                width: "8em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ID",
                title: "ID вкладу",
                template: deposit,
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "USER_LOGIN",
                title: "Користувач",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        dataSource: {
            pageSize: 10,
            schema: {
                model: {
                    fields: {
                        OPER_ID: { type: "string" },
                        TEXT: { type: "string" },
                        MSG: { type: "string" },
                        FIO: { type: "string" },
                        NSC: { type: "string" },
                        OST: { type: "string" },
                        FIO_ACT: { type: "string" },
                        AMOUNT: { type: "string" },
                        REGDATE: { type: "string" },
                        ID: { type: "string" },
                        RNK: { hidden: "string" },
                        USER_LOGIN: { type: "string" }
                    }
                }
            }
        },
        dataBound: canceledDepo
    });
       
    $("#benefactual").kendoGrid({
        autobind: false,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        pageable: {
            buttonCount: 5
        },
        columns: [
             {
                 headerTemplate: "<input type='checkbox' id='checkAll' class='checkbox' name='checkRow'/>",
                 filterable: false,
                 template: '<input type="checkbox" class="checkbox" name="checkRow"/>',
                 width: "2em"
             },
             { field: "RNK", hidden: true },
             { field: "CHANGE_INFO", hidden: true },
            {
                field: "OPER_ID",
                title: "ID",
                width: "5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "TEXT",
                title: "Операція",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "MSG",
                title: "Повідомлення",
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "FIO",
                title: "ПІБ",
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "NSC",
                title: "Номер книжки",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "OST",
                title: "Залишок",
                width: "8em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "FIO_BENEF",
                title: "ПІБ бенефіціара",
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "IDB",
                title: "IDB",
                width: "6em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "REGDATE",
                title: "Дата",
                template: "<div>#= kendo.toString(kendo.parseDate(REGDATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(REGDATE),'dd.MM.yyyy')#</div>",
                width: "8em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ID",
                title: "ID вкладу",
                template: deposit,
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "USER_LOGIN",
                title: "Користувач",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        dataSource: {
            pageSize: 10,
            schema: {
                model: {
                    fields: {
                        OPER_ID: { type: "string" },
                        TEXT: { type: "string" },
                        MSG: { type: "string" },
                        FIO: { type: "string" },
                        NSC: { type: "string" },
                        OST: { type: "string" },
                        FIO_ACT: { type: "string" },
                        AMOUNT: { type: "string" },
                        REGDATE: { type: "string" },
                        ID: { type: "string" },
                        RNK: { hidden: "string" },
                        USER_LOGIN: { type: "string" },
                        CHANGE_INFO: {
                            type: "string", attributes: {
                                style: 'white-space: nowrap '
                            }
                        }
                    }
                }
            }
        },
        dataBound: canceledDepo
    });
       
    $("#document").kendoGrid({
        autobind: false,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        detailInit: detailInit,
        pageable: {
            buttonCount: 5
        },
        columns: [
             {
                 headerTemplate: "<input type='checkbox' id='checkAll' class='checkbox' name='checkRow'/>",
                 filterable: false,
                 template: '<input type="checkbox" class="checkbox" name="checkRow"/>',
                 width: "2em"
             },
            {
                field: "OPER_ID",
                title: "ID",
                width: "5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "TEXT",
                title: "Операція",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "MSG",
                title: "Повідомлення",
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "FIO",
                title: "ПІБ",
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "OST",
                title: "Залишок",
                width: "8em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "REGDATE",
                title: "Дата",
                template: "<div>#= kendo.toString(kendo.parseDate(REGDATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(REGDATE),'dd.MM.yyyy')#</div>",
                width: "8em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ID",
                title: "ID вкладу",
                template: deposit,
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "NAME",
                title: "Тип документу",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "DOCSERIAL",
                title: "Серія",
                width: "8em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "DOCNUMBER",
                title: "Номер",
                width: "8em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "DOCORG",
                title: "Ким виданий",
                width: "18em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "DOCDATE",
                title: "Коли виданий",
                template: "<div>#= kendo.toString(kendo.parseDate(DOCDATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(DOCDATE),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "USER_LOGIN",
                title: "Користувач",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        dataSource: {
            pageSize: 10,
            schema: {
                model: {
                    fields: {
                        OPER_ID: { type: "string" },
                        TEXT: { type: "string" },
                        MSG: { type: "string" },
                        FIO: { type: "string" },
                        OST: { type: "string" },
                        REGDATE: { type: "string" },
                        ID: { type: "string" },
                        NAME: { type: "string" },
                        DOCSERIAL: { type: "string" },
                        DOCNUMBER: { type: "string" },
                        DOCORG: { type: "string" },
                        DOCDATE: { type: "string" },
                        USER_LOGIN: { type: "string" }
                    }
                }
            }
        },
        dataBound: canceledDepo
    });

    function detailInit(e) {
        $("<div/>").appendTo(e.detailCell).kendoGrid({
            dataSource: {
                dataType: "json",
                type: "GET",
                transport: {
                    read: bars.config.urlContent("/api/crkr/sight/docinfo?id=" + e.data.ID)
                },
                pageSize: 10
            },
            scrollable: false,
            sortable: true,
            pageable: true,
            columns: [
                {
                    field: "TEXT",
                    title: "Дочірня операція",
                    width: "50px"
                }, {
                    field: "FIO",
                    title: "ПІБ",
                    width: "50px"
                }, {
                    field: "NSC",
                    title: "Номер рахунку",
                    width: "50px"
                }, {
                    field: "OST",
                    title: "Залишок",
                    width: "70px"
                }
            ]
        });
    }
    
    $("#benefactual").kendoTooltip({
        filter: "td:nth-child(5)", //this filter selects the second column's cells
        position: "top",
        content: function (e) {
            var dataItem = $("#benefactual").data("kendoGrid").dataItem(e.target.closest("tr"));
            if (dataItem.CHANGE_INFO !== null)
                return dataItem.CHANGE_INFO;
            else
                return "Створена операція.";
           
        }
    }).data("kendoTooltip");

    var getDataForGrids = function (objData, gridName) {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/sight/depo"),
            type: "GET",
            dataType: "JSON",
            data: objData,
            success: function (model) {
                $("#" + gridName).data("kendoGrid").dataSource.data(model);
                if (gridName === "replenishment")
                    //TODO визначити який стовбець треба ховати (зараз ховає ПІБ)
                    $('#replenishment').data('kendoGrid').hideColumn(5);

                //if(gridName === "benefactual")

            },
            error: function () {
                bars.ui.notify('Увага!', 'Сталася помилка.', 'error');
            }
        });
    }

    function onSelect(e) {
        var index = $(e.item).index();
        if (index === 0) {
            getDataForGrids({ TabIndex: index, UserType: userType.getType() }, "opersightact");

        } else if (index === 1) {
            getDataForGrids({ TabIndex: index, UserType: userType.getType() }, "opersightfun");

        } else if (index === 2) {
            getDataForGrids({ TabIndex: index, UserType: userType.getType() }, "opersighther");

        } else if (index === 3) {
            getDataForGrids({ TabIndex: index, UserType: userType.getType() }, "replenishment");

        } else if (index === 4) {
            getDataForGrids({ TabIndex: index, UserType: userType.getType() }, "cancelactual");

        } else if (index === 5) {
            getDataForGrids({ TabIndex: index, UserType: userType.getType() }, "benefactual");

        } else if (index === 6) {
            getDataForGrids({ TabIndex: index, UserType: userType.getType() }, "document");
        }

    }

    var tabstrip = $("#tabstrip").kendoTabStrip({ select: onSelect }).data("kendoTabStrip");

        tabstrip.select(0);

    //hide something from different user types
    (function () {
        if (userType.getType() === 0) {//oper
            //$("#errorBtn").hide();
            $('#stornoBtn').get(0).lastChild.nodeValue = "Сторно";
            $('#storno').get(0).lastChild.nodeValue = "Сторно";
        }
       
        getCountOperations();
    })();

    //return grid id in current tab
    var currentGrid = function () {
        var selectedIndex = tabstrip.select().index();
        var gridId;
        if (selectedIndex === 0)
            gridId = "#opersightact";
        if (selectedIndex === 1)
            gridId = "#opersightfun";
        if (selectedIndex === 2)
            gridId = "#opersighther";
        if (selectedIndex === 3)
            gridId = "#replenishment";
        if (selectedIndex === 4)
            gridId = "#cancelactual";
        if (selectedIndex === 5)
            gridId = "#benefactual";
        if (selectedIndex === 6)
            gridId = "#document";
        return gridId;
    }

    //return array of checked items in grid
    var checkedItems = function (gridId) {
        var idsToSend = [];
        var grid = $(gridId).data("kendoGrid");
        var ds = grid.dataSource.view();

        for (var i = 0; i < ds.length; i++) {
            var row = grid.table.find("tr[data-uid='" + ds[i].uid + "']");
            var checkbox = $(row).find(".checkbox");

            if (checkbox.is(":checked")) {
                idsToSend.push(ds[i].OPER_ID);
            }
        }
        return idsToSend;
    }

    var multiRequest = function (obj, oper, successMsg) {
        bars.ui.loader("body", true);
        $.ajax({
            url: bars.config.urlContent("/api/crkr/sight/" + oper),
            data: obj,
            type: "POST",
            success: function (data) {
                bars.ui.loader("body", false);
                if (typeof data === "object") {
                    $(currentGrid()).data("kendoGrid").dataSource.data(data);
                    getCountOperations();
                    bars.ui.notify("Операція успішна!", successMsg, "success");
                } else {
                    var flag = data.includes("ORA");
                    if (flag) {
                        error.window(data);
                    } else {
                        bars.ui.notify("Увага!", "Сталася помилка!", "error");
                    }
                }
            }
        });
    }
    
    $("#visaBtn").click(function () {       
        var selectedIndex = tabstrip.select().index();
        var gridId = currentGrid();
        var idsToSend = checkedItems(gridId);

        var model = {
            id: idsToSend,
            TabIndex: selectedIndex,
            UserType: userType.getType
        }

        if (idsToSend.length > 0) {
            bars.ui.confirm({ text: "Виконати візування?" }, function () {
                multiRequest(model, "visa", "Документи завізовано!");
            });
        } else {
            bars.ui.notify("Увага!", "Оберіть хоча б один запис", "error");
        }
    });

    $("#opersightact, #opersightfun, #opersighther, #replenishment, #cancelactual, #benefactual, #document").find("#checkAll").on("change", function (e) {
        e.preventDefault();

        var selector = $(this)
            .parents()[6].id;
        var grid = $("#" + selector);
        var checkedRows = grid.find('input[type="checkbox"][name="checkRow"]');
        var $this = $(this);
        if ($this.is(":checked")) {
            checkedRows.prop("checked", true);
        } else {
            checkedRows.prop("checked", false);
        }
    });
        
    //----------------------------------Вікно для вказання причини сторнування-----------------------------

    $("#storno").click(function () {
        var selectedIndex = tabstrip.select().index();
        var gridId = currentGrid();
        var idsToSend = checkedItems(gridId);

        var model = {
            id: idsToSend,
            TabIndex: selectedIndex,
            Reason: $("#reason").val(),
            UserType: userType.getType
        }

        if (idsToSend.length > 0) {
            var obj = {};
            if (userType.getType() === 1 || userType.getType() === 2) {
                obj.confirm = "Виконати повернення?",
                obj.success = "Документи повернено!"
            }
            else {
                obj.confirm = "Виконати сторнування?",
                obj.success = "Документи сторновано!"
            }
            bars.ui.confirm({ text: obj.confirm }, function () {
                multiRequest(model, "storno", obj.success);
                $("#reasonWindow").data("kendoWindow").close();
            });
        } else {
            bars.ui.notify("Увага!", "Оберіть хоча б один запис", "error");
        }
    });

    $("#stornoAll").click(function () {
        var selectedIndex = tabstrip.select().index();
        var gridId = currentGrid();
        var idsToSend = checkedItems(gridId);

        if (idsToSend.length > 0) {

            var model = {
                id: idsToSend,
                TabIndex: selectedIndex,
                Reason: $("#reason").val(),
                UserType: userType.getType
            }
            var obj = {};
            obj.confirm = "Виконати сторнування?";
            obj.success = "Документи сторновано!";

            bars.ui.confirm({ text: obj.confirm }, function () {
                multiRequest(model, "stornoAll", obj.success);
                $("#reasonWindow").data("kendoWindow").close();
            });
        } else {
            bars.ui.notify("Увага!", "Оберіть хоча б один запис", "error");
        }
    });

    $(function () {
        function onClose() {
            $("#reasonWindow").fadeIn();
        }

        $("#reasonWindow").kendoWindow({
            width: "500px",
            title: "Вкажіть причину відміни для виділених операцій",
            resizable: false,
            visible: false,
            modal: true,
            actions: ["Close"],
            close: onClose
        });

        $("#reasonBackAllWindow").kendoWindow({
            width: "500px",
            title: "Вкажіть причину сторнування для виділених операцій",
            resizable: false,
            visible: false,
            modal: true,
            actions: ["Close"],
            close: function () {
                $("#reasonBackAllWindow").fadeIn();
            }
        });
    });

    $("#stornoBtn").click(function () {
        $("#reasonWindow").data("kendoWindow").center().open();
    });

    $("#stornoAllBtn").click(function () {
        $("#reasonBackAllWindow").data("kendoWindow").center().open();
    });
    
    //-----------------------------------------------------------------------------------------------------

    //----------------------------------Вікно для вказання виявленої помилки-------------------------------
    $("#error").click(function () {
        var selectedIndex = tabstrip.select().index();
        var gridId = currentGrid();
        var idsToSend = checkedItems(gridId);

        var model = {
            id: idsToSend,
            TabIndex: selectedIndex,
            Reason: $("#reasonError").val(),
            UserType: userType.getType
        }

        if (idsToSend.length > 0) {
            bars.ui.confirm({ text: "Ви впевнені у своїх діях?" }, function () {
                multiRequest(model, "error", "Документи відмічено як помилковий!");
                $("#reasonErrorWindow").data("kendoWindow").close();
            });
        } else {
            bars.ui.notify("Увага!", "Оберіть хоча б один запис", "error");
        }
    });
   
    $(function () {
        function onClose() {
            $("#reasonErrorWindow").fadeIn();
        }

        $("#reasonErrorWindow").kendoWindow({
            width: "500px",
            title: "Вкажіть причину помилкової операції",
            resizable: false,
            visible: false,
            modal: true,
            actions: [
                "Close"
            ],
            close: onClose
        });
    });

    //$("#errorBtn").click(function () {
    //    $("#reasonErrorWindow").data("kendoWindow").center().open();
    //});
    //-----------------------------------------------------------------------------------------------------
    
    //bocouse ie8
    if (!String.prototype.includes) {
        // ReSharper disable once NativeTypePrototypeExtending
        String.prototype.includes = function () {
            'use strict';
            return String.prototype.indexOf.apply(this, arguments) !== -1;
        };
    }
});