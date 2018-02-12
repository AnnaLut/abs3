angular.module("BarsWeb.Controllers").controller("KFiles.DataViewCtrl", ["$scope", "$http", "$location", "$element", "$rootScope", function ($scope, $http, $location, $element, $rootScope) {

    var vm = this;
    var selectFileDate;
    var selectKv;
    var selectNls;
    vm.Title = 'Перегляд даних';
    vm.ShowRevisionGrid = true;
    vm.ShowForm = false;
    vm.ShowTurnoverBalanceGrid = false;
    vm.fromDateString = '';
    vm.fromDateObject = null;
    vm.toDateString = ParseDateToStringFormatDMY(new Date());
    vm.toDateObject = null;
    vm.maxDate = new Date();
    vm.minDate = new Date(2000, 0, 1, 0, 0, 0);

    vm.revisionDataGridOptions = {
        toolbar: ["excel"],
        excel: {
            fileName: "Saldo.xlsx",
            proxyURL: bars.config.urlContent('KFiles/KFiles/convertBase64toFile/')
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            var header = sheet.rows[0];
            for (var headerCellIndex = 0; headerCellIndex < header.cells.length; headerCellIndex++) {
                var headerColl = header.cells[headerCellIndex];
                headerColl.value = headerColl.value.replace(/<br>/g, ' ');
            }
        },
        dataSource: {
            type: 'aspnetmvc-ajax',
            transport: {
                read: {
                    url: bars.config.urlContent('KFiles/KFiles/GetDataViewData'),
                    type: 'GET',
                    dataType: 'json',
                    cache: false,
                    data: function ()
                    {
                        return {
                            filterss: {
                                P_DAT_FIRST: vm.fromDateString, P_DAT_LAST: vm.toDateString, P_KOD_KORP: vm.ustanKod, P_KOD_REG: vm.regionKod, P_IZ_STRUKT: vm.withStructure, P_OKPO: vm.okpo, P_BALANS_R: vm.balans, P_TRKK: vm.trkk, P_ROZR_R: vm.rozrah, P_KOD_OPER: vm.tt
                            }
                        }
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        FILE_DATE: {
                            type: 'date'
                        },
                        ORD: {
                            type: 'number'
                        },
                        NAME: {
                            type: 'string'
                        },
                        KOD_CORP: {
                            type: 'number'
                        },
                        CORPORATION_NAME: {
                            type: 'string'
                        },
                        OKPO: {
                            type: 'string'
                        },
                        KOD_USTAN: {
                            type: 'number'
                        },
                        NLS: {
                            type: 'string'
                        },
                        KOD_ANALYT: {
                            type: 'string'
                        },
                        KV: {
                            type: 'number'
                        },
                        OSTQ_IN: {
                            type: 'number'
                        },
                        OBDBQ: {
                            type: 'number'
                        },
                        OBKRQ: {
                            type: 'number'
                        },
                        OSTQ_OUT: {
                            type: 'number'
                        },
                        DOC: {
                            type: 'number'
                        },
                        KILK_D: {
                            type: 'number'
                        },
                        KILK_KR: {
                            type: 'number'
                        }
                    }
                }
            },
            serverPaging: true,
            serverFiltering: true,
            pageSize: 100
        },
        autoBind: false,
        selectable: 'multiple',
        sortable: true,
        resizable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 25, 50, 100, "All"],
            buttonCount: 5,
            messages: {
                empty: 'Немає даних',
                allPages: 'Всі'
            }
        },
        columns: [
            {
                field: 'FILE_DATE',
                hidden: true
            },
            {
                field: 'ORD',
                hidden: true
            },
            {
                field: 'NAME',
                hidden: true
            },
            {
                field: 'KOD_CORP',
                hidden: true
            },
            {
                field: 'CORPORATION_NAME',
                hidden: true
            },
            {
                title: 'Код ЭДРПОУ',
                headerAttributes: {
                    title: 'Код ЄДРОПОУ'
                },
                field: 'OKPO',
                width: "80px"
            },
            {
                title: 'Код установи',
                headerAttributes: {
                    title: 'Код установи'
                },
                field: 'KOD_USTAN',
                width: "70px"
            },
            {
                title: 'Р/р',
                headerAttributes: {
                    title: 'Розрахунковий рахунок'
                },
                field: 'NLS',
                template: '<a style="color:blue" ng-click="Vie.ShowTurnoverBalanceData(\'#= kendo.toString(kendo.parseDate(FILE_DATE), \"dd\/MM\/yyyy\")#\', #= KV #, #= NLS #)">#= NLS #</a>',
                width: "90px"
            },
            {
                title: 'ТРКК',
                headerAttributes: {
                    title: 'ТРКК'
                },
                field: 'KOD_ANALYT',
                width: "50px"
            },
            {
                title: 'Код валюти',
                headerAttributes: {
                    title: 'Код валюти'
                },
                field: 'KV',
                width: "70px"
            },
            {
                title: 'Вхідні залишки',
                headerAttributes: {
                    title: 'Вхідні залишки'
                },
                field: 'OSTQ_IN',
                width: "90px"
            },
            {
                title: 'Дебетові обороти',
                headerAttributes: {
                    title: 'Дебетові обороти'
                },
                field: 'OBDBQ',
                width: "90px"
            },
            {
                title: 'Кредитові обороти',
                headerAttributes: {
                    title: 'Кредитові обороти'
                },
                field: 'OBKRQ',
                width: "100px"
            },
            {
                title: 'Вихідні залишки',
                headerAttributes: {
                    title: 'Вихідні залишки'
                },
                field: 'OSTQ_OUT',
                width: "70px"
            },
            {
                title: 'К-ть документів',
                headerAttributes: {
                    title: 'Кількість документів'
                },
                field: 'DOK',
                width: "40px"
            },
            {
                title: 'К-ть Дт документів',
                headerAttributes: {
                    title: 'Кількість Дт документів'
                },
                field: 'KILK_D',
                width: "40px"
            },
            {
                title: 'К-ть Кт документів',
                headerAttributes: {
                    title: 'Кількість Кт документів'
                },
                field: 'KILK_KR',
                width: "40px"
            }
        ]
    }

    vm.ShowRevisionDataGrid = function () {
        if ((vm.fromDateString === '') || (vm.toDateString === '')) {
            alert('Заповніть обов\'язкові поля');
            return;
        }
        if (vm.regionKod) {
            vm.ShowRegionGrid = false;
        }
        else {
            vm.ShowRegionGrid = true;
        }
        vm.ShowForm = true;
        vm.GetRangeDates();
        vm.filterWind.close();
        vm.revisionDataGrid.dataSource.read({ P_DAT_FIRST: vm.fromDateString, P_DAT_LAST: vm.toDateString, P_KOD_KORP: vm.ustanKod, P_KOD_REG: vm.regionKod, P_IZ_STRUKT: vm.withStructure, P_OKPO: vm.okpo, P_BALANS_R: vm.balans, P_TRKK: vm.trkk, P_ROZR_R: vm.rozrah, P_KOD_OPER: vm.tt });
    }

    vm.regionDropdownOptions = {
        dataSource: {
            transport: {
                read: {
                    url: bars.config.urlContent('/KFiles/KFiles/GetRegions'),
                    type: 'GET',
                    dataType: 'json',
                    cache: false
                }
            }
        },
        optionLabel: {
            NAME: 'Не вибрано',
            ORD: ''
        },
        dataTextField: 'NAME',
        dataValueField: 'ORD',
        autoBind: false,
        filter: 'contains',
        change: function (e) {
            var index = this.selectedIndex,
                dataItem;

            dataItem = this.dataItem(index);
            vm.regionKod = dataItem.ORD;
            $scope.$apply();
        }
    }

    vm.fromDateChanged = function () {
        vm.minDate = kendo.parseDate(vm.fromDateString, 'dd/MM/yyyy');
    };

    vm.toDateChanged = function () {
        vm.maxDate = kendo.parseDate(vm.toDateString, 'dd/MM/yyyy');
    };

    vm.filterWindOptions = {
        title: 'Введіть параметри відбору даних',
        scrollable: false,
        width: 500,
        height: 460,
        position: {
            top: '20%',
            left: '30%'
        },
        modal: true
    }

    vm.RegionGridOptions = {
        type: 'aspnetmvc-ajax',
        dataSource: {
            transport: {
                read: {
                    url: bars.config.urlContent('/KFiles/KFiles/GetRegions'),
                    type: 'GET',
                    dataType: 'json',
                    cache: false
                }
            },
            schema: {
                model: {
                    fields: {
                        NAME: {
                            type: 'string'
                        },
                        ORD: {
                            type: 'number'
                        }
                    }
                }
            }
        },
        height: 330,
        autoBind: true,
        scrollable: true,
        sortable: true,
        selectable: "single",
        columns: [
            {
                title: 'Код регіона',
                headerAttributes: {
                    title: 'Код регіона'
                },
                field: 'ORD',
                width: "10px"
            },
            {
                title: 'Регіон',
                field: 'NAME',
                width: "40px"
            }
        ]
    }

    var daysOffYear = [];
    vm.GetRangeDates = function () {
        var tDate = kendo.parseDate(vm.toDateString, 'dd/MM/yyyy');
        for (var fDate = kendo.parseDate(vm.fromDateString, 'dd/MM/yyyy'); fDate <= tDate; fDate.setDate(fDate.getDate() + 1)) {
            daysOffYear.push({ Date: ParseDateToStringFormatDMY(fDate) });
        }
        vm.DateGrid.dataSource.read();
    }

    vm.DateGridOptions = {
        dataSource: daysOffYear,
        autoBind: false,
        height: 310,
        scrollable: true,
        selectable: "single",
        columns: [
            {
                title: 'Дата',
                field: 'Date'
            }
        ]
    }

    vm.ustanDropDownOptions = {
        dataSource: {
            type: 'aspnet-mvc',
            transport: {
                read: {
                    url: bars.config.urlContent('/KFiles/KFiles/GetDropDownCorporations'),
                    type: 'GET',
                    dataType: 'json'
                }
            }
        },
        optionLabel: {
            CORPORATION_NAME: "Не вибрано",
            ID: ""
        },
        dataTextField: 'CORPORATION_NAME',
        dataValueField: 'ID',
        filter: 'contains',
        autoBind: false,
        scrollable: true,
        change: function () {
            var index = this.selectedIndex,
                dataItem;

            dataItem = this.dataItem(index);
            vm.ustanKod = dataItem.ID;
            $scope.$apply();
        }
    };

    vm.TurnovelBalanceGridOptions = {
        toolbar: ["excel"],
        excel: {
            fileName: 'Documents.xlsx',
            proxyURL: bars.config.urlContent('KFiles/KFiles/convertBase64toFile/'),
            allPages: false
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            var header = sheet.rows[0];
            for (var headerCellIndex = 0; headerCellIndex < header.cells.length; headerCellIndex++) {
                var headerColl = header.cells[headerCellIndex];
                headerColl.value = headerColl.value.replace(/<br>/g, ' ');
            }
        },
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    url: bars.config.urlContent("KFiles/KFiles/GetTurnoverbalanceData"),
                    type: "GET",
                    dataType: "json",
                    cashe: false,
                    data: function () {
                        return { FILE_DATE: selectFileDate, KV: selectKv, NLS: selectNls, TT: vm.tt };
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        FILE_DATE: {
                            type: 'date'
                        },
                        ORD: {
                            type: 'number'
                        },
                        NAME: {
                            type: 'string'
                        },
                        KOD_CORP: {
                            type: 'number'
                        },
                        CORPORATION_NAME: {
                            type: 'string'
                        },
                        OKPO: {
                            type: 'string'
                        },
                        KOD_USTAN: {
                            type: 'number'
                        },
                        NLS: {
                            type: 'string'
                        },
                        KOD_ANALYT: {
                            type: 'string'
                        },
                        KV: {
                            type: 'number'
                        },
                        S: {
                            type: 'number'
                        },
                        SQ: {
                            type: 'number'
                        },
                        ND: {
                            type: 'string'
                        },
                        VOB: {
                            type: 'number'
                        },
                        D_DOC: {
                            type: 'string'
                        },
                        T_DOC: {
                            type: 'string'
                        },
                        DOCTYPE: {
                            type: 'string'
                        },
                        MFOA: {
                            type: 'string'
                        },
                        NAMBA: {
                            type: 'string'
                        },
                        NLSA: {
                            type: 'string'
                        },
                        KVA: {
                            type: 'number'
                        },
                        OKPOA: {
                            type: 'string'
                        },
                        NAMA: {
                            type: 'string'
                        },
                        MFOB: {
                            type: 'string'
                        },
                        NAMBB: {
                            type: 'string'
                        },
                        NLSB: {
                            type: 'string'
                        },
                        KVB: {
                            type: 'number'
                        },
                        OKPOB: {
                            type: 'string'
                        },
                        NAMB: {
                            type: 'string'
                        },
                        TT: {
                            type: 'string'
                        },
                        NAZN: {
                            type: 'string'
                        }
                    }
                }
            },
            serverFiltering: true,
            pageSize: 10
        },
        autoBind: false,
        selectable: "single",
        sortable: true,
        resizable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 25, 50, 100, "All"],
            buttonCount: 5,
            messages: {
                empty: 'Немає даних',
                allPages: 'Всі'
            }
        },
        columns: [
            {
                field: 'FILE_DATE',
                hidden: true
            },
            {
                field: 'ORD',
                hidden: true
            },
            {
                title: 'Найменування <br>регіону',
                field: 'NAME',
                width: "130px"
            },
            {
                field: 'KOD_CORP',
                hidden: true
            },
            {
                field: 'CORPORATION_NAME',
                hidden: true
            },
            {
                title: 'Код ЄДРПОУ',
                field: 'OKPO',
                width: "130px"
            },
            {
                title: 'Код установи',
                field: 'KOD_USTAN',
                width: "140px"
            },
            {
                title: 'Розрахунковий <br>рахунок',
                field: 'NLS',
                width: "150px"
            },
            {
                title: 'Код <br>aналітичного обліку',
                field: 'KOD_ANALYT',
                width: "130px"
            },
            {
                title: 'Код <br>валюти',
                field: 'KV',
                width: "100px"
            },
            {
                title: 'Сума у <br>валюті',
                field: 'S',
                width: "100px"
            },
            {
                title: 'Сума в <br>грн',
                field: 'SQ',
                width: "100px"
            },
            {
                title: 'Номер <br>документу',
                field: 'ND',
                width: "100px"
            },
            {
                title: 'Вид <br>документу',
                field: 'VOB',
                width: "100px"
            },
            {
                title: 'Дата ОДБ',
                field: 'D_DOC',
                width: "130px"
            },
            {
                title: 'Час',
                field: 'T_DOC',
                width: "90px"
            },
            {
                title: 'Ознака <br>проводки',
                field: 'DOCTYPE',
                width: "100px"
            },
            {
                title: 'Код банку <br>платника',
                field: 'MFOA',
                width: "110px"
            },
            {
                field: 'NAMBA',
                hidden: true
            },
            {
                title: 'Особовий рахунок <br>платника',
                field: 'NLSA',
                width: "160px"
            },
            {
                title: 'Валюта <br>платника',
                field: 'KVA',
                width: "100px"
            },
            {
                title: 'Ідентифікатор <br>платника',
                field: 'OKPOA',
                width: "130px"
            },
            {
                title: 'Найменування <br>платника',
                field: 'NAMA',
                width: "130px"
            },
            {
                title: 'Код банку <br>отримувача',
                field: 'MFOB',
                width: "110px"
            },
            {
                field: 'NAMBB',
                hidden: true
            },
            {
                title: 'Особовий рахунок <br>отримувача',
                field: 'NLSB',
                width: "160px"
            },
            {
                title: 'Валюта <br>отримувача',
                field: 'KVB',
                width: "105px"
            },
            {
                title: 'Ідентифікатор <br>отримувача',
                field: 'OKPOB',
                width: "130px"
            },
            {
                title: 'Найменування <br>отримувача',
                field: 'NAMB',
                width: "160px"
            },
            {
                title: 'Код <br>операції',
                field: 'TT',
                width: "100px"
            },
            {
                title: 'Призначення платежу',
                field: 'NAZN',
                width: "300px"
            }
        ]
    }

    vm.ShowTurnoverBalanceData = function (fileDate,kv,nls) {
        vm.ShowRevisionGrid = false;
        vm.ShowTurnoverBalanceGrid = true;
        selectFileDate = fileDate;
        selectKv = kv;
        selectNls = nls;
        vm.TurnovelBalanceGrid.dataSource.read();
    }

    vm.OpenTurnoverBalanceDataWindow = function (dataRow) {
        var ob = {
            FILE_DATE: dataRow.FILE_DATE,
            ORD: dataRow.ORD,
            KOD_CORP: dataRow.KOD_CORP,
            CORPORATION_NAME: dataRow.CORPORATION_NAME,
            OKPO: dataRow.OKPO,
            KOD_USTAN: dataRow.KOD_USTAN,
            NLS: dataRow.NLS,
            KOD_ANALYT: dataRow.KOD_ANALYT,
            KV: dataRow.KV,
            S: dataRow.S,
            SQ: dataRow.SQ,
            ND: dataRow.ND,
            VOB: dataRow.VOB,
            D_DOC: dataRow.D_DOC,
            T_DOC: dataRow.T_DOC,
            DOCTYPE: dataRow.DOCTYPE,
            MFOA: dataRow.MFOA,
            NAMBA: dataRow.NAMBA,
            NLSA: dataRow.NLSA,
            KVA: dataRow.KVA,
            OKPOA: dataRow.OKPOA,
            NAMA: dataRow.NAMA,
            MFOB: dataRow.MFOB,
            NAMBB: dataRow.NAMBB,
            NLSB: dataRow.NLSB,
            KVB: dataRow.KVB,
            OKPOB: dataRow.OKPOB,
            NAMB: dataRow.NAMB,
            TT: dataRow.TT,
            NAZN: dataRow.NAZN
        };

        vm.KfileDataWind.refresh({
            data: ob,
            url: bars.config.urlContent('KFiles/KFiles/DataKFiles')
        });
        vm.KfileDataWind.open().center();
    }

    vm.FilterByRegion = function (data) {
        vm.ShowRevisionGrid === true ? FilterGrid(vm.revisionDataGrid, 'ORD', data.ORD) : FilterGrid(vm.TurnovelBalanceGrid, 'ORD', data.ORD);
        vm.DateGrid.clearSelection();
    }

    vm.FilterByDate = function (data) {
        vm.ShowRevisionGrid === true ? FilterGrid(vm.revisionDataGrid, 'FILE_DATE', kendo.parseDate(data.Date, 'dd/MM/yyyy')) : FilterGrid(vm.TurnovelBalanceGrid, 'FILE_DATE', kendo.parseDate(data.Date, 'dd/MM/yyyy'));
        vm.RegionGrid.clearSelection();
    }

    function FilterGrid(grid,field,value) {
        grid.dataSource.filter({
            field: field,
            operator: 'eq',
            value: value
        });
    }

    function ParseDateToStringFormatDMY(date) {
        var day = date.getDate();
        day = day < 10 ? '0' + day : day;
        var month = (date.getMonth()) + 1;
        month = month < 10 ? '0' + month : month;
        return day + '/' + month + '/' + date.getFullYear();
    }
}]);