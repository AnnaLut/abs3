// Ext.define('ExtApp.view.refBook.refExtWindow', {
//     extend: 'Ext.window.Window',
//     alias: 'widget.refExtWindow',
//
//     //title: "Карта клієнта. ",
//     autoShow: true,
//     width: Ext.getBody().getViewSize().width * 0.9,
//     height: Ext.getBody().getViewSize().height * 0.9,
//     layout: 'fit',
//     items: [{
//         xtype: "component",
//         autoEl: {
//             tag: "iframe"
//         }
//     }],
//     buttons: [
//        {
//            itemId: 'cancelButton',
//            text: 'Відмінити',
//            iconCls: 'cancel',
//            handler: function (btn) {
//                btn.up('window').close();
//            }
//        }
//     ]
// });