angular.module('BarsWeb.Controllers', [])
.controller('EditingFinesDFO', ['$scope', '$http', function ($scope, $http) {

    //инициализируем дробдаун боксы
    $scope.InitValues = function () {
        $scope.TypesShost = $scope.GetTypes("shost");//по первиному залишку, по істориї
        $scope.TypesShsrok = $scope.GetTypes("shsrok");
        $scope.TypesShtype = $scope.GetTypes("shtype");
        $scope.TypesShterm = $scope.GetTypes("shterm");
    };

    $('#mydiv').hide();
    $scope.type_fine_depend = false;
    $scope.term_fine_depend = false;
    $scope.ifsh_proc = false;

    var boolInit = true;
    $scope.rowstodelete = [];


    //очищаем откно редактирования 
    $scope.ClearEditForm = function () {
        angular.element("#type_fine").removeAttr("disabled");
        angular.element("#term_fine").removeAttr("disabled");
        $('#ifsh_proc').prop('checked', false);
        //$('#type_fine_depend').prop('checked', false);
        //$('#term_fine_depend').prop('checked', false);
        $scope.type_fine_depend = false;
        $scope.term_fine_depend = false;
        $scope.GetColumnsEditGrid();
    }

    //считываем значения чекбокса для добавления столбцо
    $scope.AddColumns = function (type) {
        debugger;
        if (type === "type_fine") {
            $scope.type_fine_depend = !$scope.type_fine_depend;
            if ($scope.type_fine_depend) {
                angular.element("#type_fine").data("kendoDropDownList").enable(!$scope.type_fine_depend);
            }
            else {
                angular.element("#type_fine").data("kendoDropDownList").enable(!$scope.type_fine_depend);
            }
        }
        else if (type === "term_fine") {
            $scope.term_fine_depend = !$scope.term_fine_depend;
            if ($scope.term_fine_depend) {
                angular.element("#term_fine").data("kendoDropDownList").enable(!$scope.term_fine_depend);
            }
            else {
                angular.element("#term_fine").data("kendoDropDownList").enable(!$scope.term_fine_depend);
            }
        }
        $scope.GetColumnsEditGrid();
    }

    //получаем колонки для грида в форме редактирования OpenWindow('EditWindow')
    $scope.GetColumnsEditGrid = function () {
        debugger;
        //тип штрафа + Тип терміну штрафа + Значення терміну штрафа
        if ($scope.type_fine_depend && $scope.term_fine_depend) {
            $scope.EditGridOptions.columns = [
            {
                field: "IDROW",
                title: "IDROW",
                hidden: true
            },
            {
                field: "ASR",
                title: "С",
                width: '5%'
            },
            {
                field: "BSR",
                title: "По",
                width: '10%',
                format: "{0:0}"
            },
            {
                field: "SH_PROC",
                title: "Тип штрафа",
                editor: categoryDropDown,
                template: '#: GetTypeName(SH_PROC) #'
            },
            {
                field: "K_PROC",
                title: "Значення",
                width: '10%',
                format: "{0:0}"
            },
            {
                field: "SH_TERM",
                title: "Тип терміну штрафа",
                editor: categoryDropDown,
                template: '#: GetTypesShterm(SH_TERM) #'
            },
            {
                field: "K_TERM",
                title: "Значення терміну штрафа"
            }
            ];
        }
            //0
        else if (!$scope.type_fine_depend && !$scope.term_fine_depend) {
            $scope.EditGridOptions.columns = [
                            {
                                field: "IDROW",
                                title: "IDROW",
                                hidden: true
                            },
              {
                  field: "ASR",
                  title: "С"
              },
            {
                field: "BSR",
                title: "По",
                format: "{0:0}"
            },
            {
                field: "K_PROC",
                title: "Значення",
                format: "{0:0}"
            }
            ];
        }
            //тип штрафа 
        else if ($scope.type_fine_depend && !$scope.term_fine_depend) {
            $scope.EditGridOptions.columns = [
                            {
                                field: "IDROW",
                                title: "IDROW",
                                hidden: true
                            },
            {
                field: "ASR",
                title: "С"
            },
            {
                field: "BSR",
                title: "По",
                format: "{0:0}"
            },
            {
                field: "SH_PROC",
                title: "Тип штрафа",
                editor: categoryDropDown,
                template: '#: GetTypeName(SH_PROC) #'
            },
            {
                field: "K_PROC",
                title: "Значення",
                format: "{0:0}"
            }
            ];
        }
            //Тип терміну штрафа + Значення терміну штрафа
        else if (!$scope.type_fine_depend && $scope.term_fine_depend) {
            $scope.EditGridOptions.columns = [
                            {
                                field: "IDROW",
                                title: "IDROW",
                                hidden: true
                            },
            {
                field: "ASR",
                title: "С",
                width: '10%'
            },
            {
                field: "BSR",
                title: "По",
                width: '10%'
            },
            {
                field: "K_PROC",
                title: "Значення",
                format: "{0:0}"
            },
            {
                field: "SH_TERM",
                title: "Тип терміну штрафа",
                editor: categoryDropDown,
                template: '#: GetTypesShterm(SH_TERM) #'
            },
            {
                field: "K_TERM",
                title: "Значення терміну штрафа",
                format: "{0:0}"
            }
            ];
        }
    }

    /*function categoryDropDownor(container, options) {
        $('<input required name="' + options.field + '"/>')
            .appendTo(container)
            .kendoDropDownList({
                autoBind: false,
                dataTextField: "NAME",
                dataValueField: "ID",
                dataSource: $scope.TypesShtype
            });
    }*/
    /*
    $scope.SetTypeValue = function () {
        var type = angular.element("#type_fine").val();
        //angular.element("#type_fine_grid").data('kendoDropDownList').select(parseInt(type));
    };*/

    /*$scope.SetTermValue = function () {
        var term = angular.element("#term_fine").val();
        angular.element("#term_fine_grid").data('kendoDropDownList').select(parseInt(term));
    };*/

    //перечитка грида
    $scope.ReloadEditGrid = function () {
        angular.element("#EditGrid").data('kendoGrid').dataSource.read();
    };
    //перечитка грида
    $scope.ReloadGrid = function () {
        angular.element("#Grid").data('kendoGrid').dataSource.read();
    };

    //получаем настройки для штрафа 
    $scope.GetDataSourceForEditGrid = function (id) {
        return {
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/GetFineData") + "?fineid=" + id
                }
            },
            serverPaging: true,
            serverFiltering: true,
            schema:
                {
                    data: "Data",
                    total: "Total",
                    model:
                        {
                            fields:
                                {
                                    ASR: {
                                        editable: false,
                                        defaultValue: $scope.defaultASR
                                    },
                                    BSR: {
                                        editable: true,
                                        type: 'number',
                                        validation: {
                                            validateTitle: function (input) {
                                                return true;
                                            }
                                        }
                                    },
                                    K_PROC: {
                                        editable: true,
                                        type: 'number',
                                        validation: {
                                            validateTitle: function (input) {
                                                if (input.val().length > 3) {
                                                    var info = "Не більше 3-х значного числа"
                                                    AlertNotifyError(info);
                                                    return false;
                                                }

                                                return true;
                                            }
                                        }
                                    },
                                    SH_PROC: {
                                        editable: true, validation: {
                                            NAME: { type: "number", validation: { required: { message: "Поле обов'язкове для заповнення" } } },
                                        }
                                    },
                                    K_TERM: {
                                        editable: true,
                                        validation: {
                                            validateTitle: function (input) {

                                                if (input.val().length > 3) {
                                                    var info = "Не більше 3-х значного числа"
                                                    AlertNotifyError(info);
                                                    input.attr("data-validateTitle-msg", "Не більше 3-х значного числа");
                                                    return false;
                                                }

                                                return true;
                                            }
                                        }
                                    },
                                    SH_TERM: {
                                        editable: true
                                    }
                                }
                        }
                }
        };
    };

    //получаем данные для грида 
    $scope.GetDataSourceForGrid = function (mod_cod) {
        return {
            async: false,
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/GetDataForGrid") + "?modcode=" + mod_cod
                }
            },
            serverPaging: true,
            serverFiltering: true,
            schema:
                {
                    data: "Data",
                    total: "Total",
                    id: "Grid",
                    model:
                        {
                            fields:
                                {
                                    ID: { type: "number", editable: false },
                                    NAME: { type: "string", validation: { required: { message: "Поле обов'язкове для заопвнення" } } },
                                    term_NAME: { type: "number", validation: { required: { message: "Поле обов'язкове для заопвнення" } } },
                                    rest_NAME: { type: "number", validation: { required: { message: "Поле обов'язкове для заопвнення" } } },
                                    MOD_CODE: {
                                        type: "string",
                                        validation: {
                                            validateTitle: function (input) {
                                                if ((input.is("[name=MOD_CODE]") && input.val() === "DPU") || (input.is("[name=MOD_CODE]") && input.val() === "") || (input.is("[name=MOD_CODE]") && input.val() === "DPT")) {
                                                    return true;
                                                }
                                                required: { message: "DPU або DPT" }
                                            }
                                        }
                                    }
                                }
                        }
                }
        };
    };

    //наполняем грид данными
    $scope.GetDataForGrid = function () {
        $scope.fileType = angular.element("#dropdownlist").val();
        $scope.selected_date = $scope.date;
        $scope.date_selected = true;

        if ($scope.selected_date !== "" && $scope.fileType !== "Виберіть тип файлу") {
            $scope.formFilesReportsGridOptions.dataSource.transport.read.url = bars.config.urlContent("/api/Dpa/RegisterCountsDpaApi/GetDataForFileReport") + "?date=" + $scope.selected_date + "&fileType=" + $scope.fileType;
        }
    };

    //визуально добаляем строку в грид
    $scope.AddRow = function (idrid) {
        $scope.flag = true;
        var grid = angular.element('#' + idrid).data("kendoGrid");
        grid.addRow();
        angular.element(".k-grid-edit-row").appendTo("#grid tbody");
        // $scope.SetDefaultASR();


    }
    //удаляем настройки штрафа
    $scope.RemoveFineSetting = function (ID) {
        $('#mydiv').show();
        var gridElement = angular.element("#EditGrid").data("kendoGrid");
        var rowstodelete = angular.element("#EditGrid").find(".ob-edit-selected").select();
        if (rowstodelete.length != 0) {
            var rows_for_delete = [];
            $.each(rowstodelete, function (index, row) {
                var selectedItem = gridElement.dataItem(row);
                rows_for_delete.push(selectedItem);
            })
            $http({
                url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/DeleteFineSetting"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ rows: rows_for_delete, ID: ID.ID }),
                contentType: "application/json",
                async: false
            }).success(function (data) {
                $scope.ReloadEditGrid("#EditGrid");
                AlertNotifyDel(data);
            }).error(function (error) {
                $('#mydiv').hide();
                //alert("Неможливо видалити запис так як існують налаштування які посилаються на нього");
            });
        }
    };

    //оповещение при удалениях
    AlertNotifyDel = function (data) {
        var popupNotification = $("#popupNotification").kendoNotification({
            position: {
                pinned: true,
                top: null,
                left: 15,
            },
            show: onShow
        }).data("kendoNotification");

        if (data === "null")
            popupNotification.show((kendo.toString("Рядки успішно видаленні")), "info");
        else
            popupNotification.show((kendo.toString(data)), "error");
    }

    //оповещение об ошибке
    AlertNotifyError = function (info) {
        var popupNotification = $("#popupNotification").kendoNotification({
            height: 45,
            position: {
                pinned: true,
                top: null,
                left: 20,
            },
            show: onShow
        }).data("kendoNotification");
        popupNotification.show((kendo.toString(info)), "error");
    }

    //что б окно было - in front of everything
    function onShow(e) {
        e.element.parent().css({
            zIndex: 22222
        });
    }
    // оповещение инфо
    AlertNotifyInfo = function (info) {
        var popupNotification = $("#popupNotification").kendoNotification({ show: onShow }).data("kendoNotification");
        popupNotification.show((kendo.toString(info)), "info");
    }

    //удаляем строки с БД
    $scope.RemoveRowFromDB = function () {
        $('#mydiv').show();
        var gridElement = angular.element("#Grid").data("kendoGrid");
        var rowstodelete = angular.element("#Grid").find(".ob-selected").select();
        if (rowstodelete.length != 0) {
            var rows_for_delete = [];
            $.each(rowstodelete, function (index, row) {
                var selectedItem = gridElement.dataItem(row);
                rows_for_delete.push(selectedItem);
            })
            $scope.ifdel = rows_for_delete.length;
            $http({
                url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/DeleteRow"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ rows: rows_for_delete }),
                contentType: "application/json",
                async: false
            }).success(function (data) {
                AlertNotifyDel(data);
                $('#mydiv').hide();
                $scope.ReloadGrid("#Grid");
            }).error(function (error) {
                $('#mydiv').hide();
                $scope.ReloadGrid("#Grid");
                //alert("Неможливо видалити запис так як існують налаштування які посилаються на нього");
            });
        }
        $scope.ReloadGrid("#Grid");
    };

    //получаем все дробдауны 
    $scope.GetTypes = function (type) {
        $.ajax({
            url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/GetDataForDrop") + "?ddt=" + type,
            method: "GET",
            dataType: "json",
            async: false,
            complete: function (data) {
                $scope.tmp = data.responseJSON;
            }
        });
        return $scope.tmp;
    };

    //открыть диалоговое окно
    $scope.OpenWindow = function (windowName) {
        var gridElement = angular.element("#Grid").data("kendoGrid");
        var row = gridElement.select();
        debugger;
        if (row.length != 0) {
            if (windowName === "EditWindow") {
                $scope.ClearEditForm();
                $scope.ReloadGrid("#EditGrid");

                var selectedItem = gridElement.dataItem(row);
                $scope.selectedItem = gridElement.dataItem(row);//для фун-ции savechengrdeditgrid()
                if (selectedItem.ID || selectedItem.ID === 0) {
                    var ifcheck = $scope.IfCheckBoxs(selectedItem.ID);

                    $scope.title = "№ " + selectedItem.ID + " - " + selectedItem.NAME;
                    $("#EditWindow").kendoWindow();
                    var dialog = $("#EditWindow").data("kendoWindow");
                    dialog.title($scope.title);
                    $scope.EditGridOptions.dataSource = $scope.GetDataSourceForEditGrid(selectedItem.ID);
                    debugger;
                    $("#type_count_rest").data("kendoDropDownList").value(selectedItem.rest_NAME);
                    tmp3 = $scope.TypesShost;
                    $("#term_count_type").data("kendoDropDownList").value(selectedItem.term_NAME);
                    tmp4 = $scope.TypesShsrok;



                    $scope.EditWindow.center().open();
                    if (ifcheck.Data[0].nShTerm_Count > 1) {
                        // $("#term_fine").data("kendoDropDownList").enable(false);
                        $("#term_fine").data("kendoDropDownList").value(null);
                        $scope.term_fine_depend = false;
                        angular.element("#term_fine_depend")[0].checked = true;
                        //$('#term_fine_depend').prop('checked', true);
                    }
                    else {
                        //$("#term_fine").data("kendoDropDownList").enable(true);
                        $scope.term_fine_depend = true;
                        angular.element("#term_fine_depend")[0].checked = false;
                        // $('#term_fine_depend').prop('checked', false);
                    }
                    $scope.AddColumns('term_fine');
                    if (ifcheck.Data[0].nSh_Count > 1) {
                        //$("#type_fine").data("kendoDropDownList").enable(false);
                        $("#type_fine").data("kendoDropDownList").value(null);
                        $scope.type_fine_depend = false;
                        angular.element("#type_fine_depend")[0].checked = true;
                        //$('#type_fine_depend').prop('checked', true);
                    }
                    else {
                        //$("#type_fine").data("kendoDropDownList").enable(true);
                        $scope.type_fine_depend = true;
                        angular.element("#type_fine_depend")[0].checked = false;
                        // $('#type_fine_depend').prop('checked', false);
                    }
                    $scope.AddColumns('type_fine');
                    debugger;
                    $("#type_fine").data("kendoDropDownList").value(ifcheck.Data[0].nSh_Value);
                    var temp1 = $scope.TypesShtype;
                    $("#term_fine").data("kendoDropDownList").value(ifcheck.Data[0].nShTerm_Value);
                    var temp2 = $scope.TypesShterm;

                    if (selectedItem.SH_PROC > 0)
                        $('#ifsh_proc')[0].checked = true;

                }
            }
        }
        else {
            var info = "Жодного рядка не обрано";
            AlertNotifyError(info);
        }
    };

    //получаем значение чек боксов для штрафа
    $scope.IfCheckBoxs = function (id) {
        $.ajax({
            url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/IfCheckBoxs") + "?fineid=" + id,
            method: "GET",
            dataType: "json",
            async: false,
            complete: function (data) {
                $scope.tmp = data.responseJSON;
            }
        });
        return $scope.tmp;
    }

    //закрыть диалоговое окно
    $scope.CloseWindow = function (windowName) {
        if (windowName === "Accept") {
            $scope.AcceptWindow.close();
        }
    };

    //валидация полей
    IsFielsdEmpty = function (row) {

        $scope.type_fine_depend;
        $scope.term_fine_depend;
        if (row.ASR > row.BSR) {
            var info = "Значення С більше чем ПО"
            AlertNotifyError(info);
            return 3;
        }
        if ((row.ASR === "" || row.BSR === "" || row.K_PROC === "" || row.K_PROC === null) && (!$scope.type_fine_depend && !$scope.term_fine_depend))
            return false;
        else if ((row.ASR === "" || row.BSR === "" || row.K_PROC === "" || row.SH_PROC === "") && ($scope.type_fine_depend && !$scope.term_fine_depend))
            return false;
        else if ((row.ASR === "" || row.BSR === "" || row.K_PROC === "" || row.SH_TERM === "" || row.K_TERM === "") && (!$scope.type_fine_depend && $scope.term_fine_depend))
            return false;
        else if ((row.ASR === "" || row.BSR === "" || row.K_PROC === "" || row.SH_PROC === "" || row.K_TERM === "" || row.SH_TERM === "") && ($scope.type_fine_depend && $scope.term_fine_depend))
            return false;
        else
            return true;
    }

    //сохраняем любые изминения в гриде(редактирование и удаляем помеченые трочки как "удалить")
    $scope.SaveChanges = function () {
        // апдейтим если есть отредактированные
        $scope.ifone = false;
        //добавляем если есть добавленные 
        var gridElement = angular.element("#Grid").data("kendoGrid");
        $scope.gridData = gridElement.dataSource.data();
        $('#mydiv').show();
        $.ajax({
            url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/GetData") + "?modcode=" + $scope.mod_cod,
            method: "GET",
            dataType: "json",
            contentType: "application/json",
            async: false,
            complete: function (data) {
                var difference = $scope.gridData.length - data.responseJSON.length;
                // if ($scope.gridData.length !== data.length) {
                $scope.difference = difference;
                if (difference === 1)
                    $scope.ifone = true;
                var insert_array = [];
                for (var i = $scope.gridData.length - 1; i > $scope.gridData.length - difference - 1; i--) {
                    if ($scope.gridData[i].NAME === "" || $scope.gridData[i].term_NAME === "" || $scope.gridData[i].rest_NAME === "") {
                        var info = "Заповніть усі поля";
                        AlertNotifyError(info);
                    }
                    else {
                        insert_array.push($scope.gridData[i]);
                    }
                }
                $http({
                    url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/InsertRow"),
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({ grid: insert_array }),
                    contentType: "application/json",
                    async: false
                }).success(function (data) {
                    //$scope.ReloadGrid("#Grid");
                    $('#mydiv').hide();

                }).error(function (error) {
                    $('#mydiv').hide();
                });
                //  }
            }
        });

        SaveEditedRows();
        $scope.ReloadGrid("#Grid");
    };

    //сохоаням изминения в форме редактирования
    $scope.SaveChangesEditGrid = function (id) {
        //удаляем если есть помеченные как удаленные
        $scope.RemoveFineSetting(id);
        var SH_PROC = "0";
        if ($scope.ifsh_proc)
            var SH_PROC = "1";//id.SH_PROC;


        var ID = id.ID;
        var tmp = 0;
        debugger;
        //добавляем если есть добавленные 
        $scope.gridData = angular.element('#EditGrid').data().kendoGrid.dataSource.view();
        //var gridElement = angular.element("#EditGrid").data("kendoGrid");
        //$scope.gridData = gridElement.dataSource.data();
        $('#mydiv').show();
        var isempty = 0;
        var insert_array = [];

        //id.SH_PROC = SH_PROC;
        var term_count_type = $("#term_count_type").val();
        var type_count_rest = $("#type_count_rest").val();

        var sh_proc_val = $("#type_fine").val();
        var sh_term_val = $("#term_fine").val();

        id.term_NAME = term_count_type;
        id.term_id = term_count_type;
        id.SH_TERM = sh_term_val;

        id.rest_NAME = type_count_rest;
        id.rest_id = type_count_rest;


        id.FL = $("#term_count_type").val();
        id.SH_OST = $("#type_count_rest").val();
        id.SH_PROC = $("#ifsh_proc")[0].checked === true ? 1 : 0;

        var rows_for_update = [];
        rows_for_update.push(id);


        $.ajax({
            url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/GetFineData") + "?fineid=" + id.ID,
            method: "GET",
            dataType: "json",
            contentType: "application/json",
            async: false,
            complete: function (data) {
                var diff = $scope.gridData.length - data.responseJSON.Data.length;
                debugger;
                /*if ($scope.gridData.length == data.responseJSON.Data.length) {
                    tmp = $scope.gridData[0];
                    tmp.ASR = "";
                    tmp.BSR = "";
                    tmp.K_PROC = "";
                    tmp.SH_PROC = "";
                    tmp.K_TERM = "";
                    tmp.SH_TERM = "";
                insert_array.push(tmp);
            }*/

                //  if ($scope.gridData.length !== data.responseJSON.Data.length) {
                $scope.diff = diff;


                changedModels = [];
                for (var i = 0; i < $scope.gridData.length - diff; i++) {
                    if ($scope.gridData[i].dirty) {
                        changedModels.push($scope.gridData[i]);
                        if ($scope.gridData[i].SH_PROC == null || $scope.gridData[i].SH_PROC == "") tmp.SH_PROC = angular.element("#type_fine").val();
                        if ($scope.gridData[i].SH_TERM == null || $scope.gridData[i].SH_TERM == "") tmp.SH_TERM = angular.element("#term_fine").val();
                    }
                }

                for (var i = $scope.gridData.length - 1; i > $scope.gridData.length - diff - 1; i--) {
                    isempty = IsFielsdEmpty($scope.gridData[i]);
                    if (!isempty == 3 || !isempty) {
                        var info = "Заповніть усі поля";
                        AlertNotifyError(info);
                    }
                    else if (isempty && isempty != 3) {
                        tmp = $scope.gridData[i];
                        if ($scope.gridData[i].SH_PROC == null || $scope.gridData[i].SH_PROC == "") tmp.SH_PROC = angular.element("#type_fine").val();
                        if ($scope.gridData[i].SH_TERM == null || $scope.gridData[i].SH_TERM == "") tmp.SH_TERM = angular.element("#term_fine").val();
                        insert_array.push(tmp);
                    }
                }

                $http({
                    url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/UpdateFine"),
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({ grid: changedModels, ID: ID }),
                    contentType: "application/json",
                    async: false
                }).success(function (data) {
                    $('#mydiv').hide();
                }).error(function (error) {
                    $('#mydiv').hide();
                });

                $http({
                    url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/InsertFine"),
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({ grid: insert_array, ID: ID }),
                    contentType: "application/json",
                    async: false
                }).success(function (data) {
                    $('#mydiv').hide();
                }).error(function (error) {
                    $('#mydiv').hide();
                });
                //удаляем если есть помеченные как удаленные
                $scope.RemoveRowFromDB($scope.rowstodelete);
                // }

                $http({
                    url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/UpdateRow"),
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({ rows: rows_for_update }),
                    contentType: "application/json",
                    async: false
                }).success(function (data) {
                    $('#mydiv').hide();
                    $scope.ReloadGrid("#Grid");
                }).error(function (error) {
                    $('#mydiv').hide();
                });
            }

        });
        $scope.ReloadEditGrid("#EditGrid");
        $('#mydiv').hide();
    };

    //находим и отправляем на бек все строки которые были отредактированы
    SaveEditedRows = function () {
        var gridElement = angular.element("#Grid").data("kendoGrid");
        var intimeselected = gridElement.dataItem(gridElement.select());
        var editedrows = angular.element("#Grid").find(".change-background").select();
        if (editedrows.length != 0 || intimeselected) {
            var rows_for_update = [];
            for (var i = 0; i < editedrows.length - $scope.difference; i++) {
                var selectedItem = gridElement.dataItem(editedrows[i]);
                rows_for_update.push(selectedItem);
            }
            rows_for_update.push(intimeselected);
            if ($scope.difference != 1 & !$scope.ifone) {
                $http({
                    url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/UpdateRow"),
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({ rows: rows_for_update }),
                    contentType: "application/json",
                    async: false
                }).success(function (data) {
                    $('#mydiv').hide();
                    $scope.ReloadGrid("#Grid");
                }).error(function (error) {
                    $('#mydiv').hide();
                });
            }
        }
    }

    //красим строчки которые были отредактированы
    CororizeDirty = function (data) {
        var dataSource = $("#Grid").data("kendoGrid").dataSource,
        data = dataSource.data(),
        changedModels = [];
        //ДОДЕЛАТЬ ЗАКРАСКУ ЄДИТА 
        if (dataSource.hasChanges) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].dirty) {
                    changedModels.push(data[i]);
                }
            }
        }
        var tr = [];
        for (var i = 0; i < changedModels.length; i++) {

            var element = $('tr[data-uid="' + changedModels[i].uid + '"] ');
            angular.element(element).addClass("change-background");
        }
        /*for (var i = 0; i < changedModels.length; i++) {

            var element = $('tr[data-uid="' + changedModels[i].uid + '"] ');
            angular.element(element).addClass("change-background");
        }*/
    }

    //красим сторчки в красный(для удаления) и серый цвет(отредактированые) 
    $scope.MarkAsDelete = function (idgrid) {
        var grid = $("#" + idgrid).data("kendoGrid");
        var rows = grid.select();
        var gridElement = angular.element("#" + idgrid).data("kendoGrid");

        var gridData = gridElement.dataSource.data();
        var rows = gridElement.select();
        if (idgrid === "Grid")
            rows.addClass("ob-selected");
        else
            rows.addClass("ob-edit-selected");
        if (rows.length != 0) {
            rows.each(function (index, row) {
                var selectedItem = gridElement.dataItem(row);
                selectedItem.status = 0;
            });
            var gridData1 = gridElement.dataSource.data();
        }
        else {
            var info = "Жодного рядка не обрано";
            AlertNotifyError(info);
        }
        rows.removeAttr("k-state-selected");
    };

    //в зависимости от read_only кнопки доступны или недоступны
    MakeButtonsDisable = function () {
        $("#table_row-add").kendoButton({
            enable: false,
        });
        $("#delete").kendoButton({
            enable: false
        });
        $("#button").kendoButton({
            enable: false
        });
        $("#save").kendoButton({
            enable: false
        });
        $("#arrow_downloadd").kendoButton({
            enable: false
        });
        $("#tablerowadd2").kendoButton({
            enable: false
        });
        $("#editdelete").kendoButton({
            enable: false
        });
    };

    //печатаем грид
    $scope.printGrid = function () {
        var gridElement = $('#Grid');
        printableContent = '';
        win = window.open('', '', 'width=800, height=500');
        doc = win.document.open();

        var htmlStart =
                '<!DOCTYPE html>' +
                '<html>' +
                '<head>' +
                '<meta charset="utf-8" />' +
                '<title>Штрафи ДФО</title>' +
                '<link href="http://kendo.cdn.telerik.com/' + kendo.version + '/styles/kendo.common.min.css" rel="stylesheet" /> ' +
                '<style>' +
                'html { font: 11pt sans-serif; }' +
                '.k-grid { border-top-width: 0; }' +
                '.k-grid, .k-grid-content { height: auto !important; }' +
                '.k-grid-content { overflow: visible !important; }' +
                '.k-grid .k-grid-header th { border-top: 1px solid; }' +
                '.k-grid-toolbar, .k-grid-pager > .k-link { display: none; }' +
                '</style>' +
                '</head>' +
                '<body>';

        var htmlEnd =
                '</body>' +
                '</html>';

        var gridHeader = gridElement.children('.k-grid-header');
        if (gridHeader[0]) {
            var thead = gridHeader.find('thead').clone().addClass('k-grid-header');
            printableContent = gridElement
                .clone()
                    .children('.k-grid-header').remove()
                .end()
                    .children('.k-grid-content')
                        .find('table')
                            .first()
                                .children('tbody').before(thead)
                            .end()
                        .end()
                    .end()
                .end()[0].outerHTML;
        } else {
            printableContent = gridElement.clone()[0].outerHTML;
        }

        doc.write(htmlStart + printableContent + htmlEnd);
        doc.close();
        win.print();
    }

    //основной Грид
    $scope.GridOptions = function (read_only, mod_cod) {
        if (read_only == 1) { MakeButtonsDisable(); }
        $scope.mod_cod = mod_cod;
        return {
            toolbar: [
                 {
                     name: "Addnewrow",
                     text: "Add new row",
                     template: ' <button id="table_row-add" class="k-button" ng-click="AddRow(\'Grid\')"  title="Додати новий рядок"><img src="/barsroot/Content/images/PureFlat/16/table_row-add2.png" width="20" height="20" /></button>'
                 },
                {
                    name: "delete",
                    text: "delete",
                    template: '<button id="delete" class="k-button" ng-click="MarkAsDelete(\'Grid\')" title="Помитити для видалення"><img src="/barsroot/Content/images/PureFlat/16/delete.png" width="20" height="20" /></button>'
                },
                {
                    name: "reload_rotate",
                    text: "reload_rotate",
                    template: '<button id="reload_rotate" class="k-button" " ng-click="ReloadGrid()" title="Оновити данні"><img src="/barsroot/Content/images/PureFlat/16/reload_rotate.png" width="20" height="20" /></button>'
                },
                {
                    name: "excel",
                    text: "",
                    template: '<a title="Завантажити" class="k-button k-button-icontext k-grid-excel"><img title="Завантажити" src="/barsroot/Content/images/PureFlat/16/arrow_download.png" width="20" height="20" /> </a>'
                },
                {
                    name: "save",
                    text: "save",
                    template: ' <button id="save" class="k-button" ng-click="SaveChanges()" title="Зберегти зміни" style="margin-left:15px;"><img src="/barsroot/Content/images/PureFlat/16/save.png" width="20" height="20" /></button>'
                },
                {
                    name: "folder_open",
                    text: "folder_open",
                    template: '<button id="folder_open" class="k-button" ng-click="OpenWindow(\'EditWindow\')" title="Відкрити вікно редагування"><img src="/barsroot/Content/images/PureFlat/16/folder_open.png" width="20" height="20" /></button>'
                },
                {
                    name: "print",
                    text: "print",
                    template: '<button id="print" class="k-button" ng-click="printGrid()" title="Друкувати"> <img src="/barsroot/Content/images/PureFlat/16/print.png" width="20" height="20" /></button>'
                },


            ],
            excel: {
                allPages: true,
                fileName: "DFO_Penalty.xlsx",
                proxyURL: bars.config.urlContent("/DptAdm/EditFinesDFO/ExcelExport")
            },
            dataSource: $scope.GetDataSourceForGrid(mod_cod),
            selectable: "multiple",
            filterable: true,
            scrollable: false,
            editable: { createAt: "bottom" },
            /*pageable: {
                refresh: true,
                pageSizes: true,
                buttonCount: 5
            },*/

            edit: function () {
                CororizeDirty();
            },
            dataBound: function () {
            },
            change: function () {
                $("#Grid").on("dblclick", "tr.k-state-selected", function () {
                    $scope.ReloadGrid("#EditGrid");
                    $scope.OpenWindow('EditWindow');
                });
                /*var tr = angular.element.find('.k-dirty-cell.ng-scope');
                var ch = $('#Grid').data('kendoGrid').dataSource.hasChanges();
                var data = $('#Grid').data('kendoGrid').dataSource.data();*/
                CororizeDirty();
            },
            columns: [
                {
                    field: "IDROW",
                    hidden: true,
                },
                {
                    field: "ID",
                    title: "№ штрафа",
                },
                {
                    field: "SH_PROC",
                    title: "галочка",
                    hidden: true
                },
                {
                    field: "NAME",
                    title: "Назва штрафа"
                },
                {
                    field: "term_NAME",
                    title: "Період заданий",
                    editor: categoryDropDown,
                    template: '#: GetTermName(term_NAME) #'
                },

                {
                    field: "rest_NAME",
                    title: "Тип обрахунку залишку",
                    editor: categoryDropDown,
                    template: '#: GetTypeShost(rest_NAME) #'
                },
                {
                    field: "MOD_CODE",
                    title: "Код модуля",
                },
                {
                    field: "term_id",
                    title: "Код модуля",
                    hidden: true
                },
                {
                    field: "rest_id",
                    title: "Код модуля",
                    hidden: true
                }
            ],
            srollable: true

        }

    }

    //возращает строки для дропдаунов
    function categoryDropDown(container, options) {

        var data = "";
        if (options.field === 'term_NAME')
            data = $scope.TypesShsrok;
        else if (options.field === 'rest_NAME')
            data = $scope.TypesShost;
        else if (options.field === 'SH_PROC')
            data = $scope.TypesShtype;
        else if (options.field === 'SH_TERM')
            data = $scope.TypesShterm;


        $('<input required name="' + options.field + '"/>')
            .appendTo(container)
            .kendoDropDownList({
                dataTextField: "NAME",
                dataValueField: "ID",
                dataSource:
                    {
                        data: data
                    }
            });
    }

    ///FOR GRID
    //возрвщвет имя по числу для дробдауна(shsrok)
    GetTypeShost = function (value) {
        $scope.tmp = value;

        for (var i = 0; i < $scope.TypesShost.length; i++) {
            if (parseInt($scope.TypesShost[i].ID) === parseInt(value)) {
                $scope.tmp = $scope.TypesShost[i].NAME;
            }
            if (value === null || value === "") {
                $scope.tmp = "";
            }
        }

        return $scope.tmp;
    };

    //возрвщвет имя по числу для дробдауна(shsrok)
    GetTermName = function (value) {
        $scope.tmp = value;

        for (var i = 0; i < $scope.TypesShsrok.length; i++) {
            if (parseInt($scope.TypesShsrok[i].ID) === parseInt(value)) {
                $scope.tmp = $scope.TypesShsrok[i].NAME;
            }
            if (value === null || value === "") {
                $scope.tmp = "";
            }
        }

        return $scope.tmp;
    };


    ///FOR SETTINGS
    //возрвщвет имя по числу для дробдауна(shtype/SH_PROC)
    GetTypeName = function (value) {
        $scope.tmp = value;

        for (var i = 0; i < $scope.TypesShtype.length; i++) {
            if (parseInt($scope.TypesShtype[i].ID) === parseInt(value)) {
                $scope.tmp = $scope.TypesShtype[i].NAME;
            }
            if (value === null || value === "") {
                $scope.tmp = "";
            }
        }
        return $scope.tmp;
    };

    //возрвщвет имя по числу для дробдауна(SH_TERM/TypesShterm)
    GetTypesShterm = function (value) {//value .id
        $scope.tmp = value;
        var idvalue = value;
        if ((typeof (value) === 'object') && value != null)
            idvalue = value.ID;

        for (var i = 0; i < $scope.TypesShterm.length; i++) {
            if (parseInt($scope.TypesShterm[i].ID) === parseInt(idvalue)) {
                $scope.tmp = $scope.TypesShterm[i].NAME;
            }
            if (idvalue === null || idvalue === "") {
                $scope.tmp = "";
            }
        }
        return $scope.tmp;
    };

    //Грид в форме редактирования
    $scope.EditGridOptions = {
        dataSource: {},
        selectable: "multiple",
        editable: { createAt: "bottom" },
        dataBound: function () {
            // $scope.SetDefaultASR();
            //$scope.defaultASR = $scope.defaultASR2;

            if ($scope.flag) {
                var grid = angular.element("#EditGrid").data("kendoGrid");
                var gridData = grid.dataSource.data();
                if (gridData.length != 1)
                    grid.dataItem(grid.table.find("tr[data-uid='" + gridData[gridData.length - 1].uid + "']")).ASR = grid.dataItem(grid.table.find("tr[data-uid='" + gridData[gridData.length - 2].uid + "']")).BSR;
                else
                    grid.dataItem(grid.table.find("tr[data-uid='" + gridData[gridData.length - 1].uid + "']")).ASR = 0;
                $scope.flag = false;
            }
        },
        columns: [
            {
                field: "IDROW",
                title: "IDROW",
                hidden: true
            },
            {
                field: "ASR",
                title: "С",
            },
            {
                field: "BSR",
                title: "По",
            },
            {
                field: "K_PROC",
                title: "Значення",
            }
        ],
        height: 225,
        srollable: true
    }

}]);