
Ext.define('ExtApp.view.refBook.SystemFiltersGrid', {
        extend: 'Ext.grid.Panel',
        alias: 'widget.referenceGrid2',
        height: 300,
        width: 500,
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
            var referenceGrid = this;
            referenceGrid.metadata = referenceGrid.thisController.controllerMetadata;
            //устанавливаем заголовок грида по имени таблицы 
            referenceGrid.title = referenceGrid.thisController.controllerMetadata.filtersMetainfo.SEMANTIC;

            //ширина грида будет установлена динамически в зависимости от ширины колонок
            referenceGrid.dynamicGridWidth = 15;

            //первая колонка - номер строки
            var rowNumberColumn = new Ext.grid.RowNumberer({ width: 40, header: '№' });
            referenceGrid.columns.push(rowNumberColumn);
            referenceGrid.dynamicGridWidth += rowNumberColumn.width;

            //поля модели, вместо модели используем свойство store.fields, которое построит динамическую модель
            var modelFields = new Array();
            //поля для формы редактирования
            var formFields = new Array();
            //цикл по метаданным колонок
            Ext.each(referenceGrid.metadata.filtersMetainfo.FiltersMetaColumns, function () {
                var colMetaInfo = this;

                //заполняем поля модели
                modelFields.push(referenceGrid.configModelField(colMetaInfo));

                //если нужно отображать поле
                if (colMetaInfo.NOT_TO_SHOW == 0) {
                    //заполняем колонки грида
                    referenceGrid.columns.push(referenceGrid.configGridColumn(colMetaInfo));
                    //заполняем поля формы редактирования
                    formFields.push(ExtApp.utils.RefBookUtils.configFormField(colMetaInfo));
                }
            });

            //присваиваем ширину, которую вычислили динамически
            referenceGrid.width = referenceGrid.dynamicGridWidth;
            //минимальная ширина грида, нужна чтобы не прятались кнопки тулбаров
            var minGridWidth = 455;
            if (referenceGrid.width < minGridWidth) {
                referenceGrid.width = minGridWidth;
            }

            //заполняем свойства формы редактирования грида

            //уже можем создать store, так как у нас есть modelFields
            referenceGrid.store = Ext.create('Ext.data.Store', {
                fields: modelFields,
                autoLoad: true,
                pageSize: 10,
                remoteSort: true,
                sorters: referenceGrid.metadata.sorters,
                proxy: {
                    type: 'ajax',
                    url: '/barsroot/ndi/ReferenceBook/GetData?tableId=' +
                        referenceGrid.metadata.filtersMetainfo.TABID +
                        '&tableName=' + referenceGrid.metadata.filtersMetainfo.TABNAME + '&filterTblId=' + referenceGrid.metadata.tableInfo.TABID + '&kindOfFilter=SystemFilter',
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
                    }
                }
            });

            //добавляем к гриду всякие пэйджинги, тулбары 
            referenceGrid.dockedItems = [
            {
                xtype: 'pagingtoolbar',
                dock: 'bottom',
                store: referenceGrid.store,
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
            },
            ];

            ////находим тулбар в dockedItems грида
            //var toolbar = Ext.Array.filter(referenceGrid.dockedItems, function (obj) {
            //    return obj.xtype == "toolbar";
            //})[0];




            //установить единожды разделители для decimal полей
            Ext.util.Format.thousandSeparator = ' ';
            Ext.util.Format.decimalSeparator = '.';

            //TODO: перенести в locale файл
            Ext.grid.RowEditor.prototype.saveBtnText = "Зберегти";
            Ext.grid.RowEditor.prototype.cancelBtnText = "Відмінити";

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
            var referenceGrid = this;
            //заполняем информацию о колонках грида
            var gridColumn = {};
            gridColumn.dataIndex = colMetaInfo.COLNAME;
            //для переноса строк в названиях колонок
            if (colMetaInfo.SEMANTIC != null) {
                gridColumn.header = colMetaInfo.SEMANTIC.replace(/~/g, "<br/>");
            }
            gridColumn.width = this.calcColWidth(colMetaInfo.SHOWWIDTH);
            referenceGrid.dynamicGridWidth += gridColumn.width;

            gridColumn.filter = {
                type: referenceGrid.getFilterType(colMetaInfo.COLTYPE)
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
                        referenceGrid.thisController.controllerMetadata.SystemBeforeFilters = [];
                        thisGrid.getStore().each(function (record) {
                            if (record.data['IsApplyFilter'] == 1)
                                referenceGrid.thisController.controllerMetadata.SystemBeforeFilters.push({
                                    //к имени поля добавляем имя таблицы
                                    FILTER_ID: record.data['FILTER_ID'],
                                    WHERE_CLAUSE: record.data['WHERE_CLAUSE']
                                });
                        });
                        if (referenceGrid.thisController.controllerMetadata.mainGrid)
                            referenceGrid.thisController.updateGridByFilters();
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
                gridColumn.renderer = referenceGrid.gridColumnRenderer;
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