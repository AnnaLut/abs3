var columns;
Ext.define('ExtApp.view.refBook.SimpleFilterPanel', {
    extend: 'Ext.form.Panel',
    alias: 'widget.SimpleFilterPanel',
    title: 'прості фільтри',
    items: [
               {
                  
                      xtype: 'toolbar',
                      itemid: 'testbuttonId',
                      items: {
                          text: 'очистити',
                          iconCls: 'minus_once',
                          itemId: 'removeSymple',
                          handler: function () {
                              //var grid = this.up('grid');
                              //var grid = this.up('grid');
                              ////try {
                              ////    store.removeAll();
                              ////} catch (e) {
                              ////    if (e.number != '-2146823281')
                              ////        throw e;
                              ////}
                              //store.removeAll();
                          }
                      }
                  
               }

    ],
    overflowY: 'auto',
    labelWidth: 110,
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
    constructor: function (sympleFiltersParameter) {
        var self = this;
        columns = sympleFiltersParameter.SympleFilters;
       
        //var form = self.down('mainFormPanel').getForm();
        //columns = sympleFiltersParameter.SympleFilters;
        //Ext.each(sympleFiltersParameter.SympleFilters, function (item) {
        //    form.items.push(item);
        //})
       
     
        self.callParent();

    },
    initComponent: function () {

        var self = this;
        self.items.push(
            {
                title: 'sdfasdf',
                items: Ext.create('ExtApp.view.refBook.FormPanel', {
                    items: columns,
                    height: 220,
                    fieldDefaults: {
                        labelAlign: 'left',
                        labelWidth: 300
                    }
                }),
                autoscroll: true,
                width: '100%'
            })
        this.callParent();
    }
})