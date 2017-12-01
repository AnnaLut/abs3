//RowNumberer.js нужно для того чтобы при добавлении новой строки в грид номер строки был '*' а не число
Ext.define("ExtApp.grid.RowNumberer", {
    override: "Ext.grid.RowNumberer",
    renderer: function (value, metaData, record, rowIdx, colIdx, store) {
        var rowspan = this.rowspan,
            page = store.currentPage,
            result = record.index;

        if (rowspan) {
            metaData.tdAttr = 'rowspan="' + rowspan + '"';
        }

        //ради этого собственно был написан этот оверрайд
        if (record.phantom) {
            return '*';
        }

        if (result == null) {
            result = rowIdx;
            if (page > 1) {
                result += (page - 1) * store.pageSize;
            }
        }
        return result + 1;
    }
});

//получение строки итогов, Ext.grid.feature.Summary не поддерживает свойство remoteRoot для формирования итогов на сервере
//Ext.grid.feature.GroupingSummary поддерживает, но он сильно комплексный и предназначен не для этого 
Ext.define('ExtApp.grid.feature.Summary', {
    override: 'Ext.grid.feature.Summary',
    getSummary: function (store, type, field, group) {

        var reader = store.proxy.reader;
        if (this.remoteRoot && reader.rawData) {
            // reset reader root and rebuild extractors to extract summaries data
            root = reader.root;
            reader.root = this.remoteRoot;
            reader.buildExtractors(true);
            summaryRow = reader.getRoot(reader.rawData);
            // restore initial reader configuration
            reader.root = root;
            reader.buildExtractors(true);
            if(summaryRow)
            if (typeof summaryRow[field] != 'undefined') {
                return summaryRow[field];
            }

            return '';
        }

        return this.callParent(arguments);
    }
});

Ext.define('ExtApp.view.BoundList', {
    override: 'Ext.view.BoundList',
    createPagingToolbar: function () {
        return Ext.widget('pagingtoolbar', {
            id: this.id + '-paging-toolbar',
            pageSize: this.pageSize,
            store: this.dataSource,
            border: false,
            ownerCt: this,
            ownerLayout: this.getComponentLayout(),
            //свойства выше были по дефолту, ниже - дополнительные
            beforePageText: 'Сторінка',
            afterPageText: '',
            displayMsg: 'Рядків на сторінці:'
        });
    }
});

Ext.override(Ext.tip.Tip, {
    minWidth: 250
});

Ext.override(Ext.view.Table, {
    onUpdate: function (g, c, m, r) {
        var v = this,
            o = v.rowTpl,
            j, s, b, l, n, t, u, e, p, q, k, d, w, h, a;
        if (v.viewReady) {
            b = v.getNodeByRecord(c, false);
            if (b) {
                p = v.overItemCls;
                q = v.overItemCls;
                k = v.focusedItemCls;
                d = v.beforeFocusedItemCls;
                w = v.selectedItemCls;
                h = v.beforeSelectedItemCls;
                j = v.indexInStore(c);
                s = Ext.fly(b, "_internal");
                l = v.createRowElement(c, j);
                if (s.hasCls(p)) {
                    Ext.fly(l).addCls(p)
                }
                if (s.hasCls(q)) {
                    Ext.fly(l).addCls(q)
                }
                if (s.hasCls(k)) {
                    Ext.fly(l).addCls(k)
                }
                if (s.hasCls(d)) {
                    Ext.fly(l).addCls(d)
                }
                if (s.hasCls(w)) {
                    Ext.fly(l).addCls(w)
                }
                if (s.hasCls(h)) {
                    Ext.fly(l).addCls(h)
                }
                a = v.ownerCt.columnManager.getColumns();
                if (Ext.isIE9m && b.mergeAttributes) {
                    b.mergeAttributes(l, true)
                } else {
                    n = l.attributes;
                    t = n.length;
                    for (e = 0; e < t; e++) {
                        u = n[e].name;
                        if (u !== "id") {
                            b.setAttribute(u, n[e].value)
                        }
                    }
                }
                if (a.length) {
                    v.updateColumns(c, v.getNode(b, true), v.getNode(l, true), a, r)
                }
                while (o) {
                    if (o.syncContent) {
                        if (o.syncContent(b, l) === false) {
                            break
                        }
                    }
                    o = o.nextTpl
                }
                v.fireEvent("itemupdate", c, j, b);
                if(m !== "edit")
                    v.refreshSize()
            }
        }
    }
});

Ext.override(Ext.dom.Element, {
    focus: function (defer, dom) {
        var me = this,
          scrollTop = undefined,
          body;
        dom = dom || me.dom;
        body = (dom.ownerDocument || DOC).body || DOC.body;
        try {
            if (Number(defer)) {
                Ext.defer(me.focus, defer, me, [null, dom]);
            } else {
                if (dom.offsetHeight > Ext.dom.Element.getViewHeight()) {
                    scrollTop = body.scrollTop;
                }

                if (dom.nodeName !== 'TR')
                    dom.focus();
                Ext.defer(function () {
                    if (dom.nodeName !== 'TR')
                        dom.focus();
                }, 50);

                if (scrollTop !== undefined) {
                    body.scrollTop = scrollTop;
                }
            }
        } catch (e) { }
        return me;
    }
});

Ext.define('MyApp.rtl.Table', {
    override: 'Ext.panel.Table'
    ,syncHorizontalScroll: function (d, b) {
        var c = this,
            a;
        b = b === true;
        if (c.rendered && (b || d !== c.scrollLeftPos)) {
            if (b) {
                a = c.getScrollTarget();
                a.el.dom.scrollLeft = d
            }
            var grid = Ext.getCmp('mainReferenceGrid');
            if (grid) {
                var scrollPosition = grid.el.down('.x-grid-view').getScroll();
                if (scrollPosition.left !== d) {
                    d = scrollPosition.left;
                }
            }
            c.headerCt.el.dom.scrollLeft = d;
            c.scrollLeftPos = d
        }
    }
});
Ext.define('Ext.ux.grid.Panel', {
    override: 'Ext.selection.CellModel',
    onViewRefresh: function (b) {
            var c = this,
                g = c.getCurrentPosition(),
                e = b.headerCt,
                a, d;
            if (g && g.view === b) {
                a = g.record;
                d = g.columnHeader;
                if (!d.isDescendantOf(e)) {
                    d = e.queryById(d.id) || e.down('[text="' + d.text + '"]') || e.down('[dataIndex="' + d.dataIndex + '"]')
                }                
                if (d && a && (b.store.indexOfId(a.getId()) !== -1)) {
                    c.setCurrentPosition({
                        row: a,
                        column: d,
                        view: b
                    })
                }
            }
        }
});