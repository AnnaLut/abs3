Ext.namespace('Ext.ux');

Ext.ux.PageSizePlugin = function () {
    Ext.ux.PageSizePlugin.superclass.constructor.call(this, {
        store: new Ext.data.SimpleStore({
            fields: ['text', 'value'],
            data: [['10', 10], ['20', 20], ['50', 50], ['100', 100]]
        }),
        mode: 'local',
        displayField: 'text',
        valueField: 'value',
        editable: false,
        allowBlank: false,
        triggerAction: 'all',
        width: 45
    });
};

Ext.extend(Ext.ux.PageSizePlugin, Ext.form.ComboBox, {
    init: function (paging) {
        paging.on('render', this.onInitView, this);
    },

    onInitView: function (paging) {
        paging.add(this);
        this.setValue(paging.store.pageSize);
        this.on('select', this.onPageSizeChanged, paging);
    },

    onPageSizeChanged: function (combo) {
        this.store.pageSize = parseInt(combo.getValue());
        this.store.currentPage = 1;
        this.doRefresh();
    }
});