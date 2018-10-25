function initFileUploader() {
    var selector = '#fileUploader';

    var kUpload = $(selector).kendoUpload({
        multiple: false,
        localization: {
            select: 'Обрати файл'
        },
        async: {
            saveUrl: bars.config.urlContent("/api/PRVN/SrrCost/RecieveFile"),
            autoUpload: false
        },
        showFileList: false,
        select: function (e) {
            var file = e.files[0];
            if (file == null || file === undefined) {
                e.preventDefault();
                return;
            }

            var extensions = $(selector).attr('accept').split(',');
            if (+extensions.indexOf(file.extension.toLowerCase()) == -1) {
                bars.ui.error({ text: "Не коректний файл!<br/>Оберіть файл з розширенням зі списку : <br/><b>" + extensions.join('<br/>') + "</b>" });
                e.preventDefault();
                return;
            }

            bars.ui.confirm({
                text: 'Завантажити файл <b>' + e.files[0].name + '</b> ?'
            }, function () {
                $('.k-upload-selected').click();
            });
        },
        upload: function (e) {
            bars.ui.loader('body', true);
        },
        success: successUploadCb,
        error: function (e) {
            bars.ui.error({ text: "При завантаженні файлу <b>" + e.files[0].name + "</b> відбулась помилка : <br/>" + e.XMLHttpRequest.responseText });
        },
        complete: function () {
            bars.ui.loader('body', false);
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

function successUploadCb(e) {
    var resp = e.response;
    if (resp.hasErrors == 0) {
        $('#uploadResults').addClass('invisible');
        destroyErrorsGrid();
        bars.ui.alert({ text: "Файл <b>" + e.files[0].name + "</b> успішно завантажено!" });
    } else {
        bars.ui.alert({ text: "Файл <b>" + e.files[0].name + "</b> завантажено з помилками!</br>Виправте помилки та перезавантажте файл." });
        initErrorGrid(resp.errors);
        $('#uploadResults').removeClass('invisible');
        $('#errorFileName').text(e.files[0].name);
    }
};

function destroyErrorsGrid() {
    var _grid = $('#uploadErrors').data('kendoGrid');
    if (_grid) _grid.destroy();

    $('#uploadErrors').empty();
};

function initErrorGrid(dataArr) {
    destroyErrorsGrid();

    var mainGridOptions = {
        dataSource: dataArr,
        reorderable: false,
        resizable: true,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        columns: [
            { field: "ErrorText", title: "Помилка", width: "250px" },
            { field: "RNK_CLIENT", title: "RNK_CLIENT", width: "120px" },
            { field: "CLIENT_NAME", title: "CLIENT_NAME", width: "350px" },
            {
                field: "ID_CALC_SET", title: "ID_CALC_SET", width: "150px",
                template: "#= ID_CALC_SET == 0 ? '' : ID_CALC_SET #"
            },
            { field: "UNIQUE_BARS_IS", title: "UNIQUE_BARS_IS", width: "200px" },
            { field: "ID_BRANCH", title: "ID_BRANCH", width: "120px" },
            { field: "ID_CURRENCY", title: "ID_CURRENCY", width: "150px" },
            { field: "FV_CCY", title: "FV_CCY", width: "300px" },
            { field: "COMM", title: "COMM", width: "250px" }
        ],
        selectable: "row",
        editable: false,
        scrollable: true
    };

    $('#uploadErrors').kendoGrid(mainGridOptions);
};


$(document).ready(function () {
    $("#title").html("Завантаження результатів розрахунків справедливої вартості SRR (XLSX)");

    initFileUploader();
});