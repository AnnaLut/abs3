Ext.define('ExtApp.view.refBook.CustomElements.RefUploadFile', {
    extend: 'Ext.form.field.File',
    alias: 'widget.refFieldFile',

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
        thistExtBox.msgTarget =  'side';
        thistExtBox.allowBlank = false;
        thistExtBox.listeners = {
            change: function (fld, value) {
                
                if (value.indexOf('\\') < 0)
                    return true;
                var newValue = value.substring( value.lastIndexOf('\\') + 1);
                fld.setRawValue(newValue);
            }
        }
        thistExtBox.callParent();
    }
});