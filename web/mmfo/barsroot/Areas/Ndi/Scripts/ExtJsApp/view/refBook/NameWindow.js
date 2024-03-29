﻿Ext.define('ExtApp.view.refBook.NameWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.NameWindow',

    autoShow: true,
    //для того чтобы большие экраны не заползали за верх монитора
    constrainHeader: true,
    minWidth: 400,
    minHeight: 200,
    maxWidth: 600,
    maxHeight: 300,

    layout: 'fit',
    buttons: [
        {
            //свойства по умолчанию, могут быть переопределены в initComponent
            itemId: 'okButton',
            text: 'Зберегти',
            iconCls: 'save'
        }, {
            itemId: 'cancelButton',
            text: 'Відмінити',
            iconCls: 'cancel',
            handler: function (btn) {
                btn.up('window').close();
            }
        }
    ],

    initComponent: function () {
        var thisEditWindow = this;
        if (thisEditWindow.btnOkProps) {
            //дополнить/перезаписать дефолтные свойства кнопки okButton новыми свойствами
            thisEditWindow.buttons[0] = Ext.apply(thisEditWindow.buttons[0], thisEditWindow.btnOkProps);
        }
        this.callParent();
    }
});