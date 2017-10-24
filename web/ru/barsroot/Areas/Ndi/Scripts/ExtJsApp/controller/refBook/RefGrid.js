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
        { ref: 'ViewInfo', selector: 'referenceGrid toolbar button#ViewInfo' }
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
                beforeitemdblclick: this.onbeforeitemdblclick
            },
            "GridCustomFilter": {
                checkchange: this.onCellclick,
                selectionchange: this.onSelectionFilterChange
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
            "referenceGrid pagingtoolbar button#applyFilterButton": {
                click: this.onapplyFilterButtonClick
            },
            "GridCustomFilter toolbar button#removeFilterButton": {
                click: this.onremoveFilterButtonClick
            },
            "GridCustomFilter toolbar button#whereClauseButton": {
                click: this.onwhereClauseButtonClick
            },
            "GridCustomFilter pagingtoolbar button#applyCustomFilter": {
                click: this.onapplyCustomFilter
            },
            "referenceGrid2 pagingtoolbar button#applySystemFilter": {
                click: this.onapplySystemFilter
            },
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
        var href;
        var IterIndex = referenceGrid.metadata.hasCheckBoxSelectColumn ? 1 : 0;
        var dataRowArray = ExtApp.utils.RefBookUtils.buildRowToArray(record, referenceGrid.metadata.columnsInfo);
        Ext.each(referenceGrid.metadata.columnsInfo,
        function (col) {
            if (col.NOT_TO_SHOW != 1) {
                var params = new Array();
                IterIndex++;
                if (cellIndex == IterIndex && col.WEB_FORM_NAME != null && col.WEB_FORM_NAME != "" && col.WEB_FORM_NAME != undefined) {
                    if (col.WEB_FORM_NAME.indexOf(":") > 0) {
                        Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                            if (col.WEB_FORM_NAME.indexOf(":" + item.COLNAME) > 0) {
                                var field = {};
                                field.Name = item.COLNAME;
                                field.Type = item.COLTYPE;
                                field.Value = record.data[item.COLNAME];
                                params.push(field);
                            }
                        }
                        )
                    }
                    if (Ext.Array.findBy(params, function (param) { return param.Value == "" }))
                        return false;
                    href = col.WEB_FORM_NAME;

                    if (href.indexOf("barsroot/ndi/referencebook") < 0) {
                        if (href.indexOf(":") > 0) {
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
                        if (href.indexOf('OpenInTab=1') > 0)
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
                        var decodURI = decodeURIComponent(col.WEB_FORM_NAME);
                        var paramsString = Ext.JSON.encode(params);

                        // var bas64Params = Base64.encode(paramsString);
                        var WEB_NAME = col.WEB_FORM_NAME + "&jsonSqlParams=" + paramsString;
                        //debugger;
                        if (col.IsFuncOnly && col.IsFuncOnly == true && col.FunctionMetaInfo) {
                            var func = col.FunctionMetaInfo;
                            func.jsonSqlProcParams = paramsString;
                            func.dataRowArray = dataRowArray;
                            thisController.callSqlFunction(func);

                            //thisController.callSqlFunction(func);
                            //window.location = WEB_NAME;
                        }
                        else {
                            var width = Ext.getBody().getViewSize().width * 1.02;
                            var height = Ext.getBody().getViewSize().height * 0.98;
                            var params = 'width=' + width + ',' + 'height=' + height + ',' + 'scrollbars=1' + ',' + 'left=5,top=10';
                            window.open(WEB_NAME, '_blank', params);
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
                }
            }
        }
    )

    },
    onbeforeitemdblclick: function (record, item, index, e, eOpts) {
        if (window.hasCallbackFunction && window.hasCallbackFunction.toUpperCase() == 'TRUE')
            window.parent.CallFunctionFromMetaTable(item.data);

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
        //при редактировании запретить редактировать NOT_TO_EDIT колонки, а при добавлении разрешить
        Ext.each(e.grid.metadata.columnsInfo, function () {
            if (this.NOT_TO_EDIT == 1) {
                var editorField = rowEditing.editor.form.findField(this.COLNAME);
                if (editorField) {
                    //if (e.record.phantom) {
                    //    editorField.enable();
                    //} else {
                    //    editorField.disable();
                    //}
                    editorField.disable();
                }
            }
        });
    },

    //вызывается при нажатии на кнопку "Зберегти" но до записи данных в строку на клиенте. 
    onValidateEdit: function (rowEditing, e) {
    },

    //метод вызывается при нажатии на кнопку "Зберегти" в плагине RowEditing
    onEdit: function (rowEditing, e) {
        //для редактирования/добавления передаем новые и старые значения а также признаки phantom, dirty
        var values = e.record.data;
        var modified = e.record.modified;
        var isPhantom = e.record.phantom;
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
        var rowEditing = grid.getPlugin('rowEditPlugin');

        var store = grid.getStore();
        //если есть добавленая пустая запись в начале грида - удаляем сначала её
        var firstRow = store.getAt(0);
        if (firstRow && firstRow.phantom) {
            store.removeAt(0);
        }
        //добавили в store пустую запись
        var emptyModel = this.getModel('refBook.RefGrid');
        store.insert(0, emptyModel);

        //перешли на редактирование новой записи
        rowEditing.startEdit(0, 0);
    },

    onSampleBtnClick: function (button, e) {
        //нашли грид и плагин rowEditing
        var grid = button.up('referenceGrid');
        var rowEditing = grid.getPlugin('rowEditPlugin');

        var store = grid.getStore();
        //получаем выбранную строку грида
        var selectedRow = grid.getSelectionModel().getSelection()[0];

        //если есть добавленая пустая запись в начале грида - удаляем сначала её
        if (store.getAt(0).phantom) {
            store.removeAt(0);
        }
        //добавили в store запись с такими же данными как у текущей выделенной строки
        store.insert(0, selectedRow.data);

        //перешли на редактирование новой записи
        rowEditing.startEdit(0, 0);
    },

    onRemoveBtnClick: function (button, e) {
        var thisController = this;
        Ext.MessageBox.confirm('Видалення рядка', 'Ви впевнені що хочете видалити рядок таблиці?', function (btn) {
            if (btn == 'yes') {
                var grid = button.up('referenceGrid');
                //получаем выбранную строку грида
                var selectedRow = grid.getSelectionModel().getSelection()[0];

                //если нажали удалить при редактировании только что добавленной строки
                if (selectedRow.phantom) {
                    grid.getPlugin('rowEditPlugin').cancelEdit();
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
        if (sampleButton != null && sampleButton != undefined && metadata.canInsert()) {
            sampleButton.setDisabled(!records.length);
        }
        var formViewButton = this.getFormViewButton();
        if (formViewButton != null && formViewButton != undefined && metadata.canUpdate())
            formViewButton.setDisabled(!records.length);
        var ViewInfo = this.getViewInfo();
        if (ViewInfo) {
            ViewInfo.setDisabled(!records.length);
        }
    },

    onSelectionFilterChange: function (rowmodel, records) {
        // var filtert = records[0].data['IsApplyFilter'] = 1;
        //enabled кнопок "Додати за зразком", "Видалити", "Рядок вертикально" если выбрана строка
        //TODO: может слишком затратно
        var grid = rowmodel.views[0].panel;
        var removeButton = Ext.ComponentQuery.query('GridCustomFilter button#removeFilterButton')[0];
        var whereClauseButton = Ext.ComponentQuery.query('GridCustomFilter button#whereClauseButton')[0];
        removeButton.setDisabled(false);
        whereClauseButton.setDisabled(false);
        //var sampleButton = Ext.ComponentQuery.query('GridCustomFilter button#filterWhere')[0]; 
        //sampleButton.setDisabled(false);

        //var formViewButton = this.getFormViewButton();
        //formViewButton.setDisabled(false);
    },
    //нажатие на кнопку отмены всех фильтров
    onClearFilterClick: function (button, e) {
        var filterGrid = Ext.getCmp('DynamicFiltersGridId');
        var CustonfilterGrid = Ext.getCmp('CustomFilterGrid');
        var SystemFilterGrid = Ext.getCmp('SystemFiltersGridId');
        var inputFilterRow = Ext.dom.Query.select('.x-form-field');
        for (var i = 0; i < inputFilterRow.length; i++) {
            var inputClass = Ext.get(inputFilterRow[i]).dom.className.replace('  ', ' ');
            if (inputClass != 'x-form-field x-form-required-field x-form-text x-trigger-noedit') {
                inputFilterRow[i].value = '';
            }
        }
        var thisController = this;
        var controllerMetadata = thisController.controllerMetadata;
        if (controllerMetadata.clause) {
            controllerMetadata.clause = "";
        }

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

        if (SystemFilterGrid && SystemFilterGrid.store.data.items && SystemFilterGrid.store.data.items.length > 0) {
            Ext.each(SystemFilterGrid.store.data.items, function (col) {
                col.data['IsApplyFilter'] = 0;
            });
            if (SystemFilterGrid.getView())
                try {
                    SystemFilterGrid.getView().refresh();
                } catch (e) {
                    if (e.number != '-2146823281')
                        throw e;
                }
        }

        if (CustonfilterGrid && CustonfilterGrid.store.data.items && CustonfilterGrid.store.data.items.length > 0) {
            Ext.each(CustonfilterGrid.store.data.items, function (col) {
                col.data['IsApplyFilter'] = 0;
            });
            if (CustonfilterGrid.getView())
                try {
                    CustonfilterGrid.getView().refresh();
                } catch (e) {
                    if (e.number != '-2146823281')
                        throw e;
                }
        }

        var proxy = this.getGrid().store.getProxy();
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
                            ;
                            grid.store.load();
                        }
                    });
            }
        });
    },

    onwhereClauseButtonClick: function (button, e) {
        var grid = button.up('grid');
        var selectedRow = grid.getSelectionModel().getSelection()[0];
        var WHERE_CLAUSE = selectedRow.data['WHERE_CLAUSE'];
        Ext.MessageBox.show({ title: 'умови фільтра', msg: WHERE_CLAUSE, buttons: Ext.MessageBox.OK });
    },

    onapplyFilterButtonClick: function (button, e) {
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        var metadata = referenceGrid.metadata;
        //metadata.startFilter = [];

        // var formFields = [];
        //var CustomFilters = [];
        //если есть информация о начальных фильтрах
        if (metadata.filtersMetainfo.CustomFilters && metadata.filtersMetainfo.CustomFilters.length > 0
            || metadata.filtersMetainfo.SystemFilters && metadata.filtersMetainfo.SystemFilters.length > 0) {
            thisController.showBeforeFilterDialog(metadata, referenceGrid);
        } else {
            referenceGrid.store.reload();
        }
    },

    onViewInfo: function (button) {
        this.onFormViewBtnClick(button);

       // var winTitle = "Інформація";
       // var thisController = this;
       // var referenceGrid = thisController.getGrid();
       // var selectedRow = referenceGrid.getSelectionModel().getSelection()[0];
       // var item = 0;
       // var colObjects = [];
       //// selectedRow.data = ExtApp.utils.RefBookUtils.convertDataRerordByFields(selectedRow.data, selectedRow.fields);

       // Ext.iterate(selectedRow.data, function (key, value) {
       //     colObjects.push({
       //         xtype: 'displayfield',
       //         value: key + " - " + value
       //     });
       // });
       // var win = new Ext.Window({
       //     title: "info",
       //     border: false,
       //     minWidth: 600,
       //     minHeight: 200,
       //     maxWidth: 1000,
       //     maxHeight: 600,
       //     autoScroll: true,
       //     layout: 'fit',
       //     items: [
       //         new Ext.form.FormPanel({
       //             frame: true,
       //             autoScroll: true,
       //             items: { items: colObjects }
       //         })
       //     ]
       // });
       // win.show();
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
            controllerMetadata.tabPanel.setActiveTab(3)
        var filterGrid = Ext.getCmp('CustomFilterGrid');
        if (filterGrid && filterGrid != '' && filterGrid != 'undefined' && filterGrid.store != 'undefined')
            filterGrid.store.reload();
    },

    saveFilterBtnHandler: function (filterNameParam, saveInBD, items, whereClause) {
        var thisController = this;
        var clause = null;
        // var jsonParam = Ext.JSON.encode(param.Name);
        var params = items && items != '' && items.length ? items : new Array();
        //if (items && items.length > 0)
        //    Ext.each(items, function (item) {
        //        var param = {};
        //        param.LogicalOp = item.data['LogicalOp'];
        //        param.Colname = item.data['Colname'];
        //        param.ReletionalOp = item.data['ReletionalOp'];
        //        param.Value = item.data['Value'];
        //        //param.Semantic = item.data['Semantic'];
        //        params.push(param);
        //    })
        //else
        if (whereClause && whereClause != '')
            clause = whereClause;
        Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
        var pars = Ext.JSON.encode(params);
        thisController.sendToServer(
            "/barsroot/ReferenceBook/InsertFilter",
            { tableId: thisController.controllerMetadata.tableInfo.TABID, tableName: thisController.controllerMetadata.tableInfo.TABNAME, parameters: pars, filterName: filterNameParam.value, saveFilter: saveInBD, clause: clause },
              function (status, msg) {
                  var title;
                  if (saveInBD == 1)
                      title = 'збереження';
                  if (saveInBD == 0)
                      title = filterNameParam.value + '  додано до динамічних фильтрів';
                  //обработка при удачном запросе на сервер
                  Ext.MessageBox.hide();
                  Ext.MessageBox.show({ title: title, msg: msg + '</br> </br>', buttons: Ext.MessageBox.OK });
                  if (status == "ok") {
                      if (saveInBD == 1) {
                          var filterGrid = Ext.getCmp('CustomFilterGrid');
                          if (filterGrid && filterGrid != '' && filterGrid.store)
                              filterGrid.store.reload();
                          else
                              thisController.addUserFilerTab();
                      }
                      if (saveInBD == 0) {
                          var data = { IsApplyFilter: true, FilterName: filterNameParam.value, Where_clause: msg }
                          thisController.addDynamicFilterHandler(data, '');
                      }
                      //перечитка данных грида

                  }

              });
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


        var titleMsg = 'Виконання процедури' + funcMetaInfo.DESCR;
        //если заполнен вопрос который нужно задать перед выполнением процедуры
        if (funcMetaInfo.QST && funcMetaInfo.PROC_EXEC != 'EACH') {
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
        if (funcMetaInfo.QST && funcMetaInfo.PROC_EXEC != 'EACH') {
            Ext.MessageBox.confirm(titleMsg, funcMetaInfo.QST, function (btn) {
                if (btn == 'yes') {
                    thisController.callSqlFunction(funcMetaInfo);
                }
            });
        } else {
            thisController.callSqlFunction(funcMetaInfo);
        }
    },

    ////////////////////////////////////////////вспомогательные функции (не обработчики событий)


    onapplyCustomFilter: function (button, e) {
        controllerMetadata.CustomBeforeFilters = [];
        controllerMetadata.startFilter = [];
        var mainGrid = controllerMetadata.mainGrid;
        var referenceGrid = button.up('grid');
        referenceGrid.getStore().each(function (record) {
            if (record.data['IsApplyFilter'] == 1)
                controllerMetadata.CustomBeforeFilters.push({
                    //к имени поля добавляем имя таблицы
                    FILTER_ID: record.data['FILTER_ID']
                });
        });
        if (mainGrid && controllerMetadata.CustomBeforeFilters.length > 0) {
            Ext.each(controllerMetadata.CustomBeforeFilters, function (filter) {
                controllerMetadata.startFilter.push(filter);
            });
            controllerMetadata.startFilter = Ext.encode(controllerMetadata.startFilter);
            mainGrid.store.getProxy().extraParams.startFilter = controllerMetadata.startFilter;
            mainGrid.store.reload();
        }
    },
    updateGridByFilters: function () {
        var thisController = this;
        var controllerMetadata = thisController.controllerMetadata;
        controllerMetadata.startFilter = [];
        if (controllerMetadata.CustomBeforeFilters && controllerMetadata.CustomBeforeFilters.length > 0)
            Ext.each(controllerMetadata.CustomBeforeFilters, function (filter) {
                controllerMetadata.startFilter.push(filter)
            });
        if (controllerMetadata.SystemBeforeFilters && controllerMetadata.SystemBeforeFilters.length > 0)
            Ext.each(controllerMetadata.SystemBeforeFilters, function (filter) {
                controllerMetadata.startFilter.push(filter)
            });
        controllerMetadata.startFilter = Ext.encode(controllerMetadata.startFilter);
        controllerMetadata.dynamicFilter = Ext.encode(thisController.controllerMetadata.DynamicBeforeFilters);
        controllerMetadata.mainGrid = Ext.getCmp('mainReferenceGrid');
        if (controllerMetadata.mainGrid) {
            controllerMetadata.mainGrid.store.getProxy().extraParams.startFilter = controllerMetadata.startFilter;
            controllerMetadata.mainGrid.store.getProxy().extraParams.dynamicFilter = controllerMetadata.dynamicFilter;
            controllerMetadata.mainGrid.store.getProxy().extraParams.isReserPages = true;
            controllerMetadata.mainGrid.store.reload();
        }
        else {
            controllerMetadata.mainGrid = Ext.create('ExtApp.view.refBook.RefGrid', { metadata: controllerMetadata });
        }
        this.controllerMetadata = controllerMetadata;
    },
    onapplySystemFilter: function (button, e) {
        controllerMetadata.SystemBeforeFilters = [];
        var thisController = this;
        var referenceGrid = button.up('grid')
        referenceGrid.getStore().each(function (record) {
            if (record.data['IsApplyFilter'] == 1)
                controllerMetadata.SystemBeforeFilters.push({
                    //к имени поля добавляем имя таблицы
                    FILTER_ID: record.data['FILTER_ID']
                });
        });
    },
    controllerMetadata: function () {
        CustomBeforeFilters = [];
        startFilter = [];
    },

    showBeforeFilterDialog: function (metadata, referenceGrid) {
        var thisController = this;
        metadata = thisController.setAccessLevel(metadata);
        thisController.controllerMetadata = metadata;
        thisController.controllerMetadata.startFilter = [];
        thisController.controllerMetadata.CustomBeforeFilters = [];
        thisController.controllerMetadata.SystemBeforeFilters = [];
        //var sympleFilterColumnsInfo = metadata.columnsInfo

        var controllerMetadata = thisController.controllerMetadata;
        controllerMetadata.thisController = thisController;
        var formFields = [];
        window.StringColumnModel = controllerMetadata.filtersMetainfo.StringColumnModel;
        var hasCustomFilter = controllerMetadata.filtersMetainfo.CustomFilters && controllerMetadata.filtersMetainfo.CustomFilters.length > 0;
        var hasSystemFilter = controllerMetadata.filtersMetainfo.SystemFilters && controllerMetadata.filtersMetainfo.SystemFilters.length > 0;
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
                       title: 'динамічні фільтри',
                       items: Ext.create('ExtApp.view.refBook.DynamicFiltersGrid', { thisController: thisController }),
                       minHeight: 100,
                       width: '100%',
                       maxHeight: 600
                   });
            tab.add(
             {
                 title: 'Конструктор фільтрів',
                 items: Ext.create('ExtApp.view.refBook.ConstructorFiltersGrid', { thisController: thisController }),
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
                maxHeight: 600
            });
            //показываем диалог
            var wind = Ext.create('ExtApp.view.refBook.FilterWindow', {
                minWidth: 600,
                minHeight: 400,
                maxWidth: 800,
                maxHeight: 800,
                title: "Фільтр перед населенням таблиці",
                items: tab,
                controllerMetadata: controllerMetadata,
                // Ext.create('ExtApp.view.refBook.RefGridCustomFilter', { metadata: metadata }), //Ext.create('ExtApp.view.refBook.FormPanel', {
                //    fieldDefaults: { labelWidth: 700 }, items: formFields
                //}),
                btnOkProps: {
                    handler: function (btn) {
                        var myWindow = btn.up('window');
                        if (true) {
                            //Ext.each(controllerMetadata.CustomBeforeFilters, function (filter) {
                            //    controllerMetadata.startFilter.push(filter)
                            //});
                            //Ext.each(controllerMetadata.SystemBeforeFilters, function (filter) {
                            //    controllerMetadata.startFilter.push(filter)
                            //});
                            var win = document.getElementById('myEditWindow');
                            var constructor = Ext.getCmp('ConstructorGrid');
                            var store = constructor.getStore();
                            var items = store.data.items;
                            var params = new Array();
                            var sympleFilterRows;
                            Ext.each(items, function (item) {
                                var param = {};
                                param.LogicalOp = item.data['LogicalOp'];
                                param.Colname = item.data['Colname'];
                                param.ReletionalOp = item.data['ReletionalOp'];
                                param.Value = item.data['Value'];
                                //param.Semantic = item.data['Semantic'];
                                params.push(param);
                            })
                            var filterName = 'складний фільтр1';
                            //debugger;
                            var form = wind.down('form').getForm();
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
                                filterName = 'простий фльтр1'
                            }


                            Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' + '</br></br>', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
                            var pars = Ext.JSON.encode(params);
                            if (params && params.length > 0)
                                thisController.sendToServer(
                                    "/barsroot/ReferenceBook/InsertFilter",
                                    { tableId: thisController.controllerMetadata.tableInfo.TABID, tableName: thisController.controllerMetadata.tableInfo.TABNAME, filterName: filterName, parameters: pars, saveFilter: 0 },
                                      function (status, msg, controller) {
                                          //обработка при удачном запросе на сервер
                                          thisController.controllerMetadata.buttonFilterOk;
                                          if (status == 'ok') {
                                              //перечитка данных грида
                                              var clause = msg;
                                              thisController.controllerMetadata.clause = clause;
                                              if (window.getFiltersOnly && window.getFiltersOnly.toUpperCase() == 'TRUE' && window.parent.CallFunctionFromMetaTable) {
                                                  thisController.returnFiltersForExtApp();
                                                  return;
                                              }

                                              if (clause && clause != '') {
                                                  thisController.addDynamicFilterHandler('', clause, filterName);
                                              }
                                              Ext.MessageBox.hide();
                                              myWindow.close();
                                              controllerMetadata.tabPanel = tab;
                                              thisController.updateGridByFilters();
                                          }
                                          else {
                                              Ext.Msg.show({ title: "Помилка при формуванні фільтра", msg: msg + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                                              return false;
                                          }

                                      });
                            else {
                                if (window.getFiltersOnly && window.getFiltersOnly.toUpperCase() == 'TRUE' && window.parent.CallFunctionFromMetaTable) {
                                    thisController.returnFiltersForExtApp();
                                    return;
                                }
                                Ext.MessageBox.hide();
                                myWindow.close();
                                controllerMetadata.tabPanel = tab;
                                thisController.updateGridByFilters();
                            }



                        }
                    }
                }
            });

            var win = document.getElementById('myEditWindow');
            tab.setActiveTab(3);
            tab.setActiveTab(2);
            wind.setSize(500, 400);
            tab.setActiveTab(1);
            tab.setActiveTab(0);
        } else {
            Ext.create('ExtApp.view.refBook.RefGrid', { metadata: controllerMetadata });
        }
    },


    writeFilter: function (saveInBD, items, whereClause, typeFilterDiscr) {
        // Create a model instance
        var thisController = this;
        var parArray = new Array();
        var parInput = {
            fieldLabel: 'назва фільтра',
            name: 'filterName',
            xtype: 'textfield',
            text: typeFilterDiscr
        };
        parArray.push(parInput);
        var wind = Ext.create('ExtApp.view.refBook.NameWindow', {
            itemId: "CreateFilterWindow",
            title: 'введіть назву фільтра',
            items: Ext.create('ExtApp.view.refBook.FormPanel', { items: parArray }),
            width: 550,
            height: 200,
            btnOkProps: {
                handler: function (btn) {
                    var formWindow = btn.up('window');
                    var form = formWindow.down('form').getForm();
                    var param = {
                        Name: 'filterName',
                        value: form.findField('filterName').getValue()
                    }
                    formWindow.close();
                    thisController.saveFilterBtnHandler(param, saveInBD, items, null);
                }
            }
        });
    },

    returnFiltersForExtApp: function () {
        var thisController = this;
        var filterString = '';
        var filtersArray = new Array();
        var clause = thisController.controllerMetadata.clause;
        Ext.each(thisController.controllerMetadata.CustomBeforeFilters, function (item) {
            filtersArray.push(item.WHERE_CLAUSE);
        })
        Ext.each(thisController.controllerMetadata.SystemBeforeFilters, function (item) {
            filtersArray.push(item.WHERE_CLAUSE);
        })

        Ext.each(thisController.controllerMetadata.DynamicBeforeFilters, function (item) {
            if (clause != item.WHERE_CLAUSE)
                filtersArray.push(item.WHERE_CLAUSE);
        })
        if (clause && clause != '')
            filtersArray.push(clause);
        // var arr = filtersArray.join(' and ');
        if (window.parent && window.parent.CallFunctionFromMetaTable)
            window.parent.CallFunctionFromMetaTable(filtersArray);
    },

    addDynamicFiltersTub: function (row, clause, filterName) {
        var thisController = this;
        var controllerMetadata = thisController.controllerMetadata;
        controllerMetadata.thisController = thisController;
        var tab = Ext.getCmp('tabFilterPanel');
        var windTube = Ext.getCmp('filterWindowTabPanel');

        controllerMetadata.tabPanel = tab ? tab : windTube;
        controllerMetadata.tabPanel.add(
                   {
                       id: 'dynamicFilterTab',
                       title: 'динамічні фільтри',
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
        if (filterGrid && filterGrid.store)
            thisController.insertDynamicFilterInGrid(row, clause, filterName);
    },

    addDynamicFilterHandler: function (row, clause, filterName) {
        var thisController = this;
        var filterGrid = Ext.getCmp('DynamicFiltersGridId');
        if (filterGrid && filterGrid != '' && filterGrid.store) {
            this.insertDynamicFilterInGrid(row, clause, filterName);
        }
        else {
            this.addDynamicFiltersTub(row, clause, filterName);
        }

    },

    insertDynamicFilterInGrid: function (row, clause, filterName) {
        var thisController = this;
        var filterGrid = Ext.getCmp('DynamicFiltersGridId');
        if (!filterGrid)
            return false;
        thisController.controllerMetadata.DynamicBeforeFilters = [];
        if (row && row != '')
            filterGrid.store.insert(0, row);
        if (clause && clause != '') {
            var items = filterGrid.getStore().data.items;
            var item = Ext.Array.findBy(items, function (i) { return i.Where_clause == clause });
            if (!item) {
                filterGrid.store.insert(0, { IsApplyFilter: true, FilterName: filterName, Where_clause: clause });
            }
        }
        filterGrid.getStore().each(function (record) {
            if (record.data['IsApplyFilter'] == 1)
                thisController.controllerMetadata.DynamicBeforeFilters.push({
                    //к имени поля добавляем имя таблицы
                    WHERE_CLAUSE: record.data['Where_clause']
                });
        });
        thisController.controllerMetadata.mainGrid = Ext.getCmp('mainReferenceGrid');
        if (thisController.controllerMetadata.mainGrid)
            thisController.updateGridByFilters();
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
                var updatableRowKeys = new Array();
                //поля которые были отредактированы
                var updatableRowData = new Array();
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
                    updatableRowKeys.push(keyField);

                    //если значение изменилось (есть в массиве измененных значений) то добавляем в список update field1=val1, field2=val2...
                    if (modified[this.COLNAME] !== undefined) {
                        var dataField = {};
                        dataField.Name = this.COLNAME;
                        dataField.Type = this.COLTYPE;
                        dataField.Value = values[this.COLNAME];
                        updatableRowData.push(dataField);
                    }
                });

                Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...' + '</br></br>', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
                thisController.sendToServer(
                    "/barsroot/ReferenceBook/UpdateData",
                    {
                        jsonUpdatableRowKeys: Ext.JSON.encode(updatableRowKeys),
                        jsonUpdatableRowData: Ext.JSON.encode(updatableRowData),
                        tableId: referenceGrid.metadata.tableInfo.TABID,
                        tableName: referenceGrid.metadata.tableInfo.TABNAME,
                        random: Math.random
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
            params: params,
            success: function (conn, resp) {
                var response = Ext.decode(conn.responseText);
                if (afterRequestFunction) {
                    afterRequestFunction(response.status, response.msg, thisController);
                }
            },
            failure: function (conn, response) {
                //обработка при неудачном запросе на сервер
                Ext.Msg.show({ title: "Виникли проблеми при з'єднанні з сервером", msg: conn.responseText + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
            }
        });
    },

    getFileFromServer: function (url) {
        window.location = url;
    },

    onExportToExcelBtnClick: function (menu, item) {
        var grid = menu.up('referenceGrid');
        columnsVisible = [];
        Ext.each(grid.columns, function (column, index) {
            if (column.isHidden()) {
                columnsVisible.push(column.dataIndex);
            }
        });
        //В зависимости от выбранного пункта меню загружаем всю таблицу либо только текущую страницу
        var pageSize = grid.store.pageSize;
        var start = ((grid.store.currentPage - 1) * grid.store.pageSize);
        if (item.allPages) {
            start = 0;
            pageSize = 99999;
        }
        var metaData = {
            tableInfo: grid.metadata.tableInfo
        };
        metaData.columnsInfo = [];
        var sort = grid.store.sorters.items;

        var oper = new Ext.data.Operation();
        grid.store.fireEvent('BeforeLoad', grid.store, oper);

        window.open("/barsroot/ReferenceBook/ExportToExcel?" +
            "tableId=" + grid.metadata.tableInfo.TABID +
            "&tableName=" + grid.metadata.tableInfo.TABNAME +
            "&gridFilter=" + oper.params.gridFilter +
            "&startFilter=" + grid.store.proxy.extraParams.startFilter +
            "&dynamicFilter=" + grid.store.proxy.extraParams.dynamicFilter +
            "&columnsVisible=" + columnsVisible +
            "&externalFilter=" + grid.store.proxy.extraParams.externalFilter +
            "&fallDownFilter=" + grid.store.proxy.extraParams.fallDownFilter +
            "&sort=" + Ext.encode(sort) +
            "&start=" + start +
            "&limit=" + pageSize +
            "&CodeOper=" + window.CodeOper + "&nativeTabelId=" + window.nativeTabelId +
            "&sParColumn=" + window.sParColumn + "&nsiTableId=" + window.nsiTableId +
            "&nsiFuncId=" + window.nsiFuncId + "&executeBeforFunc=" + window.executeBeforFunc +
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
        thisController.fillCallFuncInfo(funcMetaInfo);
        var func = thisController.currentCalledSqlFunction;
        switch (funcMetaInfo.PROC_EXEC) {
            //выполнение процедуры один раз, параметры не берутся из данных грида, а либо константы либо вводятся вручную
            case "ONCE":
                {
                    func.infoDialogTitle = 'Виконання процедури: ' + funcMetaInfo.DESCR;
                    //для ONCE заполняем единожды параметры в диалоге и вызываем функцию (из строк грида никакие данные не берутся)
                    func.params.push({ rowIndex: null, rowParams: new Array() });
                    if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                        thisController.showInputParamsDialog(false, function () {
                            thisController.executeCurrentSqlFunction();
                        })
                    else
                        thisController.executeCurrentSqlFunction();
                    break;
                }
                //выполнение процедуры для каждой выделенной строки
            case "EACH":
                {
                    //получаем собственно выбранные строки
                    selectedRows = gridSelectModel.getSelection();
                    func.allFuncCallCount = selectedRows.length;
                    func.infoDialogTitle = 'Виконання процедури для вибранних рядків';
                    var qst = funcMetaInfo.QST;
                    var descr = funcMetaInfo.DESCR;

                    //если пользователь не выбрал строк
                    if (selectedRows.length == 0) {
                        Ext.MessageBox.show({
                            title: func.infoDialogTitle,
                            msg: "Не вибрано жодного рядка",
                            buttons: Ext.MessageBox.OK
                        });
                        return;
                    }
                    if (qst) {
                        var selectRow = selectedRows[0];
                        if (descr)
                            if (descr.indexOf(":") > 0) {
                                var thisController = this;
                                var referenceGrid = thisController.getGrid();
                                Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                                    var par = ':' + item.COLNAME;
                                    descr = descr.replace(par, selectRow.data[item.COLNAME]);
                                });

                            }
                        if (qst.indexOf(":") > 0) {
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
                }
                break;
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
                    //для ONCE заполняем единожды параметры в диалоге и вызываем функцию (из строк грида никакие данные не берутся)
                    func.params.push({ rowIndex: null, rowParams: new Array() });
                    var qst = funcMetaInfo.QST;
                    if (qst) {
                        //if (funcMetaInfo.QST.indexOf(":") > 0)
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
                    else
                    {
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
                    var selectRow = selectedRows[0];
                    var params = new Array();
                    //заполняем параметры функции значения которых нужно взять из текущей строки грида
                    if (referenceGrid.metadata.columnsInfo && !selectRow) {
                        Ext.Msg.show({ title: "Не вибрано жодного рядка", msg: "оберіть будь ласка рядок для обробки даних" + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                        return;
                    }

                    Ext.each(funcMetaInfo.ParamsInfo, function (par) {
                        Ext.each(referenceGrid.metadata.columnsInfo, function (item) {
                            if (item.COLNAME == par.ColumnInfo.COLNAME || (funcMetaInfo.ConditionParamNames && Ext.Array.contains(funcMetaInfo.ConditionParamNames, item.COLNAME))) {
                                var field = {};
                                field.Name = item.COLNAME;
                                field.Type = item.COLTYPE;
                                field.SEMANTIC = item.SEMANTIC;
                                field.Value = selectRow.data[par.ColumnInfo.COLNAME]
                                params.push(field);
                            }
                        })

                    });
                    var emptyParam = Ext.Array.findBy(params, function (param) { return param.Value == "" });
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
                    var bas64Params = Base64.encode(paramsString);
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
                    var gridSelectModel = referenceGrid.getSelectionModel();
                    var selectedRows = gridSelectModel.getSelection();
                    //если в гриде вообще нет строк с данными
                    if (selectedRows.length == 0) {
                        Ext.MessageBox.show({
                            title: func.infoDialogTitle,
                            msg: "Не вибрано жодного рядка",
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
                                field.Value = selectRow.data[parName]
                                params.push(field);
                            }
                        })

                    });
                    var emptyParam = Ext.Array.findBy(params, function (param) { return param.Value == "" });
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
                    var Base64 = { _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=", encode: function (e) { var t = ""; var n, r, i, s, o, u, a; var f = 0; e = Base64._utf8_encode(e); while (f < e.length) { n = e.charCodeAt(f++); r = e.charCodeAt(f++); i = e.charCodeAt(f++); s = n >> 2; o = (n & 3) << 4 | r >> 4; u = (r & 15) << 2 | i >> 6; a = i & 63; if (isNaN(r)) { u = a = 64 } else if (isNaN(i)) { a = 64 } t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a) } return t }, decode: function (e) { var t = ""; var n, r, i; var s, o, u, a; var f = 0; e = e.replace(/[^A-Za-z0-9+/=]/g, ""); while (f < e.length) { s = this._keyStr.indexOf(e.charAt(f++)); o = this._keyStr.indexOf(e.charAt(f++)); u = this._keyStr.indexOf(e.charAt(f++)); a = this._keyStr.indexOf(e.charAt(f++)); n = s << 2 | o >> 4; r = (o & 15) << 4 | u >> 2; i = (u & 3) << 6 | a; t = t + String.fromCharCode(n); if (u != 64) { t = t + String.fromCharCode(r) } if (a != 64) { t = t + String.fromCharCode(i) } } t = Base64._utf8_decode(t); return t }, _utf8_encode: function (e) { e = e.replace(/rn/g, "n"); var t = ""; for (var n = 0; n < e.length; n++) { var r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r) } else if (r > 127 && r < 2048) { t += String.fromCharCode(r >> 6 | 192); t += String.fromCharCode(r & 63 | 128) } else { t += String.fromCharCode(r >> 12 | 224); t += String.fromCharCode(r >> 6 & 63 | 128); t += String.fromCharCode(r & 63 | 128) } } return t }, _utf8_decode: function (e) { var t = ""; var n = 0; var r = c1 = c2 = 0; while (n < e.length) { r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r); n++ } else if (r > 191 && r < 224) { c2 = e.charCodeAt(n + 1); t += String.fromCharCode((r & 31) << 6 | c2 & 63); n += 2 } else { c2 = e.charCodeAt(n + 1); c3 = e.charCodeAt(n + 2); t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63); n += 3 } } return t } }

                    var bas64Params = Base64.encode(paramsString);
                    var WEB_NAME = funcMetaInfo.WEB_FORM_NAME + "&jsonSqlParams=" + paramsString;
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
                            msg: "Не вибрано жодного рядка",
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
                                    if (!Value || Value == '') {
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
                        window.open(WEB_NAME, '_blank');
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
            default:
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
            thisController.showInputParamsDialog(false, function () {
                thisController.executeCurrentSqlFunction();
            })
        else
            thisController.executeCurrentSqlFunction();

    },
    //заполнить информацию о вызываемой sql-функции 
    //funcMetaInfo - метаинформация о вызываемой функции
    fillCallFuncInfo: function (funcMetaInfo) {
        var thisController = this;
        //метаинформация о параметрах
        var paramsMeta = funcMetaInfo.ParamsInfo;
        //в данном объекте будем сохранять нужную информацию о текущей вызванной функции
        thisController.currentCalledSqlFunction = {
            hasOutParams: funcMetaInfo.hasOutParams,
            CodeOper: funcMetaInfo.CodeOper,
            isFuncOnly: funcMetaInfo.isFuncOnly,
            tableId: funcMetaInfo.TABID,
            ColumnId: funcMetaInfo.ColumnId,
            funcId: funcMetaInfo.FUNCID,
            //имя и тип параметров
            paramsInfo: new Array(),
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
            linkWebFormName: funcMetaInfo.LinkWebFormName
        };

        var func = thisController.currentCalledSqlFunction;
        //по переданным данным заполняем форму ввода параметров
        Ext.each(paramsMeta, function (par) {
            //упрощенные метаданные параметров - только то что нужно для заполнения значений
            func.paramsInfo.push({
                Name: par.ColumnInfo.COLNAME,
                Type: par.ColumnInfo.COLTYPE,
                IsInput: par.IsInput
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
    },
    openWindowByFunction: function (WEB_NAME) {
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
        //проход по всем выбранным строкам
        Ext.each(selectedRows, function (selectedRow) {
            //заполняем параметры для текущей строки
            var currentParams = { rowIndex: selectedRow.index + 1, rowParams: new Array() };
            //заполняем параметры функции значения которых нужно взять из текущей строки грида
            Ext.each(func.paramsInfo, function (par) {
                if (par.IsInput == false) {
                    currentParams.rowParams.push({
                        Name: par.Name,
                        //для невводимых параметров тип параметра берем из метаданных колонки, с которой берем значение
                        Type: Ext.Array.findBy(referenceGrid.metadata.columnsInfo, function (i) { return i.COLNAME == par.Name; }).COLTYPE,
                        //присваиваем значению параметра значение с выбранной строки грида
                        Value: selectedRow.data[par.Name]
                    });
                }
            });
            func.params.push(currentParams);
        });
    },

    //показать диалог ввода параметров для sql-функции
    //showForEachRow - true-диалог будет запрашивать параметры для каждой строки, false-единожды для всех строк
    //okBtnHandler - функция для вызова после нажатия кнопки "Ok" диалога
    showInputParamsDialog: function (showForEachRow, okBtnHandler) {
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
        var title = func.infoDialogTitle + ". Заповніть параметри процедури";
        if (showForEachRow) {
            title += " для рядка " + (func.params[func.currentParamsInputIndex].rowIndex);
        }

        var maxLengthLabel = 0;
        Ext.Object.each(func.paramsFormPanelItems, function (index, formItem) {
            if (formItem.fieldLabel && formItem.fieldLabel.length && formItem.fieldLabel.length < formItem.fieldLabel.length)
                maxLengthLabel = formItem.fieldLabel.length;
        });
        maxLengthLabel = this.getLabelWidth(maxLengthLabel);
        Ext.create('ExtApp.view.refBook.refShowparamWindow', {
            itemId: "funcParamsWindow",
            title: title,
            items: Ext.create('ExtApp.view.refBook.FormPanel', {
                items: func.paramsFormPanelItems,
                fieldDefaults: {
                    labelAlign: 'left',
                    labelWidth: maxLengthLabel
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
                        }
                    });
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

    //вызвать sql-функцию, по данным объекта thisController.currentCalledSqlFunction
    executeCurrentSqlFunction: function (callbackFunc) {
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
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
        //для наборов параметров (т.к. функция может быть вызвана для нескольких строк с разными параметрами)
        Ext.each(func.params, function (param) {
            thisController.sendToServer(
            "/barsroot/ReferenceBook/CallRefFunction",
            { codeOper: func.CodeOper, tableId: func.tableId, funcId: func.funcId, jsonFuncParams: Ext.JSON.encode(param.rowParams), ColumnId: func.ColumnId, procName: func.funcName, random: Math.random, jsonSqlProcParams: func.jsonSqlProcParams },
            //пункция вызовется после ответа сервера 
            function (status, msg, controller) {
                //увеличиваем счетчик вызванных на выполнение функций
                func.currentCallIndex++;
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
                        Ext.MessageBox.confirm(func.infoDialogTitle + "</br>" + "перехід на сторінку <br>" + func.linkWebFormName, resMsg, function (btn) {
                            if (btn == 'yes') {
                                window.open(func.linkWebFormName);
                            }
                        });
                    }
                    else {
                        Ext.MessageBox.show({
                            title: func.infoDialogTitle,
                            msg: "Виконання процедур закінчено." + "<br/>" + resMsg + '</br> </br>',
                            buttons: Ext.MessageBox.OK
                        });
                    }

                    var grid = controller.getGrid();
                    if (grid) {
                        grid.store.load();
                    }

                    if (callbackFunc && func.errorLog.length == 0) {
                        callbackFunc();
                    }
                }
            });
        });
    },

    executeCurrentSqlFunctionWithOutParams: function (callbackFunc) {
        var thisController = this;
        var func = thisController.currentCalledSqlFunction;
        Ext.each(func.params, function (param) {
            thisController.getFileFromServer("/barsroot/ReferenceBook/CallFunctionWithResult/?" + 'tableId=' + func.tableId + '&funcId=' + func.funcId + '&codeOper=' + func.CodeOper +
                '&jsonFuncParams=' + Ext.JSON.encode(param.rowParams) + '&procName=' + func.funcName + '&random=' + Math.random + '&jsonSqlProcParams=' + window.jsonSqlProcParams);
        });

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

    getLabelWidth: function (label) {
        if (label < 10) {
            return parseInt(Ext.getBody().getViewSize().width) * 0.15;
        } else if (10 <= label < 20) {
            return parseInt(Ext.getBody().getViewSize().width) * 0.2;
        } else if (20 <= label < 30) {
            return parseInt(Ext.getBody().getViewSize().width) * 0.25;
        } else if (30 <= label < 40) {
            return parseInt(Ext.getBody().getViewSize().width) * 0.3;
        } else {
            return parseInt(Ext.getBody().getViewSize().width) * 0.345;
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