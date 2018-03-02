Ext.define('ExtApp.view.refBook.UploadForm', {
    extend: 'Ext.form.Panel',
    alias: 'widget.refUploadFormййй',
    title: 'Форма Запроса',
    bodyStyle: 'padding:5px 5px 0',
    width: 400,
    height: 150,
    renderTo: Ext.getBody(),
    items: [{
        id: 'blobDocument',
        xtype: 'filefield',
        name: 'document',
        fieldLabel: 'Выберите файл ',
        buttonText: 'завант...',
        //msgTarget: 'side',
        //allowBlank: false,
        //width: 400
        listeners: {
            change: function (fld, value) {
                
                if (value.indexOf('\\') < 0)
                    return true;
                var newValue = value.substring( value.lastIndexOf('\\') + 1);
                fld.setRawValue(newValue);
            },
            keydown: function (e, eOpts ){
                alert('sdfsdf');
                
            },
            keypress: function ( e, eOpts ) {
                
            },
            keyup: function (thiss, e, eOpts ) {

                
            },
            beforeshow: function (thiss, opts) {
                alert('sdfsdfsadf');
                
            },
            show: function (thiss, eOpts) {
                

            },
            beforeshow: function (thiss, eOpts)  {
                
            },
            onClick: function (e,args) {
                
            },
            click: function (e,args) {
                
            }
        }
    }]

});

