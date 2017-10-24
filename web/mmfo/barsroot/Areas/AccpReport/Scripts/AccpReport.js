/**
 * Created by serhii.karchavets on 19.08.2016.
 */

$(function () {
    var grid = $("#AccountsGrid");
    grid.kendoGrid({
        dataSource: {
            //type: 'aspnetmvc-ajax',
            type: 'webapi',
            transport: {
                read: '/barsroot/accpreport/accpreport/GetAccounts'
            },
            //data: $this.response.data,
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    fields: {
                        NAME: { type: "string" },
                        DDOG: { type: "date" },
                        OKPO: { type: "string" },
                        NDOG: { type: "string" },
                        MFO: { type: "string" },
                        NLS: { type: "string" },
                        SCOPE_DOG: { type: "string" },
                        ORDER_FEE: { type: "string" },
                        AMOUNT_FEE: { type: "number" },
                        FEE_MFO: { type: "string" },
                        FEE_NLS: { type: "string" },
                        FEE_OKPO: { type: "string" },
                        CHECK_ON: { type: "boolean" },
                        FEE_TYPE_ID: {type: "number"},
                        FEE_BY_TARIF: {type: "number"}
                    }
                }
            },
            pageSize: 10,
            "page": 1,
            "total": 0,
            "serverPaging": true,
            "serverSorting": true,
            "serverFiltering": true,
            "serverGrouping": true,
            "serverAggregates": true
        },
        selectable: "multiple",
        groupable: false,
        sortable: true,
        filterable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "NAME",
                title: "Назва організації"
            },
            {
                field: "DDOG",
                title: "Дата договору",
                template: "#= kendo.toString(kendo.parseDate(DDOG, 'yyyy-MM-dd'), 'dd/MM/yyyy') #"
            },
            {
                field: "NDOG",
                title: "№ договору"
            },
            {
                field: "OKPO",
                title: "Код ЄДРПОУ організації"
            },
            {
                field: "MFO",
                title: "ФО"
            },
            {
                field: "NLS",
                title: "Рахунок"
            },
            {
                field: "SCOPE_DOG",
                title: "Область дії договору"
            },
            {
                field: "ORDER_FEE",
                title: "Порядок зняття комісійної винагороди"
            },
            {
                field: "AMOUNT_FEE",
                title: "Розмір комісійної винагороди"
            },
            {
                field: "FEE_MFO",
                title: "Код банку (для перерахунку комісійної винагороди)"
            },
            {
                field: "FEE_NLS",
                title: "Розрахунковий рахунок  банку (для перерахунку комісійної винагороди)"
            },
            {
                field: "FEE_OKPO",
                title: "Код ЄДРПОУ банку (для перерахунку комісійної винагороди)"
            },
            /*{
             field: "CHECK_ON",
             title: "CHECK_ON"
             }
             ,*/
            {
                field: "CHECK_ON",
                title: "Активність",//template: '<input type="checkbox" #= CHECK_ON==1 ? checked="checked" : "" #  ></input>'
                template: '<input class="chbx" type="checkbox" #= CHECK_ON ? checked="checked" : "" #  ></input>'
            },
            {
                field: "FEE_TYPE_ID",
                title: "Тип тарифу<br>для коміс.<br>винагороди (1-фіксований,<br>2-ступінчатий<br>(по тарифу))"
            },
            {
                field: "FEE_BY_TARIF",
                title: "Код<br>тарифу"
            }
        ]
    });
});

function fillreportgrid(okpo) {
    var grid = $("#AccountsToReportGrid");
    grid.kendoGrid({
        dataSource: {
            //type: 'aspnetmvc-ajax',
            type: 'webapi',
            transport: {
                read: '/barsroot/accpreport/accpreport/GetAccountsDocs/?OKPO=' + okpo
            },
            //data: $this.response.data,
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    fields: {
                        OKPO: { type: "string" },
                        TYPEPL: { type: "number" },
                        REF: { type: "number" },
                        BRANCH: { type: "string" },
                        FDAT: { type: "date" },
                        NLSA: { type: "string" },
                        NLSB: { type: "string" },
                        MFOA: { type: "string" },
                        MFOB: { type: "string" },
                        NAM_A: { type: "string" },
                        NAM_B: { type: "string" },
                        ID_A: { type: "string" },
                        ID_B: { type: "string" },
                        S: { type: "number" },
                        S_FEE: { type: "number" },
                        ORDER_FEE: { type: "number" },
                        AMOUNT_FEE: { type: "number" },
                        NAZN: { type: "string" },
                        CHECK_ON: { type: "boolean" }
                    }
                }
            },
            pageSize: 10,
            "page": 1,
            "total": 0,
            "serverPaging": true,
            "serverSorting": true,
            "serverFiltering": true,
            "serverGrouping": true,
            "serverAggregates": true
        },
        selectable: "multiple",
        groupable: false,
        sortable: true,
        filterable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [
            { field: "OKPO_ORG", title: "OKPO_ORG" },
            { field: "TYPEPL", title: "TYPEPL" },
            { field: "REF", title: "REF" },
            { field: "BRANCH", title: "BRANCH" },
            { field: "FDAT", title: "FDAT", template: "#= kendo.toString(kendo.parseDate(FDAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #" },
            { field: "NLSA", title: "NLSA" },
            { field: "NLSB", title: "NLSB" },
            { field: "MFOA", title: "MFOA" },
            { field: "MFOB", title: "MFOB" },
            { field: "NAM_A", title: "NAM_A" },
            { field: "NAM_B", title: "NAM_B" },
            { field: "ID_A", title: "ID_A" },
            { field: "ID_B", title: "ID_B" },
            { field: "S", title: "S" },
            { field: "S_FEE", title: "S_FEE" },
            { field: "ORDER_FEE", title: "Порядок зняття<br>комісійної винагороди" },
            { field: "AMOUNT_FEE", title: "Фіксований розмір<br>комісійної винагороди" },
            { field: "NAZN", title: "NAZN" },
            {
                field: "CHECK_ON",
                title: "CHECK_ON",//template: '<input type="checkbox" #= CHECK_ON==1 ? checked="checked" : "" #  ></input>'
                template: '<input class="chbxdoc" type="checkbox" #= CHECK_ON ? checked="checked" : "" #  ></input>'
            }
        ]
    });


    $("#AccountsToReportGrid .k-grid-content").on("change", "input.chbxdoc", function (e) {
        var grid = $("#AccountsToReportGrid").data("kendoGrid"),
            dataItem = grid.dataItem($(e.target).closest("tr"));
        //console.log(dataItem);
        $.ajax({
            async: false,
            type: "POST",
            url: bars.config.urlContent('/accpreport/accpreport/CheckAccountsDoc/?REF=' + dataItem.REF + '&Check=' + this.checked)
        });
        //  setTimeout(1000); // dataItem.set("CHECK_ON", this.checked);
    });
};

function create() {
    var grid = $("#AccountsGrid").data("kendoGrid"),
        dataItem = grid.dataItem($().closest("tr"));
    //alert($("#dateFrom").val());
    //alert($("#dateTo").val());
    //alert(grid._data[0].OKPO);
    alert('Звіт відправлено на формування. Дочекайтесь завершення!');
    $.ajax({
        async: true,
        type: "POST",
        url: bars.config.urlContent('/accpreport/accpreport/CreateReport/?DateFrom=' + $("#datepickerFrom").val() + '&DateTo=' + $("#datepickerTo").val() + '&OKPO=' + grid._data[0].OKPO),
        success: function () {
            fillreportgrid(grid._data[0].OKPO);
            alert('Звіт сформовано!');

        }
    });
    //   setTimeout(1000);

};

$(document).ready(function () {
    $("#createReport").click(create);
    $("#datepickerFrom").kendoDatePicker({    format: "dd/MM/yyyy" });
    $("#datepickerTo").kendoDatePicker({    format: "dd/MM/yyyy"});

    $("#AccountsGrid .k-grid-content").on("change", "input.chbx", function (e) {
        var grid = $("#AccountsGrid").data("kendoGrid"),
            dataItem = grid.dataItem($(e.target).closest("tr"));
        //console.log(dataItem);
        //alert(this.checked);
        $.ajax({
            async: false,
            type: "POST",
            url: bars.config.urlContent('/accpreport/accpreport/SetAccounts/?NLS=' + dataItem.NLS + '&OKPO=' + dataItem.OKPO + '&Check=' + this.checked)
        });
        // setTimeout(1000); // dataItem.set("CHECK_ON", this.checked);
    });
});