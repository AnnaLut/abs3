var AdvertisingModule = angular.module('Advertising', ['kendo.directives']);
AdvertisingModule.factory('httpResponseInterceptor', [
    '$q', '$location', function($q) {
        return {
            response: function (response) {
                if (response.status === 401 || response.statusText == '401') {
                    document.location.reload();
                }
                return response || $q.when(response);
            },
            responseError: function(rejection) {
                if (rejection.status === 401 || rejection.statusText == '401') {
                    document.location.reload();
                }
                if (rejection.status === 400 || rejection.status === 500 || rejection.statusText == 'BRS-500') {
                    bars.ui.loader('body', false);
                    var text;
                    if (rejection.data.Message) {
                        text = rejection.data.Message;
                        if (rejection.data.ExceptionMessage) {
                            text += '<br/>' + rejection.data.ExceptionMessage;
                        }
                    } else {
                        text = rejection.data;
                    }
                    bars.ui.error({ text: text });
                }
                return $q.reject(rejection);
            }
        }
    }
]);
AdvertisingModule.config(['$httpProvider', function ($httpProvider) {
    //Http Intercpetor to check auth failures for xhr requests
    $httpProvider.interceptors.push('httpResponseInterceptor');
}]);

AdvertisingModule.controller('AdvertisingCtrl', function ($scope, $http) {
    $scope.Title = 'Адміністрування рекламних повідомлень';
    $scope.appName = '/barsroot';
    $scope.apiUrl = $scope.appName + '/api/doc/advertising/';

    $scope.advertising = {};
    $scope.getNewAdvertising = function () {
        var date = new Date();
        return {
            Id: null,
            Name: null,
            DateBegin: new Date(date.setHours(0,0,0)),
            DateEnd: new Date(date.setHours(23, 59, 0)),
            DataBodyHtml: null,
            IsActive: 'Y',
            Description: null,
            UserId: null,
            //Branch: '',//$scope.BranchList.dataItem($scope.BranchList.selectedIndex).Branch,
            BranchList: [],
            TransactionCodeList: null,
            IsDefault: 'N',
            Kf: null,
            Type: 1
        }
    }

    $scope.toolbarOptions = {
        items: [
            {
                type: "button",
                text: '<i class="pf-icon pf-16 pf-add_button"></i>Створити',
                click: function () {
                    $scope.showAdd();
                }
            },
            {
                type: "button",
                text: '<i class="pf-icon pf-16 pf-tool_pencil"></i>Редагувати',
                click: function () {
                    $scope.showEdit();
                }
            },
            {
                type: "button",
                text: '<i class="pf-icon pf-16 pf-delete_button_error"></i>Видалити',
                click: function () {
                    $scope.showDelete();
                }
            },
            { type: "separator" },
            {
                template: '<label ><input type="checkbox" data-ng-model="adversitingGridOptions.showNotActive" /> показувати неактивні</label>'
            }
        ]
    };

    $scope.selectedRow = function () {
        return $scope.adversitingGrid.dataItem($scope.adversitingGrid.select());
    };

    $scope.showEdit = function () {
        var data = $scope.selectedRow();
        if (!data) {
            bars.ui.error({ text: 'Не вибрано жодного рядка для редагування' });
        } else {
            bars.ui.loader('#advertisingWindow', true);
            $scope.advertising = {};

            $http.get($scope.apiUrl + data.Id).then(function (request) {
                $scope.advertising = request.data;
                bars.ui.loader('#advertisingWindow', false);
            });

            $scope.advertisingWindow.center().open();
        }
    }
    $scope.showAdd = function () {
        //var date = new Date();
        bars.ui.loader('#advertisingWindow', true);
        $scope.advertising = $scope.getNewAdvertising();

        $http.get($scope.apiUrl + 0).then(function () {
            bars.ui.loader('#advertisingWindow', false);
            //$scope.advertising = $scope.getNewAdvertising();
        });
        $scope.advertisingWindow.center().open();
    };
    $scope.showDelete = function () {
        var data = $scope.selectedRow();
        if (!data) {
            bars.ui.error({ text: 'Не вибрано жодного рядка для видалення' });
        } else {
            bars.ui.confirm({ text: 'Ви дійсно бажаєте видалити повідомлення №' + data.Id },
                function () {
                    $scope.deleteAdv(data.Id);
                });
        }
    };

    $scope.save = function () {
        var validate = validateAdvt();
        if ($scope.advertising.Id == null) {
            if (validate.status == true) {
                $scope.add();
            } else {
                bars.ui.error({ text: validate.message });
            }
        } else {
            if (validate.status == true) {
                $scope.edit();
            } else {
                bars.ui.error({ text: validate.message });
            }
        }
    };
    $scope.add = function () {
        bars.ui.loader('#advertisingWindow', true);
        var data = $scope.advertising;
        data.DateBegin = $scope.StringToDate(data.DateBegin);
        data.DateEnd = $scope.StringToDate(data.DateEnd);
        if (data.Type != 1) {
            data.DataBodyHtml = null;
        }
        $http.put($scope.apiUrl, data)
            .success(function (request) {
                bars.ui.loader('#advertisingWindow', false);
                $scope.advertisingWindow.close();
                bars.ui.notify('Оголошення створено. № ' + request.Id, '', 'success');
                $scope.adversitingGrid.dataSource.read();
                $scope.adversitingGrid.refresh();
            });
    };
    $scope.edit = function () {
        bars.ui.loader('#advertisingWindow', true);
        var data = $scope.advertising;
        data.DateBegin = $scope.StringToDate(data.DateBegin);
        data.DateEnd = $scope.StringToDate(data.DateEnd);
        if (data.Type != 1) {
            data.DataBodyHtml = null;
        }
        $http.post($scope.apiUrl, data)
            .success(function () {
                bars.ui.loader('#advertisingWindow', false);
                $scope.advertisingWindow.close();
                bars.ui.notify('Зміни збережено', '', 'success');
                $scope.adversitingGrid.dataSource.read();
                $scope.adversitingGrid.refresh();
            });
    };

    /*$scope.onChangeDateBegin = function () {
        $scope.advertising.DateBegin = '/Date(' + ($scope.advertising.DateBegin.getTime() + (new Date().getTimezoneOffset() * 60000)) + ')/';
    };

    $scope.onChangeDateEnd = function () {
        $scope.advertising.DateEnd = '/Date(' + $scope.advertising.DateEnd.getTime() + (new Date().getTimezoneOffset() * 60000)) + ')/';
    };*/

    $scope.StringToDate = function (string) {
        /*if (typeof string === 'string' && string.length == 10) {
            var array = string.split('/');
            if (array.length == 3) {
                string = new Date(array[2], parseInt(array[1], 10) - 1, parseInt(array[0], 10) + 1);
                console.log(string);
            }
        }*/
        return string;
    };
    $scope.deleteAdv = function (id) {
        $http({
            method: 'DELETE',
            url: $scope.apiUrl + '?id=' + id
        }).success(function () {
            bars.ui.notify('Оголошення № ' + id + ' видалено', '', 'success');
            $scope.adversitingGrid.dataSource.read();
            $scope.adversitingGrid.refresh();
        });

        /*$http.delete($scope.apiUrl + id)
            .success(function () {
                bars.ui.notify('Оголошення № ' + id + ' видалено', '', 'success');
                $scope.adversitingGrid.dataSource.read();
                $scope.adversitingGrid.refresh();
            })
            .error(function(request) {
                bars.ui.error({ text: request.Message + '<br/>' + request.ExceptionMessage  });
            });*/
    };
    /*$scope.editorTitle = $scope.advertising.Id == null ?
        'Створення нового повідомлення':
        'Редагування повідомлення № ' + $scope.advertising.Id;*/

    $scope.editorTitle = function () {
        if ($scope.advertising.Id == null) {
            return 'Створення нового повідомлення';
        } else {
            return 'Редагування повідомлення № ' + $scope.advertising.Id;
        }
    }

    $scope.showTtsHandBook = function () {
        bars.ui.handBook('TTS', function (data) {
            $scope.advertising.TransactionCodeList = $(data).map(function () {
                return this.Id;
            }).get().toString();
            $scope.$apply(); 
        },
        {
            multiSelect: true,
            clause: "substr(flags, 63, 1)='0'"
        });
    }

    $scope.showBranchHandBook = function() {
        bars.ui.handBook('v_user_branches', function (data) {
            $scope.advertising.BranchList = $(data).map(function () {
                return this.Id;
            }).get();
            $scope.$apply(); 
        },
        {
            multiSelect: true,
            clause: "date_closed is null"
        });
    };

    $scope.advertisingWindowOptions = {
        animation: false,
        visible: false,
        width: "650px",
        actions: ["Maximize", "Minimize", "Close"],
        draggable: true,
        height: "700px",
        modal: true,
        pinned: false,
        resizable: true,
        title: '',
        position: 'center',
        close: function () {
            $scope.advertising = $scope.getNewAdvertising();
        },
        iframe: false
    };

    /*$scope.BranchListOptions = {
        dataSource: {
            type: 'webapi',
            //serverFiltering: true,
            transport: {
                read: {
                    dataType: 'json',
                    url: $scope.appName + '/Doc/Advertising/GetBranches/'
                }
            }
        },
        dataTextField: 'Branch',
        dataValueField: 'Branch',
        filter: 'contains'
    }*/

    var adversitingGridDataBound = function (e) {
        var grid = e.sender;
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper)
                .find('tbody')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">'+grid.pager.options.messages.empty+' :(</td></tr>');
        }
    };

    $scope.adversitingGridOptions = {
        //toolbar: ["pdf",'excel'],
        showNotActive: false,
        dataSource: {
            type: 'webapi',
            sort: {
                field: "Id",
                dir: "desc"
            },
            transport: {
                read: {
                    url: $scope.apiUrl,
                    dataType: 'json',
                    data: { showNotActive: function () { return $scope.adversitingGridOptions.showNotActive; } }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    fields: {
                        Id: { type: 'number' },
                        Name: { type: 'string' },
                        DateBegin: { type: 'date' },
                        DateEnd: { type: 'date' },
                        DataBodyHtml: { type: 'string' },
                        IsActive: { type: 'string' },
                        Description: { type: 'string' },
                        UserId: { type: 'string' },
                        Branch: { type: 'string' },
                        TransactionCodeList: { type: 'string' },
                        IsDefault: { type: 'string' },
                        Kf: { type: 'string' }
                    }
                }
            },
            pageSize: 10,
            serverPaging: true,
            serverSorting: true
        },
        sortable: true,
        filterable: true,
        selectable: "multiple",
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        /*dataBound: function() {
            this.expandRow(this.tbody.find("tr.k-master-row").first());
        },*/
        dataBound: adversitingGridDataBound,
        columns: [
            {
                field: "Id",
                title: "ID",
                width: "70px"
            }, {
                field: "Name",
                title: "Назва",
                width: "120px"
            }, {
                field: "DateBegin",
                title: "Початок дії",
                format: '{0:dd/MM/yyyy HH:mm}',
                width: "120px"
            }, {
                field: "DateEnd",
                title: "Кінець дії",
                format: '{0:dd/MM/yyyy HH:mm}',
                width: "120px"
            }, {
                field: "IsActive",
                title: "Пр. активності",
                width: "120px",
                template: '<input type="checkbox" #= (IsActive == "Y") ? "checked=checked" : "" # disabled="disabled" >'
            }, {
                field: "Branch",
                title: "Відділення",
                width: "150px"
            }, {
                field: "TransactionCodeList",
                title: "Список операцій",
                width: "120px"
            }, {
                field: "IsDefault",
                title: "Пр. рек. по замовч.",
                width: "120px",
                template: '<input type="checkbox" #= (IsDefault == "Y") ? "checked=checked" : "" # disabled="disabled" >'
            }
        ]
    };
    $scope.editorOptions = {
        tools: [
            "formatting",
            "bold",
            "italic",
            "underline",
            "strikethrough",
            "justifyLeft",
            "justifyCenter",
            "justifyRight",
            "justifyFull",
            "insertUnorderedList",
            "insertOrderedList",
            "indent",
            "outdent",
            "createLink",
            "unlink",
            "insertImage",
            {
                name: "imageBase64",
                template: '<a style="width:60px" title="вставка картинки в Base64" class="k-tool k-button k-group-start k-group-end" role="button" href="" unselectable="on"><span class=" k-imageBase64" unselectable="on">Base64</span></a>',
                tooltip: "вставка картинки в Base64",
                exec: function () {
                    $scope.showImageEditorWindow();
                }
            },
            //"insertFile",
            "subscript",
            "superscript",
            "createTable",
            "addRowAbove",
            "addRowBelow",
            "addColumnLeft",
            "addColumnRight",
            "deleteRow",
            "deleteColumn",
            //"foreColor",
            //"backColor",
            "viewHtml",
            "cleanFormatting",
            "fontName",
            "fontSize"
        ]/*,
            imageBrowser: {
                messages: {
                    dropFilesHere: "Drop files here"
                },
                transport: {
                    read: "/kendo-ui/service/ImageBrowser/Read",
                    destroy: {
                        url: "/kendo-ui/service/ImageBrowser/Destroy",
                        type: "POST"
                    },
                    create: {
                        url: "/kendo-ui/service/ImageBrowser/Create",
                        type: "POST"
                    },
                    thumbnailUrl: "/kendo-ui/service/ImageBrowser/Thumbnail",
                    uploadUrl: "/kendo-ui/service/ImageBrowser/Upload",
                    imageUrl: "/kendo-ui/service/ImageBrowser/Image?path={0}"
                }
            },
            fileBrowser: {
                messages: {
                    dropFilesHere: "Drop files here"
                },
                transport: {
                    read: "/kendo-ui/service/FileBrowser/Read",
                    destroy: {
                        url: "/kendo-ui/service/FileBrowser/Destroy",
                        type: "POST"
                    },
                    create: {
                        url: "/kendo-ui/service/FileBrowser/Create",
                        type: "POST"
                    },
                    uploadUrl: "/kendo-ui/service/FileBrowser/Upload",
                    fileUrl: "/kendo-ui/service/FileBrowser/File?fileName={0}"
                }
            }*/
    };

    var validateAdvt = function () {
        var result = {
            status: true,
            message: ''
        };
        if ($scope.advertising.Name == '' || $scope.advertising.Name == null) {
            result.status = false;
            result.message += 'Незаповнено поле Назва<br/>';
        }
        if ($scope.advertising.DateBegin == '' || $scope.advertising.DateBegin == null) {
            result.status = false;
            result.message += 'Незаповнено поле Початок дії<br/>';
        }
        if ($scope.advertising.DateEnd == '' || $scope.advertising.DateEnd == null) {
            result.status = false;
            result.message += 'Незаповнено поле Кінець дії<br/>';
        }
        if ($scope.advertising.BranchList == null || $scope.advertising.BranchList.length == 0 ) {
            result.status = false;
            result.message += 'Незаповнено поле Відділення<br/>';
        }
        if ($scope.advertising.TransactionCodeList == null || $scope.advertising.TransactionCodeList == '') {
            result.status = false;
            result.message += 'Незаповнено поле Список операцій<br/>';
        }
        return result;
    }



    $scope.advertisingImage = {
        Width: 220,
        Height: 130
    };
    $scope.imageEditorWindowOptions = {
        visible: false,
        width: "600px",
        animation: false,
        actions: ["Refresh", "Maximize", "Minimize", "Close"],
        draggable: true,
        height: "650px",
        modal: true,
        pinned: false,
        resizable: true,
        title: '',
        position: 'center',
        iframe: false,
        content: $scope.appName + '/doc/advertising/imageeditor/'
    };
    $scope.showImageEditorWindow = function () {
        $scope.imageEditorWindow.center().open();
        $scope.imageEditorWindow.refresh(/*{
                url: $scope.appName + '/doc/advertising/imageeditor/'
            }*/);
    };
    $scope.saveImageUrl = function () {
        var height = document.getElementById('dataHeight').value;
        var width = document.getElementById('dataWidth').value;
        var dataUrl = $("#imageCropper").cropper("getDataURL", {
            width: width,
            height: height
        });
        if (dataUrl) {
            $scope.advertisingEditor.exec("inserthtml", { value: '<img src="' + dataUrl + '" alt="" width="' + width + '" height="' + height + '" />' });
        }
        $scope.imageEditorWindow.close();
    }
});