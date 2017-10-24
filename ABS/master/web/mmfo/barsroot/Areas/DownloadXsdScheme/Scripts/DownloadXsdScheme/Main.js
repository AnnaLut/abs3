///*** GLOBALS
var PAGE_INITIAL_COUNT = 10;
var gridSelector = "#DownloadXsdSchemeGrid";
var currentDataItem = null;
var additionalUploadInfo = {};
kendo.ui.Upload.fn._supportsDrop = function () { return false; };
///***
function updateMainGrid() {
    var grid = $(gridSelector).data("kendoGrid");
    if (grid) {
        grid.dataSource.read();
        grid.refresh();
    }
}
//---------------------------------------
function initMainGrid() {
    var dataSourceObj = {
        type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/DownloadXsdScheme/DownloadXsdScheme/SearchMain")
            }
        },
        requestEnd: function (e) {
            $("#XsdSchemeFileBrowserDialog").data("kendoUpload").enable(false);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    FILE_ID: { type: 'number', editable: false },
                    FILE_CODE: { type: 'string', editable: false },
                    FILE_NAME: { type: 'string', editable: false },
                    SCHEMA_DATE: { type: 'date' },
                    CHANGE_DATE: { type: 'date', editable: false },
                    XSD: { type: 'string', editable: false }
                }
            }
        }
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
        scrollable: true,
        editable: true,
        toolbar: [
            {
                template: '<div class="btn-group"><input name="testFile" id="XsdSchemeFileBrowserDialog" type="file"/></div>'
            }
        ],
        columns: [
			{
			    field: "FILE_CODE",
			    title: "Код файлу"
			},
			{
			    field: "FILE_NAME",
			    title: "Назва файлу",
			    width: "35%"
			},
			{
			    template: "<div style='text-align:center;'>#=(SCHEMA_DATE == null) ? ' ' : kendo.toString(SCHEMA_DATE,'dd/MM/yyyy')#</div>",
			    field: "SCHEMA_DATE",
			    title: "Дата актуальності схеми"
			},
			{
			    template: "<div style='text-align:center;'>#=(CHANGE_DATE == null) ? ' ' : kendo.toString(CHANGE_DATE,'dd/MM/yyyy')#</div>",
			    field: "CHANGE_DATE",
			    title: "Дата змін"
			},
			{
			    field: "XSD",
			    title: "Шаблон файлу"
			}
        ],
        selectable: "row",
        scrollable: true,
        change: function () {
            currentDataItem = this.dataItem(this.select());
            $("#XsdSchemeFileBrowserDialog").data("kendoUpload").enable(true);
        }
    };

    $(gridSelector).kendoGrid(mainGridOptions);
};
//---------------------------------------
function showFileBrowserDialog() {
    $("#XsdSchemeFileBrowserDialog").click();
};

//==============================
function checkFile(sFile) {
    if (sFile.extension.toLowerCase() != ".xsd") {

        alert('Обраний файл "' + sFile.name + '", не підходить ! Розширення файлу повинно бути ".xsd".')
        return false;
    } else {
        if (sFile.name.toLowerCase() != currentDataItem.XSD.toLowerCase()) {
            if (confirm('Обраний файл "' + sFile.name + '", відрізняється від налаштованого шаблону ("' + currentDataItem.XSD + '") Всеодно завантажити ?')) {
                return true;
            } else {
                return false;
            }
        } else {
            return true;
        }
    }
};

function initKendoUpload() {
    $("#XsdSchemeFileBrowserDialog").kendoUpload({
        multiple: false,
        success: function () {
            alert("OK");
        },
        localization: {
            select: "Завантажити XSD-схему"
        },
        async: {
            saveUrl: bars.config.urlContent("/api/DownloadXsdScheme/DownloadXsdScheme/RecieveFile")
        },
        showFileList: false,
        select: function (e) {
            var grid = $(gridSelector).data("kendoGrid");
            currentDataItem = grid.dataItem(grid.select());

            if (currentDataItem == null) {
                bars.ui.alert({ text: "Необхідно обрати рядок." });
                e.preventDefault();
            }

            var sDate = kendo.parseDate(currentDataItem.SCHEMA_DATE, "dd/MM/yyyy");
            if (sDate == null) {
                if (!confirm("Не введено дату актуальності схеми. Використати поточну банківську дату і продовжити ?")) {
                    e.preventDefault();
                }
            }

            var file = e.files[0];
            if (file == null || file === undefined) return;

            if (!checkFile(file)) {
                e.preventDefault();
            }
        },
        upload: function (e) {
            bars.ui.loader("body", true);
            var sDate = kendo.parseDate(currentDataItem.SCHEMA_DATE, "dd/MM/yyyy");
            if (sDate != null) {
                sDate = kendo.toString(sDate, "dd/MM/yyyy");
            } else {
                sDate = "";
            }

            e.data = {
                Date: sDate,
                fileId: currentDataItem.FILE_ID,
                selectedFileName: e.files[0].name,
                desiderFileName: currentDataItem.XSD
            };
        },
        success: function (e) {
            bars.ui.loader("body", false);
            console.log(e);
            if (e.response.Result != "OK") {
                bars.ui.error({ text: "При завантаженні файлу відбулась помилка : <br/>" + e.response.ErrorMsg });
            } else {
                bars.ui.alert({ text: "Файл <b>" + e.files[0].name + "</b> успішно завантажено" });
                updateMainGrid();
                $("#XsdSchemeFileBrowserDialog").data("kendoUpload").enable(false);
            }
        },
        error: function (e) {
            bars.ui.loader("body", false);
        }
        //dropZone: null
    });
    //$(".k-upload-button").hide();
    //$(".k-dropzone").hide();
    $('.k-upload-selected').css('visibility', 'hidden');
};

var sumsArrays = {};

//function openTestKendoWindow(self) {

//    if (!self.id) self = self.currentTarget;

//    var newId = self.id;
//    var wId = newId + '_mwindow';
//    if (!sumsArrays[newId]) sumsArrays[newId] = [];

//    var count = +getAttrFromCurrenttarget(self, "data-count");
//    if (count <= 0 || count > 12) return;

//    var kendoWindow = $('<div id="' + wId + '" />').kendoWindow({
//        actions: [],
//        title: "Введіть суми доходу за " + count + " місяців",
//        resizable: false,
//        modal: true,
//        draggable: true,
//        animation: {
//            close: {
//                effects: "fade:out",
//                duration: 300
//            },
//            open: {
//                effects: "fade:in",
//                duration: 300
//            }
//        },
//        deactivate: function () {
//            addEscEventForKWindows(false);
//            this.destroy();
//        },
//        activate: function () {
//            if ($("input[value='0']:first").data("kendoNumericTextBox"))
//                $("input[value='0']:first").data("kendoNumericTextBox").focus();

//            //$("input[name*='0']").data("kendoNumericTextBox").focus();

//            bindSelectOnFocus("#" + wId);
//        },
//        width: "400px"
//    });

//    var template = kendo.template(createQuestionWindowContent({
//        count: count,
//        oladValues: sumsArrays[newId]
//    }));

//    kendoWindow.data("kendoWindow").content(template({})).center().open();

//    addEscEventForKWindows(true);
//    kendoWindow.find("input[name*='monthInput']").kendoNumericTextBox(getNumericOptions());

//    kendoWindow.find("#btnCancel")
//            .click(function () {
//                kendoWindow.data("kendoWindow").close();
//            }).end();

//    kendoWindow.find("#btnSave")
//                .click(function () {
//                    sumsArrays[newId] = [];

//                    var inputs = $("#" + wId).find("input[name*='monthInput']");
//                    var total = 0;
//                    var allValid = true;

//                    for (var j = 0; j < inputs.length; j++) {
//                        var curr = +$(inputs[j]).val();
//                        if (curr == 0 || curr == 0) allValid = false;

//                        total += curr;
//                        sumsArrays[newId].push(curr);
//                    }
//                    if (allValid)
//                        $("#" + newId).val((total / count).toFixed(2));
//                    else
//                        $("#" + newId).val("");
//                    kendoWindow.data("kendoWindow").close();
//                }).end();
//};

//function createQuestionWindowContent(data) {
//    var resultStr = "";

//    var i = 0;
//    var months = ["перший", "другий", "третій", "четвертий", "п'ятий", "шостий", "сьомий", "восьмий", "дев'ятий", "десятий", "одинадцятий", "дванадцятий"];
//    for (i = 0; i < data.count; i++) {
//        var val = data.oladValues[i] ? 'value="' + data.oladValues[i] + '"' : 'value="0"';
//        //'value="0"'
//        var tabIndx = i + 1;
//        var tmpR = '<div class="row">';
//        tmpR += '<div class="col-md-12" style="margin:3px;">';
//        tmpR += '<label class="k-label" style="width:180px !important;" for="month' + i + '">Сума за ' + months[i] + ' місяць: </label>';
//        tmpR += '<input id="month' + i + '" name="monthInput' + i + '" tabindex="' + tabIndx + '" ' + val + ' required>';
//        tmpR += '<span class="k-invalid-msg" data-for="month' + i + '"></span>';
//        tmpR += '</div></div>';
//        resultStr += tmpR;
//    }

//    resultStr += '<div class="k-edit-buttons k-state-default">';
//    resultStr += '<a id="btnCancel" class="k-button k-button-icontext k-grid-cancel" style="float:right;margin:7px 5px 7px 5px;" tabindex="15"><span class="k-icon k-cancel"></span>Скасувати</a>';
//    resultStr += '<a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update" style="float:right;margin:7px 5px 7px 5px;" tabindex="14"><span class="k-icon k-update"></span> Ok</a>';
//    resultStr += '</div>';

//    return resultStr;
//};

//function getNumericOptions(options) {
//    if (options === undefined || options == null) options = {};
//    options = $.extend(
//        {
//            min: 0,
//            spinners: false,
//            decimals: 2,
//            restrictDecimals: true,
//            format: "n2",
//            change: function () {
//                var value = this.value();
//                if (value == null || $.trim(value) == "")
//                    this.value(0);
//            }
//        },
//        options
//    );
//    return options;
//};

function getAttrFromCurrenttarget(cTarget, name) {
    if (!cTarget.attributes) return "";
    for (var i = 0; i < cTarget.attributes.length; i++) {
        if (cTarget.attributes[i].name == name) {
            return cTarget.attributes[i].nodeValue;
        }
    }
    return "";
};

function bindSelectOnFocus(selector) {
    $(selector).find("input").bind("focus", function () {
        var input = $(this);
        clearTimeout(input.data("selectTimeId"));

        var selectTimeId = setTimeout(function () {
            input.select();
        });

        input.data("selectTimeId", selectTimeId);
    }).blur(function (e) {
        clearTimeout($(this).data("selectTimeId"));
    });
};

function addEscEventForKWindows(on) {
    if (on)
        $(document).on('keyup', escEventHandler);
    else
        $(document).off('keyup', escEventHandler);
};

function escEventHandler(e) {
    if (e.keyCode == 27) {
        var visibleWindow = $(".k-window:visible > .k-window-content");
        if (visibleWindow.length)
            visibleWindow.data("kendoWindow").close();
    }
};

$(document).ready(function () {
    $("#title").html("Завантаження схеми XSD у АБС по файлам стат.звітності");

    initMainGrid();

    initKendoUpload();

    $("#XsdSchemeFileBrowserDialog").data("kendoUpload").enable(false);

    //$("#test2rows").on('focus', openTestKendoWindow);
});