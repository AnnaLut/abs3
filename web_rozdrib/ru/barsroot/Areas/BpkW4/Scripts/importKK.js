var lastReceipt = null;

var getCurrentFile = function () {
    return currentFileId;
}

var getCurrentCard = function () {
    return $('#card_type').val();
}

var getCurrentBranch = function () {
    return $('#edtBranch').val();
}

var getProjGroup = function () {
    return $("#project_group").data("kendoDropDownList").value();
}

var getProj = function () {
    return $("#project").val();
}

var getProjId = function () {
    var grid = $("#products").data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select());
    return selectedItem.ID;
}


var getExecutor = function () {
    return $("#edtExecutor").val();
}

$("#project_group").kendoDropDownList({
    dataSource: {
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: 'json',
                url: bars.config.urlContent('/BpkW4/ImportKievCard/GetGroups')
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors"
        }
    },
    dataTextField: "NAME",
    dataValueField: "CODE"
});


$("#branchList").kendoWindow({
    visible: false,
    modal: true,
    width: 700,
    title: "Оберіть підрозділ банку"
});

$("#userList").kendoWindow({
    visible: false,
    modal: true,
    width: 700,
    title: "Оберіть виконавця банку"
});

$("#prodList").kendoWindow({
    visible: false,
    modal: true,
    width: 700,
    title: "Оберіть продукт"
});

$("#cardList").kendoWindow({
    visible: false,
    modal: true,
    width: 700,
    title: "Оберіть субпродукт"
});

$('#selectBranch').on('click', function () {
    $("#branchList").data("kendoWindow").center().open();
});

$('#selectExecutor').on('click', function () {
    $("#userList").data("kendoWindow").center().open();
});

$('#selectProject').on('click', function () {
    initProdGrid();
    //$('#products').data("kendoGrid").dataSource.read();
    $("#prodList").data("kendoWindow").center().open();
});

$('#selectCard').on('click', function () {
    $('#cards').data("kendoGrid").dataSource.read();
    $("#cardList").data("kendoWindow").center().open();
});

$('#saveFile').on('click', function () {
    var data = {
        FileId: currentFileId,
        Branch: getCurrentBranch(),
        ExecutorId: getExecutor(),
        ProjectId: getProjGroup === "SALARY" ? null : getProjId(),
        CardId: getCurrentCard()
    }
    $.get(bars.config.urlContent('/BpkW4/ImportKievCard/AcceptFile'), data)
        .done(function (result) {
            if (result.status === "error") {
                bars.ui.error({ text: result.message });
            } else {
                lastReceipt = result.data;
                $('#results').data("kendoGrid").dataSource.read();
                $('#additionalParams').hide();
                $('#processResults').show();
            }
        });
});

$('#branches').kendoGrid({
    selectable: "single",
    columns: [
        {
            field: "Branch",
            title: "Код безбалансового відділення",
            width: "200px"
        },
        {
            field: "Name",
            title: "Найменування безбалансового відділення",
            width: "300px"
        }
    ],
    dataSource: {
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: 'json',
                url: bars.config.urlContent('/BpkW4/ImportKievCard/GetAllBranches')
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors"
        },
        serverPaging: true,
        serverSorting: true,
        serverFiltering: true,
        pageSize: 20
    },
    sortable: true,
    resizable: true,
    filterable: true,
    pageable: {
        refresh: true,
        pageSizes: true,
        buttonCount: 5
    },
    change: function (e) {
        if (this.select()) {
            $('#branchList .select-button').prop("disabled", false);
        } else {
            $('#branchList .select-button').prop("disabled", "disabled");
        }

    }
});

$('#users').kendoGrid({
    selectable: "single",
    columns: [
        {
            field: "ID",
            title: "Код",
            width: "200px"
        },
        {
            field: "FIO",
            title: "ПІБ Користувача",
            width: "300px"
        }
    ],
    dataSource: {
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: 'json',
                url: bars.config.urlContent('/BpkW4/ImportKievCard/GetStaff'),
                data: { branch: getCurrentBranch }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors"
        },
        serverPaging: true,
        serverSorting: true,
        serverFiltering: true,
        pageSize: 20
    },
    sortable: true,
    resizable: true,
    filterable: true,
    pageable: {
        refresh: true,
        pageSizes: true,
        buttonCount: 5
    },
    change: function (e) {
        if (this.select()) {
            $('#userList .select-button').prop("disabled", false);
        } else {
            $('#userList .select-button').prop("disabled", "disabled");
        }

    }
});


var getProdColumns = function () {
    if (getProjGroup() === "SALARY") {
        return [
            {
                field: "ID",
                title: "Код продукту",
                width: "100px"
            },
            {
                field: "NAME",
                title: "Назва продукту",
                width: "300px"
            },
            {
                field: "OKPO",
                title: "ОКПО",
                width: "120px"
            }
        ];
    } else {
        return [
            {
                field: "CODE",
                title: "Код продукту",
                width: "200px"
            },
            {
                field: "NAME",
                title: "Назва продукту",
                width: "300px"
            },
            {
                field: "CODE",
                title: "ОКПО",
                width: "1px"
                
            }
        ];
    }
}

var initProdGrid = function () {
    var grid = $('#products').data("kendoGrid");
    if (grid) {
        grid.destroy();
    }

    $('#products').kendoGrid({
        selectable: "single",
        columns: getProdColumns(),
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/BpkW4/ImportKievCard/GetProducts'),
                    data: { prodGrp: getProjGroup }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors"
            },
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            pageSize: 20
        },
        sortable: true,
        resizable: true,
        filterable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        change: function(e) {
            if (this.select()) {
                $('#prodList .select-button').prop("disabled", false);
            } else {
                $('#prodList .select-button').prop("disabled", "disabled");
            }

        }
    });
}

$('#cards').kendoGrid({
    selectable: "single",
    columns: [
        {
            field: "CODE",
            title: "Код продукту",
            width: "200px"
        },
        {
            field: "SUB_NAME",
            title: "Назва продукту",
            width: "300px"
        }
    ],
    dataSource: {
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: 'json',
                url: bars.config.urlContent('/BpkW4/ImportKievCard/GetCards'),
                data: { product: getProj }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors"
        },
        serverPaging: true,
        serverSorting: true,
        serverFiltering: true,
        pageSize: 20
    },
    sortable: true,
    resizable: true,
    filterable: true,
    pageable: {
        refresh: true,
        pageSizes: true,
        buttonCount: 5
    },
    change: function (e) {
        if (this.select()) {
            $('#cardList .select-button').prop("disabled", false);
        } else {
            $('#cardList .select-button').prop("disabled", "disabled");
        }

    }
});

$('#results').kendoGrid({
    columns: [
        {
            field: "STR_ERR",
            title: "Повідомлення",
            width: "200px"
        },
        {
            field: "ND",
            title: "Ном. дог.",
            width: "80px"
        },
        {
            field: "RNK",
            title: "РНК",
            width: "80px"
        },
        {
            field: "NLS",
            title: "Карт. рахунок",
            width: "100px"
        },
        {
            field: "FullName",
            title: "ПІБ",
            width: "180px"
        },
        {
            field: "PasspNum",
            title: "Документ",
            width: "100px"
        },
        {
            field: "BDAY",
            title: "Дата народж.",
            template: "<div style='text-align:right;'>#=BDAY == null ? '' : kendo.toString(BDAY,'dd/MM/yyyy')#</div>",
            width: "100px"
        },
        {
            field: "OKPO",
            title: "ЗКПО",
            width: "100px"
        },
        {
            field: "PHONE_MOB",
            title: "Телефон моб.",
            width: "100px"
        },
        {
            field: "FullAddress",
            title: "Адреса реєстрації",
            width: "250px"
        },
        {
            field: "WORK",
            title: "Місце роботи",
            width: "120px"
        },
        {
            field: "TABN",
            title: "Таб. номер",
            width: "80px"
        }
    ],
    dataSource: {
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: 'json',
                url: bars.config.urlContent('/BpkW4/ImportKievCard/GetSalaryData'),
                data: { fileId: getCurrentFile }
            }
        },
        schema: {
            model: {
                fields: {
                    BDAY: { type: "date" }
                }
            }
        },
        serverPaging: true,
        serverSorting: true,
        serverFiltering: true
    }
});


$('#branchList .cancel-button').on('click', function () {
    $("#branchList").data("kendoWindow").close();
});

$('#branchList .select-button').on('click', function () {
    var grid = $("#branches").data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select());
    $('#edtBranch').val(selectedItem.Branch);
    $("#users").data("kendoGrid").dataSource.read();
    $("#branchList").data("kendoWindow").close();
});

$('#userList .cancel-button').on('click', function () {
    $("#userList").data("kendoWindow").close();
});

$('#userList .select-button').on('click', function () {
    var grid = $("#users").data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select());
    $('#edtExecutor').val(selectedItem.ID);
    $("#userList").data("kendoWindow").close();
});

$('#prodList .cancel-button').on('click', function () {
    $("#prodList").data("kendoWindow").close();
});

$('#prodList .select-button').on('click', function () {
    var grid = $("#products").data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select());
    $('#project').val(selectedItem.CODE);
    $("#prodList").data("kendoWindow").close();
});

$('#cardList .cancel-button').on('click', function () {
    $("#cardList").data("kendoWindow").close();
});

$('#cardList .select-button').on('click', function () {
    var grid = $("#cards").data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select());
    $('#card_type').val(selectedItem.CODE);
    $("#cardList").data("kendoWindow").close();
});

$('#nextFormParams').on('click', function () {
    $('#importResults').hide();
    $('#additionalParams').show();
});

$('#to_imported_projects').on('click', function () {
    $('#additionalParams').hide();
    $('#importResults').show();

});

$('#to_params').on('click', function () {
    $('#processResults').hide();
    $('#additionalParams').show();
});

$('#getReceipt').on('click', function () {
    var element = document.createElement('a');
    element.setAttribute('href', "data:text/xml;charset=windows-1251," + lastReceipt.Body);
    element.setAttribute('download', lastReceipt.Name);
    element.click();
});
