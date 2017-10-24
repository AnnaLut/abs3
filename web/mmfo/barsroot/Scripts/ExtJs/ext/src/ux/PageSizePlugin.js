Ext.namespace('Ext.ux');

//get adapted to store data format variable
var paingSizeStartValue = function (seed) {
    return [String(seed), seed]
};

Ext.ux.PageSizePlugin = function (defaultFirstValue) {
    if (defaultFirstValue == undefined) {
        defaultFirstValue = 10;
    }
    Ext.ux.PageSizePlugin.superclass.constructor.call(this, {
        store: new Ext.data.SimpleStore({
            fields: ['text', 'value'],
            data: [paingSizeStartValue(defaultFirstValue), ['20', 20], ['50', 50], ['100', 100], ['200', 200], ['500', 500], ['1000', 1000]]
        }),
        mode: 'local',
        displayField: 'text',
        valueField: 'value',
        editable: false,
        allowBlank: false,
        triggerAction: 'all',
        width: 60
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