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
 * Provides for repetitive polling of the server at distinct {@link #interval intervals}.
 * The initial request for data originates from the client, and then is responded to by the
 * server.
 * 
 * Configuration for the PollingProvider can be generated by the server-side
 * API portion of the Ext.Direct stack.
 *
 * An instance of PollingProvider may be created directly via the new keyword or by simply
 * specifying `type = 'polling'`. For example:
 *
 *      var pollA = new Ext.direct.PollingProvider({
 *          type:'polling',
 *          url: 'php/pollA.php',
 *      });
 *      Ext.direct.Manager.addProvider(pollA);
 *      pollA.disconnect();
 *      
 *      Ext.direct.Manager.addProvider({
 *          type:'polling',
 *          url: 'php/pollB.php',
 *          id: 'pollB-provider'
 *      });
 *      var pollB = Ext.direct.Manager.getProvider('pollB-provider');
 *
 */
Ext.define('Ext.direct.PollingProvider', {
    extend: 'Ext.direct.JsonProvider',
    alias:  'direct.pollingprovider',
    
    requires: [
        'Ext.Ajax',
        'Ext.util.DelayedTask'
    ],
    
    uses: [
        'Ext.direct.ExceptionEvent',
        'Ext.direct.Manager'
    ],
    
    /**
     * @cfg {Number} [interval=3000]
     * How often to poll the server-side in milliseconds. Defaults to every 3 seconds.
     */
    interval: 3000,

    /**
     * @cfg {Object} [baseParams]
     * An object containing properties which are to be sent as parameters on every polling request
     */
    
    /**
     * @cfg {String/Function} url
     * The url which the PollingProvider should contact with each request. This can also be
     * an imported Ext.Direct method which will accept the baseParams as its only argument.
     */

    constructor: function(config) {
        var me = this;
        
        me.callParent(arguments);
        
        me.addEvents(
            /**
             * @event beforepoll
             * @preventable
             * Fired immediately before a poll takes place.
             *
             * @param {Ext.direct.PollingProvider} this
             */
            'beforepoll',
            
            /**
             * @event poll
             * Fired immediately after a poll takes place.
             *
             * @param {Ext.direct.PollingProvider} this
             */
            'poll'
        );
    },

    /**
     * @inheritdoc
     */
    isConnected: function() {
        return !!this.pollTask;
    },

    /**
     * Connect to the server-side and begin the polling process. To handle each
     * response subscribe to the data event.
     */
    connect: function() {
        var me = this,
            url = me.url;
        
        if (url && !me.pollTask) {
            me.pollTask = Ext.TaskManager.start({
                run: me.runPoll,
                interval: me.interval,
                scope: me
            });
            
            me.fireEvent('connect', me);
        }
        //<debug>
        else if (!url) {
            Ext.Error.raise('Error initializing PollingProvider, no url configured.');
        }
        //</debug>
    },

    /**
     * Disconnect from the server-side and stop the polling process. The disconnect
     * event will be fired on a successful disconnect.
     */
    disconnect: function() {
        var me = this;
        
        if (me.pollTask) {
            Ext.TaskManager.stop(me.pollTask);
            delete me.pollTask;
            me.fireEvent('disconnect', me);
        }
    },
    
    /**
     * @private
     */
    runPoll: function() {
        var me = this,
            url = me.url;
        
        if (me.fireEvent('beforepoll', me) !== false) {
            if (Ext.isFunction(url)) {
                url(me.baseParams);
            }
            else {
                Ext.Ajax.request({
                    url: url,
                    callback: me.onData,
                    scope: me,
                    params: me.baseParams
                });
            }
            
            me.fireEvent('poll', me);
        }
    },

    /**
     * @private
     */
    onData: function(opt, success, response) {
        var me = this, 
            i, len, events;
        
        if (success) {
            events = me.createEvents(response);
            
            for (i = 0, len = events.length; i < len; ++i) {
                me.fireEvent('data', me, events[i]);
            }
        }
        else {
            events = new Ext.direct.ExceptionEvent({
                data: null,
                code: Ext.direct.Manager.exceptions.TRANSPORT,
                message: 'Unable to connect to the server.',
                xhr: response
            });
            
            me.fireEvent('data', me, events);
        }
    }
});