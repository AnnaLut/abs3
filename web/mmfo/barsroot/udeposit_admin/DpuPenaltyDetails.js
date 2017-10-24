/***********************/
/* v1.1.2 (05/08/2016) */
/***********************/
var dsData;
var selRow;
var pny_id;
var editable;

$(document).ready(function () {

    editable = ( $("#ReadOnlyMode").val() == "1" ? false : true );
    pny_id = bars.extension.getParamFromUrl("penalty_id", location.href);

    //
    // kendo
    //

    var PenaltyDetails = kendo.data.Model.define({
        id: "LowerLimit",
        fields: { // The available options are "string", "number", "boolean", "date"
            PenaltyId: { type: "number", editable: false },
            LowerLimit: {
                type: "number",
                nullable: true,
                // defaultValue: 0,
                editable: false // this field is not editable
            },
            UpperLimit: {
                type: "number",
                validation: {       // validation rules
                    required: true, // the field is required
                    min: 1,         // the minimum value is 1
                    uprLmtMaxValRule: function (input) {
                        if (input.is("[name='UpperLimit']")) {
                            if ($("#tbPeriodId").val() == "0") {
                                input.attr("data-uprLmtMaxValRule-msg", "must be lower than 100!");
                                return ((input.val() > 100) ? false : true );
                            }
                            return true;
                        }
                        return true;
                    }
                }
            },
            PenaltyType: {
                defaultValue: { PenaltyTypeId: 0, PenaltyTypeName: "Пустий штраф" }
            },
            PenaltyValue: {
                type: "number",
                nullable: false,
                validation: { // validation rules
                    required: { message: "Значення штрафу має бути вказане!" },
                    min: 0 // the minimum value is 1
                }
            },
            PenaltyPeriodType: {
                defaultValue: { PeriodTypeId: 0, PeriodTypeName: "Фактичний період" }
            },
            PenaltyPeriodValue: {
                type: "number",
                nullable: true // default value will not be assigned
            }
        }
    });
    
    var dataSource = new kendo.data.DataSource({
        data: dsData,
        schema: {
            model: PenaltyDetails
        }
    });

    $("#grid").kendoGrid({
        dataSource: dataSource,
        columns: [
            {
                field: "PenaltyId", hidden: true
            },
            {
                field: "LowerLimit", title: "Від", width: "100px",
                locked: true,
                lockable: false,
                headerAttributes: { style: "text-align: center; ve" },
                attributes: { style: "text-align: right; vertical-align: middle;" }
            },
            {
                field: "UpperLimit", title: "По", width: "110px",
                locked: true,
                lockable: false,
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: right; vertical-align: middle;" }
            },
            {
                headerAttributes: { style: "text-align: center;" },
                field: "PenaltyType", title: "Тип<br>шрафу", width: "320px",
                editor: pnlDropDownEditor, template: "#=PenaltyType.PenaltyTypeName#"
            },
            {
                field: "PenaltyValue", title: "Значення<br>штрафу", width: "110px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: right;" }
            },
            {
                headerAttributes: { style: "text-align: center;" },
                field: "PenaltyPeriodType", title: "Тип<br>шрафного<br>періоду", width: "300px",
                editor: prdDropDownEditor, template: "#=PenaltyPeriodType.PeriodTypeName#"
            },
            {
                field: "PenaltyPeriodValue", title: "Значення<br>шрафного<br>періоду", width: "100px",
                headerAttributes: { style: "text-align: center;" },
                attributes: { style: "text-align: right;" }
            },
            {
                command: [
                    { name: "edit", text: { edit: "Редагувати", cancel: "Відмінити", update: "Зберегти" }, className: "btn-edit" },
                    { name: "destroy", text: "Видалити", className: "btn-destroy" }
                ]
            }
        ],
        change: function () {
            // var id = this.select().data("LowerLimit");
            // /* or */ selRow = this.dataSource.get(0);
            // selRow = this.dataItem(this.select());
            // $("#tb-from").val(selRow.get("LowerLimit"));
            // $("#tb-val").val(selRow.PenaltyValue);
        },
        edit: function (e) {
            $("#btnSave").prop("disabled", true);
            if (!e.model.isNew()) {
                // Disable the editor of the "id" column when editing data items
                // var numeric = e.container.find("input[name=id]").data("kendoNumericTextBox");
                // numeric.enable(false);
            }
        },
        cancel: function (e) {
            reinitGrid();
            $("#btnSave").prop("disabled", false);
        },
        remove: function (e) {
            // Fired when the user clicks the "destroy" command button.
            Del(e.model.LowerLimit);
        },
        saveChanges: function (e) {
            // Fired when the user clicks the "save" command button.
            if (!confirm("Are you sure you want to save all changes?")) {
                // If invoked the grid will not call the sync method of the data source.
                // e.preventDefault(); 
            }
        },
        save: function (e) { // Fired when a data item is saved.

            // console.log("is modified");
            if ($("#tbPenaltyTypeId").val() == "" && !($("#cbPenaltyType").prop("checked"))) {
                bars.ui.error({ text: "Не вказано Тип штрафу" });
                e.preventDefault();
            }
            else {
                if ($("#tbPenaltyPeriodId").val() == "" && !($("#cbPenaltyPeriod").prop("checked"))) {
                    bars.ui.error({ text: "Не вказано Штрафний період" });
                    e.preventDefault();
                }
                else {
                    var pnyType = ($("#cbPenaltyType").prop("checked") ? e.model.PenaltyType.PenaltyTypeId : $("#tbPenaltyTypeId").val());

                    var pnyPrdType = ((e.model.PenaltyPeriodType.PeriodTypeId == null) ? 0 : e.model.PenaltyPeriodType.PeriodTypeId);

                    var lwrLimit = ((e.model.LowerLimit == null) ? -1 : e.model.LowerLimit);

                    SetChanges(lwrLimit, e.model.UpperLimit, pnyType, e.model.PenaltyValue,
                                pnyPrdType, e.model.PenaltyPeriodValue);

                    $("#btnSave").prop("disabled", false);
                }
            }

            // e.values - The values entered by the user. Available only when the editable.mode option is set to "incell"
            // if (e.values.LowerLimit !== "") {
            //     // the user changed the name field
            //     if ((e.values.LowerLimit !== e.model.LowerLimit) ||
            //         (e.values.PenaltyType !== e.model.PenaltyType) || 
            //         (e.values.PenaltyValue !== e.model.PenaltyValue) ||
            //         (e.values.PenaltyPeriodType !== e.model.PenaltyPeriodType)||
            //         (e.values.PenaltyPeriodValue !== e.model.PenaltyPeriodValue))
            //     {}
            // } else {
            //     e.preventDefault();
            //     alert("field cannot be empty");
            // }
        },
        // toolbar: [{ name: "create", text: "Add new" }, { name: "save" }],
        // toolbar: ["create"],
        // toolbar: ["create", "save", "cancel"],
        // messages: {
        //     commands: {
        //         cancel: "Cancel changes",
        //         canceledit: "Cancel",
        //         create: "Add new record",
        //         destroy: "Delete",
        //         edit: "Edit",
        //         save: "Save changes",
        //         select: "Select",
        //         update: "Update"
        //     }
        // }
        
        toolbar: [
            { name: "create", text: "Додати запис" },
        ],
        //----------------
        editable: (editable ? "inline" : false),
        // editable: {
        //     mode: (editable ? "popup" : false),
        //     template: kendo.template($("#popup-editor").html())
        // },
        scrollable: false,
        selectable: false,
        // resizable: true,
        pageable: false
    });

    // read data from array
    // dataSource.read();

    function reinitGrid() {
        // read data 
        $.ajax({
            type: "GET",
            url: "udptJsonService.asmx/GetPenaltyDetails",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: { pny_id: pny_id },
            async: false,
            success: function (response) {
                dsData = response.d.Data;
            },
            failure: function (msg) {
                debugger;
            },
            cache: false
        }).done(function () {
            var dataSource = new kendo.data.DataSource({
                data: dsData,
                schema: {
                    model: PenaltyDetails
                }
            });

            dataSource.read();

            var grid = $('#grid').data('kendoGrid');

            grid.setDataSource(dataSource);

        });
    };

    reinitGrid();

    function SetChanges(lowerLmt, upperLmt, penaltyType, penaltyVal, penaltyPrdType, penaltyPrdVal) {

        // console.log("LowerLimit", lowerLmt);
        // console.log("PenaltyType", penaltyType);
        // console.log("PenaltyValue", penaltyVal);
        // console.log("PenaltyPeriodType", penaltyPrdType);
        // console.log("PenaltyPeriodValue", penaltyPrdVal);

        $.ajax({
            type: "POST",
            url: "udptJsonService.asmx/SetPenaltyDetails",
            data: {
                PenaltyId: pny_id, LowerLimit: lowerLmt, UpperLimit: upperLmt, PenaltyType: penaltyType,
                PenaltyValue: penaltyVal, PenaltyPeriodType: penaltyPrdType, PenaltyPeriodValue: penaltyPrdVal
            },
            async: false,
            success: function (data, textStatus, jqXHR) {
                var errMsg = $(data).children("string").text();
                if (errMsg == null || errMsg == "" || errMsg == "null") {
                    bars.ui.alert({ text: 'Ok!' });
                }
                else {
                    bars.ui.error({ text: 'Помилка при збереженні даних: ' + errMsg });
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                bars.ui.error({ text: errorThrown });
            }
        });

        reinitGrid();

        // $('#grid').data('kendoGrid').dataSource.read();
        // $('#grid').data('kendoGrid').refresh();
    };

    function Del(lowerLmt) {
        $.ajax({
            type: "POST",
            url: "udptJsonService.asmx/DeletePenaltyDetails",
            data: {
                PenaltyId: pny_id, LowerLimit: lowerLmt
            },
            async: false,
            success: function (data) {
                alert('Ok!');
            },
            error: function (request, status, error) {
                alert(request.responseText);
                // bars.ui.error({  title: 'Помилка', text: data.message });
            }
        });

        reinitGrid();
    };
 
    ///////////////////////////////////////////////////////

    //
    $("#tbBalTypeId").prop("readOnly", true);
    $("#tbBalTypeId").css("background-color", "lightgray");
    $("#ddlBalTypes").on("change", function () {
        $("#tbBalTypeId").val($(this).val());
    });
    // 
    $("#tbPeriodId").prop("readOnly", true);
    $("#tbPeriodId").css("background-color", "lightgray");
    $("#ddlPeriods").on("change", function () {
        $("#tbPeriodId").val($(this).val());
    });
    //
    $("#cbPenaltyType").on("change", function () {
        if ($(this).prop("checked")) {
            $("#tbPenaltyTypeId").val("");
            $("#ddlPenaltyTypes").val("");
            $("#ddlPenaltyTypes").prop("disabled", true);

            // Show a column by column name
            $("#grid").data("kendoGrid").showColumn("PenaltyType");
        }
        else {
            $("#ddlPenaltyTypes").prop("disabled", false);

            // Hide a column by column name
            $("#grid").data("kendoGrid").hideColumn("PenaltyType");
        }
    });
    // 
    $("#tbPenaltyTypeId").prop("readOnly", true);
    $("#tbPenaltyTypeId").css("background-color", "lightgray");
    $("#ddlPenaltyTypes").on("change", function () {
        $("#tbPenaltyTypeId").val($(this).val());
    });
    // 
    $("#cbPenaltyPeriod").on("change", function () {
        if ($(this).prop("checked")) {
            $("#tbPenaltyPeriodId").val("");
            $("#ddlPenaltyPeriods").val("");
            $("#ddlPenaltyPeriods").prop("disabled", true);

            // Show a column by column name
            $("#grid").data("kendoGrid").showColumn("PenaltyPeriodType");
            $("#grid").data("kendoGrid").showColumn("PenaltyPeriodValue");
        }
        else {
            $("#ddlPenaltyPeriods").prop("disabled", false);

            // Hide a column by column name
            $("#grid").data("kendoGrid").hideColumn("PenaltyPeriodType");
            $("#grid").data("kendoGrid").hideColumn("PenaltyPeriodValue");
        }
    });
    // 
    $("#tbPenaltyPeriodId").prop("readOnly", true);
    $("#tbPenaltyPeriodId").css("background-color", "lightgray");
    $("#ddlPenaltyPeriods").on("change", function () {
        $("#tbPenaltyPeriodId").val($(this).val());
    });

    //
    if (editable) {
        $("#cbPenaltyType").trigger("change");
        $("#cbPenaltyPeriod").trigger("change");
    }
    
    //
    if (pny_id == null)
    {
        $("#grid").hide();
    }
    
    // hide button if form open as dialog
    if (window.location != window.parent.location) {
        $("#btnExit").hide();
        // $("#btnExit").prop("disabled", true);
    }
});

function pnlDropDownEditor(container, options) {
    $('<input required data-text-field="PenaltyTypeName" data-value-field="PenaltyTypeId" data-bind="value:' + options.field + '"/>')
        .appendTo(container)
        .kendoDropDownList({
            // dataTextField: "PenaltyTypeName",
            // dataValueField: "PenaltyTypeId",
            autoBind: false,
            dataSource: [
                { PenaltyTypeName: "Пустий штраф", PenaltyTypeId: 0 },
                { PenaltyTypeName: "Жорсткий штраф (по історії зміни ставки)", PenaltyTypeId: 1 },
                { PenaltyTypeName: "М`який штраф (по останній діючій ставці)", PenaltyTypeId: 2 },
                { PenaltyTypeName: "Фиксований відсоток штрафу", PenaltyTypeId: 3 },
                { PenaltyTypeName: "Фиксований тип %%-ної ставки", PenaltyTypeId: 5 }
            ]
        });
};

function prdDropDownEditor(container, options) {
    $('<input required data-text-field="PeriodTypeName" data-value-field="PeriodTypeId" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: [
            { PeriodTypeName: "Фактичний період", PeriodTypeId: 0 },
            { PeriodTypeName: "Розрахуноквий період", PeriodTypeId: 1 },
            { PeriodTypeName: "Строк штрафу", PeriodTypeId: 2 },
            { PeriodTypeName: "Неповний рік", PeriodTypeId: 3 },
            { PeriodTypeName: "Неповний квартал", PeriodTypeId: 4 },
            { PeriodTypeName: "Неповні півроку", PeriodTypeId: 5 }
        ]
    });
};


function closeWindow() {
    if (confirm("Закрити поточну вкладку?")) {
        window.open('', '_parent', '');
        window.close();
    }
}

function validateControls() {
    var errMsg = "";

    if ($("#tbPenaltyName").val() == "") {
        errMsg += "Не вказано Назву штрафу<br>";
    }
    if ($("#tbBalTypeId").val() == "") {
        errMsg += "Не вказано Тип обчислення залишку<br>";
    }
    if ($("#tbPeriodId").val() == "") {
        errMsg += "Не вказано Одиницю виміру періоду<br>";
    }

    if (pny_id > 0) {
        if ($("#tbPenaltyTypeId").val() == "" && !($("#cbPenaltyType").prop("checked"))) {
            errMsg += "Не вказано Тип штрафу<br>";
        }
        if ($("#tbPenaltyPeriodId").val() == "" && !($("#cbPenaltyPeriod").prop("checked"))) {
            errMsg += "Не вказано Штрафний період<br>";
        }
    }

    if (errMsg == "") {
        return true;
    }
    else {
        bars.ui.error({ text: errMsg });
        return false;
    }
}
