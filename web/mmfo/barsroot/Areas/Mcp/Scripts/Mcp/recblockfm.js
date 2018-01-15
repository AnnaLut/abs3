var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("McpRecBlockFmCtrl", function ($controller, $scope, $http, kendoService, utilsService) {
    $controller('KendoMainController', { $scope: $scope });     // Расширяем контроллер

    $scope.Title = "Заблоковані фінмоніторингом";

    var filesGridToolbar = [
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'files\', \'excel\')" ng-disabled="disabledToolbarGrid(\'files\', \'excel\')"><i class="pf-icon pf-16 pf-exel"></i>Файли в Excel</a>' }
    ];

    $scope.disabledToolbarGrid = function (id, op){
        var grid = $scope.filesGrid;

        switch (op){
            case 'excel':
                return grid._data === undefined ? true : grid._data.length <= 0;
        }
        return false;
    };

    $scope.onClickToolbarGrid = function (id, op) {
        var grid = $scope.filesGrid;

        switch (op){
            case 'excel':
                grid.saveAsExcel();
                break;
        }
    };

    var filesDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/Mcp/RecBlockFmApi/Search")} },
        schema: {
            model: {
                fields: {
					REF: { type: 'number' },
					TT: { type: 'string' },
					DOC_DATE: { type: 'string' },
					FILE_ID: { type: 'number' },
					ID: { type: 'number' },
					MFO: { type: 'number' },
					NLS: { type: 'number' },
					OKPO: { type: 'string' },
					FIO: { type: 'string' },
					SUMA: { type: 'number' },
					SOS: { type: 'number' },
					GROUPID: { type: 'number' },
					USERNAME: { type: 'string' },
					GROUPNAME: { type: 'string' }
                }
            }
        }
    });

    $scope.filesGridOptions = $scope.createGridOptions({
        dataSource: filesDataSource,
        height: 400,
        excel: $scope.excelGridOptions(),
        excelExport: $scope.excelExport,
        toolbar: filesGridToolbar,
        columns: [
			{
				field: "REF",
				title: "Референс<br>документу",
				width: "10%"
			},
			{
				field: "TT",
				title: "Код операції",
				width: "10%"
			},
			{
				field: "DOC_DATE",
				title: "Дата<br>документу",
				width: "10%"
			},
			// {
			// 	field: "FILE_ID",
			// 	title: "FILE_ID",
			// 	width: "10%"
			// },
			{
				field: "ID",
				title: "ID реєстру",
				width: "10%"
			},
			{
				field: "MFO",
				title: "МФО",
				width: "10%"
			},
			{
				field: "NLS",
				title: "Номер рахунку<br>отримувача",
				width: "10%"
			},
			{
				field: "OKPO",
				title: "ІПН",
				width: "10%"
			},
			{
				field: "FIO",
				title: "ПІБ",
				width: "10%"
			},
			{
				field: "SUMA",
				title: "Сума",
				width: "10%"
			},
			{
				field: "SOS",
				title: "Стан оплати<br>документу",
				width: "10%"
			},
			{
				field: "GROUPID",
				title: "Група<br>візування",
				width: "10%"
			},
			{
				field: "USERNAME",
				title: "Користувач",
				width: "10%"
			},
			{
				field: "GROUPNAME",
				title: "Назва групи<br>візування",
				width: "10%"
			}           
        ]
    });

});