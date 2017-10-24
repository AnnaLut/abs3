//Ext.Loader.setConfig({
//    enabled: true
//});
//Ext.Loader.setPath('Ext.ux', '../ux');

//Ext.require([
//    'Ext.selection.CellModel',
//    'Ext.grid.*',
//    'Ext.data.*',
//    'Ext.util.*',
//    'Ext.state.*',
//    'Ext.form.*',
//    'Ext.ux.CheckColumn'
//]);

//Ext.onReady(function () {
//    //Ext.QuickTips.init();
//    var thisController;

//    var columnsFilterModel = Ext.decode(window.StringColumnModel);
//    var thisWindow = this;
//    function formatDate(value) {
//        return value ? Ext.Date.dateFormat(value, 'M d, Y') : '';
//    }

//    Ext.define('rowFilterModel', {
//        extend: 'Ext.data.Model',
//        fields: [
//            // the 'name' below matches the tag name to read, except 'availDate'
//            // which is mapped to the tag 'availability'
//            //{ name: 'common', type: 'string' },
//            //{ name: 'botanical', type: 'string' },
//            //{ name: 'light' },
//            //{ name: 'price', type: 'float' },
//            //// dates can be automatically converted by specifying dateFormat
//            //{ name: 'availDate', mapping: 'availability', type: 'date', dateFormat: 'm/d/Y' },
//            //{ name: 'indoor', type: 'bool' }
//        ]
//    });
    

//    // create the Data Store
//    var store = Ext.create('Ext.data.Store', {
//        // destroy the store if the grid is destroyed
//        autoDestroy: true,
//        model: 'rowFilterModel',
//        proxy: {
//            type: 'ajax',
//            // load remote data using HTTP
//            url: '',
//            // specify a XmlReader (coincides with the XML format of the returned data)
//            reader: {
//                type: 'xml',
//                // records will have a 'rowFilterModel' tag
//                record: 'rowFilterModel'
//            }
//        },
//        sorters: [{
//            property: 'common',
//            direction: 'ASC'
//        }]
//    });

//    var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
//        clicksToEdit: 1
//    });
//    // create the grid and specify what field you want
//    // to use for the editor at each header.
//    var grid = Ext.define('ExtApp.view.refBook. ', {
//        extend: 'Ext.grid.Panel',
//        store: store,
//        id: 'ConstructorGrid',
//        constructor: function (argument) {
//            thisController = argument.thisController;
//            this.callParent(new Array());
//        },
//        columns: [{
//            id: 'Logical_Op',
//            header: 'І/АБО',
//            dataIndex: 'LogicalOp',
//            width: 60,
//            editor: new Ext.form.field.ComboBox({
//                typeAhead: true,
//                triggerAction: 'all',
//                selectOnTab: true,
//                store: [  ['І', 'І'],
//                      ['АБО', 'АБО'],
//                      [')', ')'],
//                      ['(', '(']
//                    ],
//                lazyRender: true,
//                listClass: 'x-combo-list-small'
//            })
//        }, {
//            header: 'Атрибут',
//            dataIndex: 'Colname',
//            width: 150,
//            editor: new Ext.form.field.ComboBox({
//                typeAhead: true,
//                triggerAction: 'all',
//                selectOnTab: true,
//                store: columnsFilterModel,//[['И', 'И'], ['ИЛИ', 'ИЛИ']],
//               // lazyRender: true,
//                listClass: 'x-combo-list-small'
//            })
//        }, {
//            header: 'Оператор',
//            dataIndex: 'ReletionalOp',
//            width: 100,
//            align: 'center',
//            editor: new Ext.form.field.ComboBox({
//                typeAhead: true,
//                triggerAction: 'all',
//                selectOnTab: true,
//                store: [['СХОЖИЙ', 'СХОЖИЙ'],
//                      ['НЕ СХОЖИЙ', 'НЕ СХОЖИЙ'],
//                      ['ПУСТИЙ', 'ПУСТИЙ'],
//                      ['НЕ ПУСТИЙ', 'НЕ ПУСТИЙ'],
//                      ['НЕ ОДИН З', 'НЕ ОДИН З'],
//                      ['НЕ ОДИН З', 'НЕ ОДИН З'],
//                      ['=', '='],
//                      ['!=', '!='],
//                      ['<>', '<>'],
//                      ['<=', '<='],
//                      ['>=', '>='],
//                      ['>', '>'],
//                      ['<','<']
//                ],

//               // lazyRender: true,
//                listClass: 'x-combo-list-small'
//            })
//        }, {
//            header: 'Значення',
//            dataIndex: 'Value',
//            width: 150,
//            editor: {
//                allowBlank: true
//            }
//        },
//        //{
//        //    id: 'SemanticColumn',
//        //    header: 'Семантика значения',
//        //    dataIndex: 'Semantic',
//        //    width: 55,
//        //    flex: 1,
//        //    editor: {
//        //        allowBlank: true
//        //    }
//        //},
//        {
//            xtype: 'actioncolumn',
//            width: 30,
//            sortable: false,
//            items: [{
//                title: 'Видалити',
//                iconCls: 'minus_once',
//                tooltip: 'Delete',
//                handler: function (grid, rowIndex, colIndex) {
//                    store.removeAt(rowIndex);
//                }
//            }]
//        }],
       
//        selModel: {
//            selType: 'cellmodel'
//        },
        
//        width: 600,
//        height: 300,
//        title: 'Створення фільтрів',
//        frame: true,
//        tbar: [{
//            text: 'Додати',
//            iconCls: 'plus',
//            itemId: 'addFilterButton',
//            handler: function () {
//                // Create a model instance
//                var r = Ext.create('rowFilterModel',  {
//                });
//                var grid = this.up('grid');
//                var count = grid.getStore().getCount();
//                store.insert(count, r);
//                cellEditing.startEditByPosition({ row: 0, column: 0 });
//                //btnSave
//            }
//        },
//        {
//            text: 'Видалити все',
//            iconCls: 'minus_once',
//            itemId: 'deleteAlll',
//            handler: function () {
//                var grid = this.up('grid');
//                var grid = this.up('grid');
//                try {
//                    store.removeAll();
//                } catch (e) {
//                    if (e.number != '-2146823281')
//                        throw e;
//                }
//                store.removeAll();
//            }
//        },
//         btnSave =   {
//             xtype: 'button',
//             text: 'Зберегти',
//             itemId: 'save',
//             iconCls: 'save',
//             handler: function (grid) {
//                 var parArray = new Array();
//                 var parInput = {
//                     fieldLabel: 'назва фільтра',
//                     name: 'filterName',
//                     xtype: 'textfield'
//                 };
//                 parArray.push(parInput);
//                 var wind = Ext.create('ExtApp.view.refBook.EditWindow', {
//                     itemId: "CreateFilterWindow",
//                     title: 'введіть назву фільтра',
//                     items: Ext.create('ExtApp.view.refBook.FormPanel', { items: parArray }),
//                     width: 500,
//                     btnOkProps: {
//                         handler: function (btn) {
//                             var formWindow = btn.up('window');
//                             var form = formWindow.down('form').getForm();
//                             var param = {
//                                 Name: 'filterName',
//                                 value: form.findField('filterName').getValue()
//                             }
//                             formWindow.close();
//                            // var jsonParam = Ext.JSON.encode(param.Name);
                            
//                             var items = store.data.items;
//                             var params = new Array();
//                             Ext.each(items, function (item) {
//                                 var param = {};
//                                 param.LogicalOp = item.data['LogicalOp'];
//                                 param.Colname = item.data['Colname'];
//                                 param.ReletionalOp = item.data['ReletionalOp'];
//                                 param.Value = item.data['Value'];
//                                 //param.Semantic = item.data['Semantic'];
//                                 params.push(param);
//                             })
//                             Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' , wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
//                             var pars = Ext.JSON.encode(params);
//                             thisController.sendToServer(
//                                 "/barsroot/ReferenceBook/InsertFilter",
//                                 { tableId: thisController.controllerMetadata.tableInfo.TABID, tableName: thisController.controllerMetadata.tableInfo.TABNAME, parameters: pars, filterName: param.value },
//                                   function (status, msg) {
//                                       //обработка при удачном запросе на сервер
//                                       Ext.MessageBox.hide();
//                                       Ext.MessageBox.show({ title: 'збереження', msg: msg + '</br> </br>', buttons: Ext.MessageBox.OK });
//                                       if (status == "ok") {
//                                           //перечитка данных грида

//                                           var filterGrid = Ext.getCmp('CustomFilterGrid');
//                                           if (filterGrid)
//                                           filterGrid.store.reload();
//                                       }

//                                   });
//                         }
//                     }
//                 });
                
//             }
//         }],
//            listeners: {
//        beforerender: function () {
//            thisController.thisGrid = this;
//            //thisGrid.metadata = thisGrid.thisController.controllerMetadata;
//            //var store = thisGrid.getStore().reload();
//            //var columns = thisGrid.columnManager.getColumns();
//            //var col1 = columns[1];
//            //col1.editor.sore.data.items = [
//            //        ['И', 'И'],
//            //        ['ИЛИ', 'ИЛИ']
//            //];
//            //thisGrid.CreateComponents = 'sdfsd';
//        },
//        beforeedit: function (row, cell) {
//            if (row.context.colIdx == 0 && cell.rowIdx == 0)
//                return false;
//           // alert("   " + cellindex);
//        }
//    },
//        plugins: [cellEditing]
//    });

//    // manually trigger the data store load
//    store.load({
//        // store loading is asynchronous, use a load listener or callback to handle results
//        callback: function () {
//            //Ext.Msg.show({
//            //    title: 'Store Load Callback',
//            //    msg: 'store was loaded, data available for processing',
//            //    modal: false,
//            //    icon: Ext.Msg.INFO,
//            //    buttons: Ext.Msg.OK
//            //});
//        }
//    });


//});