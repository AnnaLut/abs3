Ext.define('ExtApp.view.refBook.refShowparamWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.refShowparamWindow',

    autoShow: true,
    //для того чтобы большие экраны не заползали за верх монитора
    constrainHeader: true,
    minWidth: 800,
    minHeight: 200,
    maxWidth: 1000,
    maxHeight: 600,

    layout: 'fit',
    buttons: [
        {
            //свойства по умолчанию, могут быть переопределены в initComponent
            itemId: 'okButton',
            text: 'Виконати',
            iconCls: 'arrow_right'
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