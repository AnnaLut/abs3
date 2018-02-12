function importForm(pId, pPurpose, func) {
    func = func || function() { };
    var gridSelector = '#importFilesGrid';

    function updateGrid() {
        var grid = kendoWindow.find(gridSelector).data("kendoGrid");
        if (grid) {
            grid.dataSource.read();
        }
    };
    function updateTemplateDropDown() {
        var ddl = kendoWindow.find("#import_dbf_configuration").data("kendoDropDownList");
        if (ddl) {
            ddl.dataSource.read();
        }
    };

    var kendoWindow = $('<div />').kendoWindow({
        actions: ["Close"],
        title: 'Імпорт файлів',
        resizable: false,
        modal: true,
        draggable: true,
        //width: "900px",
        width: "70%",
        refresh: function() {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'down', close: 'up' } }),
        deactivate: function() {
            bars.ui.loader('body', false);
            this.destroy();
        },
        close: function() {
            func();
        },
        activate: function() {
            kendoWindow.find(gridSelector).kendoGrid(gridOptions).end();
            kendoWindow.data("kendoWindow").refresh();
        },
        refresh: function() {
            this.center();
        }
    });

    var template = kendo.template($("#ImportTemplate").html());
    kendoWindow.data("kendoWindow").content(template({}));

    var pageInitalCount = 10;

    var dataSourceObj = {
        requestStart: function() {
            kendo.ui.progress(kendoWindow, true);
        },
        requestEnd: function() {
            kendo.ui.progress(kendoWindow, false);
        },
        type: "webapi",
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SearchImportedFilesHistory"),
                dataType: "json",
                data: {
                    payrollId: pId
                }
            }
        },
        pageSize: pageInitalCount,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    id: { type: "number" },
                    id_pr: { type: "number" },
                    imp_date: { type: "date" },
                    file_name: { type: "string" },
                    sos: { type: "number" },
                    sos_text: { type: "string" },
                    err_text: { type: "string" },
                    cnt_total: { type: "number" },
                    cnt_doc: { type: "number" },
                    cnt_doc_reject: { type: "number" }
                }
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        dataSource: gridDataSource,
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            //pageSizes: [pageInitalCount, 20, 30, 50, 100, "All"],
            buttonCount: 5
        },
        reorderable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        filterable: true,
        scrollable: true,
        columns: [
            { field: "id", title: "№", width: "70px" },
            { field: "imp_date", title: "Дата імпорту", width: "150px", template: "<div style='text-align:center;'>#= (imp_date == null) ? ' ' : kendo.toString(imp_date,'dd.MM.yyyy HH:mm:ss') #</div>" },
            { field: "file_name", title: "Файл", width: "250px" },
            { field: "sos_text", title: "Статус", width: "150px" },

            { field: "cnt_total", title: "Всього документів", width: "110px", filterable: false },
            { field: "cnt_doc", title: "Імпортовано", width: "110px", filterable: false },
            { field: "cnt_doc_reject", title: "Помилок", width: "110px", filterable: false },
            { field: "err_text", title: "Помилка", width: "400px", template: "<div style='text-align:center;'>#= (err_text == null) ? '-' : err_text #</div>", filterable: false }
        ],
        selectable: "row",
        editable: false,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function() {
            kendoWindow.data("kendoWindow").refresh();
            kendoWindow.find('#import_delete, #import_view').removeAttr('disabled');
        },
        change: function() {
            var sos = +this.dataItem(this.select()).sos;
            var errors = +this.dataItem(this.select()).cnt_doc_reject;

            enableElem('#import_view', errors > 0 && sos != 3);
            enableElem('#import_delete', sos == 1 || sos == 2 || sos == 0)

            //if (errors > 0 && sos != 3) {
            //    kendoWindow.find('#import_view').removeAttr('disabled');
            //} else {
            //    kendoWindow.find('#import_view').attr('disabled', 'disabled');
            //}

            //if (sos == 1 || sos == 2) {
            //    kendoWindow.find('#import_delete').removeAttr('disabled');
            //} else {
            //    kendoWindow.find('#import_delete').attr('disabled', 'disabled');
            //}
        }
    };

    //kendoWindow.find(gridSelector).kendoGrid(gridOptions).end();

    kendoWindow.find("#btnCancel").click(function() {
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find('#import_delete').on('click', function() {
        var grid = kendoWindow.find(gridSelector).data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());

        if (selectedItem == null || selectedItem === undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };

        bars.ui.loader(kendoWindow, true);
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/DeleteImportedFile"),
            data: {
                fileId: +selectedItem.id
            },
            success: function(data) {
                bars.ui.loader(kendoWindow, false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    bars.ui.alert({ text: 'Файл видалено.' });
                    updateGrid();
                }
            }
        });
    });

    kendoWindow.find('#import_view').on('click', function() {
        var grid = kendoWindow.find(gridSelector).data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());

        if (selectedItem == null || selectedItem === undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };

        showFileDetails(selectedItem.id);
    });

    kendoWindow.find('#downloadExelTemplate').on('click', function() {
        window.location = bars.config.urlContent("/SalaryBag/SalaryBag/GetExcelTemplate");
    });

    kendoWindow.data("kendoWindow").center().open();

    initFileUploader();

    //kendoWindow.find("#import_encoding").kendoDropDownList({
    //    dataTextField: "text",
    //    dataValueField: "text",
    //    template: '<span style="font-size:12px;">#:data.text#</span>',
    //    valueTemplate: '<span style="font-size:12px;">#:data.text#</span>',        
    //    dataSource: [
    //        { text: "WIN" },
    //        { text: "DOS" }
    //    ]
    //});

    $("#import_dbf_configuration").kendoDropDownList({
        dataValueField: "id",
        dataTextField: "name",
        template: '<span style="font-size:12px;">#:data.name#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.name#</span>',
        filter: "contains",
        open: function() {
            var filters = this.dataSource.filter();
            if (filters) {
                this.dataSource.filter({});
            }
        },
        dataSource: {
            type: "webapi",
            transport: {
                read: {
                    url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetImportConfigs"),
                    dataType: "json"
                }
            }
        }
    });

    kendoWindow.find("#import_file_type").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "text",
        template: '<span style="font-size:12px;">#:data.text#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.text#</span>',
        dataSource: [
            { text: "DBF" },
            { text: "EXCEL" }
        ],
        change: function() {
            if (this.value() == 'DBF') {
                kendoWindow.find('#import_file_selector').attr('accept', '.dbf');
                kendoWindow.find('#star_info, #import_dbf_details').removeClass('invisible');
                kendoWindow.find('#downloadExelTemplate').addClass('invisible');
            } else {
                kendoWindow.find('#star_info, #import_dbf_details').addClass('invisible');
                kendoWindow.find('#import_file_selector').attr('accept', '.xls,.xlsx');
                kendoWindow.find('#downloadExelTemplate').removeClass('invisible');
            }
        }
    });

    bars.ui.loader(kendoWindow, true);

    function initFileUploader() {
        var kUpload = $("#import_file_selector").kendoUpload({
            multiple: false,
            localization: {
                select: 'Обрати файл'
            },
            async: {
                saveUrl: bars.config.urlContent("/api/SalaryBag/SalaryBag/RecieveFile")
            },
            showFileList: false,
            select: function(e) {
                var file = e.files[0];
                if (file == null || file === undefined) {
                    e.preventDefault();
                    return;
                }

                var dbfConfig = kendoWindow.find('#import_dbf_configuration').data('kendoDropDownList').value();
                var dataArray = gridDataSource._data;

                if (dbfConfig == "") {
                    for (var i = 0; i < dataArray.length; i++) {
                        if (dataArray[i].file_name == file.name && dataArray[i].sos == 1) {
                            bars.ui.error({
                                text: "При завантаженні файлу відбулась помилка: Неможливо імпортувати файл. Файл з такою назвою вже імпортовано."
                            });
                            e.preventDefault();
                            return;
                        }
                    }
                }


                var extensions = kendoWindow.find('#import_file_selector').attr('accept').split(',');
                if (+extensions.indexOf(file.extension.toLowerCase()) == -1) {
                    bars.ui.error({ text: "Не коректний файл!<br/>Оберіть файл з розширенням зі списку : <br/><b>" + extensions.join('<br/>') + "</b>" });
                    e.preventDefault();
                    return;
                }
            },
            upload: function(e) {
                var dbfType = kendoWindow.find('#import_dbf_configuration').data('kendoDropDownList').value();
                bars.ui.loader(kendoWindow, true);
                var postObj = {
                    p_id_pr: pId,
                    p_encoding: "WIN",
                    p_nazn: pPurpose,
                    p_id_dbf_type: dbfType || null,
                    p_file_type: kendoWindow.find('#import_file_type').data('kendoDropDownList').value()
                };
                e.data = { postedObj: JSON.stringify(postObj) };
            },
            success: function(e) {
                bars.ui.loader(kendoWindow, false);
                if (e.response.Result != "OK") {
                    bars.ui.error({ text: "При завантаженні файлу відбулась помилка : <br/>" + e.response.ErrorMsg });
                } else {
                    if (kendoWindow.find('#import_dbf_configuration').data('kendoDropDownList').value() == "" && kendoWindow.find('#import_file_type').data('kendoDropDownList').value() == "DBF") {
                        fileConstructor(e.response.ResultObj, e.response.PostFileModel, function() {
                            updateGrid();
                        }, function() {
                            updateTemplateDropDown();
                        });
                    }
                    else
                        bars.ui.alert({ text: "Файл <b>" + e.files[0].name + "</b> успішно завантажено" });
                }
                updateGrid();
            },
            error: function(e) {
                //console.log(e);
                //alert('error');
                bars.ui.loader(kendoWindow, false);
            },
            dropZone: false
        });

        var myNav = navigator.userAgent.toLowerCase();
        var browser = (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;

        if (+browser === 8) {
            $('#fileUploaderDiv > div > div').removeClass('k-button').addClass('btn').addClass('custom-btn').addClass('custom-btn-import-add-file');
        } else {
            $('#fileUploaderDiv > div > div > div').removeClass('k-button').addClass('btn').addClass('custom-btn').addClass('custom-btn-import-add-file');
        }
        $('#fileUploaderDiv > div').removeClass('k-header').removeClass('k-upload').removeClass('k-widget');
        $('#fileUploaderDiv > div > div > em').remove();
    };

    function showFileDetails(fileId) {

        function getTemplate() {
            return '<div id="modaFileDetailsGrid" tabindex="-1"></div><br/>' + templateButtons();
        };

        function templateButtons() {
            return '<div class="row" style="margin:5px 5px 5px 5px;">'
                + '     <div class="k-edit-buttons k-state-default">'
                + '         <a id="btnCancel2" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="105"><span class="k-icon k-cancel"></span>Закрити</a>'
                + '     </div>'
                + ' </div>';
        };

        var _kendoWindow = $('<div />').kendoWindow({
            actions: ["Close"],
            title: '',
            resizable: false,
            modal: true,
            draggable: true,
            //width: "900px",
            width: "70%",
            refresh: function() {
                this.center();
            },
            animation: getAnimationForKWindow({ animationType: { open: 'left', close: 'right' } }),
            deactivate: function() {
                bars.ui.loader('body', false);
                this.destroy();
            },
            activate: function() {
                _kendoWindow.find('#modaFileDetailsGrid').kendoGrid(_gridOptions).end();
                _kendoWindow.data("kendoWindow").refresh();
            },
            refresh: function() {
                this.center();
            }
        });

        var totalTemplate = getTemplate();
        var template = kendo.template(totalTemplate);
        _kendoWindow.data("kendoWindow").content(template({}));

        var pageInitalCount = 10;

        var _dataSourceObj = {
            requestStart: function() {
                kendo.ui.progress(_kendoWindow, true);
            },
            requestEnd: function() {
                kendo.ui.progress(_kendoWindow, false);
            },
            type: "webapi",
            transport: {
                read: {
                    type: "GET",
                    url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SearchImportErrorList"),
                    dataType: "json",
                    data: {
                        fileId: fileId
                    }
                }
            },
            serverPaging: true,
            serverFiltering: true,
            pageSize: pageInitalCount,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        okpob: { type: "string" },
                        namb: { type: "string" },
                        mfob: { type: "string" },
                        nlsb: { type: "string" },
                        err_text: { type: "string" }
                    }
                }
            }
        };

        var _gridDataSource = new kendo.data.DataSource(_dataSourceObj);

        var _gridOptions = {
            dataSource: _gridDataSource,
            pageable: {
                refresh: true,
                messages: {
                    empty: "Дані відсутні",
                    allPages: "Всі"
                },
                buttonCount: 5
            },
            reorderable: false,
            sortable: {
                mode: "single",
                allowUnsort: true
            },
            filterable: true,
            columns: [
                { field: "okpob", title: "ІПН", width: "100px" },
                { field: "namb", title: "ФІО клієнта", width: "200px" },
                { field: "mfob", title: "МФО", width: "100px" },
                { field: "nlsb", title: "Номер рахунку", width: "120px" },
                { field: "err_text", title: "Текст помилки", width: "350px", filterable: false },
            ],
            selectable: true,
            editable: false,
            scrollable: false,
            noRecords: {
                template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
            },
            dataBound: function() {
                _kendoWindow.data("kendoWindow").refresh();
            }
        };

        _kendoWindow.data("kendoWindow").center().open();
        _kendoWindow.find("#btnCancel2").click(function() {
            _kendoWindow.data("kendoWindow").close();
        }).end();
        bars.ui.loader(_kendoWindow, true);
    };
};