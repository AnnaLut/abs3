Ext.define('ExtApp.view.refBook.CustomElements.RefTextBox', {
    extend: 'Ext.form.field.Text',
    alias: 'widget.refTextBox',

    listConfig: {
        
    },

    //listeners:  {
    //    change: function () {
    //        alert('sdfdsfsd');
    //    },
    //    keyup: function () {
    //        alert('qqqqq');
    //    }
    //},
    //в initComponent вынесены свойства которые нужно заполнить с учетом переданных данных при создании комбобокса
    initComponent: function () {
     
        var thistExtBox = this;
        thistExtBox.listeners = {
            change: function (field, newValue, oldValue, eOpts) {
                //debugger;
                //alert('textchange');
                //debugger;
              
            }
        };

        this.callParent();
    }
});
