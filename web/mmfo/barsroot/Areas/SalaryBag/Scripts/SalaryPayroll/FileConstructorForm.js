function fileConstructor(response, postFileModel, cbFuncUpdateWindow, cbFuncUpdateDDL) {
    cbFuncUpdateWindow = cbFuncUpdateWindow || function () { };
    cbFuncUpdateDDL = cbFuncUpdateDDL || function () { };
    var _response = response;
    var _encoding = postFileModel.p_encoding;
    var _canClose = true;

    function onClose(e) {
        if (!_canClose) {
            e.preventDefault();
            $(document).off('keyup', onEscKeyUp);
        }
    };

    //Constructor window properties.
    var constructorWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: 'Конструктор файлів',
        resizable: false,
        modal: true,
        draggable: true,
        width: "70%",
        close: onClose,
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({
            animationType: {
                open: 'left',
                close: 'right'
            }
        }),
        deactivate: function () {
            bars.ui.loader(constructorWindow, false);
            this.destroy();
        },
        activate: function () {
            constructorWindow.find('#modalFileContentGrid').kendoGrid(contentGridOptions).end();
            constructorWindow.find('#modalFileConstructorGrid').kendoGrid(constructorGridOptions).end();
            constructorWindow.data("kendoWindow").refresh();
        }
    });

    //HTML-template for kendo window. 
    var windowTemplate = kendo.template($("#ConstructorTemplate").html());
    constructorWindow.data("kendoWindow").content(windowTemplate({}));

    //Binding close() method to the btnCancel click event.
    constructorWindow.find("#btnCancel").click(function () {
        bars.ui.loader(constructorWindow.find("#modalFileContentGrid"), false);
        constructorWindow.data("kendoWindow").close();
        cbFuncUpdateWindow();
    }).end();

    //File encoding change method bound to btnChange click event.
    constructorWindow.find("#btnChange").click(function () {

        if (_encoding == "WIN")
            postFileModel.p_encoding = "DOS";
        else
            postFileModel.p_encoding = "WIN";

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/PreloadDbf"),
            beforeSend: function () {
                bars.ui.loader(constructorWindow, true);
                _canClose = false;
            },
            data: JSON.stringify(postFileModel),
            success: function (data) {
                bars.ui.loader(constructorWindow, false);
                if (data.Result != "OK") {
                    bars.ui.error({ text: "При завантаженні файлу відбулась помилка : <br/>" + data.ErrorMsg });
                }
                else {
                    var newDataSource = new kendo.data.DataSource({
                        data: data.ResultObj
                    });

                    var grid = constructorWindow.find("#modalFileContentGrid").data("kendoGrid");
                    grid.setDataSource(newDataSource);

                    _response = data.ResultObj;
                    _encoding = data.PostFileModel.p_encoding;
                    _canClose = true;
                }
            },
            error: function () {
                bars.ui.loader(constructorWindow, false);
                _canClose = true;
            }
        });
    });


    //
    //
    //Binding file saving method to the btnSave click event.
    constructorWindow.find("#btnSave").click(function () {
        var grid = constructorWindow.find('#modalFileConstructorGrid').data('kendoGrid');
        var data = grid.dataSource.data();

        var selectedNames = data.map(function (e) {
            return e.customColumn;
        });
        var sorted_arr = selectedNames.slice().sort();
        var results = [];
        for (var i = 0; i < selectedNames.length - 1; i++) {
            if (sorted_arr[i + 1] == sorted_arr[i] && sorted_arr[i]) {
                results.push(sorted_arr[i]);
            }
        }
        if (results.length > 0) {
            bars.ui.alert({ text: 'Одне поле файлу не може одночасно відноситись до декількох полів ЗП відомості' });
            return;
        }


        var errorArray = [];
        var postObj = {};

        for (var i = 0; i < data.length; i++) {
            var current = data[i];
            if (current.required && current.customColumn == "") {
                errorArray.push(current.showColumn);
            }
            else
                postObj[current.dbColumn] = current.customColumn;
        }

        if (errorArray.length > 0) {
            if (errorArray.length == 1) {
                bars.ui.alert({ text: "Будь ласка, введіть значення для поля: " + "<b>" + errorArray[0] + "<b>" + "!" });
            } else {
                bars.ui.alert({ text: "Будь ласка, введіть значення для полів: <br/>" + "<b>" + errorArray.join('; ') + "</b>" + "!" });
            }
        } else if (constructorWindow.find("#templateCheckbox").is(':checked')) {
            if (constructorWindow.find("#templateName").val() == "") {
                bars.ui.alert({ text: "Будь ласка, введіть назву шаблону!" });
            } else {
                save(constructorWindow.find("#templateName").val());
            }

        } else {
            save();
        }
        function save(draft) {
            postObj["p_save_draft"] = draft ? draft : null;
            postObj["p_clob"] = postFileModel.p_clob;
            postObj["p_nazn"] = postFileModel.p_nazn;
            postObj["p_encoding"] = _encoding;
            postObj["p_file_name"] = postFileModel.p_file_name;
            postObj["p_id_dbf_type"] = postFileModel.p_id_dbf_type;
            postObj["p_id_pr"] = postFileModel.p_id_pr;
            postObj["p_file_type"] = "DBFPREV";
            postObj["p_sum_delimiter"] = constructorWindow.find('#sum_delimiter').data('kendoDropDownList').value();

            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SaveDbf"),
                data: JSON.stringify(postObj),
                beforeSend: function () {
                    bars.ui.loader(constructorWindow, true);
                    _canClose = false;
                },
                success: function (data) {
                    bars.ui.loader(constructorWindow, false);
                    _canClose = true;
                    if (data.Result != "OK") {
                        bars.ui.error({ text: "При завантаженні файлу відбулась помилка : <br/>" + data.ErrorMsg });
                    } else {
                        bars.ui.alert({ text: "Файл <b>" + postFileModel.p_file_name + "</b> успішно завантажено" });
                        constructorWindow.data("kendoWindow").close();
                        cbFuncUpdateWindow();
                        cbFuncUpdateDDL();
                    }
                },
                error: function () {
                    bars.ui.loader(constructorWindow, false);
                    _canClose = true;
                }
            });
        }
    });

    constructorWindow.find("#sum_delimiter").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        template: '<span style="font-size:12px;">#:data.text#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.text#</span>',
        dataSource: [
            { text: "гривнях", value: 1 },
            { text: "копійках", value: 100 }
        ]
    });

    constructorWindow.find("#templateCheckbox").on('change', function () {
        constructorWindow.find("#templateName, #templateNameLbl").toggleClass('invisible');
    });

    //Drop-down list data source.
    var ddlDataSource = [];

    //Grid options for content grid.
    var contentGridOptions = {
        dataSource: _response,
        pageable: {
            info: false,
            refresh: false,
            pageSize: false,
            previousNext: false,
            numeric: false
        },
        reorderable: false,
        sortable: false,
        filterable: false,
        scrollable: true,
        selectable: "row",
        editable: false,
        dataBound: function () {
            var grid = constructorWindow.find('#modalFileContentGrid').data('kendoGrid');

            ddlDataSource = grid.columns.map(function (item) {
                return {
                    'field': item.field
                };
            });
        }
    };

    //Columns array for constructor grid
    var constructorGridColumns = [
        { showColumn: "IПН", dbColumn: 'p_okpob_map', customColumn: '', required: false }, //добавить название полей из бд! дописывать значение из customColumn!
        { showColumn: "ПІБ", dbColumn: 'p_namb_map', customColumn: '', required: false },
        { showColumn: "Номер рахунку<label style='color:red;'>*</label>", dbColumn: 'p_nlsb_map', customColumn: '', required: true },
        { showColumn: "Сума<label style='color:red;'>*</label>", dbColumn: 'p_s_map', customColumn: '', required: true },
        { showColumn: "МФО", dbColumn: 'p_mfob_map', customColumn: '', required: false },
        { showColumn: "Призначення платежу", dbColumn: 'p_nazn_map', customColumn: '', required: false }
        //showColumn - display name for a column in database. dbColumn - headers of columns from database. customColumn - headers from uploaded file.
    ];

    //Data source object for constructor grid.
    var constructorDataSourceObj = {
        requestStart: function () {
            kendo.ui.progress(constructorWindow, true);
        },
        requestEnd: function () {
            kendo.ui.progress(constructorWindow, false);
        },
        data: constructorGridColumns,
        pageSize: 6,
        schema: {
            model: {
                fields: {
                    showColumn: { editable: false },
                    dbColumn: { editable: false },
                    customColumn: { editable: true }
                }
            }
        }
    };

    //Data source for constructor grid.
    var constructorGridDataSource = new kendo.data.DataSource(constructorDataSourceObj);

    //Grid options for constructor grid.
    var constructorGridOptions = {
        dataSource: constructorGridDataSource,
        pageable: {
            info: false,
            refresh: false,
            pageSize: false,
            previousNext: false,
            numeric: false
        },
        columns: [
            { field: "showColumn", title: "Поля ЗП відомості", template: '#= data.showColumn #' },
            { field: "customColumn", title: "Поля файлу", editor: fileFieldsDropDownList }
        ],
        edit: function (e) {
            $("#modalFileConstructorGrid .k-dirty").addClass("k-dirty-clear");
        },
        editable: true,
        reorderable: false,
        sortable: false,
        filterable: false,
        scrollable: true,
        selectable: "row"
    };

    //Drop-down list for displaying headers of dbf.
    function fileFieldsDropDownList(container, options) {
        $('<input class="customHeaderSelector" name="' + options.field + '"/>')
            .appendTo(container)
            .kendoDropDownList({
                autoBind: false,
                dataTextField: "field",
                dataValueField: "field",
                optionLabel: {
                    field: ""
                },
                dataSource: ddlDataSource,
                template: '<span style="font-size:12px;">#:data.field#</span>',
                valueTemplate: '<span style="font-size:12px;">#:data.field#</span>'
            });
    }

    //Opens a constructor window and brings it on top of any other open window instances.
    constructorWindow.data("kendoWindow").center().open();
}