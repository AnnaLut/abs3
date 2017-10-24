Ext.define('ExtApp.view.refBook.UploadForm', {
    extend: 'Ext.form.Panel',
    alias: 'widget.refUploadForm',
    title: 'Форма Запроса',
    bodyStyle: 'padding:5px 5px 0',
    width: 400,
    height: 150,
    renderTo: Ext.getBody(),
    items: [{
        xtype: 'filefield',
        name: 'document',
        fieldLabel: 'Выберите файл ',
        buttonText: 'завант...'
        //msgTarget: 'side',
        //allowBlank: false,
        //width: 400
        //listeners: {
        //    change: function (fld, value) {
        //        
        //        if (value.indexOf('\\') < 0)
        //            return true;
        //        var newValue = value.substring( value.lastIndexOf('\\') + 1);
        //        fld.setRawValue(newValue);
        //    }
        //}
    }]

});