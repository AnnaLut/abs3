Ext.application({

    name: 'ExtApp',
    appFolder: '/barsroot/Areas/Ndi/Scripts/ExtJsApp',

    requires: [
        'Ext.grid.*',
        'Ext.data.*',
        'Ext.ux.grid.FiltersFeature'
    ],

    views: [
        
    ],

    stores: [

    ],

    controllers: [
        'refBook.RefList'
    ],

    launch: function () {
        //код АРМ-а, список справочников которого мы просматриваем
        var appId = window.appId;
        Ext.create('ExtApp.view.refBook.RefList', { appId : appId });
    }
});




