var bankdate;
var list_viid = [];
$(document).ready(function () {
    var custtype = bars.extension.getParamFromUrl('cusstype', location.href);

    var toolbar = [];
    toolbar.push({ name: "btProvide", type: "button", text: "<span class='pf-icon pf-16 pf-key'></span> Забезпечення", className: "k-custom-edit" });
    toolbar.push({ name: "btAccounts", type: "button", text: "<span class='pf-icon pf-16 pf-tree'></span> Рахунки" });
    toolbar.push({ name: "btGLK", type: "button", text: "<span class='pf-icon pf-16 pf-business_report'></span> ГЛК" });
    toolbar.push({ name: "btToExcel", type: "button", text: "<span class='pf-icon pf-16 pf-exel'></span>Експорт в Excel" });

    toolbar.push({ template: "<div class='legend normal' title='Робочі'></div>" });
    toolbar.push({ template: "<div class='legend today' title='Кінець сьогодні'></div>" });
    toolbar.push({ template: "<div class='legend this_week' title='Кінець цей тиждень'></div>" });
    toolbar.push({ template: "<div class='legend this_month' title='Кінець це місяць'></div>" });
    toolbar.push({ template: "<div class='legend prostr' title='Прострочка'></div>" });

    var grid = $("#gridPortfolio").kendoGrid({
        toolbar: toolbar,
        filterable: true,
        resizable: true,
        selectable: true,
        sortable: true,
        scrollable: true,
        selectable: "row",
        pageable: {
            refresh: true,
            pageSize: 100,
            pageSizes: [100,200,500,1000]
        },
        columns: [
            { 
                template: '<input class="checkboxExist" type="checkbox"/>',
                width: 22
            },
        {
            title: "Бранч КД",
            width: 150,
            nullable: true,
            field: "BRANCH"
        },
        {
            title: "РЕФ КД",
            width: 80,
            nullable: true,
            field: "ND",
            template: "<a href='/barsroot/CreditUi/NewCredit/?nd=${ND}&custtype=${CUSTTYPE}' onclick='window.open(this.href); return false;'>${ND}</a>"

        },
        {
            title: "Код продукт",
            width: 55,
            nullable: true,
            field: "PROD"
        },
        {           
            title: "РНК",
            width: 70,
            nullable: true,
            field: "RNK",
            template: "<a href='/barsroot/clientregister/registration.aspx?readonly=1&rnk=${RNK}' onclick='window.open(this.href); return false;'>${RNK}</a>"
        },
        {
            title: "Назва позичальника",
            width: 150,
            nullable: true,
            field: "NAMK"
        },
        {
            title: "№ КД",
            width: 55,
            nullable: true,
            field: "CC_ID"
        },
        {
            title: "Тра нш",
            width: 37,
            nullable: true,
            field: "TR",
            template: '<input type="checkbox" #= TR ? "checked=checked" : "" # disabled="disabled" ></input>',
            filterable: false
        },
        {
            title: "Вид КД",
            width: 80,
            nullable: true,
            field: "VIDD_NAME",
            filterable: {
                extra: false,
                ui: typeFilter,
                operators: {
                    string: {
                        eq: "Дорівнює",
                        neq: "Не дорівнює"
                    }
                }
            }
        },
        {
            title: "Стан КД",
            width: 60,
            nullable: true,
            field: "SOS_NAME"
        },
        {
            title: "Сума по договору",
            width: 90,
            nullable: true,
            field: "SDOG",
            template: "#=moneyFormat(SDOG)#"
        },
        {
            title: "Сума ліміту",
            width: 90,
            nullable: true,
            field: "S",
            template: "#=moneyFormat(S)#"
        },
        {
            title: "<br>Вал",
            width: 50,
            nullable: true,
            field: "KV"
        },
        {
            title: "%-ст",
            width: 50,
            nullable: true,
            field: "PR"
        },
        {
            title: "Дата початку",
            width: 70,
            nullable: true,
            field: "DSDATE",
            format: "{0:dd.MM.yyyy}"
        },
        {
            title: "Дата завершення",
            width: 70,
            nullable: true,
            field: "DWDATE",
            format: "{0:dd.MM.yyyy}"
        },
        {
            title: "Дата закриття",
            width: 70,
            nullable: true,
            field: "DAZS",
            format: "{0:dd.MM.yyyy}"
        },
         {
             title: "Виплата тіла",
             columns: [{
                 title: "період",
                 field: "FREQ",
                 nullable: true,
                 width: 70
             },
             {
                 title: "день",
                 field: "OPL_DAY",
                 nullable: true,
                 width: 40
             }]
         },
         {
             title: "Виплата %",
             columns: [{
                 title: "період",
                 field: "FREQP",
                 nullable: true,
                 width: 70
             },
             {
                 title: "день",
                 field: "DAYSN",
                 nullable: true,
                 width: 40
             }]
         },
        {
            title: "Реф пов'язаного",
            width: 80,
            nullable: true,
            field: "NDI"
        },
        {
            title: "Інспектор КД",
            width: 60,
            nullable: true,
            field: "ISP"
        }
        ],
        dataBound: function (e) {
            bars.ui.loader('body', true);
            $(".checkboxExist").bind("change", function (e) {
                $(e.target).closest("tr").toggleClass("k-state-selected");
                DisabledButtons();
               
            });

            var data = $("#gridPortfolio").data("kendoGrid").dataSource.data();

            $.each(data, function (i, row) {
                var diff = kendo.parseDate(row.DWDATE) - kendo.parseDate(bankdate);
                var color = (row.SOS > 10 && (diff < -1)) ? "prostr" : (diff == 0) ? "today" : (diff > 0 && diff <= 7) ? "this_week" : (diff > 0 && diff <= 30) ? "this_month" : "normal";
                $('tr[data-uid="' + row.uid + '"] ').addClass(color);
            });

            DisabledButtons();
            bars.ui.loader('body', false);
        },
        change: function (e) {
            DisabledButtons();

            $('tr').find('[class=checkboxExist]').prop('checked', false);
            $('tr.k-state-selected').find('[class=checkboxExist]').prop('checked', true);
        },
        excel: {
            fileName: "Кредитний Портфель ЮО.xlsx",
            allPages: true
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            sheet.columns.autoWidth = true;
            for (var i = 2; i < sheet.rows.length; i++) {
                var row = sheet.rows[i];
                row.cells[9].format = row.cells[10].format = "#,##0.00";
            }
        }
    }).data("kendoGrid");

    ///start
    GetData();

    /////////////////////////
    //buttons
    /////////////////////////


    $(".k-grid-btToExcel").click(function () {
        $("#gridPortfolio").data("kendoGrid").saveAsExcel();
    });

    $(".k-grid-btGLK").click(function () {
        var grid = $("#gridPortfolio").data("kendoGrid");
        var selected_items = grid.select();
        window.open(bars.config.urlContent('/CreditUI/glk/Index/?id=' + grid.dataItem(selected_items).ND), '_blank');
    });

    $(".k-grid-btProvide").click(function () {
        var grid = $("#gridPortfolio").data("kendoGrid");
        var selected_items = grid.select();
        window.open(bars.config.urlContent('/CreditUI/Provide/Index/?id=' + grid.dataItem(selected_items).ND), '_blank');
    });

    $(".k-grid-btAccounts").click(function () {
        var grid = $("#gridPortfolio").data("kendoGrid");
        var selected_items = grid.select();
        window.open(bars.config.urlContent('/CreditUI/Accounts/Index/?id=' + grid.dataItem(selected_items).ND), '_blank');
    });
 
})

function createListPortfolio() {
    var grid = $("#gridPortfolio").data("kendoGrid");
    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: "json",
                cache: false,
                url: bars.config.urlContent('/CreditUI/Portfolio/GetPortfolio/'),
                data: { custtype: 2 }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                id: 'ND',
                fields: {
                    ISP: {type: "number" }, 
                    ND: {type: "number" },   
                    CC_ID: {type: "string" }, 
                    VIDD: {type: "number" },   
                    RNK: {type: "number" },   
                    KV: {type: "number" },   
                    S: {type: "number" },   
                    GPK: {type: "number" },    
                    DSDATE: {type: "date" },   
                    DWDATE: {type: "date" },   
                    PR: {type: "number" },   
                    OSTC: {type: "number" },   
                    SOS: {type: "number" },   
                    NAMK: {type: "string" },   
                    ACC8: {type: "number" },    
                    DAZS: {type: "date" },   
                    BRANCH: {type: "string" },   
                    CUSTTYPE: {type: "number" },   
                    PROD: {type: "number" },   
                    SDOG: {type: "number" },   
                    NDI: {type: "number" },   
                    VIDD_NAME: {type: "string" },   
                    SOS_NAME: {type: "string" },   
                    TR: {type: "boolean" },   
                    OPL_DAY: {type: "number" },   
                    NDG: {type: "number" },   
                    DAYSN: {type: "number" },   
                    FREQ: {type: "string" },   
                    FREQP: {type: "string" },   
                    OPL_DATE: {type: "number" },   
                    NDO: {type: "number" },   
                    I_CR9: {type: "string" }   
                }
            }
        },
        sort: [
           { field: "ND", dir: "desc" }
        ],
        pageSize: 50
    });
    grid.setDataSource(dataSource);
}

function DisabledButtons() {
    var grid = $("#gridPortfolio").data("kendoGrid");
    var selected_items = grid.select();
    disabledButtons(((selected_items.length == 1)), ".k-grid-btProvide");
    disabledButtons(((selected_items.length == 1)), ".k-grid-btGLK");
    disabledButtons(((selected_items.length == 1)), ".k-grid-btAccounts");
    
}

function GetData() {
    $.ajax({
        type: "POST",
        async: true,
        dataType: "json",
        url: bars.config.urlContent('/CreditUI/Portfolio/GetBankDate/'),
        success: function (data) {
            bankdate = data.BANKDATE;
            list_viid = data.LIST_VIDD;
            createListPortfolio();
        }
    });
}

function typeFilter(element) {
    element.kendoDropDownList({
        dataTextField: "NAME",
        dataValueField: "NAME",
        dataSource: list_viid,
        optionLabel: false
    });
}

