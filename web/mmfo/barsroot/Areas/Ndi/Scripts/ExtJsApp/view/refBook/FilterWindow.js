var metadata;

Ext.define('ExtApp.view.refBook.FilterWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.FilterWindow',
    Id: "myFilterWindow",
    closeAction: 'destory',
    autoShow: true,
    //для того чтобы большие экраны не заползали за верх монитора
    constrainHeader: true,
    minWidth: 800,
    minHeight: 200,
    maxWidth: 1000,
    maxHeight: 600,
    margin: 0,
    layout: 'fit',
    buttons: [
        {
            //свойства по умолчанию, могут быть переопределены в initComponent
            itemId: 'okButton',
            text: 'Далі',
            iconCls: 'arrow_right',
            handler: function (btn) {
                metadata.thisController.filterDialogOkBtnHandler(btn);
            } 
        }, {
            itemId: 'cancelButton',
            text: 'Відмінити',
            iconCls: 'cancel',
            handler: function (btn) {
                
                btn.up('window').close();
                if (window.getFiltersOnly && window.getFiltersOnly.toUpperCase() == 'TRUE' && window.parent.CallFunctionFromMetaTable)
                    window.parent.CallFunctionFromMetaTable(null, false);
               
            }
        }
    ],
    listeners: {
        beforerender: function () {
            var thisEditWindow = this;
            metadata = thisEditWindow.controllerMetadata;
        },
        afterrender: function () {
           
            //if (metadata.applyFilters) {
            //    var cleareBtn = Ext.getCmp('clareFilersInDialogId');
            //    cleareBtn.setDisabled(false);
            //}
        }
    },

    initComponent: function () {
        
        var thisWindow = this;
        metadata = thisWindow.controllerMetadata;
        var hasApplyFilters = metadata.applyFilters.hasAplyFilters;
        thisWindow.buttons.push({
            id: 'clareFilersInDialogId',
            text: 'Скасувати фільтри',
            title: 'Скасувати фільтри',
            iconCls: 'clear_filter',
            disabled: !hasApplyFilters,
            handler: function (btn) {
                
                var thisEditWindow = btn.up('window');
                var thiswindController = thisEditWindow.controllerMetadata.thisController;
                var constructor = Ext.getCmp('ConstructorGrid');
                var tab = Ext.getCmp('filterWindowTabPanel');
                if(tab)
                  var  constructorGrid = tab.down('#ConstructorGrid').getView();
                if (constructorGrid)
                {
                        constructorGrid.store.data.removeAll();
                        var store = constructorGrid.getStore();// insertEmtyRowInConstructor
                        store.removeAll();
                        thiswindController.insertEmtyRowInConstructor();
                    
                }
                  
                thiswindController.onClearFilterClick();
                btn.setDisabled(true);
            }
        })
        this.callParent();
    }
});