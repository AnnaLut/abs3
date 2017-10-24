$(document).ready(function () {

    $("#splitter").kendoSplitter({
        orientation: "vertical",
        panes: [{ size: "50%", min: "30%", resizable: true, scrollable: false, collapsible: false },
                { size: "50%", min: "50%", resizable: true, scrollable: false, collapsible: false }]
    });

    var Penalty = kendo.data.Model.define({
        id: "accID"
    });

    var selectedRow;

    $("#TopGrid").kendoGrid({
        columns: [{ title: "Валюта<br>платежу", field: "DocCurrency" },
                  { title: "Номер деп. рах.<br>ген. дог.", field: "AccGenNumber" },
                  { title: "Назва деп. рах.<br>ген. дог.", field: "AccGenName" },
                  { title: "Фактичний<br>залишок", field: "BalActual" },
                  { title: "Плановий<br>залишок", field: "BalPlanned" },
                  { title: "Залишок<br>дочірніх", field: "Bal" },
                  { title: "Референс<br>документу", field: "DocId" },
                  { title: "Дата<br>платежу", field: "DocDate" },
                  { title: "Сума<br>платежу", field: "DocAmount" }
                  //{ title: "", field: "" },
        ],
        change: function () {
            var id = this.select().data("id");
            selectedRow = this.dataSource.get(id);

            $("#update-name").val(selectedRow.get("Name"));
            $("#update-description").val(selectedRow.get("Description"));
        },
        scrollable: true,
        height: "100%"
    });

    $("#BottomGrid").kendoGrid({
        columns: [{ title: "Валюта", field: "Currency" },
                  { title: "Номер деп. рах.<br>дод. дог.", field: "AccAddNumber" },
                  { title: "Назва деп. рах.<br>дод. дог.", field: "AccAddName" },
                  { title: "Фактичний<br>залишок", field: "BalActual" },
                  { title: "Плановий<br>залишок", field: "BalPlanned" },
                  { title: "Номер дод.<br>договору", field: "AgrmNumber" },
                  { title: "Сума дод.<br>договору", field: "AgrmAmount" }
        ],
        scrollable: true,
        height: "100%"
    });
});