

Ext.define('ExtApp.view.refBook.SystemFiltersGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.SystemFiltersGrid',
    minHeight: 350,
    maxHeight: 350,
    //width: 500,
    columns: [],
    id: 'SystemFiltersGridId',
    features: [
        {
            //фильтры по колонкам грида
            ftype: 'filters',
            //делать encode url параметров
            encode: true,
            //фильтр не локальный по уже отобранным данным а серверный
            local: false,
            //название url-параметра который будет отвечать за фильтрацию
            paramPrefix: 'gridFilter'
        }
    ],

    //в данный метод пихаем конфигурацию, которую нужно получить динамически из метаданных
    initComponent: function () {
        //наш грид-представление, конфигурацию которого будем дополнять
        
        var  grid = this;
        var thisController = grid.thisController;
        grid.metadata = grid.thisController.controllerMetadata;
        //устанавливаем заголовок грида по имени таблицы 
        grid.title = grid.thisController.controllerMetadata.filtersMetainfo.SEMANTIC;

        //ширина грида будет установлена динамически в зависимости от ширины колонок
        grid.dynamicGridWidth = 15;

        //первая колонка - номер строки
        var rowNumberColumn = new Ext.grid.RowNumberer({ width: 40, header: '№' });
        grid.columns.push(rowNumberColumn);
        grid.dynamicGridWidth += rowNumberColumn.width;

        //поля модели, вместо модели используем свойство store.fields, которое построит динамическую модель
        var modelFields = new Array();
        //поля для формы редактирования
        var formFields = new Array();
        //цикл по метаданным колонок
        Ext.each(grid.metadata.filtersMetainfo.FiltersMetaColumns, function () {
            var colMetaInfo = this;

            //заполняем поля модели
            modelFields.push(grid.configModelField(colMetaInfo));

            //если нужно отображать поле
            if (colMetaInfo.NOT_TO_SHOW == 0) {
                //заполняем колонки грида
                grid.columns.push(grid.configGridColumn(colMetaInfo));
                //заполняем поля формы редактирования
                formFields.push(ExtApp.utils.RefBookUtils.configFormField(colMetaInfo));
            }
        });

        //присваиваем ширину, которую вычислили динамически
       // grid.width = grid.dynamicGridWidth;
        //минимальная ширина грида, нужна чтобы не прятались кнопки тулбаров
        var minGridWidth = 455;
        if (grid.width < minGridWidth) {
            grid.width = minGridWidth;
        }

        //заполняем свойства формы редактирования грида

        //уже можем создать store, так как у нас есть modelFields
        grid.store = Ext.create('Ext.data.Store', {
            fields: modelFields,
            autoLoad: true,
            pageSize: 10,
            remoteSort: true,
            sorters: grid.metadata.sorters,
            proxy: {
                type: 'ajax',
                url: '/barsroot/ndi/ReferenceBook/GetData',
                //referenceGrid.metadata.filtersMetainfo.TABID +
                //'&tableName=' + referenceGrid.metadata.filtersMetainfo.TABNAME + '&filterTblId=' + referenceGrid.metadata.tableInfo.TABID + '&kindOfFilter=SystemFilter',
                reader: {
                    type: 'json',
                    root: 'data'
                },
                afterRequest: function (req, res) {
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
                    tableId: grid.metadata.filtersMetainfo.TABID === 'undefined' ? '' : grid.metadata.filtersMetainfo.TABID,
                    tableName: grid.metadata.filtersMetainfo.TABNAME === 'undefined' ? '' : grid.metadata.filtersMetainfo.TABNAME,
                    filterTblId: grid.metadata.tableInfo.TABID === 'undefined' ? '' : grid.metadata.tableInfo.TABID,
                    kindOfFilter: 'SystemFilter'
                }
            },
            listeners: {
                load: function (store) {
                    if (grid.metadata.saveFilterLocal) {
                        var filters = grid.thisController.controllerMetadata.applyFilters.SystemBeforeFilters;
                        thisController.SetFiltersByApplyFilters(grid, filters);
                    }

                    //всегда выбирать первую строку
                    //referenceGrid.getSelectionModel().select(0);
                    //устанавливать доступность кнопки сброса фильтра
                    //referenceGrid.down('button#removeFilterButton').setDisabled(true);
                    //referenceGrid.down('button#whereClauseButton').setDisabled(true);
                    //var clearFiltersBtn = referenceGrid.down('button#clearFilterButton');
                    //var anyFilter = referenceGrid.store.proxy.extraParams.externalFilter != null &&
                    //    referenceGrid.store.proxy.extraParams.externalFilter.length > 0 ||
                    //    referenceGrid.filters.getFilterData().length > 0;
                    //clearFiltersBtn.setDisabled(!anyFilter);
                    //выключим альтернативный индикатор загрузки в заголовке грида

                    //Ext.select('.x-panel-header-text:first').removeCls('x-mask-msg-text');

                }
            }
        });

        //добавляем к гриду всякие пэйджинги, тулбары 
        grid.dockedItems = [
        {
            xtype: 'pagingtoolbar',
            dock: 'bottom',
            store: grid.store,
            beforePageText: 'системні фільтри',
            afterPageText: '',
            plugins: [new Ext.ux.PageSizePlugin()],
            // displayMsg: 'Рядків на сторінці:',
            items: [

                //{
                //    xtype: 'toolbar',
                //    items: [
                //        {
                //            itemId: 'applySystemFilter',
                //            text: 'застосувати системні фільтри',
                //            tooltip: 'Перегляд рядка в окремому вікні',
                //            //  iconCls: 'book_open',
                //            disabled: false
                //        }
                //    ]
                //}

            ]
        } ];
       
            var filters = grid.thisController.controllerMetadata.applyFilters.SystemBeforeFilters;
            if (grid.metadata.saveFilterLocal && filters && filters.length > 0) {
                grid.dockedItems.push({
                    xtype: 'toolbar',
                    items: [
                    {
                        itemId: 'revertSystemFilters',
                        text: 'відновити фільтри',
                        tooltip: 'обрати фільтри, застосовані минулого разу',
                        iconCls: 'TUDASUDA',
                        disabled: false
                    }]
                });
            }
         
       
       
        ////находим тулбар в dockedItems грида
        //var toolbar = Ext.Array.filter(grid.dockedItems, function (obj) {
        //    return obj.xtype == "toolbar";
        //})[0];


    //    var filters = grid.thisController.controllerMetadata.applyFilters.CustomBeforeFilters;
    //    if (grid.metadata.saveFilterLocal && filters && filters.length > 0) {
    //        toolbar.items.push(
    //            {
    //                xtype: 'tbseparator'
    //            });
    //        toolbar.items.push(
    //{
    //    itemId: 'revertFilters',
    //    text: 'відновити фільтри',
    //    tooltip: 'обрати фільтри, застосовані минулого разу',
    //    iconCls: 'TUDASUDA',
    //    disabled: false
    //});
    //    }
       




        //установить единожды разделители для decimal полей
        Ext.util.Format.thousandSeparator = ' ';
        Ext.util.Format.decimalSeparator = '.';

        
      

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
        var grid = this;
        //заполняем информацию о колонках грида
        var gridColumn = {};
        gridColumn.dataIndex = colMetaInfo.COLNAME;
        //для переноса строк в названиях колонок
        if (colMetaInfo.SEMANTIC != null) {
            gridColumn.header = colMetaInfo.SEMANTIC.replace(/~/g, "<br/>");
        }
        gridColumn.width = this.calcColWidth(colMetaInfo.SHOWWIDTH);
        grid.dynamicGridWidth += gridColumn.width;

        gridColumn.filter = {
            type: grid.getFilterType(colMetaInfo.COLTYPE)
        };

        //получаем элемент для редактирования поля в зависимости от типа данных
        gridColumn.editor = { xtype: ExtApp.utils.RefBookUtils.getFieldEditor(colMetaInfo.COLTYPE) };
        //если при редактировании данные должны выбираться из справочника, то editor грида ставим комбобокс, а так же указываем откуда брать данные
        if (colMetaInfo.SrcTableName) {
            gridColumn.editor.xtype = "refCombobox";
            gridColumn.editor.SrcTableName = colMetaInfo.SrcTableName;
            gridColumn.editor.SrcColName = colMetaInfo.SrcColName;
            gridColumn.editor.SrcTextColName = colMetaInfo.SrcTextColName;
        }

        if (colMetaInfo.COLTYPE == "B") {
            //если тип колонки bool, представляем в виде чекбокс
            gridColumn.xtype = 'checkcolumn';
            gridColumn.listeners = {
                //нужно для того чтобы чекбоксы были readonly
                // beforecheckchange: function () { return false; }
                checkchange: function (comp, rowIndex, checked, eOpts) {
                    
                    var thisGrid = this.up('grid');
                    var thisController = thisGrid.thisController;
                    thisController.updateApplyFilters(thisGrid);
                    //grid.thisController.controllerMetadata.applyFilters.SystemBeforeFilters = [];
                    //thisGrid.getStore().each(function (record) {
                    //    if (record.data['IsApplyFilter'] == 1)
                    //        grid.thisController.controllerMetadata.applyFilters.SystemBeforeFilters.push({
                    //            //к имени поля добавляем имя таблицы
                    //            FILTER_ID: record.data['FILTER_ID'],
                    //            Where_clause: record.data['Where_clause']
                    //        });
                    //});
                    if (grid.thisController.controllerMetadata.mainGrid)
                        grid.thisController.updateGridByFilters();
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
            gridColumn.renderer = grid.gridColumnRenderer;
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
            if (sizeInches < 1.15) {
                sizeInches = 1.15;
            }
            var sizePixels = sizeInches * 96;
            return sizePixels;
        }
        else {
            return 1.15 * 96;
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

    //получить значение параметра текущего url по имени
    getUrlParameterByName: function (name) {
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
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