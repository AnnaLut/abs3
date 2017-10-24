Ext.define('ExtApp.utils.RefBookUtils', {
    //так как мы создаем RefCombobox использую xtype, то файл RefCombobox.js должен быть загружен до его использования
    requires: ['ExtApp.view.refBook.CustomElements.RefCombobox', 'ExtApp.view.refBook.CustomElements.RefTextBox',
    'ExtApp.view.refBook.CustomElements.RefCheckBox'],
    statics: {
        //дефолтные значения для всех колонок, полей формы
        defaults: { dateFormat: 'd.m.Y', decimalPrecision: 5 },

         getBase64: function () {
             var Base64 = { _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=", encode: function (e) { var t = ""; var n, r, i, s, o, u, a; var f = 0; e = Base64._utf8_encode(e); while (f < e.length) { n = e.charCodeAt(f++); r = e.charCodeAt(f++); i = e.charCodeAt(f++); s = n >> 2; o = (n & 3) << 4 | r >> 4; u = (r & 15) << 2 | i >> 6; a = i & 63; if (isNaN(r)) { u = a = 64 } else if (isNaN(i)) { a = 64 } t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a) } return t }, decode: function (e) { var t = ""; var n, r, i; var s, o, u, a; var f = 0; e = e.replace(/[^A-Za-z0-9+/=]/g, ""); while (f < e.length) { s = this._keyStr.indexOf(e.charAt(f++)); o = this._keyStr.indexOf(e.charAt(f++)); u = this._keyStr.indexOf(e.charAt(f++)); a = this._keyStr.indexOf(e.charAt(f++)); n = s << 2 | o >> 4; r = (o & 15) << 4 | u >> 2; i = (u & 3) << 6 | a; t = t + String.fromCharCode(n); if (u != 64) { t = t + String.fromCharCode(r) } if (a != 64) { t = t + String.fromCharCode(i) } } t = Base64._utf8_decode(t); return t }, _utf8_encode: function (e) { e = e.replace(/rn/g, "n"); var t = ""; for (var n = 0; n < e.length; n++) { var r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r) } else if (r > 127 && r < 2048) { t += String.fromCharCode(r >> 6 | 192); t += String.fromCharCode(r & 63 | 128) } else { t += String.fromCharCode(r >> 12 | 224); t += String.fromCharCode(r >> 6 & 63 | 128); t += String.fromCharCode(r & 63 | 128) } } return t }, _utf8_decode: function (e) { var t = ""; var n = 0; var r = c1 = c2 = 0; while (n < e.length) { r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r); n++ } else if (r > 191 && r < 224) { c2 = e.charCodeAt(n + 1); t += String.fromCharCode((r & 31) << 6 | c2 & 63); n += 2 } else { c2 = e.charCodeAt(n + 1); c3 = e.charCodeAt(n + 2); t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63); n += 3 } } return t } }
             return Base64;
         },
         buildSaveInPageParamsByAddUse: function (additionalUseNames,saveInPageParams,param){
            debugger;
             thisUtils = this;
            if(!additionalUseNames  ||  !additionalUseNames.length || !saveInPageParams)
                return;
             if(Ext.Array.contains(additionalUseNames,'ReplaseTableSemantic') && saveInPageParams.DefaultModels && saveInPageParams.DefaultModels &&
                 saveInPageParams.ReplaceModels.ReplaceSemanticFields);
             thisUtils.formatDataValue(param.Value,param.Type,null)
             saveInPageParams.ReplaceModels.ReplaceSemanticFields.push(param);
             return saveInPageParams;


         },
         setHiddenColumnsToLocalSrorage: function (columnNames, localStorageModel) {
            debugger
            var columnsNamesString = '';
            if (columnNames.length)
            {
                Ext.each(columnNames, function (name) {
                    columnsNamesString += name + ',';
                });
               
            }
            columnsNamesString = columnsNamesString.slice(0, -1);
            var myLocalStore = Ext.state.LocalStorageProvider.create();
            myLocalStore.set(localStorageModel.HiddenColumnsKey, columnsNamesString);
        },

        clearHiddenColumnsFromLocalSrorage: function (localStorageModel) {
            var myLocalStore = Ext.state.LocalStorageProvider.create();
            myLocalStore.set(localStorageModel.HiddenColumnsKey, '');
        },
        getHiddenColumnsFromLocalSrorage: function (localStorageModel) {
            
            var hiddenColumns;
            var myLocalStore = Ext.state.LocalStorageProvider.create();
            var hiddenColumnsNames = myLocalStore.get(localStorageModel.HiddenColumnsKey);
            if (hiddenColumnsNames)
                hiddenColumns = hiddenColumnsNames.split(",");
            return hiddenColumns;
            
        },
        //сконфигурировать поле ввода формы по переданным метаданным
        configFormField: function (colMetaInfo) {
            var thisUtils = this;
            //заполняем информацию о полях для формы редактирования
            var formField = {};
            formField.name = colMetaInfo.COLNAME;
            //label для поля
            if (colMetaInfo.SEMANTIC != null) {
                formField.fieldLabel = colMetaInfo.SEMANTIC.replace(/~/g, "<br/>");
            }
            //получаем элемент для редактирования поля в зависимости от типа данных
            formField.xtype = thisUtils.getFieldEditor(colMetaInfo.COLTYPE);
            formField.colMetaInfo = colMetaInfo;

            //если при редактировании данные для этого поля должны выбираться из справочника, то элемент редактирования будет комбобокс
            if (colMetaInfo.SrcTableName) {

                formField.xtype = "refCombobox";
                formField.SrcTableName = colMetaInfo.SrcTableName;
                formField.SrcColName = colMetaInfo.SrcColName;
                formField.SrcTextColName = colMetaInfo.SrcTextColName;
                formField.SrcTab_Alias = colMetaInfo.SrcTab_Alias;
                formField.NativeTableId = colMetaInfo.TABID;
                formField.COL_DYN_TABNAME = colMetaInfo.COL_DYN_TABNAME;
            }

            if (colMetaInfo.HasSrcCond && colMetaInfo.srcQueryModel)
            {
                
                formField.xtype = "refCombobox";
                formField.HasSrcCond = colMetaInfo.HasSrcCond;
                formField.srcQueryModel = colMetaInfo.srcQueryModel;
            }
            //если тип колонки bool, проставляем возвращаемое формой значение как {1,0} а не {true,false}
            if (colMetaInfo.COLTYPE == "B") {
                formField.getValue = function () {
                    var fieald = this;
                    return fieald.checked ? 1 : 0;
                }

                formField.util = thisUtils;
            }

            if (colMetaInfo.COLTYPE == "D") {
                
                formField.format = thisUtils.defaults.dateFormat;
                if (colMetaInfo.SHOWFORMAT) {
                    formField.format = colMetaInfo.SHOWFORMAT;
                }
            }
            if (colMetaInfo.COLTYPE == "N" || colMetaInfo.COLTYPE == "E") {
                
                formField.decimalPrecision = thisUtils.defaults.decimalPrecision;
                //formField.hideTrigger = true;
                formField.keyNavEnabled = true;
                formField.mouseWheelEnabled = false;
            }

    if (colMetaInfo.COLTYPE == 'CLOB') {
                {
                    formField.xtype = 'filefield';
                    //formField.name = 'document';
                    formField.buttonText = 'завантажити';
                    //msgTarget: 'side',
                    //allowBlank: false,
                    //width: 400
                    formField.listeners = {
                        change: function (fld, value) {
                            
                            if (value.indexOf('\\') < 0)
                                return true;
                            var newValue = value.substring( value.lastIndexOf('\\') + 1);
                            fld.setRawValue(newValue);
                        }
                    }
                }
            }

            //если колонка не для редактирования 
            if (colMetaInfo.NOT_TO_EDIT == 1) {
                formField.readOnly = true;
            }

            //если это колонка из другой таблицы
            if (colMetaInfo.IsForeignColumn == true) {
                formField.readOnly = true;
            }

            return formField;
        },

        formatDataValue: function (value,type,format) {
             debugger;
            thisUtils = this;
            if (type == "D") {
                var dateFormat = thisUtils.defaults.dateFormat;
                if (format) {
                    dateFormat = format;
                }
                value = Ext.Date.format(value, dateFormat);
            }
            //форматирование числовых полей
            if (type == "N" || type == "E") {
                if (format) {
                    value = Ext.util.Format.number(value, format);
                }
            }
            return value;
        },
        setInsertRecordByDefault: function (grid) {
            
            var defInsertParams = grid.metadata.saveInPageParams.DefaultModels   ? grid.metadata.saveInPageParams.DefaultModels.InsertDefParams : null;

            if (!defInsertParams || !defInsertParams.length)
                return;
            var store = grid.getStore();
            var phantomeRecord = store.data.items[0];
            if (!phantomeRecord.phantom)
                return;
            Ext.each(defInsertParams, function (param) {
                phantomeRecord.set(param.Name, param.Value);
            });
        },
        configFieldsForeSympleFilters: function (columnsMetaInfo) {
            var self = this;
            var resColumns = new Array();
            Ext.each(columnsMetaInfo, function (col) {
                if (col.COLTYPE === 'B')
                    return;

                ////упрощенные метаданные параметров - только то что нужно для заполнения значений
                //func.paramsInfo.push({
                //    Name: par.ColumnInfo.COLNAME,
                //    Type: par.ColumnInfo.COLTYPE,
                //    IsInput: par.IsInput
                //});
                //для параметров, которые нужно вводить вручную, заполняем поля формы
                col.NOT_TO_EDIT = 0;
                //конфигурируем поле ввода по метаописанию и устанавливаем значение по умолчанию, если есть
                var resColumn = self.configFormField(col);
                if (resColumn.DefaultValue) {
                    resColumn.value = resColumn.DefaultValue;
                }
               
                resColumns.push(resColumn);

            });
            return resColumns;
        },
        configCustomFilters: function myfunction(field) {
            var thisUtils = this;
            //
            //заполняем информацию о полях для формы редактирования
            var formField = {};

            formField.name = field.Name;
            //label для поля
            if (field.SEMANTIC != null) {
                formField.fieldLabel = field.SEMANTIC.replace(/~/g, "<br/>");
            }
            //получаем элемент для редактирования поля в зависимости от типа данных
            formField.xtype = thisUtils.getFieldEditor(field.Type);
            //если при редактировании данные для этого поля должны выбираться из справочника, то элемент редактирования будет комбобокс

            if (field.TYPE == "D") {
                
                formField.format = thisUtils.defaults.dateFormat;
                if (field.SHOWFORMAT) {
                    formField.format = field.SHOWFORMAT;
                }
            }
            if (field.TYPE == "N" || field.TYPE == "E") {
                formField.decimalPrecision = thisUtils.defaults.decimalPrecision;
            }

            //если это колонка из другой таблицы
            if (field.IsForeignColumn == true) {
                formField.readOnly = true;
            }

            return formField;
        },
        buildSympleFilterFromForm: function (form) {

            var params = new Array();
            var thisUtils = this;
            var formFields = form.getFields();
            var isFirstRow = true;
            formFields.each(function (field) {
                var value = field.getValue();
                if (field.wasDirty && value !== null && value !== '' && value !== undefined) {
                    var param = {};
                    param.LogicalOp = isFirstRow ? '' : 'І';
                    param.Colname = field.colMetaInfo.SEMANTIC;
                    param.ReletionalOp = thisUtils.getReletionalOperatorForSympleFilter(field.xtype);
                    param.Value = form.findField(field.name).getValue();
                    if (field.getXType() == 'datefield')
                        param.Value = Ext.Date.format(new Date(value), thisUtils.defaults.dateFormat);  // value.toDateString();// Ext.Date.parse(value,thisUtils.defaults.dateFormat);
                    //param.Semantic = item.data['Semantic'];
                    params.push(param);
                    isFirstRow = false;
                }
            });
            return params;

        },
        buildComplexFiltersRowItems: function (gridItems) {
            var params = new Array();
            if (gridItems && gridItems.length > 0)
                Ext.each(gridItems, function (item) {
                    var param = {};
                    param.LogicalOp = item.data['LogicalOp'];
                    param.Colname = item.data['Colname'];
                    param.ReletionalOp = item.data['ReletionalOp'];
                    param.Value = item.data['Value'];
                    //param.Semantic = item.data['Semantic'];
                    params.push(param);
                })
            return params;
        },
        buildSympleFiltersInsertModel: function () {

        },
        getReletionalOperatorForSympleFilter: function (fieldType) {
            switch (fieldType) {
                case "numberfield":
                case "checkbox":
                case "datefield":
                    return '=';
                case "textfield":
               case "refTextBox":
                    return 'СХОЖИЙ';
                default:
                    return '=';
            }
        },
        //получить элемент управления для редактирования поля формы по переданному коду типа данных
        getFieldEditor: function (codeType) {
            switch (codeType) {
                case "C":
                    return 'refTextBox';
                case "N":
                    return 'numberfield';
                case "E":
                    return 'numberfield';
                case "B":
                    return 'refCheckBox';
                case "D":
                    return 'datefield';
                default:
                    return 'refTextBox';
            }
        },
        getRefUrl: function (thisCombo) {
            var url
            var nativeTableId = thisCombo.NativeTableId != undefined ? thisCombo.NativeTableId : "";
           
            if (false) {
                var grid = Ext.getCmp('mainReferenceGrid');
                var gridSelectModel = grid.getSelectionModel();
                selectedRow = gridSelectModel.getSelection()[0];
                var tabeName = selectedRow.data['ND'];
                url = '/barsroot/ndi/ReferenceBook/GetRelatedReferenceData?nativeTableId=' + nativeTableId + 'tableName=' + tabeName +
                               '&fieldForId=' + thisCombo.SrcColName + '&fieldForName=' + thisCombo.SrcTextColName;
            }
            else
                url = '/barsroot/ndi/ReferenceBook/GetRelatedReferenceData?nativeTableId=' + nativeTableId + '&tableName=' + thisCombo.SrcTableName +
                               '&fieldForId=' + thisCombo.SrcColName + '&fieldForName=' + thisCombo.SrcTextColName;
            return url;
        },

        getUrlByDinamicTabName: function (combo, selectedRow) {
            var tableName = selectedRow.data[combo.COL_DYN_TABNAME];
            if (!tableName || tableName == '') {
                Ext.MessageBox.show({ title: 'порожній запис ', msg: 'порожній запис ' + combo.COL_DYN_TABNAME, buttons: Ext.MessageBox.OK });

                return null
            }

            combo.SrcTableName = tableName;
            var dynamicUrl = '/barsroot/ndi/ReferenceBook/GetRelatedReferenceData?tableName=' + tableName;
            return dynamicUrl;
        },

        getUrlBySrcCond: function (combo, selectedRow) {
            var srcQueryModel = combo.srcQueryModel;
            if (!srcQueryModel)
                return null;
            if (srcQueryModel.QueryParamsInfo && srcQueryModel.QueryParamsInfo.length > 0)
                srcQueryModel.QueryParams = [];
                Ext.each(srcQueryModel.QueryParamsInfo, function (item) {
                    var Value = selectedRow.data[item.COLNAME];
                    if (Value !== undefined)
                    {
                        var param = {};
                        param.Name = item.COLNAME;
                        param.Type = item.COLTYPE;
                        param.Value = Value;
                        srcQueryModel.QueryParams.push(param);
                    }

                })
            var queryModelString = Ext.JSON.encode(srcQueryModel);
            var dynamicUrl = '/barsroot/ndi/ReferenceBook/GerSrcQueryData?srcQueryModel=' + queryModelString;
            return dynamicUrl;
           
        },

        getUrlParameterValues: function (url) {
            // separating the GET parameters from the current URL
            var getParams = url.split("?");
            // transforming the GET parameters into a dictionnary
            var params = Ext.urlDecode(getParams[1]);
            return params;
            //var regex = new RegExp("[?&]" + '[\w*]' + "(=([^&#]*)|&|#|$)"),
            //    results = regex.exec(url);
            //return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        },

        getColumnsHiddenFromGrid: function (grid) {
            debugger
            columnsVisible = [];
            Ext.each(grid.columns, function (column, index) {
                if (column.isHidden()) {
                    columnsVisible.push(column.dataIndex);
                }
            });
            return columnsVisible;

        },

        showAllGridColumns: function (grid) {
            
            Ext.each(grid.columns, function (column) {
                if (column.isHidden()) {
                    column.show();
                }
            });
        },
        buildRowToArray: function (row, columnsInfo) {
            var dataArray = new Array();
            var data = row.data ? row.data : row;
            Ext.each(columnsInfo, function (item) {
                if (data[item.COLNAME] === undefined)
                    return;
                var rowItem = new Object();
                rowItem.Name = item.COLNAME;
                rowItem.Type = item.COLTYPE;
                rowItem.Value = data[item.COLNAME];
                dataArray.push(rowItem);

            });
            return dataArray;
        },

        buildRowToModelByFieldNames: function (modelFactory, rowModels) {
            
            var storeModelsArray = [];
            Ext.each(rowModels, function (rowModel) {
                var model = modelFactory.call(null, 'rowFilterModel');
                Ext.iterate(rowModel,
                    function(key,value) {
                       
                        model.data[key] = value;
                    });
                storeModelsArray.push(model);
            })
            return storeModelsArray;
        },
        buildEditModelsToSendServer: function (editrows, columnsInfo) {

            var Util = this;
            var rowsArray = [];
            Ext.each(editrows, function (item) {
                var row = Util.buildRowToArray(item.OldRow, columnsInfo);
                var editModel = new Object();
                editModel.OldRow = row;
                editModel.Modified = [];

                Ext.each(item.modifiedArray, function (modField) {
                    var modTempField = Ext.Array.findBy(columnsInfo, function (column) { return column.COLNAME == modField.Name });
                    if (!modTempField)
                        return;
                    modField.Type = modTempField.COLTYPE;
                    editModel.Modified.push(modField);
                });
                rowsArray.push(editModel);
            })
            return rowsArray;
        },
        replaceParamsFromRow: function (rowArray, strForReplace) {
            Ext.each(rowArray, function (param) {
                var par = ':' + param.Name;
                if (strForReplace.indexOf(par) > -1)
                    strForReplace = strForReplace.replace(par, param.Value)
            })

            return strForReplace;
        },
        compareRecords: function (oldRecord, newRecord, keyNames) {
            var isDirty = false;
            Ext.each(keyNames, function (keyName) {
                if (oldRecord.data[keyName] != newRecord.data[keyName]) {
                    isDirty = true
                    return isDirty;
                }

            })
            return isDirty;
        },
        compareEditItemsByKeys: function (oldEditItem, newEditItem) {
            var thisUtils = this;
            var isKeysEquel = true;
            var oldRow = oldEditItem.oldRow;
            Ext.each(newEditItem.keys, function (key) {
                if (!isKeysEquel)
                    return isKeysEquel;
                Ext.each(oldEditItem.keys, function (oldKey) {
                    if (!isKeysEquel)
                        return isKeysEquel;
                    if (key.Name === oldKey.Name) {
                        isKeysEquel = thisUtils.isEquelValues(key.Value, oldKey.Value);
                    }
                })
            }
             )
            return isKeysEquel;
            //var oldItem = Ext.Array.findBy(oldEditItem.OldRaw, function (item) {
            //    if (item.Name == keyName) return item
            //});
            //var newItem = Ext.Array.findBy(newEditItem.OldRaw, function (item) {
            //    if (item.Name == keyName) return item
            //});
            //if (oldItem && oldItem.Value && newItem && newItem.Value && newItem.Value != oldItem.Value) {
            //    isEquel = false;
            //}
            //if(oldItem && oldItem.Value )
            //if (Ext.Array.findBy(oldEditItem.OldRaw, function (item) {
            //          if (item.Name == keyName) return item
            //}).Value != Ext.Array.findBy(newEditItem.OldRaw, function (item) {
            //          if (item.Name == keyName) return item
            //}).Value)

        },
        isFieldPropertyEquels: function (fielProperty1, fielProperty2) {
            if (fielProperty1.Name != fielProperty2.Name)
                return false;
            if (fielProperty1.Type == fielProperty2 == 'date') {
                return  this.areEquelDates(fielProperty1,fielProperty2);
            }
            else
                return fielProperty1 == fielProperty2;
        },
        isValueEquelToOriginal: function (value, orign) {
            if (value == null && orign == '')
                return true
            else
                return this.isEquelValues(value, orign)
        },
        isEquelValues: function (value1, value2) {
            if (Ext.isDate(value1) && Ext.isDate(value2))
                return this.areEquelDates(value1, value2);
            else
                return value1 == value2;

        },
        areEquelDates: function(value1,value2){
            
            var areNotEquel = value1.getDay() !== value1.getDay() ||
                value1.getTime() !== value2.getTime() ||
                value1.getFullYear() !== value2.getFullYear();
            return !areNotEquel;
        },
        compareAndEdtiRecordByEtitItem: function (record, editItem, keysNames) {
            var thisUtils = this;
            var isEquelByKeys = true;
            var res;
            Ext.each(editItem.keys, function (key) {
                if (!isEquelByKeys)
                    return;
                if (!thisUtils.isEquelValues(record.data[key.Name], key.Value)) {
                    isEquelByKeys = false;
                    return;
                }
            })
            if (isEquelByKeys)
                Ext.Array.filter(editItem.modifiedArray, function (item) {
                    if (!thisUtils.isEquelValues(record.data[item.Name], item.Value))
                        record.set(item.Name, item.Value)
                })
        },
        deleteFromEditRowsByKeys: function (recordForDelete, keys) {

        },
        updateOrAddRecordsForUpdate: function (AddEditRowsInform, record, columnsInfo) {
            var keyNames = AddEditRowsInform.keyNames;
            if (keyNames.length < 1)
                Ext.each(columnsInfo, function (item) { if (item.IsPk == 1) keyNames.push(item.COLNAME) });
            if (!keyNames || !keyNames.length || keyNames.length < 1) {
                Ext.Msg.show({ title: "помилка при редагуванні", msg: 'можливо ви не вказали первинний ключ ' + '</br> </br> ', icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                return null;
            }
            AddEditRowsInform.keyNames = keyNames;
            var RowsArray = AddEditRowsInform.EditingRowsDataArray;
            var itemToUpdate = this.createItemToRawUpdate(record, columnsInfo, keyNames);
            if (!itemToUpdate)
                return AddEditRowsInform;
            if (!RowsArray || !RowsArray.length || RowsArray.length < 1) {
                RowsArray = new Array();
            }
            var keysEquels = false
            if (RowsArray.length == 0)
                RowsArray.push(itemToUpdate);
            else {
                isRowEquelModefided = false;
                for (var i = 0; i < RowsArray.length; i++) {
                    keysEquels = this.compareEditItemsByKeys(RowsArray[i], itemToUpdate);
                    if (keysEquels) {
                        isRowEquelModefided = true;
                        if (itemToUpdate.modifiedArray.length < 1)
                            RowsArray.splice(i, 1);
                        else
                            RowsArray[i] = itemToUpdate;
                        break;
                    }
                }
                if (!isRowEquelModefided && itemToUpdate.modifiedArray.length > 0)
                    RowsArray.push(itemToUpdate);
            }
            AddEditRowsInform.EditingRowsDataArray = RowsArray;

            return AddEditRowsInform;
        },
        getRowsKeys: function (columnsInfo, keyNames) {
            if (keyNames.length < 1)
                Ext.each(columnsInfo, function (item) { if (item.IsPk == 1) keyNames.push(item.COLNAME) });
            else
                return keyNames;
        },
        createItemToRawUpdateOld: function (record, metaColumns, keyNames) {

            var oldValues = new Array();

            var updatableRowData = record.getChanges();
            var modified = record.modified;
            var values = record.data;
            try {
                Ext.each(metaColumns, function () {

                    var oldField = {};
                    oldField.Name = this.COLNAME;
                    oldField.Type = this.COLTYPE;
                    if (modified[this.COLNAME] !== undefined) {

                        oldField.Value = modified[this.COLNAME];
                        if (Ext.Array.contains(keyNames, this.COLNAME)) {

                            Ext.Error.raise(this.SEMANTIC + '  первичний ключ ' + '</br> </br> ');
                            return null;
                        }
                    } else {

                        oldField.Value = values[this.COLNAME];
                    }
                    oldValues.push(oldField);

                    //если значение изменилось (есть в массиве измененных значений) то добавляем в список update field1=val1, field2=val2...
                    //if (modified[this.COLNAME] !== undefined) {
                    //    var dataField = {};
                    //    dataField.Name = this.COLNAME;
                    //    dataField.Type = this.COLTYPE;
                    //    dataField.Value = values[this.COLNAME];
                    //    updatableRowData.push(dataField);
                    //}

                });
                var keysData = Ext.each(metaColumns, function (item) { if (item.IsPk == 1) return { Name: item.COLNAME, Type: item.COLTYPE, Value: oldValues[item.COLNAME] }; });
                var EditRowModel = { OldRaw: oldValues, Modified: updatableRowData };
                return EditRowModel;
            } catch (e) {

                Ext.Msg.show({ title: "помилка при редагуванні", msg: e.message, icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                return null;
            }
        },
        createItemToRawUpdate: function (record, metaColumns, keyNames) {
            var Util = this;
            var oldValuesDictionary = record.raw;
            var newModified = record.getChanges();
            var modifiedArray = [];
            for (var propertyName in newModified) {
                if (propertyName)
                    modifiedArray.push({ Name: propertyName, Value: newModified[propertyName] })

            }

            var thisRecord = record;
            var keys = Util.getKeysByRecord(record, metaColumns, keyNames);
            var EditRowModel = { OldRow: oldValuesDictionary, modifiedArray: modifiedArray, keys: keys };
            return EditRowModel;
        },

        getKeysByRecord: function (record, metaColumns, keyNames) {
            var keysData = new Array();
            Ext.each(metaColumns, function (item) { if (item.IsPk == 1) return keysData.push({ Name: item.COLNAME, Type: item.COLTYPE, Value: record.raw[item.COLNAME] }); });
            return keysData;
        },

        getAddEditItemFromRecord: function (record, metaColumns) {
            //поля которые были отредактированы
            var RowToAddFielsdArray = new Array();
            try {
                Ext.each(metaColumns, function () {
                    //так как оптимистическая блокировка, то where строится по всем полям
                    var oldField = {};
                    oldField.Name = this.COLNAME;
                    oldField.Type = this.COLTYPE;
                    oldField.Value = record.data[this.COLNAME];
                    RowToAddFielsdArray.push(oldField);
                });
                var RowModel = { RowToAddFielsdArray: RowToAddFielsdArray };
                return RowModel;
            } catch (e) {

                Ext.Msg.show({ title: "помилка при редагуванні", msg: e.message, icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                return null;
            }
        },

        getDeleteItemFromRecord: function (record, metaColumns) {
            var RowToAddFielsdArray = new Array();
            try {
                Ext.each(metaColumns, function () {
                    //так как оптимистическая блокировка, то where строится по всем полям
                    var oldField = {};
                    oldField.Name = this.COLNAME;
                    oldField.Type = this.COLTYPE;
                    oldField.Value = record.data[this.COLNAME];
                    RowToAddFielsdArray.push(oldField);
                });
                var RowModel = { RowToDelete: RowToAddFielsdArray };
                return RowModel;
            } catch (e) {

                Ext.Msg.show({ title: "помилка при видаленні", msg: e.message, icon: Ext.Msg.ERROR, buttons: Ext.Msg.OK });
                return null;
            }
        },

        convertDataRerordByFields: function (data, fields) {
            Ext.each(fields.items, function (item) {
                if (item.type.type == 'date' && data[item.name])
                    data[item.name].toLocaleDateString();

            })
            return data;
        },

        converrDatesFromDataArray: function (datArray) {

            Ext.each(datArray.items, function (item) {
                if (item.type.type == 'date' && data[item.name])
                    data[item.name].toLocaleDateString();

            })
            return data;
        },

        searchInRecords: function (record, records) {

        },

        setEditedRowsAfterReload: function (AddEditRowsInform, store, records) {

            if (!records || !records.length || records.length < 1)
                return;
            var thisUtils = this;
            var editArray = AddEditRowsInform.EditingRowsDataArray;
            var keyNames = AddEditRowsInform.keyNames;
            for (var i = 0; i < records.length; i++) {
                Ext.each(editArray, function (item) {
                    thisUtils.compareAndEdtiRecordByEtitItem(records[i], item, keyNames)

                })
            }

            // var rec = records[2];
            //rec.beginEdit();
            // rec.set('MFO', 23423242);
            //rec.dirty = true;
            // rec.endEdit();
            // rec.commit();

            // var editInform = grid.metadata.AddEditRowsInform;

        },

        getAddingRowsFromGrid: function (grid) {
            var records = grid.store.data.items;
            if (!records || records.length < 1)
                return null;
            thisUtils = this;
            var metadata = grid.metadata;
            var columnsinfo = metadata.nativeMetaColumns
            var addingArray = new Array();
            Ext.each(records, function (record) {
                if (record.phantom) {
                    var rowModel = thisUtils.getAddEditItemFromRecord(record, columnsinfo);
                    if (rowModel)
                        addingArray.push(rowModel);
                }

            })
            return addingArray;
        },

        getDeletingRows: function (records, metadata) {
            thisUtils = this;

            var columnsinfo = metadata.nativeMetaColumns
            var deletingArray = new Array();
            Ext.each(records, function (record) {
                var rowModel = thisUtils.getDeleteItemFromRecord(record, columnsinfo);
                if (rowModel)
                    deletingArray.push(rowModel);
            })
            return deletingArray;
        },

        getEdtiPlugin: function (referenceGrid) {
            var cellEditing = Ext.create('ExtApp.view.refBook.CustomElements.RefCellEditor', {
                clicksToEdit: 1,
                pluginId: "cellEditPlugin",
                //clicksToMoveEditor: 0,
                listeners: {
                    beforeedit: function (editor, event, opts) {
                        //Эта проверка  позволяет заблокировать редактирование в случае когда можно только добавлять tableMode = 3
                        //if (!event.record.phantom) {
                        //    return referenceGrid.metadata.canUpdate();
                        //}
                    }
                }
            });

            var rowEditing = [{
                pluginId: "rowMultiEdit",
                ptype: "rowediting",
                clicksToEdit: 1,
                clicksToMoveEditor: 1,
                enableKeyEvents: true,
                //autoCancel: false,
                listeners: {
                    beforeedit: function (editor, event, opts) {
                        //this.addChangedRow(event);
                        Ext.editEvent = event;
                        // Эта проверка  позволяет заблокировать редактирование в случае когда можно только добавлять tableMode = 3
                        if (!event.record.phantom) {
                            return referenceGrid.metadata.canUpdate();
                        }
                    }
                }
            }];

            //rowEditing.on('canceledit', function (context) {
            //    
            //    context.record.store.remove(context.record);
            //});

            var ediPlaginMode = referenceGrid.metadata.AddEditRowsInform.EditorMode;
            switch (ediPlaginMode) {
                case "MULTI_EDIT":
                    return cellEditing; //rowEditing;
                case 'SINGLE_EDIT':
                    return [{
                        pluginId: "rowEditPlugin",
                        ptype: "rowediting",
                        clicksToEdit: 0,
                        clicksToMoveEditor: 1,
                        listeners: {
                            beforeedit: function (editor, event, opts) {
                                // Эта проверка  позволяет заблокировать редактирование в случае когда можно только добавлять tableMode = 3
                                if (!event.record.phantom) {
                                    return referenceGrid.metadata.canUpdate();
                                }
                            }
                        }
                    }]
                default:
                    return [{
                        pluginId: "rowEditPlugin",
                        ptype: "rowediting",
                        clicksToEdit: 0,
                        clicksToMoveEditor: 1,
                        listeners: {
                            beforeedit: function (editor, event, opts) {
                                // Эта проверка  позволяет заблокировать редактирование в случае когда можно только добавлять tableMode = 3
                                if (!event.record.phantom) {
                                    return referenceGrid.metadata.canUpdate();
                                }
                            }
                        }
                    }];
            }


        },

        executeDepAction: function (form, record, dependency) {
            if (!form)
                return;
            if (form.getForm)
                form = form.getForm();
            var record = record;
            _depColName = dependency.DepColName;
            if (dependency.ActionType == "SETREADONLYANDCLEARE" && _depColName) {
                var depField = form.findField(_depColName);
                if (!depField)
                    return;
                depField.setValue('');
                 if(record)
                record.set(_depColName, '');
                depField.setDisabled(true);

            }
            if (dependency.ActionType == "SET_ENABLE_AND_RECOVER" && _depColName) {
                var depField = form.findField(_depColName);
                if (!depField)
                    return;
                if (depField.getValue() != depField.originalValue) {
                    depField.setValue(depField.originalValue);
                     if(record)
                     record.set(_depColName, record.modified[_depColName]);
                }

                depField.setDisabled(false);


            }

        },

        onBeforeEditFormByDependencies: function (form, record, columnsInfo) {
            var Util = this;
            var depColsInfo = Ext.Array.filter(columnsInfo, function (item) { return item.Dependencies && item.Dependencies.length > 0 })
            if (!depColsInfo || depColsInfo.length < 1)
                return;

            Ext.each(depColsInfo, function (colInfo) {
                colInfo.Dependencies.sort(function (a, b) {
                    var nameA = a.Event.toUpperCase(); // ignore upper and lowercase
                    var nameB = b.Event.toUpperCase(); // ignore upper and lowercase
                    if (nameA < nameB) {
                        return -1;
                    }
                    if (nameA > nameB) {
                        return 1;
                    }

                    // names must be equal
                    return 0;
                });
                Ext.each(colInfo.Dependencies, function (item) {
                    Util.parsDependencies(form, record, item);
                })
            })

        },

        parsDependencies: function (form, record, dependency) {
            var Util = this;
            if (!form)
                return;
            var srcField = form.findField(dependency.ColName);
            var srcValue = record.data[dependency.ColName];
            if (srcValue === undefined)
                return;
            if (!srcField)
                return;
            switch (dependency.Event) {
                case 'CHECK':
                    {
                        if (srcValue)
                            Util.executeDepAction(form, record, dependency);
                        break;
                    }
                case 'UNCHECK':
                    {
                        if (!srcValue)
                            Util.executeDepAction(form, record, dependency);
                        break;
                    }
                default:
                    break;
            }
        },

        calculateLabelWidth: function (label) {
            if (label < 10) {
                return parseInt(Ext.getBody().getViewSize().width) * 0.08;
            } else if (10 <= label && label < 20) {
                return parseInt(Ext.getBody().getViewSize().width) * 0.12;
            } else if (20 <= label && label < 30) {
                return parseInt(Ext.getBody().getViewSize().width) * 0.16;
            } else if (30 <= label && label < 40) {
                return parseInt(Ext.getBody().getViewSize().width) * 0.18;
            } else {
                return parseInt(Ext.getBody().getViewSize().width) * 0.2;
            }
        },

        getLabelWidthForPanel: function (items) {
            var maxCountSymbols = 0;
            var maxLengthLabel = 0;
            Ext.Object.each(items, function (index, formItem) {
                if (formItem.fieldLabel && formItem.fieldLabel.length && formItem.fieldLabel.length > maxCountSymbols)
                    maxCountSymbols = formItem.fieldLabel.length;
            });
            maxLengthLabel = this.calculateLabelWidth(maxCountSymbols);
            return maxLengthLabel;
        },

        deleteLineBreaks: function (items) {
            var newItemsArray = new Array();
            Ext.each(items, function (item) {
                var newItem = item;
                if (!newItem || !newItem.fieldLabel || newItem.fieldLabel.indexOf('<br/>') > -1) {
                    newItem.fieldLabel = newItem.fieldLabel.replace('<br/>', ' ');
                    newItem.fieldLabel = newItem.fieldLabel.replace('<br/>', ' ');
                    newItem.fieldLabel = newItem.fieldLabel.replace('<br/>', ' ');
                    newItem.fieldLabel = newItem.fieldLabel.replace('<br/>', ' ');
                }
                newItemsArray.push(newItem);
            })
            return newItemsArray;
        },

        buildModelForRequest: function (model) {
            Ext.iterate(model, function(key, value) {
                if (value === 'undefined')
                    value = '';
            });
        },

        isObjEmpty: function (obj) {
            for (var index in obj) {
                var value = obj[index];
                if (value)
                    return false
            }
            return true;
        },

        createGridModel: function (modelName) {
            return Ext.create(modelName, {
            });
        },

        getFieldType: function (codeType) {
            switch (codeType) {
                case "C": return 'string';
                case "N": return 'float';
                case "E": return 'float';
                case "B": return 'bool';
                case "D": return 'date';
                default: return 'string';
            }
        }
    }




}
);
