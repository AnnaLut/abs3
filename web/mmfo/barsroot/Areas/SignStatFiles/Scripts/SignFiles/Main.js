var formCfg = {
    pageCount: 15,
    gridSelector: '#MainFilesGrid',
    updateGrid: function () {
        var _grid = $(this.gridSelector).data('kendoGrid');
        if (_grid)
            _grid.dataSource.read();
    },
    allowedFilesExts: [],
    processBtnSelector: '#btnProcessRow'
};

function initMainGrid() {
    var dataSourceObj = {
        type: "webapi",
        requestEnd: function () {
            changeProcessBtnText('');
            $('#btnRevert, #bntloadSignedEnvelope').addClass('invisible');
        },
        transport: {
            read: {
                type: "POST",
                url: bars.config.urlContent("/api/SignStatFiles/SignFiles/SearchAllFiles"),
                dataType: "json"
            }
        },
        pageSize: formCfg.pageCount,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    FileId: { type: 'number' },
                    FileName: { type: 'string' },
                    FileTypeName: { type: 'string' },
                    FileDate: { type: 'string' },
                    LoadUserPib: { type: 'string' },
                    LoadDate: { type: 'date' },
                    FileStatus: { type: 'number' },
                    FileStatusName: { type: 'string' },
                    StatusDate: { type: 'date' },
                    OperationId: { type: 'number' },
                    OperationName: { type: 'string' },
                    NeedSign: { type: 'string' },
                    StorageId: { type: 'number' },
                    Completed: { type: 'number' },
                    Load: { type: 'number' }
                }
            }
        }
    };

    var mainGridDataSource = new kendo.data.DataSource(dataSourceObj);

    var mainGridOptions = {
        toolbar: getToolBar(),
        dataSource: mainGridDataSource,
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSizes: [formCfg.pageCount, 25, 50, 200, 1000, "All"],
            buttonCount: 5
        },
        reorderable: false,
        resizable: true,
        columns: [
            {
                field: 'FileId', title: 'Номер файлу', width: 100
            },
            {
                field: 'FileName', title: 'Назва файлу', width: 200
            },
            {
                field: 'FileTypeName', title: 'Тип файлу', width: 500
            },
            {
                field: 'FileDate', title: 'Звітна дата', width: 100
            },
            {
                field: 'LoadDate', title: 'Дата завантаження', width: 160,
                template: '#= LoadDate ? LoadDate.format() : "" #'
            },
            {
                field: 'LoadUserPib', title: 'Завантажив (ПІБ)', width: 250
            },
            {
                field: 'FileStatusName', title: 'Статус файлу', width: 250
            },
            {
                filed: 'StatusDate', title: 'Час зміни статусу', width: 180,
                template: '#= StatusDate ? StatusDate.format("dd.MM.yyyy hh:mm:ss") : "" #'
            }
        ],
        selectable: "row",
        editable: false,
        scrollable: true,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function () {
            var mainGrid = $(formCfg.gridSelector).data("kendoGrid");
            var trInTbodyArr = $(formCfg.gridSelector).find(".k-grid-content tr:not(th)");

            for (var i = 0; i < trInTbodyArr.length; i++) {
                if (+mainGrid.dataItem(trInTbodyArr[i]).Completed === 1)
                    $(trInTbodyArr[i]).addClass('green-tr');
            }
        },
        detailInit: detailInit,
        change: rowSelectionChange
    };

    $(formCfg.gridSelector).kendoGrid(mainGridOptions);
}
function rowSelectionChange() {
    var grid = $(formCfg.gridSelector).data('kendoGrid');
    var selected = grid.select();
    var dataItem = grid.dataItem(selected);
    var _operName = dataItem.OperationName;

    changeProcessBtnText(_operName);

    var method = dataItem.FileStatus === 1 || dataItem.Completed === 1 ? 'addClass' : 'removeClass';
    $('#btnRevert')[method]('invisible');
    $('#bntloadSignedEnvelope')[dataItem.Load === 1 ? 'removeClass' : 'addClass']('invisible');
}
function getToolBar() {
    return [
        { template: '<a class="k-button invisible" title="Завантажити файл" id="btnLoadFile" onclick="toolBarBtnClick(this);" ><i class="pf-icon pf-16 pf-arrow_download"></i> Завантажити файл</a>' },
        { template: '<a class="k-button" id="btnProcessRow" onclick="toolBarBtnClick(this);" ><i class="pf-icon pf-16 pf-execute"></i></a>' },
        { template: '<a class="k-button" title="Скасувати останню операцію" id="btnRevert" onclick="toolBarBtnClick(this);" ><i class="pf-icon pf-16 pf-visa_back"></i> Скасувати</a>' },
        { template: '<a class="k-button invisible" title="Вивантажити підписаний конверт" id="bntloadSignedEnvelope" onclick="toolBarBtnClick(this);" ><i class="pf-icon pf-16 pf-arrow_download"></i> Вивантажити підписаний конверт</a>' }
    ];
}

function detailInit(e) {
    $("<div/>").appendTo(e.detailCell).kendoGrid({
        dataSource: {
            type: "webapi",
            requestEnd: function () {
            },
            transport: {
                read: {
                    url: bars.config.urlContent("/api/SignStatFiles/SignFiles/SearchFileDetails?fileId=" + e.data.FileId),
                    dataType: "json"
                }
            },
            pageSize: formCfg.pageCount,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        Name: { type: 'string' },
                        UserPib: { type: 'string' },
                        OperDate: { type: 'date' }
                    }
                }
            }
        },
        columns: [
            {
                field: 'Name', title: 'Операція'
            },
            {
                field: 'UserPib', title: 'ПІБ виконавця'
            },
            {
                field: 'OperDate', title: 'Дата/час',
                template: '#= OperDate ? OperDate.format("dd.MM.yyyy hh:mm:ss") : "" #'
            }
        ]
    });
}

function toolBarBtnClick(that) {
    toolBarHandlers[that.id].apply();
}
var toolBarHandlers = {
    btnLoadFile: function () {
        FilesForm(formCfg.allowedFilesExts, function (row) {
            bars.ui.loader('body', true);
            $.ajax({
                type: 'GET',
                url: bars.config.urlContent("/api/SignStatFiles/SignFiles/UploadFileToDb"),
                data: {
                    path: row.FullPath
                },
                success: function (data) {
                    bars.ui.alert({ text: 'Файл успішно завантажено' });
                    formCfg.updateGrid();

                    var grid = $(formCfg.gridSelector).data('kendoGrid');
                    grid.items().each(function () {
                        var _data = grid.dataItem(this);
                        if (+_data.FileId === +data) {
                            grid.select(this);
                        }
                    });
                },
                complete: function () {
                    bars.ui.loader('body', false);
                }
            });
        });
    },
    btnProcessRow: function () {
        checkIfRowIsSelected(function () {
            var that = this;

            bars.ui.confirm({
                text: 'Ви дійсно бажаєте виконати операцію <b>"' + that.OperationName + '"</b> по файлу №<b>' + that.FileId + '(' + that.FileName + ')</b>'
            }, function () {
                bars.ui.loader('body', true);

                if (that.NeedSign === 'H') {
                    signFile(that, false);
                } else if (that.NeedSign === 'Y') {
                    // put final sign and call SetFileOperation
                    //setFileOperation(that, 'Візування файлу', 'yes');
                    signFile(that, true);
                } else {
                    setFileOperation(that, that.OperationName);
                }
            });
        });
    },

    btnRevert: function () {
        checkIfRowIsSelected(function () {
            var that = this;

            bars.ui.confirm({
                text: 'Ви дійсно бажаєте скасувати останню операцію по файлу №<b>' + that.FileId + ' (' + that.FileName + ')</b> ?'
            }, function () {
                bars.ui.loader('body', true);
                setFileOperation(that, 'Скасування операції', null, 1);
            });
        });
    },
    bntloadSignedEnvelope: function () {
        checkIfRowIsSelected(function () {
            //bars.ui.notify('Завантаження', 'Завантаження розпочнеться автоматично (Не закривайте браузер).', 'info', {
            //    autoHideAfter: 2.5 * 1000,
            //    width: "350px"
            //});
            //window.location = bars.config.urlContent('/api/SignStatFiles/SignFiles/DownloadResultFile?fileId=' + this.FileId + '&fileName=' + this.FileName);
            // UploadResultFile

            var that = this;

            bars.ui.confirm({
                text: 'Ви дійсно бажаєте вивантажити конверт по файлу №<b>' + that.FileId + ' (' + that.FileName + ')</b> ?'
            }, function () {
                bars.ui.loader('body', true);
                $.ajax({
                    url: bars.config.urlContent('/api/SignStatFiles/SignFiles/UploadResultFile'),
                    data: {
                        fileId: that.FileId,
                        fileName: that.FileName
                    },
                    success: function (data) {
                        bars.ui.alert({ title: 'Повідомлення', text: 'Виконано успішно !' });
                        //formCfg.updateGrid();
                    },
                    complete: function () {
                        bars.ui.loader('body', false);
                    }
                });
            });
        });
    }
};

function signFile(selectedRow, isCAdES) {

    $signer.initSign(function () {
        bars.ui.loader('body', true);
        $.ajax({
            type: 'GET',
            url: bars.config.urlContent('/api/SignStatFiles/SignFiles/GetFileHash'),
            data: {
                storageId: selectedRow.StorageId,
                isCAdES: isCAdES
            },
            success: function (data) {
                if (isCAdES) {                    
                    $signer.signFile(data, function (res) {
                        setFileOperation(selectedRow, selectedRow.OperationName, res.SignFile, false, true);
                    });
                } else {
                    $signer.sign(data, function (res) {
                        setFileOperation(selectedRow, selectedRow.OperationName, res.Sign);
                    });
                }
            }
        });
    });
}

function setFileOperation(selectedItem, title, sign, reverse, isCAdES) {
    title = title || 'Повідомлення';

    var FileOperation =
    {
        FileId: selectedItem.FileId,
        OperationId: selectedItem.OperationId,
        Sign: sign || '',
        Reverse: reverse || 0,
        IsCAdES: isCAdES || false,
        StorageId: selectedItem.StorageId
    };

    $.ajax({
        type: "POST",
        url: bars.config.urlContent('/api/SignStatFiles/SignFiles/SetFileOperation'),
        data: FileOperation,
        success: function (data) {
            bars.ui.alert({ title: title, text: 'Виконано успішно !' });
            formCfg.updateGrid();
        },
        complete: function () {
            bars.ui.loader('body', false);
        }
    });
}

function preInitForm(cb) {
    bars.ui.loader('body', true);

    // в Promise.all передаємо масив промісів, котрі необхідно виконати до завантаження даних у гріди на формі (наприклад підгрузка масивів статусів)
    Promise.all([
        getAllowedExtensions()
    ]).then(
        function (result) {
            bars.ui.loader('body', false);
            if (cb && typeof cb === 'function') {
                cb.apply();
            }
        },
        function (error) {
            var errorText = 'Метод : ' + error.name + '</br>' + error.text;

            showBarsErrorAlert(errorText);
            bars.ui.loader('body', false);
        });
}
function getAllowedExtensions() {
    var promise = new Promise(
        function (resolve, reject) {
            $.ajax({
                type: "GET",
                global: false,
                url: bars.config.urlContent('/api/SignStatFiles/SignFiles/GetAllowedExtensions'),
                success: function (data) {
                    formCfg.allowedFilesExts = data;
                    resolve(true);
                },
                error: function (xhr) {
                    var text;
                    if (xhr.status === 401)
                        document.location.reload();
                    else if (xhr.status === 403)
                        window.location = $.parseJSON(xhr.responseText).LogOnUrl;
                    else if (xhr.status === 400 || xhr.status === 404 || xhr.status === 500) {
                        if (xhr.responseJSON && xhr.responseJSON.Message) text = parseJsonError(xhr.responseJSON);
                        else text = replaseResponseText(xhr.responseText);
                    } else if (xhr.status === 502)
                        document.location.refresh();

                    reject({
                        text: text,
                        name: 'GetAllowedExtensions'
                    });
                }
            });
        });

    return promise;
}

function initButtonsState() {
    if (formCfg.allowedFilesExts && formCfg.allowedFilesExts.length > 0) {
        $('#btnLoadFile').removeClass('invisible');
    }
    enableElem('#btnProcessRow', false);
}

function changeProcessBtnText(text) {
    //if (text === undefined || text == null || text.trim() === '') return;
    text = text || '';
    var btn = $(formCfg.processBtnSelector);
    var i = btn.find('i')[0];
    var iHtml = i.outerHTML;
    btn.html(iHtml + ' ' + text);

    enableElem(formCfg.processBtnSelector, text);
}

function checkIfRowIsSelected(func) {
    var grid = $(formCfg.gridSelector).data('kendoGrid');
    var selected = grid.select();
    if (selected.length === 1) {
        func.apply(grid.dataItem(selected));
        return;
    }
    bars.ui.alert({ text: "Не вибрано жодного рядка." });
}

$(document).ready(function () {
    $('#title').text('Підписання файлів стат звітності');

    // execute this after DOM is loaded
    preInitForm(function () {
        initMainGrid();
        changeGridMaxHeight(0.8, formCfg.gridSelector);
        initButtonsState();
    });
});