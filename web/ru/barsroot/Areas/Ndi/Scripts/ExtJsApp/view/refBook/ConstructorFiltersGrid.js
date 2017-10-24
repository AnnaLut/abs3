//Ext.Loader.setConfig({
//    enabled: true
//});
//Ext.Loader.setPath('Ext.ux', '../ux');

Ext.require([
    'Ext.selection.CellModel',
    'Ext.grid.*',
    'Ext.data.*',
    'Ext.util.*',
    'Ext.state.*',
    'Ext.form.*',
    'Ext.ux.CheckColumn'
]);

Ext.onReady(function () {
    //Ext.QuickTips.init();
    var thisController;

    var columnsFilterModel = Ext.decode(window.StringColumnModel);
    var thisWindow = this;
    //function formatDate(value) {
    //    return value ? Ext.Date.dateFormat(value, 'M d, Y') : '';
    //}

    Ext.define('rowFilterModel', {
        extend: 'Ext.data.Model',
        fields: [
            { name: 'LogicalOp', type: Ext.form.field.ComboBox },
            { name: 'Colname', type: Ext.form.field.ComboBox },
            { name: 'ReletionalOp', type: Ext.form.field.ComboBox },
            { name: 'Value', type: 'stirng' }
        ]
    });


    // create the Data Store
    var store = Ext.create('Ext.data.Store', {
        // destroy the store if the grid is destroyed
        autoDestroy: true,
        model: 'rowFilterModel',
        proxy: {
            type: 'ajax',
            // load remote data using HTTP
            url: '',
            reader: {
                type: 'xml',
                // records will have a 'rowFilterModel' tag
                record: 'rowFilterModel'
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
    // create the grid and specify what field you want
    // to use for the editor at each header.
    var grid = Ext.define('ExtApp.view.refBook.ConstructorFiltersGrid', {
        extend: 'Ext.grid.Panel',
        store: store,
        id: 'ConstructorGrid',
        constructor: function (argument) {
            thisController = argument.thisController;
            this.callParent(new Array());
        },
        columns: [{
            id: 'Logical_Op',
            header: 'І/АБО',
            dataIndex: 'LogicalOp',
            width: 60,
            editor: new Ext.form.field.ComboBox({
                typeAhead: true,
                triggerAction: 'all',
                selectOnTab: true,
                store: [['І', 'І'],
                      ['АБО', 'АБО'],
                      [')', ')'],
                      ['(', '(']
                ],
                lazyRender: true,
                listClass: 'x-combo-list-small'
            })
        }, {
            header: 'Атрибут',
            dataIndex: 'Colname',
            width: 150,
            editor: new Ext.form.field.ComboBox({
                typeAhead: true,
                triggerAction: 'all',
                selectOnTab: true,
                store: columnsFilterModel,//[['И', 'И'], ['ИЛИ', 'ИЛИ']],
                // lazyRender: true,
                listClass: 'x-combo-list-small'
            })
        }, {
            header: 'Оператор',
            dataIndex: 'ReletionalOp',
            width: 100,
            align: 'center',
            editor: new Ext.form.field.ComboBox({
                typeAhead: true,
                triggerAction: 'all',
                selectOnTab: true,
                store: [['СХОЖИЙ', 'СХОЖИЙ'],
                      ['НЕ СХОЖИЙ', 'НЕ СХОЖИЙ'],
                      ['ПУСТИЙ', 'ПУСТИЙ'],
                      ['НЕ ПУСТИЙ', 'НЕ ПУСТИЙ'],
                      ['ОДИН З', 'ОДИН З'],
                      ['НЕ ОДИН З', 'НЕ ОДИН З'],
                      ['=', '='],
                      ['!=', '!='],
                      ['<>', '<>'],
                      ['<=', '<='],
                      ['>=', '>='],
                      ['>', '>'],
                      ['<', '<']
                ],

                // lazyRender: true,
                listClass: 'x-combo-list-small'
            })
        }, {
            header: 'Значення',
            dataIndex: 'Value',
            width: 150,
            editor: {
                allowBlank: true
            }
        },
        //{
        //    id: 'SemanticColumn',
        //    header: 'Семантика значения',
        //    dataIndex: 'Semantic',
        //    width: 55,
        //    flex: 1,
        //    editor: {
        //        allowBlank: true
        //    }
        //},
        {
            xtype: 'actioncolumn',
            width: 30,
            sortable: false,
            items: [{
                title: 'видалити',
                iconCls: 'minus_once',
                tooltip: 'Delete',
                handler: function (grid, rowIndex, colIndex) {
                    store.removeAt(rowIndex);
                }
            }]
        }],

        selModel: {
            selType: 'cellmodel'
        },

        width: 600,
        height: 300,
        title: 'Створення фільтрів',
        frame: true,
        tbar: [{
            text: 'Додати',
            iconCls: 'plus',
            itemId: 'addFilterButton',
            handler: function () {
                // Create a model instance
                var r = Ext.create('rowFilterModel', {
                });
                var grid = this.up('grid');
                var count = grid.getStore().getCount();
                store.insert(count, r);
                cellEditing.startEditByPosition({ row: 0, column: 0 });
                //btnSave
            }
        },
        {
            text: 'видалити все',
            iconCls: 'minus_once',
            itemId: 'deleteAlll',
            handler: function () {
                var grid = this.up('grid');
                try {
                    var store = grid.getStore();
                    store.removeAll();
                } catch (e) {
                    if (e.number != '-2146823281')
                        throw e;
                }
               
            }
        },
         btnSave = {
             xtype: 'button',
             text: 'Зберегти',
             itemId: 'save',
             iconCls: 'save_brown',
             handler: function (grid) {
                 var dataItems = ExtApp.utils.RefBookUtils.buildComplexFiltersRowItems(store.data.items);
                 thisController.writeFilter(1, dataItems, null);
             }
         },
        btnSaveDymanic = {
            xtype: 'button',
            text: 'Застосувати',
            tooltip: 'Запам\'ятати і застосувати',
            itemId: 'saveDynamic',
            iconCls: 'save',
            handler: function (grid) {
                var filterNameParam = new Object();
                filterNameParam.Name = 'filterName';
                filterNameParam.value = 'Складний фільтр';
                var dataItems = ExtApp.utils.RefBookUtils.buildComplexFiltersRowItems(store.data.items);
                thisController.saveFilterBtnHandler(filterNameParam, 0, dataItems, null);

            }
        }],
        listeners: {
            beforerender: function () {
                thisController.thisGrid = this;
                //thisGrid.metadata = thisGrid.thisController.controllerMetadata;
                //var store = thisGrid.getStore().reload();
                //var columns = thisGrid.columnManager.getColumns();
                //var col1 = columns[1];
                //col1.editor.sore.data.items = [
                //        ['И', 'И'],
                //        ['ИЛИ', 'ИЛИ']
                //];
                //thisGrid.CreateComponents = 'sdfsd';
            },
            beforeedit: function (row, cell) {
                if (row.context.colIdx == 0 && cell.rowIdx == 0)
                    return false;
                // alert("   " + cellindex);
            }
        },
        plugins: [cellEditing]
    });

    // manually trigger the data store load
    store.load({
        // store loading is asynchronous, use a load listener or callback to handle results
        callback: function () {
            //Ext.Msg.show({
            //    title: 'Store Load Callback',
            //    msg: 'store was loaded, data available for processing',
            //    modal: false,
            //    icon: Ext.Msg.INFO,
            //    buttons: Ext.Msg.OK
            //});
        }
    });


});