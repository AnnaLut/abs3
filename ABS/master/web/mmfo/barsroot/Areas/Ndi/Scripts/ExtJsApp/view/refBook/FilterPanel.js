
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
                 //        //    
                 //        //   alert(  this.metadata.tableInfo.TABNAME)
                 //        //}
                 //    }
                 //]
             }
    ],
    constructor: function (metadata) {
        var self = this;
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
  
            myTabPanel.down('#SypleFilterFormPanelId').doLayout();
       
            self.items = myTabPanel;
            ExtApp.view.refBook.FilterPanel.superclass.initComponent.call(this);
            return this;
        }


        
        var  thisController = thisControllerFunc;
        var metadata = thisController.controllerMetadata;
        var hasGridColors = metadata.colorsForGrid && metadata.colorsForGrid.length && metadata.colorsForGrid.length > 0;
        var tab = Ext.create('Ext.tab.Panel', {
            width: '100%',
            minHeight: 200,
            maxHeight: 600,
            id: 'tabFilterPanel',
           // renderTo: Ext.getBody(),
            items: [
             
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
                id: 'SympleFilterTub',
                minHeight: 100,
                width: '100%',
                maxHeight: 600,
                maxWidth: 600
            });
        if(hasGridColors)
            tab.add(
                {
                    title: 'Опис кольорів',
                    id: 'ColorTabId',
                    items: Ext.create('ExtApp.view.refBook.ColorSemanticGrid', { thisController: thisController }),
                    minHeight: 100,
                    width: '100%',
                    maxHeight: 600
                });

        
        self.items = tab;
        for (var i =  0; i < tab.items.length; i++) {
            tab.setActiveTab(i);
        }
        tab.setActiveTab('ConstructorTabId');
        ExtApp.view.refBook.FilterPanel.superclass.initComponent.call(this);
    },
    thisControllerFunc: function()
    {

    },
    metadataFunc: function()
    {

    }
    
    
})


