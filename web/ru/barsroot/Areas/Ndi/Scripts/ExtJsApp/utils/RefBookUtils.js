Ext.define('ExtApp.utils.RefBookUtils', {
    //так как мы создаем RefCombobox использую xtype, то файл RefCombobox.js должен быть загружен до его использования
    requires: ['ExtApp.view.refBook.RefCombobox'],
    statics: {
        //дефолтные значения для всех колонок, полей формы
        defaults: { dateFormat: 'd.m.Y', decimalPrecision: 5 },

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

            //если при редактировании данные для этого поля должны выбираться из справочника, то элемент редактирования будет комбобокс
            if (colMetaInfo.SrcTableName) {
                formField.xtype = "refCombobox";
                formField.SrcTableName = colMetaInfo.SrcTableName;
                formField.SrcColName = colMetaInfo.SrcColName;
                formField.SrcTextColName = colMetaInfo.SrcTextColName;
                formField.SrcTab_Alias = colMetaInfo.SrcTab_Alias;
                formField.DYN_TABNAME = colMetaInfo.DYN_TABNAME;
            }

            //если тип колонки bool, проставляем возвращаемое формой значение как {1,0} а не {true,false}
            if (colMetaInfo.COLTYPE == "B") {
                formField.getValue = function () {
                    var fieald = this
                    return fieald.checked ? 1 : 0;
                }
            }

            if (colMetaInfo.COLTYPE == "D") {
                formField.format = thisUtils.defaults.dateFormat;
                if (colMetaInfo.SHOWFORMAT) {
                    formField.format = colMetaInfo.SHOWFORMAT;
                }
            }
            if (colMetaInfo.COLTYPE == "N" || colMetaInfo.COLTYPE == "E") {
                formField.decimalPrecision = thisUtils.defaults.decimalPrecision;
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

        configFieldsForeSympleFilters: function (columnsMetaInfo) {
            var self = this;
            var resColumns = new Array();
            Ext.each(columnsMetaInfo, function (col) {
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
                if (field.wasDirty && value != null && value != '' && value != 'undefined') {
                    var param = {};
                    param.LogicalOp = isFirstRow ? '' : 'І';
                    param.Colname = field.name;
                    param.ReletionalOp = thisUtils.getReletionalOperatorForSympleFilter(field.xtype);
                    param.Value = value;
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
                    return 'СХОЖИЙ';
                default:
                    return '=';
            }
        },
        //получить элемент управления для редактирования поля формы по переданному коду типа данных
        getFieldEditor: function (codeType) {
            switch (codeType) {
                case "C":
                    return 'textfield';
                case "N":
                    return 'numberfield';
                case "E":
                    return 'numberfield';
                case "B":
                    return 'checkbox';
                case "D":
                    return 'datefield';
                default:
                    return 'textfield';
            }
        },
        getRefUrl: function (thisCombo) {
            var url
            if (false) {
                var grid = Ext.getCmp('mainReferenceGrid');
                var gridSelectModel = grid.getSelectionModel();
                selectedRow = gridSelectModel.getSelection()[0];
                var tabeName = selectedRow.data['ND'];
                url = '/barsroot/ndi/ReferenceBook/GetRelatedReferenceData?tableName=' + tabeName +
                               '&fieldForId=' + thisCombo.SrcColName + '&fieldForName=' + thisCombo.SrcTextColName;
            }
            else
                url = '/barsroot/ndi/ReferenceBook/GetRelatedReferenceData?tableName=' + thisCombo.SrcTableName +
                               '&fieldForId=' + thisCombo.SrcColName + '&fieldForName=' + thisCombo.SrcTextColName;
            return url;
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
        buildRowToArray: function (row, columnsInfo) {
            var dataArray = new Array();
            Ext.each(columnsInfo, function (item) {
                    dataArray.push({
                        Name: item.COLNAME,
                        //для невводимых параметров тип параметра берем из метаданных колонки, с которой берем значение
                        Type: item.COLTYPE,
                        //присваиваем значению параметра значение с выбранной строки грида
                        Value: row.data[item.COLNAME]
                    });
                
            });
            return dataArray;
        },
        replaceParamsFromRow: function(rowArray,strForReplace)
        {
            Ext.each(rowArray,function (param) {
                var par = ':' + param.Name;
                if(strForReplace.indexOf(par) > 0 )
                    strForReplace =  strForReplace.replace(par, param.Value)
            })
           
            return strForReplace;
        }

    },
    convertDataRerordByFields: function (data, fields) {

        Ext.each(fields.items, function (item) {
            if (item.type.type == 'date' && data[item.name])
                data[item.name].toLocaleDateString();
            
        })
        return data;
    }
}
);
