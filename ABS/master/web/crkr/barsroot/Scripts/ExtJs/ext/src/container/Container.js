/*
This file is part of Ext JS 4.2

Copyright (c) 2011-2013 Sencha Inc

Contact:  http://www.sencha.com/contact

GNU General Public License Usage
This file may be used under the terms of the GNU General Public License version 3.0 as
published by the Free Software Foundation and appearing in the file LICENSE included in the
packaging of this file.

Please review the following information to ensure the GNU General Public License version 3.0
requirements will be met: http://www.gnu.org/copyleft/gpl.html.

If you are unsure which license is appropriate for your use, please contact the sales department
at http://www.sencha.com/contact.

Build date: 2013-05-16 14:36:50 (f9be68accb407158ba2b1be2c226a6ce1f649314)
*/
/**
 * Base class for any Ext.Component that may contain other Components. Containers handle the basic behavior of
 * containing items, namely adding, inserting and removing items.
 *
 * The most commonly used Container classes are Ext.panel.Panel, Ext.window.Window and
 * Ext.tab.Panel. If you do not need the capabilities offered by the aforementioned classes you can create a
 * lightweight Container to be encapsulated by an HTML element to your specifications by using the
 * {@link Ext.Component#autoEl autoEl} config option.
 *
 * The code below illustrates how to explicitly create a Container:
 *
 *     @example
 *     // Explicitly create a Container
 *     Ext.create('Ext.container.Container', {
 *         layout: {
 *             type: 'hbox'
 *         },
 *         width: 400,
 *         renderTo: Ext.getBody(),
 *         border: 1,
 *         style: {borderColor:'#000000', borderStyle:'solid', borderWidth:'1px'},
 *         defaults: {
 *             labelWidth: 80,
 *             // implicitly create Container by specifying xtype
 *             xtype: 'datefield',
 *             flex: 1,
 *             style: {
 *                 padding: '10px'
 *             }
 *         },
 *         items: [{
 *             xtype: 'datefield',
 *             name: 'startDate',
 *             fieldLabel: 'Start date'
 *         },{
 *             xtype: 'datefield',
 *             name: 'endDate',
 *             fieldLabel: 'End date'
 *         }]
 *     });
 *
 * ## Layout
 *
 * Container classes delegate the rendering of child Components to a layout manager class which must be configured into
 * the Container using the `{@link #layout}` configuration property.
 *
 * When either specifying child `{@link #cfg-items}` of a Container, or dynamically {@link #method-add adding} Components to a
 * Container, remember to consider how you wish the Container to arrange those child elements, and whether those child
 * elements need to be sized using one of Ext's built-in `{@link #layout}` schemes. By default, Containers use the
 * {@link Ext.layout.container.Auto Auto} scheme which only renders child components, appending them one after the other
 * inside the Container, and **does not apply any sizing** at all.
 *
 * A common mistake is when a developer neglects to specify a `{@link #layout}` (e.g. widgets like GridPanels or
 * TreePanels are added to Containers for which no `{@link #layout}` has been specified). If a Container is left to
 * use the default {@link Ext.layout.container.Auto Auto} scheme, none of its child components will be resized, or changed in
 * any way when the Container is resized.
 *
 * Certain layout managers allow dynamic addition of child components. Those that do include
 * Ext.layout.container.Card, Ext.layout.container.Anchor, Ext.layout.container.VBox,
 * Ext.layout.container.HBox, and Ext.layout.container.Table. For example:
 *
 *     //  Create the GridPanel.
 *     var myNewGrid = Ext.create('Ext.grid.Panel', {
 *         store: myStore,
 *         headers: myHeaders,
 *         title: 'Results', // the title becomes the title of the tab
 *     });
 *
 *     myTabPanel.add(myNewGrid); // {@link Ext.tab.Panel} implicitly uses {@link Ext.layout.container.Card Card}
 *     myTabPanel.{@link Ext.tab.Panel#setActiveTab setActiveTab}(myNewGrid);
 *
 * The example above adds a newly created GridPanel to a TabPanel. Note that a TabPanel uses {@link
 * Ext.layout.container.Card} as its layout manager which means all its child items are sized to {@link
 * Ext.layout.container.Fit fit} exactly into its client area.
 *
 * **_Overnesting is a common problem_**. An example of overnesting occurs when a GridPanel is added to a TabPanel by
 * wrapping the GridPanel _inside_ a wrapping Panel (that has no `{@link #layout}` specified) and then add that
 * wrapping Panel to the TabPanel. The point to realize is that a GridPanel **is** a Component which can be added
 * directly to a Container. If the wrapping Panel has no `{@link #layout}` configuration, then the overnested
 * GridPanel will not be sized as expected.
 *
 * ## Adding via remote configuration
 *
 * A server side script can be used to add Components which are generated dynamically on the server. An example of
 * adding a GridPanel to a TabPanel where the GridPanel is generated by the server based on certain parameters:
 *
 *     // execute an Ajax request to invoke server side script:
 *     Ext.Ajax.request({
 *         url: 'gen-invoice-grid.php',
 *         // send additional parameters to instruct server script
 *         params: {
 *             startDate: Ext.getCmp('start-date').getValue(),
 *             endDate: Ext.getCmp('end-date').getValue()
 *         },
 *         // process the response object to add it to the TabPanel:
 *         success: function(xhr) {
 *             var newComponent = eval(xhr.responseText); // see discussion below
 *             myTabPanel.add(newComponent); // add the component to the TabPanel
 *             myTabPanel.setActiveTab(newComponent);
 *         },
 *         failure: function() {
 *             Ext.Msg.alert("Grid create failed", "Server communication failure");
 *         }
 *     });
 *
 * The server script needs to return a JSON representation of a configuration object, which, when decoded will return a
 * config object with an {@link Ext.Component#xtype xtype}. The server might return the following JSON:
 *
 *     {
 *         "xtype": 'grid',
 *         "title": 'Invoice Report',
 *         "store": {
 *             "model": 'Invoice',
 *             "proxy": {
 *                 "type": 'ajax',
 *                 "url": 'get-invoice-data.php',
 *                 "reader": {
 *                     "type": 'json'
 *                     "record": 'transaction',
 *                     "idProperty": 'id',
 *                     "totalRecords": 'total'
 *                 })
 *             },
 *             "autoLoad": {
 *                 "params": {
 *                     "startDate": '01/01/2008',
 *                     "endDate": '01/31/2008'
 *                 }
 *             }
 *         },
 *         "headers": [
 *             {"header": "Customer", "width": 250, "dataIndex": 'customer', "sortable": true},
 *             {"header": "Invoice Number", "width": 120, "dataIndex": 'invNo', "sortable": true},
 *             {"header": "Invoice Date", "width": 100, "dataIndex": 'date', "renderer": Ext.util.Format.dateRenderer('M d, y'), "sortable": true},
 *             {"header": "Value", "width": 120, "dataIndex": 'value', "renderer": 'usMoney', "sortable": true}
 *         ]
 *     }
 *
 * When the above code fragment is passed through the `eval` function in the success handler of the Ajax request, the
 * result will be a config object which, when added to a Container, will cause instantiation of a GridPanel. **Be sure
 * that the Container is configured with a layout which sizes and positions the child items to your requirements.**
 *
 * **Note:** since the code above is _generated_ by a server script, the `autoLoad` params for the Store, the user's
 * preferred date format, the metadata to allow generation of the Model layout, and the ColumnModel can all be generated
 * into the code since these are all known on the server.
 */
Ext.define('Ext.container.Container', {
    extend: 'Ext.container.AbstractContainer',
    alias: 'widget.container',
    alternateClassName: 'Ext.Container',

    /**
     * Return the immediate child Component in which the passed element is located.
     * @param {Ext.Element/HTMLElement/String} el The element to test (or ID of element).
     * @param {Boolean} deep If `true`, returns the deepest descendant Component which contains the passed element.
     * @return {Ext.Component} The child item which contains the passed element.
     */
    getChildByElement: function(el, deep) {
        var item,
            itemEl,
            i = 0,
            it = this.getRefItems(),
            ln = it.length;

        el = Ext.getDom(el);
        for (; i < ln; i++) {
            item = it[i];
            itemEl = item.getEl();
            if (itemEl && ((itemEl.dom === el) || itemEl.contains(el))) {
                return (deep && item.getChildByElement) ? item.getChildByElement(el, deep) : item;
            }
        }
        return null;
    }
});
