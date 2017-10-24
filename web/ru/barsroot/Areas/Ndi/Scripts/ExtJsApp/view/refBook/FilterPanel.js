
Ext.define('ExtApp.view.refBook.FilterPanel', {
    extend: 'Ext.Panel',
    alias: 'widget.GridFilterPanel',
    dock: 'top',
    collapsed: true,
    collapsible: true,
    cls: 'extfilter-panel',
    title: 'фільтри',
    header: {
        listeners: {
            dblclick: function (header) {
                var panel = header.up('panel');
                if (panel.getCollapsed()) {
                    panel.expand();
                } else {
                    panel.collapse();
                }
            }
        }
    },
    items: [
             {
                 xtype: 'form',
                 name: 'FilterForm',
                 buttonAlign: 'left',
                 layout: {
                     type: 'hbox',
                     pack: 'start',
                     align: 'stretch'
                 }
                 //items: [{ width: 400, items: new Array() }, { flex: 400, items: new Array() }]
                 //buttons: [
                 //    {
                 //        text: 'Виконати фільтр',
                 //        //handler: function () {
                 //        //   // var form = this.findParentByType('form');
                 //        //    // form.applyFilters(form.store);
                 //        //    debugger;
                 //        //   alert(  this.metadata.tableInfo.TABNAME)
                 //        //}
                 //    }
                 //]
             }
    ],
    constructor: function (metadata) {
        var self = this
        thisControllerFunc = metadata.metadata.thisController;
        metadataFunc = metadata.metadata;
        self.superclass.constructor.call(this);
        return this;
    },
    initComponent: function () {
        var self = this
        if (metadataFunc.filtersMetainfo.ShowFilterWindow != 'false' ||
            (metadataFunc.filtersMetainfo.CustomFilters && metadataFunc.filtersMetainfo.CustomFilters.length > 0) 
            || (metadataFunc.filtersMetainfo.SystemFilters && metadataFunc.filtersMetainfo.SystemFilters.length > 0))
        {
            var myTabPanel = metadataFunc.tabPanel;
            myTabPanel.down('#SypleFilterFormPanelId').removeAll(true);
            myTabPanel.down('#SypleFilterFormPanelId').add(thisControllerFunc.controllerMetadata.SympleFilters);
            //myTabPanel.items.items[3].remove('SimpleFilterPanelId', true);
            myTabPanel.down('#SypleFilterFormPanelId').doLayout();
            //myTabPanel.items.items[3].add(Ext.create('ExtApp.view.refBook.SimpleFilterPanel', { thisController: thisControllerFunc }));
            //myTabPanel.items.items[3].doLayout();
            //myTabPanel.add(
            //{
            //    title: 'звичайні',
            //    items: Ext.create('ExtApp.view.refBook.SimpleFilterPanel', { thisController: thisControllerFunc }),
            //    //    items: thisController.controllerMetadata.SympleFilters,
            //    //    height: 300,
            //    //    fieldDefaults: {
            //    //        labelAlign: 'left',
            //    //        labelWidth: 200
            //    //    }
            //    //}),
            //    id: 'SympleFilterTub2',
            //    minHeight: 100,
            //    width: '100%',
            //    maxHeight: 600
            //});// = Ext.create('ExtApp.view.refBook.ConstructorFiltersGrid', { thisController: thisController });
          
            //if (myTabPanel.items.length > 4)
            //    myTabPanel.setActiveTab(4);
            //if (myTabPanel.items.length > 3)
            //    myTabPanel.setActiveTab(3);
            //if (myTabPanel.items.length > 2)
            //    myTabPanel.setActiveTab(2);
            //if (myTabPanel.items.length > 1)
            //    myTabPanel.setActiveTab(1);
            //myTabPanel.setActiveTab(0);
            self.items = myTabPanel;
            ExtApp.view.refBook.FilterPanel.superclass.initComponent.call(this);
            return this;
        }
            
        
       
        var  thisController = thisControllerFunc;
        var metadata = self.controllerMetadata;
        var tab = Ext.create('Ext.tab.Panel', {
            width: '100%',
            minHeight: 200,
            maxHeight: 600,
            id: 'tabFilterPanel',
           // renderTo: Ext.getBody(),
            items: [
                //{
                //    title: 'Конструктор фільтрів',
                //    //items: Ext.create('ExtApp.view.refBook.ConstructorFiltersGrid', { thisController: thisController }),
                //    //minHeight: 100,
                //   // width: '100%',
                //   // maxHeight: 600
                //}
            ]
        });
        tab.add(
           {
               title: 'Конструктор фільтрів',
               items: Ext.create('ExtApp.view.refBook.ConstructorFiltersGrid', { thisController: thisControllerFunc }),
               minHeight: 100,
               width: '100%',
               maxHeight: 600
           });
        tab.add(
            {
                title: 'звичайні',
                items: Ext.create('ExtApp.view.refBook.SimpleFilterPanel', { thisController: thisController }),
                //    items: thisController.controllerMetadata.SympleFilters,
                //    height: 300,
                //    fieldDefaults: {
                //        labelAlign: 'left',
                //        labelWidth: 200
                //    }
                //}),
                id: 'SympleFilterTub',
                minHeight: 100,
                width: '100%',
                maxHeight: 600,
                maxWidth: 600
            });
        //var myTabPanel = metadata.metadata.tabPanel;
       
        self.items = tab;
        if (tab.items.length > 4)
            tab.setActiveTab(4);
        if (tab.items.length > 3)
            tab.setActiveTab(3);
        if (tab.items.length > 2)
            tab.setActiveTab(2);
        if (tab.items.length > 1)
            tab.setActiveTab(1);
        tab.setActiveTab(0);
        
        ExtApp.view.refBook.FilterPanel.superclass.initComponent.call(this);
        
       // self.doLayout();
    },
    thisControllerFunc: function()
    {

    },
    metadataFunc: function()
    {

    }
    
    
})


