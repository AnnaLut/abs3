Ext.define('ExtApp.view.refBook.RefCombobox', {
    extend: 'Ext.form.field.ComboBox',
    alias: 'widget.refCombobox',

    //это для того чтобы содержимое выпадающего списка растягивалось на ширину самой широкой записи
    matchFieldWidth: false,
    listConfig: {
        loadingText: 'Пошук...',
        emptyText: 'Дані не знайдено'
    },
    //признак вывода pagingtoolbar при развертывании комбобокса. по сути работает как true при pageSize > 0 и false при = 0, 
    //а реальный pageSize нужно устанавливать в store 
    pageSize: 10,
    //минимальное количество символов для live-поиска значений
    minChars: 1,
    allowBlank: true,
    valueField: 'ID',
    displayField: 'ID',
    //'all' - при нажатии на expand-кнопку будут выводиться все записи без фильтра, 
    //'query' - записи будут фильтроваться по текущему введенному значению
    triggerAction: 'all',
    //это нужно для крутого форматирования вывода списка после раскрывания комбобокса
    tpl: Ext.create('Ext.XTemplate',
        '<tpl for=".">',
        '<div class="x-boundlist-item"><span style="font-weight:bold;font-size:14px;">{ID}</span> - {NAME}</div>',
        '</tpl>'),
    
    //в initComponent вынесены свойства которые нужно заполнить с учетом переданных данных при создании комбобокса
    initComponent: function () {
        var thisCombo = this;
        thisCombo.listeners = {
            select: function(combo, records) {
                //перечитать наименование после изменения кода (в records[0] лежит код/наименование которое только что выбрали)

                //получаем поле с наименованием, которое состоит из "<имя таблицы>_<имя колонки>"
                var fieldWithName = combo.up('form').getForm().findField(thisCombo.SrcTableName + "_" + thisCombo.SrcTextColName);
                //устанавливаем наименование если в форме редактирования есть поле-наименование для этого комбобокса
                if (fieldWithName) {
                    fieldWithName.setValue(records[0].data.NAME);
                }
            }
        };
        thisCombo.store = Ext.create('Ext.data.ArrayStore', {
            fields: ['ID', 'NAME'],
            pageSize: 10,
            autoLoad: false,
            isLoaded: false,
            proxy: {
                type: 'ajax',
                url: '/barsroot/ndi/ReferenceBook/GetRelatedReferenceData?tableName=' + thisCombo.SrcTableName +
                    '&fieldForId=' + thisCombo.SrcColName + '&fieldForName=' + thisCombo.SrcTextColName,
                reader: {
                    type: 'json',
                    root: 'data'
                },
                afterRequest: function(req, res) {
                    var response = Ext.decode(req.operation.response.responseText);
                    if (response.status == "ok") {
                    } else {
                        Ext.Msg.show({
                            title: "Не вдалося отримати дані",
                            msg: response.errorMessage,
                            icon: Ext.Msg.ERROR,
                            buttons: Ext.Msg.OK
                        });
                    }
                }
            }
        }),
        this.callParent();
    }
});
