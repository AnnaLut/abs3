Ext.define('ExtApp.view.refBook.RNKWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.refRNKWindow',

    //title: "Карта клієнта. ",
    autoShow: true,
    width: Ext.getBody().getViewSize().width * 0.9,
    height: Ext.getBody().getViewSize().height * 0.9,
    layout: 'fit',
    items: [{
        xtype: "component",
        autoEl: {
            tag: "iframe"
        }
    }],
    buttons: [
       {
           itemId: 'cancelButton',
           text: 'Відмінити',
           iconCls: 'cancel',
           handler: function (btn) {
               btn.up('window').close();
           }
       }
    ]
});