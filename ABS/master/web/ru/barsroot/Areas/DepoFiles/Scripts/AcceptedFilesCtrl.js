angular.module('BarsWeb.Controllers')
    .controller('AcceptedFiles', ['$scope', function ($scope) {
        $scope.copy_or_delete = {};
        $scope.Init = function (gb, delet)
        {
            if (gb !== "")
                $scope.gb = true;
            else 
                $scope.gb = false;

            debugger;
            if (delet !== "")
                $("#btDelete").attr("disabled", "disabled");
            else
                $("#btDelete").hide();
        }
        $scope.mainGridOptions = {
            toolbar: [{ name: 'excel', text: 'Вивантажити в Excel' }],
            excel: {
                fileName: "Прийняті файли зарахувань.xlsx"
            },
            dataSource: {
                type: 'webapi',
                transport: {
                    dataType: "json",
                    read: {
                        url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/GetAcceptedFiles")
                    }
                },
                requestStart: function () {
                    if ($("#mainGrid").data("kendoGrid").dataSource.data().length < 1)
                        kendo.ui.progress($("#mainGrid"), true);
                },
                requestEnd: function () {
                    if ($("#mainGrid").data("kendoGrid").dataSource.data().length < 1)
                        kendo.ui.progress($("#mainGrid"), false);
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            HEADER_ID: { type: 'number' },
                            FILENAME: { type: 'string' },
                            DAT: { type: 'date' },
                            INFO_LENGTH: { type: 'number' },
                            SUM: { type: 'string' },
                            NAZN: { type: 'string' },
                            BRANCH: { type: 'string' }
                        }
                    }
                },
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true
            },
            change: function(e)
            {
                var grid = $("#mainGrid").data("kendoGrid");
                var selectedItem = grid.dataItem(grid.select());
                if (selectedItem.FILENAME[0] == ".")
                    can_copy = 1;
                else
                    can_copy = 0;
                S_A(selectedItem.uid, selectedItem.HEADER_ID, can_copy, selectedItem.FILENAME, selectedItem.DAT, selectedItem.CAN_DELETE);
            },
            columns: [
                {
                    width: "4%",
                    template: '<input type="image" class="pf-icon pf-16 pf-folder_open" ng-click="GetFileExt(\'${FILENAME}\', \'${DAT}\', ${HEADER_ID})"/>'
                },
                {
                    title: "Id файлу",
                    field: "HEADER_ID",
                    width: "9%"
                },
                {
                    title: "Ім'я файлу",
                    field: "FILENAME",
                    width: "14%"
                },
                {
                    title: "Дата",
                    field: "DAT",
                    template: "#= kendo.toString(kendo.parseDate(DAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: "9%"
                },
                {
                    title: "К-сть платежів",
                    field: "INFO_LENGTH",
                    width: "12%"
                },
                {
                    title: "Сума",
                    field: "SUM",
                    width: "14%"
                },
                {
                    title: "Призначення",
                    field: "NAZN",
                    width: "19%"
                },
                {
                    title: "Відділення",
                    field: "BRANCH",
                    width: "19%"
                }
            ],
            sortable: true,
            filterable: true,
            resizable: true,
            selectable: "single",
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100, 200],
                buttonCount: 5
            },
        }

        function S_A(id, header_id, can_copy, filename, dat, can_delete) {
            debugger;
            if (can_copy == 0) {
                $('#btCopy').attr("disabled", "disabled");
            }
            else {
                $('#btCopy').removeAttr("disabled");
            }

            if ($scope.gb) {
                if (can_delete == 1) {
                    $('#btDelete').attr("disabled", "disabled");
                }
                else {
                    $('#btDelete').removeAttr("disabled");
                }
            }
            date = kendo.toString(kendo.parseDate(new Date(dat), 'yyyy-MM-dd'), 'dd/MM/yyyy');
            $scope.copy_or_delete = {
                header_id: header_id,
                filename: filename,
                dat: date
            };
        }

        $scope.Copy = function ()
        {
            $.ajax({
                url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/Copy") + "?header_id=" + $scope.copy_or_delete.header_id,
                method: "GET",
                dataType: "json",
                async: false,
                success:
                        function (data) {
                            header_id = data;
                            $scope.CopyFile($scope.copy_or_delete.filename, $scope.copy_or_delete.dat, header_id);
                        }
            });
        }

        $scope.Delete = function () {
            $.ajax({
                url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/Delete") + "?header_id=" + $scope.copy_or_delete.header_id,
                method: "GET",
                dataType: "json",
                async: false,
                success:
                        function (data) {
                            $("#mainGrid").data("kendoGrid").dataSource.read();
                            bars.ui.success({ text: data });
                        }
            });
        }

        $scope.GetFileExt = function (filename, dat, header_id) {
            inject = "";
            if ($scope.gb)
            {
                inject = "&gb=true";
            }
            date = kendo.toString(kendo.parseDate(new Date(dat), 'yyyy-MM-dd'), 'dd/MM/yyyy');
            var url = '/barsroot/depofiles/depofiles/acceptfile' + "?mode=" + "showfile" + '&filename=' + filename + '&dat=' + date + '&header_id=' + header_id + inject;
            location.replace(url);
        }

        $scope.AcceptNewFile = function () {
            inject = "";
            if ($scope.gb) {
                inject = "&gb=true";
            }
            var url = '/barsroot/depofiles/depofiles/acceptfile' + "?mode=" + "acceptnewfile" + inject;
            location.replace(url);
        }

        $scope.CreateNewFile = function () {
            inject = "";
            if ($scope.gb) {
                inject = "&gb=true";
            }
            var url = '/barsroot/depofiles/depofiles/acceptfile' + "?mode=" + "createnewfile" + inject;
            location.replace(url);
        }

        $scope.CopyFile = function (filename, dat, header_id) {
            inject = "";
            if ($scope.gb) {
                inject = "&gb=true";
            }
            var url = '/barsroot/depofiles/depofiles/acceptfile' + "?mode=" + "copy" + '&filename=' + filename + '&dat=' + date + '&header_id=' + header_id + inject;
            location.replace(url);
        }
    }]);