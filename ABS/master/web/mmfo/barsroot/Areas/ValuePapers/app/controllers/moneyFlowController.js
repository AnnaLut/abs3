app.controller("moneyFlowController", ['$scope', 'paramsService', moneyFlowController]);

function moneyFlowController($scope, paramsService) {

    var gridDataSource = {
        type: "webapi",
        transport: {
            read: {
                type: "GET",
                dataType: 'json',
                url: bars.config.urlContent('/api/valuepapers/generalfolder/GetMFGrid'),
                data: function () {
                    //$scope.vm.REF = '7009566701';
                    return $scope.vm;
                }
            }
        },
        serverFiltering: true,
        serverSorting: true,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    FDAT: { type: "date" },
                    ND: { type: "number" }
                }
            }
        }
    };

    $scope.vm = {};
    $scope.$on('initMoneyFlow', function (event, data) {
        var ref = data.REF;
        paramsService.getMoneyFlowParams(data.REF).then(function (response) {
            $scope.vm = response;
            $scope.vm.REF = ref;
            $scope.vm.RB1 = 1;
            $scope.vm.RB2 = 0;
            $scope.moneyFlowGrid.dataSource.read();
        });
    })

    $scope.datePickerOptions = {
        format: "dd.MM.yyyy",
        parseFormats: ["dd/MM/yyyy"]
    }

    $scope.turnMoneyParam = function (rb1, rb2, dat) {
        $scope.vm.RB1 = rb1;
        $scope.vm.RB2 = rb2;
        $scope.vm.DAT_ROZ = dat;
        $scope.moneyFlowGrid.dataSource.read();
    }
    html = document.documentElement;
    var height = Math.max(html.clientHeight, html.scrollHeight, html.offsetHeight);
    $scope.isRightClick = false;
    var total = 0;
    var cntrlIsPressed = false;


    $scope.gridOptions = {
        autoBind: false,
        resizable: true,
        toolbar: [{ name: "excel", text: "Експорт в Excel" }],//
        excel: {
            proxyURL: "/barsroot/valuepapers/generalfolder/Excel_Export_Save"
        },
        height: (height / 1.8).toString() + "px",
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            var row = sheet.rows[0];
            for (var cellIndex = 0; cellIndex < row.cells.length; cellIndex++) {
                row.cells[cellIndex].value = row.cells[cellIndex].value.replace(/<br>/g, ' ');
            }
        },
        columns: [
            {
                field: "FDAT",
                title: "Дата",
                template: "<div>#=FDAT!=null ? kendo.toString(FDAT,'dd.MM.yyyy') : '' #</div>",
                width: 85
            },
            { field: "NDD", title: "Номер дня<br>в потоці", width: 50 },
            { field: "DNEY", title: "Днів", width: 50 },
            { field: "G1", title: "Потік<br>всього<br>1", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G1,'n2')#</div>" },
            { field: "G2", title: "Потік<br>еталон<br>2", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G2,'n2')#</div>" },
            { field: "G3", title: "Потік<br>номінал<br>3", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G3,'n2')#</div>" },
            { field: "G4", title: "Потік<br>проценти<br>4", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G5,'n2')#</div>" },
            { field: "G5", title: "Потік<br>Диск/Прем<br>5", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G5,'n2')#</div>" },
            { field: "G6", title: "Вартість<br>реальна<br>6", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G6,'n2')#</div>" },
            { field: "G7", title: "Вартість<br>еталонна<br>7", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G7,'n2')#</div>" },
            { field: "G8", title: "Норма<br>Диск/Прем<br>8", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G8,'n2')#</div>" },
            { field: "G9", title: "Амортизація<br>Диск/Прем 9", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G9,'n2')#</div>" },
            { field: "G9A", title: "Амортизація<br>на 1шт<br>9а", width: 50, template: "<div style='text-align:right;'>#=kendo.toString(G9A,'n2')#</div>" },
            { field: "G10", title: "Норма<br>купон (%%) 10", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G10,'n2')#</div>" },
            { field: "G10A", title: "Норма купону<br>1шт<br>10а", width: 50, template: "<div style='text-align:right;'>#=kendo.toString(G10A,'n2')#</div>" },
            { field: "G11", title: "Переоцінка<br>11", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G11,'n2')#</div>" },
            { field: "G11A", title: "Переоцінка<br>на 1шт<br>11а", width: 50, template: "<div style='text-align:right;'>#=kendo.toString(G11A,'n2')#</div>" },
            { field: "G12", title: "Номінал<br>12", width: 120, template: "<div style='text-align:right;'>#=kendo.toString(G12,'n2')#</div>" },
            { field: "G12A", title: "Номінал<br>на 1шт<br>12", width: 80, template: "<div style='text-align:right;'>#=kendo.toString(G12A,'n2')#</div>" },
            { field: "G13", title: "ПІДСУМОК/Бал.ст.<br>13 = 12+11+10+8", width: 150, template: "<div style='text-align:right;'>#=kendo.toString(G13,'n2')#</div>" },
            { field: "G13A", title: "ПІДСУМОК/Бал.ст.<br>на 1шт<br>13 = 12+11+10+8", width: 150 },
            { field: "G14", title: "Ст.дох.<br>тек.IRR 14", width: 100, template: "<div style='text-align:right;'>#=kendo.toString(G14,'n2')#</div>" }
        ],
        dataSource: gridDataSource,
        columnMenu: true,
        dataBound: function () {
            var moneyFlowGrid = this;
            $(document).off('keydown').on('keydown', function (event) {
                if (event.which == "17")
                    cntrlIsPressed = true;
            });

            $(document).off('keyup').on('keyup', function () {
                cntrlIsPressed = false;
            });

            $('#moneyFlowGrid tbody tr').off('click').on('click', function (event) {

                if (cntrlIsPressed)
                    $(event.target).closest('tr').toggleClass('k-state-selected');
                else {
                    $('#moneyFlowGrid tbody tr.k-state-selected').removeClass('k-state-selected');
                    $(event.target).closest('tr').addClass('k-state-selected');
                }

                var selectedRows = $('#moneyFlowGrid tbody tr.k-state-selected');
                if (selectedRows.length > 0)
                    $scope.firstSelRow = moneyFlowGrid.dataItem(selectedRows[0]);
                else
                    $scope.firstSelRow = undefined;
            });
            //------------------------TOOLTIP---------
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

            $("#moneyFlowGrid").kendoTooltip({
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
            $('#moneyFlowGrid tbody tr').each(function (index, elem) {

                if (moneyFlowGrid.dataItem(elem).color_id == 0)
                    $(elem).addClass('gray-row');
                if (moneyFlowGrid.dataItem(elem).color_id == 1)
                    $(elem).addClass('green-row');
                if (moneyFlowGrid.dataItem(elem).color_id == 2)
                    $(elem).addClass('yellow-row');
            });
        }
    };

}