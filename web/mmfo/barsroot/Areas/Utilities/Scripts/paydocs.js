$(document).ready(function () {

    var grid = $("#PayDocs").kendoGrid({
        toolbar: [{ name: "btPay", type: "button", text: "<span class='pf-icon pf-16 pf-money'></span> Оплатити обрані регіони" }],
        filterable: true,
        resizable: true,
        selectable: true,
        sortable: true,
        scrollable: true,
        selectable: "multiple,row",
        pageable: {
            refresh: true,
            pageSize: 15,
            pageSizes: [15, 30]
        },
        columns: [
            {
                headerTemplate: '<input class="checkbox" type="checkbox" id="Allchk">',
                template: '<input class="chk_column" type="checkbox"/>',
                width: 29
            },
            {
                title: "Код області",
                width: 100,
                field: "KF"
            },
            {
                title: "Назва області",
                width: 300,
                field: "NAME"
            }
        ],
        dataBound: function (e) {
            $(".chk_column").bind("change", function (e) {
                $(e.target).closest("tr").toggleClass("k-state-selected");
            });
        },
        change: function (e) {
            $('tr').find('[class=chk_column]').prop('checked', false);
            $('tr.k-state-selected').find('[class=chk_column]').prop('checked', true);
        }
    }).data("kendoGrid");

    ///start
    GetKF();


    //buttons
    $(".k-grid-btPay").click(function () {
        var grid = $("#PayDocs").data("kendoGrid");
        var selected_kf = [];
        grid.select().each(function () {
            selected_kf.push(grid.dataItem($(this)).KF);
        });

        if (selected_kf.length === 0) {
            bars.ui.error({ text: "Оберіть хоча б 1 регіон!" });
            return;
        }


        bars.ui.loader("#PayDocs", true);
        $.ajax({
            async: true,
            type: 'POST',
            url: bars.config.urlContent("/Utilities/PayDocs/PaySelectedDocs/"),
            data: { kf_list: JSON.stringify(selected_kf) },
            success: function (data) {
                if (!data.Error)
                    bars.ui.alert({ text: "Оплата здійснена успішно" });
                else
                    bars.ui.error({
                        text: data.Error, height: 'auto',
                    });
            },
            complete: function () {
                bars.ui.loader("#PayDocs", false);
            }
        });
    });

    $('#Allchk').change(function (ev) {
        var checked = ev.target.checked;
        $('.chk_column').each(function (idx, item) {
            var stateSelected = $(item).closest('tr').is('.k-state-selected');
            if ((checked && !stateSelected) || (!checked && stateSelected)) {
                $(item).click();
            }
        });
    });


});


function GetKF() {
    var grid = $("#PayDocs").data("kendoGrid");
    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: "json",
                cache: false,
                url: bars.config.urlContent("/Utilities/PayDocs/GetKF/")
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: function (response) {
                if (response.Errors)
                    bars.ui.error({ text: response.Errors });
            },
            model: {
                id: "KF",
                fields: {
                    KF: { type: "string" },
                    NAME: { type: "string" }
                }
            }
        },
        pageSize: 15
    });
    grid.setDataSource(dataSource);
}