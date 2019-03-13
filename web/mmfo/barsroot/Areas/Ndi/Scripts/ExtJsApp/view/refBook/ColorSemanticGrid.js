
Ext.require([
    'Ext.selection.CellModel',
    'Ext.grid.*',
    'Ext.data.*',
    'Ext.util.*',
    'Ext.state.*',
    'Ext.form.*',
    'Ext.ux.CheckColumn'
]);

var colorGridObject;
Ext.onReady(function () {
    //Ext.QuickTips.init();
    var thisController;

    var columnsFilterModel = Ext.decode(window.StringColumnModel);
    var thisWindow = this;

    var model = Ext.define('rowColorMdoel', {
        extend: 'Ext.data.Model',
        listeners:  {
                render: function (a,b) {
                   // alert('rowColorMdoel render');
                }
        },
        fields: [
            { name: 'COLOR_NAME', type: 'stirng' },
            { name: 'COLOR_SEMANTIC', type: 'stirng' }
        ]
    });


    // create the Data Store
    var store = Ext.create('Ext.data.Store', {
        // destroy the store if the grid is destroyed
        autoDestroy: true,
        model: 'rowColorMdoel',
        proxy: {
            type: 'ajax',
            // load remote data using HTTP
            url: '',
            reader: {
                type: 'xml',
                // records will have a 'rowColorMdoel' tag
                record: 'rowColorMdoel'
            }
        },
        sorters: [{
            property: 'common',
            direction: 'ASC'
        }]
    });

    var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 1
    });



    var grid = Ext.define('ExtApp.view.refBook.ColorSemanticGrid', {
        extend: 'Ext.grid.Panel',
        store: store,
        id: 'ColorSemanticGridId',
        constructor: function (argument) {
            
            colorGridObject = this;
            thisController = argument.thisController;
            this.callParent(new Array());
        },
        initComponent: function (argument) {
            
            this.callParent();
        },
        columns: [{
            header: 'Кольор',
            dataIndex: 'COLOR_NAME',
            width: 100,
            //flex: 30 / 100,
            renderer: function (value, cellInfo) {
                
                if (value.toUpperCase().indexOf('COLOR_') > -1)
                    cellInfo.tdCls += ' bg_' + value;
                else
                    cellInfo
                        .style += "background-color:" + value + ";";
                return "";
            },
            editor: {
                allowBlank: true

            }
            },
            {
            header: 'Опис застосування  кольору',
            dataIndex: 'COLOR_SEMANTIC',
            width: 150,
            flex: 200 / 250,
            editor: {
                allowBlank: true
            }
        }],

        selModel: {
            selType: 'cellmodel'
        },

        //width: 600,
        height: 350,
        title: 'Опис значення кольорів',
        frame: true,

        //viewConfig: {
        //    stripeRows: false,
        //    viewConfig: {
        //        getRowClass: function(record, rowIndex, rowParams, store) {
        //            return "bg_color_salmon";
        //        }
        //    },
//
        //    /* Provide configuration for the locked portion of the grid */
        //    lockedViewConfig: {
        //        getRowClass: function(record, rowIndex, rowParams, store) {
        //            return "bg_color_salmon";
        //        }
        //    },
        //    render: function (grid, record) {
        //
        //    },
        //    getTdCls: function () {
        //
        //    }
        //},
        //renderTo: document.body,
        plugins: [cellEditing]
    });


});