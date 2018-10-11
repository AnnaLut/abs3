app.controller("homeController", ['$scope', 'paramsService', '$window', 'LS', homeController]);


function homeController($scope, paramsService, $window, LS) {
    $("#loader").hide();
    paramsService.getDefaultParams().then(function (model) {
        $scope.contractModel = model;
        $scope.ADAT = new Date(model.BANKDATE);
    });

    $scope.getGridFilter = function () {
        bars.ui.getFiltersByMetaTable(function (response) {
            if (response && response.length > 0) {
                window.gridParams.strPar02 = response.join(' and ');
                //   window.gridParams.strPar02 = 'ID = 439';
                $scope.gridParams = window.gridParams;
            }
            else {
                window.gridParams.strPar02 = ' 1=1 ';
                $scope.gridParams = window.gridParams;
            }
            function updateGrid() {
                if ($scope.ADAT) {
                    $scope.grid.dataSource.read();
                    return;
                } else {
                    setTimeout(updateGrid, 500);
                }
            }
            updateGrid();
        }, { tableName: "CP_V_NEW" });
    }

    setTimeout(function () {
        $scope.getGridFilter();
    }, 500);

    var getDealWindowFilter = function () {
        bars.ui.getFiltersByMetaTable(function (response) {
            return response
        }, { tableName: "CP_KOD" });
    }

    $scope.gridDataSource = {
        type: "webapi",
        transport: {
            read: {
                type: "GET",
                dataType: 'json',
                url: bars.config.urlContent('/api/valuepapers/generalfolder/GetCpv'),
                data: function () {

                    $scope.gridParams.P_DATE = $scope.ADAT.toISOString()
                    return $scope.gridParams;
                }
            }
        },
        requestStart: function () {
            $("#loader").show();
        },
        requestEnd: function () {
            $("#loader").hide();
        },
        //serverPaging: true, //просили сделать простыней, без страниц.
        serverFiltering: true,
        serverSorting: true,
        //pageSize: 25,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    DATD: { type: "date" },
                    ND: { type: "string" },
                    SUMB: { type: "number" },
                    REF: { type: "number" },
                    ID: { type: "number" },
                    CP_ID: { type: "string" },
                    KV: { type: "number" },
                    VIDD: { type: "number" },
                    PFNAME: { type: "string" },
                    RYN: { type: "string" },
                    DATP: { type: "date" },
                    NO_PR: { type: "number" },
                    BAL_VAR: { type: "number" },
                    KIL: { type: "number" },
                    ZAL: { type: "number" },
                    CENA: { type: "number" },
                    OSTA: { type: "number" },
                    OSTAB: { type: "number" },
                    OSTAF: { type: "number" },
                    OSTD: { type: "number" },
                    OST_2VD: { type: "number" },
                    OSTP: { type: "number" },
                    OST_2VP: { type: "number" },
                    OSTR: { type: "number" },
                    OSTRD: { type: "number" },
                    OSTR2: { type: "number" },
                    OSTR3: { type: "number" },
                    OSTEXPN: { type: "number" },
                    OSTEXPR: { type: "number" },
                    OSTUNREC: { type: "number" },
                    OSTS: { type: "number" },
                    OSTS2: { type: "number" },
                    ERAT: { type: "number" },
                    NO_P: { type: "number" }
                }
            }
        }
    };

    $scope.isRightClick = false;

    var total = 0;

    var cntrlIsPressed = false;

    html = document.documentElement;

    var height = Math.max(html.clientHeight, html.scrollHeight, html.offsetHeight);
    $scope.gridOptions = {
        autoBind: false,
        resizable: true,
        sortable: true,
        //    selectable: "multiple",
        height: (height / 1.95).toString() + "px", //(height / 2.2).toString()
        toolbar: [{ name: "excel", text: "Експорт в Excel" }],//
        excel: {
            proxyURL: "/barsroot/valuepapers/generalfolder/Excel_Export_Save"
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            var row = sheet.rows[0];
            for (var cellIndex = 0; cellIndex < row.cells.length; cellIndex++) {
                row.cells[cellIndex].value = row.cells[cellIndex].value.replace(/<br>/g, ' ');
            }
        },
        columns: [
            {
                field: "DATD",
                title: "Дата<br>угоди<br>купівлі",
                template: "<div style='text-align:center;'>#=DATD!=null ? kendo.toString(DATD,'dd/MM/yyyy') : '' #</div>",
                width: 85
            },
            { field: "ND", title: "№<br>угоди<br>купівлі", width: 90, template: "<div style='text-align:center;'>#=ND#</div>" },
            { field: "SUMB", title: "Сума<br>угоди<br>купівлі", width: 120, template: "<div style='text-align:right;'>#=kendo.toString(SUMB,'n2')#</div>" },
            { field: "REF", title: "РЕФ<br>угоди<br>купівлі", width: 100, template: "<div style='text-align:center;'>#=REF#</div>" },
            { field: "ID", title: "№<br>ЦП", width: 75, template: "<div style='text-align:center;'>#=ID#</div>" },
            { field: "CP_ID", title: "Код<br>ЦП", width: 110, template: "<div style='text-align:center;'>#=CP_ID#</div>" },
            { field: "KV", title: "Вал", width: 50, template: "<div style='text-align:center;'>#=KV#</div>" },
            { field: "VIDD", title: "Вид<br>угод", width: 65, template: "<div style='text-align:center;'>#=VIDD#</div>" },
            { field: "PFNAME", title: "Потрфель", width: 150 },
            { field: "RYN", title: "Суб<br>портфель", width: 150 },
            { field: "DATP", title: "Дата<br>погашення", template: "<div style='text-align:center;'>#=DATP!=null ? kendo.toString(DATP,'dd.MM.yyyy') : ''#</div>", width: 85 },
            { field: "NO_PR", title: "Ном.<br>%ст.<br>річна", width: 60, template: "<div style='text-align:center;'>#=NO_PR#</div>" },
            { field: "BAL_VAR", title: "Бал-варт.факт<br>N+D+P+R+R2<br>+S+2VD+2VP", width: 150 },
            { field: "KIL", title: "Кіль-ть<br>ЦП-факт.<br>в пакеті", width: 90, template: "<div style='text-align:center;'>#=KIL#</div>" },
            { field: "ZAL", title: "в.т.ч.<br>в<br>заставі", width: 100, template: "<div style='text-align:center;'>#=ZAL#</div>" },
            { field: "CENA", title: "Ціна<br>1 шт.<br>ЦП", width: 70 },
            { field: "OSTA", title: "Сума<br>ном.<br>№", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTA,'n2')#</div>" },
            { field: "OSTAB", title: "Сума<br>ном<br>№-план", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTAB,'n2')#</div>" },
            { field: "OSTAF", title: "Сума<br>ном.<br>№-буд.", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTAF,'n2')#</div>" },
            { field: "OSTD", title: "Сума<br>дисконту<br>D", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTD,'n2')#</div>" },
            { field: "OST_2VD", title: "Сума<br>дисконту<br>2VD", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OST_2VD,'n2')#</div>" },
            { field: "OSTP", title: "Сума<br>премії<br>Р", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTP,'n2')#</div>" },
            { field: "OST_2VP", title: "Сума<br>премії<br>2VР", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OST_2VP,'n2')#</div>" },
            { field: "OSTR", title: "Сума<br>нарах.%<br>R", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTR,'n2')#</div>" },
            { field: "OSTRD", title: "Сума<br>нарах.%<br>дивідентів", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTRD,'n2')#</div>" },
            { field: "OSTR2", title: "Сума<br>куплених.%<br>R2", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTR2,'n2')#</div>" },
            { field: "OSTR3", title: "Сума<br>куплених.%<br>R3", width: 90, template: "<div style='text-align:right;'>#=kendo.toString(OSTR3,'n2')#</div>" },
            { field: "OSTUNREC", title: "Остат.<br>невизн.куп.%<br>доходів", width: 100 },
            { field: "OSTEXPN", title: "Сума<br>прострочки<br>номіналу", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTEXPN,'n2')#</div>" },
            { field: "OSTEXPR", title: "Сума<br>прострочки<br>нарах.купону", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTEXPR,'n2')#</div>" },
            { field: "OSTS", title: "Сума<br>переоц.<br>S", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTS,'n2')#</div>" },
            { field: "OSTS2", title: "Сума<br>переоц.<br>S2", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(OSTS2,'n2')#</div>" },
            { field: "ERAT", title: "Ефект<br>ставка %", width: 100, template: "<div style='text-align:right;'>#=ERAT#</div>" },
            { field: "NO_P", title: "Приз<br>НЕ<br>переоц.", width: 90 }
        ],
        dataSource: $scope.gridDataSource,
        enableColumnResize: true,
        columnMenu: true,
        columnMenuInit: function (e) {
            var menu = e.container.children().data("kendoMenu");
            menu.bind("close", function () { $scope.setStorageHiddenColumns() });
        },
        dataBound: function () {
            var grid = this;

            $('#grid tbody tr').each(function (index, elem) {

                if (grid.dataItem(elem).ACTIVE == -1)
                    $(elem).addClass('red-row');
                if (grid.dataItem(elem).ACTIVE == 0)
                    $(elem).addClass('green-row');
                if (grid.dataItem(elem).ACTIVE == 1)
                    $(elem).addClass('white-row');
            });

            filter_columns_str = LS.getData();
            if (filter_columns_str !== null && filter_columns_str !== "") {
                filter_columns_array = filter_columns_str.split(',');
                for (var i = 0; i < filter_columns_array.length; i++) {
                    tmp = filter_columns_array[i];
                    grid.hideColumn(filter_columns_array[i]);
                }
            }

            $(document).off('keydown').on('keydown', function (event) {
                if (event.which == "17")
                    cntrlIsPressed = true;
            });

            $(document).off('keyup').on('keyup', function () {
                cntrlIsPressed = false;
            });

            $('#grid tbody tr').off('click').on('click', function (event) {

                if (cntrlIsPressed)
                    $(event.target).closest('tr').toggleClass('k-state-selected');
                else {
                    $('#grid tbody tr.k-state-selected').removeClass('k-state-selected');
                    $(event.target).closest('tr').addClass('k-state-selected');
                }

                var selectedRows = $('#grid tbody tr.k-state-selected');
                if (selectedRows.length > 0)
                    $scope.firstSelRow = grid.dataItem(selectedRows[0]);
                else
                    $scope.firstSelRow = undefined;
            });


            //-------------------------TOOLTIP---------

            kendo.ui.Tooltip.fn._show = function (show) {
                return function (target) {
                    var e = {
                        sender: this,
                        target: target,
                        preventDefault: function () {
                            this.isDefaultPrevented = true;
                        }
                    };

                    if (typeof this.options.beforeShow === "function") {
                        this.options.beforeShow.call(this, e);
                    }
                    if (!e.isDefaultPrevented) {
                        show.call(this, target);
                    }
                };
            }(kendo.ui.Tooltip.fn._show);

            $("#grid").kendoTooltip({
                filter: "td", //this filter selects all th and td cells
                position: "right",

                beforeShow: function (event) {
                    if (!$(event.target).closest('tr').hasClass('k-state-selected') ||
                            $(event.target).closest("tbody").find("tr.k-state-selected").length < 2) {
                        event.preventDefault();
                    }

                    var index = $(event.target).closest('td').index();
                    var sum = 0;
                    $(event.target).closest("tbody").find("tr.k-state-selected").find("td:nth-child(" + (index + 1) + ")").each(function (index, elem) {

                        var num = +$(elem).text().replace(/[^\w\.//]/g, '');
                        if (!isNaN(num))
                            sum += num;
                    });
                    total = sum;
                    if (sum == 0)
                        event.preventDefault();


                },
                // apply additional custom logic to display the text of the relevant element only
                content: function (e) {
                    return "Сумма: " + total;
                    var cell = $(e.target);
                    var content = cell.text();
                    return content;
                }
            })

            $('#grid .k-grid-content tr').off('dblclick').on('dblclick', function (event) {
                var ref = grid.dataItem($(event.target).closest('tr')).REF;
                $scope.openBarsDialog('/barsroot/documentview/default.aspx?ref=' + ref);
            })
        }
    };

    $scope.inversePActiveUpdateGrid = function () {
        $scope.gridParams.p_active = +!$scope.gridParams.p_active;
        $scope.grid.dataSource.read();
    };

    $scope.showContractSaleWindow = function () {
        transport.dDat = 0;
        transport.SUMBK = 0;
    }

    $scope.$on('updateGrid', function () {
        //    $scope.contactSaleWindow.close();
        $scope.grid.dataSource.read();
    })

    $scope.newDeal = function (p_nOp, p_fl_END, p_nGrp) {
        $scope.p_nOp = p_nOp;
        $scope.p_fl_END = p_fl_END;

        bars.ui.getMetaDataNdiTable("CP_KOD", function (response) {

            var options = {
                ID: response.ID
            }
            paramsService.resetModel();

            paramsService.getDealWindowParams(p_nOp, p_fl_END, p_nGrp, options).then(function (windowTitle) {
                $scope.$broadcast('updateDropDown');
                $scope.contactSaleWindow.title(windowTitle).open().center();
            });

        }, { hasCallbackFunction: true });

    }

    $scope.newDealRef = function (p_nOp, p_fl_END, p_nGrp) {
        /*  bars.ui.getMetaDataNdiTable("CP_V", function (response) {
               
               var options = {
                   REF: response.REF,
               }           
               
               paramsService.resetModel();
   
               paramsService.getDealWindowParams(p_nOp, p_fl_END, p_nGrp, options).then(function (windowTitle) {
                   $scope.$broadcast('updateDropDown');
                   $scope.contactSaleWindow.title(windowTitle).open().center();
               });
   
           }, { hasCallbackFunction: true });
           */
        var options = {
            REF: $scope.firstSelRow.REF
        }
        paramsService.resetModel();
        paramsService.getDealWindowParams(p_nOp, p_fl_END, p_nGrp, options).then(function (windowTitle) {
            $scope.$broadcast('updateDropDown');
            $scope.contactSaleWindow.title(windowTitle).open().center();
        });
    }

    $scope.openMetaTableWithRef = function () {        
        var options = {
            jsonSqlParams: "[{\"Name\":\"P_REF\",\"Type\":\"S\",\"Value\":" + $scope.firstSelRow.REF+ "}]",
            code: "V_CP_INT_DIVIDENTS",
            hasCallbackFunction: false//,
            // externelFuncOnly: true,
        };

        bars.ui.getMetaDataNdiTable("", function () {

        }, options);

    }
          
    $scope.openMetaTable4PayDiv = function () {        
        var options = {
            jsonSqlParams: "[{\"Name\":\"P_REF\",\"Type\":\"S\",\"Value\":" + $scope.firstSelRow.REF+ "}]",
            code: "V_CP_PAY_DIVIDENTS",
            hasCallbackFunction: false//,
            // externelFuncOnly: true,
        };

        bars.ui.getMetaDataNdiTable("", function () {

        }, options);

    }
    $scope.getBMD = function () {
        bars.ui.getMetaDataNdiTable("CP_KOD", function (response) {
            bars.ui.dialog({
                content: bars.config.urlContent('/valuepapers/cptoanotherbag/index') + '?id=' + response.ID,
                iframe: true,
                width: document.documentElement.offsetWidth * 0.8,
                height: document.documentElement.offsetHeight * 0.6
            });
        }, { hasCallbackFunction: true });
    }

    $scope.payTicket = function (strPar02, nGrp, nMode) {
        bars.ui.getMetaDataNdiTable("CP_KOD", function (response) {
            bars.ui.dialog({
                content: bars.config.urlContent('/valuepapers/payticket/index') + '?strPar01=' + "ID = " + response.ID + '&strPar02=' + strPar02 + '&nGrp=' + nGrp + '&nMode=' + nMode + "&nID=" + response.ID + "&CP_ID=" + response.CP_ID,
                iframe: true,
                height: document.documentElement.offsetHeight * 0.95,
                width: document.documentElement.offsetWidth * 0.95
            });
        }, { hasCallbackFunction: true });
    }

    $scope.payTicketOrNominal = function (strPar02, nGrp) {
        bars.ui.getMetaDataNdiTable("CP_KOD2", function (response) {
            $("#window").kendoWindow({
                content: bars.config.urlContent('/valuepapers/payticket/payticketornominal') + '?strPar02=' + strPar02 + '&nGrp=' + nGrp + "&nID=" + response.ID + "&CP_ID=" + response.CP_ID,
                visible: false,
                modal: true,
                iframe: true
            }).data("kendoWindow").center().open();
            $("#window").data("kendoWindow").maximize();
        }, { hasCallbackFunction: true });
    }


    $scope.datePickerOptions = {
        format: "dd.MM.yyyy",
        parseFormats: ["dd/MM/yyyy"]
    }

    $scope.openBarsDialogWithTableRow = function (url, fieldName) {
        if (!$scope.firstSelRow) {
            bars.ui.error({ text: "Необхідно виділити рядок в таблиці" });
            return;
        }
        url += $scope.firstSelRow[fieldName];
        $scope.openBarsDialog(url);
    }

    $scope.openBarsDialog = function (url, settings) {
        if (settings && settings.filterCodeParameter && settings.filterCode && $scope.firstSelRow && $scope.firstSelRow[settings.filterCodeParameter.Name])
            url += "&JsonSqlParams=[{\"Name\":\"" + settings.filterCodeParameter.Name + "\",\"Type\":\"" + settings.filterCodeParameter.Type + "\",\"Value\":\"" + $scope.firstSelRow[settings.filterCodeParameter.Name] + "\"}]&filterCode=" + settings.filterCode;
        var options = {
            content: url,
            iframe: true,
            modal: true,
            height: document.documentElement.offsetHeight * 0.8,
            width: document.documentElement.offsetWidth * 0.8,
            padding: 0,
            actions: ["Refresh", "Maximize", "Minimize", "Close"]
        };
        //if (settings != null) { change(settings, options); }
        bars.ui.dialog(options);
    }

    $scope.openSpecparamsWindow = function () {
        document.getElementById('specParamsWindowMode').value = $scope.p_nOp;
        $scope.specParamsWindow.open().center();
        $scope.$broadcast('loadChangeBillGrids');
    }

    $scope.openMoneyFlow = function () {
        if (!$scope.firstSelRow) {
            bars.ui.error({ text: "необхідно виділити рядок в таблиці" });
            return;
        }
        //$scope.$broadcast('initMoneyFlow', { REF: $scope.firstSelRow.REF });
        //$scope.moneyFlowWindow.center().open();
        $window.open('/barsroot/valuepapers/generalfolder/moneyflow?REF=' + $scope.firstSelRow.REF, '_blank');
        //$window.open($scope.moneyFlowWindow, '_blank');
        //$window.open($scope.moneyFlowWindow.open(),'_blank');
    }

    $scope.openPlanMoneyFlow = function () {
        if (!$scope.firstSelRow) {
            bars.ui.error({ text: "необхідно виділити рядок в таблиці" });
            return;
        }
        var data = {
            NMODE1: window.gridParams.nGrp,
            REF: $scope.firstSelRow.REF,
            ACCA: $scope.contractModel.ACCA || "",
            ID: $scope.firstSelRow.ID,
            STRPAR01: window.gridParams.strPar01,
            STRPAR02: window.gridParams.strPar02,
            DAT_UG: $scope.firstSelRow.DATD
        };

        paramsService.getIrrWindowParams(data).then(function (result) {

            $scope.$broadcast('initPlanMoneyFlow', { gridData: data, model: result });
            $scope.planMoneyFlowWindow.center().open();
        })
    }

    $scope.cpAmor = function () {
        var gridDate = $scope.grid.dataSource.data();
        var items = [];
        for (var i = 0; i < gridDate.length; i++) {
            items.push({
                REF: gridDate[i].REF,
                ID: gridDate[i].ID
            })
        }
        var data = {
            items: items,
            NGRP: $scope.gridParams.nGrp,
            ADAT: $scope.ADAT
        }
        paramsService.cpAmor(data).then(function (errors) {

            if (errors.errors == "")
                bars.ui.success({ text: "Операцію виконано успішно!" })
            else
                bars.ui.error({ text: errors.errors })
        })
    }

    $scope.makeAmort = function () {

        var data = {
            NGRP: $scope.gridParams.nGrp,
            FILTER: window.gridParams.strPar02,
            ADAT: $scope.ADAT
        }

        paramsService.makeAmort(data).then(function (response) {
            if (response.error == "null")
                bars.ui.success({ text: "Операцію виконано успішно!" })
            else
                bars.ui.error({ text: response.error })
        })
    }

    $scope.setStorageHiddenColumns = function () {
        columns = $("#grid").data("kendoGrid").columns;
        filter_str = "";
        for (var i = 0; i < columns.length; i++) {
            if (columns[i].hidden) {
                filter_str += columns[i].field + ",";
            }
        }
        LS.setData(filter_str.substring(0, filter_str.length - 1));
    }


    //$scope.getStorageHiddenColumns = function () {
    //    bars.ui.alert({ text: LS.getData() });
    //}
};

//homeController.$inject = ['$scope', 'paramsService'];