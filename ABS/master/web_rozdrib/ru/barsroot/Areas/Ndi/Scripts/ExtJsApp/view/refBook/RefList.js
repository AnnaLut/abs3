Ext.define('ExtApp.view.refBook.RefList', {
    extend: 'Ext.tree.Panel',
    alias: 'widget.referenceList',
    margin: 10,
    requires: [
        'Ext.data.*',
        'Ext.grid.*',
        'Ext.tree.*',
        'Ext.ux.CheckColumn'
    ],
    xtype: 'tree-grid',

    title: 'Довідники',
    //height: 300,
    useArrows: true,
    rootVisible: false,
    hideHeaders: true,
    singleExpand: false,

    listeners: {
        //сворачивание-разворачивание одним кликом
        itemclick: function(view, node) {
            if (node.isLeaf()) {
            } else if (node.isExpanded()) {
                node.collapse();
            } else {
                node.expand();
            }
        }
    },

    initComponent: function () {
        Ext.apply(this, {
            store: new Ext.data.TreeStore({
                proxy: {
                    type: 'ajax',
                    url: '/barsroot/ndi/referenceBook/GetReferenceTree?appId=' + this.appId
                },
                folderSort: true,
                fields: ["name"]
            }),

            columns: [{
                xtype: 'treecolumn', 
                flex: 1,
                dataIndex: 'name'
            }]
        });
        this.callParent();
    },

    renderTo: Ext.getBody()
});