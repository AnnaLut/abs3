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

    var model = Ext.define('rowFilterModel', {
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
        listeners: {
            afterload: function () {
                

            },
            load: function () {
                
            }
        },
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
    var cancelUpdateFilter = function (btn) {
       btn.hide();
       var constructor = btn.up('grid');
       constructor.additionalProperties.filterModel = {};
       constructor.additionalProperties.filterModel.isEditingFilter = false;
        
        //var toolbar = constructor.down('toolbar');
        //toolbar.remove(btn);
        constructor.setTitle('Створення фільтрів');
        constructor.store.removeAll();
        constructor.store.sync();
    };

    var grid = Ext.define('ExtApp.view.refBook.ConstructorFiltersGrid', {
        extend: 'Ext.grid.Panel',
        store: store,
        id: 'ConstructorGrid',
        columnLines: true,
        constructor: function (argument) {
            thisController = argument.thisController;
            var filterModel = {};
            filterModel.isEditingFilter = false;
            this.additionalProperties = { filterModel: filterModel };
            this.callParent(new Array());
        },
        columns: [{
            id: 'Logical_Op',
            header: 'І/АБО',
            dataIndex: 'LogicalOp',
            width: 12,
            flex: 12 / 100,
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
            width: 30,
            flex: 30 / 100,
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
            width: 14,
            flex: 14 / 100,
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
            width: 38,
            flex: 38 / 100,
            editor: {
                allowBlank: true
            }
        },
        {
            xtype: 'actioncolumn',
            width: 6,
            flex: 6 / 100,
            sortable: false,
            items: [{
                title: 'Видалити',
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

        //width: 600,
        height: 350,
        title: 'Створення фільтрів',
        frame: true,
        tbar: [{
            text: 'Додати',
            iconCls: 'plus',
            itemId: 'addFilterButton',
            handler: function (row, e) {
                // Create a model instance
                
                var r = Ext.create('rowFilterModel', {
                });
                var grid = this.up('grid');
                var selectedRecord = grid.getSelectionModel().getSelection()[0];
                var rowNumber;
                if (selectedRecord)
                    rowNumber = grid.store.indexOf(selectedRecord) + 1;
                else
                    rowNumber = grid.getStore().getCount();
                store.insert(rowNumber, model);
                cellEditing.startEditByPosition({ row: 0, column: 0 });
                //btnSave
            }
        },
        {
            text: 'Видалити все',
            iconCls: 'minus_once',
            itemId: 'deleteAlll',
            handler: function () {
                var grid = this.up('grid');
                try {
                    var store = grid.getStore();
                    store.removeAll();
                } catch (e) {
                    if (e.number != '-2146823281' && e.message != "Cannot read property 'getId' of undefined") {
                        throw e;
                    }
                }
               
            }
        },
         btnSave = {
             xtype: 'button',
             text: 'Зберегти',
             itemId: 'save',
             iconCls: 'save_brown',
             handler: function (btn) {
                 var thisGrid = btn.up('grid');
                 var dataItems = ExtApp.utils.RefBookUtils.buildComplexFiltersRowItems(store.data.items);
                 var filterModel = thisGrid.additionalProperties.filterModel;
                 thisController.writeFilter(1, dataItems, null,filterModel);
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
        },
        btnCancelEditFilter = {
            xtype: 'button',
            text: 'Відмінити редагування',
            tooltip: 'Відмінити редагування',
            itemId: 'cancelEditFilterId',
            iconCls: 'cancel',
            hidden: true,
            handler: function (btn) {
                cancelUpdateFilter(btn);
            }
        }],
        listeners: {
            beforeedit: function (row, cell) {
                if (row.context.colIdx == 0 && cell.rowIdx == 0)
                    return false;
                // alert("   " + cellindex);
            }
        },
        plugins: [cellEditing]
    });
  
   
});