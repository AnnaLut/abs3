angular.module('BarsWeb.Controllers')
.controller('ArchiveFilesCtrl', ['$scope', '$http', function ($scope, $http) {
    var vm = this;

    vm.ArchGridDataSource = new kendo.data.DataSource({
        type: 'webapi',
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/api/way/archivefilesapi/get"),
                dataType: 'json',
                cache: false
            }
        },
        requestStart: function () {
            bars.ui.loader("body", true);
        },
        requestEnd: function (e) {            
            bars.ui.loader("body", false);
        },
            schema: {
                data: function (result) {
                    return result.Data.Data || (function () {
                        return bars.ui.error({ text: 'Помилка отримання значень таблиці:<br/>' + result.Message });
                    })();
                },
                total: function (result) {
                    return result.Data.Total || 0;
                },
                errors: function (result) {
                    return result.Data.Errors || 0;
                    },
                model: {
                    fields: {
                        ID: { type: "number" },
                        FILE_NAME: { type: "string" },
                        FILE_DATE: { type: "date" },
                        FILE_N: { type: "number" },
                        FILE_DEAL: { type: "number" },
                        CARD_CODE: { type: "string" },
                        BRANCH: { type: "string" },
                        ISP: { type: "number" }
                    }
                }
        },
        pageSize: 10,
        resizable: true,
        serverFiltering: true,
        serverPaging: true,
        serverSorting: true
    });

    vm.ArchGridOptions = {
        filterable: true,       
        selectable: 'row',
        sortable: true,
        resizable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 30, 45, 60],
            buttonCount: 5
        },       
        dataSource: vm.ArchGridDataSource,
        columns: [
            { field: "ID", title: "Код файлу", width: 100 },
            { field: "FILE_NAME", title: "Ім'я файлу", width: 200 },
            { field: "FILE_DATE", title: "Дата файлу", template: "<div>#=kendo.toString(kendo.parseDate(FILE_DATE, 'yyyy-MM-dd'), 'dd/MM/yyyy')#</div>", width: 100 },
            { field: "FILE_N", title: "Кількість заяв<br/> у файлі", width: 100 },
            { field: "FILE_DEAL", title: "Кількість зареєстр.<br/> угод", width: 100 },
            { field: "CARD_CODE", title: "Тип картки", width: 100 },
            { field: "BRANCH", title: "Відділення", width: 100 },
            { field: "ISP", title: "Вик.", width: 100 }
        ]        
    };

    vm.toolbarOptions = {
        items: [
            {
                template: '<button class="k-button" title="Виконати формування квитанції" ng-click="Arch.ExecReceipt()"><i class="pf-icon pf-16 pf-execute"></i></button>'
            }
        ]
    };
    
    vm.ExecReceipt = function () {
        var grid = vm.ArchGrid,
            selectedItem = grid.dataItem(grid.select()),
            url = bars.config.urlContent('/way/ArchiveFiles/LoadFile');

        if (selectedItem == null) { bars.ui.alert({ text: 'Оберіть файл!' }); return;}
        window.open(url + '?fileid=' + selectedItem.ID);
    };  

}]);