$(document).ready(function () {
    paramObj = { urlParams: '' };

    initMainFilters();
    initGrid();
});

function initGrid() {
    var admuDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/ADMU/GetADMUList"),
                data: function () {
                    var a = {
                        parameters: paramObj.urlParams || '',
                        mainFilter: {
                            UserLogin: $('#userLogin').val(),
                            UserName: $('#userName').val(),
                            Id: $('#userId').data('kendoNumericTextBox').value(),
                            UserBranch: $('#userBranch').data('kendoAutoComplete').value(),
                            UserState: $('#userState').data('kendoDropDownList').value()
                        }
                    };
                    return a;
                },
                error: function (xhr, error) {
                    bars.ui.error({ text: "Сталася помилка при спробі завантажити дані таблиці.<br/>" + error });
                }
            }
        },
        requestStart: function (e) {
            bars.ui.loader($('#allMenus'), true);
        },
        requestEnd: function (e) {
            bars.ui.loader($('#allMenus'), false);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ID: { type: "number" },
                    LOGIN_NAME: { type: "string" },
                    USER_NAME: { type: "string" },
                    BRANCH_CODE: { type: "string" },
                    AUTHENTICATION_MODE_ID: { type: "string" },
                    AUTHENTICATION_MODE_NAME: { type: "string" },
                    STATE_ID: { type: "number" },
                    STATE_NAME: { type: "string" }
                }
            }
        }
    });

    function setDefaultSelectedRow() {
        var grid = $("#ADMUGrid").data("kendoGrid");
        if (grid) {
            grid.select(grid.tbody.find("tr:first"));
        }
    }

    $("#ADMUGrid").kendoGrid({
        autoBind: false,
        selectable: "row",
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 5,
            pageSizes: [10, 50, 100, 1000]
        },
        columns: [
            {
                field: "ID",
                title: "ID",
                width: "10%"
            },
            {
                field: "LOGIN_NAME",
                title: "Логін",
                width: "15%"
            },
            {
                field: "USER_NAME",
                title: "Ім'я користувача",
                width: "20%"
            },
            {
                field: "BRANCH_CODE",
                title: "Відділення",
                width: "15%"
            },
            {
                field: "AUTHENTICATION_MODE_NAME",
                title: "Режим автентифікації",
                width: "15%"
            },
            {
                field: "STATE_NAME",
                title: "Стан",
                width: "10%"
            },
            {
                field: "ADM_COMMENTS",
                title: "Додаткова інформація",
                width: "15%"
            }
        ],
        dataSource: admuDataSource,
        filterable: false,
        dataBound: setDefaultSelectedRow
    });
}

function initMainFilters() {
    $('#mainFilterSearchBtn').on('click', function () {
        var grid = $("#ADMUGrid").data("kendoGrid");
        grid.dataSource.read();
        grid.dataSource.page(1);
    });

    $('#mainFilters input').on('keypress', function (e) {
        var char = e.which || e.keyCode;
        if (char === 13) {
            $('#mainFilterSearchBtn').click();
        }
    });

    $('#userId').kendoNumericTextBox({
        spinners: false,
        decimals: 0,
        restrictDecimals: true,
        format: 'n0',
        max: 999999999999
    });
    $('#userState').kendoDropDownList(getDropDownOptions({
        dataSource: [
            { code: 4, name: 'Закритий' },
            { code: 3, name: 'Блокований' },
            { code: 2, name: 'Активний' }
        ]
    }));

    $("#userBranch").kendoAutoComplete({
        dataSource: {
            type: 'json',
            transport: {
                read: bars.config.urlContent('/admin/ADMU/GetBranchesDdlData')
            }
        },
        filter: 'contains',
        placeholder: 'Почніть вводити відділення',
        dataTextField: "Branch",
        template: '<span class="k-state-default" style="font-size:12px;">#: data.Branch #</span>'
    });
}

function getDropDownOptions(options) {
    if (options === undefined || options === null) options = {};
    options = $.extend(
        {
            dataTextField: 'name',
            dataValueField: 'code',
            optionLabel: ' --- '
        },
        options
    );

    options.template = '<span class="k-state-default" style="font-size:12px;">#: data.' + options.dataTextField + ' #</span>';
    options.valueTemplate = '<span class="k-state-default" style="font-size:12px;">#: data.' + options.dataTextField + ' #</span>';

    return options;
}