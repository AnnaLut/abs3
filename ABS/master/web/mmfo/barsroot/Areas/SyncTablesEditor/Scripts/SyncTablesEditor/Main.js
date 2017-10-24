///*** GLOBALS
var PAGE_INITIAL_COUNT = "10";
var uploadFileGlobalData = {};
///***
kendo.ui.Tooltip.fn._show = function (show) {
    return function (target) {
        var e = {
            sender: this,
            target: target,
            preventDefault: function () {
                this.isDefaultPrevented = true;
            }
        };

        if (typeof this.options.beforeShow === "function") {
            this.options.beforeShow.call(this, e);
        }
        if (!e.isDefaultPrevented) {
            show.call(this, target);
        }
    };
}(kendo.ui.Tooltip.fn._show);
///***

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid) {
        grid.dataSource.fetch();
    }
};

function initMainGrid() {
    var dataSourceObj = {
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/SearchMain")
            }
        },
        serverSorting: true,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    TABID: { type: 'number', editable: false },
                    S_SELECT: { type: 'string', editable: false },
                    S_INSERT: { type: 'string', editable: false },
                    S_UPDATE: { type: 'string', editable: false },
                    S_DELETE: { type: 'string', editable: false },
                    FILE_DATE: { type: 'date' },
                    SYNC_FLAG: { type: 'number' },
                    ENCODE: { type: 'string' },
                    FILE_NAME: { type: 'string' },
                    BRANCH: { type: 'string' },
                    SEMANTIC: { type: 'string', editable: false },
                    TABNAME: { type: 'string', editable: false }
                }
            }
        },
        change: function (e) {
            if (e.action == "itemchange") {
                colorRows();
            }
        },
        batch: true
    };

    var mainGridDataSource = new kendo.data.DataSource(dataSourceObj);

    var mainGridOptions = {
        dataSource: mainGridDataSource,
        pageable: {
            info: false,
            refresh: false,
            pageSizes: false,
            previousNext: false,
            numeric: false,
            refresh: true
        },
        toolbar: [
            {
                template: '<div class="btn-group">'
                            + '<button type="button" class="btn btn-primary k-grid-custom-update"> Зберегти зміни </button>'
                            + '<button type="button" class="btn btn-primary k-grid-custom-cancel"> Відмінити зміни </button>'
                            + '<button type="button" class="btn btn-primary k-grid-custom-add"> Додати </button>'
                            + '<button type="button" class="btn btn-primary k-grid-custom-delete"> Видалити </button>'
                            + '<button type="button" class="btn btn-primary k-grid-custom-diff"> Показати різницю </button>'
                            + '<button type="button" class="btn btn-primary k-grid-custom-sync"> Синхронізувати </button>'
                            + '<button type="button" class="btn btn-primary k-grid-custom-sync-all"> Синхронізувати усі таблиці </button>'
                            + '<button type="button" class="btn btn-primary k-grid-custom-upload-file"> Завантажити DBF файл </button>'
                            + '<button type="button" class="btn btn-primary k-grid-custom-export"> Експорт у SQL сценарій </button>'
                        + '</div>'
            }
        ],
        columns: [
            {
                field: "TABID",
                title: "Код таблиці",
                width: "100px",
                footerTemplate: ''
            },
            {
                field: "SEMANTIC",
                title: "Назва",
                width: "250px"
            },
            {
                field: "TABNAME",
                title: "Назва(БД)",
                width: "150px"
            },
            {
                field: "FILE_NAME",
                title: "DBF файл",
                width: "150px"
            },
            {
                field: "ENCODE",
                title: "Кодування",
                width: "100px",
                editor: encodingEditor
            },
            {
                field: "S_SELECT",
                title: "SQL SELECT"
            },
            {
                field: "S_INSERT",
                title: "SQL INSERT"
            },
            {
                field: "S_UPDATE",
                title: "SQL UPDATE"
            },
            {
                field: "S_DELETE",
                title: "SQL DELETE"
            }
        ],
        editable: true,
        selectable: "row",
        scrollable: true,
        height: "800px"
    };

    $("#gridMain").kendoGrid(mainGridOptions);

    addDblClickEventToCell([6, 7, 8, 9], cellSqlEditor);

    addDblClickEventToCell([1, 2, 3], selectTabName);

    CreateToolTip(2, "SEMANTIC");

    function addCellDblClickEvent(index) {
        var mainGrid = $("#gridMain").data("kendoGrid");
        $(mainGrid.tbody).on("dblclick", "td:nth-child(" + index + ")", function (e) {

            var row = $(this).closest("tr");
            var dataItem = mainGrid.dataItem(row);

            //var rowIdx = $("tr", mainGrid.tbody).index(row);
            //var colIdx = $("td", row).index(this);

            //var colName = mainGrid.columns[colIdx].title;
            //var fieldName = mainGrid.columns[colIdx].field;
            var colInfo = getColData(this);

            CellEditForm(dataItem, colInfo.field, colInfo.title, dataItem.SEMANTIC);
        });
    };

    function addDblClickEventToCell(indexesArr, func) {
        indexesArr.forEach(function (item, index) {
            //$($("#gridMain").data("kendoGrid").tbody).on("dblclick", "td:nth-child(" + item + ")", func);
            $("#gridMain").on("dblclick", "td:nth-child(" + item + ")", func);
        });
    };

    function cellSqlEditor() {
        var mainGrid = $("#gridMain").data("kendoGrid");
        var row = $(this).closest("tr");
        var dataItem = mainGrid.dataItem(row);
        var colInfo = getColData(this);

        CellEditForm(dataItem, colInfo.field, colInfo.title, dataItem.SEMANTIC);
    };

    function selectTabName() {
        var mainGrid = $("#gridMain").data("kendoGrid");
        var row = $(this).closest("tr");
        var dataItem = mainGrid.dataItem(row);

        var options = {
            tableName: "META_TABLES",
            jsonSqlParams: "",
            filterCode: "",
            hasCallbackFunction: true
        };

        bars.ui.getMetaDataNdiTable("META_TABLES", function (selectedItem) {
            if (!selectedItem.SEMANTIC || !selectedItem.TABID || !selectedItem.TABNAME) return;

            dataItem.SEMANTIC = selectedItem.SEMANTIC;
            dataItem.TABID = selectedItem.TABID;
            dataItem.TABNAME = selectedItem.TABNAME;
            dataItem.dirty = true;

            mainGrid.refresh();
            colorRows();
        }, options);
    };

    function getColData(context) {
        var mg = $("#gridMain").data("kendoGrid");
        var row = $(context).closest("tr");

        var colIdx = $("td", row).index(context);

        return {
            title: mg.columns[colIdx].title || "",
            field: mg.columns[colIdx].field || ""
        }
    };

    function encodingEditor(container, options) {
        $('<input data-bind="value:' + options.field + '"/>')
          .appendTo(container)
          .kendoDropDownList({
              valuePrimitive: true,
              autoBind: false,
              dataTextField: "NAME",
              dataValueField: "NAME",
              dataSource: encodingDataSource
          });
    };

    $(".k-grid-custom-cancel").click(function () {
        updateMainGrid();
    });

    $(".k-grid-custom-update").click(function () {
        bars.ui.loader('body', true);

        var grid = $("#gridMain").data("kendoGrid");
        var gridRows = grid.tbody.find("tr");

        gridRows.each(function (e) {
            var rowItem = grid.dataItem($(this));
            if (rowItem.dirty == true) {
                updateRow(rowItem);
            }
        });
        colorRows();
        bars.ui.loader('body', false);
    });

    $(".k-grid-custom-add").click(function () {
        var grid = $("#gridMain").data("kendoGrid");

        var dataSource = grid.dataSource;
        dataSource.insert(0, {});
        dataSource.data()[0].dirty = true;

        grid.editRow(grid.tbody.children().first());
        colorRows();
    });

    $(".k-grid-custom-sync-all").click(function () {
        bars.ui.loader('body', true);

        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/SyncAllTabs"),
            success: function (data) {
                bars.ui.loader('body', false);
                if (data.Result != "OK") {
                    bars.ui.error({ text: "При синхронізації відбулись помилки:<br/>" + data.ErrorMsg });
                } else {
                    bars.ui.alert({ text: "Синхронізація таблиць пройшла успішно." });
                }
            }
        });

        bars.ui.loader('body', false);
    });

    $(".k-grid-custom-sync").click(function () {
        var grid = $("#gridMain").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null) {
            bars.ui.alert({ text: "Необхідно обрати рядок для синхронізації." });
            return;
        }

        SyncTable(selectedItem);
    });

    $(".k-grid-custom-diff").click(function () {
        var grid = $("#gridMain").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null) {
            bars.ui.alert({ text: "Необхідно обрати рядок для відображення відмінностей." });
            return;
        }
        if (selectedItem.S_SELECT == null || selectedItem.S_SELECT == "") {
            bars.ui.alert({ text: "Для таблиці <br/>" + selectedItem.SEMANTIC + "<br/> не вказаний параметр 'SQL SELECT'." });
            return;
        }

        var postData = {
            sql: selectedItem.S_SELECT
        };

        bars.ui.loader('body', true);
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/ExecuteSelect"),
            data: postData,
            success: function (data) {
                bars.ui.loader('body', false);
                if (data.Result != "OK")
                    bars.ui.error({ text: "Відбулась помилка <br/>" + data.ErrorMsg })
                else {
                    if (data.ResultObj != "")
                        diffForm(data.ResultObj, selectedItem);
                    else
                        bars.ui.alert({ text: "Відмінностей не виявлено" })
                }
            }
        });
    });

    $(".k-grid-custom-delete").click(function () {
        var grid = $("#gridMain").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null) {
            bars.ui.alert({ text: "Нічого не вибрано = Нічого не видалено." });
            return;
        }

        bars.ui.confirm(
          { text: 'Дані по таблиці <b>' + selectedItem.SEMANTIC + '</b> будуть видалені.<br/>Продовжити ?' },
           function () {
               deleteRow(selectedItem);
           });
    });

    $(".k-grid-custom-upload-file").click(function () {
        var grid = $("#gridMain").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null || selectedItem == undefined) {
            bars.ui.alert({ text: "Не вибрано рядок." });
            return;
        };
        $("#FileBrowserDialog").val("");

        checkFile(selectedItem.TABID, "", selectedItem.FILE_NAME);
    });

    $(".k-grid-custom-export").click(function () {
        var grid = $("#gridMain").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null || selectedItem == undefined) {
            bars.ui.alert({ text: "Не вибрано рядок." });
            return;
        };

        exportToSql(selectedItem);
    });
};

function exportToSql(selectedItem) {
    window.location = bars.config.urlContent("/SyncTablesEditor/SyncTablesEditor/GetSqlFile?tabId=" + selectedItem.TABID + "&tabName=" + selectedItem.TABNAME);
    //bars.ui.loader('body', true);
    //$.ajax({
    //    type: "GET",
    //    //url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/ExportTableToSql?tabId=" + selectedItem.TABID),
    //    url: bars.config.urlContent("/SyncTablesEditor/SyncTablesEditor/GetSqlFile?tabId=" + selectedItem.TABID + "&tabName=" + selectedItem.TABNAME),
    //    success: function (data) {
    //        bars.ui.loader('body', false);
    //        if (data.Result != "OK") {
    //            bars.ui.error({ text: data.ErrorMsg });
    //        } else {
    //            var xz = data.ResultMsg;
    //            ShowWindowWithText(data.ResultMsg, "Експорт таблиці <b>" + selectedItem.SEMANTIC + "</b> у SQL сценарій");
    //        }
    //    }
    //});
};

function checkFile(tabId, filePath, fileName) {
    var postData = {
        TabId: tabId,
        FilePath: filePath
    };
    uploadFileGlobalData = postData;
    uploadFileGlobalData.FILE_NAME = fileName;
    bars.ui.loader('body', true);
    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/CheckFile"),
        data: postData,
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                bars.ui.error({ text: data.ErrorMsg });
            } else {
                if (data.FileExists == true) {

                    var _readDate = createDate(data.FileDate);
                    var realFileDate = (_readDate).valueOf();
                    var _sqlDate = createDate(data.FileDateFromSql);
                    var sqlFileDate = (_sqlDate).valueOf();

                    if (sqlFileDate > realFileDate || sqlFileDate == realFileDate) {
                        if (sqlFileDate > realFileDate) {
                            bars.ui.confirm(
                                { text: "Дата імпортованого файлу менше за дату останнього поновлення довідника!<br/><em>Продовжити?</em>" },
                                function () {
                                    uploadFile(uploadFileGlobalData.TabId, uploadFileGlobalData.FilePath);
                                });
                        }
                        if (sqlFileDate == realFileDate) {
                            bars.ui.confirm(
                                { text: "Дата створення обраного файлу збігається з датою створення вже імпортованого файлу!<br/><em>Продовжити?</em>" },
                                 function () {
                                     uploadFile(uploadFileGlobalData.TabId, uploadFileGlobalData.FilePath);
                                 });
                        }
                    } else {
                        uploadFile(uploadFileGlobalData.TabId, uploadFileGlobalData.FilePath);
                    }

                } else {
                    bars.ui.confirm(
                              { text: 'При спробі прочитати файл ' + data.FilePath + ' відбулась помилка : файл не знайдено або відсутній доступ.<br/><em>Обрати файл вручну ?</em>' },
                               function () {
                                   //selectFile(uploadFileGlobalData.FILE_NAME);
                                   showFileBrowserDialog();
                               });
                }
            }
        }
    });
};

function createDate(valFromWebApi) {
    var _dateStr = valFromWebApi;
    var _date = _dateStr.split("T")[0];

    var days = _date.split("-")[2];
    var months = _date.split("-")[1];
    var years = _date.split("-")[0];

    var someDate = new Date(years, months - 1, days);

    return someDate;
};

function selectFile(desiredName) {
    var dName = desiredName + ".DBF";

    var selectedFilePath = $("#FileBrowserDialog").val();
    if (selectedFilePath == "") return;

    var selectedFileName = selectedFilePath.substr(selectedFilePath.lastIndexOf('\\') + 1);

    if (dName != selectedFileName) {
        bars.ui.confirm(
            { text: "Назва файлу повинна відповідати налаштуванням(<b>" + dName + "</b>).<br/>Щоб обрати файл з іншою назвою, необхідно змінити налаштування для таблиці.<br/><em>Обрати файл ще раз ?</em>" },
             function () {
                 showFileBrowserDialog();
                 //selectFile(uploadFileGlobalData.FILE_NAME);
             });
    } else {
        var n = selectedFilePath.toUpperCase().indexOf("FAKEPATH");
        //var n = true;
        if (n >= 0) {
            tryToPostFile();
        } else {
            checkFile(uploadFileGlobalData.TabId, selectedFilePath, uploadFileGlobalData.FILE_NAME);
        }
    }
};

function tryToPostFile() {
    var _ff = document.getElementById("FileBrowserDialog");
    var file = document.getElementById("FileBrowserDialog").files[0];
    var fDate = new Date(file.lastModifiedDate);

    bars.ui.loader('body', true);
    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/GetFileLastChangeDate?tabId=" + uploadFileGlobalData.TabId),
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                bars.ui.error({ text: data.ErrorMsg });
            } else {
                var realFileDate = fDate.valueOf();
                var sqlFileDate = (new Date(data.ResultMsg)).valueOf();

                if (sqlFileDate > realFileDate || sqlFileDate == realFileDate) {
                    if (sqlFileDate > realFileDate) {
                        bars.ui.confirm(
                            { text: "Дата імпортованого файлу менше за дату останнього поновлення довідника!<br/><br/><em>Продовжити?</em>" },
                            function () {
                                sendSelectedFileDirectly();
                            });
                    }
                    if (sqlFileDate == realFileDate) {
                        bars.ui.confirm(
                            { text: "Дата створення обраного файлу збігається з датою створення вже імпортованого файлу!<br/><br/><em>Продовжити?</em>" },
                             function () {
                                 sendSelectedFileDirectly();
                             });
                    }
                } else {
                    sendSelectedFileDirectly();
                }
            }
        }
    });
};

function sendSelectedFileDirectly() {
    var a = window.FormData;
    var formData = new a();
    var file = document.getElementById("FileBrowserDialog").files[0];

    formData.append("fileToUpload", file);

    var fDate = new Date(file.lastModifiedDate);

    var days = fDate.getDate();
    var month = fDate.getMonth() + 1;
    var year = fDate.getFullYear();
    var _fDate = (days < 10 ? '0' + days : days) + "." + (month < 10 ? '0' + month : month) + "." + year;

    formData.append("lastModifDate", _fDate);
    formData.append("tabId", uploadFileGlobalData.TabId);

    bars.ui.loader('body', true);
    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/RecieveFile"),
        data: formData,
        processData: false,
        contentType: false,
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                bars.ui.error({ text: data.ErrorMsg });
            } else {
                bars.ui.alert({ text: "Файл " + uploadFileGlobalData.FILE_NAME + ".DBF успішно завантажено." })
            }
        }
    });
};

function showFileBrowserDialog() {
    var file = new fileBrowserDialogCtor("FileBrowserDialog");
    file.clear();
    file.showDialog();
};

function fileSelectionChanged() {
    var path = $("#FileBrowserDialog").val();
    if (path == "" || path == null) return;

    selectFile(uploadFileGlobalData.FILE_NAME);
};

function uploadFile(tabId, filePath) {
    var postData = {
        TabId: tabId,
        FilePath: filePath
    };
    bars.ui.loader('body', true);
    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/UploadFile"),
        data: postData,
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                bars.ui.error({ text: data.ErrorMsg });
            } else {
                bars.ui.alert({ text: "Файл " + filePath + " успішно завантажено." });
            }
        }
    });
};

function colorRows() {
    var mainGrid = $("#gridMain").data("kendoGrid");
    var trInTbodyArr = $("tbody").find("tr");

    trInTbodyArr.each(function () {
        if (mainGrid.dataItem($(this)).dirty == true) {
            $(this).addClass('cyan');
        } else {
            $(this).removeClass('cyan');
        }
    });
};

function CreateToolTip(colNumber, propName) {
    $("#gridMain").kendoTooltip({
        filter: "td:nth-child(" + colNumber + ")",
        position: "top",
        showOn: "mouseenter",
        width: "auto",
        autoHide: true,
        animation: {
            close: {
                effects: "fade:out",
                duration: 1
            },
            open: {
                effects: "fade:in",
                duration: 500
            }
        },
        beforeShow: function (e) {
            var dataItem = $("#gridMain").data("kendoGrid").dataItem(e.target.closest("tr"));
            var cont = dataItem[propName];
            if (cont == null || cont == "") {
                e.preventDefault();
            }
        },
        content: function (e) {

            var dataItem = $("#gridMain").data("kendoGrid").dataItem(e.target.closest("tr"));

            var content = dataItem[propName];
            if (content == null || content == "") {
                content = "";
            }
            return content;
        }
    }).data("kendoTooltip");
};

function CellEditForm(dataItem, fieldName, colTitle, tableName) {
    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: "Редагування " + colTitle + " запиту для таблиці '" + tableName + "'",
        resizable: false,
        modal: true,
        draggable: false,
        animation: {
            close: {
                effects: "fade:out",
                duration: 5
            },
            open: {
                effects: "fade:in",
                duration: 5
            }
        },
        activate: function () {
            $('#sqlText').focus();
        },
        deactivate: function () {
            this.destroy();
        }
    });

    var template = kendo.template($("#cell-edit-form").html());
    var textAreaData = dataItem[fieldName] == null ? "" : dataItem[fieldName];

    kendoWindow.data("kendoWindow")
        .content(template(textAreaData.trim()))
        .center().maximize().open();

    kendoWindow
        .find("#btnCancel")
            .click(function () {
                kendoWindow.data("kendoWindow").close();
            })
            .end();

    kendoWindow
            .find("#btnSave")
                .click(function () {
                    var grid = $("#gridMain").data("kendoGrid");

                    var someText = $("#sqlText").val().trim();
                    dataItem[fieldName] = someText;
                    dataItem.dirty = true;
                    grid.refresh();

                    kendoWindow.data("kendoWindow").close();
                    colorRows();
                }).end();
};

function ShowWindowWithText(text, title) {
    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: title,
        resizable: false,
        modal: true,
        draggable: false,
        animation: {
            close: {
                effects: "fade:out",
                duration: 5
            },
            open: {
                effects: "fade:in",
                duration: 5
            }
        },
        activate: function () {
            $('#some-text').focus();
        },
        deactivate: function () {
            this.destroy();
        }
    });

    var template = kendo.template($("#text-info").html());
    var textAreaData = text == null ? "" : text;

    kendoWindow.data("kendoWindow")
        .content(template(textAreaData.trim()))
        .center().maximize().open();

    kendoWindow
        .find("#btnCancel")
            .click(function () {
                kendoWindow.data("kendoWindow").close();
            })
            .end();
};

function diffForm(data, selectedItem) {
    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: 'Відмінності для таблиці "' + selectedItem.SEMANTIC + '"',
        resizable: false,
        modal: true,
        width: "80%",
        height: "650px",
        pinned: true,
        animation: {
            close: {
                effects: "fade:out",
                duration: 5
            },
            open: {
                effects: "fade:in",
                duration: 5
            }
        },
        deactivate: function () {
            this.destroy();
        }
    });

    var columnsArr = [];
    for (var key in data[0]) {
        if (data[0].hasOwnProperty(key)) {
            //if ($.isNumeric(key[0]))
            //    columnsArr.push("_" + key);
            //else
            //    columnsArr.push(key);
            if (!$.isNumeric(key[0]))
                columnsArr.push(key);
        }
    };

    var dataArr = [];
    for (var i = 0; i < data.length; i++) {
        var tmpObj = {};
        for (var key in data[i]) {
            if (data[i].hasOwnProperty(key)) {
                //if ($.isNumeric(key[0]))
                //    tmpObj["_" + key] = data[i][key];
                //else
                //    tmpObj[key] = data[i][key];
                tmpObj[key] = data[i][key];
            }
        };
        dataArr.push(tmpObj);
    };

    var template = kendo.template($("#diff-form").html());
    kendoWindow.data("kendoWindow").content(template).center().open();

    kendoWindow
        .find("#btnCancel")
            .click(function () {
                kendoWindow.data("kendoWindow").close();
            })
            .end();

    kendoWindow
     .find("#modalGrid").kendoGrid({
         dataSource: {
             data: dataArr,
             pageSize: 10
         },
         scrollable: true,
         sortable: true,
         resizable: true,
         selectable: "row",
         pageable: {
             refresh: true,
             messages: {
                 empty: "Таблиці ідентичні"
             },
             buttonCount: 5
         },
         pageSize: 10,
         columns: columnsArr,
         dataBound: function () {
             var a = $("#modalGrid").find("tr");
             $("#modalGrid").find("tr").each(function () {
                 var mainGrid = $("#modalGrid").data("kendoGrid");

                 if (mainGrid.dataItem($(this))[1] == 1) {
                     $(this).addClass('darkGreen')
                 }
                 if (mainGrid.dataItem($(this))[1] == 2) {
                     $(this).addClass('darkBlue')
                 }
                 if (mainGrid.dataItem($(this))[1] == 3) {
                     $(this).addClass('darkRed')
                 }
             });
         }
     }).end();
};

function SyncTable(dataItem) {
    var postData = {
        TABID: dataItem.TABID
    };

    bars.ui.loader('body', true);
    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/SyncTab"),
        data: postData,
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                bars.ui.error({ text: "Відбулась помилка при синхронізації таблиці: " + dataItem.TABID + " " + dataItem.TABNAME + " " + dataItem.SEMANTIC + "<br/>" + data.ErrorMsg });
            } else {
                bars.ui.alert({ text: "Успішно синхронізовано таблицю:" + dataItem.TABID + " " + dataItem.TABNAME + " " + dataItem.SEMANTIC });
            }
        }
    });
};
function deleteRow(dataItem) {
    var postData = {
        TABID: dataItem.TABID
    };

    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/DeleteRow"),
        data: postData,
        success: function (data) {
            if (data.Result != "OK") {
                bars.ui.error({ text: "Відбулась помилка при видаленні даних :<br/>" + data.ErrorMsg });
            } else {
                bars.ui.alert({ text: "Запис успішно видалено." });
                updateMainGrid();
            }
        }
    });
};

function updateRow(dataItem) {
    var postData = {
        TABID: dataItem.TABID,
        S_SELECT: dataItem.S_SELECT,
        S_INSERT: dataItem.S_INSERT,
        S_UPDATE: dataItem.S_UPDATE,
        S_DELETE: dataItem.S_DELETE,
        ENCODE: dataItem.ENCODE,
        SEMANTIC: dataItem.SEMANTIC,
        TABNAME: dataItem.TABNAME,
        FILE_NAME: dataItem.FILE_NAME
    };

    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/SyncTablesEditor/SyncTablesEditor/SetRow"),
        data: postData,
        success: function (data) {
            if (data.ErrorMsg === null || data.ErrorMsg === "") {
                dataItem.dirty = false;
            } else {
                dataItem.dirty = true;
            }
            colorRows();
        }
    });
};

var encodingDataSource = new kendo.data.DataSource({
    data: {
        "items": [
          {
              "NAME": "DOS",
          },
          {
              "NAME": "UKG",
          },
          {
              "NAME": "WIN"
          }
        ]
    },
    schema: {
        data: "items",
        model: {
            fields: {
                NAME: { type: "string" }
            }
        }
    }
});

function fileBrowserDialogCtor(elemId) {

    var openFileDialog = elemId;

    this.showDialog = function () {
        document.getElementById(openFileDialog).click();
    }
    this.fileName = function () {
        var tmp = $('#' + openFileDialog).val();
        console.log(tmp);
        return tmp;
    }
    this.hasFile = function () {
        return document.getElementById(openFileDialog).value != "";
    }
    this.fileNameWithoutFakePath = function () {
        var fileName = document.getElementById(openFileDialog).value;
        return fileName.substr(fileName.lastIndexOf('\\') + 1);
    }
    this.fakePathWithoutFileName = function () {
        var fileName = document.getElementById(openFileDialog).value;
        return fileName.substr(0, fileName.lastIndexOf('\\'));
    }
    this.clear = function () {
        var $el = $('#' + openFileDialog);
        $el.wrap('<form>').closest('form').get(0).reset();
        $el.unwrap();
    };
};

$(document).ready(function () {
    $("#title").html("Редагування таблиць, що синхронізуються");

    initMainGrid();

    $(document).keyup(function (e) {
        if (e.keyCode == 27) {
            var visibleWindow = $(".k-window:visible > .k-window-content");
            if (visibleWindow.length)
                visibleWindow.data("kendoWindow").close();
        }
    });

    $("#FileBrowserDialog").change(fileSelectionChanged);
});