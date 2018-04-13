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
