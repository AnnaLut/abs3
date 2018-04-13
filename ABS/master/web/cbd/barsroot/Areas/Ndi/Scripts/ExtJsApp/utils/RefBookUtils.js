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
            }

            //если тип колонки bool, проставляем возвращаемое формой значение как {1,0} а не {true,false}
            if (colMetaInfo.COLTYPE == "B") {
                formField.getValue = function() {
                    return colMetaInfo.checked ? 1 : 0;
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
        }
    }
});
