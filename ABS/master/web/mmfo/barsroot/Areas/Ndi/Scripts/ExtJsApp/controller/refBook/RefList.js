Ext.define('ExtApp.controller.refBook.RefList', {
    extend: 'Ext.app.Controller',

    views: [
        //'refBook.RefList'
    ],

    init: function () {
        this.control({
            "referenceList": {
                itemclick: this.onItemclick
            }
        });
    },

    onItemclick: function (component, record, item, index, e) {

    }
});