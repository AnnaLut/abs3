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
            change: function (field, newValue, oldValue, eOpts) {
                
                //т.к. во время конвертации с true на 1 вызыется этот метод
                if (newValue == oldValue)
                    return;
                var colMetaInfo = field.column ? field.column.columnMetaInfo : field.colMetaInfo;
                var form = field.up('form');
                if (!form)
                    return;
                form = form.getForm();
                var dependencies = colMetaInfo.Dependencies;
                if (!colMetaInfo || !form || !dependencies || !dependencies.length || dependencies.length < 1)
                    return;
                var checkDeps = Ext.Array.filter(dependencies, function (dep) { return dep.Event == 'CHECK' });
                if (checkDeps && checkDeps.length && checkDeps.length > 0 && field.checked)
                Ext.each(checkDeps, function (dep) {
                    ExtApp.utils.RefBookUtils.executeDepAction(form, form._record, dep);
                })
               
                var UncheckDep = Ext.Array.filter(dependencies, function (dep) { return dep.Event == 'UNCHECK' });
                if (UncheckDep && UncheckDep.length && UncheckDep.length > 0 && !field.checked)
                    Ext.each(UncheckDep, function (dep) {
                        ExtApp.utils.RefBookUtils.executeDepAction(form, form._record, dep);
                    })

            },
            validitychange: function( field, isValid, eOpts ){
                //alert('validitychange')
            }
        };

        this.callParent();
    }
});

var colMetaInfo;