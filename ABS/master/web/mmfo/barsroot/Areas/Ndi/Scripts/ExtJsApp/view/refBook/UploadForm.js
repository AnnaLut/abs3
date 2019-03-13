Ext.require([
    'Ext.form.field.File',
    'Ext.form.field.Number',
    'Ext.form.Panel',
    'Ext.window.MessageBox'
]);

Ext.onReady(function() {

    Ext.define('ExtApp.view.refBook.UploadForm', {
        extend: 'Ext.form.Panel',
        alias: 'widget.refUploadForm',
        width: 400,
        frame: true,
        title: 'File Upload Form',
        bodyPadding: '10 10 0',

        defaults: {
            anchor: '100%',
            allowBlank: false,
            msgTarget: 'side',
            labelWidth: 50
        },

        items: [{
            xtype: 'textfield',
            fieldLabel: 'Name'
        },{
            xtype: 'filefield',
            id: 'form-file',
            emptyText: 'Select an image',
            fieldLabel: 'Photo',
            name: 'photo-path',
            buttonText: '',
            buttonConfig: {
                iconCls: 'upload-icon'
            }
        }],

        buttons: [{
            text: 'Save',
            handler: function(){
                var form = this.up('form').getForm();
                if(form.isValid()){
                    form.submit({
                        url: 'file-upload.php',
                        waitMsg: 'Uploading your photo...',
                        success: function(fp, o) {
                            msg('Success', tpl.apply(o.result));
                        }
                    });
                }
            }
        },{
            text: 'Reset',
            handler: function() {
                this.up('form').getForm().reset();
            }
        }]
    });



    // Ext.define('ExtApp.view.refBook.UploadForm', {
    //     extend: 'Ext.form.Panel',
    //     alias: 'widget.refUploadForm',
    //     title: 'Форма Запроса',
    //     bodyStyle: 'padding:5px 5px 0',
    //     width: 400,
    //     height: 150,
    //     renderTo: Ext.getBody(),
    //     items: [{
    //         id: 'blobDocument',
    //         xtype: 'filefield',
    //         name: 'document',
    //         fieldLabel: 'Выберите файл ',
    //         buttonText: 'завант...',
    //         //msgTarget: 'side',
    //         //allowBlank: false,
    //         //width: 400
    //         listeners: {
    //             change: function (fld, value) {
    //
    //                 if (value.indexOf('\\') < 0)
    //                     return true;
    //                 var newValue = value.substring(value.lastIndexOf('\\') + 1);
    //                 fld.setRawValue(newValue);
    //             },
    //             keydown: function (e, eOpts) {
    //                 alert('sdfsdf');
    //
    //             },
    //             keypress: function (e, eOpts) {
    //
    //             },
    //             keyup: function (thiss, e, eOpts) {
    //
    //
    //             },
    //             beforeshow: function (thiss, opts) {
    //                 alert('sdfsdfsadf');
    //
    //             },
    //             show: function (thiss, eOpts) {
    //
    //
    //             },
    //             beforeshow: function (thiss, eOpts) {
    //
    //             },
    //             onClick: function (e, args) {
    //
    //             },
    //             click: function (e, args) {
    //
    //             }
    //         }
    //     }]
    //
    // })
});
