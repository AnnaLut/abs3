app.controller("planMoneyFlowController", ['$scope', 'paramsService', planMoneyFlowController]);

function planMoneyFlowController($scope, paramsService) {


    $scope.gridDate = {};

    //$('.k-grid-add').on('click', function () {
    //    debugger;
    //    $scope.planMoneyFlowGrid.dataSource.options.schema.model.fields.P_FDAT.editable = true;
    //});

    var gridDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent('/api/valuepapers/generalfolder/GetIrrGrid'),
                type: "GET",
                dataType: "json"
            },
            update: {
                url: bars.config.urlContent('/api/valuepapers/generalfolder/PostDiuMany'),
                contentType: "application/json",
                dataType: "json",
                type: "post"
            },
            destroy: {
                url: bars.config.urlContent('/api/valuepapers/generalfolder/PostDiuMany'),
                contentType: "application/json",
                dataType: "json",
                type: "post"
            },
            create: {
                url: bars.config.urlContent('/api/valuepapers/generalfolder/PostDiuMany'),
                contentType: "application/json",
                dataType: "json",
                type: "post"
            },
            parameterMap: function (options, operation) {

                if (operation == "read") {
                    $scope.gridData.DAT_UG = kendo.parseDate($scope.gridData.DAT_UG);
                    $scope.gridData.DAT_UG = kendo.toString($scope.gridData.DAT_UG, "yyyy-MM-ddTHH:mm:sszzz");
                    return $scope.gridData;
                }
                
                if (options) {
                    var action = -1;
                    switch (operation) {
                        case "destroy": {
                            action = 0;
                            break;
                        }
                        case "update": {
                            action = 2;
                            break;
                        }
                        case "create": {
                            action = 1;
                            break;
                        }
                    }
                    options.Action = action;
                    options.REF = $scope.gridData.REF;
                    return JSON.stringify(options);
                }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                id: "P_FDAT",
                fields: {
                    P_FDAT: { type: "date" }, 
                    P_SS1: { type: "number" },
                    P_SDP: { type: "number" },
                    P_SN2: { type: "number" },
                    P_S: { type: "number" }
                }
            }
        }
    })

    $scope.vm = {};
    $scope.$on('initPlanMoneyFlow', function (event, data) {
        $scope.vm = data.model;
        $scope.gridData = data.gridData;
        $scope.planMoneyFlowGrid.dataSource.read();
    })

    html = document.documentElement;
    var height = Math.max(html.clientHeight, html.scrollHeight, html.offsetHeight);

    $scope.datePickerOptions = {
        format: "dd.MM.yyyy",
        parseFormats: ["dd/MM/yyyy"]
    }

    $scope.gridOptions = {
        autoBind: false,
        resizable: true,
        toolbar: [{ name: "create", text: "Додати запис" }, { name: "excel", text: "Експорт в Excel" }],//
        excel: {
            proxyURL: "/barsroot/valuepapers/generalfolder/Excel_Export_Save"
        },
        height: (height / 2.2).toString() + "px",
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            var row = sheet.rows[0];
            for (var cellIndex = 0; cellIndex < row.cells.length; cellIndex++) {
                row.cells[cellIndex].value = row.cells[cellIndex].value.replace(/<br>/g, ' ');
            }
        },
        columns: [            
            { field: "P_FDAT", title: "Дата", width: 85, template: "<div>#=kendo.toString(P_FDAT,'dd.MM.yyyy')#</div>" },
            { field: "P_SS1", title: "Номінал", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(P_SS1,'n2')#</div>" },
            { field: "P_SDP", title: "Дисконт/Премія", width: 90, template: "<div style='text-align:right;'>#=kendo.toString(P_SDP,'n2')#</div>" },
            { field: "P_SN2", title: "Купон", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(P_SN2,'n2')#</div>" },
            { field: "P_S", title: "Разом<br>(в коп.)", width: 80, template: "<div style='text-align:right;'>#=kendo.toString(P_S,'n2')#</div>" },
            { command: ["edit", "destroy"], title: "&nbsp;", width: "150px" }
            //{
            //    command: [
            //        {
            //            name: "edit",
            //            text: {
            //                update: "Зберегти",
            //                cancel: "Відмініти"
            //            },
            //            title: "Редагувати",
            //            template: "<a class='k-grid-edit' title='#=text#' href='' style='min-width:16px;color:green;'><span class='k-icon k-i-pencil'></a>"
            //        },
            //        {
            //            name: "destroy",
            //            text: "Видалити",
            //            template: "<a style='margin-left:10px;color:red;' class='k-grid-delete' title='#=text#' href=''><span class='k-icon k-i-close'></a>"
            //        }
            //    ],
            //    title: "&nbsp;",
            //    width: "150px"
            //}
        ],
        edit: function (e) { e.container.find("input[name=P_FDAT]").data("kendoDatePicker").enable(e.model.isNew()); },
        dataSource: gridDataSource,
        columnMenu: false,
        pageable: false,
        height: 500,
        editable: "inline",
        dataBound: function () {
            if(this.dataItems().length == 0 ) return;

            $scope.vm.P_KOIR = this.dataSource.data().length;
            $scope.vm.P_KOIP = Math.floor((this.dataItems()[$scope.vm.P_KOIR - 1].P_FDAT - this.dataItems()[0].P_FDAT) / (1000 * 60 * 60 * 24));
            $scope.$apply();

            $('[kendo-grid="planMoneyFlowGrid"] tbody tr td:nth-child(3)').css('background-color', '#efefef');
            $('[kendo-grid="planMoneyFlowGrid"] tbody tr td:nth-child(4)').css('background-color', '#e1f4de');
            $('[kendo-grid="planMoneyFlowGrid"] tbody tr td:nth-child(5)').css('background-color', '#def4f4');
            
        }
    }

    $scope.delIir = function () {

        bars.ui.confirm({ text: 'Видалити потоки грошових коштів по угоді ' + $scope.gridData.REF + '?' }, function () {
            paramsService.delIir({ REF: $scope.gridData.REF }).then(function () {
                $scope.planMoneyFlowGrid.dataSource.read();
            });
        })

    }

    $scope.calcEfectBet = function () {

        bars.ui.confirm({ text: "Pозрахувати ефективну ставку?" }, function () {
            paramsService.calcEfectBet().then(function (response) { })
        })        
    }

    $scope.calcFlows = function () {

        bars.ui.confirm({ text: "Pозрахувати потоки?" }, function () {
            paramsService.calcFlows({ REF: $scope.gridData.REF }).then(function () {

                $scope.planMoneyFlowGrid.dataSource.read();
            })
        })
    }

    $scope.refreshM = function () {
            $scope.planMoneyFlowGrid.dataSource.read();        
    }

}