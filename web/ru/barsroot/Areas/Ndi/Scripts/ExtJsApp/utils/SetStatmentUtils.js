Ext.define('ExtApp.utils.SetStatmentUtils', {

    statics: {
        setHiddenColumnsToLocalSrorage: function (columnNames, localStorageModel) {
            debugger
            var columnsNamesString = '';
            if (columnNames.length)
            {
                Ext.each(columnNames, function (name) {
                    columnsNamesString += name + ',';
                });
               
            }
            columnsNamesString = columnsNamesString.slice(0, -1);
            var myLocalStore = Ext.state.LocalStorageProvider.create();
            myLocalStore.set(localStorageModel.HiddenColumnsKey, columnsNamesString);
        },

        clearHiddenColumnsFromLocalSrorage: function (localStorageModel) {
            var myLocalStore = Ext.state.LocalStorageProvider.create();
            myLocalStore.set(localStorageModel.HiddenColumnsKey, '');
        },
        getHiddenColumnsFromLocalSrorage: function (localStorageModel) {
            
            var hiddenColumns;
            var myLocalStore = Ext.state.LocalStorageProvider.create();
            var hiddenColumnsNames = myLocalStore.get(localStorageModel.HiddenColumnsKey);
            if (hiddenColumnsNames)
                hiddenColumns = hiddenColumnsNames.split(",");
            return hiddenColumns;
            
        }
    }

});