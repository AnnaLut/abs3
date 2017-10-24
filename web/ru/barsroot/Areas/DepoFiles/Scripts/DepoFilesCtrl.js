angular.module('BarsWeb.Controllers')
    .controller('DepoFiles', ['$scope', function ($scope) {
        var dropdown_values = null;
        $scope.temp_file = {};
        $scope.editable_row = {};
        $scope.save_editable_row = {};
        $scope.test = "fsdsdsd";
        $scope.Init = function (filename, header_id, dat, mode, gb) {
            if (gb !== "")
                $scope.gb = true;
            else
                $scope.gb = false;
            angular.element("#file").kendoUpload({
                multiple: false,
                localization: {
                    select: "Вибрати...",
                    headerStatusUploading: "Завантаження",
                    headerStatusUploaded: "Успішно"
                },
                success: onSuccess,
                async: {
                    saveUrl: bars.config.urlContent("/api/depofiles/depofilesapi/UploadToTempDir")
                }
            });
            if (mode === "showfile") {
                $("#file").data("kendoUpload").enable(false);
                $("#idEncodeDos").attr('disabled', 'disabled');
                $("#idEncodeWin").attr('disabled', 'disabled');
                $("#listTypes").attr('disabled', 'disabled');
                $("#listAgencyType").attr('disabled', 'disabled');
                $("#ddAccType").attr('disabled', 'disabled');
                $("#ddMonth").attr('disabled', 'disabled');
                $("#textYear").attr('disabled', 'disabled');
                $("#btUpload").attr('disabled', 'disabled');
                $("#btPay").attr('disabled', 'disabled');
                $("#tbNewHeader").hide();
                $.ajax({
                    url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/GetDropDownValues") + "?header_id=" + header_id,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    success:
                            function (data) {
                                dropdown_values = data;
                            }
                });

                $.ajax({
                    url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/GetStatistics") + "?header_id=" + header_id,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    success:
                            function (data) {
                                $scope.statistics = data;
                            }
                });
            }
            else if (mode === "acceptnewfile") {
                $("#tbNewHeader").hide();
                $("#btPay").attr('disabled', 'disabled');
            }
            else if (mode === "createnewfile") {
                $("#btUpload").attr('disabled', 'disabled');
                $("#btPay").attr('disabled', 'disabled');
                $("#btFinish").attr('disabled', 'disabled');
                $("#file").data("kendoUpload").enable(false);
                $("#idEncodeDos").attr('disabled', 'disabled');
                $("#idEncodeWin").attr('disabled', 'disabled');
                $.ajax({
                    url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/GetUFilename"),
                    method: "GET",
                    dataType: "json",
                    async: false,
                    success:
                            function (data) {
                                $("#FILENAME").val(data);
                            }
                });
                $("#DAT").val(kendo.toString(kendo.parseDate(new Date(), 'yyyy-MM-dd'), 'dd/MM/yyyy'));
            }
            else if (mode === "copy")
            {
                $("#FILENAME").val(filename);
                $("#DAT").val(dat);
                $("#file").data("kendoUpload").enable(false)
                $("#idEncodeDos").attr('disabled', 'disabled');
                $("#idEncodeWin").attr('disabled', 'disabled');
                $("#btUpload").attr('disabled', 'disabled');
                $("#btPay").attr('disabled', 'disabled');
                $("#btCreateHeader").attr('disabled', 'disabled');
                $("#btFinish").removeAttr('disabled');
                $("#FILENAME").attr('disabled', 'disabled');
                $("#HEADER_LENGTH").attr('disabled', 'disabled');
                $("#DAT").attr('disabled', 'disabled');
                $("#MFO_A").attr('disabled', 'disabled');
                $("#NLS_A").attr('disabled', 'disabled');
                $("#MFO_B").attr('disabled', 'disabled');
                $("#NLS_B").attr('disabled', 'disabled');
                $("#DK").attr('disabled', 'disabled');
                $("#TYPE").attr('disabled', 'disabled');
                $("#NUM").attr('disabled', 'disabled');
                $("#HAS_ADD").attr('disabled', 'disabled');
                $("#NAME_A").attr('disabled', 'disabled');
                $("#NAME_B").attr('disabled', 'disabled');
                $("#NAZN").attr('disabled', 'disabled');
                $("#BRANCH_CODE").attr('disabled', 'disabled');
                $("#DPT_CODE").attr('disabled', 'disabled');
                $("#EXEC_ORD").attr('disabled', 'disabled');
                $("#KS_EP").attr('disabled', 'disabled');
                $("#listTypes").attr('disabled', 'disabled');
                $("#listAgencyType").attr('disabled', 'disabled');
            }
            $("#textYear").val(new Date().getFullYear());
            $scope.params = {
                filename: filename,
                header_id: header_id,
                dat: dat,
                mode: mode,
                gb: $scope.gb
            }
        }

        $("input[name='show_filter']").change(function () {
            $("#fileGrid").data("kendoGrid").dataSource.read();
        });


        $scope.fileGridOptions = {
            toolbar: [
              { template: '<button type="button" class="k-button" ng-click="addWin.center().open()">Додати новий запис</button>' }
            ],
            dataSource: {
                autoSync: false,
                type: 'webapi',
                transport: {
                    dataType: "json",
                    read: {
                        url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/GetShowFile"),
                        data: function () {
                            return { header_id: $scope.params.header_id, incorrect: $("#incorrect")[0].checked, unknown: $("#unknown")[0].checked, excluded: $("#excluded")[0].checked }
                        }
                    }
                },
                requestStart: function (e) {
                    if (!$("#btCreateHeader")[0].disabled)
                        $("#fileGrid .k-grid-toolbar").hide();
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        id: "INFO_ID",
                        fields: {
                            INFO_ID: { type: 'number', editable: true },
                            NLS: { type: 'string', editable: true },
                            REAL_ACC_NUM: { type: 'string', editable: false },
                            REAL_CUST_CODE: { type: 'string', editable: false },
                            REAL_CUST_NAME: { type: 'string', editable: false },
                            BRANCH_CODE: { type: 'number', editable: true },
                            DPT_CODE: { type: 'number', editable: true },
                            SUM: { type: 'string', editable: true },
                            FIO: { type: 'string', editable: true },
                            ID_CODE: { type: 'string', editable: true },
                            PAYOFF_DATE: { type: 'date', editable: true },
                            BRANCH: { type: 'string', editable: false },
                            AGENCY_NAME: { type: 'string', editable: false },
                            REF: { type: 'number', editable: false },
                            INCORRECT: { type: 'number', editable: false },
                            CLOSED: { type: 'number', editable: false },
                            EXCLUDED: { type: 'number', editable: false }
                        }
                    }
                },
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
            },
            dataBound: function (e) {
                grid_data = $("#fileGrid").data("kendoGrid").dataSource.data();
                if ($scope.params.mode !== "acceptnewfile") {
                    $("#fileGrid").data("kendoGrid").hideColumn(0);
                    $("#fileGrid").data("kendoGrid").hideColumn(1);
                }
                if ($scope.params.mode !== "createnewfile" && $scope.params.mode !== "copy")
                {
                    $("#fileGrid").data("kendoGrid").hideColumn(2);
                }
                if (grid_data.length > 0 && ($scope.params.mode === "acceptnewfile" || $scope.params.mode === "showfile" || $scope.params.mode === "createnewfile")) {
                    $scope.getStatistic(null, null);
                }

                for (var i = 0; i < grid_data.length; i++) {
                    if (!grid_data[i].REF &&
                        grid_data[i].EXCLUDED != 1 &&
                        grid_data[i].CLOSED != 1) {
                        $("#btPay").removeAttr('disabled');
                        $("#fileGrid").data("kendoGrid").showColumn(0);
                        $("#fileGrid").data("kendoGrid").showColumn(1);
                        break;
                    }
                }
                var rows = e.sender.tbody.children();
                for (var j = 0; j < rows.length; j++) {
                    var row = $(rows[j]);
                    var dataItem = e.sender.dataItem(row);

                    if (dataItem.MARKED4PAYMENT === 0)
                        $("tr[data-uid='" + dataItem.uid + "']").find("input")[0].checked = false;
                    else
                        $("tr[data-uid='" + dataItem.uid + "']").find("input")[0].checked = true;

                    if (!dataItem.get("MARKED4PAYMENT") === 0)
                        row.addClass("gray");
                    else if (dataItem.get("DEAL_CREATED") === 1)
                        row.addClass("blue");
                    else if (dataItem.get("REAL_ACC_NUM") === null)
                        row.addClass("red");

                    if (dataItem.get("INCORRECT") === 1)
                        row.addClass("red");
                    else if (dataItem.get("CLOSED") === 1)
                        row.addClass("orange");
                    else if (dataItem.get("EXCLUDED") === 1)
                        row.addClass("green");

                }
            },
            columns: [
                {
                    title: "Вибрано до оплати",
                    width: "85px",
                    template: "<input type='checkbox' class='checkbox' ng-click='getStatistic(dataItem.INFO_ID, dataItem.MARKED4PAYMENT)' />"
                },
                { template: '<a style="color: blue" ng-click="EditRow(dataItem)">Редагувати</a>', width: "105px" },
                {
                    template: '<a style="color: blue" ng-click="DeleteRow(dataItem.INFO_ID)">Видалити</a>', width: "105px"
                },
                {
                    title: "ID стрічки",
                    field: "INFO_ID",
                    width: "85px"
                },
                {
                    title: "Рахунок",
                    field: "NLS",
                    width: "115px"
                },
                {
                    title: "Рахунок одержувача",
                    field: "REAL_ACC_NUM",
                    width: "115px"
                },
                {
                    title: "Ід. код. одержувача",
                    field: "REAL_CUST_CODE",
                    width: "115px"
                },
                {
                    title: "ПІБ одержувача",
                    field: "REAL_CUST_NAME",
                    width: "115px"
                },
                {
                    title: "Код відд.",
                    field: "BRANCH_CODE",
                    width: "72px"
                },
                {
                    title: "Код деп.",
                    field: "DPT_CODE",
                    width: "70px"
                },
                {
                    title: "Сума",
                    field: "SUM",
                    width: "115px"
                },
                {
                    title: "ПІБ",
                    field: "FIO",
                    width: "115px"
                },
                {
                    title: "Ід. код",
                    field: "ID_CODE",
                    width: "100px"
                },
                {
                    title: "День виплати",
                    field: "PAYOFF_DATE",
                    template: "#= kendo.toString(kendo.parseDate(PAYOFF_DATE, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: "100px"
                },
                {
                    title: "Відділення",
                    field: "BRANCH",
                    width: "175px"
                },
                {
                    title: "Орган соц. захисту",
                    field: "AGENCY_NAME",
                    width: "115px"
                },
                {
                    title: "Документ",
                    field: "REF",
                    width: "100px",
                    template: '<a style="color: blue" ng-click="ShowRef(${REF})">{{ GetRefTemplate(dataItem.REF) }}</a>'
                },
                {
                    title: "Помилка",
                    field: "INCORRECT",
                    width: "100px"
                },
                {
                    title: "Закритий",
                    field: "CLOSED",
                    width: "100px"
                },
                {
                    title: "Виключений",
                    field: "EXCLUDED",
                    width: "100px"
                }
            ],
            sortable: true,
            filterable: true,
            resizable: true,
            selectable: "single",
            scrollable: true,
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100, 200],
                buttonCount: 5
            }
        }

        $scope.DeleteRow = function(id)
        {
            $.ajax({
                url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/DeleteRow") + "?info_id=" + id,
                method: "GET",
                dataType: "json",
                async: false,
                success:
                        function (data) {
                            $("#fileGrid").data("kendoGrid").dataSource.read();
                            bars.ui.success({ text: data });
                        }
            });
        }

        $scope.GetRefTemplate = function (ref) {
            if (ref)
                return ref;
            else
                return '';
        }

        $scope.getStatistic = function (info_id, mark) {
            if (!info_id)
                $.ajax({
                    url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/GetStatistics") + "?header_id=" + $scope.params.header_id,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    success:
                            function (data) {
                                $scope.statistics = data;
                                $("#statistics").val(data);
                            }
                });
            else {
                if (parseInt(mark) === 1)
                    mark = 0
                else
                    mark = 1
                $.ajax({
                    url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/MarkLine") + "?info_id=" + info_id + "&mark=" + mark,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    success:
                            function (data) {
                                $("#fileGrid").data("kendoGrid").dataSource.read();
                            }
                });
            }
        };

        $scope.EditRow = function (item) {
            $scope.editable_row = item;
            $scope.editable_row.PAYOFF_DATE = kendo.toString(kendo.parseDate($scope.editable_row.PAYOFF_DATE, 'yyyy-MM-dd'), 'dd/MM/yyyy');
            if ($scope.editable_row.EXCLUDED === 0)
                $("#edit_exluded")[0].checked = false;
            else
                $("#edit_exluded")[0].checked = true;
            if ($scope.editable_row.CLOSED === 0)
                $("#edit_closed")[0].checked = false;
            else
                $("#edit_closed")[0].checked = true;
            if ($scope.editable_row.INCORRECT === 0)
                $("#edit_incorrect")[0].checked = false;
            else
                $("#edit_incorrect")[0].checked = true;
            $("#edit_payoff_date").data("kendoDatePicker").value($scope.editable_row.PAYOFF_DATE);
            $("#edit_branchTypes").data("kendoDropDownList").value($scope.editable_row.BRANCH);
            $scope.editWin.title("Редагування cтрічки №" + $scope.editable_row.INFO_ID);
            angular.element("#depositbfrowgrid").data("kendoGrid").dataSource.read();
            $scope.editWin.center().open();
        };

        $scope.ddMonthOptions = {
            dataSource: {
                data: [
                        {
                            text: "січень", value: "1"
                        },
                        {
                            text: "лютий", value: "2"
                        },
                        {
                            text: "березень", value: "3"
                        },
                        {
                            text: "квітень", value: "4"
                        },
                        {
                            text: "травень", value: "5"
                        },
                        {
                            text: "червень", value: "6"
                        },
                        {
                            text: "липень", value: "7"
                        },
                        {
                            text: "серпень", value: "8"
                        },
                        {
                            text: "вересень", value: "9"
                        },
                        {
                            text: "жовтень", value: "10"
                        },
                        {
                            text: "листопад", value: "11"
                        },
                        {
                            text: "грудень", value: "12"
                        }
                ]
            },
            dataBound: function () {
                d = new Date();
                $("#ddMonth").data("kendoDropDownList").value(d.getMonth() + 1);
            },
            dataTextField: "text",
            dataValueField: "value",
            change: function () {
            },
            select: function (e) {
            }
        };

        $scope.listTypesOptions = {
            dataSource: {
                transport: {
                    async: false,
                    read: {
                        url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/LoadFileTypes")
                    }
                }
            },
            dataBound: function () {
                if (dropdown_values !== null) {
                    $("#listTypes").data("kendoDropDownList").value(dropdown_values.TYPE_ID);
                }
            },
            dataTextField: "TEXT",
            dataValueField: "VALUE"
        };

        $scope.listAgencyTypeOptions = {
            dataSource: {
                transport: {
                    async: false,
                    read: {
                        url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/LoadAgencyTypes")
                    }
                }
            },
            dataBound: function () {
                if (dropdown_values !== null) {
                    $("#listAgencyType").data("kendoDropDownList").value(dropdown_values.AGENCY_TYPE);
                }
                if ($scope.params.gb) {
                    $("#ddAgencyInGb").data("kendoDropDownList").dataSource.read();
                }
            },
            change: function () {
                if ($scope.params.gb) {
                    $("#ddAgencyInGb").data("kendoDropDownList").dataSource.read();
                }
            },
            dataTextField: "TEXT",
            dataValueField: "VALUE"
        };

        $scope.ddAgencyInGbOptions = {
            autoBind: false,
            dataSource: {
                transport: {
                    async: false,
                    read: {
                        url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/LoadAgencyInGb"),
                        data: function () {
                            return { agency_type: $("#listAgencyType").val() };
                        }
                    }
                }
            },
            dataTextField: "TEXT",
            dataValueField: "VALUE"
        };

        $scope.branchTypesOptions = {
            dataSource: {
                transport: {
                    async: false,
                    read: {
                        url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/LoadBranchTypes")
                    }
                }
            },
            dataTextField: "TEXT",
            dataValueField: "VALUE"
        };

        $scope.ddAccTypeOptions = {
            dataSource: {
                transport: {
                    async: false,
                    read: {
                        url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/LoadAccTypes")
                    }
                }
            },
            dataTextField: "TEXT",
            dataValueField: "VALUE"
        };

        $scope.ShowRef = function (ref) {
            bars.ui.dialog({
                content: bars.config.urlContent('/documentview/default.aspx') + '?ref=' + ref,
                iframe: true,
                height: document.documentElement.offsetHeight * 0.8,
                width: document.documentElement.offsetWidth * 0.8
            });
        }

        $scope.gvBranchOptions = //{ function (header_id)
            //$scope.params.header_id = header_id;
            //return 
            {
                toolbar: ["excel"],
                dataSource: {
                    type: 'webapi',
                    transport: {
                        read: {
                            url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/GetGridBranch"),
                            data: function () {
                                return { header_id: $scope.params.header_id }
                            }
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        model: {
                            id: "BRANCH",
                            fields: {
                                BRANCH: { type: 'string' },
                                AGENCY_NAME: { type: 'string' },
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
                columns: [
                    {
                        command: ["edit"]
                    },
                    {
                        title: "Відділення",
                        field: "BRANCH"
                    },
                    {
                        title: "Орган соц. захисту",
                        field: "AGENCY_ID",
                        template: "${AGENCY_NAME}",
                        editor: agencyDropDownEditor
                    }
                ],
                sortable: true,
                filterable: true,
                resizable: true,
                selectable: "single",
                editable: "inline",
                save: function (e) {
                    $.ajax({
                        url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/UpdateGridBranch"),
                        type: "POST",
                        contentType: 'application/json',
                        async: false,
                        data: JSON.stringify({ header_id: $scope.params.header_id, branch: e.model.BRANCH, agency_id: e.model.AGENCY_ID })
                    });
                    $("#gvBranch").data("kendoGrid").dataSource.read();
                },
                pageable: {
                    refresh: true,
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 5
                }
            }


        function agencyDropDownEditor(container, options) {
            $('<input required name="' + options.field + '"/>')
                .appendTo(container)
                .kendoDropDownList({
                    filter: "contains",
                    dataTextField: "TEXT",
                    dataValueField: "VALUE",
                    dataSource: {
                        transport: {
                            async: false,
                            read: {
                                url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/GetSocAgency") + "?branch=" + options.model.BRANCH + "&agency_type=" + $("#listAgencyType").val()
                            }
                        }
                    }
                });
        }

        $scope.CreateHeader = function () {
            obj = new Object();
            obj.FILENAME = $("#FILENAME").val().toString();
            obj.HEADER_LENGTH = $("#HEADER_LENGTH").val();
            obj.FDAT = $("#DAT").val();
            obj.MFO_A = $("#MFO_A").val();
            obj.NLS_A = $("#NLS_A").val();
            obj.MFO_B = $("#MFO_B").val();
            obj.NLS_B = $("#NLS_B").val();
            obj.DK = $("#DK").val();
            obj.TYPE = $("#TYPE").val();
            obj.NUM = $("#NUM").val();
            obj.HAS_ADD = $("#HAS_ADD").val();
            obj.NAME_A = $("#NAME_A").val();
            obj.NAME_B = $("#NAME_B").val();
            obj.NAZN = $("#NAZN").val();
            obj.BRANCH_CODE = $("#BRANCH_CODE").val();
            obj.DPT_CODE = $("#DPT_CODE").val();
            obj.EXEC_ORD = $("#EXEC_ORD").val();
            obj.KS_EP = $("#KS_EP").val();
            obj.TYPE_ID = $("#listTypes").val();
            obj.AGENCY_TYPE = $("#listAgencyType").val();
            obj.HEADER_ID = "";
            $.ajax({
                url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/InsertHeader"),
                type: "POST",
                contentType: 'application/json',
                async: false,
                data: JSON.stringify(obj),
                success: function (data) {
                    $("#listTypes").data("kendoDropDownList").enable(false);
                    $("#listAgencyType").data("kendoDropDownList").enable(false);
                    $("#ddAccType").data("kendoDropDownList").enable(false);
                    $("#btCreateHeader").attr('disabled', 'disabled');
                    $("#btFinish").removeAttr('disabled');
                    $("#FILENAME").attr('disabled', 'disabled');
                    $("#HEADER_LENGTH").attr('disabled', 'disabled');
                    $("#DAT").attr('disabled', 'disabled');
                    $("#MFO_A").attr('disabled', 'disabled');
                    $("#NLS_A").attr('disabled', 'disabled');
                    $("#MFO_B").attr('disabled', 'disabled');
                    $("#NLS_B").attr('disabled', 'disabled');
                    $("#DK").attr('disabled', 'disabled');
                    $("#TYPE").attr('disabled', 'disabled');
                    $("#NUM").attr('disabled', 'disabled');
                    $("#HAS_ADD").attr('disabled', 'disabled');
                    $("#NAME_A").attr('disabled', 'disabled');
                    $("#NAME_B").attr('disabled', 'disabled');
                    $("#NAZN").attr('disabled', 'disabled');
                    $("#BRANCH_CODE").attr('disabled', 'disabled');
                    $("#DPT_CODE").attr('disabled', 'disabled');
                    $("#EXEC_ORD").attr('disabled', 'disabled');
                    $("#KS_EP").attr('disabled', 'disabled');
                    $scope.params.header_id = data;
                    $("#fileGrid .k-grid-toolbar").show();
                }
            });
        }

        function onSuccess(e) {
            $scope.temp_file = e.files;
        }

        $('#btUpload').on('click', function (e) {
            e.preventDefault();
            if ($scope.temp_file.length > 0) {
                var data = {
                    "file_name": $scope.temp_file[0].name,
                    "rbWin": $("#idEncodeWin")[0].checked,
                    "rbDos": $("#idEncodeDos")[0].checked,
                    "listTypes": $("#listTypes").val(),
                    "listAgencyType": $("#listAgencyType").val(),
                    "ddAccType": $("#ddAccType").val(),
                    "ddMonth": $("#ddMonth").val(),
                    "textYear": $("#textYear").val(),
                    "gb": $scope.params.gb
                };
                $.ajax({
                    method: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    async: false,
                    url: '/barsroot/api/depofiles/depofilesapi/UpFile',
                    data: JSON.stringify(data),
                    success: function (result) {
                        bars.ui.success({ text: "Файл успішно прийнято." });
                        $("#file").data("kendoUpload").enable(false);
                        $("#idEncodeWin").attr('disabled', 'disabled');
                        $("#idEncodeDos").attr('disabled', 'disabled');
                        $("#btUpload").attr('disabled', 'disabled');
                        $("#listTypes").data("kendoDropDownList").enable(false);
                        $("#listAgencyType").data("kendoDropDownList").enable(false);
                        $("#ddAccType").data("kendoDropDownList").enable(false);
                        $("#ddMonth").data("kendoDropDownList").enable(false);
                        $("#textYear").attr('disabled', 'disabled');
                        $scope.params.header_id = result.header_id;
                        $scope.params.filename = result.filename;
                        $scope.params.dat = result.dat;
                        $("#fileGrid").data("kendoGrid").dataSource.read();
                        $("#gvBranch").data("kendoGrid").dataSource.read();
                        $scope.temp_file = {};
                    }
                });
            }
            else {
                bars.ui.error({ text: "Оберіть спочатку файл" });
            }
        });

        //function getIds() {
        //    grid = angular.element("#fileGrid").data("kendoGrid");
        //    grid_data = grid.dataSource.data();
        //    ids = "";
        //    i = 0;
        //    stringArray = new Array();
        //    angular.element("#fileGrid").find("input:checked").each(function () {
        //        var dataItem = grid.dataItem(angular.element(this).closest('tr'));
        //        ids = ids + "&ids=" + dataItem.INFO_ID;
        //        stringArray[i] = dataItem.INFO_ID.toString();
        //        i++;
        //    });
        //    return stringArray;
        //}

        $('#btPay').on('click', function (e) {
            e.preventDefault();
            if ($("#ddAgencyInGb"))
                agencyInGb = $("#ddAgencyInGb").val()
            else
                agencyInGb = ""

            var data = {
                "header_id": $scope.params.header_id,
                "filename": $scope.params.filename,
                "dat": kendo.toString(kendo.parseDate($scope.params.dat, 'yyyy-MM-dd'), 'dd/MM/yyyy'),
                "gb": $scope.gb,
                "agencyInGb": agencyInGb
            }
            $.ajax({
                type: "POST",
                contentType: 'application/json',
                async: false,
                data: JSON.stringify(data),
                url: '/barsroot/api/depofiles/depofilesapi/PayFile',
                success: function (result) {
                    bars.ui.success({ text: "Файл успішно сплачено." });
                    $scope.params.header_id = result.header_id;
                    $scope.params.filename = result.filename;
                    $scope.params.dat = result.dat;
                    $("#fileGrid").data("kendoGrid").dataSource.read();
                    $("#gvBranch").data("kendoGrid").dataSource.read();
                }
            });
        });


        $scope.depositbfrowgridOptions = {
            toolbar: [{ name: 'excel', text: 'Вивантажити в Excel' }],
            autoBind: false,
            excel: {
                fileName: "Рахунки в системі.xlsx",
                allPages: true,
                filterable: true,
                proxyURL: bars.config.urlContent("/DepoFiles/DepoFiles/ConvertBase64ToFile/")
            },
            dataSource: {
                type: 'webapi',
                transport: {
                    dataType: "json",
                    read: {
                        url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/GetDepositBfRowCorrection"),
                        data: function () {
                            return { info_id: $scope.editable_row.INFO_ID };
                        }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ASVO_ACCOUNT: { type: 'string' },
                            ACC_NUM: { type: 'string' },
                            ACC_TYPE: { type: 'string' },
                            BRANCH_NAME: { type: 'string' },
                            CUST_NAME: { type: 'string' },
                            CUST_CODE: { type: 'string' },
                            DOC_SERIAL: { type: 'string' },
                            CUST_ID: { type: 'number' },
                            ACC_ID: { type: 'number' },
                            DOC_NUMBER: { type: 'string' },
                            DOC_ISSUED: { type: 'string' },
                            CUST_BDAY: { type: 'date' },
                            DOC_DATE: { type: 'date' }
                        }
                    }
                },
                pageSize: 3,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverAggregates: true
            },
            columns: [
                { template: '<a id="btnEditClient" ng-click="EditClient(dataItem.CUST_ID)" style="color: blue">Редагувати клієнта</a>', width: "90px" },
                { template: '<a id="btnEditAccount" ng-click="EditAccount(dataItem.ACC_ID, dataItem.CUST_ID)" style="color: blue">Редагувати рахунок</a>', width: "90px" },
                {
                    title: "Рахунок АСВО",
                    field: "ASVO_ACCOUNT",
                    width: "130px"
                },
                {
                    title: "Рахунок",
                    field: "ACC_NUM",
                    width: "130px"
                },
                {
                    title: "Тип",
                    field: "ACC_TYPE",
                    width: "80px"
                },
                {
                    title: "Відділення",
                    field: "BRANCH_NAME",
                    width: "130px"
                },
                {
                    title: "ПІБ",
                    field: "CUST_NAME",
                    width: "100px"
                },
                {
                    title: "Ід. код",
                    field: "CUST_CODE",
                    width: "100px"
                },
                {
                    title: "Серія",
                    field: "DOC_SERIAL",
                    width: "80px"
                },
                {
                    title: "",
                    field: "CUST_ID",
                    hidden: true
                },
                {
                    title: "Рахунок",
                    field: "ACC_ID",
                    hidden: true
                },

                {
                    title: "Номер",
                    field: "DOC_NUMBER",
                    width: "80px"
                },
                {
                    title: "Виданий",
                    field: "DOC_ISSUED",
                    width: "100px"
                },
                {
                    title: "Дата документу",
                    field: "DOC_DATE",
                    template: "#= kendo.toString(kendo.parseDate(DOC_DATE, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: "100px"
                },
                {
                    title: "Дата народження",
                    field: "CUST_BDAY",
                    template: "#= kendo.toString(kendo.parseDate(CUST_BDAY, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                    width: "100px"
                }
            ],
            scrollable: true,
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

        $scope.EditClient = function (rnk) {
            bars.ui.dialog({
                content: bars.config.urlContent("/clientregister/registration.aspx") + "?readonly=0&rnk=" + rnk,
                iframe: true,
                height: document.documentElement.offsetHeight * 0.8,
                width: document.documentElement.offsetWidth * 0.8,
                close: function () {
                    angular.element("#depositbfrowgrid").data("kendoGrid").dataSource.read();
                }
            });
        };

        $scope.EditAccount = function (acc, rnk) {
            bars.ui.dialog({
                content: bars.config.urlContent("/viewaccounts/accountform.aspx") + "?type=1&acc=" + acc + '&rnk=' + rnk + '&accessmode=1',
                iframe: true,
                height: document.documentElement.offsetHeight * 0.8,
                width: document.documentElement.offsetWidth * 0.8,
                close: function () {
                    angular.element("#depositbfrowgrid").data("kendoGrid").dataSource.read();
                }
            });
        };

        $scope.InsertRow = function () {
            validator = angular.element("#add_form").data("kendoValidator");
            if (validator.validate()) {
                row = new Object();
                row.HEADER_ID = $scope.params.header_id;
                row.FILE_NAME = $("#FILENAME").val().toString();
                row.FDAT = $("#DAT").val();
                row.NLS = $("#add_nls").val();
                row.BRANCH_CODE = $("#add_branch_code").val();
                row.DPT_CODE = $("#add_dpt_code").val();
                row.SUM = $("#add_sum").val();
                row.FIO = $("#add_fio").val();
                row.ID_CODE = $("#add_id_code").val();
                row.PAYOFF_DATE = $("#add_payoff_date").val();
                row.INFO_ID = $("#add_infoid").val();
                $.ajax({
                    url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/InsertFileGrid"),
                    type: "POST",
                    contentType: 'application/json',
                    async: false,
                    data: JSON.stringify(row)
                });
                $("#fileGrid").data("kendoGrid").dataSource.read();
                $scope.addWin.close();
                $("#add_nls").val("");
                $("#add_branch_code").val("");
                $("#add_dpt_code").val("");
                $("#add_sum").val("");
                $("#add_fio").val("");
                $("#add_id_code").val("");
                $("#add_payoff_date").val("");
                $("#add_infoid").val("");
            }
        }

        $scope.UpdateRow = function () {
            model = new Object();
            model.NLS = $("#edit_nls").val();
            model.BRANCHCODE = $("#edit_branch_code").val();
            model.DPTCODE = $("#edit_dpt_code").val();
            model.SUM = $("#edit_sum").val();
            model.FIO = $("#edit_fio").val();
            model.IDCODE = $("#edit_id_code").val();
            model.PAYOFFDATE = $("#edit_payoff_date").val();
            if ($("#edit_exluded")[0].checked)
                model.EXCLUDED = 1;
            else
                model.EXCLUDED = 0;
            model.BRANCH = $("#edit_branchTypes").val();
            model.ACCTYPE = $("#edit_ddAccTypes").val();
            model.INFOID = $scope.editable_row.INFO_ID;
            $.ajax({
                url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/UpdateRow"),
                type: "POST",
                contentType: 'application/json',
                async: false,
                data: JSON.stringify(model),
                success: function () {
                    bars.ui.success({ text: "Стрічка успішно оновлена" })
                    $("#fileGrid").data("kendoGrid").dataSource.read();
                    $("#edit_branchTypes").data("kendoDropDownList").dataSource.read();
                    $("#edit_branchTypes").data("kendoDropDownList").value($scope.editable_row.BRANCH);
                }
            });
        }

        angular.element("#add_form").kendoValidator({
            messages: {
                required: "Поле обов'язкове!",
                number: "Повинно бути числом!"
            },
            rules: {
                number: function (input) {
                    var OnlyNumbers = /^(?:[1-9]\d*|0)?(?:\.\d+)?$/;
                    if (input.is("[name=add_branch_code]") || input.is("[name=add_dpt_code]")
                        || input.is("[name=add_sum]") || input.is("[name=add_id_code]") || input.is("[name=add_infoid]")) {
                        if (!input.val().match(OnlyNumbers)) {
                            return false;
                        }
                    }
                    return true;
                }
            }
        });

        $scope.Finish = function () {
            grid_data = $("#fileGrid").data("kendoGrid").dataSource.data();
            if (grid_data.length > 0) {
                $.ajax({
                    url: bars.config.urlContent("/api/DepoFiles/DepoFilesApi/Finish") + "?header_id=" + $scope.params.header_id,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    success:
                            function (data) {
                                header_id = $scope.params.header_id;
                                filename = $("#FILENAME").val().toString();
                                date = $("#DAT").val();
                                inject = "";
                                if ($scope.params.gb)
                                    inject = "&gb=true";
                                var url = '/barsroot/depofiles/depofiles/acceptfile' + "?mode=" + "showfile" + '&filename=' + filename + '&dat=' + date + '&header_id=' + header_id + inject;
                                location.replace(url);
                            }
                });
            }
            else
                bars.ui.error({ text: "Недостатня кількість записів у файлі!" });
        }
    }]);