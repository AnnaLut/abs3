Ext.define('ExtApp.view.refBook.RefGridCustomFilter', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.GridCustomFilter',
    id: 'CustomFilterGrid',
    columns: [],
    minHeight: 350,
    maxHeight: 350,
    //autoExpandColumn: 'lastUpdated',
    
    //в данный метод пихаем конфигурацию, которую нужно получить динамически из метаданных
    initComponent: function () {
        //наш грид-представление, конфигурацию которого будем дополнять
        var customFilterGrid = this;
        var thisController = customFilterGrid.thisController;
        customFilterGrid.metadata = customFilterGrid.thisController.controllerMetadata;
        //устанавливаем заголовок грида по имени таблицы   
        customFilterGrid.title = customFilterGrid.thisController.controllerMetadata.filtersMetainfo.SEMANTIC;

        //ширина грида будет установлена динамически в зависимости от ширины колонок
        customFilterGrid.dynamicGridWidth = 15;

        //первая колонка - номер строки
        var rowNumberColumn = new Ext.grid.RowNumberer({ width: 40, header: '№' });
        customFilterGrid.columns.push(rowNumberColumn);
        customFilterGrid.dynamicGridWidth += rowNumberColumn.width;

        //поля модели, вместо модели используем свойство store.fields, которое построит динамическую модель
        var modelFields = new Array();
        //цикл по метаданным колонок
        Ext.each(customFilterGrid.metadata.filtersMetainfo.FiltersMetaColumns, function () {
            var colMetaInfo = this;

            //заполняем поля модели
            modelFields.push(customFilterGrid.configModelField(colMetaInfo));

            //если нужно отображать поле
            if (colMetaInfo.NOT_TO_SHOW == 0) {
                //заполняем колонки грида
                customFilterGrid.columns.push(customFilterGrid.configGridColumn(colMetaInfo));
            }
        });

        //присваиваем ширину, которую вычислили динамически
        // customFilterGrid.width = customFilterGrid.dynamicGridWidth;
        //минимальная ширина грида, нужна чтобы не прятались кнопки тулбаров
        var minGridWidth = 455;
        if (customFilterGrid.width < minGridWidth) {
            customFilterGrid.width = minGridWidth;
        }

        //заполняем свойства формы редактирования грида
        var getCustFilterModel = {
            tableId: customFilterGrid.metadata.filtersMetainfo.TABID === 'undefined' ? '' : customFilterGrid.metadata.filtersMetainfo.TABID,
            tableName: customFilterGrid.metadata.filtersMetainfo.TABNAME === 'undefined' ? '' : customFilterGrid.metadata.filtersMetainfo.TABNAME,
            filterTblId: customFilterGrid.metadata.tableInfo.TABID === 'undefined' ? '' : customFilterGrid.metadata.tableInfo.TABID,
            kindOfFilter: 'CustomFilter'

        }

        //уже можем создать store, так как у нас есть modelFields
        customFilterGrid.store = Ext.create('Ext.data.Store', {
            fields: modelFields,
            autoLoad: true,
            pageSize: customFilterGrid.metadata.tableInfo.LINESDEF ? customFilterGrid.metadata.tableInfo.LINESDEF : 10,
            remoteSort: true,
            sorters: customFilterGrid.metadata.sorters,
            proxy: {
                type: 'ajax',
                url: '/barsroot/ndi/ReferenceBook/GetData/',
                //referenceGrid.metadata.filtersMetainfo.TABID +
                //'&tableName=' + referenceGrid.metadata.filtersMetainfo.TABNAME + '&filterTblId=' + referenceGrid.metadata.tableInfo.TABID + '&kindOfFilter=CustomFilter',
                reader: {
                    type: 'json',
                    root: 'data'
                },
                method: 'POST',
                afterRequest: function (req, res) {
                    
                    //
                    //window.executeBeforFunc = 'no';
                    var response = Ext.decode(req.operation.response.responseText);
                    if (response.status !== "ok") {
                        Ext.Msg.show({
                            title: "Не вдалося отримати дані для цієї таблиці (id=" + tableId + ")",
                            msg: response.errorMessage + '</br> </br>',
                            icon: Ext.Msg.ERROR,
                            buttons: Ext.Msg.OK
                        });
                    }
                },
                extraParams: {
                    tableId: customFilterGrid.metadata.filtersMetainfo.TABID === 'undefined' ? '' : customFilterGrid.metadata.filtersMetainfo.TABID,
                    tableName: customFilterGrid.metadata.filtersMetainfo.TABNAME === 'undefined' ? '' : customFilterGrid.metadata.filtersMetainfo.TABNAME,
                    filterTblId: customFilterGrid.metadata.tableInfo.TABID === 'undefined' ? '' : customFilterGrid.metadata.tableInfo.TABID,
                    kindOfFilter: 'CustomFilter'
                }
            }
        });

        //добавляем к гриду всякие пэйджинги, тулбары 
        customFilterGrid.dockedItems = [
        {
            xtype: 'pagingtoolbar',
            dock: 'bottom',
            store: customFilterGrid.store,
            beforePageText: 'Фільтри користувача',
            afterPageText: '',
            plugins: [new Ext.ux.PageSizePlugin()],
            // displayMsg: 'Рядків на сторінці:',
            items: [

            ]
        },
        {
            xtype: 'toolbar',
            items: [
                {
                    itemId: 'whereClauseButton',
                    text: 'Перегляд умов фільтра',
                    tooltip: 'Перегляд умов фільтра',
                    iconCls: 'book_open',
                    disabled: true
                },
                {
                    xtype: 'tbseparator'
                },
                {
                    itemId: 'removeFilterButton',
                    text: 'Видалити',
                    tooltip: 'Видалити вибраний рядок',
                    iconCls: 'minus_once',
                    disabled: true
                },
                 {
                     xtype: 'tbseparator'
                 },
                {
                    itemId: 'updateFilterButton',
                    text: 'редагувати фільтр',
                    tooltip: 'редагувати вибраний фільтр',
                    iconCls: 'EDITG',
                    disabled: true
                }


            ]
        }
        ];

        ////находим тулбар в dockedItems грида
        var toolbar = Ext.Array.filter(customFilterGrid.dockedItems, function (obj) {
            return obj.xtype == "toolbar";
        })[0];

        var filters = customFilterGrid.thisController.controllerMetadata.applyFilters.CustomBeforeFilters;
        if (customFilterGrid.metadata.saveFilterLocal && filters && filters.length > 0) {
            toolbar.items.push(
                {
                    xtype: 'tbseparator'
                });
            toolbar.items.push(
    {
        itemId: 'revertCustomFilters',
        text: 'відновити фільтри',
        tooltip: 'обрати фільтри, застосовані минулого разу',
        iconCls: 'TUDASUDA',
        disabled: false
    });
        }
        this.callParent();
    },

    //сконфигурировать поле модели по переданным метаданным
    configModelField: function (colMetaInfo) {
        var referenceGrid = this;
        var modelField = {};
        modelField.name = colMetaInfo.COLNAME;
        modelField.type = referenceGrid.getFieldType(colMetaInfo.COLTYPE);
        modelField.useNull = true;
        if (colMetaInfo.COLTYPE == "D") {
            //указание формата явно нужно только для старых версий эксплорера 
            //остальные понимаю в каком формате дата приходит с сервера в json-е и умеют её преобразовать в javascript Date
            modelField.dateFormat = 'Y-m-dTH:i:s';
        }
        if (colMetaInfo.COLTYPE == "C") {
            //нужно чтоб не обновлять лишние поля: если с базы приходят поля null, то при редактировании они все-равно становятся ""
            modelField.convert = function (value) {
                return (value === null) ? "" : value;
            };
        }
        if (colMetaInfo.COLTYPE == "B") {
            //при установке/снятии галочки checkbox принимает значение true/false, а отправлять для обновления нужно 1/0
            modelField.convert = function (value) {
                return (value === 1 || value === true) ? 1 : 0;
            };
        }
        return modelField;
    },

    //сконфигурировать колонку грида по переданным метаданным
    configGridColumn: function (colMetaInfo) {
        var customFilterGrid = this;
        customFilterGrid.thisGridMetadata = new Object();
        customFilterGrid.thisGridMetadata.wasCheckChange = false;

        //заполняем информацию о колонках грида
        var gridColumn = {};
        gridColumn.dataIndex = colMetaInfo.COLNAME;
        //для переноса строк в названиях колонок
        if (colMetaInfo.SEMANTIC != null) {
            gridColumn.header = colMetaInfo.SEMANTIC.replace(/~/g, "<br/>");
        }
        gridColumn.width = this.calcColWidth(colMetaInfo.SHOWWIDTH);
        customFilterGrid.dynamicGridWidth += gridColumn.width;

        gridColumn.filter = {
            type: customFilterGrid.getFilterType(colMetaInfo.COLTYPE)
        };

        //получаем элемент для редактирования поля в зависимости от типа данных
        gridColumn.editor = { xtype: ExtApp.utils.RefBookUtils.getFieldEditor(colMetaInfo.COLTYPE) };

        if (colMetaInfo.COLTYPE == "B") {
            //если тип колонки bool, представляем в виде чекбокс
            gridColumn.xtype = 'checkcolumn';
            gridColumn.listeners = {
                //нужно для того чтобы чекбоксы были readonly
                // beforecheckchange: function () { return false; }
                checkchange: function () {
                    
                    var revertFilterBtn;
                   
                    var thisController = customFilterGrid.thisController;
                    if (customFilterGrid.thisGridMetadata.wasCheckChange && customFilterGrid.down('#revertCustomFilters'))
                    {
                        revertFilterBtn = customFilterGrid.down('#revertCustomFilters');
                        revertFilterBtn.setDisabled(true);
                        customFilterGrid.thisGridMetadata.wasCheckChange = true;
                    }
                        
                    thisController.updateApplyFilters(customFilterGrid);
                }
            };
        }
        if (colMetaInfo.COLTYPE == "D") {
            //если тип колонки date, представляем в виде колонки типа даты
            gridColumn.xtype = 'datecolumn';
            gridColumn.align = 'center';

            //формат отображения 
            var dateFormat = ExtApp.utils.RefBookUtils.defaults.dateFormat;
            gridColumn.filter.dateFormat = dateFormat;
            gridColumn.editor.format = dateFormat;
            if (colMetaInfo.SHOWFORMAT) {
                gridColumn.editor.format = colMetaInfo.SHOWFORMAT;
            }
        }
        if (colMetaInfo.COLTYPE == "N" || colMetaInfo.COLTYPE == "E") {
            gridColumn.align = 'center';
            //при редактировании введенное значение округлиться до такого кол-ва знаков после запятой 
            gridColumn.editor.decimalPrecision = ExtApp.utils.RefBookUtils.defaults.decimalPrecision;
        }

        //если колонка не для редактирования - дисейблим editor
        if (colMetaInfo.NOT_TO_EDIT == 1) {
            gridColumn.editor.disabled = true;
        }

        //если это колонка из другой таблицы - очищаем editor 
        if (colMetaInfo.IsForeignColumn == true) {
            gridColumn.editor = null;
        }

        //обработчик итоговых строк

        //кастомный обработчик отрисовки, отвечат за форматирование ячеек
        //колоноки с чекбоксами раскрашивать не будем потому что renderer для checkcolumn ломает такие колонки
        if (!gridColumn.renderer && colMetaInfo.COLTYPE !== "B") {
            gridColumn.renderer = customFilterGrid.gridColumnRenderer;
        }

        return gridColumn;
    },

    getFilterType: function (codeType) {
        switch (codeType) {
            case "N": return 'numeric';
            case "E": return 'numeric';
            case "B": return 'boolean';
            case "D": return 'date';
            default: return 'string';
        }
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
    },

    calcColWidth: function (showWidth) {
        //магический расчет ширины - взято из прошлых справочников + помножено на 96 для перевода в пиксели
        if (showWidth && showWidth != null) {
            var sizeInches = showWidth / 1.5;
            if (sizeInches < 1) {
                sizeInches = 1;
            }
            var sizePixels = sizeInches * 96;
            return sizePixels;
        }
        else {
            return 0.8 * 96;
        }
    },

    //рендер колонок грида
    //value - значение текущей ячейки, можем поменять его - добавить произвольный html, раскрасить, отформатировать 
    //cellInfo - информация о текущей ячейке, которая рендерится
    //record - текущая строка таблицы со всеми данными
    gridColumnRenderer: function (value, cellInfo, record) {
        
        //если колонка рендерится в редакторе а не в гриде - ничего не делаем
        if (!cellInfo.column) {
            return value;
        }

        //найдем метаданные текущей колонки
        var colMetaInfo = {};
        var columnsInfo = this.metadata.columnsInfo;
        Ext.each(columnsInfo, function (item) {
            if (item.COLNAME == cellInfo.column.dataIndex) {
                colMetaInfo = item;
                return;
            }
        });

        //раскраска ячеек


        //форматирование дат
        if (colMetaInfo.COLTYPE == "D") {
            var colDateFormat = 'd.m.Y';
            if (colMetaInfo.SHOWFORMAT) {
                colDateFormat = colMetaInfo.SHOWFORMAT;
            }
            value = Ext.Date.format(value, colDateFormat);
        }
        //форматирование числовых полей
        if (colMetaInfo.COLTYPE == "N" || colMetaInfo.COLTYPE == "E") {
            if (colMetaInfo.SHOWFORMAT) {
                value = Ext.util.Format.number(value, colMetaInfo.SHOWFORMAT);
            }
        }




        return value;
    },

    //поиск и возврат типа колонки текущего справочника по названию колонки
    getColType: function (columnsInfo, colName) {
        var result = 'S';
        Ext.each(columnsInfo, function (col) {
            if (col.COLNAME === colName) {
                result = col.COLTYPE;
                return false;
            }
        });
        return result;
    },

    renderTo: Ext.getBody()
});
