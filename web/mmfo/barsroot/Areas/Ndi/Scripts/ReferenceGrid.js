Ext.application({

    name: 'ExtApp',
    appFolder: '/barsroot/Areas/Ndi/Scripts/ExtJsApp',

    requires: [
        'ExtApp.utils.RefBookUtils',
        'ExtApp.utils.SetStatmentUtils'
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
        var codeOper = window.CodeOper;
        var sParColumn = window.sParColumn;
        var nativeTabelId = window.nativeTabelId;
        var base64JsonSqlProcParams = window.base64jsonSqlProcParams;
        var isFuncOnly = window.isFuncOnly;
        var nsiTableId = window.nsiTableId;
        var nsiFuncId = window.nsiFuncId;
        var filterCode = window.filterCode;
        var baseCodeOper = window.baseCodeOper;
        var Base64InsertDefParamsString = window.Base64InsertDefParamsString;
        var code = window.Code;
        var thisController = thisApp.controllers.findBy(function (controller) { return controller.id = "refBook.RefGrid"; });
        if (tableId) {
            var getObj = new Object();
            getObj.TableId = tableId === 'undefined' ? '' : tableId;
            getObj.CodeOper = codeOper === 'undefined' ? '' : codeOper;
            getObj.SparColumn = sParColumn === 'undefined' ? '' : sParColumn;
            getObj.NativeTabelId = nativeTabelId === 'undefined' ? '' : nativeTabelId;
            getObj.NsiTableId = nsiTableId === 'undefined' ? '' : nsiTableId;
            getObj.NsiFuncId = nsiFuncId === 'undefined' ? '' : nsiFuncId;
            getObj.Base64jsonSqlProcParams = base64JsonSqlProcParams === 'undefined' ? '' : base64JsonSqlProcParams;
            getObj.BaseCodeOper = baseCodeOper === 'undefined' ? '' : baseCodeOper;
            getObj.Filtercode = filterCode === 'undefined' ? '' : filterCode;
            getObj.Code = code === 'undefined' ? '' : code;
            getObj.Base64InsertDefParamsString = Base64InsertDefParamsString;
            //запрос на получение метаданных
            Ext.Ajax.request({
                url: '/barsroot/ndi/ReferenceBook/GetMetadata',
                method: 'POST',
                params: { data: Ext.JSON.encode(getObj) },
                    //tableId: tableId,
                    //CodeOper: CodeOper,
                    //sParColumn: sParColumn,
                    //nativeTabelId: nativeTabelId,
                    //nsiTableId: nsiTableId,
                    //nsiFuncId: nsiFuncId,
                    //base64jsonSqlProcParams: base64jsonSqlProcParams
                

                success: function (conn, response) {
                    
                    //обработка при удачном запросе на сервер
                    var result = Ext.JSON.decode(conn.responseText);
                    if (result.success) {
                        thisApp.callBeforeFunction(result.metadata);
                    }
                    else {
                        Ext.Msg.show({
                            title: "Не вдалося отримати інформацію з метаданих для цієї таблиці (id=" + tableId + ")",
                            msg: result.errorMessage + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK
                        });
                    }

                },
                failure: function (conn, response) {
                    //обработка при неудачном запросе на сервер
                    Ext.Msg.show({
                        title: "Виникли проблеми при з'єднанні з сервером",
                        msg: conn.responseText + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK
                    });
                }
            });
        }
        else if (isFuncOnly && isFuncOnly.toLowerCase() == 'true') {
            Ext.Ajax.request({
                url: '/barsroot/ndi/ReferenceBook/GetFuncOnlyMetaData',
                params: {
                    CodeOper: codeOper
                },
                success: function (conn, response) {

                    //обработка при удачном запросе на сервер
                    var result = Ext.JSON.decode(conn.responseText);
                    if (result.success) {
                        var funcMetaInfo = result.funcMetaInfo;
                        var titleMsg = 'Виконання процедури' + funcMetaInfo.DESCR;

                        if (funcMetaInfo.QST) {
                            Ext.MessageBox.confirm(titleMsg, funcMetaInfo.QST, function (btn) {
                                if (btn == 'yes') {

                                    thisController.callSqlFunctionOnly(funcMetaInfo);
                                }
                            });
                        }
                        else
                            thisController.callSqlFunctionOnly(funcMetaInfo)
                    }
                    else {
                        Ext.Msg.show({
                            title: "Не вдалося виконати функцію",
                            msg: result.errorMessage + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK
                        });
                    }

                },
                failure: function (conn, response) {
                    //обработка при неудачном запросе на сервер
                    Ext.Msg.show({
                        title: "Виникли проблеми при з'єднанні з сервером",
                        msg: conn.responseText + '</br> </br>', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK
                    });
                }
            });
        }
        else {
            Ext.Msg.show({
                title: "Ідентифікатор довідника не вказаний",
                msg: "", icon: Ext.Msg.ERROR + '</br> </br>', buttons: Ext.Msg.OK
            });
        }
    },

    //вызвать процедуру перед населением таблицы
    callBeforeFunction: function (metadata) {
        
        var thisApp = this;
        var thisController = thisApp.controllers.findBy(function (controller) { return controller.id = "refBook.RefGrid"; });
        var beforeFunc = Ext.Array.findBy(metadata.callFunctions, function (i) { return i.PROC_EXEC == "BEFORE" });
        //если нужно вызвать какую-то функцию перед тем как населить таблицу
        if (beforeFunc) {
            
            thisController.fillCallFuncInfo(beforeFunc,metadata);
            var func = thisController.currentCalledSqlFunction;
            func.infoDialogTitle = beforeFunc.DESCR;
            //для ONCE заполняем единожды параметры в диалоге и вызываем функцию (из строк грида никакие данные не берутся)
            func.params.push({ rowIndex: null, rowParams: new Array() });
            if (beforeFunc.QST) {
                var titleMsg = 'Виконання процедури' + beforeFunc.DESCR;
                Ext.MessageBox.confirm(titleMsg, beforeFunc.QST, function (btn) {
                    if (btn == 'yes') {
                        if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true }))
                            thisController.showInputParamsDialog(false, function () {
                                // thisController.executeCurrentSqlFunction(function () {
                                thisApp.createRefGrid(metadata);
                                //});
                            });
                        else
                            thisApp.createRefGrid(metadata);
                    }
                    else {
                        window.executeBeforFunc = "no";
                        thisApp.createRefGrid(metadata);
                    }
                });

            } else {
                if (func.paramsInfo.length > 0 && Ext.Array.findBy(func.paramsInfo, function (i) { return i.IsInput == true })) {
                    thisController.showInputParamsDialog(false, function () {
                        
                        thisApp.createRefGrid(metadata);
                        // });
                    });
                }
                else thisApp.createRefGrid(metadata);
            }
        } else {
            thisApp.createRefGrid(metadata);
        }
    },

    //создать грид по метаданным справочника
    createRefGrid: function (metadata) {
        
        var thisApp = this;
        var thisController = thisApp.controllers.findBy(function (controller) { return controller.id = "refBook.RefGrid"; });
        metadata.tableMode = window.tableMode;
        metadata.saveFilterLocal = window.saveFilterLocal;
        thisController.showBeforeFilterDialog(metadata);
    },

    //установить уровни доступа
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
            return metadata.tableMode == 'FullUpdate' || metadata.tableMode == 'DeleteUpdate' || metadata.tableMode == 'Delete'
        };
        return metadata;
    }
});






