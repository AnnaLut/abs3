var selectedRows = [];
var countCheckBox = 0;
var model = {};

$(document).ready(function () {


    var acc =  bars.extension.getParamFromUrl('ACC_ACC', document.location.href);
    var rnk = bars.extension.getParamFromUrl('RNK', document.location.href);
    var isDKBO = bars.extension.getParamFromUrl('ISDKBO', document.location.href);
    var isAccClose = bars.extension.getParamFromUrl('IS_ACC_CLOSE', document.location.href);


    var kendoGrid = $("#grid").kendoGrid({
        change: onChange,
        columns: [
            {
                field: 'HasDcbo',
                title: "Обрати",
                width: "60px",
                template: function (data) {
                    if (data.DEAL_ID != null) {                       
                        return "<div class='checkDCBOcontainer'><input type='checkbox' id='checkBoxDcbo' class='checkbox checkDcbo' checked='checked' disabled ></div>";
                    }
                    else if (CheckedSelectedRow(data.CUSTOMER_ID, data.ACC_ACC) == true || data.ACC_ACC == acc) {
                        return "<div class='checkDCBOcontainer'><input type='checkbox' id='checkBoxDcbo' class='checkbox checkDcbo' checked='checked' onclick='checkBoxChecked(" + data.CUSTOMER_ID + ',' + data.ACC_ACC + ", this)'/></div>";
                    }
                    else {
                        return "<div class='checkDCBOcontainer'><input type='checkbox' id='checkBoxDcbo' class='checkbox checkDcbo' onclick='checkBoxChecked(" + data.CUSTOMER_ID + ',' + data.ACC_ACC + ", this)'/></div>";
                    }
                },
                filterable: false
            },
            {
                title: "Відділення",
                field: "BRANCH",
                width: "175px"
            },
            {
                headerTemplate: '<div class="headerTitle"><span>Клієнт</span></div>',
                columns: [{
                    field: "CUSTOMER_NAME",
                    title: "П.I.Б",
                    width: "168px"
                },
                {
                    field: "CUSTOMER_ZKPO",
                    title: "І.П.Н.",
                    width: "100px"
                },
                {
                    field: "PASS_SERIAL",
                    title: "Серія",
                    width: '85px'
                },
                {
                    field: "PASS_NUMBER",
                    title: "Номер документа",
                    width: '155px',
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                min: 0,
                                format: "n0"
                            });
                        }
                    }
                },
                {
                    field: "CUSTOMER_ID",
                    title: "РНК",
                    width: "110px",
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                min: 0,
                                format: "n0"
                            });
                        }
                    }
                }]
            },
            {
                field: "CARD_ACC",
                title: "Картковий рахунок",
                width: "165px",
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            min: 0,
                            format: "n0"
                        });
                    }
                }
            },
            {
                field: "NAME_SAL_PR",
                title: "З/п проект",
                width: "170px",
            },
            {
                field: "OKPO_SAL_PR",
                title: "ЗКПО організіції",
                width: "140px"
            },
            {
                headerTemplate: '<div class="headerTitle"><span>ДКБО</span></div>',
                columns: [{

                    field: "DKBO_CONTRACT_ID",
                    title: "№ договору",
                    width: "145px",
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                min: 0,
                                format: "n0"
                            });
                        }
                    }

                },
                {
                    field: "DKBO_DATE_FROM",
                    title: "Дата приєднання",
                    width: "190px",
                    template: "<div>#=DKBO_DATE_FROM == null ? '' : kendo.toString(kendo.parseDate(DKBO_DATE_FROM),'dd/MM/yyyy')#</div>",
                }]
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            pageSize: 10,
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/bpkw4/checkdkbo/Get_W4_DKBO_WEB_Grid')
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    fields: {
                        DKBO_CONTRACT_ID: { type: "string" },
                        BRANCH: { type: "string" },
                        CARD_ACC: { type: "string" },
                        CURRENCY: { type: "string" },
                        OB_22: { type: "string" },
                        SUBPRODUCT: { type: "string" },
                        CARD_TYPE: { type: "string" },
                        CARD_DATE_FROM: { type: "string" },
                        CARD_DATE_TO: { type: "string" },
                        DKBO_DATE_FROM: { type: "date" },
                        CUSTOMER_ID: { type: "number" },
                        CUSTOMER_ZKPO: { type: "string" },
                        CUSTOMER_NAME: { type: "string" },
                        DKBO_EXISTS: { type: "number" },
                        CUSTOMER_BDAY: { type: "date" },
                        PASS_SERIAL: { type: "string" },
                        PASS_NUMBER: { type: "string" },
                        DEAL_ID: { type: "number" },
                        ACC_ACC: { type: "number" },
                        DOC_ID:{ type: "string" }
                    }
                }
            }
        },
        sortable: true,
        filterable: true,
        resizable: true,
        autoBind: true,
        scrollable: true,
        selectable: 'single',
        pageable: {
            previousNext: true,
            refresh: true,
            pageSizes: [10, 20, 50, 100, 200],
            buttonCount: 3,
            messages: {
                itemsPerPage: ''
            }
        }
    }).data('kendoGrid');


    var setFilter = function () {

        if (isAccClose == 0) {
            if (acc && rnk) {
                kendoGrid.dataSource.filter({ field: "CUSTOMER_ID", operator: "eq", value: rnk });

                if (isDKBO != 1) {
                    var input = {
                        checked: true
                    }
                    checkBoxChecked(rnk, acc, input);
                }

            }
        }
        else if(rnk) {
            kendoGrid.dataSource.filter({ field: "CUSTOMER_ID", operator: "eq", value: rnk });
        }

        var customerRnk = $('#customerRnk').val();

        if(customerRnk !== ""){
            kendoGrid.dataSource.filter({ field: "CUSTOMER_ID", operator: "eq", value: customerRnk });
        }
        

    }

    setFilter();



    function onChange() {
        var dataItem = kendoGrid.dataItem(kendoGrid.select());
        model.Acc = dataItem.ACC_ACC;
        model.DocId = dataItem.DOC_ID;

        if (dataItem.DKBO_CONTRACT_ID != null || dataItem.DEAL_ID != null) {

            $('#btnEdit').prop('disabled', false);
            $('#btnPrint').prop('disabled', false);
            $('#dealId').val(dataItem.DEAL_ID);
            $('#customerRnk').val(dataItem.CUSTOMER_ID);
        }
        else {
            $('#btnEdit').prop('disabled', true);
            $('#btnPrint').prop('disabled', true);
            $('#dealId').val('');
            $('#customerRnk').val('');
        }
    }
});


function CheckedSelectedRow(customerId, customerAcc) {

    if (selectedRows.length != 0) {

        for (var i = 0; i < selectedRows.length; i++) {

            for (var a = 0; a < selectedRows[i].CustomerAccounts.length; a++) {

                if (selectedRows[i].CustomerRnk == customerId && selectedRows[i].CustomerAccounts[a] == customerAcc) {
                    return true;
                }

            }
        }
    }
    return false;
}

function addToDCBO() {

    bars.ui.confirm({
        text: 'Загальна кількість рахунків: ' + countCheckBox + ' рахунків <br/> Приєднати до ДКБО ?'
    }, function () {

        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/BpkW4/DKBOApi/post"),
            data: JSON.stringify(selectedRows),
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
        }).done(function (result) {
            bars.ui.alert({ text: result.Message });

            if (selectedRows.length == 1) {
                window.location.href = bars.config.urlContent('/bpkw4/checkdkbo/QuestItemsDisplay?dealId=' + result.DealId + '&customerRnk=' + result.CustomerRnk);
            }
            else {
                $("#grid").data('kendoGrid').dataSource.read();
            }

            selectedRows = [];
            countCheckBox = 0;

            $('#btnAdd').prop('disabled', true);
            $('#btnEdit').prop('disabled', true);
            $('#btnPrint').prop('disabled', true);
            $('#dealId').val('');

        }).fail(function () {
        });;
    });
}

function checkBoxChecked(customerId, customerAcc, input) {

    var curIndex;
    selectedRows.forEach(function (elem, index) {
        if (elem.CustomerRnk == customerId) {
            curIndex = index;
            return;
        }

    })

    $('#btnAdd').prop('disabled', false);

    if (input.checked) {

        countCheckBox++;

        if (curIndex == undefined)
            selectedRows.push({
                CustomerRnk: customerId,
                CustomerAccounts: [customerAcc]
            });
        else {

            if (selectedRows[curIndex].CustomerAccounts.indexOf(customerAcc) == -1)
                selectedRows[curIndex].CustomerAccounts.push(customerAcc);
        }

    }
    else {
        countCheckBox--;
        selectedRows[curIndex].CustomerAccounts.splice(selectedRows[curIndex].CustomerAccounts.indexOf(customerAcc), 1)

        if (selectedRows[curIndex].CustomerAccounts.length == 0)
            selectedRows.splice(curIndex, 1);

        if (selectedRows.length == 0) {
            $('#btnAdd').prop('disabled', true);
        }

    }

}

var printDkbo = function () {
   
    $.ajax({
        url: bars.config.urlContent('/bpkw4/checkdkbo/Print'),
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        data: { selectedACC: model.Acc, selectedDocID: model.DocId },
    }).done(function () {
        window.location.href = bars.config.urlContent('/PrintContract/Index?multiSelection=true');
    });

}












