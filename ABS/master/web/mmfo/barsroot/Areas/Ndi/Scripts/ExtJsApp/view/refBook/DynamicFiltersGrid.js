Ext.onReady(function myfunction() {
    Ext.define('DynamicFilterModel', {
        extend: 'Ext.data.Model',
        fields: [
            { name: 'IsApplyFilter', type: 'checkcolumn' },
            { name: 'FilterName', type: 'string' },
            { name: 'Where_clause', type: 'string' }
        ]
    });

    var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 1
    });

    var store = Ext.create('Ext.data.Store', {
        // destroy the store if the grid is destroyed
        autoDestroy: true,
        model: 'DynamicFilterModel',
        proxy: {
            dtype: 'ajax',
            // load remote data using HTTP
            url: '',
            reader: {
                type: 'xml',
                // crecords will have a 'rowFilterModel' tag
                reord: 'DynamicFilterModel'
            }
        }
    });
    var thisController;
    var grid = Ext.define('ExtApp.view.refBook.DynamicFiltersGrid', {
        extend: 'Ext.grid.Panel',
        store: store,
        id: 'DynamicFiltersGridId',
        constructor: function (argument) {
            thisController = argument.thisController;
            this.callParent(new Array());
        },
        columns: [{
            id: 'IsCheckedColumnId',
            header: 'обрати',
            dataIndex: 'IsApplyFilter',
            xtype: 'checkcolumn',
            width: 5,
            flex: 5 / 100,
            listeners: {
                //нужно для того чтобы чекбоксы были readonly
                // beforecheckchange: function () { return false; }
                checkchange: function (comp, rowIndex, checked, eOpts) {
                    var thisGrid = this.up('grid');
                    thisController.controllerMetadata.applyFilters.DynamicBeforeFilters = [];
                    thisGrid.getStore().each(function (record) {
                        if (record.data['IsApplyFilter'] == 1)
                            thisController.controllerMetadata.applyFilters.DynamicBeforeFilters.push({
                                //к имени поля добавляем имя таблицы
                                Where_clause: record.data['Where_clause']
                            });
                    });
                    thisController.updateApplyFilters(thisGrid);
                    thisController.controllerMetadata.mainGrid = Ext.getCmp('mainReferenceGrid');
                    if (thisController.controllerMetadata.mainGrid)
                        thisController.updateGridByFilters();
                }
            }
        }, {
            header: 'Імя фільтра',
            dataIndex: 'FilterName',
            width: 30,
            flex: 30 / 100
        }, {
            header: 'умови фільтра',
            dataIndex: 'Where_clause',
            width: 65,
            flex: 65 / 100,
            align: 'left'
            
        }
        ],

        //selModel: {
        //    selType: 'cellmodel'
        //},

       // width: 600,
        height: 350,
        title: 'Динамічні фільтри',
        frame: true,
        tbar: [
         btnSave = {
             xtype: 'button',
             text: 'Зберегти',
             title: 'Зберегти в базу данних',
             itemId: 'saveSelectedFilter',
             iconCls: 'save',
             disabled: true,
             handler: function (btn) {
                 var grid = btn.up('grid');
                 var row = grid.getSelectionModel().getSelection()[0];
                 var clause = row.data['Where_clause'];
                 var parArray = new Array();
                 var parInput = {
                     fieldLabel: 'назва фільтра',
                     name: 'filterName',
                     xtype: 'textfield',
                     value: row.data['FilterName']
                 };
                 parArray.push(parInput);
                 var wind = Ext.create('ExtApp.view.refBook.EditWindow', {
                     itemId: "CreateFilterWindow",
                     title: 'введіть назву фільтра',
                     width: 500,
                     items: Ext.create('ExtApp.view.refBook.FormPanel', { items: parArray }),
                     btnOkProps: {
                         handler: function (btn) {
                             var formWindow = btn.up('window');
                             var form = formWindow.down('form').getForm();
                             var param = {
                                 Name: 'filterName',
                                 value: form.findField('filterName').getValue()
                             }
                             formWindow.close();

                             thisController.saveFilterBtnHandler(param, 1, [], clause);

                         }
                         
                     }
                 });

             }
         }],
        listeners: 
            {
                selectionchange: function (container, pos, eOpts) {
                    this.down('#saveSelectedFilter').setDisabled(false);
                }
            },
            plugins: [cellEditing]
    });
});