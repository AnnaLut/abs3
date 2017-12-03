$(document).ready(function () {

    var editableModel = {
        conclusionDateStartValue: kendo.toString($("#conclusionDate").data("kendoDatePicker").value(), "dd.MM.yyyy"),
        product: $("#productType").val(),
        nbuNumber: $("#nbuId").val()
    };




    $("#btnSave").kendoButton({
        enable: false,
        click: updDeal
    });

    var datepicker = $("#conclusionDate").data("kendoDatePicker");

    datepicker.bind("change", function () {

        var value = kendo.toString(this.value(), "dd.MM.yyyy");

        if (value != editableModel.conclusionDateStartValue)
            $("#btnSave").data("kendoButton").enable(true);
        else
            $("#btnSave").data("kendoButton").enable(false);

    });

    var productSelector = $("#productType").data("kendoDropDownList");

    productSelector.bind("change", function () {

        var value = this.value();

        if (value != editableModel.product)
            $("#btnSave").data("kendoButton").enable(true);
        else
            $("#btnSave").data("kendoButton").enable(false);

    });

    var nbuTb = $("#nbuId");

    nbuTb.bind("change", function () {

        var value = $("#nbuId").val();

        if (value != editableModel.nbuNumber)
            $("#btnSave").data("kendoButton").enable(true);
        else
            $("#btnSave").data("kendoButton").enable(false);

    });

    function updDeal() {

        var valueConcDate = $("#conclusionDate").data("kendoDatePicker").value();
        var concDate = kendo.toString(valueConcDate, "dd/MM/yyyy");

        var megamodel = {
            colDatConclusion: concDate,
            nd: globalND,
            productCode: $("#productType").val(),
            n_nbu: $("#nbuId").val()
        }
        bars.ui.loader('body', true);
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/mbdk/savedeal/SaveDeal"),
            data: megamodel,
            success: function (data) {
                bars.ui.loader('body', false);

                if (data.error == null || data.error == "") {
                    bars.ui.alert({ text: "Дані успішно збережено" });
                    $("#btnSave").data("kendoButton").enable(false);

                    editableModel.conclusionDateStartValue = kendo.toString(valueConcDate, "dd.MM.yyyy");
                    editableModel.product = $("#productType").val();
                    editableModel.nbuNumber = $("#nbuId").val();

                } else {
                    bars.ui.error({ text: data.error });
                }
            }
        });
    };
});




