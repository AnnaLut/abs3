var mainApp = angular.module(globalSettings.modulesAreas);
mainApp.controller("F601DeltaCtrl", function ($controller, $scope, $rootScope, $location, $http, $q, $window,
    utilsService) {
    $controller('KendoMainController', { $scope: $scope });     // Расширяем контроллер

    $scope.Title = "Відображення дельти даних по формі 601";

    function getWebApiPath(strMethodName) {
        return bars.config.urlContent('/api/F601/F601DeltaApi/' + strMethodName);
    }

    String.prototype.hashCode = function () {
        var hash = 0, i, chr;
        if (this.length === 0) return hash;
        for (i = 0; i < this.length; i++) {
            chr = this.charCodeAt(i);
            hash = ((hash << 5) - hash) + chr;
            hash |= 0; // Convert to 32bit integer
        }
        return hash;
    };

    $scope.ReportsModelOptions = {
        id: "ID",
        fields: {
            ID: { type: "number" }
            , REPORTING_DATE: { type: "date" }
            , STAGE_NAME: { type: "string" }
        }
    }

    $scope.ReportsModel = kendo.data.Model.define($scope.ReportsModelOptions);
    $scope.ReportsSource = new kendo.data.DataSource({
        pageSize: 4,
        page: 1,
        total: 0,
        transport: {
            read: {
                url: getWebApiPath("GetNBUReports"),
                method: "GET",
                dataType: "json",
                async: true
            }
        },
        schema: {
            model: $scope.ReportsModel
            , parse: function (response) { return response; }
        }
    });

    $scope.ReportsGridOptions = {
        autoBind: true,
        selectable: 'row',
        groupable: false,
        sortable: true,
        resizable: true,
        navigatable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            pageSizes: [4, 8, 16, 24, 50, 100, 200],
            buttonCount: 4
        },
        dataSource: $scope.ReportsSource,
        dataBound: function (e) {
            var row = this.tbody.find('tr:first');
            this.select(row);
        },
        columns: [
            {
                field: 'REPORTING_DATE',
                title: 'Дата відправки звіту',
                type: "date",
                format: "{0:dd.MM.yyyy}",
                attributes: { "style": "text-align: center !important; padding-right:10px;" },
                headerAttributes: { "style": "text-align: center !important; padding-right:10px;; padding-left:10px" }
            },
            {
                field: 'STAGE_NAME',
                title: 'Статус звіту',
                attributes: { "style": "text-align: left !important; padding-left:10px;" },
                headerAttributes: { "style": "text-align: left !important; padding-right:10px;; padding-left:10px" },
                width: "60%"
            }
        ],
        editable: false,
        change: function (e) {
            $("#DeltaViewWindow").hide();
            $scope.ReportID = e.sender.dataItem(this.select()).ID;
            $scope.SessionsSource.read();
        }
    };
// -----------------------------------------------------
    $scope.SessionsModelOptions = {
        id: "ID",
        fields: {
            ID: { type: "number" }
            , REPORT_ID: { type: "number" }
            , OBJECT_ID: { type: "number" }
            , OBJECT_TYPE_ID: { type: "number" }
            , OBJECT_TYPE_NAME: { type: "string" }
            , OBJECT_KF: { type: "string" }
            , OBJECT_CODE: { type: "string" }
            , OBJECT_NAME: { type: "string" }
            , SESSION_CREATION_TIME: { type: "date" }
            , SESSION_ACTIVITY_TIME: { type: "date" }
            , SESSION_TYPE_ID: { type: "number" }
            , SESSION_TYPE_NAME: { type: "string" }
            , STATE_ID: { type: "number" }
            , SESSION_STATE: { type: "string" }
            , SESSION_DETAILS: { type: "string" }
        }
    }

    $scope.SessionsModel = kendo.data.Model.define($scope.SessionsModelOptions);
    $scope.SessionsSource = new kendo.data.DataSource({
        pageSize: 5, page: 1, total: 0,
        transport: {
            read: {
                url: function () {
                    return getWebApiPath("GetNBUSessionHistory?id=" + $scope.ReportID);
                },
                method: "GET",
                dataType: "json",
                async: true
            }
        },
        schema: {
            model: $scope.SessionsModel
            , parse: function (response) { return response; }
}
    });

    $scope.SessionsGridOptions = {
        autoBind: false,
        selectable: 'row',
        groupable: false,
        sortable: true,
        resizable: true,
        navigatable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            pageSizes: [5, 10, 20, 50, 100, 200, 1000],
            buttonCount: 5
        },
        dataSource: $scope.SessionsSource,
        dataBound: function (e) {
            //var row = this.tbody.find('tr:first');
            //this.select(row);
        },
        columns: [
            {
                field: 'OBJECT_TYPE_NAME',
                title: 'тип<br/>об`єкту<br/>даних',
                attributes: { "style": "text-align: right !important; padding-left:10px;" },
                headerAttributes: { "style": "text-align: center !important; padding-right:10px;; padding-left:10px" }
            },
            {
                field: 'OBJECT_KF',
                title: 'МФО'
            },
            {
                field: 'OBJECT_NAME',
                title: "Назва<br/>об'єкту"
            },
            {
                field: 'SESSION_CREATION_TIME',
                title: 'Дата<br/>створення<br/>сесії',
                type: "date",
                format: "{0:dd.MM.yyyy}",
                attributes: { "style": "text-align: right !important; padding-right:10px;" },
                headerAttributes: { "style": "text-align: center !important; padding-right:10px;; padding-left:10px" }
            },
            {
                field: 'SESSION_ACTIVITY_TIME',
                title: 'Дата<br/>активності <br/>сесії',
                type: "date",
                format: "{0:dd.MM.yyyy}",
                attributes: { "style": "text-align: right !important; padding-right:10px;" },
                headerAttributes: { "style": "text-align: center !important; padding-right:10px;; padding-left:10px" }
            },
            {
                field: 'SESSION_TYPE_NAME',
                title: 'Назва типу<br/>сесії'
            },
            {
                field: 'SESSION_STATE',
                title: 'Статус<br/>обробки'
            },
            {
                field: 'SESSION_DETAILS',
                title: 'Деталі сесії',
                width: "40%"
            }
        ],
        editable: false,
        change: function (e) {
            $("#DeltaViewWindow").show();
            $scope.sessionData = e.sender.dataItem(this.select());
            $scope.DataSource.read();
        }
    };
    $scope.$on("kendoWidgetCreated", function (event, grid) {
        $scope.grid = $("#SessionsGrid").data().kendoGrid;
        if (grid === $scope.grid) {
        }
    });

    function isNotEqual(o1, o2) {
        return (typeof (o1) == 'object') ? JSON.stringify(o1) !== JSON.stringify(o2) : o1 !== o2;
    }

    //=========================================================================
    $scope.DataModelOptions = {
        id: "id",
        fields: {
            id: { type: "number" }
            , report_id: { type: "number" }
            , object_id: { type: "number" }
            , json: { type: "string" }
        }
    }

    $scope.DataModel = kendo.data.Model.define($scope.DataModelOptions);
    $scope.DataSource = new kendo.data.DataSource({
        pageSize: 2,
        page: 1,
        total: 0,
        transport: {
            read: {
                url: getWebApiPath("GetNBUSessionData"),
                method: "GET",
                dataType: "json",
                data: function () {
                    bars.ui.loader($("#DeltaViewWindow"), true);
                    return { reportId: $scope.ReportID, sessionId: $scope.sessionData.OBJECT_ID }
                    //return { reportId: 21, sessionId: 391 }
                },
                async: true
            },
        },
        error: function (e) {
            bars.ui.loader($("#DeltaViewWindow"), false);
        },
        schema: {
            model: $scope.DataModel
            , parse: function (response) {
                if ($scope.JSON1) // видаляємо попередній перегляд
                    delete $scope.JSON1, $scope.JSON2;
                $scope.JSON1 = {};
                $scope.JSON2 = {};
                if (response.length > 0) {
                    if (response.length > 2) 
                        alert('Надано ' + response.length + ' записів для порівняння. Берем перші два.');
                    if (response.length < 2) {
                        alert('Надано ' + response.length + ' запис для порівняння. Нема з чим порівнювати.');
                        return;
                    }

                    $scope.JSON1txt = '';
                    $scope.JSON2txt = '';

                    if (response[0].json) {
                        $scope.JSON1txt = response[0].json;
                        $scope.JSON1 = JSON.parse(response[0].json);
                    }
                    if (response[1].json) {
                        $scope.JSON2txt = response[1].json;
                        $scope.JSON2 = JSON.parse(response[1].json);
                    }

                    buildDelta();

                    switch ($scope.sessionData.OBJECT_TYPE_ID) {
                    //switch (1) {
                        case 4:
                            showKredOper(); // схема Кредитні операції
                            break;
                        case 3:
                            showPledge(); // схема Забезпечення за Кредитною операцією (Застава)
                            break;
                        case 2:
                            showUO(); // схема Позичальник - юридична особа
                            break;
                        case 1:
                            showFO(); // схема Позичальник - фізична особа
                            break;
                    }
                }
                $("#DeltaViewCurrent").attr("title", $scope.JSON1txt); 
                $("#DeltaViewLast").attr("title", $scope.JSON2txt); 
                bars.ui.loader($("#DeltaViewWindow"), false);
                return response;
            }
        }
    });
// Кредити ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    $scope.KredModelOptions = {
        id: "orderNum",
        fields: {
            orderNum: { type: "number" }
            , flagOsoba: { type: "boolean" }
            , codCredit: { type: "number" }
            , codMan: { type: "number" }
            , typeCredit: { type: "number" }
            , numberDog: { type: "string" }
            , dogDay: { type: "string" }
            , endDay: { type: "string" }
            , sumZagal: { type: "number" }
            , r030: { type: "string" }
            , procCredit: { type: "number" }
            , sumPay: { type: "number" }
            , periodBase: { type: "number" }
            , periodProc: { type: "number" }
            , sumArrears: { type: "number" }
            , arrearBase: { type: "number" }
            , arrearProc: { type: "number" }
            , dayBase: { type: "number" }
            , dayProc: { type: "number" }
            , factEndDay: { type: "string" }
            , flagZ: { type: "boolean" }
            , klass: { type: "number" }
            , risk: { type: "number" }
            , flagInsurance: { type: "boolean" }
            , Pledge: { type: "string" } // typePledge - Застави по кредитам
            , Tranche: { type: "string" } // typeTranche - Транші по кредитам
        }
    }
// Застави по кредитам
    $scope.KredPledgeModelOptions = {
        id: "codZastava",
        fields: {
              codZastava: { type: "number" }
            , sumPledge: { type: "number" }
            , pricePledge: { type: "number" }
        }
    }
    $scope.KredPledgeColumns = [
        { field: 'codZastava', title: 'Забезпечення за кредитним договором' },
        { field: 'sumPledge', title: 'Сума забезпечення згідно з договором' },
        { field: 'pricePledge', title: 'Вартість забезпечення згідно з <br/>висновком суб’єкта оціночної діяльності' }
    ];
    $scope.KredPledgeModel = kendo.data.Model.define($scope.KredPledgeModelOptions);
    $scope.KredPledgeCSource = new kendo.data.DataSource({ schema: { model: $scope.KredPledgeModel } });
    $scope.KredPledgeLSource = new kendo.data.DataSource({ schema: { model: $scope.KredPledgeModel } });
    $scope.KredPledgeCOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.KredPledgeCSource, columns: $scope.KredPledgeColumns };
    $scope.KredPledgeLOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.KredPledgeLSource, columns: $scope.KredPledgeColumns };
// Транші по кредитам
    $scope.TrancheModelOptions = {
        id: "numDogTr",
        fields: {
              numDogTr: { type: "string" }
            , dogDayTr: { type: "string" }
            , endDayTr: { type: "string" }
            , sumZagalTr: { type: "number" }
            , r030Tr: { type: "string" }
            , procCreditTr: { type: "number" }
            , periodBaseTr: { type: "number" }
            , periodProcTr: { type: "number" }
            , sumArrearsTr: { type: "number" }
            , arrearBaseTr: { type: "number" }
            , arrearProcTr: { type: "number" }
            , dayBaseTr: { type: "number" }
            , dayProcTr: { type: "number" }
            , factEndDayTr: { type: "string" }
            , klassTr: { type: "number" }
            , riskTr: { type: "number" }
        }
    }
    $scope.KredTrancheColumns = [
        { field: 'numDogTr', title: '№<br/>договору' },
        { field: 'dogDayTr', title: 'Дата<br/>укладання<br/>договору' },
        { field: 'endDayTr', title: 'Дата<br/>погашення<br/>заборгованості' },
        { field: 'sumZagalTr', title: 'Сума<br/>наданого<br/>фінансового<br/>зобов’язання' },
        { field: 'r030Tr', title: 'Код<br/>валюти' },
        { field: 'procCreditTr', title: 'Процентна<br/>ставка' },
        { field: 'periodBaseTr', title: 'Періодичність<br/>сплати<br/>боргу' },
        { field: 'periodProcTr', title: 'Періодичність<br/>сплати<br/>процентів' },
        { field: 'sumArrearsTr', title: 'Залишок<br/>заборг.' },
        { field: 'arrearBaseTr', title: 'Прострочена<br/>заборгов.' },
        { field: 'arrearProcTr', title: 'Простр<br/>заборгов<br/>за<br/>процентами' },
        { field: 'dayBaseTr', title: 'Кільк.<br/>днів<br/>прострочення' },
        { field: 'dayProcTr', title: 'Кільк.<br/>днів<br/>простр<br/>за %' },
        { field: 'factEndDayTr', title: 'Дата<br/>факт.<br/>погашення' },
        { field: 'klassTr', title: 'Клас<br/>боржника' },
        { field: 'riskTr', title: 'Величина<br/>кредитного<br/>ризику' }
    ];
    $scope.KredTrancheModel = kendo.data.Model.define($scope.KredTrancheModelOptions);
    $scope.KredTrancheCSource = new kendo.data.DataSource({ schema: { model: $scope.KredTrancheModel } });
    $scope.KredTrancheLSource = new kendo.data.DataSource({ schema: { model: $scope.KredTrancheModel } });
    $scope.KredTrancheCOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.KredTrancheCSource, columns: $scope.KredTrancheColumns };
    $scope.KredTrancheLOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.KredTrancheLSource, columns: $scope.KredTrancheColumns };

    function isKredPlgGrid(jsonObj) {
        return jsonObj && jsonObj.data && jsonObj.data[0] && jsonObj.data[0].pledge && jsonObj.data[0].pledge.length > 0
    }
    function isKredTrnGrid(jsonObj) {
        return jsonObj && jsonObj.data && jsonObj.data[0] && jsonObj.data[0].tranche && jsonObj.data[0].tranche.length > 0
    }

    function showKredOper() {
        // кредити останні
        $("#DeltaViewCurrent").kendoListView({
            template: kendo.template($($scope.JSON1.data ? "#KredOperCurrent" : "#NoDataTemplate").html()),
            dataSource: { data: $scope.JSON1.data ? $scope.JSON1.data[0] : {}, schema: { model: kendo.data.Model.define($scope.KredModelOptions) } },
            dataBound: function () {
                if (isKredPlgGrid($scope.JSON1))
                    makeGridRef('KredPledge', 'C', 'Забезпечення за кредитним договором');
                if (isKredTrnGrid($scope.JSON1))
                    makeGridRef('KredTranche', 'C', 'Траншів за кредитним договором');
                // позначаєм поля, що відрізняються
                for (var x in $scope.delta) {
                    $("#" + x).addClass("Diff");
                }
            }
        });
        $("#DeltaGridsCurrent").kendoListView({
            template: kendo.template($( $scope.JSON1.data ? "#KredOperCurrentGrids":"#NoDataTemplate").html()),
            dataSource: { data: $scope.JSON1.data ? $scope.JSON1.data[0] : {}, schema: { model: kendo.data.Model.define($scope.KredModelOptions) } },
            dataBound: function () {
                // Залoги
                if (isKredPlgGrid($scope.JSON1)) {
                    $("#KredPledgeC").kendoGrid($scope.KredPledgeCOptions);
                    $scope.KredPledgeCSource.data($scope.JSON1.data[0].pledge);
                    //$("#KredPledgeC").before($("<a />", { name: 'KredPledgeGrid', text: 'Деталізація Забезпечення за кредитним договором' }));
                }
                // транші
                if (isKredTrnGrid($scope.JSON1)) {
                    $("#KredTrancheC").kendoGrid($scope.KredTrancheCOptions);
                    $scope.KredTrancheCSource.data($scope.JSON1.data[0].tranche);
                    //$("#KredTrancheC").before($("<a />", { name: 'KredTrancheGrid', text: 'Деталізація Забезпечення за кредитним договором' }));
                }
            }
        });
        // кредити попередні
        $("#DeltaViewLast").kendoListView({
            template: kendo.template($($scope.JSON2.data ? "#KredOperLast" : "#NoDataTemplate").html()),
            dataSource: { data: $scope.JSON2.data ? $scope.JSON2.data[0] : {}, schema: { model: kendo.data.Model.define($scope.KredModelOptions) } },
            dataBound: function () {
                if (isKredPlgGrid($scope.JSON2))
                    makeGridRef('KredPledge', 'L', 'Забезпечення за кредитним договором');
                if (isKredTrnGrid($scope.JSON2))
                    makeGridRef('KredTranche', 'L', 'Траншів за кредитним договором');
            }
        });
        $("#DeltaGridsLast").kendoListView({
            template: kendo.template($($scope.JSON2.data ? "#KredOperLastGrids" : "#NoDataTemplate").html()),
            dataSource: { data: $scope.JSON2.data ? $scope.JSON2.data[0] : {}, schema: { model: kendo.data.Model.define($scope.KredModelOptions) } },
            dataBound: function () {
                // Залиги
                if (isKredPlgGrid($scope.JSON2)) {
                    $("#KredPledgeL").kendoGrid($scope.KredPledgeLOptions);
                    $scope.KredPledgeLSource.data($scope.JSON2.data[0].pledge);
                }
                // транші
                if (isKredTrnGrid($scope.JSON2)) {
                    $("#KredTrancheL").kendoGrid($scope.KredTrancheLOptions);
                    $scope.KredTrancheLSource.data($scope.JSON2.data[0].tranche);
                }
            }
        });

    }

    // Застави як такі ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    $scope.PledgeModelOptions = {
        id: "orderNum",
        fields: {
            orderNum: { type: "number" } //+
            , codZastava: { type: "number" } //+
            , codMan: { type: "number" }    //+
            , numberPledge: { type: "string" } //+
            , pledgeDay: { type: "string" } //+
            , s031: { type: "string" } //+
            , orderZastava: { type: "number" }//+
            , r030: { type: "string" }
            , sumPledge: { type: "number" }//+
            , pricePledge: { type: "number" }
            , lastPledgeDay: { type: "string" }
            , codRealty: { type: "number" }
            , zipRealty: { type: "string" }
            , squareRealty: { type: "number" }
            , sumBail: { type: "number" }
            , sumGuarantee: { type: "number" }
            , real6month: { type: "number" }
            , noreal6month: { type: "number" }
            , flagInsurancePledge: { type: "boolean" }
            , deposit: { type: "string" } // або "D" або структура PledgeDepositModelOptions
        }
    }
    $scope.PledgeDepositModelOptions = {
        id: "numDogDp",
        fields: {
            numDogDp: { type: "string" }
            , dogDayDp: { type: "string" }
            , r030Dp: { type: "string" }
            , sumDp: { type: "number" }
        }
    }
    $scope.PersonDocColumns = [
        { field: 'numDogDp', title: '№<br/>депозитного<br/>договору' },
        { field: 'dogDayDp', title: 'Дата укладання<br/>депозитного договору' },
        { field: 'r030Dp', title: 'Код валюти<br/>за депозитом' },
        { field: 'sumDp', title: 'Сума<br/>депозиту' }
    ];
    $scope.PledgeDepModel = kendo.data.Model.define($scope.PledgeDepositModelOptions);
    $scope.PledgeDepCSource = new kendo.data.DataSource({ schema: { model: $scope.PledgeDepModel } });
    $scope.PledgeDepLSource = new kendo.data.DataSource({ schema: { model: $scope.PledgeDepModel } });
    $scope.PledgeDepCOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.PledgeDepCSource, columns: $scope.PledgeDepColumns };
    $scope.PledgeDepLOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.PledgeDepLSource, columns: $scope.PledgeDepColumns };
    function isPledgeGrid(jsonObj) { return jsonObj && jsonObj.data && jsonObj.data[0].deposit && jsonObj.data[0].deposit.length > 0 }

    function showPledge() {
        JSON2viewData();
        $("#DeltaViewCurrent").kendoListView({
            template: getKendoTemplate($scope.JSON1, 'PledgeCurrent'),
            dataSource: { data: $scope.viewData1[0], schema: { model: kendo.data.Model.define($scope.PledgeModelOptions) } },
            dataBound: function () {
                if (isPledgeGrid($scope.JSON1))
                    makeGridRef('Deposit', 'C', 'депозитів, що є предметом забезпечення');

                markDelta();
            }
        });
        $("#DeltaGridsCurrent").kendoListView({
            template: getKendoTemplate($scope.JSON1, 'PledgeCurrentGrids'),
            dataSource: { data: $scope.viewData1[0], schema: { model: kendo.data.Model.define($scope.PledgeModelOptions) } },
            dataBound: function () {
                if (isPledgeGrid($scope.JSON1)) {
                    $("#DepositC").kendoGrid($scope.PledgeDepCOptions);
                    $scope.PledgeDepCSource.data($scope.JSON1.data[0].deposit);
                }
            }
        });
        // застави попередні
        $("#DeltaViewLast").kendoListView({
            template: getKendoTemplate($scope.JSON2, 'PledgeLast'),
            dataSource: { data: $scope.viewData2[0], schema: { model: kendo.data.Model.define($scope.PledgeModelOptions) } },
            dataBound: function () {
                if (isPledgeGrid($scope.JSON2))
                    makeGridRef('Deposit', 'L', 'депозитів, що є предметом забезпечення');
            }
        });
        $("#DeltaGridsLast").kendoListView({
            template: getKendoTemplate($scope.JSON2[0], 'PersonLastGrids'),
            dataSource: { data: $scope.viewData2, schema: { model: kendo.data.Model.define($scope.PersonModelOptions) } },
            dataBound: function () {
                if (isPledgeGrid($scope.JSON2)) {
                    $("#DepositL").kendoGrid($scope.PledgeDepLOptions);
                    $scope.PledgeDepLSource.data($scope.JSON2.data[0].deposit);
                }
            }
        });

    }
    // Фіз.особи ````````````````````````````````````````````````````````````````````````````````
    $scope.PersonModelOptions = {
        id: "codMan",
        fields: {
            codMan: { type: "number" }
            , fio: { type: "string" }
            , isRez: { type: "boolean" }
            , endDay: { type: "string" }
            , inn: { type: "string" }
            , codDocum: { type: "number" }
            , codK020: { type: "string" }
            , birthDay: { type: "string" }
            , document: { type: "string" } // PersonDocModelOptions
            , address: { type: "string" }
            , countryCodNerez: { type: "string" }
            , education: { type: "string" } // typeEdu - масив чисел
            , organization: { type: "string" } // PersonOrgModelOptions
            , profit: { type: "string" }
            , family: { type: "string" }
            , k060: { type: "string" }
            , isKr: { type: "number" }
        }
    }
    $scope.PersonDocModelOptions = {
        id: "typeD",
        fields: {
            typeD: { type: "number" }
            , seriya: { type: "string" }
            , nomerD: { type: "string" }
            , dtD: { type: "string" }
        }
    }
    $scope.PersonDocColumns = [
        { field: 'typeD', title: 'Тип<br/>документа' },
        { field: 'seriya', title: 'Серія<br/>документа' },
        { field: 'nomerD', title: 'Номер<br/>документа' },
        { field: 'dtD', title: 'Дата видачі<br/>документа' }
    ];
    $scope.PersonDocModel = kendo.data.Model.define($scope.PersonDocModelOptions);
    $scope.PersonDocCSource = new kendo.data.DataSource({ schema: { model: $scope.PersonDocModel } });
    $scope.PersonDocLSource = new kendo.data.DataSource({ schema: { model: $scope.PersonDocModel } });
    $scope.PersonDocCOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.PersonDocCSource, columns: $scope.PersonDocColumns };
    $scope.PersonDocLOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.PersonDocLSource, columns: $scope.PersonDocColumns };

    $scope.PersonOrgModelOptions = {
        id: "typeW",
        fields: {
            typeW: { type: "number" }
            , codEdrpou: { type: "string" }
            , nameW: { type: "string" }
        }
    }
    $scope.PersonOrgColumns = [
        { field: 'typeW', title: 'Тип<br/>роботодавця' },
        { field: 'codEdrpou', title: 'Ідентифікатор<br/>роботодавця' },
        { field: 'nameW', title: 'Найменування <br/>роботодавця' }
    ];
    $scope.PersonOrgModel = kendo.data.Model.define($scope.PersonOrgModelOptions);
    $scope.PersonOrgCSource = new kendo.data.DataSource({ schema: { model: $scope.PersonOrgModel } });
    $scope.PersonOrgLSource = new kendo.data.DataSource({ schema: { model: $scope.PersonOrgModel } });
    $scope.PersonOrgCOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.PersonOrgCSource, columns: $scope.PersonOrgColumns };
    $scope.PersonOrgLOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.PersonOrgLSource, columns: $scope.PersonOrgColumns };

    function showFO() {
        PersonJsonDataUp($scope.JSON1);
        PersonJsonDataUp($scope.JSON2);
        // Перебудувати дельту, оскільки змінили об'єкти
        buildDelta2();
        // копіюємо JSON, оскільки kendoListView псує поле document
        JSON2viewData();
        // люди останні
        $("#DeltaViewCurrent").kendoListView({
            template: getKendoTemplate($scope.JSON1,'PersonCurrent'),
            dataSource: { data: $scope.viewData1, schema: { model: kendo.data.Model.define($scope.PersonModelOptions) } },
            dataBound: function () {
                if (isPersonDocGrid($scope.JSON1))
                    makeGridRef('document','C','документів що посвідчує особу Боржника');
                if (isPersonOrgGrid($scope.JSON1))
                    makeGridRef('organization', 'C', 'місць роботи Боржника');

                markDelta();
            }
        });
        $("#DeltaGridsCurrent").kendoListView({
            template: getKendoTemplate($scope.JSON1, 'PersonCurrentGrids'),
            dataSource: { data: $scope.viewData1, schema: { model: kendo.data.Model.define($scope.PersonModelOptions) } },
            dataBound: function () {
                // Документи
                if (isPersonDocGrid($scope.JSON1)) {
                    $("#documentC").kendoGrid($scope.PersonDocCOptions);
                    $scope.PersonDocCSource.data($scope.JSON1.data.document);
                }
                // Місця роботи
                if (isPersonOrgGrid($scope.JSON1)) {
                    $("#organizationC").kendoGrid($scope.PersonOrgCOptions);
                    $scope.PersonOrgCSource.data($scope.JSON1.data.organization);
                }
            }
        });
        // люди попередні
        $("#DeltaViewLast").kendoListView({
            template: getKendoTemplate($scope.JSON2, 'PersonLast'),
            dataSource: { data: $scope.viewData2, schema: { model: kendo.data.Model.define($scope.PersonModelOptions) } },
            dataBound: function () {
                if (isPersonDocGrid($scope.JSON2))
                    makeGridRef('document', 'L', 'документів що посвідчує особу Боржника');
                if (isPersonOrgGrid($scope.JSON2))
                    makeGridRef('organization', 'L', 'місць роботи Боржника');
            }
        });
        $("#DeltaGridsLast").kendoListView({
            template: getKendoTemplate($scope.JSON2, 'PersonLastGrids'),
            dataSource: { data: $scope.viewData2, schema: { model: kendo.data.Model.define($scope.PersonModelOptions) } },
            dataBound: function () {
                // Документи
                if (isPersonDocGrid($scope.JSON2)) {
                    $("#documentL").kendoGrid($scope.PersonDocLOptions);
                    $scope.PersonDocLSource.data($scope.JSON2.data.document);
                }
                // Місця роботи
                if (isPersonOrgGrid($scope.JSON2)) {
                    $("#organizationL").kendoGrid($scope.PersonOrgLOptions);
                    $scope.PersonOrgLSource.data($scope.JSON2.data.organization);
                }
            }
        });
    }
    function isPersonDocGrid(jsonObj) {
        return jsonObj && jsonObj.data && jsonObj.data.document && jsonObj.data.document.length > 0
    }
    function isPersonOrgGrid(jsonObj) {
        return jsonObj && jsonObj.data && jsonObj.data.organization && jsonObj.data.organization.length > 0 
    }
    // Копіювання вложених даних рівнем вище
    function PersonJsonDataUp(jsonObj) {
        if (jsonObj && jsonObj.data) {
            jsonObj.data.lastName = jsonObj.data.fio.lastName;
            jsonObj.data.firstName = jsonObj.data.fio.firstName;
            jsonObj.data.middleName = jsonObj.data.fio.middleName;
            if (jsonObj.data.address) { // перевірки необов'язкових полів
                jsonObj.data.codRegion = jsonObj.data.address.codRegion;
                jsonObj.data.area = jsonObj.data.address.area;
                jsonObj.data.zip = jsonObj.data.address.zip;
                jsonObj.data.city = jsonObj.data.address.city;
                jsonObj.data.streetAddress = jsonObj.data.address.streetAddress;
                jsonObj.data.houseNo = jsonObj.data.address.houseNo;
                jsonObj.data.adrKorp = jsonObj.data.address.adrKorp;
                jsonObj.data.flatNo = jsonObj.data.address.flatNo;
            }
            else
                jsonObj.data.codRegion = jsonObj.data.area = jsonObj.data.zip = jsonObj.data.city = jsonObj.data.streetAddress = jsonObj.data.houseNo = jsonObj.data.adrKorp = jsonObj.data.flatNo = "";
            if (jsonObj.data.profit) {
                jsonObj.data.real6month = jsonObj.data.profit.real6month;
                jsonObj.data.noreal6month = jsonObj.data.profit.noreal6month;
            }
            else
                jsonObj.data.real6month = jsonObj.data.noreal6month = 0;
            if (jsonObj.data.family) {
                jsonObj.data.status = jsonObj.data.family.status;
                jsonObj.data.members = jsonObj.data.family.members;
            }
            else
                jsonObj.data.status = jsonObj.data.members = 0;
        }

    }

    // Юр.особи ````````````````````````````````````````````````````````````````````````````````
    $scope.LegalModelOptions = {
        id: "codMan",
        fields: {
            codMan: { type: "number" }
            , isRez: { type: "boolean" }
            , codEdrpou: { type: "string" }
            , codDocum: { type: "number" }
            , codK020: { type: "string" }
            , nameUr: { type: "string" }
            , registryDay: { type: "string" }
            , numberRegistry: { type: "string" }
            , ecActivity: { type: "string" }
            , countryCodNerez: { type: "string" }
            , finPerformance: { type: "string" }
            , isMember: { type: "boolean" }
            , isController: { type: "boolean" }
            , groupUr: { type: "string" } // LegalGroupModelOptions
            , finPerformanceGr: { type: "number" }
            , isPartner: { type: "boolean" }
            , partners: { type: "string" } // LegalPartnModelOptions
            , finPerformancePr: { type: "string" }  
            , isAudit: { type: "boolean" }
            , k060: { type: "string" }
            , ownerPp: { type: "string" } // LegalOwnerPModelOptions
            , ownerJur: { type: "string" } // LegalOwnerLModelOptions
            , isKr: { type: "number" }
        }
    }
    $scope.LegalGroupModelOptions = {
        id: "codedrpougr",
        fields: {
            whois: { type: "number" }
            , isrezgr: { type: "string" } // boolean
            , codedrpougr: { type: "string" }
            , nameurgr: { type: "string" }
            , countrycodgr: { type: "string" }
        }           
    }
    $scope.LegalGroupColumns = [
        { field: 'whois', title: 'Статус участі<br/>юридичної особи<br/>в групі' },
        { field: 'isrezgr', title: 'Резидентність<br/>особи' },
        { field: 'codedrpougr', title: 'Ідентифікатор<br/>особи' },
        { field: 'nameurgr', title: 'Найменування<br/>особи' },
        { field: 'countrycodgr', title: 'Код країни<br/>місця реєстрації' }
    ];
    function isLegalGrGrid(jsonObj) {
        return jsonObj && jsonObj.data && jsonObj.data.groupUr && jsonObj.data.groupUr.length > 0
    }
    $scope.LegalGrModel = kendo.data.Model.define($scope.LegalGroupModelOptions);
    $scope.LegalGrCSource = new kendo.data.DataSource({ schema: { model: $scope.LegalGrModel } });
    $scope.LegalGrLSource = new kendo.data.DataSource({ schema: { model: $scope.LegalGrModel } });
    $scope.LegalGrCOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.LegalGrCSource, columns: $scope.LegalGroupColumns };
    $scope.LegalGrLOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.LegalGrLSource, columns: $scope.LegalGroupColumns };

    $scope.LegalPartnModelOptions = {
        id: "codEdrpouPr",
        fields: {
            isRezPr: { type: "boolean" }
            , codEdrpouPr: { type: "string" }
            , nameUrPr: { type: "string" }
            , countryCodPr: { type: "string" }
        }
    }
    $scope.LegalPartnerColumns = [
        { field: 'isRezPr', title: 'Резидентність<br/>контрагента' },
        { field: 'codEdrpouPr', title: 'Ідентифікатор<br/>контрагента' },
        { field: 'nameUrPr', title: 'Найменування<br/>особи' },
        { field: 'countryCodPr', title: 'Код країни<br/>місця реєстрації' }
    ];
    function isLegalPrGrid(jsonObj) {
        return jsonObj && jsonObj.data && jsonObj.data.partners && jsonObj.data.partners.length > 0
    }
    $scope.LegalPrModel = kendo.data.Model.define($scope.LegalPartnModelOptions);
    $scope.LegalPrCSource = new kendo.data.DataSource({ schema: { model: $scope.LegalPrModel } });
    $scope.LegalPrLSource = new kendo.data.DataSource({ schema: { model: $scope.LegalPrModel } });
    $scope.LegalPrCOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.LegalPrCSource, columns: $scope.LegalPartnerColumns };
    $scope.LegalPrLOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.LegalPrLSource, columns: $scope.LegalPartnerColumns };

    $scope.LegalOwnerPModelOptions = {
        id: "inn",
        fields: {
            fio: { type: "string" }
            , isRez: { type: "boolean" }
            , inn: { type: "string" }
            , countryCod: { type: "string" }
            , perCent: { type: "number" }
            , address: { type: "string" }
        }
    }
    $scope.LegalOwnerPColumns = [
        {
            field: 'fio', title: 'Прізвище, ім’я, по батькові<br/>фізичної особи'
            , template: "#=getFioHTML(fio)#"
        },
        { field: 'isRez', title: 'Резидентність<br/>особи' },
        { field: 'inn', title: 'Ідентифікатор<br/>власника істотної участі' },
        { field: 'countryCod', title: 'Код країни<br/>місця реєстрації' },
        { field: 'perCent', title: 'Частка власника<br/>істотної участі' },
        {
            field: 'address', title: 'Місце реєстрації власника<br/>істотної участі – фізичної особи'
            , template: "#=address ? getAddressHTML(address):''#"
            , width: '50%'
        }
    ];
    function isLegalOwnPGrid(jsonObj) {
        return jsonObj && jsonObj.data && jsonObj.data.ownerPp && jsonObj.data.ownerPp.length > 0
    }
    getFioHTML = function (objFio) {
        return String.format("<span style='display:block;'>{0},{1},{2}</span>", iif(objFio.lastName), iif(objFio.firstName), iif(objFio.middleName));
    }
    getAddressHTML = function (objAddr) {
        return String.format("<span style='display:block;'>інд:{0}, рег:{1}, р-н:{2}, н.п.:{3}, вул.{4}, буд.{5}, корп.{6}, кв.{7}</span>"
            , iif(objAddr.zip), iif(objAddr.codRegion), iif(objAddr.area), iif(objAddr.city), iif(objAddr.streetAddress), iif(objAddr.houseNo), iif(objAddr.adrKorp), iif(objAddr.flatNo));
    }
    $scope.LegalOPModel = kendo.data.Model.define($scope.LegalOwnerPModelOptions);
    $scope.LegalOPCSource = new kendo.data.DataSource({ schema: { model: $scope.LegalOPModel } });
    $scope.LegalOPLSource = new kendo.data.DataSource({ schema: { model: $scope.LegalOPModel } });
    $scope.LegalOPCOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.LegalOPCSource, columns: $scope.LegalOwnerPColumns };
    $scope.LegalOPLOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.LegalOPLSource, columns: $scope.LegalOwnerPColumns };

    $scope.LegalOwnerJModelOptions = {
        id: "codEdrpouOj",
        fields: {
            nameOj: { type: "string" }
            , isRezOj: { type: "boolean" }
            , codEdrpouOj: { type: "string" }
            , registryDayOj: { type: "string" }
            , numberRegistryOj: { type: "string" }
            , countryCodOj: { type: "string" }
            , perCentOj: { type: "number" }
        }
    }
    $scope.LegalOwnerJColumns = [
        { field: 'nameOj', title: 'Найменування<br/>особи' },
        { field: 'isRezOj', title: 'Резидентність<br/>особи' },
        { field: 'codEdrpouPr', title: 'Ідентифікатор<br/>власника істотної участі' },
        { field: 'registryDayOj', title: 'Дата державної<br/>реєстрації' },
        { field: 'numberRegistryOj', title: 'Номер державної<br/>реєстрації' },
        { field: 'countryCodOj', title: 'Код країни<br/>місця реєстрації' },
        { field: 'perCentOj', title: 'Частка власника<br/>істотної участі' }
    ];
    function isLegalOwnJGrid(jsonObj) {
        return jsonObj && jsonObj.data && jsonObj.data.ownerJur && jsonObj.data.ownerJur.length > 0
    }
    $scope.LegalOJModel = kendo.data.Model.define($scope.LegalOwnerJModelOptions);
    $scope.LegalOJCSource = new kendo.data.DataSource({ schema: { model: $scope.LegalOJModel } });
    $scope.LegalOJLSource = new kendo.data.DataSource({ schema: { model: $scope.LegalOJModel } });
    $scope.LegalOJCOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.LegalOJCSource, columns: $scope.LegalOwnerJColumns };
    $scope.LegalOJLOptions = { autoBind: true, resizable: true, selectable: 'row', dataSource: $scope.LegalOJLSource, columns: $scope.LegalOwnerJColumns };

    function showUO() {
        LegalJsonDataUp($scope.JSON1);
        LegalJsonDataUp($scope.JSON2);
        // Перебудувати дельту, оскільки змінили об'єкти
        buildDelta2();
        JSON2viewData();
        $("#DeltaViewCurrent").kendoListView({
            template: getKendoTemplate($scope.JSON1, 'LegalCurrent'),
            dataSource: { data: $scope.viewData1, schema: { model: kendo.data.Model.define($scope.LegalModelOptions) } },
            dataBound: function () {
                if (isLegalGrGrid($scope.JSON1))
                    makeGridRef('LegalGr', 'C', 'юридичних осіб, що входять до групи юридичних осіб, що знаходяться під спільним контролем');
                if (isLegalPrGrid($scope.JSON1))
                    makeGridRef('LegalPr', 'C', 'юридичних осіб, які належать до групи пов’язаних контрагентів');
                if (isLegalOwnPGrid($scope.JSON1))
                    makeGridRef('LegalOP', 'C', 'власників істотної участі – фізичних осіб');
                if (isLegalOwnJGrid($scope.JSON1))
                    makeGridRef('LegalOJ', 'C', 'власників істотної участі – юридичних осіб');

                markDelta();
            }
        });
        $("#DeltaGridsCurrent").kendoListView({
            template: getKendoTemplate($scope.JSON1, 'LegalCurrentGrids'),
            dataSource: { data: $scope.viewData1, schema: { model: kendo.data.Model.define($scope.LegalModelOptions) } },
            dataBound: function () {
                // групи юридичних осіб
                if (isLegalGrGrid($scope.JSON1)) {
                    $("#LegalGrC").kendoGrid($scope.LegalGrCOptions);
                    $scope.LegalGrCSource.data($scope.JSON1.data.groupUr);
                }
                // пов’язанi контрагенти
                if (isLegalPrGrid($scope.JSON1)) {
                    $("#LegalPrC").kendoGrid($scope.LegalPrCOptions);
                    $scope.LegalPrCSource.data($scope.JSON1.data.partners);
                }
                // Власники істотної участі – фізичні особи
                if (isLegalOwnPGrid($scope.JSON1)) {
                    $("#LegalOPC").kendoGrid($scope.LegalOPCOptions);
                    $scope.LegalOPCSource.data($scope.JSON1.data.ownerPp);
                }
                // Власники істотної участі – юридичні особи
                if (isLegalOwnJGrid($scope.JSON1)) {
                    $("#LegalOJC").kendoGrid($scope.LegalOJCOptions);
                    $scope.LegalOJCSource.data($scope.JSON1.data.ownerJur);
                }
            }
        });
        $("#DeltaViewLast").kendoListView({
            template: getKendoTemplate($scope.JSON2, 'LegalLast'),
            dataSource: { data: $scope.viewData2, schema: { model: kendo.data.Model.define($scope.PledgeModelOptions) } },
            dataBound: function () {
                if (isLegalGrGrid($scope.JSON2))
                    makeGridRef('LegalGr', 'L', 'юридичних осіб, що входять до групи юридичних осіб, що знаходяться під спільним контролем');
                if (isLegalPrGrid($scope.JSON2))
                    makeGridRef('LegalPr', 'L', 'юридичних осіб, які належать до групи пов’язаних контрагентів');
                if (isLegalOwnPGrid($scope.JSON2))
                    makeGridRef('LegalOP', 'L', 'власників істотної участі – фізичних осіб');
                if (isLegalOwnJGrid($scope.JSON2))
                    makeGridRef('LegalOJ', 'L', 'власників істотної участі – юридичних осіб');
            }
        });
        $("#DeltaGridsLast").kendoListView({
            template: getKendoTemplate($scope.JSON2, 'LegalLastGrids'),
            dataSource: { data: $scope.viewData2, schema: { model: kendo.data.Model.define($scope.LegalModelOptions) } },
            dataBound: function () {
                // групи юридичних осіб
                if (isLegalGrGrid($scope.JSON2)) {
                    $("#LegalGrL").kendoGrid($scope.LegalGrLOptions);
                    $scope.LegalGrLSource.data($scope.JSON2.data.groupUr);
                }
                // пов’язанi контрагенти
                if (isLegalPrGrid($scope.JSON2)) {
                    $("#LegalPrL").kendoGrid($scope.LegalPrLOptions);
                    $scope.LegalPrLSource.data($scope.JSON2.data.partners);
                }
                // Власники істотної участі – фізичні особи
                if (isLegalOwnPGrid($scope.JSON2)) {
                    $("#LegalOPL").kendoGrid($scope.LegalOPLOptions);
                    $scope.LegalOPLSource.data($scope.JSON2.data.ownerPp);
                }
                // Власники істотної участі – юридичні особи
                if (isLegalOwnJGrid($scope.JSON2)) {
                    $("#LegalOJL").kendoGrid($scope.LegalOJLOptions);
                    $scope.LegalOJLSource.data($scope.JSON2.data.ownerJur);
                }
            }
        });
    }
    // Копіювання вложених даних рівнем вище для юрика
    function LegalJsonDataUp(jsonObj) {
        if (jsonObj && jsonObj.data) {
            jsonObj.data.k110 = jsonObj.data.ecActivity.k110;
            jsonObj.data.ec_year = jsonObj.data.ecActivity.ec_year;
            if (jsonObj.data.finPerformance) { // перевірки необов'язкових полів
                jsonObj.data.sales = jsonObj.data.finPerformance.sales;
                jsonObj.data.ebit = jsonObj.data.finPerformance.ebit;
                jsonObj.data.ebitda = jsonObj.data.finPerformance.ebitda;
                jsonObj.data.totalDebt = jsonObj.data.finPerformance.totalDebt;
            }
            else
                jsonObj.data.sales = jsonObj.data.ebit = jsonObj.data.ebitda = jsonObj.data.totalDebt = 0;
            if (jsonObj.data.finPerformanceGr) { 
                jsonObj.data.salesGr = jsonObj.data.finPerformanceGr.salesGr;
                jsonObj.data.ebitGr = jsonObj.data.finPerformanceGr.ebitGr;
                jsonObj.data.ebitdaGr = jsonObj.data.finPerformanceGr.ebitdaGr;
                jsonObj.data.totalDebtGr = jsonObj.data.finPerformanceGr.totalDebtGr;
                jsonObj.data.classGr = jsonObj.data.finPerformanceGr.classGr;
            }
            else {
                jsonObj.data.salesGr = jsonObj.data.ebitGr = jsonObj.data.ebitdaGr = jsonObj.data.totalDebtGr = 0;
                jsonObj.data.classGr = "";
            }
            if (jsonObj.data.finPerformancePr) {
                jsonObj.data.salesPr = jsonObj.data.finPerformance.sales;
                jsonObj.data.ebitPr = jsonObj.data.finPerformance.ebit;
                jsonObj.data.ebitdaPr = jsonObj.data.finPerformance.ebitda;
                jsonObj.data.totalDebtPr = jsonObj.data.finPerformance.totalDebt;
            }
            else
                jsonObj.data.salesPr = jsonObj.data.ebitPr = jsonObj.data.ebitdaPr = jsonObj.data.totalDebtPr = 0;

            if (jsonObj.data.k060) {
                var strTmp = jsonObj.data.k060.toString();
                delete jsonObj.data.k060;
                jsonObj.data.k060 = strTmp;
            }
            else
                jsonObj.data.k060 = "";

        }
    }

    // ------------------ різне ---------------------------- 
    $scope.splitter1 = {
        orientation: "horizontal",
        panes: [
            { collapsible: true, size: '50%', collapsedSize: "10%"},
            { collapsible: true, size: '50%', collapsedSize: "10%"}
        ]
    };
    $scope.splitter2 = {
        orientation: "vertical",
        panes: [
            { collapsible: true, size: '50%', collapsedSize: "10%"},
            { collapsible: true, size: '50%', collapsedSize: "10%"}
        ]
    };
    formatFldV = function (val) {
        return val ? val : '';
    }
    iif = function (val) {
        return val ? val : '-';
    }
    formatDate = function (strDate) {
        if (strDate)
            return kendo.toString(kendo.parseDate(strDate), 'dd MMM yyyy');
        return '';
    }
    // шаблон для виводу в гріді значення коду з його назвою в тайтлі
    getValueWithTitle = function (code_id, code_name) {//
        if (code_id)
            return "<span style='display:block;' title='" + (code_name ? code_name.replace(/'"/g, "") : '') + "'>" + code_id + "</span>";
        return ''
    }
    // шаблон для виводу в гріді урізаного поля з його повною довжиною в тайтлі
    getValueSubStr = function (strField, iLen) {//
        if (strField)
            return "<span style='display:block;' title='" + strField.replace(/'"/g, "") + "'>" + strField.slice(0, iLen) + (strField.length > 11 ? '...' : '') + "</span>";
        return ''
    }
    // Отримати шаблолн для відображення даних
    function getKendoTemplate(dataObj, tempateID) {
        return kendo.template($("#" + ((dataObj && dataObj.data) ? tempateID : "NoDataTemplate")).html())
    }
    // Створити посилання на грід
    function makeGridRef(elementID,srtSuffix,strTitle) {
        //$("#" + elementID + srtSuffix + "Ref").html($("<a />", { class: "refer", title: 'Перелік ' + strTitle + ' - дивись наступний блок', text: '...' }));
        $("#" + elementID + srtSuffix + "Ref").html("<a "+' class="refer" title="Перелік ' + strTitle + ' - дивись наступний блок">...</a>');

    }

    // Копіювання JSON, оскільки kendoListView псує поле document і не може одночасно використовувати дані разом із грідом
    function JSON2viewData() {
        if ($scope.viewData1) delete $scope.viewData1;
        if ($scope.viewData2) delete $scope.viewData2;
        $scope.viewData1 = {};
        $scope.viewData2 = {};
        if ($scope.JSON1 && $scope.JSON1.data)
            utilsService.copy($scope.JSON1.data, $scope.viewData1);
        if ($scope.JSON2 && $scope.JSON2.data)
            utilsService.copy($scope.JSON2.data, $scope.viewData2);
    }
    // Подбудова "дельти даних" - переліку полів, що різняться в двох JSON-ах (використовується при "розфарбовуванні в'юх")
    function buildDelta() {
        if ($scope.delta) delete $scope.delta;
        $scope.delta = {};
        if ($scope.JSON1.data && $scope.JSON2.data) {
            for (var x in $scope.JSON1.data[0]) {
                if (!$scope.JSON2 || !$scope.JSON2.data[0] || isNotEqual($scope.JSON2.data[0][x], $scope.JSON1.data[0][x]))
                    $scope.delta[x] = 1;
            }
            for (var x in $scope.JSON2.data[0]) {
                if (!$scope.JSON1 || !$scope.JSON1.data[0] || isNotEqual($scope.JSON2.data[0][x], $scope.JSON1.data[0][x]))
                    $scope.delta[x] = 1;
            }
        }
    }
    function buildDelta2() {
        if ($scope.delta) delete $scope.delta;
        $scope.delta = {};
        if ($scope.JSON1.data && $scope.JSON2.data) {
            for (var x in $scope.JSON1.data) {
                if (!$scope.JSON2 || !$scope.JSON2.data || isNotEqual($scope.JSON2.data[x], $scope.JSON1.data[x]))
                    $scope.delta[x] = 1;
            }
            for (var x in $scope.JSON2.data[0]) {
                if (!$scope.JSON1 || !$scope.JSON1.data || isNotEqual($scope.JSON2.data[x], $scope.JSON1.data[x]))
                    $scope.delta[x] = 1;
            }
        }
    }
    // Позначити поля, що відрізняються
    function markDelta() {
        for (var x in $scope.delta) {
            $("#" + x).addClass("Diff");
        }
    }
    $(document).ready(function () {
        $(document).on("click", "a.refer", function () {
            var strParentID = $(this).parent().attr('id');
            var strId = strParentID.substr(0, strParentID.length - 3);
            $('html, body').animate({
                scrollTop: ($('#' + strId).offset().top)
            }, 500);

            //$('#' + strId).focus();
        });
    });
});