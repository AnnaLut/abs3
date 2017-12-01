
    Ext.define('ExtApp.view.refBook.CustomElements.RefCellEditor', {
    extend: 'Ext.grid.plugin.CellEditing',
    alias: 'plugin.RefCellEditor',
    pluginId: "cellEditPlugin",
    //initEditTriggers: function () {
    //    var me = this;
    //    var keys = [];
    //    for (var i = 48; i < 58; i++) { keys.push(i); } // 0-9
    //    for (var i = 65; i < 91; i++) { keys.push(i); } // A-Z
    //    for (var i = 97; i < 123; i++) { keys.push(i); } // a-z
    //    // listen for particular key presses made over cells
    //    //me.view.addListener('render', function () {
    //    //    var keyPressMap = new Ext.util.KeyMap({
    //    //        target: me.view.el,
    //    //        eventName: 'keypress',
    //    //        binding: [{
    //    //            key: keys,
    //    //            handler: me.onAlphaNumericKey,
    //    //            scope: me
    //    //        }]
    //    //    });
    //    //    var keyDownMap = new Ext.util.KeyMap({
    //    //        target: me.view.el,
    //    //        eventName: 'keydown',
    //    //        binding: [{
    //    //            key: Ext.EventObject.DELETE,
    //    //            handler: me.onDeleteKey,
    //    //            scope: me
    //    //        }, {
    //    //            key: Ext.EventObject.BACKSPACE,
    //    //            handler: me.onBackspaceKey,
    //    //            scope: me
    //    //        }]
    //    //    });
    //    //}, me, { single: true });
    //    me.callParent(arguments);
    //},
    //onAlphaNumericKey: function (keyCode, e) { // only executes before a cell has entered edit mode
    //    var me = this,
    //        grid = me.grid,
    //        pos = grid.getSelectionModel().getCurrentPosition(),
    //        record = grid.store.getAt(pos.row),
    //        columnHeader = grid.headerCt.getHeaderAtIndex(pos.column);
    //    alert('onAlphaNumericKey');
    //    if (me.getEditor(record, columnHeader)) {
    //        // insert the key pressed into the editor field and start editing
    //        newGridCellValue = String.fromCharCode(keyCode);
    //        me.startEdit(record, columnHeader);
    //    }
    //},
    //onBackspaceKey: function (keyCode, e) { // only executes before a cell has entered edit mode
    //    var me = this;
    //    alert('onBackspaceKey');
    //    e.stopEvent(); // cancel the default browser behaviour of navigating one page back
    //    me.onDeleteKey(keyCode, e);
    //},
    //onDeleteKey: function (keyCode, e) { // only executes before a cell has entered edit mode
    //    var me = this,
    //        grid = me.grid,
    //        pos = grid.getSelectionModel().getCurrentPosition(),
    //        record = grid.store.getAt(pos.row),
    //        columnHeader = grid.headerCt.getHeaderAtIndex(pos.column);
    //    alert('onDeleteKey')
    //    if (me.getEditor(record, columnHeader)) {
    //        // perform an "instantaneous" edit that essentially just sets the value of the cell to nothing
    //        deleteGridCellValue = true;
    //        me.startEdit(record, columnHeader);
    //    }
    //},
    //onEnterKey: function (e) { // only executes before a cell has entered edit mode
    //    var me = this,
    //        grid = me.grid,
    //        sm = grid.getSelectionModel();
    //    //alert('onEnterKey');
    //    me.callParent(arguments);
    //    // cellmodel navigates left/right when tab key is pressed by default, but not up/down when enter is pressed
    //    // the code below enables this functionality for cells that are not editable
    //    if (!grid.headerCt.getHeaderAtIndex(sm.getCurrentPosition().column).getEditor()) {
    //        sm.move(e.shiftKey ? 'up' : 'down', e);
    //    }
    //},
    onSpecialKey: function (ed, field, e) {
        
        // only executes when a cell is in edit mode
        var me = this,
            sm = me.grid.getSelectionModel().getSelection();
        //ed = me.activeEditor;
        var newrow = ed.row;
        var last = me.lastEdit;
        
        //alert('onSpecialKey');
        // cellmodel navigates left/right when tab key is pressed by default, but not up/down when enter is pressed
        // the code below enables this functionality for cells that are editable
        //if (e.getKey() === e.UP) {
        //    me.addListener('edit', function () {
        //        sm.move(e.shiftKey ? 'up' : 'down', e); // navigate up/down once edit completes
        //    }, me, { single: true });
        //}
        //newCell = me.view.walkCells(5, 'left', e, false),
        currRowNum = this.context.rowIdx;
        crurrCollIndex = this.context.colIdx;

        field.el.dom.focus();

        if (e.getKey() === e.UP) {
            
            ed.completeEdit();
            e.stopEvent();
            e.preventDefault();
            //field.focus(false);
            var newRowNum = this.context.rowIdx - 1;
            var  newCollIndex = this.context.colIdx;
            if (field.xtype == 'refTextBox')
                setTimeout('upEdit()', 30);
            else
                this.startEditByPosition({ row: currRowNum - 1, column: crurrCollIndex });
            //var curRow = me.grid.getSelectionModel().getSelection();
            //this.startEditByPosition({ row: currRownum - 4, column: newCollIndex });
            //var curRow = me.grid.getSelectionModel().getSelection();
            //me.grid.getSelectionModel().setCurrentPosition({row: curRow, column: newCollIndex });

        }
        if (e.getKey() == e.LEFT) {
            ed.completeEdit();
            e.stopEvent();
            e.preventDefault();
            this.startEditByPosition({ row: currRowNum, column: crurrCollIndex - 1 });
        }

        if (e.getKey() == e.RIGHT) {
            ed.completeEdit();
            e.stopEvent();
            e.preventDefault();
            this.startEditByPosition({ row: currRowNum, column: crurrCollIndex + 1 });
        }
        // this.st
        // this.startEditByPosition({ row: currRownum - 1, column: newCollIndex });//: newCollIndex  this.startEditByPosition({ row: --currRownum, column: newCollIndex });
        if (e.getKey() == e.DOWN)
        {
            ed.completeEdit();
            e.stopEvent();
            e.preventDefault();
            if (field.xtype == 'refTextBox')
                setTimeout('downEdit()', 30);
            else
                this.startEditByPosition({ row: currRowNum + 1, column: crurrCollIndex });
         //   this.startEditByPosition({ row: currRownum + 1, column: newCollIndex });
         //newCell = me.view.walkCells(sm, pos +1, -1, this.acceptsNav, this);
         //newRow = me.view.walkRows(sm, 1);

        }

        //me.grid.columns[9].field.focus(true);
        me.callParent(arguments);
    }

});

    upEdit = function () {
        var grid = Ext.getCmp('mainReferenceGrid');        
        grid.plugins[0].startEditByPosition({ row: window.currRowNum - 1, column: window.crurrCollIndex });
    }

    downEdit = function () {
        var grid = Ext.getCmp('mainReferenceGrid');
        grid.plugins[0].startEditByPosition({ row: window.currRowNum + 1, column: window.crurrCollIndex });
    }

