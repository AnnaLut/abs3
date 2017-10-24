﻿Ext.define('ExtApp.view.refBook.RefGrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.referenceGrid',
    id: 'mainReferenceGrid',
    margin: 4,
    columns: [],
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
        }],
    //selModel: new Ext.selection.CheckboxModel({
    //    enableKeyNav: true
    //}),
    overflowY: 'auto',
    viewConfig: {
        focusRow: Ext.emptyFn,
        preserveScrollOnRefresh: true
    },
    maxHeight: document.body.offsetHeight - 20,
    layout: 'fit',
    padding: 4,
    //в данный метод пихаем конфигурацию, которую нужно получить динамически из метаданных
    initComponent: function () {
        //наш грид-представление, конфигурацию которого будем дополнять
        var referenceGrid = this;
        var thisController = referenceGrid.thisController;
        //устанавливаем заголовок грида по имени таблицы 
        referenceGrid.title = referenceGrid.metadata.tableInfo.SEMANTIC;
        var semantic = referenceGrid.metadata.tableInfo.SEMANTIC;
        if (window.parent && window.parent.document)
            window.parent.document.title = semantic;
        else
            document.title = semantic;
        //ширина грида будет установлена динамически в зависимости от ширины колонок
        referenceGrid.dynamicGridWidth = 15;
        var funcForeSelect = Ext.Array.findBy(referenceGrid.metadata.callFunctions, function (i) { return i.PROC_EXEC == "EACH" });
        if (funcForeSelect)
        {
            referenceGrid.selModel = new Ext.selection.CheckboxModel({
                enableKeyNav: true
            });
            referenceGrid.metadata.hasCheckBoxSelectColumn = true;
        }
        
        //первая колонка - номер строки
        var rowNumberColumn = new Ext.grid.RowNumberer({ width: 40, header: '№' });
        referenceGrid.columns.push(rowNumberColumn);
        referenceGrid.dynamicGridWidth += rowNumberColumn.width;

        //поля модели, вместо модели используем свойство store.fields, которое построит динамическую модель
        var modelFields = new Array();
        //поля для формы редактирования
        var formFields = new Array();

        //цикл по метаданным колонок
        Ext.each(referenceGrid.metadata.columnsInfo, function () {
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

        referenceGrid.editForm = {
            items: formFields,
            //события формы
            listeners: {
                beforerender: function (formPanel) {

                    var form = formPanel.getForm();
                    //разрешить редактировать поля с признаком NOT_TO_EDIT если выполняется добавление новой записи
                    if (form.getRecord().phantom) {
                        var notToEditCols = Ext.Array.filter(referenceGrid.metadata.columnsInfo, function (col) { return col.NOT_TO_EDIT == 1; });
                        Ext.each(notToEditCols, function () {
                            form.findField(this.COLNAME).setReadOnly(false);
                        });
                    }

                    //если не режим редактирования, то сделать все поля ReadOnly
                    if (!(referenceGrid.metadata.canUpdate() || referenceGrid.metadata.canInsert())) {
                        var allFormFields = form.getFields();
                        allFormFields.each(function (field) {
                            field.setReadOnly(true);
                        });
                        //также задисейблить кнопку "Зберегти"
                        formPanel.up("window").down("#okButton").setDisabled(true);
                    }
                }
            }
        };
        var pageSize = referenceGrid.metadata.tableInfo.LINESDEF && referenceGrid.metadata.tableInfo.LINESDEF != 'undefined' ? referenceGrid.metadata.tableInfo.LINESDEF : 10;
        var getDataUrl =  '/barsroot/ndi/ReferenceBook/GetData?tableId=' +
                    referenceGrid.metadata.tableInfo.TABID +
                    '&tableName=' + referenceGrid.metadata.tableInfo.TABNAME +
                    "&CodeOper=" + window.CodeOper + "&nativeTabelId=" + window.nativeTabelId +
                    "&sParColumn=" + window.sParColumn + "&nsiTableId=" + window.nsiTableId + "&nsiFuncId=" + window.nsiFuncId +
                    "&executeBeforFunc=" + window.executeBeforFunc + "&filterCode=" + window.filterCode;
        //уже можем создать store, так как у нас есть modelFields
        referenceGrid.store = Ext.create('Ext.data.Store', {
            fields: modelFields,
            autoLoad: true,
            pageSize: pageSize,
            remoteSort: true,
            sorters: referenceGrid.metadata.sorters,
            proxy: {
                type: 'ajax',
                url: getDataUrl,
                reader: {
                    type: 'json',
                    root: 'data'
                },
                afterRequest: function (req, res) {
                    window.executeBeforFunc = 'no';
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
                //дополнительные параметры которые передадутся в url
                extraParams: {
                    startFilter: referenceGrid.metadata.startFilter,
                    dynamicFilter: referenceGrid.metadata.dynamicFilter,
                    //CustomFilters: Ext.encode(referenceGrid.metadata.CustomFilters),
                    jsonSqlProcParams: window.jsonSqlProcParams,
                    base64jsonSqlProcParams: window.base64jsonSqlProcParams,
                    isReserPages: false
                    //Ext.encode(referenceGrid.metadata.startFilter)
                    //передаем параметр с информацией о доп. фильтрации вычитки данных (используется для проваливания в другие справочники)
                    //fallDownFilter: referenceGrid.getUrlParameterByName("fallDownFilter")
                }
            },
            listeners: {
                load: function (store) {
                    //всегда выбирать первую строку
                    //referenceGrid.getSelectionModel().select(0);
                    //устанавливать доступность кнопки сброса фильтра
                    var clearFiltersBtn = referenceGrid.down('button#clearFilterButton');
                    //var applyFiltersBtn = referenceGrid.down('button#applyFilterButton');
                    var anyFilter = (referenceGrid.store.proxy.extraParams.externalFilter  && referenceGrid.store.proxy.extraParams.externalFilter.length > 0) ||
                        (referenceGrid.store.proxy.extraParams.dynamicFilter && referenceGrid.store.proxy.extraParams.dynamicFilter.length > 0) || 
                        (referenceGrid.store.proxy.extraParams.startFilter  && referenceGrid.store.proxy.extraParams.startFilter.length > 0) ||
                        referenceGrid.filters.getFilterData().length > 0;

                    referenceGrid.store.proxy.extraParams.isReserPages = false;
                    clearFiltersBtn.setDisabled(!anyFilter);
                    //var aplyStartFilter = referenceGrid.metadata.CustomFilters != null && referenceGrid.metadata.CustomFilters.length > 0;
                    //applyFiltersBtn.setDisabled(!aplyStartFilter);
                    //выключим альтернативный индикатор загрузки в заголовке грида
                    Ext.select('.x-panel-header-text:first').removeCls('x-mask-msg-text');

                },
                beforeload: function () {
                    //включим альтернативный индикатор загрузки в заголовке грида
                    Ext.select('.x-panel-header-text:first').addCls('x-mask-msg-text');
                }
                //, afterrender: function () {
                //    this.getUpdater().disableCaching = true;
                //}
            }
        });
        var separator = {
            xtype: 'tbseparator'
        };
        //добавляем к гриду всякие пэйджинги, тулбары 
        referenceGrid.dockedItems = [
        {
            xtype: 'pagingtoolbar',
            dock: 'bottom',
            store: referenceGrid.store,
            displayInfo: true, 
            beforePageText: 'Сторінка',
            afterPageText: '',
            plugins: [new Ext.ux.PageSizePlugin(referenceGrid.store.pageSize)],
            // displayMsg: 'Рядків на сторінці:',
            items: [
                '-',
                {
                    disabled: true,
                    itemId: 'clearFilterButton',
                    iconCls: 'clear_filter',
                    tooltip: 'Скасувати усі фільтри',
                    hidden: false
                },

                {
                    xtype: 'tbseparator'
                },

                //{
                //    disabled: true,
                //    itemId: 'applyFilterButton',
                //    iconCls: 'ux-gridfilter-text-icon',
                //    tooltip: 'застосувати фільтри',
                //    hidden: false
                //},
            ]
        },
        Ext.create('ExtApp.view.refBook.FilterPanel', { metadata: referenceGrid.metadata }),
        //Ext.create('ExtApp.view.refBook.RefGridFilterExt', referenceGrid.metadata.extFilters, this.store),
        dymanicButtonContainer = {
            itemid: 'container1',
            type: 'contater',
            alias: 'widget.mycontater',
            hidden: true,
            items: [

            ]
        },
        {
            itemid: 'staticToolbar',
            xtype: 'toolbar',
            items: [
                //{
                //    itemId: 'formViewButton',
                //    text: 'Рядок вертикально',
                //    tooltip: 'Перегляд рядка в окремому вікні',
                //    iconCls: 'book_open',
                //    disabled: true
                //},
                //{
                //    xtype: 'tbseparator'
                //},
                {
                    itemId: 'excelButton',
                    tooltip: 'Завантажити в Excel',
                    iconCls: 'excel',
                    menu: [
                          { xtype: 'button', text: 'Усі сторінки', allPages: true },
                          { xtype: 'button', text: 'Поточна сторінка', allPages: false }
                    ]
                }
            ]
        }];

        //functionToolbar.items.push({ text: 'sfdfds',xtype: 'button' });
        //functionToolbar.items.push(newButton);

        ////находим тулбар в dockedItems грида
        var toolbar = Ext.Array.filter(referenceGrid.dockedItems, function (obj) {
            return obj.itemid == "staticToolbar" ? obj.xtype = 'toolbar' : obj.itemid == "staticToolbar";
        })[0];
        //если есть произвольные функции к этому справочнику, то в тулбар добавляем кнопку для вызова этих функций
        if (referenceGrid.metadata.callFunctions.length > 0) {
            //признак того что есть функций с типом EACH - нужно чтобы включить multiSelect грида 
            var haveEachRowFunction = false;
            //одна кнопка бажет содержать выпадающий список функций
            var menuItemFunctions = new Array();
            var menuItemFunctionsInToolbar = new Array();
            Ext.each(referenceGrid.metadata.callFunctions, function (funcMetaInfo) {
                //добавляем все функции кроме типа BEFORE - функции с таким типом вызываются только до загрузки данных в грид
                if (funcMetaInfo.PROC_EXEC != "BEFORE") {
                    var menuItem = Ext.create('Ext.Button');
                    //текст для отображения берем из DESCR
                    
                    //добавляем свойство с метаинформацией о функции для каждой меню-кнопки
                    menuItem.metaInfo = funcMetaInfo;
                    if (funcMetaInfo.ICON_ID && funcMetaInfo.ICON_ID != '' && funcMetaInfo.IconClassName && funcMetaInfo.IconClassName != '') {
                        menuItem.iconCls = funcMetaInfo.IconClassName;
                        
                       // var path = 'background-image: url(' + funcMetaInfo.
                        //menuItem.style = 'background-image: url(/barsroot/Content/Themes/ExtJs/custom/icons/new_ic/BMP/BF8_.png) !important;';
                        menuItem.tooltip = funcMetaInfo.DESCR;
                        menuItemFunctionsInToolbar.push(menuItem);
                    }
                    else {
                       // menuItem.iconCls = 'function-button-name';
                        menuItem.text = funcMetaInfo.DESCR;
                        menuItemFunctions.push(menuItem);
                    }
                    if (funcMetaInfo.PROC_EXEC == "EACH") {
                        haveEachRowFunction = true;
                    }
                }
            });

            if (menuItemFunctionsInToolbar.length > 0)
                toolbar.items.push(
                      functionToolbar = {
                          xtype: 'toolbar',
                          itemid: 'functionToolbar',
                          items: menuItemFunctionsInToolbar.splice(0, 15)
                      });
            if (menuItemFunctionsInToolbar.length > 0) {
                functionToolbar2 = {
                    xtype: 'toolbar',
                    itemid: 'functionToolbar',
                    items: []
                }
                Ext.each(menuItemFunctionsInToolbar, function (item) {
                    functionToolbar2.items.push(item);
                })
                dymanicButtonContainer.hidden = false;
                dymanicButtonContainer.items.push(functionToolbar2);
            }

            if (menuItemFunctions.length != 0)  // если список доступных функ. - 0, тогда не добавлять элемент
                toolbar.items.push(
                {
                    itemId: 'callFuncButton',
                    tooltip: 'Виконання процедури',
                    iconCls: 'arrow_right',
                    //arrowCls: '',
                    menu: menuItemFunctions
                });

            //если в функция для вызова типа EACH, то добавить в грид возможность множественного выделения строк
            if (haveEachRowFunction) {
                referenceGrid.multiSelect = true;
            }
        }

        if (referenceGrid.metadata.canUpdate()) {
            toolbar.items.unshift({
                itemId: 'formViewButton',
                text: 'Рядок вертикально',
                tooltip: 'Перегляд рядка в окремому вікні',
                iconCls: 'book_open',
                disabled: true
            });
        }

        //добавить дополнительные кнопки в тулбар и rowEditing плагин если корректируемый справочник
        //добавляем кнопки в начало тулбара
        if (referenceGrid.metadata.canInsert()) {
            toolbar.items.unshift(
            {
                itemId: 'addButton',
                text: 'Додати',
                tooltip: 'Додати новий рядок',
                iconCls: 'plus',
                disabled: false
            },
            {
                itemId: 'sampleButton',
                text: 'Додати за зразком',
                tooltip: 'Додати за зразком',
                iconCls: 'add-sample',
                disabled: true
            })
        };
        //if (true) {
        //    toolbar.items.unshift(
        //         {
        //             itemId: 'FormToInsertBtn',
        //             text: 'додати',
        //             tooltip: 'Додаты рядок формою',
        //             iconCls: 'add-sample'
        //         })
        //};

        if (!referenceGrid.metadata.canUpdate()) {
            toolbar.items.unshift(
            {
                itemId: 'ViewInfo',
                text: 'перегляд',
                tooltip: 'Інформаційне вікно',
                iconCls: 'SEARCH',
                disabled: true
            })
            };

        if (referenceGrid.metadata.canInsert() || referenceGrid.metadata.canUpdate()) {
            //добавляем плагин редактирования
            referenceGrid.plugins = [{
                pluginId: "rowEditPlugin",
                ptype: "rowediting",
                clicksToEdit: 0,
                clicksToMoveEditor: 1,
                listeners: {
                    beforeedit: function (editor, event, opts) {
                        //Эта проверка  позволяет заблокировать редактирование в случае когда можно только добавлять tableMode = 3
                        if (!event.record.phantom) {
                            return referenceGrid.metadata.canUpdate();
                        }
                    }
                }
            }];
           
        }
        if (referenceGrid.metadata.canDelete()) {
            
            toolbar.items.unshift({
                itemId: 'removeButton',
                text: 'Видалити',
                tooltip: 'Видалити вибраний рядок',
                iconCls: 'minus_once',
                disabled: true
            });
        };
        //если нужна итоговая строка, добавляем summaryFeature в грид
        //if (referenceGrid.metadata.additionalProperties.addSummaryRow == true) {
       
            referenceGrid.features.push(
                {
                    ftype: 'summary',
                    //с сервера в store должен прийти json со свойством 'summaryData'
                    remoteRoot: 'summaryData'
                });
       // }

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
        if (colMetaInfo.COLTYPE == "N") {
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

        //получаем ограничивающий элемент для вадидации ячейки в зависимости от типа данных
        gridColumn.editor = {
            xtype: ExtApp.utils.RefBookUtils.getFieldEditor(colMetaInfo.COLTYPE)
        };
        
        if (colMetaInfo.SHOWMAXCHAR)
        {
            if (gridColumn.editor.xtype == "numberfield") {
               maxValue = Math.pow(10, colMetaInfo.SHOWMAXCHAR  );
               gridColumn.editor.maxValue = maxValue;
               gridColumn.editor.minValue = -1 * maxValue;
            } else if (gridColumn.editor.xtype == "textfield") {
                gridColumn.editor.maxLength = colMetaInfo.SHOWMAXCHAR;
            }
        }
        //проверка ограничение длинны поля в зависимости от типа поля
        
        //if (colMetaInfo.DYN_TABNAME && colMetaInfo.DYN_TABNAME != '')
        //{
        //    gridColumn.editor.xtype = "refCombobox";
        //    gridColumn.editor.SrcTableName = this.getTabName();
            
        //}
        //else
        //если при редактировании данные должны выбираться из справочника, то editor грида ставим комбобокс, а так же указываем откуда брать данные
        if (colMetaInfo.SrcTableName) {
            gridColumn.editor.xtype = "refCombobox";
            gridColumn.editor.SrcTableName = colMetaInfo.SrcTableName;
            gridColumn.editor.SrcColName = colMetaInfo.SrcColName;
            gridColumn.editor.SrcTextColName = colMetaInfo.SrcTextColName;
            gridColumn.editor.SrcTab_Alias = colMetaInfo.SrcTab_Alias;
            gridColumn.editor.DYN_TABNAME = colMetaInfo.DYN_TABNAME;
        }

        
        if (colMetaInfo.COLTYPE == "B") {
            //если тип колонки bool, представляем в виде чекбокс
            gridColumn.xtype = 'checkcolumn';
            gridColumn.listeners = {
                //нужно для того чтобы чекбоксы были readonly
                beforecheckchange: function () { return false; }
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
            gridColumn.align = 'right';
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
        gridColumn.summaryRenderer = function (value, summaryData, dataIndex) {
            //индекс текущей колонки
            var columnIndex = summaryData.column.dataIndex;
            //Проверяем, есть ли шаблон, и устанавливаем его
            if (colMetaInfo.SHOWFORMAT) {
                summaryData.record.data[columnIndex] = Ext.util.Format.number(summaryData.record.data[columnIndex], colMetaInfo.SHOWFORMAT)
            }
            //получить данные итоговой строки по индексу колонки
            return summaryData.record.data[columnIndex];
        };
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
            if (sizeInches < 0.5) {
                sizeInches = 0.5;
            }
            var sizePixels = sizeInches * 96;
            return sizePixels;
        }
        else {
            return 1.15 * 96;
        }
    },

    getColor: function (raw, colid, ColorType) {
        var colors = {};
        for(var k in raw){
            var key = k.toString();
            if(key.indexOf("COL_ALL_ALIAS") != -1){
                // COL_ALL_ALIAS_columnNumber_oder_type     type: FontColor = 1, BackgroundColor = 2        see: enum ColorType
                // example: ["COL_ALL_ALIAS", 14, 7, 1]
                var elems = key.split('__');
                if(elems[1] == colid){
                    if(ColorType == parseInt(elems[3])){
                        var color = raw[key];
                        if(color != null && color != "null" && color != ""){
                            colors[parseInt(elems[2])] = color;
                        }
                    }
                }
            }
        }
        var index = -1;
        for(var order in colors){
            if(parseInt(order) > parseInt(index)){
                index = order;
            }
        }
        return index != -1 ? colors[index] : null;
    },

    //рендер колонок грида
    //value - значение текущей ячейки, можем поменять его - добавить произвольный html, раскрасить, отформатировать 
    //cellInfo - информация о текущей ячейке, которая рендерится
    //record - текущая строка таблицы со всеми данными
    gridColumnRenderer: function (value, cellInfo, record) {
        var referenceGrid = this;

        //если пришло на рендер пустое значение
        if (value == null) {
            value = "";
        }

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

        var _bgColorColumn = referenceGrid.getColor(record.raw, colMetaInfo.COLID, 2);
        var _fontColorColumn = referenceGrid.getColor(record.raw, colMetaInfo.COLID, 1);

        var fontColor = _fontColorColumn != null ? _fontColorColumn : record.raw.FONT_ROW_COLOR_NAME;
        var bgColor = _bgColorColumn != null ? _bgColorColumn : record.raw.BG_ROW_COLOR_NAME;

        if (fontColor) {
            cellInfo.tdCls = 'font_' + fontColor;
        }
        // used always after FONT !!!!!
        if (bgColor) {
            cellInfo.tdCls += ' bg_' + bgColor;
        }

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

                if (value < 0) {
                    value = value * -1
                    value = Ext.util.Format.number(value, colMetaInfo.SHOWFORMAT);
                    value = '-' + value;

                }
                else
                    value = Ext.util.Format.number(value, colMetaInfo.SHOWFORMAT);

            }
        }

        if (colMetaInfo.WEB_FORM_NAME) {
            value = Ext.String.format('<a href="#">{0}</a>', value);
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
    getTabName: function () {
        return "Accounts";
    },
    renderTo: Ext.getBody()
});

