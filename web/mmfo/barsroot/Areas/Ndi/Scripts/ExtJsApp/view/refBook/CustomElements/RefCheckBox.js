Ext.define('ExtApp.view.refBook.CustomElements.RefCheckBox', {
    extend: 'Ext.form.field.Checkbox',
    alias: 'widget.refCheckBox',

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
            change: function (column, newValue, oldValue, eOpts) {
                
                var event = newValue  ? 'CHECK' : "UNCHECK";
                    ExtApp.utils.RefBookUtils.onBeforeEditRowByDependencies(column, newValue, oldValue,event);
                    return;


            },
            check: function (field,isChec,orig) {
                
            },
            cellEditRecord:function (field, isValid, eOpts) {
                
            },
            validitychange: function( field, isValid, eOpts ){
                //alert('validitychange')
            },
            afteredit: function(e) {
                
                var rec   = e.record;
                var field = e.field;
                var val   = e.value;

                if (field == 'myDateColumnName') {
                    var newDay = Ext.util.Format.date(val, 'l');
                    rec.set('myDOWColumnName', newDay);
            }
            }
        };

        this.callParent();
    }
});

var colMetaInfo;