Ext.define('ExtApp.view.refBook.RefGridFilterExt', {
    extend: 'Ext.Panel',
    alias: 'widget.refGridFilterExt',
    dock: 'top',
    collapsed: true,
    collapsible: true,
    cls: 'extfilter-panel',
    title: 'Додаткові параметри фільтрації',
    items: [
        {
            xtype: 'form',
            name: 'extFilterForm',
            buttonAlign: 'left',
            layout: {
                type: 'hbox',
                pack: 'start',
                align: 'stretch'
            },
            items: [{ width: 400, items: new Array() }, { flex: 400, items: new Array() }],
            buttons: [
                {
                    text: 'Виконати фільтр',
                    handler: function () {
                        var form = this.findParentByType('form');
                        form.applyFilters(form.store);
                    }
                }
            ],
            applyFilters: function (store) {
                function ExtFilter(field) {
                    this.value = field.value;
                    this.extFilterMeta = {};
                    this.extFilterMeta.addColName = field.metaFilter.AddColName;
                    this.extFilterMeta.addTabName = field.metaFilter.AddTabName;
                    this.extFilterMeta.comparison = field.Comparison;
                    this.extFilterMeta.hostColName = field.metaFilter.HostColName;
                    this.extFilterMeta.varColName = field.metaFilter.VarColName;
                    this.extFilterMeta.varColType = field.metaFilter.VarColType;
                };

                var form = this.getForm();
                var extFilters = [];
                form.getFields().each(function (field) {
                    if (field.value) {
                        var extfilter = new ExtFilter(field);
                        extFilters.push(extfilter);
                    }
                });
                store.getProxy().extraParams.externalFilter = Ext.encode(extFilters);
                store.reload();
            }
        }
    ],
    store: null,
    constructor: function (extFiltersMeta, store) {
        var self = this;
        self.hidden = extFiltersMeta.length <= 0;
        self.items[0].store = store;

        var numberOfFilter = 0;
        Ext.each(extFiltersMeta, function (flt) {
            numberOfFilter++;
            var filterItem = {
                    xtype: 'container',
                    style: {
                        padding: '6px'
                    },
                    isFilter: true,
                    labelAlign: 'left'
                };
            var metaFilter = this;
            var editor = {};
            switch (this.VarColType) {
                case 'N':
                case 'E':
                    editor = [
                        {
                            xtype: 'numberfield',
                            fieldLabel: flt.Caption.replace(/~/g, " ") + ', від',
                            labelWidth: 200, labelAlign: 'right',
                            Comparison: "gt",
                            metaFilter: metaFilter,
                            plugins: ['clearbutton']
                        },
                        {
                            xtype: 'numberfield',
                            fieldLabel: "до",
                            labelWidth: 200,
                            labelAlign: 'right',
                            Comparison: "lt",
                            metaFilter: metaFilter,
                            plugins: ['clearbutton']
                        }
                    ];
                    break;
                case 'B':
                    editor = [
                    {
                        xtype: 'combo',
                        fieldLabel: flt.Caption.replace(/~/g, " "),
                        labelWidth: 200,
                        labelAlign: 'right',
                        editable: false,
                        store: [['1', 'Так'], ['0', 'Ні']],
                        metaFilter: metaFilter,
                        plugins: ['clearbutton'],
                        isBoolean: true
                    }];
                    break;
                case 'D':
                    editor = [
                        {
                            xtype: 'datefield',
                            fieldLabel: flt.Caption.replace(/~/g, " ") + ', від',
                            labelWidth: 200,
                            labelAlign: 'right',
                            Comparison: "gt",
                            metaFilter: metaFilter,
                            plugins: ['clearbutton'],
                            isBoolean: true
                        },
                        {
                            xtype: 'datefield',
                            fieldLabel: 'до',
                            labelWidth: 200,
                            labelAlign: 'right',
                            Comparison: "lt",
                            metaFilter: metaFilter,
                            plugins: ['clearbutton'],
                            isBoolean: true
                        }
                    ];
                    break;
                default:
                    editor = [
                    {
                        xtype: 'textfield',
                        fieldLabel: flt.Caption.replace(/~/g, " "),
                        labelWidth: 200, labelAlign: 'right',
                        Comparison: "eq",
                        metaFilter: metaFilter,
                        plugins: ['clearbutton']
                    }];
            }
            filterItem.items = editor;
            if (numberOfFilter % 2) {
                self.items[0].items[0].items.push(filterItem);
            } else {
                self.items[0].items[1].items.push(filterItem);
            }

        });
        self.superclass.constructor.call(this);
        return this;
    }
})