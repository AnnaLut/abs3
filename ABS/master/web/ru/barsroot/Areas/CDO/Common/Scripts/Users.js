$(function () {
    $.get(bars.config.urlContent('/api/kernel/params/MFO'))
        .success(function (request) {
            $('#bankId').val(request.Value);
        })
        .error(function () {
            bars.ui.error({ text: 'Неможливо визначити МФО банку' });
        })
        .complete();


    kendo.bind($(".cl-admin"));
    $('#LoginProviderValue').change(function () {
        isConfirmedPhone = false;
    });

    $('#customersGrid').kendoGrid({
        height: 120,
        autoBind: true,
        selectable: 'single',
        groupable: false,
        sortable: true,
        resizable: true,
        filterable: true,
        scrollable: true,
        //pageable: {
        //    refresh: true,
        //    pageSizes: [10, 20, 50, 100, 200],
        //    buttonCount: 1
        //},
        pageable: {
            previousNext: false,
            info: false,
            refresh: true,
            pageSizes: [10, 20, 50, 100, 200],
            buttonCount: 1,
            messages: {
                itemsPerPage: '',
                next: '>',
                last: '<',
                previous: "<"
            }
        },
        dataBound: function (e) {
            var data = e.sender.dataSource.data();
            if (data.length === 0) {
                //if (e.sender.dataSource.total() === 0) {
                var colCount = e.sender.columns.length;
                $(e.sender.wrapper)
                    .find('tbody')
                    .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + e.sender.pager.options.messages.empty + ' </td></tr>');
            }
            var grid = this;
            grid.element.height("auto");
            grid.element.find(".k-grid-content").height("auto");
            kendo.resize(grid.element);
        },
        dataBinding: function () {
            //enableToolbarButtons(false);
        },
        change: function () {
            //enableToolbarButtons(true, selectedCustGridRow());
        },
        dataSource: {
            type: 'webapi',
            pageSize: 10,
            page: 1,
            total: 0,
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            serverGrouping: true,
            serverAggregates: true,
            /*sort: {
                field: "Id",
                dir: "desc"
            },*/
            filter: {
                // leave data items which are "Food" or "Tea"
                logic: "or",
                filters: [
                  { field: "Sed", operator: "eq", value: "91" },
                  { field: "TypeId", operator: "eq", value: 2 }
                ]
            },
            transport: {
                read: {
                    //url: bars.config.urlContent('/api/v1/clients/customers/'),
                    url: bars.config.urlContent('/api/cdo/common/customers') + ((bars.ext.getParamFromUrl('clmode') === 'visa') ? 'ForVisa/' : '/'),
                    dataType: 'json',
                    data: function () { return customersFilter; }

                    /*,
                    data: {filter1: function () { return vm.customersFilter; }} /*function () { return vm.customersFilter; } /* {
                        type: function () { return vm.customersFilter.type; },
                        showClosed: function () { return vm.customersFilter.showClosed; },
                        customFilter: function() { return vm.customersFilter; }
                    }*/
                }/*,
                        parameterMap: function (data, operation) {
                            debugger
                            return $.extend(data, vm.customersFilter);
                        }*/
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    id: 'Id',
                    fields: {
                        Id: {
                            type: 'number'
                        },
                        ContractNumber: {
                            type: 'string'
                        },
                        Code: {
                            type: 'string'
                        },
                        TypeId: {
                            type: 'number'
                        },
                        TypeName: {
                            type: 'string'
                        },
                        Sed: {
                            type: 'string'
                        },
                        Name: {
                            type: 'string'
                        },
                        DateOpen: {
                            type: 'date'
                        },
                        DateClosed: {
                            type: 'date'
                        },
                        Branch: {
                            type: 'string'
                        }
                    }
                }
            }
        },
        columns: [
            {
                field: 'Id',
                title: 'Реєстр.<br/>номер',
                template: '<a href="\\#" onclick="viewCustomer(#=Id#);return false;">#= Id #</a>',
                filterable: bars.ext.kendo.grid.uiNumFilter,
                width: '80px'
            }, {
                field: 'ContractNumber',
                title: '№ договору',
                width: '100px'
            }, {
                field: 'Code',
                title: 'ЕДРПОУ /<br/>іден. код',
                width: '100px'
            }, {
                field: 'TypeName',
                title: 'Тип клієнта',
                width: '160px',
                template: '<i class="pf-icon pf-16 pf-{{getClientTypeIcon(dataItem.TypeId)}}"></i> #=TypeName#'
            }, {
                field: 'Sed',
                title: 'Підпр.',
                template: '<input type="checkbox" #= Sed == \"91  \" ?  \"checked\":\"\" # onclick="return false;"/>',
                filterable: false,//{ messages: { isTrue: "trueString", isFalse: "falseString" } },
                width: '60px'
            }, {
                field: 'Name',
                title: 'Найменування',
                width: '200px'
            }, {
                field: 'DateOpen',
                title: 'Дата<br/>реєстрації',
                format: '{0:dd.MM.yyyy}',
                width: '80px'
            }, {
                field: 'DateClosed',
                title: 'Дата<br/>закриття',
                format: '{0:dd.MM.yyyy}',
                width: '80px'
            }, {
                field: 'Branch',
                title: 'Код безб.<br/>відділення',
                width: '170px'
            }
        ]
    });
});

var customersFilter = {
    type: 'ALL',
    showClosed: false,
    likeClause: '',
    systemFilterId: 0,
    userFilterId: 0,
    whereClause: ''
}


var viewCustomerWinOptions = {
    width: 960,
    height: 610
}
function viewCustomer(id) {
    var clMode = bars.ext.getParamFromUrl('clmode');
    var url = bars.config.urlContent('/clientregister/registration.aspx?readonly=0&rnk=' + id);
    if (clMode) {
        url += '&clmode=' + clMode;
    }
    bars.ui.dialog({
        actions: [ "Maximize", "Close" ],
        iframe: true,
        content: {
            url: url
        },
        width: viewCustomerWinOptions.width,
        height: viewCustomerWinOptions.height,
        close: function() {
            if (clMode === 'visa') {
                $('#customersGrid').data('kendoGrid').dataSource.read();
                //$('#customersGrid').data('kendoGrid').refresh();
            }
        }
    });
}
