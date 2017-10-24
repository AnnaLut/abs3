angular.module('BarsWeb.Controllers')
    .controller('KFiles.FilesCorporationCtrl', ['$scope', '$http', '$rootScope',
        function ($scope, $http, $rootScope) {

            $scope.model = {};
            $scope.ShowGridFilesCorporation = true;

            $rootScope.getCorporationFiles = function (corporationId) {

                $scope.model.CorporationId = corporationId;
                $scope.gridFilesCorporation.dataSource.read({ CorporationID: corporationId });
            }

            $scope.gridDataSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        url: bars.config.urlContent("/kfiles/kfiles/GetCorporationFiles"),
                        dataType: 'json'
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ID: { type: "number" },
                            FILE_DATE: { type: "date" },
                            MFO: { type: "string" },
                            STATE: { type: "string" },
                            SYNCTIME: { type: "date" },
                            SYNCTYPE: { type: "string" }
                        }
                    }
                },
                pageSize: 10,
                page: 1
            });

            $scope.gridOptionsFilesCorporation = {
                autoBind: false,
                dataSource: $scope.gridDataSource,
                sortable: true,
                selectable: 'row',
                columns: [
                    { field: "ID", title: "Ідентифікатор сеансу", width: "20%" },
                    { field: "FILE_DATE", title: "Дата файлу", width: "20%", template: "<div>#=kendo.toString(kendo.parseDate(FILE_DATE),'dd/MM/yyyy')#</div>" },
                    { field: "MFO", title: "Код/назва регіонального управління", width: "15%" },
                    { field: "STATE", title: "Стан сеансу", width: "15%" },
                    { field: "SYNCTIME", title: "Системний час створення сеансу", width: "15%", template: "<div>#=kendo.toString(kendo.parseDate(SYNCTIME),'dd/MM/yyyy')#</div>" },
                    { field: "SYNCTYPE", title: "Додаткові відомості", width: "15%" }
                ]
            };

            $scope.toolbarOptionsFilesCorporation = {
                items: [
                     { template: "<button type = 'button' ng-click = 'dataFiles()' class='k-button' ng-disabled = '!disabledButtonDataFiles'><i class='pf-icon pf-16 pf-folder'></i>Дані файлу</button>" },
                     { template: "<button type = 'button' ng-click = 'closeDataFiles()' class='k-button'  ng-show='showButtoncloseDataFiles' ><i class='pf-icon pf-16 pf-arrow_left'></i>Повернутись до даних файлу</button>" }
                ]
            };


            $scope.gridDataSourceDataFiles = new kendo.data.DataSource({
                transport: {
                    read: {
                        url: bars.config.urlContent("/kfiles/kfiles/GetCorporationDataFiles"),
                        dataType: 'json'
                    }
                },
                schema: {
                    model: {
                        fields: {
                            DAPP: { type: "date" },
                            DK: { type: "number" },
                            DOCDAT: { type: "date" },
                            DOCKV: { type: "string" },
                            DOCTYPE: { type: "number" },
                            KOD_ANALYT: { type: "string" },
                            KOD_CORP: { type: "number" },
                            KOD_USTAN: { type: "number" },
                            KV: { type: "string" },
                            KVA: { type: "number" },
                            KVB: { type: "number" },
                            MFOA: { type: "string" },
                            MFOB: { type: "string" },
                            NAMA: { type: "string" },
                            NAMB: { type: "string" },
                            NAMK: { type: "string" },
                            NAZN: { type: "string" },
                            ND: { type: "string" },
                            NLS: { type: "string" },
                            NLSA: { type: "string" },
                            NLSB: { type: "string" },
                            NMS: { type: "string" },
                            OBDB: { type: "number" },
                            OBDBQ: { type: "number" },
                            OBKR: { type: "number" },
                            OBKRQ: { type: "number" },
                            OKPO: { type: "string" },
                            OKPOA: { type: "string" },
                            OKPOB: { type: "string" },
                            OST: { type: "number" },
                            OSTQ: { type: "number" },
                            OURMFO: { type: "string" },
                            POSTDAT: { type: "date" },
                            POSTTIME: { type: "date" },
                            ROWTYPE: { type: "number" },
                            S: { type: "number" },
                            SQ: { type: "number" },
                            TT: { type: "string" },
                            VALDAT: { type: "date" },
                            VOB: { type: "number" }
                        }
                    }
                },
                pageSize: 10,
                page: 1
            });

            $scope.gridOptionsDataFiles = {
                autoBind: false,
                dataSource: $scope.gridDataSourceDataFiles,
                resizable: true,
                pageable: true,
                sortable: true,
                columns: [
                    { field: "ROWTYPE", title: "Ознака Рахунок/документ/пiдсумок", width: "100px" },
                    { field: "OURMFO", title: "МФО банку", width: "100px" },
                    { field: "NLS", title: "Особовий рахунок (кількість рахунків  для підсумкового рядку)", width: "100px" },
                    { field: "KV", title: "Валюта рахунку", width: "100px" },
                    { field: "OKPO", title: "Код ОКПО", width: "100px" },
                    { field: "OBDB", title: "Дебетові обороти в валюті", width: "100px" },
                    { field: "OBDBQ", title: "Дебетові обороти (еквівалент в національній валюті)", width: "100px" },
                    { field: "OBKR", title: "Кредитові обороти в валюті", width: "100px" },
                    { field: "OBKRQ", title: "Кредитові обороти (еквівалент в національній валюті)", width: "100px" },
                    { field: "OST", title: "Вихідний залишок в валюті", width: "100px" },
                    { field: "OSTQ", title: "Вихідний залишок (еквівалент в національній валюті)", width: "100px" },
                    { field: "KOD_CORP", title: "Код корпоративного клієнта", width: "100px" },
                    { field: "KOD_USTAN", title: "Код установи корпоративного клієнта", width: "100px" },
                    { field: "KOD_ANALYT", title: "Код аналітичного обліку", width: "100px" },
                    { field: "DAPP", title: "Дата попереднього руху по рахунку", width: "200px", template: "<div>#=  DAPP === null ? '-' : kendo.toString(kendo.parseDate(DAPP),'dd/MM/yyyy') #</div>" },
                    { field: "POSTDAT", title: "Дата проведення в ОДБ (дата руху по рахунку для стрычки по рахунку)", width: "200px", template: "<div>#=  POSTDAT === null ? '-' :  kendo.toString(kendo.parseDate(POSTDAT),'dd/MM/yyyy') #</div>" },
                    { field: "DOCDAT", title: "Дата документу", width: "200px", template: "<div>#= DOCDAT === null ? '-' :  kendo.toString(kendo.parseDate(DOCDAT),'dd/MM/yyyy')#</div>" },
                    { field: "VALDAT", title: "Дата валютування", width: "200px", template: "<div>#= VALDAT === null ? '-' :   kendo.toString(kendo.parseDate(VALDAT),'dd/MM/yyyy')#</div>" },
                    { field: "ND", title: "Номер документу", width: "100px" },
                    { field: "VOB", title: "Вид документу", width: "100px" },
                    { field: "DK", title: "Дебет/Кредит", width: "100px" },
                    { field: "MFOA", title: "МФО банку платника", width: "100px" },
                    { field: "NLSA", title: "Особовий рахунок платника", width: "100px" },
                    { field: "KVA", title: "Валюта особового рахунку платника", width: "100px" },
                    { field: "NAMA", title: "Найменування клієнта платника", width: "300px" },
                    { field: "OKPOA", title: "Ідентифікатор клієнта платника", width: "100px" },
                    { field: "MFOB", title: "МФО банку отримувача", width: "100px" },
                    { field: "NLSB", title: "Особовий рахунок отримувача", width: "100px" },
                    { field: "KVB", title: "Валюта особового рахунку отримувача", width: "100px" },
                    { field: "NAMB", title: "Найменування клієнта отримувача", width: "100px" },
                    { field: "OKPOB", title: "Ідентифікатор клієнта отримувача", width: "100px" },
                    { field: "S", title: "Сума платежу в валюті", width: "100px" },
                    { field: "DOCKV", title: "Валюта платежу", width: "100px" },
                    { field: "SQ", title: "Сума платежу (еквівалент в національній валюті)", width: "100px" },
                    { field: "NAZN", title: "Призначення платежу", width: "400px" },
                    { field: "DOCTYPE", title: "Ознака проводки", width: "100px" },
                    { field: "POSTTIME", title: "Час проведення в ОДБ", width: "200px", template: "<div>#= POSTTIME === null ? '-' :   kendo.toString(kendo.parseDate(POSTTIME),'dd/MM/yyyy')#</div>" },
                    { field: "NAMK", title: "Найменування клієнта", width: "100px" },
                    { field: "NMS", title: "Найменування рахунку", width: "100px" },
                    { field: "TT", title: "Код операции", width: "100px" }
                ]
            };

            $scope.dataFiles = function () {

                $scope.disabledButtonDataFiles = false;
                $scope.showButtoncloseDataFiles = true;
                $scope.ShowGridDataFiles = true;
                $scope.ShowGridFilesCorporation = false;
                $rootScope.lockTabCorporation = true;
                $scope.gridDataFiles.dataSource.read({ sessionID: $scope.model.sessionID });
            }

            $scope.closeDataFiles = function () {

                $scope.ShowGridDataFiles = false;
                $scope.ShowGridFilesCorporation = true;
                $scope.showButtoncloseDataFiles = false;
                $scope.disabledButtonDataFiles = false;
                $rootScope.lockTabCorporation = false;
                $scope.gridFilesCorporation.dataSource.read({ CorporationID: $scope.model.CorporationId });
            }

            $scope.selectedRowFilesCorporation = function (data) {

                $scope.model.sessionID = data.ID;

                if (data.STATE == 'Оброблено') {
                    $scope.disabledButtonDataFiles = true;
                }
                else {
                    $scope.disabledButtonDataFiles = false;
                }
            }

        }]);