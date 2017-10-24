﻿Ext.define('ExtApp.view.refBook.InternelLinkWondow', {
    extend: 'Ext.window.Window',
    alias: 'widget.InternelLinkWondow',

    //title: "Карта клієнта. ",
    autoShow: true,
    width: Ext.getBody().getViewSize().width * 0.98,
    height: Ext.getBody().getViewSize().height *0.96,
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