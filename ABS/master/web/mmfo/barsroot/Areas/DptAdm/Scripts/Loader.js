if (!('bars' in window)) window['bars'] = {};
bars.utils = bars.utils || {};
bars.utils.dptadm = bars.utils.dptadm || {
    showTypes: function () {
        var grid = $('#grid_dpt_types').data('kendoGrid');
        var row = grid.dataItem(grid.select());
        bars.utils.dptadm.currentTypeId = row.TYPE_ID;        
    },
    prepareTypesWindow: function () {
        var self = bars.utils.dptadm;
        if (!self._TypesWndPrepared) {
            $('grid_dpt_types').kendoGrid({
                detailInit: self.detailInit,
                dataBound: function () {
                    this.expandRow(this.tbody.find("tr.k-master-row").first());
                },
                dataSource: {
                    type: "aspnetmvc-ajax",
                    schema: {
                        data: "Data",
                        total: "Total"
                    },
                    transport: {
                        read: {
                            url: bars.config.urlContent('/DptAdm/DptAdm/GetDptType'),
                            data: self.getCurrentType
                        }
                    },
                    pageSize: 10,
                    serverPaging: true,
                    serverSorting: true
                },
                pageable: {
                    buttonCount: 5
                },
                columns: [
                    {
                        field: "TYPE_ID",
                        title: "#"
                    },
                    {
                        field: "TYPE_CODE",
                        title: "Код типу"
                    },
                    {
                        field: "TYPE_NAME",
                        title: "Назва"
                    },
                    {
                        field: "FL_ACTIVE",
                        title: "Активний"
                    },
                    {
                        field: "FL_DEMAND",
                        title: "До запитання"
                    }, {
                        field: "SORT_ORD",
                        title: "№з/п"}
                ]
            });
            self._TypesWndPrepared = true;
        } else {
            var grid = $('#grid_dpt_types').data('kendoGrid');
            grid.dataSource.read();
            grid.refresh();
        }
    },
    currentTypeId: null,
    getCurrentType: function () {
        return { TypeId: bars.utils.dptadm.currentTypeId }
    }
};
