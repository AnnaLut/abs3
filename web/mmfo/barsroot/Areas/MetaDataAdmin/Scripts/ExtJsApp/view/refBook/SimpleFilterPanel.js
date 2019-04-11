Ext.define('ExtApp.view.refBook.SimpleFilterPanel', {
    extend: 'Ext.form.Panel',
    alias: 'widget.SimpleFilterPanel',
    title: 'прості фільтри',
    id: 'SimpleFilterPanelId',
    items: [
               {
                  
                      xtype: 'toolbar',
                      itemid: 'testbuttonId',
                      items:[ {
                          text: 'Очистити',
                          iconCls: 'minus_once',
                          itemId: 'removeSymple',
                          handler: function (btn) {
                              btn.up('panel').down('form').getForm().reset();
                          }
                      },
                       btnSave = {
                           xtype: 'button',
                           text: 'Зберегти',
                           itemId: 'btnSaveSimpleFilterId',
                           iconCls: 'save_brown',
                           handler: function (btn) {
                               var form = btn.up('panel').down('form').getForm();
                               var sympleFilterRows = ExtApp.utils.RefBookUtils.buildSympleFilterFromForm(form);
                               var filterNameParam = new Object();
                               Controller.writeFilter(1, sympleFilterRows, null);
                           }
                       },
                           btnExec = {
                               xtype: 'button',
                               text: 'Застосувати та запам\'ятати',
                               itemId: 'createSympleFilter',
                               iconCls: 'save',
                               handler: function (btn) {
                                   var form = btn.up('panel').down('form').getForm();
                                   var sympleFilterRows = ExtApp.utils.RefBookUtils.buildSympleFilterFromForm(form);
                                   var filterNameParam = new Object();
                                   filterNameParam.Name = 'filterName';
                                   filterNameParam.value = 'Простий фільтр';
                                   Controller.saveFilterBtnHandler(filterNameParam, 0, sympleFilterRows, null);
                               }
                      }]
                  
               }

    ],
    overflowY: 'auto',
    layout: {
        //размещение элементов вертикально один за одним
        type: 'vbox',
        //дочерние элементы растягиваются на всю ширину
        align: 'stretch'
    },
    bodyPadding: 0,
    //без данного признака значения originalValue полей формы undefined при закачке данных на форму
    trackResetOnLoad: true,
    border: false,
    autoscroll: true,
    constructor: function (thisControllerObject) {
        var self = this;
        Controller = thisControllerObject.thisController;
        columns = thisControllerObject.thisController.controllerMetadata.SympleFilters;
       
        //var form = self.down('mainFormPanel').getForm();
        //columns = sympleFiltersParameter.SympleFilters;
        //Ext.each(sympleFiltersParameter.SympleFilters, function (item) {deletуLineBreaks
        //    form.items.push(item);
        //})
       
     
        self.callParent();

    },
    initComponent: function () {
        var self = this;
        self.items.push(
            {
                title: 'введіть значення для фільтрації',
                items: Ext.create('ExtApp.view.refBook.SypleFilterFormPanel', {
                    items: ExtApp.utils.RefBookUtils.deleteLineBreaks(columns),
                    height: 270,
                    fieldDefaults: {
                        labelAlign: 'left',
                        labelWidth: ExtApp.utils.RefBookUtils.getLabelWidthForPanel(columns)
                    }
                }),
                autoscroll: true,
                width: '100%'
            })
        this.callParent();
    }
})

var columns;
var Controller;