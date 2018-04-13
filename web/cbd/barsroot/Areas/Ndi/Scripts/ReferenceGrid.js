Ext.application({

    name: 'ExtApp',
    appFolder: '/barsroot/Areas/Ndi/Scripts/ExtJsApp',

    requires: [
        'ExtApp.utils.RefBookUtils'
    ],

    views: [
    ],

    controllers: [
        'refBook.RefGrid'
    ],

    //точка входа в приложение
    launch: function () {
        var thisApp = this;
        //заполняется из ViewBag в представлении
        var tableId = window.tableId;
        if (tableId && tableId != '') {
            //запрос на получение метаданных
            Ext.Ajax.request({
                url: '/barsroot/ndi/ReferenceBook/GetMetadata',
                params: {
                    tableId: tableId
                },
                success: function (conn, response) {
                    //обработка при удачном запросе на сервер
                    var result = Ext.JSON.decode(conn.responseText);
                    if (result.success) {
                        thisApp.callBeforeFunction(result.metadata);
                    }
                    else {
                        Ext.Msg.show({
                            title: "Не вдалося отримати інформацію з метаданих для цієї таблиці (id=" + tableId + ")",
                            msg: result.errorMessage, icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK
                        });
                    }

                },
                failure: function (conn, response) {
                    //обработка при неудачном запросе на сервер
                    Ext.Msg.show({
                        title: "Виникли проблеми при з'єднанні з сервером",
                        msg: conn.responseText, icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK
                    });
                }
            });
        }
        else {
            Ext.Msg.show({
                title: "Ідентифікатор довідника не вказаний",
                msg: "", icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK
            });
        }
    },

    //вызвать процедуру перед населением таблицы
    callBeforeFunction: function (metadata) {
        var thisApp = this;
        var beforeFunc = Ext.Array.findBy(metadata.callFunctions, function (i) { return i.PROC_EXEC == "BEFORE"; });
        //если нужно вызвать какую-то функцию перед тем как населить таблицу
        if (beforeFunc) {
            var thisController = thisApp.controllers.findBy(function (controller) { return controller.id = "refBook.RefGrid"; });
            thisController.fillCallFuncInfo(beforeFunc);
            var func = thisController.currentCalledSqlFunction;
            func.infoDialogTitle = beforeFunc.DESCR;
            //для ONCE заполняем единожды параметры в диалоге и вызываем функцию (из строк грида никакие данные не берутся)
            func.params.push({ rowIndex: null, rowParams: new Array() });
            thisController.showInputParamsDialog(false, function () {
                thisController.executeCurrentSqlFunction(function () {
                    thisApp.showBeforeFilterDialog(metadata);
                });
            });
        } else {
            thisApp.showBeforeFilterDialog(metadata);
        }
    },

    //показать диалоговый фильтр перед населением таблицы
    showBeforeFilterDialog: function (metadata) {
        var thisApp = this;
        metadata.startFilter = [];
        var formFields = [];
        var columnsForStartFilter = [];
        //если есть информация о начальных фильтрах
        if (metadata.intlFilters.length > 0) {
            //отбираем только метаданные колонок текущего справочника - по внешним колонкам не строим начальные фильтры 
            var nativeColumnsInfo = Ext.Array.filter(metadata.columnsInfo, function (col) { return col.IsForeignColumn == false; });
            Ext.each(nativeColumnsInfo, function (col) {
                //если по колонке нужно показывать начальный диалоговый фильтр
                var intlFilter = Ext.Array.findBy(metadata.intlFilters, function(i) { return i.COLID == col.COLID; });
                if (intlFilter) {
                    columnsForStartFilter.push(col);
                    var formField = ExtApp.utils.RefBookUtils.configFormField(col);
                    //если фильтр при входе должен быть обязательно заполнен
                    if (intlFilter.MANDATORY_FLAG_ID == 1) {
                        formField.allowBlank = false;
                    }
                    formFields.push(formField);
                }
            });

            //показываем диалог
            Ext.create('ExtApp.view.refBook.EditWindow', {
                itemId: "startFilterWindow",
                title: "Фільтр перед населенням таблиці",
                items: Ext.create('ExtApp.view.refBook.FormPanel', { items: formFields }),
                btnOkProps: {
                    handler: function (btn) {
                        var window = btn.up('window');
                        var form = window.down('form').getForm();
                        if (form.isValid()) {
                            Ext.each(columnsForStartFilter, function (col) {
                                var filterValue = form.findField(col.COLNAME).getValue();
                                //если заполнили поле формы, то добавляем его к начальному фильтру
                                if (filterValue != null) {
                                    metadata.startFilter.push({
                                        //к имени поля добавляем имя таблицы
                                        Name: metadata.tableInfo.TABNAME + "." + col.COLNAME,
                                        Type: col.COLTYPE,
                                        Value: filterValue
                                    });
                                }
                            });
                            window.close();
                            thisApp.createRefGrid(metadata);
                        }
                    }
                }
            });
        } else {
            thisApp.createRefGrid(metadata);
        }
    },

    //создать грид по метаданным справочника
    createRefGrid: function (metadata) {
        var thisApp = this;
        thisApp.setAccessLevel(metadata);
        Ext.create('ExtApp.view.refBook.RefGrid', { metadata: metadata });
    },

    //установить уровни доступа
    setAccessLevel: function(metadata) {
        //записываем в метаданные уровень доступа
        metadata.tableMode = window.tableMode;
        metadata.canUpdate = function () {
            return metadata.tableMode == 0 || metadata.tableMode == 2 || metadata.tableMode == 5 || metadata.tableMode == 6;
        };
        metadata.canInsert = function () {
            return metadata.tableMode == 0 || metadata.tableMode == 3 || metadata.tableMode == 5 || metadata.tableMode == 7;
        };
        metadata.canDelete = function () {
            return metadata.tableMode == 0 || metadata.tableMode == 4 || metadata.tableMode == 6 || metadata.tableMode == 7;
        };
    }
});




