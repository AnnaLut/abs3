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
        { ref: 'formViewButton', selector: 'referenceGrid toolbar button#formViewButton' }
    ],

    init: function() {
        this.control({
            "referenceGrid": {
                edit: this.onEdit,
                beforeedit: this.onBeforeEdit,
                validateedit: this.onValidateEdit,
                canceledit: this.onCancelEdit,
                selectionchange: this.onSelectionChange
            },
            "referenceGrid toolbar button#addButton": {
                click: this.onAddBtnClick
            },
            "referenceGrid toolbar button#sampleButton": {
                click: this.onSampleBtnClick
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
            "referenceGrid toolbar #callFuncButton menu": {
                click: this.onCallFunctionMenuClick
            },
            "referenceGrid pagingtoolbar button#clearFilterButton": {
                click: this.onClearFilterClick
            },
            //для всех pagingtoolbar-ов на странице (основного грида и выпадающих списков)
            "pagingtoolbar": {
                afterlayout: this.onPagingToolbarAfterLayout
            },
            "#refEditWindow #okButton": {
                click: this.onEditWindowSaveClick
            }
        });
    },

    //метод вызывается перед началом редактирования записи с помощью плагина RowEditing
    onBeforeEdit: function(rowEditing, e) {
        //при редактировании запретить редактировать NOT_TO_EDIT колонки, а при добавлении разрешить
        Ext.each(e.grid.metadata.columnsInfo, function() {
            if (this.NOT_TO_EDIT == 1) {
                var editorField = rowEditing.editor.form.findField(this.COLNAME);
                if (editorField) {
                    if (e.record.phantom) {
                        editorField.enable();
                    } else {
                        editorField.disable();
                    }
                }
            }
        });
    },

    //вызывается при нажатии на кнопку "Зберегти" но до записи данных в строку на клиенте. 
    onValidateEdit: function(rowEditing, e) {
        //return false;
    },

    //метод вызывается при нажатии на кнопку "Зберегти" в плагине RowEditing
    onEdit: function(rowEditing, e) {
        //для редактирования/добавления передаем новые и старые значения а также признаки phantom, dirty
        var values = e.record.data;
        var modified = e.record.modified;
        var isPhantom = e.record.phantom;
        var isDirty = e.record.dirty;
        this.AddEditRecord(values, modified, isPhantom, isDirty);
    },

    //метод вызывается при нажатии на кнопку "Відмінити" в плагине RowEditing
    onCancelEdit: function(rowEditing, e) {
        //если отменили редактирование только что добавленной строки, то удаляем
        if (e.record.phantom) {
            e.grid.store.remove(e.record);
        }
    },

    onAddBtnClick: function(button, e) {

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

    onSampleBtnClick: function(button, e) {

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

    onRemoveBtnClick: function(button, e) {
        var thisController = this;
        Ext.MessageBox.confirm('Видалення рядка', 'Ви впевнені що хочете видалити рядок таблиці?', function(btn) {
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
                Ext.each(grid.metadata.columnsInfo, function() {
                    if (this.IsForeignColumn == false) {
                        var field = {};
                        field.Name = this.COLNAME;
                        field.Type = this.COLTYPE;
                        field.Value = selectedRow.data[this.COLNAME];
                        deletableRow.push(field);
                    }
                });
                Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
                thisController.sendToServer(
                    "/barsroot/ReferenceBook/DeleteData",
                    { jsonDeletableRow: Ext.JSON.encode(deletableRow), tableId: grid.metadata.tableInfo.TABID, tableName: grid.metadata.tableInfo.TABNAME, random: Math.random },
                    function(status, msg) {
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

    onSelectionChange: function(rowmodel, records) {
        //enabled кнопок "Додати за зразком", "Видалити", "Рядок вертикально" если выбрана строка
        //TODO: может слишком затратно
        var removeButton = this.getRemoveButton();
        if (removeButton) {
            removeButton.setDisabled(!records.length);
        }
        var sampleButton = this.getSampleButton();
        if (sampleButton) {
            sampleButton.setDisabled(!records.length);
        }

        var formViewButton = this.getFormViewButton();
        formViewButton.setDisabled(!records.length);
    },

    //нажатие на кнопку отмены всех фильтров
    onClearFilterClick: function(button, e) {
        var proxy = this.getGrid().store.getProxy();
        //очистка расширенного фильтра
        if (proxy.extraParams) {
            proxy.extraParams.externalFilter = [];
        }
        this.getGrid().filters.clearFilters();
        this.getGrid().store.reload();
    },

    //убираем с пэйджинг тулбаров всё лишнее
    onPagingToolbarAfterLayout: function(toolbar, e) {
        //кнопка перехода к последней странице пэйджинга нам не нужна так как не используем count(*) 
        toolbar.down("#last").hide();
        //кнопка ввода текущей отображаемой страницы нам тоже не нужна
        toolbar.down('#inputItem').setDisabled(true);
    },

    //обработчик кнопки "Рядок вертикально"
    onFormViewBtnClick: function(button) {
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

    //обработчик нажатия на кнопку "Зберегти" при редактировании данных справочника в форме
    onEditWindowSaveClick: function(button) {
        var thisController = this;
        var refEditWindow = button.up('window');
        var form = refEditWindow.down('form').getForm();

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
    onCallFunctionMenuClick: function(menu, item) {
        var thisController = this;
        //каждый пункт меню содержит свойство metaInfo с информацией о вызываемой процедуре
        var funcMetaInfo = item.metaInfo;

        //если заполнен вопрос который нужно задать перед выполнением процедуры
        if (funcMetaInfo.QST) {
            Ext.MessageBox.confirm('Виконання процедури', funcMetaInfo.QST, function (btn) {
            if (btn == 'yes') {
                thisController.callSqlFunction(funcMetaInfo);
            }
          });
        } else {
            thisController.callSqlFunction(funcMetaInfo);
        }
    },


    ////////////////////////////////////////////вспомогательные функции (не обработчики событий)

    //добавить/редактировать строку справочника - единый метод, который использует как rowEditing плагин грида так и форма редактирования
    //values - текущие значения
    //modified - поля которые были изменены и их значения до изменения (нужно только для insert)
    //isPhantom признак показывает добавляется новая строка или редактируется существующая (true - добавляется новая)
    //isDirty признак показывает были ли данные изменены при редактировании (true - были изменены)
    AddEditRecord: function(values, modified, isPhantom, isDirty) {
        var thisController = this;
        var referenceGrid = thisController.getGrid();
        //выбрать все колонки кроме колонок из других таблиц
        var metaColumns = Ext.Array.filter(referenceGrid.metadata.columnsInfo, function(col) { return col.IsForeignColumn == false; });

        //если строка было добавлена как новая а не редактируется текущая 
        //(признак phantom означает что строка есть в store на клиенте, но она не сохранена)
        if (isPhantom) {
            var insertableRow = new Array();
            Ext.each(metaColumns, function() {
                var field = {};
                field.Name = this.COLNAME;
                field.Type = this.COLTYPE;
                field.Value = values[this.COLNAME];
                insertableRow.push(field);
            });

            Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
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

                Ext.each(metaColumns, function() {
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

                Ext.MessageBox.show({ msg: 'Виконується оновлення даних, зачекайте...', wait: true, waitConfig: { interval: 200 }, iconCls: "save" });
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
    AddEditAfterRequest: function(status, msg, controller) {
        //обработка при удачном запросе на сервер
        Ext.MessageBox.hide();
        Ext.MessageBox.show({ title: 'Оновлення даних', msg: msg, buttons: Ext.MessageBox.OK });
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
    sendToServer: function(url, params, afterRequestFunction) {
        var thisController = this;
        Ext.Ajax.request({
            url: url,
            params: params,
            success: function(conn, resp) {
                var response = Ext.decode(conn.responseText);
                if (afterRequestFunction) {
                    afterRequestFunction(response.status, response.msg, thisController);
                }
            },
            failure: function(conn, response) {
                //обработка при неудачном запросе на сервер
                Ext.Msg.show({ title: "Виникли проблеми при з'єднанні з сервером", msg: conn.responseText, icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
            }
        });
    },

    onExportToExcelBtnClick: function (menu, item) {
        var grid = menu.up('referenceGrid');
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
            "&startFilter=" + grid.metadata.startFilter +
            "&externalFilter=" + grid.store.proxy.extraParams.externalFilter +
            "&fallDownFilter=" + grid.store.proxy.extraParams.fallDownFilter +
            "&sort=" + Ext.encode(sort) +
            "&start=" + start +
            "&limit=" + pageSize
        );
        grid.store.fireEvent('Load');
    },

    //заполнить параметры и вызвать sql-процедуру определенного типа
    //metaInfo - метаописание процедуры, параметров
    callSqlFunction: function(funcMetaInfo) {
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
                    func.infoDialogTitle = 'Виконання процедури';
                    //для ONCE заполняем единожды параметры в диалоге и вызываем функцию (из строк грида никакие данные не берутся)
                    func.params.push({ rowIndex: null, rowParams: new Array() });
                    thisController.showInputParamsDialog(false, function () {
                        thisController.executeCurrentSqlFunction();
                    });
                    break;
                }
                //выполнение процедуры для каждой выделенной строки
            case "EACH":
                {
                    //получаем собственно выбранные строки
                    selectedRows = gridSelectModel.getSelection();

                    func.allFuncCallCount = selectedRows.length;
                    func.infoDialogTitle = 'Виконання процедури для вибранних рядків';

                    //если пользователь не выбрал строк
                    if (selectedRows.length == 0) {
                        Ext.MessageBox.show({
                            title: func.infoDialogTitle,
                            msg: "Не вибрано жодного рядка",
                            buttons: Ext.MessageBox.OK
                        });
                        return;
                    }

                    //заполняем значения параметров из выбранных строк
                    thisController.fillFuncParamsFromRows(selectedRows);

                    //для EACH параметры заполняются в диалоге заново для каждой выбранной строки
                    //после заполнения параметров из грида заполняем вводимые параметры в диалоге для всех строк, и посли нажатия Ok вызываем функцию
                    thisController.showInputParamsDialog(true, function () {
                        //запоминаем номер строки для которой вызывается процедура, чтобы в случае неудачи пользователь знал на какой строке свалилось
                        thisController.executeCurrentSqlFunction();
                    });
                }
                break;
            case "ALL":
                {
                    //если процедуру нужно вызвать для всех строк, то выделяем все строки, для более простого их получения
                    gridSelectModel.selectAll();
                    selectedRows = gridSelectModel.getSelection();
                    gridSelectModel.deselectAll();

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

                    //для ALL заполняем единожды параметры функции, значения которых нужно ввести в диалоге ввода параметров
                    //после нажатия "Ok" в диалоге ввода параметров - проходимся по всем строкам, дозаполняем параметры и вызываем функции для конкретных строк
                    thisController.showInputParamsDialog(false, function () {
                        thisController.executeCurrentSqlFunction();
                    });
                }
                break;
        };
    },

    //заполнить информацию о вызываемой sql-функции 
    //funcMetaInfo - метаинформация о вызываемой функции
    fillCallFuncInfo: function (funcMetaInfo) {
        var thisController = this;
        //метаинформация о параметрах
        var paramsMeta = funcMetaInfo.ParamsInfo;

        //в данном объекте будем сохранять нужную информацию о текущей вызванной функции
        thisController.currentCalledSqlFunction = {
            tableId: funcMetaInfo.TABID,
            funcId: funcMetaInfo.FUNCID,
            //имя и тип параметров
            paramsInfo: new Array(),
            //параметры со значениями для всех строк, для которых выполняется процедура 
            params: new Array(),
            //текущий номер вызова функции (нужно если мы вызываем одну и ту же функцию для нескольких строк, для показа progressbar-а)
            currentCallIndex: 0,
            //количество удачно выполненных функций от общего количества (удачно если сервер вернул статус "ok")
            successCallCount: 0,
            //общее количество раз которое функция будет вызвана (зависит от количества выбранных строк на которых мы вызываем функцию)
            allFuncCallCount: 1,
            infoDialogTitle: "Виконання процедури",
            paramsFormPanelItems: new Array(),
            //данный параметр нужен для отслеживания количества вызова диалога ввода параметов (для режима EACH)
            currentParamsInputIndex: 0,
            //будем записывать сюда информацию об ошибках при выполнении процедур
            errorLog: new Array()
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
        Ext.create('ExtApp.view.refBook.EditWindow', {
            itemId: "funcParamsWindow",
            title: title,
            items: Ext.create('ExtApp.view.refBook.FormPanel', { items: func.paramsFormPanelItems }),
            btnOkProps: {
                handler: function (btn) {
                    var window = btn.up('window');
                    var form = window.down('form').getForm();
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
                        Ext.each(func.params, function(param) {
                            param.rowParams = param.rowParams.concat(inputParams);
                        });
                    }

                    //закрываем окно
                    window.close();

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
            { tableId: func.tableId, funcId: func.funcId, jsonFuncParams: Ext.JSON.encode(param.rowParams), random: Math.random },
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
                    if (func.errorLog.length > 0) {
                        errorMsg += "</br>Повідомлення про помилки: ";
                        Ext.each(func.errorLog.sort(function (a, b) { return a.rowIndex - b.rowIndex; }), function (log) {
                            errorMsg += log.errMsg;
                        });
                    }
                    Ext.MessageBox.show({
                        title: func.infoDialogTitle,
                        msg: "Виконання процедур закінчено. <br/>Успішно " + func.successCallCount + " з " + func.allFuncCallCount + errorMsg,
                        buttons: Ext.MessageBox.OK
                    });
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

    //тип фильтра для колонки грида
    getFilterType: function(codeType) {
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
    getFieldType: function(codeType) {
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

    //рассчитать ширину колонки на основе значения в META_COLUMNS.SHOWWIDTH
    calcColWidth: function(showWidth) {
        //магический расчет ширины - взято из прошлых справочников + помножено на 96 для перевода в пиксели
        if (showWidth) {
            var sizeInches = showWidth / 1.5;
            if (sizeInches < 1.15) {
                sizeInches = 1.15;
            }
            var sizePixels = sizeInches * 96;
            return sizePixels;
        } else {
            return 1.15 * 96;
        }
    }
});