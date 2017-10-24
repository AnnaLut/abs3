var tp_id;
var dsDataOB22;

$(document).ready(function () {
    //
    // kendo
    // 
    $("#tabstrip").kendoTabStrip({
        animation: {
            open: {
                effects: "fadeIn"
            }
        }
    });

    //
    var tabStrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");

    tp_id = bars.extension.getParamFromUrl("type_id", location.href);

    if (tp_id == null) {
        tabStrip.enable(tabStrip.tabGroup.children().eq(1), false);
    }

    var OB22Details = kendo.data.Model.define({
        id: "Id",
        fields: {
        }
    });

    var dataSrcOB22 = new kendo.data.DataSource({
        data: dsDataOB22,
        schema: {
            model: OB22Details
        }
    });

    $("#gridOB22").kendoGrid({
        dataSource: dataSrcOB22,
        columns: [
            {
                field: "TypeId", hidden: true
            },
            {
                field: "parK013", title: "Код виду<br>клієнта<br>K013", width: "50px",
                locked: true,
                lockable: false,
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "parS181", title: "Код<br>строку<br>S181", width: "50px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "parR034", title: "Тип<br>валюти<br>R034", width: "50px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "depR020", title: "Бал.<br>рах.<br>депозиту", width: "70px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "depOB22", title: "ОБ22<br>рах.<br>депозиту", width: "50px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "intR020", title: "Бал.<br>рах.<br>відсотків", width: "70px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "intOB22", title: "ОБ22<br>рах.<br>відсотків", width: "50px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "expR020", title: "Бал.<br>рах.<br>витрат", width: "70px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "expOB22", title: "ОБ22<br>рах.<br>витрат", width: "50px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "rdcR020", title: "Бал.<br>рах.<br>зменшення", width: "50px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                field: "rdcOB22", title: "ОБ22<br>рах.<br>зменшення", width: "70px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: center;" }
            },
            {
                command: [
                    //{ name: "edit", text: { edit: "Редагувати", cancel: "Відмінити", update: "Зберегти" }, className: "btn-edit" },
                    { name: "destroy", text: "Видалити", className: "btn-destroy" }
                ]
            }
        ],
        toolbar: [
            { name: "create", text: "Додати запис" }
        ],
        editable: ("popup"),
        scrollable: true,
        selectable: true,
        pageable: false
    });

    //
    $("#tbTypeId").prop("readOnly", true);
    $("#tbTypeId").css("background-color", "lightgray");
    //
    $("#tbTemplateId").prop("readOnly", true);
    $("#tbTemplateId").css("background-color", "lightgray");
    $("#ddlTemplates").on("change", function () {
        $("#tbTemplateId").val($(this).val());
    });


    // hide button if form open as dialog
    if (window.location != window.parent.location) {
        $("#btnExit").hide();
    }
});

function closeWindow() {
    if (confirm("Закрити поточну вкладку?")) {
        window.open('', '_parent', '');
        window.close();
    }
}

function validateControls() {
    var errMsg = "";
    if ($("#tbTypeName").val() == "") {
        errMsg += "Не вказано назву типу депозиту<br>";
    }
    //if ($("#tbTemplateId").val() == "") {
    //    errMsg += "Не вказано шаблон для друку договору<br>";
    //}
    if (errMsg == "") {
        return true;
    }
    else {
        bars.ui.error({ text: errMsg });
        return false;
    }
}