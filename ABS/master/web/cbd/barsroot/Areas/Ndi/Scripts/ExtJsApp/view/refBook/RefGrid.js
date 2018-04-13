Ext.define('ExtApp.view.refBook.RefGrid', {
  extend: 'Ext.grid.Panel',
  alias: 'widget.referenceGrid',
  margin: 10, 
   
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

  //в данный метод пихаем конфигурацию, которую нужно получить динамически из метаданных
  initComponent: function() {
    //наш грид-представление, конфигурацию которого будем дополнять
    var referenceGrid = this;

    //устанавливаем заголовок грида по имени таблицы 
    referenceGrid.title = referenceGrid.metadata.tableInfo.SEMANTIC;

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
    Ext.each(referenceGrid.metadata.columnsInfo, function() {
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
    referenceGrid.editForm = {
      items: formFields,
      //события формы
      listeners: {
        beforerender: function(formPanel) {
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
              referenceGrid.metadata.tableInfo.TABID +
              '&tableName=' + referenceGrid.metadata.tableInfo.TABNAME,
          reader: {
              type: 'json',
              root: 'data'
          },
          afterRequest: function(req, res) {
              var response = Ext.decode(req.operation.response.responseText);
              if (response.status !== "ok") {
                  Ext.Msg.show({
                      title: "Не вдалося отримати дані для цієї таблиці (id=" + tableId + ")",
                      msg: response.errorMessage,
                      icon: Ext.Msg.ERROR,
                      buttons: Ext.Msg.OK
                  });
              }
          },
          //дополнительные параметры которые передадутся в url
          extraParams: {
              startFilter: Ext.encode(referenceGrid.metadata.startFilter), //Ext.encode(referenceGrid.metadata.startFilter)
              //передаем параметр с информацией о доп. фильтрации вычитки данных (используется для проваливания в другие справочники)
              fallDownFilter: referenceGrid.getUrlParameterByName("fallDownFilter")
          }
      },
      listeners: {
        load: function (store) {
          //всегда выбирать первую строку
          //referenceGrid.getSelectionModel().select(0);
          //устанавливать доступность кнопки сброса фильтра
            var clearFiltersBtn = referenceGrid.down('button#clearFilterButton');
            var anyFilter = referenceGrid.store.proxy.extraParams.externalFilter != null &&
                referenceGrid.store.proxy.extraParams.externalFilter.length > 0 ||
                referenceGrid.filters.getFilterData().length > 0;
            
            clearFiltersBtn.setDisabled(!anyFilter);
          //выключим альтернативный индикатор загрузки в заголовке грида
          Ext.select('.x-panel-header-text:first').removeCls('x-mask-msg-text');

        },
        beforeload: function () {
          //включим альтернативный индикатор загрузки в заголовке грида
            Ext.select('.x-panel-header-text:first').addCls('x-mask-msg-text');
        }
      }
    });

    //добавляем к гриду всякие пэйджинги, тулбары 
    referenceGrid.dockedItems = [
    {
      xtype: 'pagingtoolbar',
      dock: 'bottom',
      store: referenceGrid.store,
     // displayInfo: true, 
      beforePageText: 'Сторінка',
      afterPageText: '', 
      plugins: [new Ext.ux.PageSizePlugin()],
     // displayMsg: 'Рядків на сторінці:',
      items: [
          '-',
          {
            disabled: true,
            itemId: 'clearFilterButton',
            iconCls: 'clear_filter',
            tooltip: 'Скасувати усі фільтри',
            hidden: false
          }
      ]
    },
    Ext.create('ExtApp.view.refBook.RefGridFilterExt', referenceGrid.metadata.extFilters, this.store),
    {
      xtype: 'toolbar',
      items: [
          {
            itemId: 'formViewButton',
            text: 'Рядок вертикально',
            tooltip: 'Перегляд рядка в окремому вікні',
            iconCls: 'book_open',
            disabled: true
          },
          {
            xtype: 'tbseparator'
          },
          {
            itemId: 'excelButton',
            tooltip: 'Завантажити в Excel',
            iconCls: 'excel',
            menu: [
                { text: 'Усі сторінки', allPages: true },
                { text: 'Поточна сторінка', allPages: false}
            ]
          }
      ]
    }];

    //находим тулбар в dockedItems грида
    var toolbar = Ext.Array.filter(referenceGrid.dockedItems, function (obj) {
      return obj.xtype == "toolbar";
    })[0];

    //если есть произвольные функции к этому справочнику, то в тулбар добавляем кнопку для вызова этих функций
    if (referenceGrid.metadata.tableMode != 1 && referenceGrid.metadata.callFunctions.length > 0) {
      //признак того что есть функций с типом EACH - нужно чтобы включить multiSelect грида 
      var haveEachRowFunction = false;

      //одна кнопка бажет содержать выпадающий список функций
      var menuItemFunctions = new Array();
      Ext.each(referenceGrid.metadata.callFunctions, function (funcMetaInfo) {
          //добавляем все функции кроме типа BEFORE - функции с таким типом вызываются только до загрузки данных в грид
          if (funcMetaInfo.PROC_EXEC != "BEFORE") {
              var menuItem = {};
              //текст для отображения берем из DESCR
              menuItem.text = funcMetaInfo.DESCR;
              //добавляем свойство с метаинформацией о функции для каждой меню-кнопки
              menuItem.metaInfo = funcMetaInfo;
              menuItemFunctions.push(menuItem);

              if (funcMetaInfo.PROC_EXEC == "EACH") {
                  haveEachRowFunction = true;
              }
          }
      });

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

      //добавить дополнительные кнопки в тулбар и rowEditing плагин если корректируемый справочник
      //добавляем кнопки в начало тулбара
    if (referenceGrid.metadata.tableMode != 1) {
        if (referenceGrid.metadata.canInsert()) {
            toolbar.items.unshift(
            {
                itemId: 'addButton',
                text: 'Додати',
                tooltip: 'Додати новий рядок',
                iconCls: 'plus'
            },
            {
                itemId: 'sampleButton',
                text: 'Додати за зразком',
                tooltip: 'Додати за зразком',
                iconCls: 'add-sample',
                disabled: true
            });
        }
        if (referenceGrid.metadata.canDelete()) {
            toolbar.items.unshift({
                itemId: 'removeButton',
                text: 'Видалити',
                tooltip: 'Видалити вибраний рядок',
                iconCls: 'minus',
                disabled: true
            });
        }

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
    };

    //если нужна итоговая строка, добавляем summaryFeature в грид
    if (referenceGrid.metadata.additionalProperties.addSummaryRow == true) {

      referenceGrid.features.push(
          {
            ftype: 'summary',
            //с сервера в store должен прийти json со свойством 'summaryData'
            remoteRoot: 'summaryData'
          });
    }

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
    if (!record.raw.FONT_COLOR_COLIDX || record.raw.FONT_COLOR_COLIDX < 0 || colMetaInfo.COLID == record.raw.FONT_COLOR_COLIDX) {
      var fontColor = record.raw.FONT_COLOR_NAME;
      if (fontColor) {
        cellInfo.tdCls = 'font_' + fontColor;
      }
    }

    if (!record.raw.BG_COLOR_COLIDX || record.raw.BG_COLOR_COLIDX < 0 || colMetaInfo.COLID == record.raw.BG_COLOR_COLIDX) {
      var bgColor = record.raw.BG_COLOR_NAME;
      if (bgColor) {
        cellInfo.tdCls += ' bg_' + bgColor;
      }
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
        value = Ext.util.Format.number(value, colMetaInfo.SHOWFORMAT);
      }
    }
    //проваливания в другие справочники - рендерим колонку как ссылку 
    //если будет null или undefined то будет выводиться ссылка с "null"
    if (value && colMetaInfo.FallDownInfo) {
        var filterInfo = {};
        filterInfo.FilterCode = colMetaInfo.FallDownInfo.FilterCode;
        filterInfo.FilterParams = new Array();

        for (var i = 0; i < colMetaInfo.FallDownInfo.Columns.length; i++) {
            var colType = this.getColType(columnsInfo, colMetaInfo.FallDownInfo.Columns[i]);
            filterInfo.FilterParams.push({
                Name: colMetaInfo.FallDownInfo.Columns[i],
                Value: record.data[colMetaInfo.FallDownInfo.Columns[i]],
                Type: colType//colMetaInfo.COLTYPE
            });
        }

        var filterInfoUrlParam = encodeURIComponent(Ext.encode(filterInfo));

        var href = "/barsroot/ndi/referencebook/referenceGrid?tableid=" + colMetaInfo.FallDownInfo.TableId + "&mode=RO" + "&fallDownFilter=" + filterInfoUrlParam;
        //в данных строки в атрибуте REF_<COLNAME> хранится сама ссылка 
        value = Ext.String.format('<a href="{0}">{1}</a>', href, value);
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
    Ext.each(columnsInfo, function(col) {
        if (col.COLNAME === colName) {
            result = col.COLTYPE;
            return false;
        }
    });
    return result;
  },
 
  renderTo: Ext.getBody()
});

