Ext.define('ExtApp.controller.refBook.RefGrid', {
    extend: 'Ext.app.Controller',

    models: [
        'refBook.RefGrid'
    ],

    views: [
        //'refBook.RefGrid',
        //'refBook.RefGridFilterExt',
        //'refBook.RefCombobox',
        //'refBook.EditWindow',
        //'refBook.FormPanel'
    ],

    refs: [
        { ref: 'grid', selector: 'referenceGrid' },
        { ref: 'removeButton', selector: 'referenceGrid toolbar button#removeButton' },
        { ref: 'sampleButton', selector: 'referenceGrid toolbar button#sampleButton' },
        { ref: 'formViewButton', selector: 'referenceGrid toolbar button#formViewButton' },
        { ref: 'ViewInfo', selector: 'referenceGrid toolbar button#ViewInfo' },
        { ref: 'SaveAll', selector: 'referenceGrid toolbar button#SaveAll' }
    ],

    init: function (grid, cell, cellIndex, record, row, rowIndex, e) {
        this.control({
            "referenceGrid": {
                edit: this.onEdit,
                beforeedit: this.onBeforeEdit,
                validateedit: this.onValidateEdit,
                canceledit: this.onCancelEdit,
                selectionchange: this.onSelectionChange,
                cellclick: this.onCellclick,
                beforeitemdblclick: this.onbeforeitemdblclick,
                afterrender: this.onAfterrender//,
                // itemmouseenter: this.OnItemmouseenter
            },
            "GridCustomFilter": {
                checkchange: this.onCellclick,
                selectionchange: this.onSelectionFilterChange
            },
            'referenceGrid toolbar button#SaveAll':
            {
                click: this.syncAllCanges
            },
            'referenceGrid toolbar button#turn':
            {
                click: this.resetEdit
            },
            "referenceGrid toolbar button#addButton": {
                click: this.onAddBtnClick
            },
            "referenceGrid toolbar button#sampleButton": {
                click: this.onSampleBtnClick
            },
            "referenceGrid toolbar button#FormToInsertBtn": {
                click: this.onFormToInsertBtn
            },
            "referenceGrid toolbar button#ViewInfo": {
                click: this.onViewInfo
            },
            "referenceGrid toolbar button#removeButton": {
                click: this.onRemoveBtnClick
            },
            "referenceGrid toolbar button#saveColumnsButton": {
                click: this.onSaveColumnsButton
            },

            "referenceGrid toolbar button#cleareColumnsButton": {
                click: this.onCleareColumnsButton
            },
            "referenceGrid toolbar #excelButton menu": {
                click: this.onExportToExcelBtnClick
            },
            "referenceGrid toolbar button#formViewButton": {
                click: this.onFormViewBtnClick
            },
            "referenceGrid toolbar button#formFilterViewButton": {
                click: this.onFormFilterViewBtnClick
            },
            "referenceGrid toolbar #callFuncButton menu": {
                click: this.onCallFunctionMenuClick
            },
            "referenceGrid > panel > toolbar > button": {
                click: this.onToolBtnclick
            },
            "referenceGrid toolbar > toolbar > button": {
                click: this.onToolBtnclick
            },
            "referenceGrid pagingtoolbar button#clearFilterButton": {
                click: this.onClearFilterClick
            },
            //"referenceGrid pagingtoolbar button#applyFilterButton": {
            //    click: this.onapplyFilterButtonClick
            //},
            "GridCustomFilter toolbar button#removeFilterButton": {
                click: this.onremoveFilterButtonClick
            },
            "GridCustomFilter toolbar button#whereClauseButton": {
                click: this.onwhereClauseButtonClick
            },
            "GridCustomFilter toolbar button#updateFilterButton": {
                click: this.onEditFilterButtonClick
            },
            "GridCustomFilter toolbar button#revertCustomFilters": {
                click: this.SetFiltersByApplyFilters
            },

            "SystemFiltersGrid toolbar button#revertSystemFilters": {
                click: this.SetFiltersByApplyFilters
            },

            "referenceGrid gridcolumn": {
                show: this.onShowColumns,
                hide: this.onHideColumns
            },
            
            
            //"GridCustomFilter pagingtoolbar button#applyCustomFilter": {
            //    click: this.onapplyCustomFilter
            //},
            //"SystemFiltersGrid pagingtoolbar button#applySystemFilter": {
            //    click: this.onapplySystemFilter
            //},
            //для всех pagingtoolbar-ов на странице (основного грида и выпадающих списков)
            "pagingtoolbar": {
                afterlayout: this.onPagingToolbarAfterLayout
            },
            "#refEditWindow #okButton": {
                click: this.onEditWindowSaveClick
            },
            "#myEditWindow #okButton": {
                click: this.onEditFilterWindowSaveClick
            }
        });

    },

    onCellclick: function (grid, cell, cellIndex, record, row, rowIndex, e) {
        if (window.hasCallbackFunction && window.hasCallbackFunction.toUpperCase() == 'TRUE')
            return false;
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        referenceGrid.el.dom.focus();
        var href;
        // var IterIndex = referenceGrid.metadata.hasCheckBoxSelectColumn ? 1 : 0;
        
        referenceGrid.metadata.CurrentActionInform.lastClickRowInform = new Object();
        referenceGrid.metadata.CurrentActionInform.lastClickRowInform.dataRowArray = ExtApp.utils.RefBookUtils.buildRowToArray(record, referenceGrid.metadata.columnsInfo);
        referenceGrid.metadata.CurrentActionInform.lastClickRowInform.currentSelectedRecord = record;
        referenceGrid.metadata.CurrentActionInform.lastClickRowInform.rowNumber = referenceGrid.store.indexOf(record) + 1;
        var columns = grid.getGridColumns();
        var cellInform = columns[cellIndex];

        

        var col = cellInform.columnMetaInfo;
        var params = new Array();
        if (!col || !col.WEB_FORM_NAME || record.phantom)
            return;
        if (col.WEB_FORM_NAME.indexOf(":") > -1 && col.WEB_FORM_NAME.indexOf("/") > -1) {
            paramValues = ExtApp.utils.RefBookUtils.getUrlParameterValues(col.WEB_FORM_NAME);
            for (key in paramValues) {
                par = paramValues[key];
                par = par.replace(':', '');
                var ColParam = Ext.Array.findBy(referenceGrid.metadata.columnsInfo, function (item) {
                    return item.COLNAME == par;
                })
                if (record.data[par] !== undefined) {
                    var field = {};
                    field.Name = ColParam.COLNAME;
                    field.Type = ColParam.COLTYPE;
                    field.Value = record.data[ColParam.COLNAME];
                    params.push(field);
                }
            }

        }
        if (Ext.Array.findBy(params, function (param) { return param.Value === "" }))
            return false;
        href = col.WEB_FORM_NAME;

        if (href.indexOf("barsroot/ndi/referencebook") < 0) {
            if (href.indexOf(":") > -1) {
                var parName;
                var uriParams = ExtApp.utils.RefBookUtils.getUrlParameterValues(href);
                Ext.each(params, function (par) {
                    parName = ':' + par.Name;
                    for (var key in uriParams) {
                        var uriParamValue = uriParams[key];
                        if (parName == uriParamValue)
                            href = href.replace(parName, par.Value);
                    }
                })
            };
            if (href.indexOf('OpenInTab=1') > -1)
                window.open(href, '_blank');
            else
                // href = col.WEB_FORM_NAME;// + cell.innerText;
                Ext.create('ExtApp.view.refBook.RNKWindow', {
                    title: col.SEMANTIC + ":  " + cell.innerText,
                    items: [{
                        xtype: "component",
                        autoEl: {
                            tag: "iframe",
                            src: href,
                            modal: false
                        }
                    }]
                });

        }
        else {
            var parameters = [];
            if (col.ParamsNames && col.ParamsNames.length && col.ParamsNames.length > 0)

                Ext.each(col.ParamsNames, function (parName) {
                    var ColParam = Ext.Array.findBy(referenceGrid.metadata.columnsInfo,
                        function (item) {
                            return item.COLNAME == parName;
                        });
                    if (ColParam && record.data[parName] !== undefined) {
                        var field = {};
                        field.Name = ColParam.COLNAME;
                        field.Type = ColParam.COLTYPE;
                        field.Value = record.data[ColParam.COLNAME];
                        parameters.push(field);
                    }
                });
            var decodURI = decodeURIComponent(col.WEB_FORM_NAME);
            var paramsString = Ext.JSON.encode(parameters);

            // var bas64Params = Base64.encode(paramsString);
            var WEB_NAME = col.WEB_FORM_NAME + "&jsonSqlParams=" + paramsString;
            //
            if (col.IsFuncOnly && col.IsFuncOnly == true && col.FunctionMetaInfo) {
                var func = col.FunctionMetaInfo;
                func.jsonSqlProcParams = paramsString;
                func.dataRowArray = referenceGrid.metadata.CurrentActionInform.lastClickRowInform.dataRowArray;
                thisController.callSqlFunction(func);

                //thisController.callSqlFunction(func);
                //window.location = WEB_NAME;
            }
            else {
                this.openWindowByFunction(WEB_NAME);
                //var width = Ext.getBody().getViewSize().width * 1.02;
                //var height = Ext.getBody().getViewSize().height * 0.98;
                //var params = 'width=' + width + ',' + 'height=' + height + ',' + 'scrollbars=1' + ',' + 'left=5,top=10';
                //window.open(WEB_NAME, '_blank', params);
            }
            //Ext.create('ExtApp.view.refBook.InternelLinkWondow', {
            //    title: col.SEMANTIC + ":  " + cell.innerText,
            //    items: [{
            //        xtype: "component",
            //        autoEl: {
            //            tag: "iframe",
            //            src: WEB_NAME
            //        }
            //    }]
            //});
        }
    },

    openWindowForUploadOnly: function (tabid,funcId) {
        var url = '/barsroot/ndi/ReferenceBook/GetUploadFile?tabid=' + tabid + '&funcid=' + funcId;
        var width = 1000;
        var height = 600;
        var params = 'width=' + width + ',' + 'height=' + height + ',' + 'scrollbars=1' + ',' + 'left=205,top=125';
        window.open(url, '_blank', params);
    },
    onbeforeitemdblclick: function (record, item, index, e, eOpts) {
        if (window.hasCallbackFunction && window.hasCallbackFunction.toUpperCase() == 'TRUE')
            window.parent.CallFunctionFromMetaTable(item.data, true);

    },

    onHideColumns: function (col) {
        var thisController = this;
        var metadata = col.up('grid').metadata;
        if (metadata.saveColumnsParam == 'BY_DEFAULT')
            thisController.updateColumnsHidden();
    },

    onShowColumns: function (col) {
        var thisController = this;
        var metadata = col.up('grid').metadata;
        if (metadata.saveColumnsParam == 'BY_DEFAULT')
            thisController.updateColumnsHidden();
    },

    openRefWindow: function (href, formTitle) {
        Ext.create('ExtApp.view.refBook.RNKWindow', {
            title: formTitle,
            items: [{
                xtype: "component",
                autoEl: {
                    tag: "iframe",
                    src: href,
                    modal: false
                }
            }]
        });
    },

    //метод вызывается перед началом редактирования записи с помощью плагина RowEditing
    onBeforeEdit: function (rowEditing, e) {
        if (!rowEditing.editor || !rowEditing.editor.form)
            return;
        if (!e.record.phantom) {
            var thisController = this;
            var metadata = thisController.controllerMetadata;
            ExtApp.utils.RefBookUtils.onBeforeEditFormByDependencies(rowEditing.editor.form, e.record, metadata.nativeMetaColumns);
            return;
        }

        var hasColsToInsert = false
        var notEditCols = Ext.Array.filter(e.grid.metadata.columnsInfo, function (col) { return col.InputInNewRecord == 1; })
        if (notEditCols && notEditCols.length && notEditCols.length > 0)
            hasColsToInsert = true;
        //при редактировании запретить редактировать NOT_TO_EDIT колонки, а при добавлении разрешить
        if (!hasColsToInsert)
            Ext.each(e.grid.metadata.columnsInfo,
                function () {
                    var editorField = rowEditing.editor.form.findField(this.COLNAME);
                    if (!editorField)
                        return;
                    if (this.NOT_TO_EDIT == 1) {
                        //if (e.record.phantom) {
                        //    editorField.enable();
                        //} else {
                        //    editorField.disable();
                        //}
                        editorField.disable();
                    } else
                        editorField.enable();
                });
        else
            Ext.each(e.grid.metadata.columnsInfo,
                function () {
                    var editorField = rowEditing.editor.form.findField(this.COLNAME);
                    if (!editorField)
                        return;
                    if (this.InputInNewRecord == 0) {
                        //if (e.record.phantom) {
                        //    editorField.enable();
                        //} else {
                        //    editorField.disable();
                        //}
                        editorField.disable();
                    } else
                        editorField.enable();
                });
    },

    //вызывается при нажатии на кнопку "Зберегти" но до записи данных в строку на клиенте. 
    onValidateEdit: function (editor, e, eOpts) {
        //if (e.value != e.originalValue && editor.pluginId == 'cellEditPlugin')
        //    this.addChangedRow(e);
        //
    },

    //метод вызывается при нажатии на кнопку "Зберегти" в плагине RowEditing
    onEdit: function (editor, e) {
        var isPhantom = e.record.phantom;
        if (editor.pluginId == 'cellEditPlugin') {
            if (ExtApp.utils.RefBookUtils.isValueEquelToOriginal(e.value, e.originalValue))
                return;
            Ext.FinishedEdit = true;
            if (isPhantom)
                this.addAddedRow(e);
            else
                this.addChangedRow(e);
            return;
        }

        //для редактирования/добавления передаем новые и старые значения а также признаки phantom, dirty
        var values = e.record.data;
        var modified = e.record.modified;

        var isDirty = e.record.dirty;
        this.AddEditRecord(values, modified, isPhantom, isDirty);
    },

    //метод вызывается при нажатии на кнопку "Відмінити" в плагине RowEditing
    onCancelEdit: function (rowEditing, e) {
        //если отменили редактирование только что добавленной строки, то удаляем
        if (e.record.phantom) {
            e.grid.store.remove(e.record);
        }
    },

    onAddBtnClick: function (button, e) {
        
        //нашли грид и плагин rowEditing
        var grid = button.up('referenceGrid');
        //var rowEditing = grid.getPlugin('rowEditPlugin');
        var addEditInform = grid.metadata.AddEditRowsInform;
        var store = grid.getStore();
        //если есть добавленая пустая запись в начале грида - удаляем сначала её
        if (addEditInform.EditorMode != 'MULTI_EDIT') {
            var firstRow = store.getAt(0);
            if (firstRow && firstRow.phantom) {
                store.removeAt(0);
            }
        }
        var rowsToInsert = addEditInform.InsertRowAfter ? store.getCount() : 0;
        //добавили в store пустую запись
        
        var emptyModel = this.getModel('refBook.RefGrid');
        store.insert(rowsToInsert, emptyModel);
        ExtApp.utils.RefBookUtils.setInsertRecordByDefault(grid);
       
        //перешли на редактирование новой записи
        //rowEditing.startEdit(0, 0);
    },

    onSampleBtnClick: function (button, e) {
        
        //нашли грид и плагин rowEditing
        var grid = button.up('referenceGrid');
        //var rowEditing = grid.getPlugin('rowEditPlugin');
        var addEditInform = grid.metadata.AddEditRowsInform;
        var store = grid.getStore();
        //получаем выбранную строку грида
        var selectedRow = grid.getSelectionModel().getSelection()[0];

        //если есть добавленая пустая запись в начале грида - удаляем сначала её
        if (addEditInform.EditorMode != 'MULTI_EDIT') {
            if (store.getAt(0).phantom) {
                store.removeAt(0);
            }
        }
        var rowsToInsert = addEditInform.InsertRowAfter ? store.getCount() : 0;
        //добавили в store запись с такими же данными как у текущей выделенной строки
        store.insert(rowsToInsert, selectedRow.data); 
    
        //перешли на редактирование новой записи
        // rowEditing.startEdit(0, 0);
    },

    onRemoveBtnClick: function (button, e) {
        var thisController = this;
        var grid = button.up('referenceGrid');
        var selectedRows = grid.getSelectionModel().getSelection();
        if (!selectedRows || selectedRows.length < 1) {
            Ext.Msg.show({ title: "не обрано жодного рядка", msg: 'оберіть рядок для видалення' + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
            return;
        }
        if (grid.getPlugin('cellEditPlugin')) {
            thisController.removeAll(grid, grid.getPlugin('cellEditPlugin'), selectedRows);
            return;
        }
        Ext.MessageBox.confirm('Видалення рядка', 'Ви впевнені що хочете видалити рядок таблиці?', function (btn) {
            if (btn == 'yes') {
                //получаем выбранную строку грида
                var selectedRow = selectedRows[0];
                var editPlagin;

                editPlagin = grid.getPlugin('rowEditPlugin')
                //если нажали удалить при редактировании только что добавленной строки
                if (selectedRow.phantom) {
                    editPlagin.cancelEdit();
                    grid.store.remove(selectedRow);
                    return false;
                }
                var deletableRow = new Array();
                Ext.each(grid.metadata.columnsInfo, function () {
                    if (this.IsForeignColumn == false) {
                        var field = {};
                        field.Name = this.COLNAME;
                        field.Type = this.COLTYPE;
                        field.Value = selectedRow.data[this.COLNAME];
                        deletableRow.push(field);
                    }
                });
                Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' + '</br></br>', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
                thisController.sendToServer(
                    "/barsroot/ReferenceBook/DeleteData",
                    { jsonDeletableRow: Ext.JSON.encode(deletableRow), tableId: grid.metadata.tableInfo.TABID, tableName: grid.metadata.tableInfo.TABNAME, random: Math.random },
                    function (status, msg) {
                        //обработка при удачном запросе на сервер
                        Ext.MessageBox.hide();
                        Ext.MessageBox.show({ title: 'Видалення', msg: msg, buttons: Ext.MessageBox.OK });
                        if (status == "ok") {
                            //перечитка данных грида
                            thisController.getGrid().store.load();
                        }
                    });
            }
        });
    },

    onSaveColumnsButton: function (button, e) {
        var thisController = this;
        var grid = thisController.getGrid();
        var columnsHiddenNames = ExtApp.utils.RefBookUtils.getColumnsHiddenFromGrid(grid);
        ExtApp.utils.RefBookUtils.setHiddenColumnsToLocalSrorage(columnsHiddenNames, grid.metadata.localStorageModel);

    },

    onCleareColumnsButton: function (button, e) {
        var thisController = this;
        var grid = thisController.getGrid();
        ExtApp.utils.RefBookUtils.clearHiddenColumnsFromLocalSrorage(grid.metadata.localStorageModel);
        ExtApp.utils.RefBookUtils.showAllGridColumns(grid);
        thisController.updateColumnsHidden();
    },

    clearConstructorGrid: function (grid) {
        var ConstructorGrid = grid ? grid : Ext.getCmp('ConstructorGrid');
        try {
            var store = ConstructorGrid.getStore();
            store.removeAll();
        } catch (e) {
            if (e.number != '-2146823281')
                throw e;
        }
    },

    onSelectionChange: function (rowmodel, records) {
        // var filtert = records[0].data['IsApplyFilter'] = 1;
        //enabled кнопок "Додати за зразком", "Видалити", "Рядок вертикально" если выбрана строка
        //TODO: может слишком затратно

        var thisController = this;
        var referenceGrid = thisController.getGrid();
        var metadata = referenceGrid.metadata;
        var removeButton = this.getRemoveButton();
        if (removeButton && metadata.canDelete()) {
            removeButton.setDisabled(!records.length);
        }

        var sampleButton = this.getSampleButton();
        if (sampleButton && metadata.canInsert()) {
            sampleButton.setDisabled(!records.length);
        }
        var formViewButton = this.getFormViewButton();
        if (formViewButton && metadata.canUpdate())
            formViewButton.setDisabled(!records.length);
        var ViewInfo = this.getViewInfo();
        if (ViewInfo) {
            ViewInfo.setDisabled(!records.length);
        }

        referenceGrid.el.dom.focus();
        
    },

    onSelectionFilterChange: function (rowmodel, records) {

        // var filtert = records[0].data['IsApplyFilter'] = 1;
        //enabled кнопок "Додати за зразком", "Видалити", "Рядок вертикально" если выбрана строка
        //TODO: может слишком затратно
        var grid = rowmodel.views[0].panel;
        var removeButton = Ext.ComponentQuery.query('GridCustomFilter button#removeFilterButton')[0];
        var whereClauseButton = Ext.ComponentQuery.query('GridCustomFilter button#whereClauseButton')[0];
        var updateFilterButton = Ext.ComponentQuery.query('GridCustomFilter button#updateFilterButton')[0];
        updateFilterButton.setDisabled(false);
        removeButton.setDisabled(false);
        whereClauseButton.setDisabled(false);
        //var sampleButton = Ext.ComponentQuery.query('GridCustomFilter button#filterWhere')[0]; 
        //sampleButton.setDisabled(false);

        //var formViewButton = this.getFormViewButton();
        //formViewButton.setDisabled(false);
    },

    //нажатие на кнопку отмены всех фильтров
    onClearFilterClick: function (button, e) {

        var thisController = this;
        //var filterGrid = Ext.getCmp('DynamicFiltersGridId');
        //var CustonfilterGrid = Ext.getCmp('CustomFilterGrid');
        //var SystemFilterGrid = Ext.getCmp('SystemFiltersGridId');
        thisController.uncheckFilters();
        var ConstructorFilter = Ext.getCmp('ConstructorGrid');

        var inputFilterRow = Ext.dom.Query.select('.x-form-field');
        for (var i = 0; i < inputFilterRow.length; i++) {
            var inputClass = Ext.get(inputFilterRow[i]).dom.className.replace('  ', ' ');
            if (inputClass != 'x-form-field x-form-required-field x-form-text x-trigger-noedit') {
                inputFilterRow[i].value = '';
            }
        }

        var controllerMetadata = thisController.controllerMetadata;
        if (controllerMetadata.applyFilters.clause) {
            controllerMetadata.applyFilters.clause = "";
        }


        controllerMetadata.applyFilters = thisController.createApplyFilters();
        thisController.setFiltersToLocalStorage();


        //if (filterGrid && filterGrid.store.data.items && filterGrid.store.data.items.length > 0) {
        //    Ext.each(filterGrid.store.data.items, function (col) {
        //        col.data['IsApplyFilter'] = 0;
        //    });
        //    if (filterGrid.getView())
        //        try {
        //            filterGrid.getView().refresh();
        //        } catch (e) {
        //            if (e.number != '-2146823281')
        //                throw e;
        //        }
        //}

        //if (SystemFilterGrid && SystemFilterGrid.store.data.items && SystemFilterGrid.store.data.items.length > 0) {
        //    Ext.each(SystemFilterGrid.store.data.items, function (col) {
        //        col.data['IsApplyFilter'] = 0;
        //    });
        //    if (SystemFilterGrid.getView())
        //        try {
        //            SystemFilterGrid.getView().refresh();
        //        } catch (e) {
        //            if (e.number != '-2146823281')
        //                throw e;
        //        }
        //}

        //if (CustonfilterGrid && CustonfilterGrid.store.data.items && CustonfilterGrid.store.data.items.length > 0) {
        //    Ext.each(CustonfilterGrid.store.data.items, function (col) {
        //        col.data['IsApplyFilter'] = 0;
        //    });
        //    if (CustonfilterGrid.getView())
        //        try {
        //            CustonfilterGrid.getView().refresh();
        //        } catch (e) {
        //            if (e.number != '-2146823281')
        //                throw e;
        //        }
        //}
        var grid = this.getGrid();
        if (!grid)
            return false;
        var proxy = grid.store.getProxy();
        //очистка расширенного фильтра
        if (proxy.extraParams) {
            proxy.extraParams.externalFilter = [];
        }
        if (proxy.extraParams.startFilter) {
            proxy.extraParams.startFilter = [];
        }
        if (proxy.extraParams.dynamicFilter) {
            proxy.extraParams.dynamicFilter = [];
        }
        if (proxy.extraParams.clause) {
            proxy.extraParams.clause = "";
        }
        this.getGrid().filters.clearFilters();
        this.getGrid().store.reload();
    },

    onremoveFilterButtonClick: function (button, e) {
        var thisController = this;
        Ext.MessageBox.confirm('Видалення рядка', 'Ви впевнені що хочете видалити рядок таблиці?', function (btn) {
            if (btn == 'yes') {
                var grid = button.up('GridCustomFilter');
                //получаем выбранную строку грида
                var selectedRow = grid.getSelectionModel().getSelection()[0];

                //если нажали удалить при редактировании только что добавленной строки
                if (selectedRow.phantom) {
                    grid.getPlugin('rowEditPlugin').cancelEdit();
                    grid.store.remove(selectedRow);
                    return false;
                }
                var deletableRow = new Array();
                var field = {};
                field.Name = 'FILTER_ID';
                field.Value = selectedRow.data['FILTER_ID'];
                deletableRow.push(field);
                //Ext.each(grid.metadata.filtersMetainfo.FiltersMetaColumns, function () {
                //    if (this.COLNAME != 'IsApplyFilter') {
                //        var field = {};
                //        field.Name = this.COLNAME;
                //        field.Type = this.COLTYPE;
                //        field.Value = selectedRow.data[this.COLNAME];
                //        deletableRow.push(field);
                //    }
                //});
                Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' + '</br></br>', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
                thisController.sendToServer(
                    "/barsroot/ReferenceBook/DeleteData",
                    { jsonDeletableRow: Ext.JSON.encode(deletableRow), tableId: grid.metadata.filtersMetainfo.TABID, tableName: grid.metadata.filtersMetainfo.TABNAME, random: Math.random },
                    function (status, msg) {
                        //обработка при удачном запросе на сервер
                        Ext.MessageBox.hide();
                        Ext.MessageBox.show({ title: 'Видалення', msg: msg, buttons: Ext.MessageBox.OK });
                        if (status == "ok") {
                            //перечитка данных грида
                            grid.store.load();
                        }
                    });
            }
        });
    },

    onwhereClauseButtonClick: function (button, e) {
        var grid = button.up('grid');
        var selectedRow = grid.getSelectionModel().getSelection()[0];
        var Where_clause = selectedRow.data['WHERE_CLAUSE'];
        Ext.MessageBox.show({ title: 'умови фільтра', msg: Where_clause, buttons: Ext.MessageBox.OK });
    },

    //onapplyFilterButtonClick: function (button, e) {
    //
    //    var thisController = this;
    //    var referenceGrid = thisController.getGrid();
    //    var metadata = referenceGrid.metadata;
    //    //metadata.startFilter = [];
//
    //    // var formFields = [];
    //    //var CustomFilters = [];
    //    //если есть информация о начальных фильтрах
    //    if (metadata.filtersMetainfo.CustomFilters && metadata.filtersMetainfo.CustomFilters.length > 0
    //        || metadata.filtersMetainfo.SystemFilters && metadata.filtersMetainfo.SystemFilters.length > 0) {
    //        thisController.showBeforeFilterDialog(metadata, referenceGrid);
    //    } else {
    //        referenceGrid.store.reload();
    //    }
    //},

    onViewInfo: function (button) {
        this.onFormViewBtnClick(button);
    },

    onAfterrender: function (grid) {
        if (!grid.metadata || !grid.metadata.onlineFunctions || !grid.metadata.onlineFunctions.length || grid.metadata.onlineFunctions.length < 1)
            return;
        var thisController = this;
        var view = grid.getView();
        var metadata = grid.metadata;
        var onlineFuncOptions = grid.metadata.onlineFunctions[0];
        var tip = Ext.create('Ext.tip.ToolTip', {
            // The overall target element.
            target: view.el,
            // Each grid row causes its own separate show and hide.
            delegate: view.cellSelector,
            // Moving within the row should not hide the tip.
            //trackMouse: true,
            title: onlineFuncOptions.DESCR,
            autoHide: false,
            closable: true,
            draggable: true,
            anchorToTarget: true,
            minWidth: 200,
            minHeight: 60,
            config: {
                padding: 5
            },
            // Render immediately so that tip.body can be referenced prior to the first show.
            renderTo: Ext.getBody(),
            listeners: {
                // Change content dynamically depending on which element triggered the show.
                beforeshow: function updateTipBody(val, meta) {
                    var gridColums = view.getGridColumns();
                    var column = gridColums[tip.triggerElement.cellIndex];
                    if (!column.columnMetaInfo || !column.columnMetaInfo.COLNAME || column.columnMetaInfo.COLTYPE != 'N')
                        return false;
                    var selectModel = view.getSelectionModel();
                    if (!selectModel)
                        return false;
                    var selectedRows = selectModel.getSelection();
                    if (!selectedRows || !selectedRows.length || selectedRows.length < 1)
                        return false;
                    var sum = thisController.ExecAddFunc(view, column, selectedRows);
                    // var val = view.getRecord(tip.triggerElement.parentNode).get(column.dataIndex);
                    tip.update(sum);
                }
                //beforerender: function (val, meta, rec, rowIndex, colIndex, store) {

                //},
                //show: function (e) {

                //},
                //beforeactivate: function myfunction(e) {

                //}
            }
        });
    },

    uncheckFilterGrid: function (filterGrid) {

        if (filterGrid && filterGrid.store.data.items && filterGrid.store.data.items.length > 0) {
            Ext.each(filterGrid.store.data.items, function (col) {
                col.data['IsApplyFilter'] = 0;
            });
            if (filterGrid.getView())
                try {
                    filterGrid.getView().refresh();
                } catch (e) {
                    if (e.number != '-2146823281')
                        throw e;
                }
        }
    },
    uncheckFilters: function (grid) {
        var thisController = this;
        var filterGrid = Ext.getCmp('DynamicFiltersGridId');
        var CustomfilterGrid = Ext.getCmp('CustomFilterGrid');
        var SystemFilterGrid = Ext.getCmp('SystemFiltersGridId');

        thisController.uncheckFilterGrid(filterGrid);
        thisController.uncheckFilterGrid(CustomfilterGrid);
        thisController.uncheckFilterGrid(SystemFilterGrid);
    },
    removeAll: function (grid, plagin, rows) {
        var thisController = this;
        var editPlagin = plagin
        var selectedRows = rows;
        var rowsCount = selectedRows.length;
        var metadata = grid.metadata;
        var recordsForDelete = [];
        Ext.MessageBox.confirm('Видалення ' + rowsCount + ' рядків', 'Ви впевнені що хочете видалити ' + rowsCount + '  рядка таблиці?', function (btn) {
            if (btn == 'yes') {
                Ext.each(selectedRows, function (row) {
                    if (row.phantom) {
                        grid.store.remove(row);
                        return;
                    }
                    recordsForDelete.push(row);
                });
                //если нажали удалить при редактировании только что добавленной строки
                if (recordsForDelete.length < 1)
                    return;
                rowsForDelete = ExtApp.utils.RefBookUtils.getDeletingRows(recordsForDelete, metadata);
                //Ext.each(recordsForDelete, function (row) {

                //    var deletableRow = new Array();
                //    Ext.each(grid.metadata.columnsInfo, function () {
                //        if (this.IsForeignColumn == false) {
                //            var field = {};
                //            field.Name = this.COLNAME;
                //            field.Type = this.COLTYPE;
                //            field.Value = row.data[this.COLNAME];
                //            deletableRow.push(field);
                //        }
                //    });
                //    rowsForDelete.push(deletableRow);

                //})
                var DeleteRowsModel = new Object();
                DeleteRowsModel.RowsArray = Ext.JSON.encode(rowsForDelete);
                Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' + '</br></br>', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
                thisController.sendToServer(
                    "/barsroot/ReferenceBook/DeleteRows",
                    {
                        deletingRowsModel: DeleteRowsModel,
                        tableId: grid.metadata.tableInfo.TABID,
                        tableName: grid.metadata.tableInfo.TABNAME,
                        random: Math.random
                    },
                    function (status, msg) {
                        //обработка при удачном запросе на сервер
                        Ext.MessageBox.hide();
                        Ext.MessageBox.show({ title: 'Видалення', msg: msg, buttons: Ext.MessageBox.OK });
                        if (status == "ok") {
                            //перечитка данных грида
                            thisController.getGrid().store.load();
                        }
                    });
            }
        })


    },

    BeforeCellEditingHandler: function (e) {
        if (!e || e.record || !e.grid || !e.grid.metadata)
            return;
        Ext.each(e.grid.metadata.columnsInfo, function () {
            var editorField = rowEditing.editor.form.findField(this.COLNAME);
            if (!editorField)
                return;
            if (this.NOT_TO_EDIT == 1) {
                //if (e.record.phantom) {
                //    editorField.enable();
                //} else {
                //    editorField.disable();
                //}
                editorField.disable();
            }
            else
                editorField.enable();
        });
        var record = e.record;

    },

    ExecAddFunc: function (view, column, rows) {
        var sum = 0;
        Ext.each(rows, function (row) {
            sum += row.data[column.columnMetaInfo.COLNAME];
        })
        // var format = column.columnMetaInfo.SHOWFORMAT ? column.columnMetaInfo.SHOWFORMAT : '# ##0.00';
        //var sumRes = Ext.util.Format.number(sum, format);
        var res = '<font size="4">' + sum + '</font>';
        return res;
    },

    addUserFilerTab: function () {
        var thisController = this;
        var controllerMetadata = thisController.controllerMetadata;
        controllerMetadata.thisController = thisController;
        var tab = Ext.getCmp('tabFilterPanel');
        controllerMetadata.tabPanel = tab;
        controllerMetadata.tabPanel.add(
                   {
                       id: 'usertab',
                       title: 'Користувача',
                       items: Ext.create('ExtApp.view.refBook.RefGridCustomFilter', { thisController: thisController }),
                       minHeight: 100,
                       width: '100%',
                       maxHeight: 600
                   });
        controllerMetadata.tabPanel.setActiveTab(0);
        controllerMetadata.tabPanel.setActiveTab(1);
        if (controllerMetadata.tabPanel.items.length >= 3)
            controllerMetadata.tabPanel.setActiveTab(2);
        if (controllerMetadata.tabPanel.items.length >= 4)
            controllerMetadata.tabPanel.setActiveTab(3);

    },

    saveFilterBtnHandler: function (filterParam, saveInBd, items, whereClause) {
        var thisController = this;
        var clause = null;


        // var jsonParam = Ext.JSON.encode(param.Name);
        var params = items && items != '' && items.length ? items : new Array();
        if (whereClause && whereClause != '')
            clause = whereClause;
        Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
        var pars = Ext.JSON.encode(params);
        var insertModel = new Object();
        var url = filterParam.filterId && saveInBd
         ? "/barsroot/ReferenceBook/UpdateFilter"
         : "/barsroot/ReferenceBook/InsertFilter";
        if (filterParam.filterId) {
            insertModel.TableId = thisController.controllerMetadata.tableInfo.TABID;
            insertModel.TableName = thisController.controllerMetadata.tableInfo.TABNAME;
            insertModel.FilterRows = params;
            insertModel.FilterName = filterParam.value;
            insertModel.FilterId = filterParam.filterId;
        }
        else {
            insertModel.TableId = thisController.controllerMetadata.tableInfo.TABID;
            insertModel.TableName = thisController.controllerMetadata.tableInfo.TABNAME;
            insertModel.FilterRows = params;
            insertModel.FilterName = filterParam.value;
            insertModel.SaveFilter = saveInBd;
            insertModel.Clause = clause;
        }
        // var inserUpdatetModel =  Ext.JSON.encode(insertModel);
        thisController.sendToServer(
            url,
            { insertUpdateModel: Ext.JSON.encode(insertModel) },
              function (status, msg) {
                  var title;
                  if (saveInBd == 1)
                      title = 'збереження';
                  if (saveInBd == 0)
                      title = filterParam.value + '  додано до динамічних фильтрів';
                  //обработка при удачном запросе на сервер
                  Ext.MessageBox.hide();
                  Ext.MessageBox.show({ title: title, msg: msg + '</br> </br>', buttons: Ext.MessageBox.OK });
                  if (status == "ok") {
                      if (saveInBd == 1) {
                          var filterGrid = Ext.getCmp('CustomFilterGrid');
                          if (!filterGrid)
                              thisController.addUserFilerTab();
                          thisController.setFiltersToLocalStorage();
                          thisController.refreshAfterAddFilter();
                      }
                      if (saveInBd == 0) {
                          var filterGrid = Ext.getCmp('DynamicFiltersGridId');
                          thisController.uncheckFilterGrid(filterGrid);
                          var data = new thisController.DynFilter(true, msg, filterParam.value);
                          thisController.addDynamicFilterHandler(data, params);
                          thisController.setFiltersToLocalStorage();
                      }
                     
                     
                  }

                  //перечитка данных грида

              }

              );
    },

    refreshAfterAddFilter: function () {

        var thisController = this;
        var filterGrid = Ext.getCmp('CustomFilterGrid');
        if (filterGrid && filterGrid.store)
            filterGrid.store.reload();
        thisController.updateFiltersInfo();
    },

    updateFiltersInfo: function () {

        var thisController = this;
        Ext.Ajax.request({
            url: '/barsroot/ndi/ReferenceBook/GetFiltersMetaInfo',
            params: { tableId: thisController.controllerMetadata.tableInfo.TABID },
            success: function (conn, response) {
                //обработка при удачном запросе на сервер
                var result = Ext.JSON.decode(conn.responseText);
                if (result.success && result.filtersInfo) {
                    thisController.controllerMetadata.filtersMetainfo = result.filtersInfo;
                } else {
                    Ext.Msg.show({
                        title: "Не вдалося отримати інформацію з опису фільтрів для цієї таблиці (id=" +
                            thisController.controllerMetadata.tableInfo.TABID +
                            ")",
                        msg: result.errorMessage + '</br> </br>',
                        icon: Ext.Msg.ERROR,
                        buttons: Ext.Msg.OK
                    });
                    return false;
                }

            },
            failure: function (conn, response) {
                //обработка при неудачном запросе на сервер
                Ext.Msg.show({
                    title: "Виникли проблеми при з'єднанні з сервером",
                    msg: conn.responseText + '</br> </br>',
                    icon: Ext.Msg.ERROR,
                    buttons: Ext.Msg.OK
                });
            }

        });
    },

    syncAllCanges: function (btn) {
        var grid = btn.up('grid');
        var thisController = this;
        
        var addingModels = ExtApp.utils.RefBookUtils.getAddingRowsFromGrid(grid);
        if (thisController.controllerMetadata.AddEditRowsInform.EditingRowsDataArray.length === 0 && (!addingModels || addingModels.length < 1)) {
            Ext.MessageBox.show({ title: 'дані не змінено', msg: 'немає змінених даних', buttons: Ext.MessageBox.OK });
            return false;
        }
        grid.metadata.CurrentActionInform.actionName = 'syncAllCanges';
        var rawEditArray = thisController.controllerMetadata.AddEditRowsInform.EditingRowsDataArray;
        var EditRowsModel = new Object();
        var AddRowsModel = new Object();
        var EditRows = ExtApp.utils.RefBookUtils.buildEditModelsToSendServer(rawEditArray, grid.metadata.nativeMetaColumns);
        EditRowsModel.RowsArray = Ext.JSON.encode(EditRows);
        AddRowsModel.RowsToAddArray = Ext.JSON.encode(addingModels);
        Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' + '</br></br>', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
        thisController.sendToServer(
            "/barsroot/ReferenceBook/InsertUpdateRows",
            {
                AddingRowsModel: AddRowsModel,
                EditingRowsModel: EditRowsModel,
                tableId: thisController.controllerMetadata.tableInfo.TABID,
                tableName: thisController.controllerMetadata.tableInfo.TABNAME,
                random: Math.random
            },
            thisController.AddEditAfterRequest);
    },

    resetEdit: function (btn) {
        var grid = btn.up('grid');
        grid.store.rejectChanges();
        var metadata = grid.metadata;
        if (metadata.AddEditRowsInform)
            metadata.AddEditRowsInform.EditingRowsDataArray = new Array();

        //grid.getView().refresh();
        return;
        //btn.up('grid').editingPlugin = Ext.create('Ext.grid.plugin.CellEditing', {
        //    clicksToEdit: 1,
        //    pluginId: "cellEditPlugin",
        //    clicksToMoveEditor: 1,
        //    listeners: {
        //        beforeedit: function (editor, event, opts) {

        //            //Эта проверка  позволяет заблокировать редактирование в случае когда можно только добавлять tableMode = 3
        //            //if (!event.record.phantom) {
        //            //    return referenceGrid.metadata.canUpdate();
        //            //}
        //        }
        //    }
        //});
        //btn.up('grid').plugins = Ext.create('Ext.grid.plugin.CellEditing', {
        //    clicksToEdit: 1,
        //    pluginId: "cellEditPlugin",
        //    clicksToMoveEditor: 1,
        //    listeners: {
        //        beforeedit: function (editor, event, opts) {

        //            //Эта проверка  позволяет заблокировать редактирование в случае когда можно только добавлять tableMode = 3
        //            //if (!event.record.phantom) {
        //            //    return referenceGrid.metadata.canUpdate();
        //            //}
        //        }
        //    }
        //});
    },

    addChangedRow: function (e) {
        var thisController = this;
        var metadata = thisController.controllerMetadata;
        metadata.AddEditRowsInform = ExtApp.utils.RefBookUtils.updateOrAddRecordsForUpdate(metadata.AddEditRowsInform, e.record, metadata.columnsInfo);
        thisController.controllerMetadata = metadata;

    },

    addAddedRow: function (e) {
        //
        //var thisController = this;
        //var metadata = thisController.controllerMetadata;
        //metadata.AddedRowsInform = ExtApp.utils.RefBookUtils.updateOrAddRecordsForAdd(metadata.AddedRowsInform, e.record, metadata.columnsInfo);
        //thisController.controllerMetadata = metadata;
    },

    //убираем с пэйджинг тулбаров всё лишнее
    onPagingToolbarAfterLayout: function (toolbar, e) {
        //кнопка перехода к последней странице пэйджинга нам не нужна так как не используем count(*) 
        toolbar.down("#last").hide();
        //кнопка ввода текущей отображаемой страницы нам тоже не нужна
        toolbar.down('#inputItem').setDisabled(true);
    },

    //обработчик кнопки "Рядок вертикально"
    onFormViewBtnClick: function (button) {

        var thisController = this;
        var referenceGrid = thisController.getGrid();
        //получаем выбранную строку грида и загружаем в форму данные этой строки
        var selectedRow = referenceGrid.getSelectionModel().getSelection()[0];

        var formPanel = Ext.create('ExtApp.view.refBook.FormPanel', referenceGrid.editForm);
        formPanel.form.loadRecord(selectedRow);
        var winTitle = selectedRow.phantom ? "Додавання нового рядка" : "Редагування рядка";
        //создаем диалог редактирования формы, в который передаем заголовок и форму с данными
        Ext.create('ExtApp.view.refBook.EditWindow', {
            itemId: "refEditWindow",
            title: winTitle,
            items: formPanel /*, btnOkProps: { handler: thisController.onEditWindowSaveClick }*/
        });
    },

    uploadFile: function (e) {
        
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        //получаем выбранную строку грида и загружаем в форму данные этой строки
       // var selectedRow = referenceGrid.getSelectionModel().getSelection()[0];

        var formPanel = Ext.create('ExtApp.view.refBook.UploadForm');//  Ext.create('ExtApp.view.refBook.FormPanel', referenceGrid.editForm);
        // formPanel.form.loadRecord(selectedRow);
       // var winTitle = selectedRow.phantom ? "Додавання нового рядка" : "Редагування рядка";
        //создаем диалог редактирования формы, в который передаем заголовок и форму с данными
        Ext.create('ExtApp.view.refBook.refShowparamWindow', {
            itemId: "refEditWindow",
            title: 'winTitle',
            items: formPanel /*, btnOkProps: { handler: thisController.onEditWindowSaveClick }*/
        });
    },

    onFormFilterViewBtnClick: function (button) {
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        var metadata = referenceGrid.metadata;
        var refEditWindow = Ext.ComponentQuery.query('#startFilterWindow')[0];
        refEditWindow.removeAll();
        refEditWindow.items = Ext.create('ExtApp.view.refBook.RefGrid', { metadata: metadata });
    },
    //обработчик нажатия на кнопку "Зберегти" при редактировании данных справочника в форме
    onEditWindowSaveClick: function (button) {

        var thisController = this;
        var refEditWindow = button.up('window');
        var form = refEditWindow.down('form').getForm();
        var isDirty = form.isDirty();
        var isPhantom = form.getRecord().phantom;
        var record = form.getRecord();
        //если пользователь отредактировал данные или это новая строка на добавление
        if (isDirty || isPhantom) {
            //заполнить объекты с текущими значениями формы и значениями до редактирования изменившихся полей
            var values = {};
            var modified = {};
            var formFields = form.getFields();
            var referenceGrid = thisController.getGrid();
            //выбрать все колонки кроме колонок из других таблиц
            var metaColumns = Ext.Array.filter(referenceGrid.metadata.columnsInfo, function (col) { return col.IsForeignColumn == false; });
            formFields.each(function (field) {
                //текущие значения формы (метод getValue переопределен на возвращение 0/1 вместо true/false)
                var value = field.getValue();
                values[field.name] = value;
                //if (field.xtype == 'datefield') {
                //    if (value.getTime() != field.originalValue.getTime()) {
                //        modified[field.name] = field.originalValue;
                //    }
                //}
                //else
                //добавляем в объект свойство со значением до редактирования только если значение изменилось
                if (field.wasDirty)
                    modified[field.name] = field.originalValue;

            });
            Ext.each(metaColumns, function () {
                if (this.NOT_TO_SHOW == 1)
                    values[this.COLNAME] = record.data[this.COLNAME];
            });
            //передаем новые и старые значения, а также признаки phantom, dirty
            thisController.AddEditRecord(values, modified, isPhantom, isDirty);

        } else {
            refEditWindow.close();
        }
    },

    //форма для добавления строки. Заполняется из метаописания
    onFormToInsertBtn: function (button) {
        var thisController = this;
        var winTitle = "Додавання рядка";
        metadata = thisController.controllerMetadata;
        var colObjects = [];
        var columns = metadata.columnsInfo;
        Ext.each(columns, function (semantic) {
            colObjects.push({
                'fieldLabel': semantic['SEMANTIC'],
                'xtype': thisController.getFormFieldType(semantic['COLTYPE'])
            });
        });
        Ext.create('ExtApp.view.refBook.EditWindow', {
            itemId: "refEditWindow",
            items: Ext.create('ExtApp.view.refBook.FormPanel', { items: colObjects }),
            title: winTitle
        });
    },

    onEditFilterWindowSaveClick: function (button) {
        var thisController = this;
        var refEditWindow = button.up('window');
        var form = refEditWindow.down('form');
        var isDirty = form.isDirty();
        var isPhantom = form.getRecord().phantom;
        //если пользователь отредактировал данные или это новая строка на добавление
        if (isDirty || isPhantom) {
            //заполнить объекты с текущими значениями формы и значениями до редактирования изменившихся полей
            var values = {};
            var modified = {};
            form.getFields().each(function (field) {
                //текущие значения формы (метод getValue переопределен на возвращение 0/1 вместо true/false)
                var value = field.getValue();
                values[field.name] = value;
                //добавляем в объект свойство со значением до редактирования только если значение изменилось
                if (value != field.originalValue) {
                    modified[field.name] = field.originalValue;
                }
            });

            //передаем новые и старые значения, а также признаки phantom, dirty
            thisController.AddEditRecord(values, modified, isPhantom, isDirty);

        } else {
            refEditWindow.close();
        }
    },
    //menu - кнопка с выпадающим меню
    //item - конкретный пункт меню который нажали
    onCallFunctionMenuClick: function (menu, item) {
        
        var thisController = this;
        //каждый пункт меню содержит свойство metaInfo с информацией о вызываемой процедуре
        var funcMetaInfo = item.metaInfo;
        //thisController.fillCallFuncInfo(funcMetaInfo);
        //var func = thisController.currentCalledSqlFunction;
        //if (!funcMetaInfo.isFuncOnly || (funcMetaInfo.WEB_FORM_NAME && funcMetaInfo.WEB_FORM_NAME.indexOf('/') > 0 && funcMetaInfo.WEB_FORM_NAME.indexOf('/ndi/') < 0)) {
        //    window.open(funcMetaInfo.WEB_FORM_NAME, '_blank');
        //    return;
        //}
         if(funcMetaInfo.MultiRowsParams != null &&funcMetaInfo.MultiRowsParams.length > 0 && funcMetaInfo.MultiRowsParams[0].Kind =='FROM_UPLOAD_EXCEL')
         {
             thisController.openWindowForUploadOnly(funcMetaInfo.TABID,funcMetaInfo.FUNCID);
              return;
         }

        var titleMsg = 'Виконання процедури' + funcMetaInfo.DESCR;
        //если заполнен вопрос который нужно задать перед выполнением процедуры
        if (funcMetaInfo.QST && !Ext.Array.contains(['SELECTED_ONE', 'EACH', 'BATCH'], funcMetaInfo.PROC_EXEC)) {
            Ext.MessageBox.confirm(titleMsg, funcMetaInfo.QST, function (btn) {
                if (btn == 'yes') {
                    thisController.callSqlFunction(funcMetaInfo);
                }
            });
        } else {
            thisController.callSqlFunction(funcMetaInfo);
        }
    },

    onToolBtnclick: function (button) {
        
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        //каждый пункт меню содержит свойство metaInfo с информацией о вызываемой процедуре
        var funcMetaInfo = button.metaInfo;
        var titleMsg = 'Виконання процедури' + funcMetaInfo.DESCR;
        //если заполнен вопрос который нужно задать перед выполнением процедуры
        if (funcMetaInfo.QST && !Ext.Array.contains(['SELECTED_ONE', 'EACH', 'BATCH'], funcMetaInfo.PROC_EXEC)) {
            Ext.MessageBox.confirm(titleMsg, funcMetaInfo.QST, function (btn) {
                if (btn == 'yes') {
                    thisController.callSqlFunction(funcMetaInfo);
                }
            });
        } else {
            thisController.callSqlFunction(funcMetaInfo);
        }
    },

    OnItemmouseenter: function (record, item, index, e, eOpts) {

    },

    ////////////////////////////////////////////вспомогательные функции (не обработчики событий)


    //onapplyCustomFilter: function (button, e) {

    //    controllerMetadata.applyFilters.CustomBeforeFilters = [];
    //    controllerMetadata.startFilter = [];
    //    var mainGrid = controllerMetadata.mainGrid;
    //    var referenceGrid = button.up('grid');
    //    referenceGrid.getStore().each(function (record) {
    //        if (record.data['IsApplyFilter'] == 1)
    //            controllerMetadata.applyFilters.CustomBeforeFilters.push({
    //                //к имени поля добавляем имя таблицы
    //                FILTER_ID: record.data['FILTER_ID']
    //            });
    //    });
    //    if (mainGrid && controllerMetadata.applyFilters.CustomBeforeFilters.length > 0) {
    //        Ext.each(controllerMetadata.applyFilters.CustomBeforeFilters, function (filter) {
    //            controllerMetadata.startFilter.push(filter);
    //        });
    //        controllerMetadata.startFilter = Ext.encode(controllerMetadata.startFilter);
    //        mainGrid.store.getProxy().extraParams.startFilter = controllerMetadata.startFilter;
    //        mainGrid.store.reload();
    //    }
    //},

    SetFiltersByApplyFilters: function (btn, e) {
        
        var thisController = this;
        var thisGrid = btn.up('grid');
        if (!thisGrid || !thisGrid.metadata.saveFilterLocal)
            return false;
        var filters;
        switch (thisGrid.id) {
            case 'CustomFilterGrid':
                filters = thisController.controllerMetadata.applyFilters.CustomBeforeFilters;
                break;
            case 'SystemFiltersGridId':
                filters = thisController.controllerMetadata.applyFilters.SystemBeforeFilters;
                break;
            default:
                return false;

        }

        if (!filters || !filters.length > 0)
            return false;

        var store = thisGrid.getStore();
        var gridFilters = filters;
        if (gridFilters && gridFilters.length) {
            store.each(function (record) {

                Ext.Array.filter(gridFilters,
                    function (filter) {
                        if (record.data['FILTER_ID'] == filter.FILTER_ID)
                            record.set('IsApplyFilter', 1);
                    });

            });
        }
        btn.setDisabled(true);
        thisController.updateApplyFilters(thisGrid);
    },

    updateApplyFilters: function (grid) {

        var thisController = this;
        var filterGridId = grid.id;

        switch (filterGridId) {
            case 'CustomFilterGrid':
                thisController.controllerMetadata.applyFilters.CustomBeforeFilters = thisController.getApplyFiltersByGrid(grid);
                break;

            case 'SystemFiltersGridId':
                thisController.controllerMetadata.applyFilters.SystemBeforeFilters = thisController.getApplyFiltersByGrid(grid);
                break;

            case 'DynamicFiltersGridId':
                thisController.controllerMetadata.applyFilters.DynamicBeforeFilters = thisController.getDynamicFiltersByGrid(grid);
                break;
            default:
                Ext.MessageBox.show({ title: 'filter apply exception', msg: 'unknown type of filter:  ' + filterType, buttons: Ext.MessageBox.OK });
                break;
        }

        thisController.setFiltersToLocalStorage();
        thisController.setDisableCleareFiltersBtn();
        thisController.controllerMetadata.mainGrid = Ext.getCmp('mainReferenceGrid');
        if (thisController.controllerMetadata.mainGrid)
            thisController.updateGridByFilters();

    },

    updateApplyFiltersByFilterGrids: function()
    {
        
        var thisController = this;
        var CustomfilterGrid = Ext.getCmp('CustomFilterGrid');
        if (CustomfilterGrid && CustomfilterGrid.items.length > 0)
            thisController.updateApplyFilters(CustomfilterGrid);
        var SystemFilterGrid = Ext.getCmp('SystemFiltersGridId');
        if (SystemFilterGrid && SystemFilterGrid.items.length > 0)
            thisController.updateApplyFilters(SystemFilterGrid);
    },

    getDynamicFiltersByGrid: function (grid) {
        var beforeFilters = [];
        grid.getStore().each(function (record) {
            if (record.data['IsApplyFilter'] == 1)
                beforeFilters.push({
                    //к имени поля добавляем имя таблицы
                    IsApplyFilter: true,
                    FilterName: record.data['FilterName'],
                    Where_clause: record.data['Where_clause']
                });
        });

        if (beforeFilters.length) {
            var cleareFilterBtn = Ext.getCmp('clareFilersInDialogId');
            if (cleareFilterBtn)
                cleareFilterBtn.setDisabled(false);
        }
        return beforeFilters;
    },

    getApplyFiltersByGrid: function (grid) {

        var beforeFilters = [];
        grid.getStore().each(function (record) {
            if (record.data['IsApplyFilter'] == 1)
                beforeFilters.push({
                    //к имени поля добавляем имя таблицы
                    FILTER_ID: record.data['FILTER_ID'],
                    Where_clause: record.data['WHERE_CLAUSE']
                });
        });
        if (beforeFilters.length) {
            var cleareFilterBtn = Ext.getCmp('clareFilersInDialogId');
            if (cleareFilterBtn)
                cleareFilterBtn.setDisabled(false);
        }
        return beforeFilters;
    },

    setDisableCleareFiltersBtn: function () {

        var thisController = this;
        var applyFilters = thisController.controllerMetadata.applyFilters;
        var cleareFilterBtn = Ext.ComponentQuery.query("#clareFilersInDialogId")[0];// Ext.getCmp('clareFilersInDialogId');
        if (cleareFilterBtn && applyFilters) {
            if (applyFilters.CustomBeforeFilters && applyFilters.CustomBeforeFilters.length ||
                applyFilters.SystemBeforeFilters && applyFilters.SystemBeforeFilters.length ||
                applyFilters.ConstructorStructure && applyFilters.ConstructorStructure.length)
                cleareFilterBtn.setDisabled(false);
            else
                cleareFilterBtn.setDisabled(true);
        }

    },

    updateGridByFilters: function () {

        var thisController = this;
        var controllerMetadata = thisController.controllerMetadata;
        controllerMetadata.startFilter = [];
        if (controllerMetadata.applyFilters.CustomBeforeFilters && controllerMetadata.applyFilters.CustomBeforeFilters.length > 0)
            Ext.each(controllerMetadata.applyFilters.CustomBeforeFilters, function (filter) {
                controllerMetadata.startFilter.push(filter);
            });
        if (controllerMetadata.applyFilters.SystemBeforeFilters && controllerMetadata.applyFilters.SystemBeforeFilters.length > 0)
            Ext.each(controllerMetadata.applyFilters.SystemBeforeFilters, function (filter) {
                controllerMetadata.startFilter.push(filter);
            });
        controllerMetadata.startFilter = Ext.encode(controllerMetadata.startFilter);
        controllerMetadata.dynamicFilter = Ext.encode(thisController.controllerMetadata.applyFilters.DynamicBeforeFilters);
        controllerMetadata.mainGrid = Ext.getCmp('mainReferenceGrid');
        if (controllerMetadata.mainGrid) {
            controllerMetadata.mainGrid.store.getProxy().extraParams.startFilter = controllerMetadata.startFilter;
            controllerMetadata.mainGrid.store.getProxy().extraParams.dynamicFilter = controllerMetadata.dynamicFilter;
            controllerMetadata.mainGrid.store.getProxy().extraParams.isResetPages = true;
            controllerMetadata.mainGrid.store.reload();
        }
        else {
            controllerMetadata.mainGrid = Ext.create('ExtApp.view.refBook.RefGrid', { metadata: controllerMetadata });

        }
        this.controllerMetadata = controllerMetadata;
    },

    onapplySystemFilter: function (button, e) {
        controllerMetadata.applyFilters.SystemBeforeFilters = [];
        var thisController = this;
        var referenceGrid = button.up('grid');
        referenceGrid.getStore().each(function (record) {
            if (record.data['IsApplyFilter'] == 1)
                controllerMetadata.applyFilters.SystemBeforeFilters.push({
                    //к имени поля добавляем имя таблицы
                    FILTER_ID: record.data['FILTER_ID']
                });
        });
    },

    onEditFilterButtonClick: function (button, e) {
        
        var thisController = this;
        var referenceGrid = button.up('grid');
        var selectedRows = referenceGrid.getSelectionModel().getSelection();
        if (!selectedRows || selectedRows.Count < 1)
            Ext.MessageBox.show({ title: 'не обрано жодного рядка', msg: 'не обрано жодного рядка', buttons: Ext.MessageBox.OK });
        var selectedRow = selectedRows[0];
        var filters = Ext.Array.filter(thisController.controllerMetadata.filtersMetainfo.CustomFilters,
            function (filter) { return filter.FILTER_ID === selectedRow.data['FILTER_ID'] });
        var filter = filters[0];
        if (!filter.FilterRows) {
            Ext.MessageBox.show({
                title: 'не збережена структура фільтра', msg: '<br> для подальшого редагування створіть фільтр заново',
                buttons: Ext.MessageBox.OK
            });
            return false;
        }

        var rows = ExtApp.utils.RefBookUtils
            .buildRowToModelByFieldNames(ExtApp.utils.RefBookUtils.createGridModel, filter.FilterRows);

        var controllerGrid = Ext.getCmp('ConstructorGrid');
        var filterModel = controllerGrid.additionalProperties.filterModel;
        filterModel.rows = rows;
        filterModel.filterId = filter.FILTER_ID;
        filterModel.filterName = filter.SEMANTIC;

        thisController.updateFilter(filterModel);
    },

    controllerMetadata: function () {
        startFilter = [];
    },

    createApplyFilters: function () {
        var applyFilters = {};
        applyFilters.CustomBeforeFilters = [];
        applyFilters.SystemBeforeFilters = [];
        applyFilters.DynamicBeforeFilters = [];
        applyFilters.ConstructorStructure = [];
        applyFilters.hasAplyFilters = false;
        return applyFilters;
    },

    DynFilter: function (isApply, clause, name) {
        this.IsApplyFilter = isApply;
        this.FilterName = name;
        this.Where_clause = clause;
    },

    ConstuctorRow: function (colname, isNull, logicalOp, reletionalOp, value) {
        this.Colname = colname;
        this.IsNull = isNull;
        this.LogicalOp = logicalOp;
        this.ReletionalOp = reletionalOp;
        this.Value = value;
    },

    showBeforeFilterDialog: function (metadata, referenceGrid) {
        
        var thisController = this;
        metadata = thisController.setAccessLevel(metadata);
        thisController.controllerMetadata = metadata;
        thisController.controllerMetadata.startFilter = [];
        var myLocalStore = Ext.state.LocalStorageProvider.create();
        var keyFilterLosSrorage = metadata.localStorageModel.FiltersStorageKey;
        var applyFilters;
        if (metadata.saveFilterLocal && metadata.saveFilterLocal.toLowerCase() == 'true')
            applyFilters = myLocalStore.get(keyFilterLosSrorage);
        if (applyFilters != undefined) {
            
            thisController.controllerMetadata.applyFilters = applyFilters;
            if (
                //applyFilters.CustomBeforeFilters && applyFilters.CustomBeforeFilters.length ||
                //applyFilters.SystemBeforeFilters && applyFilters.SystemBeforeFilters.length ||
                //applyFilters.DynamicBeforeFilters &&  applyFilters.DynamicBeforeFilters.length ||
                applyFilters.ConstructorStructure && applyFilters.ConstructorStructure.length)
                thisController.controllerMetadata.applyFilters.hasAplyFilters = true;
            else
                thisController.controllerMetadata.applyFilters.hasAplyFilters = false;
            thisController.controllerMetadata.applyFilters.DynamicBeforeFilters = [];
        }
        else
            thisController.controllerMetadata.applyFilters = thisController.createApplyFilters();


        thisController.controllerMetadata.AddEditRowsInform = metadata.addEditRowsInform;
        thisController.controllerMetadata.AddEditRowsInform.EditingRowsDataArray = new Array();
        thisController.controllerMetadata.AddEditRowsInform.AddingRowsDataArray = new Array();
        thisController.controllerMetadata.AddEditRowsInform.keyNames = [];
        thisController.controllerMetadata.CurrentActionInform = new Object();
        //var sympleFilterColumnsInfo = metadata.columnsInfo

        var controllerMetadata = thisController.controllerMetadata;
        controllerMetadata.thisController = thisController;
        window.StringColumnModel = controllerMetadata.filtersMetainfo.StringColumnModel;

        var hasCustomFilter = controllerMetadata.filtersMetainfo.CustomFilters && controllerMetadata.filtersMetainfo.CustomFilters.length > 0;
        var hasSystemFilter = controllerMetadata.filtersMetainfo.SystemFilters && controllerMetadata.filtersMetainfo.SystemFilters.length > 0;
        var hasGridColors = controllerMetadata.colorsForGrid && controllerMetadata.colorsForGrid.length && controllerMetadata.colorsForGrid.length > 0;
        ////если есть информация о начальных фильтрах
        controllerMetadata.SympleFilters = ExtApp.utils.RefBookUtils.configFieldsForeSympleFilters(controllerMetadata.filtersMetainfo.FilterColumns);
        
        if (controllerMetadata.filtersMetainfo.ShowFilterWindow != 'false' || hasCustomFilter || hasSystemFilter) {
            //if (controllerMetadata.filtersMetainfo.CustomFilters && controllerMetadata.filtersMetainfo.CustomFilters.length > 0
            //    || controllerMetadata.filtersMetainfo.SystemFilters && controllerMetadata.filtersMetainfo.SystemFilters.length > 0) {
            //Ext.each(metadata.CustomFilters, function (filter) {
            //    ;
            //    CustomFilters.push(filter);
            //    var formField = ExtApp.utils.RefBookUtils.configCustomFilters(filter);
            //    formFields.push(formField);
            //})
            // thisApp.setAccessLevel(metadata);
            var tab = Ext.create('Ext.tab.Panel', {
                width: '100%',
                minHeight: 200,
                maxHeight: 600,
                id: 'filterWindowTabPanel',
                renderTo: Ext.getBody(),
                items: [

                ]
            });

            if (hasSystemFilter) {
                tab.add({
                    title: 'Системні',
                    items: Ext.create('ExtApp.view.refBook.SystemFiltersGrid', { thisController: thisController }),
                    minHeight: 100,
                    width: '100%',
                    maxHeight: 600
                });
            }

            //if (controllerMetadata.filtersMetainfo.CustomFilters && controllerMetadata.filtersMetainfo.CustomFilters.length > 0)
            tab.add(
               {
                   title: 'Користувача',
                   items: Ext.create('ExtApp.view.refBook.RefGridCustomFilter', { thisController: thisController }),
                   minHeight: 100,
                   width: '100%',
                   maxHeight: 600
               });
            tab.add(
                   {
                       id: 'dynamicFilterTab',
                       title: 'Динамічні фільтри',
                       items: Ext.create('ExtApp.view.refBook.DynamicFiltersGrid', { thisController: thisController }),
                       minHeight: 100,
                       width: '100%',
                       maxHeight: 600
                   });
            tab.add(
            {
                title: 'Конструктор фільтрів',
                id: 'ConstructorTabId',
                items: Ext.create('ExtApp.view.refBook.ConstructorFiltersGrid', { thisController: thisController }),
                minHeight: 100,
                width: '100%',
                maxHeight: 600
            });
            tab.add(
            {
                title: 'Звичайні',
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
                maxHeight: 600
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
            //показываем диалог
            var wind = Ext.create('ExtApp.view.refBook.FilterWindow',
            {
                minWidth: 800,
                minHeight: 450,
                maxWidth: 1000,
                maxHeight: 800,
                title: "Фільтр перед населенням таблиці",
                items: tab,
                controllerMetadata: controllerMetadata,
                // Ext.create('ExtApp.view.refBook.RefGridCustomFilter', { metadata: metadata }), //Ext.create('ExtApp.view.refBook.FormPanel', {
                //    fieldDefaults: { labelWidth: 700 }, items: formFields
                //}),
                btnOkProps: {
                    handler: function (btn) {
                        thisController.filterDialogOkBtnHandler(btn);
                    }
                }

            });
            
            for (var i = 0; i < tab.items.length; i++) {
                tab.setActiveTab(i);
            }
            wind.setSize(500, 400);
            tab.setActiveTab('ConstructorTabId');
            // if (applyFilters && applyFilters.DynamicBeforeFilters.length > 0)
            thisController.insertDefaultFiltersValues();
            controllerMetadata.tabPanel = tab;
        } else {
            Ext.create('ExtApp.view.refBook.RefGrid', { metadata: controllerMetadata });
        }
        thisController.insertClorsSemantic();
    },

    filterDialogOkBtnHandler: function (btn) {
        var thisController = this;
        var myWindow = btn.up('window');
        var revertCustomFiltersBtn = myWindow.down('#revertCustomFilters');
        if (revertCustomFiltersBtn)
            revertCustomFiltersBtn.setDisabled(true);
        var revertSystemFiltersBtn = myWindow.down('#revertSystemFilters');
        if (revertSystemFiltersBtn)
            revertSystemFiltersBtn.setDisabled(true);

        
        var constructor = Ext.getCmp('ConstructorGrid');
        var store = constructor.getStore();
        var items = store.data.items;
        var params = new Array();
        var sympleFilterRows;
        Ext.each(items,
            function (item) {

                var isRowEmpty = ExtApp.utils.RefBookUtils.isObjEmpty(item.data);
                if (isRowEmpty)
                    return;
                var param = {};
                param.LogicalOp = item.data['LogicalOp'];
                param.Colname = item.data['Colname'];
                param.ReletionalOp = item.data['ReletionalOp'];
                param.Value = item.data['Value'];
                //param.Semantic = item.data['Semantic'];
                params.push(param);
            });
        var filterName = 'Складний фільтр1';
        //
        var form = myWindow.down('form').getForm();
        var fields = form.getFields();
        var isDirty = form.isDirty();
        if (isDirty) {
            sympleFilterRows = ExtApp.utils.RefBookUtils.buildSympleFilterFromForm(form);
        }
        if (sympleFilterRows && sympleFilterRows.length && sympleFilterRows.length > 0) {
            if (params.length > 0) {
                Ext.Msg.show({
                    title: "застосування фільтрів",
                    msg: "ви ввели дані для простого і складного фільтра! </br>   оберіть будь ласка один.", icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK
                });
                return;
            }

            params = sympleFilterRows;
            filterName = 'простий фльтр1';
        }

        var Model = {
            TableId: thisController.controllerMetadata.tableInfo.TABID,
            TableName: thisController.controllerMetadata.tableInfo.TABNAME,
            FilterName: filterName,
            FilterRows: params,
            SaveFilter: 0
        }
        thisController.updateApplyFiltersByFilterGrids();
        Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' + '</br></br>', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
        //var pars = Ext.JSON.encode(params);

        if (params.length > 0)
            thisController.sendToServer(
                "/barsroot/ReferenceBook/InsertFilter",
                {
                    insertUpdateModel: Ext.JSON.encode(Model)
                },
                  function (status, msg, controller) {
                      //обработка при удачном запросе на сервер

                      if (status == 'ok') {
                          //перечитка данных грида
                          var clause = msg;
                          thisController.controllerMetadata.applyFilters.clause = clause;

                          if (clause) {
                              var dynFilter = new thisController.DynFilter(true, clause, filterName);
                              thisController.addDynamicFilterHandler(dynFilter, params, true);
                          }
                          thisController.setFiltersToLocalStorage();
                         
                          if (window.getFiltersOnly && window.getFiltersOnly.toUpperCase() == 'TRUE' && window.parent.CallFunctionFromMetaTable) {
                              thisController.returnFiltersForExtApp();
                              return false;
                          }


                          Ext.MessageBox.hide();
                          myWindow.close();
                          // controllerMetadata.tabPanel = tab;
                          thisController.updateGridByFilters();
                      }
                      else {
                          Ext.Msg.show({ title: "Помилка при формуванні фільтра", msg: msg + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                          return false;
                      }

                  });
        else {

            thisController.controllerMetadata.applyFilters.ConstructorStructure = [];
            thisController.controllerMetadata.applyFilters.clause = "";
            thisController.setFiltersToLocalStorage();
            if (window.getFiltersOnly && window.getFiltersOnly.toUpperCase() == 'TRUE' && window.parent.CallFunctionFromMetaTable) {
                thisController.returnFiltersForExtApp();
                return;
            }
            Ext.MessageBox.hide();
            myWindow.close();
            //controllerMetadata.tabPanel = tab;
            thisController.updateGridByFilters();
        }


    },

    updateFilter: function (filterModel) {

        var thisController = this;
        thisController.controllerMetadata.tabPanel.setActiveTab('ConstructorTabId');
        var constructor = Ext.getCmp('ConstructorGrid');
        var store = constructor.getStore();
        constructor.additionalProperties.filterModel.isEditingFilter = true;
        constructor.setTitle('редагування фільтра id: ' +
            filterModel.filterId +
            '    назва: ' +
            filterModel.filterName);
        var cancelBtn = constructor.down('button#cancelEditFilterId');
        if (cancelBtn)
            cancelBtn.show();
        var count = 0;
        store.removeAll();
        store.sync();
        Ext.each(filterModel.rows,
            function (row) {
                var model = ExtApp.utils.RefBookUtils.createGridModel('rowFilterModel');
                model.data['LogicalOp'] = row.data.LogicalOp;
                model.data['Colname'] = row.data.Colname;
                model.data['ReletionalOp'] = row.data.ReletionalOp;
                model.data['Value'] = row.data.Value;
                store.insert(count, model.data);
                count++;
            });


        //model.setFields({ LogicalOp : 'sdfdsfs' });

        store.sync();

    },

    writeFilter: function (saveInBd, items, whereClause, filterModel) {
        // Create a model instance

        var thisController = this;
        var parArray = new Array();
        var parInput = {
            fieldLabel: 'Назва фільтра',
            name: 'filterName',
            xtype: 'textfield',
            inputType: "text",
            value: filterModel && filterModel.filterName ? filterModel.filterName : ''
        };
        parArray.push(parInput);
        var wind = Ext.create('ExtApp.view.refBook.NameWindow', {
            itemId: "CreateFilterWindow",
            title: 'Введіть назву фільтра',
            items: Ext.create('ExtApp.view.refBook.FormPanel', { items: parArray }),
            width: 550,
            height: 200,
            btnOkProps: {
                handler: function (btn) {
                    var formWindow = btn.up('window');
                    var form = formWindow.down('form').getForm();
                    var param = {
                        //filterId: filterModel.filterId,
                        Name: 'filterName',
                        value: form.findField('filterName').getValue()
                    }
                    if (filterModel && filterModel.filterId)
                        param.filterId = filterModel.filterId;

                    formWindow.close();

                    thisController.saveFilterBtnHandler(param, saveInBd, items, null);
                }
            }
        });
    },

    returnFiltersForExtApp: function () {

        var thisController = this;
        thisController.setFiltersToLocalStorage();
        var filterString = '';
        var filtersArray = new Array();
        var clause = thisController.controllerMetadata.applyFilters.clause;
        Ext.each(thisController.controllerMetadata.applyFilters.CustomBeforeFilters,
            function (item) {
                filtersArray.push(item.Where_clause);
            });
        Ext.each(thisController.controllerMetadata.applyFilters.SystemBeforeFilters,
            function (item) {
                filtersArray.push(item.Where_clause);
            });

        Ext.each(thisController.controllerMetadata.applyFilters.DynamicBeforeFilters,
            function (item) {
                if (clause !== item.Where_clause)
                    filtersArray.push(item.Where_clause);
            });
        if (clause)
            filtersArray.push(clause);
        // var arr = filtersArray.join(' and ');
        if (window.parent && window.parent.CallFunctionFromMetaTable)
            window.parent.CallFunctionFromMetaTable(filtersArray, true);
        return;
    },

    getApplyFilters: function (getByString) {
        var thisController = this;
        var filterString = '';
        var filtersArray = new Array();
        var clause = thisController.controllerMetadata.applyFilters.clause;
        Ext.each(thisController.controllerMetadata.applyFilters.CustomBeforeFilters,
            function (item) {
                filtersArray.push(item.Where_clause);
            });
        Ext.each(thisController.controllerMetadata.applyFilters.SystemBeforeFilters,
            function (item) {
                filtersArray.push(item.Where_clause);
            });

        Ext.each(thisController.controllerMetadata.applyFilters.DynamicBeforeFilters,
            function (item) {
                if (clause !== item.Where_clause)
                    filtersArray.push(item.Where_clause);
            });
        if (clause)
            filtersArray.push(clause);
        if (getByString) {
            if (filtersArray.length > 0)
                return filtersArray.join(' and ');
        }
        else
            return filtersArray;


    },
    updateFiltersFormBd: function () {
        var thisController = this;
        var controllerMetadata = thisController.controllerMetadata;
    },

    setFiltersToLocalStorage: function () {

        var thisController = this;
        var metadata = thisController.controllerMetadata;
        if (!metadata.saveFilterLocal || metadata.saveFilterLocal.toLowerCase() != "true")
            return false;
        var tableId = metadata.tableInfo.TABID;
        var keyFilterLosSrorage = metadata.localStorageModel.FiltersStorageKey;
        var applyFilters = metadata.applyFilters;
        var filterInfoEncode = Ext.JSON.encode(applyFilters);
        var myLocalStore = Ext.state.LocalStorageProvider.create();
        //var filterInfoBefore = myLocalStore.get(tableId);
        myLocalStore.set(keyFilterLosSrorage, applyFilters);
        if (thisController.checkHasBeforeFilters())
            var cleareWindowFilterBtn = Ext.getCmp('clareFilersInDialogId');
        if (cleareWindowFilterBtn)
            cleareWindowFilterBtn.setDisabled(false);
        var clearFilterButton = Ext.getCmp('clearFilterButton');
        if (clearFilterButton)
            clearFilterButton.setDisabled(false);
    },

    checkHasBeforeFilters: function () {
        var thisController = this;
        var controllerMetadata = thisController.controllerMetadata;
        var applyFilters = controllerMetadata.applyFilters;

        if (applyFilters.CustomBeforeFilters && applyFilters.CustomBeforeFilters.length > 0
            || applyFilters.SystemBeforeFilters && applyFilters.SystemBeforeFilters.length > 0
            || applyFilters.DynamicBeforeFilters && applyFilters.DynamicBeforeFilters.length > 0
            || applyFilters.ConstructorStructure && applyFilters.DynamicBeforeFilters.length > 0)
            applyFilters.hasAplyFilters = true;
        return applyFilters.hasAplyFilters;

    },
    addDynamicFiltersTub: function (row, dynFilter) {
        var thisController = this;
        var controllerMetadata = thisController.controllerMetadata;
        controllerMetadata.thisController = thisController;
        var tab = Ext.getCmp('tabFilterPanel');
        var windTube = Ext.getCmp('filterWindowTabPanel');

        controllerMetadata.tabPanel = tab ? tab : windTube;
        controllerMetadata.tabPanel.add(
                   {
                       id: 'dynamicFilterTab',
                       title: 'Динамічні фільтри',
                       items: Ext.create('ExtApp.view.refBook.DynamicFiltersGrid', { thisController: thisController }),
                       minHeight: 100,
                       width: '100%',
                       maxHeight: 600
                   });
        controllerMetadata.tabPanel.setActiveTab(0);
        controllerMetadata.tabPanel.setActiveTab(1);
        if (controllerMetadata.tabPanel.items.length >= 3)
            controllerMetadata.tabPanel.setActiveTab(2);
        var filterGrid = Ext.getCmp('DynamicFiltersGridId');
        if (filterGrid && filterGrid.store && row) {
            thisController.insertDynamicFilterInGrid(row, dynFilter, filterGrid);
        }



    },

    addDynamicFilterHandler: function (dynFilter, structRows, checkThisOnly) {

        var thisController = this;

        var filterGrid = Ext.getCmp('DynamicFiltersGridId');
        if (checkThisOnly)
            thisController.uncheckFilterGrid(filterGrid);
        if (filterGrid && filterGrid.store) {
            thisController.insertDynamicFilterInGrid(dynFilter, filterGrid);
        }
        else {
            thisController.addDynamicFiltersTub(dynFilter);
        }
        if (structRows && structRows.length > 0)
            thisController.controllerMetadata.applyFilters.ConstructorStructure = structRows;
      if(dynFilter.Where_clause)
            thisController.controllerMetadata.applyFilters.clause = dynFilter.Where_clause;

    },

    insertDefaultFiltersValues: function () {
        
        var thisController = this;
        var applyFilters = thisController.controllerMetadata.applyFilters;
        if (!applyFilters)
            return false;
        //if (applyFilters.DynamicBeforeFilters.length > 0)
        //    thisController.insertDynamicFiltersInGrid(applyFilters.DynamicBeforeFilters);
        if (applyFilters.ConstructorStructure && applyFilters.ConstructorStructure.length != undefined && applyFilters.ConstructorStructure.length > 0) {

            thisController.insertConstructorStructure(applyFilters.ConstructorStructure);
        } else {
            thisController.insertEmtyRowInConstructor();
        }
    },

    insertDynamicFiltersInGrid: function (dynFilters) {

        var thisController = this;
        var thisFilterGrid = Ext.getCmp('DynamicFiltersGridId');
        if (!thisFilterGrid || !dynFilters || dynFilters.length < 1)
            return false;
        Ext.Array.each(dynFilters, function (dynFilter) {
            thisController.insertDynamicFilterInGrid(dynFilter, thisFilterGrid);
        });
    },

    insertConstructorStructure: function (strRows) {
        var constructor = Ext.getCmp('ConstructorGrid');
        if (!constructor || !strRows || strRows.length < 1)
            return false;
        var store = constructor.getStore();

        Ext.each(strRows,
            function (row) {
                var model = ExtApp.utils.RefBookUtils.createGridModel('rowFilterModel');
                model.data['LogicalOp'] = row.LogicalOp;
                model.data['Colname'] = row.Colname;
                model.data['ReletionalOp'] = row.ReletionalOp;
                model.data['Value'] = row.Value;
                var count = store.getCount();
                store.insert(count, model.data);
            });
    },

    insertEmtyRowInConstructor: function (constructorGrid) {
        //var model = ExtApp.utils.RefBookUtils.createGridModel.call(null, 'rowFilterModel');
        var model = ExtApp.utils.RefBookUtils.createGridModel('rowFilterModel');
        model.data['Colname'] = "";
        model.data['LogicalOp'] = "";
        model.data['ReletionalOp'] = "";
        model.data['Value'] = "";
        var grid = constructorGrid ? constructorGrid : Ext.getCmp('ConstructorGrid');
        var store = grid.getStore();
        var count = 0;
        store.insert(count, model);

    },
    insertDynamicFilterInGrid: function (dynFilter, filterGrid) {
        var thisController = this;
        var thisFilterGrid = filterGrid ? filterGrid : Ext.getCmp('DynamicFiltersGridId');
        if (!thisFilterGrid)
            return false;

        //if (dynFilter)
        //    thisFilterGrid.store.insert(0, dynFilter);
        if (dynFilter.Where_clause) {
            var items = thisFilterGrid.getStore().data.items;
            var item = Ext.Array.findBy(items, function (i) { return i.data.Where_clause == dynFilter.Where_clause });
            if (!item) {
                thisFilterGrid.store.insert(0, dynFilter);
            }
            else
                if (item.data.IsApplyFilter == 0) {
                    item.set('IsApplyFilter', 1);
                }
        }
        thisController.updateDynamiFilterFromGrid();
        thisController.controllerMetadata.mainGrid = Ext.getCmp('mainReferenceGrid');
        if (thisController.controllerMetadata.mainGrid)
            thisController.updateGridByFilters();
    },

    insertClorsSemantic: function () {
        
        var  thisController = this;
        var colorRows =  thisController.controllerMetadata.colorsForGrid;
        if(colorRows && colorRows.length && colorRows.length > 0)
        var colorGrid = Ext.getCmp('ColorSemanticGridId');
        if ( !colorGrid || !colorRows || colorRows.length < 1)
            return false;
        var store = colorGrid.getStore();

        Ext.each(colorRows,
            function (row) {
                var model = ExtApp.utils.RefBookUtils.createGridModel('rowColorMdoel');
                model.data['COLOR_NAME'] = row.COLOR_NAME;
                model.data['COLOR_SEMANTIC'] = row.COLOR_SEMANTIC;
                var count = store.getCount();
                store.insert(count, model.data);
            });
        
    },

    updateDynamiFilterFromGrid: function () {
        var thisController = this;
        thisController.controllerMetadata.applyFilters.DynamicBeforeFilters = [];
        var thisFilterGrid = Ext.getCmp('DynamicFiltersGridId');
        thisFilterGrid.getStore().each(function (record) {
            if (record.data['IsApplyFilter'] == 1)
                thisController.controllerMetadata.applyFilters.DynamicBeforeFilters.push({
                    //к имени поля добавляем имя таблицы
                    IsApplyFilter: true,
                    Where_clause: record.data['Where_clause']
                });
        });
        thisController.setFiltersToLocalStorage();
    },

    setAccessLevel: function (metadata) {
        //записываем в метаданные уровень доступа
        metadata.tableMode = window.tableMode;
        metadata.canUpdate = function () {
            return metadata.tableMode == 'FullUpdate' || metadata.tableMode == 'OnlyUpdate' || metadata.tableMode == 'InsertUpdate' || metadata.tableMode == 'DeleteUpdate';
        };
        metadata.canInsert = function () {
            return metadata.tableMode == 'FullUpdate' || metadata.tableMode == 'InsertUpdate' || metadata.tableMode == 'InsertDelete' || metadata.tableMode == 'Insert';
        };
        metadata.canDelete = function () {
            return metadata.tableMode == 'FullUpdate' || metadata.tableMode == 'DeleteUpdate' || metadata.tableMode == 'Delete' || metadata.tableMode == 'InsertDelete';
        };
        return metadata;
    },

    //добавить/редактировать строку справочника - единый метод, который использует как rowEditing плагин грида так и форма редактирования
    //values - текущие значения
    //modified - поля которые были изменены и их значения до изменения (нужно только для insert)
    //isPhantom признак показывает добавляется новая строка или редактируется существующая (true - добавляется новая)
    //isDirty признак показывает были ли данные изменены при редактировании (true - были изменены)
    AddEditRecord: function (values, modified, isPhantom, isDirty) {
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        //выбрать все колонки кроме колонок из других таблиц
        var metaColumns = Ext.Array.filter(referenceGrid.metadata.columnsInfo, function (col) { return col.IsForeignColumn == false; });
        //если строка было добавлена как новая а не редактируется текущая 
        //(признак phantom означает что строка есть в store на клиенте, но она не сохранена)
        if (isPhantom) {
            var insertableRow = new Array();
            Ext.each(metaColumns, function () {
                var field = {};
                field.Name = this.COLNAME;
                field.Type = this.COLTYPE;
                field.Value = values[this.COLNAME];
                insertableRow.push(field);
            });

            Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' + '</br></br>', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
            this.sendToServer(
                "/barsroot/ReferenceBook/InsertData",
                { jsonInsertableRow: Ext.JSON.encode(insertableRow), tableId: referenceGrid.metadata.tableInfo.TABID, tableName: referenceGrid.metadata.tableInfo.TABNAME, random: Math.random },
                thisController.AddEditAfterRequest);
        } else {
            //если строка была отредактирована
            if (isDirty) {
                //ключевые поля проверки where для update (записываются все поля для оптимистической блокировки)
                var rowKeysToEdit = new Array();
                //поля которые были отредактированы
                var rowDataToEdit = new Array();
                Ext.each(metaColumns, function () {
                    //так как оптимистическая блокировка, то where строится по всем полям
                    var keyField = {};
                    keyField.Name = this.COLNAME;
                    keyField.Type = this.COLTYPE;
                    if (modified[this.COLNAME] !== undefined) {
                        //если значение изменилось, то в where запишем старое значение: where field1 = oldValue
                        keyField.Value = modified[this.COLNAME];
                    } else {
                        //если значение не изменилось, то его нет в modified и в where запишем текущее значение: where field1 = value
                        keyField.Value = values[this.COLNAME];
                    }

                    //if ((keyField.Type == 'S' || keyField.Type == 'C') && keyField.Value.indexOf("href=") > 0)
                    //    return;
                    rowKeysToEdit.push(keyField);

                    //если значение изменилось (есть в массиве измененных значений) то добавляем в список update field1=val1, field2=val2...
                    if (modified[this.COLNAME] !== undefined) {
                        var dataField = {};
                        dataField.Name = this.COLNAME;
                        dataField.Type = this.COLTYPE;
                        dataField.Value = values[this.COLNAME];
                        rowDataToEdit.push(dataField);
                    }
                });
                var editDataObj = new Object();
                editDataObj.OldRow = rowKeysToEdit;
                editDataObj.Modified = rowDataToEdit;
                //editDataObj.TableId = "";
                //editDataObj.TableName = referenceGrid.metadata.tableInfo.TABNAME;
                //editDataObj.random = Math.random;


                Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' + '</br></br>', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
                thisController.sendToServer(
                    "/barsroot/ndi/ReferenceBook/UpdateData/?" + "tableId=" + referenceGrid.metadata.tableInfo.TABID + "&tableName=" +
                    referenceGrid.metadata.tableInfo.TABNAME,
                    {
                        editData: Ext.JSON.encode(editDataObj)
                    },
                    thisController.AddEditAfterRequest);
            }
        }
    },

    //вызывается после ответа сервера при добавлении/редактировании записи
    AddEditAfterRequest: function (status, msg, controller) {
        //обработка при удачном запросе на сервер
        Ext.MessageBox.hide();
        Ext.MessageBox.show({ title: 'Оновлення даних', msg: msg + '</br></br>', buttons: Ext.MessageBox.OK });
        if (status == "ok") {
            //закрываем форму редактирования если она открыта
            var refEditWindow = Ext.ComponentQuery.query('#refEditWindow')[0];
            controller.controllerMetadata.AddEditRowsInform.EditingRowsDataArray = new Array();
            if (refEditWindow) {
                refEditWindow.close();
            }
            //перечитка данных грида
            controller.getGrid().store.load();
        }
    },

    //посылает данные на сервер для всех DML операций, выполнения sql-процедур
    sendToServer: function (url, params, afterRequestFunction) {
        var thisController = this;
        Ext.Ajax.request({
            url: url,
            method: 'POST',
            params: params,
            success: function (conn, resp) {
                var response = Ext.decode(conn.responseText);
                if (afterRequestFunction) {
                    
                    afterRequestFunction(response.status, response.msg, thisController);
                }
            },
            failure: function (conn, response) {
                if(conn && conn.request)
                {
                    if(conn.request.responseText === '')
                        return;
                    Ext.Msg.show({ title: "Виникли проблеми при з'єднанні з сервером", msg: conn.request.responseText + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                }
                else
                    return;
                //обработка при неудачном запросе на сервер

            }
        });
    },   

    getFileFromServer: function (url) {
        window.location = url;
    },

    updateColumnsHidden: function () {
        var grid = this.getGrid();
        
        var hiddenColumns = ExtApp.utils.RefBookUtils.getColumnsHiddenFromGrid(grid);
        var clearColBtn = Ext.getCmp('cleareColumnsButton');
        if (clearColBtn)
        {
            if (hiddenColumns && hiddenColumns.length)
                clearColBtn.setDisabled(false);
            else
                clearColBtn.setDisabled(true);
        }
        
        ExtApp.utils.RefBookUtils.setHiddenColumnsToLocalSrorage(hiddenColumns, grid.metadata.localStorageModel);

    },
    onExportToExcelBtnClick: function (menu, item) {

        var grid = menu.up('referenceGrid');
        

        var columnsHiddenNames = ExtApp.utils.RefBookUtils.getHiddenColumnsFromLocalSrorage(grid.metadata.localStorageModel);
        
           
        //Ext.each(grid.columns, function (column, index) {
        //    if (column.isHidden()) {
        //        columnsVisible.push(column.dataIndex);
        //    }
        //});

        //В зависимости от выбранного пункта меню загружаем всю таблицу либо только текущую страницу
        var pageSize = grid.store.pageSize;
        var start = ((grid.store.currentPage - 1) * grid.store.pageSize);
        var getAll = item.allPages;
        if (item.allPages) {
         
            start = 0;
            pageSize = 999;
        }
        var metaData = {
            tableInfo: grid.metadata.tableInfo
        };
        metaData.columnsInfo = [];
        var sort = grid.store.sorters.items;

        var oper = new Ext.data.Operation();
        grid.store.fireEvent('BeforeLoad', grid.store, oper);

        var exportExcelObj = new Object();

        window.open("/barsroot/ReferenceBook/ExportToExcel?" +
            "tableId=" + grid.metadata.tableInfo.TABID +
            "&tableName=" + grid.metadata.tableInfo.TABNAME +
            "&gridFilter=" + oper.params.gridFilter +
            "&startFilter=" + grid.store.proxy.extraParams.startFilter +
            "&Base64DynamicFilter=" + ExtApp.utils.RefBookUtils.getBase64().encode(grid.store.proxy.extraParams.dynamicFilter)  +
            "&columnsVisible=" + columnsHiddenNames +
            "&externalFilter=" + grid.store.proxy.extraParams.externalFilter +
            "&sort=" + Ext.encode(sort) +
            "&start=" + start +
            "&limit=" + pageSize +
            "&GetAll=" + getAll +
            "&CodeOper=" + window.CodeOper +
            "&nativeTabelId=" + window.nativeTabelId +
            "&sParColumn=" + window.sParColumn +
            "&nsiTableId=" + window.nsiTableId +
            "&nsiFuncId=" + window.nsiFuncId +
            "&executeBeforFunc=" + window.executeBeforFunc +
            "&jsonSqlProcParams=" + window.jsonSqlProcParams +
            "&base64jsonSqlProcParams=" + window.base64jsonSqlProcParams
        );
        grid.store.fireEvent('Load');
    },


    //заполнить параметры и вызвать sql-процедуру определенного типа
    //metaInfo - метаописание процедуры, параметров
    callSqlFunction: function (funcMetaInfo) {
        
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        var gridSelectModel = referenceGrid.getSelectionModel();
        var selectedRows;
        //заполнить информацию о вызываемой функции по метаданным
        thisController.fillCallFuncInfo(funcMetaInfo,referenceGrid.metadata);
        var func = thisController.currentCalledSqlFunction;
        switch (funcMetaInfo.PROC_EXEC) {
            //выполнение процедуры один раз, параметры не берутся из данных грида, а либо константы либо вводятся вручную
            case "ONCE":
                {
                    func.infoDialogTitle = 'Виконання процедури: ' + funcMetaInfo.DESCR;
                    //для ONCE заполняем единожды параметры в диалоге и вызываем функцию (из строк грида никакие данные не берутся)
                    func.params.push({ rowIndex: null, rowParams: new Array() });

                    if (funcMetaInfo.SystemParamsInfo && funcMetaInfo.SystemParamsInfo.length > 0)
                        thisController.setSystemParams();
                    if (func.paramsInfo.length > 0 &&
                        Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                        thisController.showInputParamsDialog(false,
                            function () {
                                thisController.executeCurrentSqlFunction();
                            });
                    else
                        thisController.executeCurrentSqlFunction();
                    break;
                }
                //выполнение процедуры для каждой выделенной строки
            case "EACH":
            case "BATCH":
                {
                    //получаем собственно выбранные строки
                    selectedRows = gridSelectModel.getSelection();
                    func.allFuncCallCount = selectedRows.length;
                    func.infoDialogTitle = 'Виконання процедури для вибранних рядків';
                    var qst = funcMetaInfo.QST;
                    var descr = funcMetaInfo.DESCR;

                    //если пользователь не выбрал строк
                    if (selectedRows.length === 0) {
                        Ext.MessageBox.show({
                            title: func.infoDialogTitle,
                            msg: "Не обрано жодного рядка",
                            buttons: Ext.MessageBox.OK
                        });
                        return;
                    }
                    if (qst) {
                        var selectRow = selectedRows[0];
                        if (descr && descr.indexOf(":") > -1) {
                                var thisController = this;
                                var referenceGrid = thisController.getGrid();
                                Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                                    var par = ':' + item.COLNAME;
                                    descr = descr.replace(par, selectRow.data[item.COLNAME]);
                                });
                            }
                        if (qst.indexOf(":") > -1) {
                            var thisController = this;
                            var referenceGrid = thisController.getGrid();
                            Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                                var par = ':' + item.COLNAME;
                                qst = qst.replace(par, selectRow.data[item.COLNAME]);
                            });
                        }
                        var titleMsg = 'Виконання процедури' + descr;//.replace(;
                        Ext.MessageBox.confirm(titleMsg, qst + '</br>', function (btn) {
                            if (btn != 'yes') {
                                return false;
                            }
                            else {
                                thisController.fillFuncParamsFromRows(selectedRows);

                                //для EACH параметры заполняются в диалоге заново для каждой выбранной строки
                                //после заполнения параметров из грида заполняем вводимые параметры в диалоге для всех строк, и посли нажатия Ok вызываем функцию
                                if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                                    thisController.showInputParamsDialog(false, function () {
                                        //запоминаем номер строки для которой вызывается процедура, чтобы в случае неудачи пользователь знал на какой строке свалилось
                                        thisController.executeCurrentSqlFunction();
                                    });
                                else
                                    thisController.executeCurrentSqlFunction();
                            }
                        });
                    }
                    else {

                        //заполняем значения параметров из выбранных строк
                        thisController.fillFuncParamsFromRows(selectedRows);

                        //для EACH параметры заполняются в диалоге заново для каждой выбранной строки
                        //после заполнения параметров из грида заполняем вводимые параметры в диалоге для всех строк, и посли нажатия Ok вызываем функцию
                        if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                            thisController.showInputParamsDialog(false, function () {
                                //запоминаем номер строки для которой вызывается процедура, чтобы в случае неудачи пользователь знал на какой строке свалилось
                                thisController.executeCurrentSqlFunction();
                            });
                        else
                            thisController.executeCurrentSqlFunction();
                    }
                }
                break;
           case "SELECTED_ONE":
                {
                    
                    selectedRows = gridSelectModel.getSelection();
                    func.allFuncCallCount = selectedRows.length;
                    var qst = funcMetaInfo.QST;
                    var descr = funcMetaInfo.DESCR;
                    var warningMsg;
                    //если пользователь не выбрал строк
                    if (selectedRows.length === 0)
                        warningMsg = "Не обрано жодного рядка";
                    if (selectedRows.length > 1)
                        warningMsg = "Обрано більше одного рядка";
                    if (warningMsg) {
                        Ext.MessageBox.show({
                            title: func.infoDialogTitle,
                            msg: warningMsg,
                            buttons: Ext.MessageBox.OK
                        });
                        return;
                    }
                    var selectRow = selectedRows[0];
                    func.infoDialogTitle = 'Виконання процедури для рядка' + referenceGrid.metadata.CurrentActionInform.lastClickRowInform.rowNumber;
                    if (qst) {

                        if (descr)
                            if (descr.indexOf(":") > -1) {
                                var thisController = this;
                                var referenceGrid = thisController.getGrid();
                                Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                                    var par = ':' + item.COLNAME;
                                    descr = descr.replace(par, selectRow.data[item.COLNAME]);
                                });

                            }
                        if (qst.indexOf(":") > -1) {
                            var thisController = this;
                            var referenceGrid = thisController.getGrid();
                            Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                                var par = ':' + item.COLNAME;
                                qst = qst.replace(par, selectRow.data[item.COLNAME]);
                            });

                        }
                        var titleMsg = 'Виконання процедури' + descr;//.replace(;
                        Ext.MessageBox.confirm(titleMsg, qst + '</br>', function (btn) {
                            if (btn != 'yes') {
                                return false;
                            }
                            else {
                                thisController.fillFuncParamsFromRows(selectedRows);

                                //для EACH параметры заполняются в диалоге заново для каждой выбранной строки
                                //после заполнения параметров из грида заполняем вводимые параметры в диалоге для всех строк, и посли нажатия Ok вызываем функцию
                                if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                                    thisController.showInputParamsDialog(true, function () {
                                        //запоминаем номер строки для которой вызывается процедура, чтобы в случае неудачи пользователь знал на какой строке свалилось
                                        thisController.executeCurrentSqlFunction();
                                    });
                                else
                                    thisController.executeCurrentSqlFunction();
                            }
                        });
                    }
                    else {

                        //заполняем значения параметров из выбранных строк
                        thisController.fillFuncParamsFromRows(selectedRows);

                        //для EACH параметры заполняются в диалоге заново для каждой выбранной строки
                        //после заполнения параметров из грида заполняем вводимые параметры в диалоге для всех строк, и посли нажатия Ok вызываем функцию
                        if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                            thisController.showInputParamsDialog(true, function () {
                                //запоминаем номер строки для которой вызывается процедура, чтобы в случае неудачи пользователь знал на какой строке свалилось
                                thisController.executeCurrentSqlFunction();
                            });
                        else
                            thisController.executeCurrentSqlFunction();
                    }
                    break;
                }
            case "ALL":
                {
                    //если процедуру нужно вызвать для всех строк, то выделяем все строки, для более простого их получения
                    gridSelectModel.selectAll();
                    //selectedRows = gridSelectModel.getSelection();
                    //var params = new Array();
                    //Ext.each(gridSelectModel.getStore().data.items,function (item) {
                    //    params.push(item.data);
                    //});
                    selectedRows = gridSelectModel.getStore().data.items
                    func.allFuncCallCount = selectedRows.length;
                    func.infoDialogTitle = 'Виконання процедури для всіх рядків, що відображаються';

                    //если в гриде вообще нет строк с данными
                    if (selectedRows.length == 0) {
                        Ext.MessageBox.show({
                            title: func.infoDialogTitle,
                            msg: "Рядки з даними відсутні",
                            buttons: Ext.MessageBox.OK
                        });
                        return;
                    }

                    //заполняем значения параметров из выбранных строк
                    thisController.fillFuncParamsFromRows(selectedRows);
                    //gridSelectModel.deselectAll();
                    //для ALL заполняем единожды параметры функции, значения которых нужно ввести в диалоге ввода параметров
                    //после нажатия "Ok" в диалоге ввода параметров - проходимся по всем строкам, дозаполняем параметры и вызываем функции для конкретных строк
                    if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                        thisController.showInputParamsDialog(false, function () {
                            //var metadata =  this.getgrid().metadata;
                            thisController.executeCurrentSqlFunction();
                        })
                    else
                        thisController.executeCurrentSqlFunction();
                    break;
                }
            case "ON_ROW_CLICK":
                {
                    func.infoDialogTitle = 'Виконання процедури: ' + funcMetaInfo.DESCR;

                    func.params.push({ rowIndex: null, rowParams: new Array() });
                    var qst = funcMetaInfo.QST;
                    if (qst) {
                        qst = ExtApp.utils.RefBookUtils.replaceParamsFromRow(funcMetaInfo.dataRowArray, qst);
                        Ext.MessageBox.confirm(funcMetaInfo.DESCR, qst + '</br>', function (btn) {
                            if (btn != 'yes') {
                                return false;
                            }
                            else {
                                if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                                    thisController.showInputParamsDialog(false, function () {
                                        thisController.executeCurrentSqlFunction();
                                    })
                                else
                                    thisController.executeCurrentSqlFunction();
                            }
                        });
                    }
                    else {
                        if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                            thisController.showInputParamsDialog(false, function () {
                                thisController.executeCurrentSqlFunction();
                            })
                        else
                            thisController.executeCurrentSqlFunction();
                    }

                    break;
                }
            case "LINK_FUNC_BEFORE":
                {
                    var gridSelectModel = referenceGrid.getSelectionModel();
                    var selectedRows = gridSelectModel.getSelection();
                    if (!selectedRows || selectedRows.length < 1) {
                        Ext.Msg.show({ title: "не обрано жодного рядка", msg: 'Не обрано жодного рядка' + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                        return;
                    }
                    var selectRow = selectedRows[0];
                    var params = new Array();
                    //заполняем параметры функции значения которых нужно взять из текущей строки грида
                    //if (referenceGrid.metadata.columnsInfo && !selectRow) {
                    //    Ext.Msg.show({ title: "Не вибрано жодного рядка", msg: "оберіть будь ласка рядок для обробки даних" + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                    //    return;
                    //}   )

                    if (funcMetaInfo)
                        Ext.each(funcMetaInfo.ParamsInfo, function (par) {
                            Ext.each(referenceGrid.metadata.columnsInfo,
                                function (item) {
                                    if (item.COLNAME == par.ColumnInfo.COLNAME) {
                                        var field = {};
                                        field.Name = item.COLNAME;
                                        field.Type = item.COLTYPE;
                                        field.SEMANTIC = item.SEMANTIC;
                                        field.Value = selectRow.data[item.COLNAME];
                                        params.push(field);
                                    }
                                });

                        });
                    if (funcMetaInfo && funcMetaInfo.ConditionParamNames)
                        Ext.each(referenceGrid.metadata.columnsInfo,
                                function (item) {
                                   if (Ext.Array.contains(funcMetaInfo.ConditionParamNames, item.COLNAME) && !Ext.Array.findBy(params, function (param) {
                                        return param.Name == item.COLNAME;
                                    })) {

                                        var field = {};
                                        field.Name = item.COLNAME;
                                        field.Type = item.COLTYPE;
                                        field.SEMANTIC = item.SEMANTIC;
                                        field.Value = selectRow.data[item.COLNAME];
                                        params.push(field);
                                    }
                                });

                    var emptyParam = Ext.Array.findBy(params, function (param) { return param.Value === "" || param.Value === undefined });
                    if (emptyParam) {
                        if (emptyParam.Name)
                            Ext.MessageBox.show({
                                title: func.infoDialogTitle,
                                msg: "Параметер " + emptyParam.SEMANTIC + ' порожній',
                                buttons: Ext.MessageBox.OK
                            });
                        return false;
                    }
                    //if (funcMetaInfo.ConditionParamNames)
                    //    Ext.each(funcMetaInfo.ConditionParamNames, function (parName) {
                    //        Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                    //            if (item.COLNAME == parName ){
                    //                ;
                    //                var field = {};
                    //                field.Name = item.COLNAME;
                    //                field.Type = item.COLTYPE;
                    //                field.Value = selectRow.data[parName]
                    //                params.push(field);
                    //            }
                    //        })

                    //    });
                    var paramsString = Ext.JSON.encode(params);
                    var Base64 = { _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=", encode: function (e) { var t = ""; var n, r, i, s, o, u, a; var f = 0; e = Base64._utf8_encode(e); while (f < e.length) { n = e.charCodeAt(f++); r = e.charCodeAt(f++); i = e.charCodeAt(f++); s = n >> 2; o = (n & 3) << 4 | r >> 4; u = (r & 15) << 2 | i >> 6; a = i & 63; if (isNaN(r)) { u = a = 64 } else if (isNaN(i)) { a = 64 } t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a) } return t }, decode: function (e) { var t = ""; var n, r, i; var s, o, u, a; var f = 0; e = e.replace(/[^A-Za-z0-9+/=]/g, ""); while (f < e.length) { s = this._keyStr.indexOf(e.charAt(f++)); o = this._keyStr.indexOf(e.charAt(f++)); u = this._keyStr.indexOf(e.charAt(f++)); a = this._keyStr.indexOf(e.charAt(f++)); n = s << 2 | o >> 4; r = (o & 15) << 4 | u >> 2; i = (u & 3) << 6 | a; t = t + String.fromCharCode(n); if (u != 64) { t = t + String.fromCharCode(r) } if (a != 64) { t = t + String.fromCharCode(i) } } t = Base64._utf8_decode(t); return t }, _utf8_encode: function (e) { e = e.replace(/rn/g, "n"); var t = ""; for (var n = 0; n < e.length; n++) { var r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r) } else if (r > 127 && r < 2048) { t += String.fromCharCode(r >> 6 | 192); t += String.fromCharCode(r & 63 | 128) } else { t += String.fromCharCode(r >> 12 | 224); t += String.fromCharCode(r >> 6 & 63 | 128); t += String.fromCharCode(r & 63 | 128) } } return t }, _utf8_decode: function (e) { var t = ""; var n = 0; var r = c1 = c2 = 0; while (n < e.length) { r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r); n++ } else if (r > 191 && r < 224) { c2 = e.charCodeAt(n + 1); t += String.fromCharCode((r & 31) << 6 | c2 & 63); n += 2 } else { c2 = e.charCodeAt(n + 1); c3 = e.charCodeAt(n + 2); t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63); n += 3 } } return t } }
                    var WEB_NAME = funcMetaInfo.WEB_FORM_NAME + "&jsonSqlParams=" + paramsString;
                    if (funcMetaInfo.OpenInWindow && funcMetaInfo.OpenInWindow == true)
                        this.openWindowByFunction(WEB_NAME);
                    else
                        window.open(WEB_NAME, '_blank');
                    break;
                }
            case "INTERNER_LINK_WITH_PARAMS":
                {
                    
                    var params = new Array();
                    var insertDefParams = Array();
                    var gridSelectModel = referenceGrid.getSelectionModel();
                    var selectedRows = gridSelectModel.getSelection();
                    //если в гриде вообще нет строк с данными
                    if (selectedRows.length == 0) {
                        Ext.MessageBox.show({
                            title: func.infoDialogTitle,
                            msg: "Не обрано жодного рядка",
                            buttons: Ext.MessageBox.OK
                        });
                        return;
                    }
                    var selectRow = selectedRows[0];
                    Ext.each(funcMetaInfo.ConditionParamNames, function (parName) {
                        Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                            if (item.COLNAME == parName) {
                                var field = {};
                                field.Name = item.COLNAME;
                                field.Type = item.COLTYPE;
                                field.SEMANTIC = item.SEMANTIC;
                                field.Value = selectRow.data[parName];
                                params.push(field);
                            }
                        })

                    });

                    
                    Ext.each(funcMetaInfo.RowParamsNames, function (parName) {
                        Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                            if (item.COLNAME == parName) {
                                var field = {};
                                field.Name = item.COLNAME;
                                field.Type = item.COLTYPE;
                                field.SEMANTIC = item.SEMANTIC;
                                field.Value = selectRow.data[parName];
                                params.push(field);
                            }
                        })

                    });
                    if (funcMetaInfo.ThrowNsiParams && funcMetaInfo.ThrowNsiParams.DefParams && funcMetaInfo.ThrowNsiParams.DefParams.length)
                        Ext.each(funcMetaInfo.ThrowNsiParams.DefParams, function (defPar) {
                            Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                                if (item.COLNAME == defPar.ColName && defPar.Kind == 'DEF_VAL_BY_INSERT') {
                                    var field = {};
                                    field.Name = item.COLNAME;
                                    field.Type = item.COLTYPE;
                                    field.SEMANTIC = item.SEMANTIC;
                                    field.Value = selectRow.data[defPar.ColName];
                                    insertDefParams.push(field);
                                }
                            })

                        });

                    var emptyParam = Ext.Array.findBy(params, function (param) { return param.Value === "" || param.Value == undefined});
                    if (emptyParam) {
                        if (emptyParam.Name)
                            Ext.MessageBox.show({
                                title: func.infoDialogTitle,
                                msg: "Параметер " + emptyParam.SEMANTIC + 'порожній',
                                buttons: Ext.MessageBox.OK
                            });
                        return false;
                    }

                    var paramsString = Ext.JSON.encode(params);
                    //var Base64 = { _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=", encode: function (e) { var t = ""; var n, r, i, s, o, u, a; var f = 0; e = Base64._utf8_encode(e); while (f < e.length) { n = e.charCodeAt(f++); r = e.charCodeAt(f++); i = e.charCodeAt(f++); s = n >> 2; o = (n & 3) << 4 | r >> 4; u = (r & 15) << 2 | i >> 6; a = i & 63; if (isNaN(r)) { u = a = 64 } else if (isNaN(i)) { a = 64 } t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a) } return t }, decode: function (e) { var t = ""; var n, r, i; var s, o, u, a; var f = 0; e = e.replace(/[^A-Za-z0-9+/=]/g, ""); while (f < e.length) { s = this._keyStr.indexOf(e.charAt(f++)); o = this._keyStr.indexOf(e.charAt(f++)); u = this._keyStr.indexOf(e.charAt(f++)); a = this._keyStr.indexOf(e.charAt(f++)); n = s << 2 | o >> 4; r = (o & 15) << 4 | u >> 2; i = (u & 3) << 6 | a; t = t + String.fromCharCode(n); if (u != 64) { t = t + String.fromCharCode(r) } if (a != 64) { t = t + String.fromCharCode(i) } } t = Base64._utf8_decode(t); return t }, _utf8_encode: function (e) { e = e.replace(/rn/g, "n"); var t = ""; for (var n = 0; n < e.length; n++) { var r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r) } else if (r > 127 && r < 2048) { t += String.fromCharCode(r >> 6 | 192); t += String.fromCharCode(r & 63 | 128) } else { t += String.fromCharCode(r >> 12 | 224); t += String.fromCharCode(r >> 6 & 63 | 128); t += String.fromCharCode(r & 63 | 128) } } return t }, _utf8_decode: function (e) { var t = ""; var n = 0; var r = c1 = c2 = 0; while (n < e.length) { r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r); n++ } else if (r > 191 && r < 224) { c2 = e.charCodeAt(n + 1); t += String.fromCharCode((r & 31) << 6 | c2 & 63); n += 2 } else { c2 = e.charCodeAt(n + 1); c3 = e.charCodeAt(n + 2); t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63); n += 3 } } return t } }

                   // var bas64Params = Base64.encode(paramsString);
                    var WEB_NAME = funcMetaInfo.WEB_FORM_NAME + "&jsonSqlParams=" + paramsString;
                    if (insertDefParams.length > 0)
                        WEB_NAME += "&InsertDefParams=" + Ext.JSON.encode(insertDefParams);
                    if (funcMetaInfo.OpenInWindow && funcMetaInfo.OpenInWindow == true)
                        this.openWindowByFunction(WEB_NAME);
                    else
                        window.open(WEB_NAME, '_blank');

                    break;
                }
            case "INTERNER_LINK":
                {
                    var WEB_NAME = funcMetaInfo.WEB_FORM_NAME;
                    if (funcMetaInfo.OpenInWindow && funcMetaInfo.OpenInWindow == true)
                        this.openWindowByFunction(WEB_NAME);
                    else
                        window.open(WEB_NAME, '_blank');
                    break;
                }
            case "LINK_WITH_PARAMS":
                {
                    var gridSelectModel = referenceGrid.getSelectionModel();
                    var selectedRows = gridSelectModel.getSelection();
                    //если в гриде вообще нет строк с данными
                    if (selectedRows.length == 0) {
                        Ext.MessageBox.show({
                            title: func.infoDialogTitle,
                            msg: "Не обрано жодного рядка",
                            buttons: Ext.MessageBox.OK
                        });
                        return;
                    }
                    var selectRow = selectedRows[0];
                    var WEB_NAME = funcMetaInfo.WEB_FORM_NAME;
                    var hasEmptyParams;
                    var uriParams = ExtApp.utils.RefBookUtils.getUrlParameterValues(WEB_NAME);
                    Ext.each(referenceGrid.metadata.columnsInfo, function (col) {
                        var parName = ':' + col.COLNAME;
                        if (WEB_NAME.indexOf(parName) !== -1) {
                            var Value = selectRow.data[col.COLNAME];
                            for (var key in uriParams) {
                                if (parName == uriParams[key]) {
                                    if (Value === undefined || Value === '') {
                                        Ext.MessageBox.show({
                                            title: func.infoDialogTitle,
                                            msg: "Параметер " + col.SEMANTIC + ' порожній',
                                            buttons: Ext.MessageBox.OK
                                        });
                                        hasEmptyParams = true;
                                        return false;
                                    }
                                    WEB_NAME = WEB_NAME.replace(parName, Value);
                                }
                            }
                        }
                    });
                    if (!hasEmptyParams) {
                        if (funcMetaInfo.OpenInWindow && funcMetaInfo.OpenInWindow == true) {
                            this.openWindowByFunction(WEB_NAME);
                        }
                        else
                            window.open(WEB_NAME, '_blank');
                    }

                    break;
                }
            case "LINK":
                {
                    var WEB_NAME = funcMetaInfo.WEB_FORM_NAME;
                    if (funcMetaInfo.OpenInWindow && funcMetaInfo.OpenInWindow == true) {
                        this.openWindowByFunction(WEB_NAME);
                    }
                    else
                        window.open(WEB_NAME, "_blank");
                    break;
                }
            case "GET_FILE_ONCE":
                {
                    
                    func.infoDialogTitle = 'Виконання процедури: ' + funcMetaInfo.DESCR;
                    //для ONCE заполняем единожды параметры в диалоге и вызываем функцию (из строк грида никакие данные не берутся)
                    func.params.push({ rowIndex: null, rowParams: new Array() });
                    if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                        thisController.showInputParamsDialog(false, function () {
                            thisController.executeCurrentSqlFunctionWithOutParams();
                        })
                    else
                        thisController.executeCurrentSqlFunctionWithOutParams();
                    break;
                }
            case "SIMPLE_VIS":
                {
                    func.infoDialogTitle = funcMetaInfo.DESCR;
                    selectedRows = gridSelectModel.getStore().data.items;
                    thisController.fillFuncParamsFromRows(selectedRows);
                    thisController.executeSimpleMathFuncs();
                }
            default:
                Ext.Msg.show({
                    title: "Тип процедури не знайдено",
                    msg: "Тип функції " + +"'" + funcMetaInfo.PROC_EXEC + "'" + " не знайдено" + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK
                });
                //thisController.functionLinkWithRow(funcMetaInfo);
                break;
        };
    },

    callSqlFunctionOnly: function (funcMetaInfo) {
        var thisController = this;
        thisController.fillCallFuncInfo(funcMetaInfo);
        var func = thisController.currentCalledSqlFunction;
        func.infoDialogTitle = 'Виконання процедури: ' + funcMetaInfo.DESCR;
        //для ONCE заполняем единожды параметры в диалоге и вызываем функцию (из строк грида никакие данные не берутся)
        func.params.push({ rowIndex: null, rowParams: new Array() });
        if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
            thisController.showInputParamsDialog(false,
                function () {
                    thisController.executeCurrentSqlFunction();
                });
        else
            thisController.executeCurrentSqlFunction();

    },

    //заполнить информацию о вызываемой sql-функции 
    //funcMetaInfo - метаинформация о вызываемой функции
    fillCallFuncInfo: function (funcMetaInfo,metadata) {
        
        var thisController = this;
        
        //метаинформация о параметрах
        var paramsMeta = funcMetaInfo.ParamsInfo;
        var systemParamsInfo = funcMetaInfo.SystemParamsInfo;
        //в данном объекте будем сохранять нужную информацию о текущей вызванной функции
        thisController.currentCalledSqlFunction = {
            hasFileResult: funcMetaInfo.HasFileResult,
            CodeOper: funcMetaInfo.CodeOper,
            isFuncOnly: funcMetaInfo.isFuncOnly,
            tableId: funcMetaInfo.TABID,
            ColumnId: funcMetaInfo.ColumnId,
            funcId: funcMetaInfo.FUNCID,
            //имя и тип параметров
            paramsInfo: new Array(),
            systemParamsInfo: new Array(),
            systemParams: new Array(),
            //параметры со значениями для всех строк, для которых выполняется процедура 
            params: new Array(),
            jsonSqlProcParams: funcMetaInfo.jsonSqlProcParams ? funcMetaInfo.jsonSqlProcParams : window.jsonSqlProcParams ? window.jsonSqlProcParams : '',
            //текущий номер вызова функции (нужно если мы вызываем одну и ту же функцию для нескольких строк, для показа progressbar-а)
            currentCallIndex: 0,
            //количество удачно выполненных функций от общего количества (удачно если сервер вернул статус "ok")
            successCallCount: 0,
            //общее количество раз которое функция будет вызвана (зависит от количества выбранных строк на которых мы вызываем функцию)
            allFuncCallCount: 1,
            infoDialogTitle: "Виконання процедури: " + funcMetaInfo.DESCR,
            paramsFormPanelItems: new Array(),
            //данный параметр нужен для отслеживания количества вызова диалога ввода параметов (для режима EACH)
            currentParamsInputIndex: 0,
            //будем записывать сюда информацию об ошибках при выполнении процедур
            errorLog: new Array(),
            //Текст процедуры
            funcName: funcMetaInfo.PROC_NAME,
            linkWebFormName: funcMetaInfo.LinkWebFormName,
            simpleMsg: funcMetaInfo.MSG,
            canSendByBatch: Ext.Array.contains(['ALL', 'EACH', 'BATCH'], funcMetaInfo.PROC_EXEC),
            MultiRowsParams: funcMetaInfo.MultiRowsParams,
            procExec: funcMetaInfo.PROC_EXEC,
            saveInPageParams: !metadata ? null : metadata.saveInPageParams,
            base64ExternProcParams: !funcMetaInfo.base64ExternProcParams ? '' : funcMetaInfo.base64ExternProcParams
        };
       
        var func = thisController.currentCalledSqlFunction;
        //по переданным данным заполняем форму ввода параметров
        Ext.each(paramsMeta, function (par) {
            //упрощенные метаданные параметров - только то что нужно для заполнения значений
            func.paramsInfo.push({
                Name: par.ColumnInfo.COLNAME,
                Type: par.ColumnInfo.COLTYPE,
                IsInput: par.IsInput,
                kind: par.Kind,
                additionalUse : par.AdditionalUse
            });
            //для параметров, которые нужно вводить вручную, заполняем поля формы
            if (par.IsInput == true) {
                //конфигурируем поле ввода по метаописанию и устанавливаем значение по умолчанию, если есть
                var formField = ExtApp.utils.RefBookUtils.configFormField(par.ColumnInfo);
                if (par.DefaultValue) {
                    formField.value = par.DefaultValue;
                }
                func.paramsFormPanelItems.push(formField);
            }
        });
        ;
        if (systemParamsInfo && systemParamsInfo.length > 0)
            Ext.each(systemParamsInfo, function (par) {
                func.systemParamsInfo.push({
                    Name: par.ColName,
                    Type: par.ColType
                })
            });
    },

    openWindowByFunction: function (WEB_NAME) {
        var baseCodeOper = window.baseCodeOper;
        if (baseCodeOper)
            WEB_NAME += '&baseCodeOper=' + baseCodeOper;
        var width = Ext.getBody().getViewSize().width * 0.97;
        var height = Ext.getBody().getViewSize().height * 0.93;
        var params = 'width=' + width + ',' + 'height=' + height + ',' + 'scrollbars=1' + ',' + 'left=205,top=125';
        window.open(WEB_NAME, '_blank', params);
    },
    //заполнить параметры произвольных sql-процедур, взять значения из строк грида
    //selectedRows - выбранные строки грида
    fillFuncParamsFromRows: function (selectedRows) {
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        var func = thisController.currentCalledSqlFunction;

        func.sendByBatch = func.canSendByBatch && func.allFuncCallCount > 1 || func.procExec == 'BATCH';

        //проход по всем выбранным строкам
        Ext.each(selectedRows, function (selectedRow) {
            //заполняем параметры для текущей строки
            var currentParams = { rowIndex: selectedRow.index + 1, rowParams: new Array() };
            //заполняем параметры функции значения которых нужно взять из текущей строки грида
            Ext.each(func.paramsInfo, function (par) {

                if (par.IsInput == false) {
                    var colParam = Ext.Array.findBy(referenceGrid.metadata.columnsInfo, function (i) { return i.COLNAME == par.Name; });
                    if(colParam)
                    currentParams.rowParams.push({
                        Name: par.Name,
                        //для невводимых параметров тип параметра берем из метаданных колонки, с которой берем значение
                        Type: colParam.COLTYPE,
                        //присваиваем значению параметра значение с выбранной строки грида
                        Value: selectedRow.data[par.Name]
                    });
                }
            });
            func.params.push(currentParams);
        });
    },

    fillMultiRowParams: function (selectedRows) {
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        var func = thisController.currentCalledSqlFunction;
        if (!func.MultiRowsParams || func.MultiRowsParams.length < 1)
            return;
        Ext.each(func.MultiRowsParams, function (multiParam) {

            Ext.each(selectedRows, function (selectedRow) {
                //заполняем параметры для текущей строки
                var currentParams =  new Array();
                //заполняем параметры функции значения которых нужно взять из текущей строки грида

                Ext.each(multiParam.ListColumnNames, function (name) {
 
                        currentParams.rowParams.push({
                            Name: par.Name,
                            //для невводимых параметров тип параметра берем из метаданных колонки, с которой берем значение
                            Type: Ext.Array.findBy(referenceGrid.metadata.columnsInfo, function (i) { return i.COLNAME == name; }).COLTYPE,
                            //присваиваем значению параметра значение с выбранной строки грида
                            Value: selectedRow.data[par.Name]
                        });
                });
                multiParam.RowFilds.push(currentParams);
            });
        });

    },
    //показать диалог ввода параметров для sql-функции
    //showForEachRow - true-диалог будет запрашивать параметры для каждой строки, false-единожды для всех строк
    //okBtnHandler - функция для вызова после нажатия кнопки "Ok" диалога
    showInputParamsDialog: function (showForEachRow, okBtnHandler) {
        
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
        var title = func.infoDialogTitle + ". Заповніть параметри процедури";
        
        //если мы отправляем информацию со всех выделенных строк в одной процедуре - то параметры ввода сохраняем отдельно
        if (func.sendByBatch)
        {
            showForEachRow = false;
        }

        if (showForEachRow) {
            title += " для рядка " + (func.params[func.currentParamsInputIndex].rowIndex);
        }

        Ext.create('ExtApp.view.refBook.refShowparamWindow', {
            itemId: "funcParamsWindow",
            title: title,
            items: Ext.create('ExtApp.view.refBook.FormPanel', {
                items: func.paramsFormPanelItems,
                fieldDefaults: {
                    labelAlign: 'left',
                    labelWidth: ExtApp.utils.RefBookUtils.getLabelWidthForPanel(func.paramsFormPanelItems)
                }
            }),
            btnOkProps: {
                handler: function (btn) {
                    var formWindow = btn.up('window');
                    var form = formWindow.down('form').getForm();
                    var inputParams = new Array();
                    //заполняем параметры функции значения которых нужно взять из диалога ввода параметров
                    Ext.each(func.paramsInfo, function (par) {
                        if (par.IsInput == true) {
                            var param = {
                                Name: par.Name,
                                Type: par.Type,
                                //присваиваем значению параметра значение с выбранной строки грида
                                Value: form.findField(par.Name).getValue()
                            }
                            inputParams.push(param);
                            
                            if(par.additionalUse  && par.additionalUse.length)
                                ExtApp.utils.RefBookUtils.buildSaveInPageParamsByAddUse(par.additionalUse,func.saveInPageParams,param);
                        }
                    });
                    if(func.sendByBatch)
                        func.inputParams = inputParams;
                    else
                    //если вызываем для каждой строки то запоминаем параметры только для текущего элемента масива параметров, иначе одни и те же значения заполняются для всего масива
                    if (showForEachRow) {
                        //объединяем параметры которые уже были (брались из строк грида) с введенными в диалоге параметрами 
                        func.params[func.currentParamsInputIndex].rowParams = func.params[func.currentParamsInputIndex].rowParams.concat(inputParams);
                    } else {
                        Ext.each(func.params, function (param) {
                            param.rowParams = param.rowParams.concat(inputParams);
                        });
                    }
                    
                    formWindow.closeAction = 'destroy';
                    var ProcParams = func.params[0].rowParams;
                    if (ProcParams && ProcParams.length > 0 &&
                        Ext.Array.findBy(ProcParams, function (param) { return param.Type == "CLOB" || param.Type == "BLOB"; })) {
                        thisController.executeCurrentSqlFunctionWithUploadFile(func, formWindow);
                        return true;
                    }
                    
                    //закрываем окно
                    formWindow.close();

                    var ProcParams = Ext.JSON.encode(func.params[0].rowParams);
                    window.jsonSqlProcParams = ProcParams;
                    window.CodeOper;
                    //если параметры нужно запрашивать для каждой строки - функция вызывает себя же и заполняет следующий набор параметров
                    if (showForEachRow) {
                        //если вызвали диалог ввода параметров уже столько раз сколько должно быть вызвано функций 
                        if (func.currentParamsInputIndex == func.allFuncCallCount - 1) {
                            //вызываем хендлер, который должен что-то выполнить после ввода и запоминания параметров
                            okBtnHandler();
                        } else {
                            //вызываем диалог ввода параметров для следующей строки
                            func.currentParamsInputIndex++;
                            thisController.showInputParamsDialog(showForEachRow, okBtnHandler);
                        }
                    } else {
                        okBtnHandler();
                    }
                }
            }
        });
    },
    callWebFunctionForeBatchEach: function (status, msg, controller, callbackFunc) {
        
        //увеличиваем счетчик вызванных на выполнение функций
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
            Ext.MessageBox.hide();
            var errorMsg = "";
            //если были ошибки - сортируем лог и заполняем сообщение об ошибках
            if (func.errorLog && func.errorLog.length > 0) {
                errorMsg += "</br>Повідомлення про помилки: ";
            }
            if (!msg)
                msg = "";
            var resMsg = (errorMsg == "") ? msg : errorMsg;
           
                Ext.MessageBox.show({
                    title: func.infoDialogTitle,
                    msg: "Виконання процедур закінчено." + "<br/>" + resMsg + '</br> </br>',
                    buttons: Ext.MessageBox.OK
                });
            

            var grid = controller.getGrid();
            if (grid) {
                grid.store.load();
            }

            if (callbackFunc && func.errorLog.length == 0) {
                callbackFunc();
            }
        //}
    },

    callRefWebFunction: function (status, msg, controller, callbackFunc) {
        
       
        //увеличиваем счетчик вызванных на выполнение функций
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
        func.currentCallIndex++;
        var param = func.params;
        //процедура выполнилась успешно
        if (status == "ok") {
            func.successCallCount++;
        } else {
            func.errorLog.push({ rowIndex: param.rowIndex, errMsg: "</br>" + "Не вдалося виконати процедуру" + (param.rowIndex ? " для рядка №" + (param.rowIndex) : "") + ". " + msg });
        }
        var progress = func.currentCallIndex / func.allFuncCallCount;
        //меняем текущее значение progressbar
        Ext.MessageBox.updateProgress(progress, 'Виконано ' + func.currentCallIndex + " з " + func.allFuncCallCount);
        //если это выполнилась процедура для последней выделенной строки - прячем progressBar и показываем окно об успешном завершении 
        if (func.currentCallIndex == func.allFuncCallCount) {
            Ext.MessageBox.hide();
            var errorMsg = "";
            //если были ошибки - сортируем лог и заполняем сообщение об ошибках
            if (func.errorLog && func.errorLog.length > 0) {
                errorMsg += "</br>Повідомлення про помилки: ";
                Ext.each(func.errorLog.sort(function (a, b) { return a.rowIndex - b.rowIndex; }), function (log) {
                    errorMsg += log.errMsg;
                });
            }
            if (!msg)
                msg = "";
            var resMsg = (errorMsg == "") ? msg : errorMsg;
            if (func.linkWebFormName && func.linkWebFormName != '' && !func.errorLog.length > 0) {
                if (msg != "" && msg != 'Процедура виконана') {
                    Ext.MessageBox.confirm("перехід на сторінку <br>", resMsg, function (btn) {
                        if (btn == 'yes') {
                            window.open(func.linkWebFormName);
                        }
                    });
                }
                else
                    window.open(func.linkWebFormName);
            }
            else {
                Ext.MessageBox.show({
                    title: func.infoDialogTitle,
                    msg: "Виконання процедур закінчено." + "<br/>" + resMsg + '</br> </br>',
                    buttons: Ext.MessageBox.OK,
                    fn: function(btn){
                        
                        if(callbackFunc && typeof (callbackFunc) == 'function')
                        if(errorMsg && errorMsg.length < 1)
                                callbackFunc(true);
                            else
                                callbackFunc(false);


                    }
                });
            }

            var grid = controller.getGrid();
            if (grid) {
                grid.store.load();
            }

        }
    },

    //вызвать sql-функцию, по данным объекта thisController.currentCalledSqlFunction
    executeCurrentSqlFunction: function (callbackFunc) {
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
        if (func.systemParams && func.systemParams.length > 0)
            func.params[func.currentCallIndex].rowParams = func.params[func.currentCallIndex].rowParams.concat(func.systemParams);
        
        if (func.hasFileResult) {
            thisController.executeCurrentSqlFunctionWithOutParams(callbackFunc);
            return true;
        }
        Ext.MessageBox.show({
            title: func.infoDialogTitle,
            msg: 'Зачекайте...',
            width: 300,
            wait: true,
            waitConfig: { interval: 200 },
            progress: true,
            closable: false,
            animateTarget: 'mb6'
        });
        if (func.sendByBatch)
            thisController.sendToServer(
            "/barsroot/ReferenceBook/CallFuncWithMultypleRows",
            {
                codeOper: func.CodeOper, tableId: func.tableId, funcId: func.funcId, listJsonSqlProcParams: Ext.JSON.encode(func.params),
                ColumnId: func.ColumnId, procName: func.funcName, random: Math.random, inputProcParams: Ext.JSON.encode(func.inputParams)
            },
               function (status, msg, controller) {
                   thisController.callWebFunctionForeBatchEach(status, msg, controller, callbackFunc);
               })
        else
        //для наборов параметров (т.к. функция может быть вызвана для нескольких строк с разными параметрами)
 Ext.each(func.params, function (param) {
                thisController.sendToServer(
                "/barsroot/ReferenceBook/CallRefFunction",
                {
                    codeOper: func.CodeOper, tableId: func.tableId, funcId: func.funcId, jsonFuncParams: Ext.JSON.encode(param.rowParams),
                    ColumnId: func.ColumnId, procName: func.funcName, random: Math.random, base64ExternProcParams: func.base64ExternProcParams
                },
               function (status, msg, controller) {
                    
                    var callbackFunc;
                   if (window.hasCallbackFunction && window.hasCallbackFunction.toUpperCase() == 'TRUE' && window.ExternelFuncOnly &&  window.ExternelFuncOnly.toUpperCase() == 'TRUE')
                       callbackFunc =  window.parent.CallBackFunctionOnly;
                   thisController.callRefWebFunction(status, msg, controller, callbackFunc);
               });
            });
    },

    executeSimpleMathFuncs: function () {
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
        var sum = 0;
        Ext.each(func.params, function (item) {
            sum += item.rowParams[0].Value;
        });
        Ext.MessageBox.show({
            title: func.infoDialogTitle,
            msg: func.simpleMsg + '   ' + sum,
            buttons: Ext.MessageBox.OK
        });
    },

    executeCurrentSqlFunctionWithOutParams: function (callbackFunc) {
        
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
        Ext.each(func.params, function (param) {
            thisController.getFileFromServer("/barsroot/ReferenceBook/CallFunctionWithResult/?" + 'tableId=' + func.tableId + '&funcId=' + func.funcId + '&codeOper=' + func.CodeOper +
                '&jsonFuncParams=' + Ext.JSON.encode(param.rowParams) + '&procName=' + func.funcName + '&random=' + Math.random + '&base64ExternProcParams=' + window.base64ExternProcParams);
        });
    },

 getUrlForCallFunc: function (func) {
        var thisController = this;
        var proc = func == null ? thisController.currentCalledSqlFunction : func;
        var exec = proc.PROC_EXEC;
        switch (exec) {
            case 'EACH':
                return "/barsroot/ReferenceBook/CallRefFunction";
            case 'BATCH':
                return "/barsroot/ReferenceBook/CallFuncWithMultypleRows";
            default:
                return false;

        }
    },
    executeCurrentSqlFunctionWithUploadFile: function (functi, formWindow) {
        var form = formWindow.down('form').getForm();
        var thisController = this;
        
        var func = thisController.currentCalledSqlFunction;
        var params = func.params[0].rowParams;
        var fileParam = Ext.Array.findBy(params, function (param) { return param.Type == "CLOB" || param.Type == "BLOB"; });
        if (fileParam && fileParam.Value && form.isValid()) {
            form.submit({
                url: '/barsroot/ndi/ReferenceBook/UploadTemplateFile?fieldFileName=' + fileParam.Name + '&tableId=' + func.tableId + '&funcId=' + func.funcId + '&codeOper=' + func.CodeOper +
            '&jsonFuncParams=' + Ext.JSON.encode(params) + '&procName=' + func.funcName,
                waitMsg: 'завантаження...',
                success: function (form,result) {
                    var msg;
                    var descr;
                    if(result || result.response || result.response.responseText)
                    {
                        var resObj = Ext.JSON.decode(result.response.responseText);
                        if(resObj.success === 'true')
                        {
                            msg = resObj.resultMessage;
                            descr = 'Файл завантажен';
                            formWindow.close();
                        }
                        else
                        {
                            msg = resObj.resultMessage;
                            descr = 'Файл не завантажено';
                        }
                    }
                    else {
                        msg = 'повідомлення не в потрібному форматі';
                        descr = 'помилка відповіді від сервера';
                    }
                    Ext.Msg.alert(descr, msg);
                },
                failure:function(form,result) {
                    var msg;
                    var descr = 'помилка відповіді від сервера';
                    if(result && result.response && result.response.responseText)
                       msg = result.response.responseText
                    else
                        msg = 'повідомлення не в потрібному форматі';
                    Ext.Msg.alert(descr, msg)
                }
            });
        }
    },
    setSystemParams: function (callbackFunc) {
        
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
        if (func.systemParamsInfo && func.systemParamsInfo.length > 0)
            Ext.each(func.systemParamsInfo, function (param) {

                switch (param.Name) {
                    case 'P_FILTER_STRING':
                        var value = thisController.getApplyFilters(true);
                        func.systemParams.push({
                            Name: param.Name,
                            Type: param.Type,
                            Value: value
                        }
                            );
                        break;
                    default:
                        break;
                }
            }

            )

    },
    //тип фильтра для колонки грида
    getFilterType: function (codeType) {
        switch (codeType) {
            case "N":
                return 'numeric';
            case "E":
                return 'numeric';
            case "B":
                return 'boolean';
            case "D":
                return 'date';
            default:
                return 'string';
        }
    },

    //тип поля для модели колонок грида
    getFieldType: function (codeType) {
        switch (codeType) {
            case "C":
                return 'string';
            case "N":
                return 'float';
            case "E":
                return 'float';
            case "B":
                return 'bool';
            case "D":
                return 'date';
            default:
                return 'string';
        }
    },

    getFormFieldType: function (codeType) {
        switch (codeType) {
            case "C":
                return 'textfield';
            case "N":
                return 'numberfield';
            case "D":
                return 'datefield';
        }
    },

    //рассчитать ширину колонки на основе значения в META_COLUMNS.SHOWWIDTH
    calcColWidth: function (showWidth) {
        //магический расчет ширины - взято из прошлых справочников + помножено на 96 для перевода в пиксели
        if (showWidth) {
            var sizeInches = showWidth / 1.5;
            if (sizeInches < 0.5) {
                sizeInches = 0.5;
            }
            var sizePixels = sizeInches * 96;
            return sizePixels;
        } else {
            return 1.15 * 96;
        }
    }
});