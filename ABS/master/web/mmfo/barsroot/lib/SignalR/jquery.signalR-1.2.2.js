/* jquery.signalR.core.js */
/*global window:false */
/*!
 * ASP.NET SignalR JavaScript Library v1.2.2
 * http://signalr.net/
 *
 * Copyright Microsoft Open Technologies, Inc. All rights reserved.
 * Licensed under the Apache 2.0
 * https://github.com/SignalR/SignalR/blob/master/LICENSE.md
 *
 */

/// <reference path="Scripts/jquery-1.6.4.js" />
(function ($, window, undefined) {
    "use strict";

    if (typeof ($) !== "function") {
        // no jQuery!
        throw new Error("SignalR: jQuery not found. Please ensure jQuery is referenced before the SignalR.js file.");
    }

    if (!window.JSON) {
        // no JSON!
        throw new Error("SignalR: No JSON parser found. Please ensure json2.js is referenced before the SignalR.js file if you need to support clients without native JSON parsing support, e.g. IE<8.");
    }

    var signalR,
        _connection,
        _pageLoaded = (window.document.readyState === "complete"),
        _pageWindow = $(window),

        events = {
            onStart: "onStart",
            onStarting: "onStarting",
            onReceived: "onReceived",
            onError: "onError",
            onConnectionSlow: "onConnectionSlow",
            onReconnecting: "onReconnecting",
            onReconnect: "onReconnect",
            onStateChanged: "onStateChanged",
            onDisconnect: "onDisconnect"
        },
        ajaxDefaults = {
            processData: true,
            timeout: null,
            async: true,
            global: false,
            cache: false
        },
        log = function (msg, logging) {
            if (logging === false) {
                return;
            }
            var m;
            if (typeof (window.console) === "undefined") {
                return;
            }
            m = "[" + new Date().toTimeString() + "] SignalR: " + msg;
            if (window.console.debug) {
                window.console.debug(m);
            } else if (window.console.log) {
                window.console.log(m);
            }
        },

        changeState = function (connection, expectedState, newState) {
            if (expectedState === connection.state) {
                connection.state = newState;

                $(connection).triggerHandler(events.onStateChanged, [{ oldState: expectedState, newState: newState }]);
                return true;
            }

            return false;
        },

        isDisconnecting = function (connection) {
            return connection.state === signalR.connectionState.disconnected;
        },

        configureStopReconnectingTimeout = function (connection) {
            var stopReconnectingTimeout,
                onReconnectTimeout;

            // Check if this connection has already been configured to stop reconnecting after a specified timeout.
            // Without this check if a connection is stopped then started events will be bound multiple times.
            if (!connection._.configuredStopReconnectingTimeout) {
                onReconnectTimeout = function (connection) {
                    connection.log("Couldn't reconnect within the configured timeout (" + connection.disconnectTimeout + "ms), disconnecting.");
                    connection.stop(/* async */ false, /* notifyServer */ false);
                };

                connection.reconnecting(function () {
                    var connection = this;

                    // Guard against state changing in a previous user defined even handler
                    if (connection.state === signalR.connectionState.reconnecting) {
                        stopReconnectingTimeout = window.setTimeout(function () { onReconnectTimeout(connection); }, connection.disconnectTimeout);
                    }
                });

                connection.stateChanged(function (data) {
                    if (data.oldState === signalR.connectionState.reconnecting) {
                        // Clear the pending reconnect timeout check
                        window.clearTimeout(stopReconnectingTimeout);
                    }
                });

                connection._.configuredStopReconnectingTimeout = true;
            }
        };

    signalR = function (url, qs, logging) {
        /// <summary>Creates a new SignalR connection for the given url</summary>
        /// <param name="url" type="String">The URL of the long polling endpoint</param>
        /// <param name="qs" type="Object">
        ///     [Optional] Custom querystring parameters to add to the connection URL.
        ///     If an object, every non-function member will be added to the querystring.
        ///     If a string, it's added to the QS as specified.
        /// </param>
        /// <param name="logging" type="Boolean">
        ///     [Optional] A flag indicating whether connection logging is enabled to the browser
        ///     console/log. Defaults to false.
        /// </param>

        return new signalR.fn.init(url, qs, logging);
    };

    signalR._ = {
        defaultContentType: "application/x-www-form-urlencoded; charset=UTF-8",
        ieVersion: (function () {
            var version,
                matches;

            if (window.navigator.appName === 'Microsoft Internet Explorer') {
                // Check if the user agent has the pattern "MSIE (one or more numbers).(one or more numbers)";
                matches = /MSIE ([0-9]+\.[0-9]+)/.exec(window.navigator.userAgent);

                if (matches) {
                    version = window.parseFloat(matches[1]);
                }
            }

            // undefined value means not IE
            return version;
        })(),

        firefoxMajorVersion: function (userAgent) {
            // Firefox user agents: http://useragentstring.com/pages/Firefox/
            var matches = userAgent.match(/Firefox\/(\d+)/);
            if (!matches || !matches.length || matches.length < 2) {
                return 0;
            }
            return parseInt(matches[1], 10 /* radix */);
        },
        
        configurePingInterval: function (connection) {
            var privateData = connection._,
                onFail = function (error) {
                    $(connection).triggerHandler(events.onError, [error]);
                };

            if (!privateData.pingIntervalId && privateData.pingInterval) {
                privateData.pingIntervalId = window.setInterval(function () {
                    signalR.transports._logic.pingServer(connection).fail(onFail);
                }, privateData.pingInterval);
            }
        }
    };

    signalR.events = events;

    signalR.ajaxDefaults = ajaxDefaults;

    signalR.changeState = changeState;

    signalR.isDisconnecting = isDisconnecting;

    signalR.connectionState = {
        connecting: 0,
        connected: 1,
        reconnecting: 2,
        disconnected: 4
    };

    signalR.hub = {
        start: function () {
            // This will get replaced with the real hub connection start method when hubs is referenced correctly
            throw new Error("SignalR: Error loading hubs. Ensure your hubs reference is correct, e.g. <script src='/signalr/hubs'></script>.");
        }
    };

    _pageWindow.load(function () { _pageLoaded = true; });

    function validateTransport(requestedTransport, connection) {
        /// <summary>Validates the requested transport by cross checking it with the pre-defined signalR.transports</summary>
        /// <param name="requestedTransport" type="Object">The designated transports that the user has specified.</param>
        /// <param name="connection" type="signalR">The connection that will be using the requested transports.  Used for logging purposes.</param>
        /// <returns type="Object" />

        if ($.isArray(requestedTransport)) {
            // Go through transport array and remove an "invalid" tranports
            for (var i = requestedTransport.length - 1; i >= 0; i--) {
                var transport = requestedTransport[i];
                if ($.type(requestedTransport) !== "object" && ($.type(transport) !== "string" || !signalR.transports[transport])) {
                    connection.log("Invalid transport: " + transport + ", removing it from the transports list.");
                    requestedTransport.splice(i, 1);
                }
            }

            // Verify we still have transports left, if we dont then we have invalid transports
            if (requestedTransport.length === 0) {
                connection.log("No transports remain within the specified transport array.");
                requestedTransport = null;
            }
        } else if ($.type(requestedTransport) !== "object" && !signalR.transports[requestedTransport] && requestedTransport !== "auto") {
            connection.log("Invalid transport: " + requestedTransport.toString() + ".");
            requestedTransport = null;
        }
        else if (requestedTransport === "auto" && signalR._.ieVersion <= 8) {
            // If we're doing an auto transport and we're IE8 then force longPolling, #1764
            return ["longPolling"];

        }

        return requestedTransport;
    }

    function getDefaultPort(protocol) {
        if (protocol === "http:") {
            return 80;
        }
        else if (protocol === "https:") {
            return 443;
        }
    }

    function addDefaultPort(protocol, url) {
        // Remove ports  from url.  We have to check if there's a / or end of line
        // following the port in order to avoid removing ports such as 8080.
        if (url.match(/:\d+$/)) {
            return url;
        } else {
            return url + ":" + getDefaultPort(protocol);
        }
    }

    signalR.fn = signalR.prototype = {
        init: function (url, qs, logging) {
            this.url = url;
            this.qs = qs;
            this._ = {
                keepAliveData: {},
                negotiateAbortText: "__Negotiate Aborted__",
                pingAbortText: "__Ping Aborted__",
                pingIntervalId: null,
                pingInterval: 300000,
                pollTimeoutId: null,
                reconnectTimeoutId: null,
                lastMessageAt: new Date().getTime(),
                lastActiveAt: new Date().getTime(),
                beatInterval: 5000, // Default value, will only be overridden if keep alive is enabled
                beatHandle: null,
                activePings: {},
                nextPingId: 0
            };
            if (typeof (logging) === "boolean") {
                this.logging = logging;
            }
        },

        _parseResponse: function (response) {
            var self = this;

            if (!response) {
                return response;
            } else if (self.ajaxDataType === "text") {
                return self.json.parse(response);
            } else {
                return response;
            }
        },

        json: window.JSON,

        isCrossDomain: function (url, against) {
            /// <summary>Checks if url is cross domain</summary>
            /// <param name="url" type="String">The base URL</param>
            /// <param name="against" type="Object">
            ///     An optional argument to compare the URL against, if not specified it will be set to window.location.
            ///     If specified it must contain a protocol and a host property.
            /// </param>
            var link;

            url = $.trim(url);

            against = against || window.location;

            if (url.indexOf("http") !== 0) {
                return false;
            }

            // Create an anchor tag.
            link = window.document.createElement("a");
            link.href = url;

            // When checking for cross domain we have to special case port 80 because the window.location will remove the 
            return link.protocol + addDefaultPort(link.protocol, link.host) !== against.protocol + addDefaultPort(against.protocol, against.host);
        },

        ajaxDataType: "text",

        contentType: "application/json; charset=UTF-8",

        logging: false,

        state: signalR.connectionState.disconnected,

        reconnectDelay: 2000,

        disconnectTimeout: 30000, // This should be set by the server in response to the negotiate request (30s default)

        reconnectWindow: 30000, // This should be set by the server in response to the negotiate request

        keepAliveWarnAt: 2 / 3, // Warn user of slow connection if we breach the X% mark of the keep alive timeout

        start: function (options, callback) {
            /// <summary>Starts the connection</summary>
            /// <param name="options" type="Object">Options map</param>
            /// <param name="callback" type="Function">A callback function to execute when the connection has started</param>
            var connection = this,
                config = {
                    pingInterval: 300000,
                    waitForPageLoad: true,
                    transport: "auto",
                    jsonp: false
                },
                initialize,
                deferred = connection._deferral || $.Deferred(), // Check to see if there is a pre-existing deferral that's being built on, if so we want to keep using it
                parser = window.document.createElement("a");

            // Persist the deferral so that if start is called multiple times the same deferral is used.
            connection._deferral = deferred;

            if ($.type(options) === "function") {
                // Support calling with single callback parameter
                callback = options;
            } else if ($.type(options) === "object") {
                $.extend(config, options);
                if ($.type(config.callback) === "function") {
                    callback = config.callback;
                }
            }

            config.transport = validateTransport(config.transport, connection);

            // If the transport is invalid throw an error and abort start
            if (!config.transport) {
                throw new Error("SignalR: Invalid transport(s) specified, aborting start.");
            }

            connection._.config = config;
            connection._.pingInterval = config.pingInterval;

            // Check to see if start is being called prior to page load
            // If waitForPageLoad is true we then want to re-direct function call to the window load event
            if (!_pageLoaded && config.waitForPageLoad === true) {
                connection._.deferredStartHandler = function () {
                    connection.start(options, callback);
                };
                _pageWindow.bind("load", connection._.deferredStartHandler);

                return deferred.promise();
            }

            // If we're already connecting just return the same deferral as the original connection start
            if (connection.state === signalR.connectionState.connecting) {
                return deferred.promise();
            }
            else if (changeState(connection,
                            signalR.connectionState.disconnected,
                            signalR.connectionState.connecting) === false) {
                // We're not connecting so try and transition into connecting.
                // If we fail to transition then we're either in connected or reconnecting.

                deferred.resolve(connection);
                return deferred.promise();
            }

            configureStopReconnectingTimeout(connection);

            // Resolve the full url
            parser.href = connection.url;
            if (!parser.protocol || parser.protocol === ":") {
                connection.protocol = window.document.location.protocol;
                connection.host = window.document.location.host;
                connection.baseUrl = connection.protocol + "//" + connection.host;
            }
            else {
                connection.protocol = parser.protocol;
                connection.host = parser.host;
                connection.baseUrl = parser.protocol + "//" + parser.host;
            }

            // Set the websocket protocol
            connection.wsProtocol = connection.protocol === "https:" ? "wss://" : "ws://";

            // If jsonp with no/auto transport is specified, then set the transport to long polling
            // since that is the only transport for which jsonp really makes sense.
            // Some developers might actually choose to specify jsonp for same origin requests
            // as demonstrated by Issue #623.
            if (config.transport === "auto" && config.jsonp === true) {
                config.transport = "longPolling";
            }

            // If the url is protocol relative, prepend the current windows protocol to the url. 
            if (connection.url.indexOf("//") === 0) {
                connection.url = window.location.protocol + connection.url;
                connection.log("Protocol relative URL detected, normalizing it to '" + connection.url + "'.");
            }

            if (this.isCrossDomain(connection.url)) {
                connection.log("Auto detected cross domain url.");

                if (config.transport === "auto") {
                    // Try webSockets and longPolling since SSE doesn't support CORS
                    // TODO: Support XDM with foreverFrame
                    config.transport = ["webSockets", "longPolling"];
                }

                if (config.withCredentials === undefined) {
                    config.withCredentials = true;
                }

                // Determine if jsonp is the only choice for negotiation, ajaxSend and ajaxAbort.
                // i.e. if the browser doesn't supports CORS
                // If it is, ignore any preference to the contrary, and switch to jsonp.
                if (!config.jsonp) {
                    config.jsonp = !$.support.cors;

                    if (config.jsonp) {
                        connection.log("Using jsonp because this browser doesn't support CORS.");
                    }
                }

                connection.contentType = signalR._.defaultContentType;
            }

            connection.withCredentials = config.withCredentials;
            connection.ajaxDataType = config.jsonp ? "jsonp" : "text";


            $(connection).bind(events.onStart, function (e, data) {
                if ($.type(callback) === "function") {
                    callback.call(connection);
                }
                deferred.resolve(connection);
            });

            initialize = function (transports, index) {
                index = index || 0;
                if (index >= transports.length) {
                    // No transport initialized successfully
                    $(connection).triggerHandler(events.onError, ["SignalR: No transport could be initialized successfully. Try specifying a different transport or none at all for auto initialization."]);
                    deferred.reject("SignalR: No transport could be initialized successfully. Try specifying a different transport or none at all for auto initialization.");
                    // Stop the connection if it has connected and move it into the disconnected state
                    connection.stop();
                    return;
                }

                // The connection was aborted
                if (connection.state === signalR.connectionState.disconnected) {
                    return;
                }

                var transportName = transports[index],
                    transport = $.type(transportName) === "object" ? transportName : signalR.transports[transportName];

                connection.transport = transport;

                if (transportName.indexOf("_") === 0) {
                    // Private member
                    initialize(transports, index + 1);
                    return;
                }

                transport.start(connection, function () { // success
                    // Firefox 11+ doesn't allow sync XHR withCredentials: https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest#withCredentials
                    var isFirefox11OrGreater = signalR._.firefoxMajorVersion(window.navigator.userAgent) >= 11,
                        asyncAbort = !!connection.withCredentials && isFirefox11OrGreater;

                    // The connection was aborted while initializing transports
                    if (connection.state === signalR.connectionState.disconnected) {
                        return;
                    }

                    if (transport.supportsKeepAlive && connection._.keepAliveData.activated) {
                        signalR.transports._logic.monitorKeepAlive(connection);
                    }

                    signalR.transports._logic.startHeartbeat(connection);

                    // Used to ensure low activity clients maintain their authentication.
                    // Must be configured once a transport has been decided to perform valid ping requests.
                    signalR._.configurePingInterval(connection);

                    changeState(connection,
                                signalR.connectionState.connecting,
                                signalR.connectionState.connected);

                    $(connection).triggerHandler(events.onStart);

                    // wire the stop handler for when the user leaves the page
                    _pageWindow.bind("unload", function () {
                        connection.log("Window unloading, stopping the connection.");

                        connection.stop(asyncAbort);
                    });

                    if (signalR._.firefoxMajorVersion(window.navigator.userAgent) >= 11) {
                        _pageWindow.bind("beforeunload", function () {
                            // If connection.stop() runs in beforeunload and fails, it will also fail
                            // in unload unless connection.stop() runs after a timeout.
                            window.setTimeout(function () {
                                connection.stop(asyncAbort);
                            }, 0);
                        });
                    }
                }, function () {
                    initialize(transports, index + 1);
                });
            };

            $(connection).triggerHandler(events.onStarting);
            
            var url = connection.url + "/negotiate",
                onFailed = function (error, connection) {
                    $(connection).triggerHandler(events.onError, [error.responseText]);
                    deferred.reject("SignalR: Error during negotiation request: " + error.responseText);
                    // Stop the connection if negotiate failed
                    connection.stop();
                };

            url = signalR.transports._logic.prepareQueryString(connection, url);

            connection.log("Negotiating with '" + url + "'.");

            // Save the ajax negotiate request object so we can abort it if stop is called while the request is in flight.
            connection._.negotiateRequest = $.ajax(
                $.extend({}, $.signalR.ajaxDefaults, {
                    xhrFields: { withCredentials: connection.withCredentials },
                    url: url,
                    type: "GET",
                    contentType: connection.contentType,
                    data: {},
                    dataType: connection.ajaxDataType,
                    error: function (error, statusText) {
                        // We don't want to cause any errors if we're aborting our own negotiate request.
                        if (statusText !== connection._.negotiateAbortText) {
                            onFailed(error, connection);
                        } else {
                            // This rejection will noop if the deferred has already been resolved or rejected.
                            deferred.reject("Stopped the connection while negotiating.");
                        }
                    },
                    success: function (result) {
                        var res,
                            keepAliveData = connection._.keepAliveData;

                        try {
                            res = connection._parseResponse(result);
                        }
                        catch (error) {
                            onFailed(error, connection);
                            return;
                        }

                        keepAliveData = connection._.keepAliveData;
                        connection.appRelativeUrl = res.Url;
                        connection.id = res.ConnectionId;
                        connection.token = res.ConnectionToken;
                        connection.webSocketServerUrl = res.WebSocketServerUrl;

                        // Once the server has labeled the PersistentConnection as Disconnected, we should stop attempting to reconnect
                        // after res.DisconnectTimeout seconds.
                        connection.disconnectTimeout = res.DisconnectTimeout * 1000; // in ms


                        // If we have a keep alive
                        if (res.KeepAliveTimeout) {
                            // Register the keep alive data as activated
                            keepAliveData.activated = true;

                            // Timeout to designate when to force the connection into reconnecting converted to milliseconds
                            keepAliveData.timeout = res.KeepAliveTimeout * 1000;

                            // Timeout to designate when to warn the developer that the connection may be dead or is not responding.
                            keepAliveData.timeoutWarning = keepAliveData.timeout * connection.keepAliveWarnAt;

                            // Instantiate the frequency in which we check the keep alive.  It must be short in order to not miss/pick up any changes
                            connection._.beatInterval = (keepAliveData.timeout - keepAliveData.timeoutWarning) / 3;
                        }
                        else {
                            keepAliveData.activated = false;
                        }

                        if (!res.ProtocolVersion || res.ProtocolVersion !== "1.2") {
                            $(connection).triggerHandler(events.onError, ["You are using a version of the client that isn't compatible with the server. Client version 1.2, server version " + res.ProtocolVersion + "."]);
                            deferred.reject("You are using a version of the client that isn't compatible with the server. Client version 1.2, server version " + res.ProtocolVersion + ".");
                            return;
                        }

                        var transports = [],
                            supportedTransports = [];

                        $.each(signalR.transports, function (key) {
                            if (key === "webSockets" && !res.TryWebSockets) {
                                // Server said don't even try WebSockets, but keep processing the loop
                                return true;
                            }
                            supportedTransports.push(key);
                        });

                        if ($.isArray(config.transport)) {
                            // ordered list provided
                            $.each(config.transport, function () {
                                var transport = this;
                                if ($.type(transport) === "object" || ($.type(transport) === "string" && $.inArray("" + transport, supportedTransports) >= 0)) {
                                    transports.push($.type(transport) === "string" ? "" + transport : transport);
                                }
                            });
                        } else if ($.type(config.transport) === "object" ||
                                        $.inArray(config.transport, supportedTransports) >= 0) {
                            // specific transport provided, as object or a named transport, e.g. "longPolling"
                            transports.push(config.transport);
                        } else { // default "auto"
                            transports = supportedTransports;
                        }
                        initialize(transports);
                    }
                }));

            return deferred.promise();
        },

        starting: function (callback) {
            /// <summary>Adds a callback that will be invoked before anything is sent over the connection</summary>
            /// <param name="callback" type="Function">A callback function to execute before the connection is fully instantiated.</param>
            /// <returns type="signalR" />
            var connection = this;
            $(connection).bind(events.onStarting, function (e, data) {
                callback.call(connection);
            });
            return connection;
        },

        send: function (data) {
            /// <summary>Sends data over the connection</summary>
            /// <param name="data" type="String">The data to send over the connection</param>
            /// <returns type="signalR" />
            var connection = this;

            if (connection.state === signalR.connectionState.disconnected) {
                // Connection hasn't been started yet
                throw new Error("SignalR: Connection must be started before data can be sent. Call .start() before .send()");
            }

            if (connection.state === signalR.connectionState.connecting) {
                // Connection hasn't been started yet
                throw new Error("SignalR: Connection has not been fully initialized. Use .start().done() or .start().fail() to run logic after the connection has started.");
            }

            connection.transport.send(connection, data);
            // REVIEW: Should we return deferred here?
            return connection;
        },

        received: function (callback) {
            /// <summary>Adds a callback that will be invoked after anything is received over the connection</summary>
            /// <param name="callback" type="Function">A callback function to execute when any data is received on the connection</param>
            /// <returns type="signalR" />
            var connection = this;
            $(connection).bind(events.onReceived, function (e, data) {
                callback.call(connection, data);
            });
            return connection;
        },

        stateChanged: function (callback) {
            /// <summary>Adds a callback that will be invoked when the connection state changes</summary>
            /// <param name="callback" type="Function">A callback function to execute when the connection state changes</param>
            /// <returns type="signalR" />
            var connection = this;
            $(connection).bind(events.onStateChanged, function (e, data) {
                callback.call(connection, data);
            });
            return connection;
        },

        error: function (callback) {
            /// <summary>Adds a callback that will be invoked after an error occurs with the connection</summary>
            /// <param name="callback" type="Function">A callback function to execute when an error occurs on the connection</param>
            /// <returns type="signalR" />
            var connection = this;
            $(connection).bind(events.onError, function (e, errorData, sendData) {
                // In practice 'errorData' is the SignalR built error object.
                // In practice 'sendData' is undefined for all error events except those triggered by ajaxSend.  For ajaxSend 'sendData' is the original send payload.
                callback.call(connection, errorData, sendData);
            });
            return connection;
        },

        disconnected: function (callback) {
            /// <summary>Adds a callback that will be invoked when the client disconnects</summary>
            /// <param name="callback" type="Function">A callback function to execute when the connection is broken</param>
            /// <returns type="signalR" />
            var connection = this;
            $(connection).bind(events.onDisconnect, function (e, data) {
                callback.call(connection);
            });
            return connection;
        },

        connectionSlow: function (callback) {
            /// <summary>Adds a callback that will be invoked when the client detects a slow connection</summary>
            /// <param name="callback" type="Function">A callback function to execute when the connection is slow</param>
            /// <returns type="signalR" />
            var connection = this;
            $(connection).bind(events.onConnectionSlow, function (e, data) {
                callback.call(connection);
            });

            return connection;
        },

        reconnecting: function (callback) {
            /// <summary>Adds a callback that will be invoked when the underlying transport begins reconnecting</summary>
            /// <param name="callback" type="Function">A callback function to execute when the connection enters a reconnecting state</param>
            /// <returns type="signalR" />
            var connection = this;
            $(connection).bind(events.onReconnecting, function (e, data) {
                callback.call(connection);
            });
            return connection;
        },

        reconnected: function (callback) {
            /// <summary>Adds a callback that will be invoked when the underlying transport reconnects</summary>
            /// <param name="callback" type="Function">A callback function to execute when the connection is restored</param>
            /// <returns type="signalR" />
            var connection = this;
            $(connection).bind(events.onReconnect, function (e, data) {
                callback.call(connection);
            });
            return connection;
        },

        stop: function (async, notifyServer) {
            /// <summary>Stops listening</summary>
            /// <param name="async" type="Boolean">Whether or not to asynchronously abort the connection</param>
            /// <param name="notifyServer" type="Boolean">Whether we want to notify the server that we are aborting the connection</param>
            /// <returns type="signalR" />
            var connection = this,
                // Save deferral because this is always cleaned up
                deferral = connection._deferral,
                config = connection._.config;

            // Verify that we've bound a load event.
            if (connection._.deferredStartHandler) {
                // Unbind the event.
                _pageWindow.unbind("load", connection._.deferredStartHandler);
            }

            // Always clean up private non-timeout based state.
            delete connection._deferral;
            delete connection._.config;
            delete connection._.deferredStartHandler;

            // This needs to be checked despite the connection state because a connection start can be deferred until page load.
            // If we've deferred the start due to a page load we need to unbind the "onLoad" -> start event.
            if (!_pageLoaded && (!config || config.waitForPageLoad === true)) {
                connection.log("Stopping connection prior to negotiate.");

                // If we have a deferral we should reject it
                if (deferral) {
                    deferral.reject("The connection was stopped during page load.");
                }

                // Short-circuit because the start has not been fully started.
                return;
            }

            if (connection.state === signalR.connectionState.disconnected) {
                return;
            }

            connection.log("Stopping connection.");

            changeState(connection, connection.state, signalR.connectionState.disconnected);

            window.clearTimeout(connection._.beatHandle);
            window.clearInterval(connection._.pingIntervalId);
            window.clearTimeout(connection._.pingLoopId);

            if (connection.transport) {
                if (notifyServer !== false) {
                    connection.transport.abort(connection, async);
                }

                if (connection.transport.supportsKeepAlive && connection._.keepAliveData.activated) {
                    signalR.transports._logic.stopMonitoringKeepAlive(connection);
                }

                connection.transport.stop(connection);
                connection.transport = null;
            }

            if (connection._.negotiateRequest) {
                // If the negotiation request has already completed this will noop.
                    connection._.negotiateRequest.abort(connection._.negotiateAbortText);
                delete connection._.negotiateRequest;
            }

            $.each(connection._.activePings, function (i, pingXhr) {
                connection.log("Aborting ping " + i + ".");
                pingXhr.abort(connection._.pingAbortText);
            });

            // Trigger the disconnect event
            $(connection).triggerHandler(events.onDisconnect);

            delete connection.messageId;
            delete connection.groupsToken;
            delete connection.id;
            delete connection._.pingIntervalId;
            delete connection._.lastMessageAt;
            delete connection._.lastActiveAt;
            delete connection._.pingLoopId;

            return connection;
        },

        log: function (msg) {
            log(msg, this.logging);
        }
    };

    signalR.fn.init.prototype = signalR.fn;

    signalR.noConflict = function () {
        /// <summary>Reinstates the original value of $.connection and returns the signalR object for manual assignment</summary>
        /// <returns type="signalR" />
        if ($.connection === signalR) {
            $.connection = _connection;
        }
        return signalR;
    };

    if ($.connection) {
        _connection = $.connection;
    }

    $.connection = $.signalR = signalR;

}(window.jQuery, window));
/* jquery.signalR.transports.common.js */
// Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.md in the project root for license information.

/*global window:false */
/// <reference path="jquery.signalR.core.js" />

(function ($, window, undefined) {
    "use strict";

    var signalR = $.signalR,
        events = $.signalR.events,
        changeState = $.signalR.changeState,
        transportLogic;

    signalR.transports = {};

    function beat(connection) {
        if (connection._.keepAliveData.monitoring) {
            checkIfAlive(connection);
        }

        // Ensure that we successfully marked active before continuing the heartbeat.
        if (transportLogic.markActive(connection)) {
            connection._.beatHandle = window.setTimeout(function () {
                beat(connection);
            }, connection._.beatInterval);
        }
    }

    function checkIfAlive(connection) {
        var keepAliveData = connection._.keepAliveData,
            timeElapsed;

        // Only check if we're connected
        if (connection.state === signalR.connectionState.connected) {
            timeElapsed = new Date().getTime() - connection._.lastMessageAt;

            // Check if the keep alive has completely timed out
            if (timeElapsed >= keepAliveData.timeout) {
                connection.log("Keep alive timed out.  Notifying transport that connection has been lost.");

                // Notify transport that the connection has been lost
                connection.transport.lostConnection(connection);
            }
            else if (timeElapsed >= keepAliveData.timeoutWarning) {
                // This is to assure that the user only gets a single warning
                if (!keepAliveData.userNotified) {
                    connection.log("Keep alive has been missed, connection may be dead/slow.");
                    $(connection).triggerHandler(events.onConnectionSlow);
                    keepAliveData.userNotified = true;
                }
            }
            else {
                keepAliveData.userNotified = false;
            }
        }
    }

    function isConnectedOrReconnecting(connection) {
        return connection.state === signalR.connectionState.connected ||
               connection.state === signalR.connectionState.reconnecting;
    }

    function addConnectionData(url, connectionData) {
        var appender = url.indexOf("?") !== -1 ? "&" : "?";

        if (connectionData) {
            url += appender + "connectionData=" + window.encodeURIComponent(connectionData);
        }

        return url;
    }

    transportLogic = signalR.transports._logic = {
        pingServer: function (connection) {
            /// <summary>Pings the server</summary>
            /// <param name="connection" type="signalr">Connection associated with the server ping</param>
            /// <returns type="signalR" />
            var url,
                deferral = $.Deferred(),
                activePings = connection._.activePings,
                pingId = connection._.nextPingId++;

            url = connection.url + "/ping";
            url = transportLogic.prepareQueryString(connection, url);

            activePings[pingId] = $.ajax(
                $.extend({}, $.signalR.ajaxDefaults, {
                    xhrFields: { withCredentials: connection.withCredentials },
                    url: url,
                    type: "GET",
                    contentType: connection.contentType,
                    data: {},
                    dataType: connection.ajaxDataType,
                    success: function (result) {
                        var data;
                        
                        try {
                            data = connection._parseResponse(result);
                        }
                        catch (error) {
                            deferral.reject("Failed to parse ping server response, stopping the connection: " + result);
                            connection.stop();
                            return;
                        }

                        if (data.Response === "pong") {
                            deferral.resolve();
                        }
                        else {
                            deferral.reject("SignalR: Invalid ping response when pinging server: " + data.Response);
                        }
                    },
                    error: function (error, statusText) {
                        if (error.status === 401 || error.status === 403) {
                            deferral.reject("Failed to ping server. Server responded with a " + error.status + " status code, stopping the connection.");
                            connection.stop();
                        }
                        else if (statusText === connection._.pingAbortText)
                        {
                            // We don't want to cause any errors if we're aborting our own ping request.
                            // Don't reject or resolve the deferred, because we want the long-polling pingLoop to stop.
                            connection.log("Ping " + pingId + " aborted.");
                        }
                        else {
                            deferral.reject("SignalR: Error pinging server: " + (error.responseText || error.statusText));
                        }
                    },
                    complete: function () {
                        delete activePings[pingId];
                    }
                }));

            return deferral.promise();
        },

        prepareQueryString: function (connection, url) {
            url = transportLogic.addQs(url, connection);

            return addConnectionData(url, connection.data);
        },

        addQs: function (url, connection) {
            var appender = url.indexOf("?") !== -1 ? "&" : "?",
                firstChar;

            if (!connection.qs) {
                return url;
            }

            if (typeof (connection.qs) === "object") {
                return url + appender + $.param(connection.qs);
            }

            if (typeof (connection.qs) === "string") {
                firstChar = connection.qs.charAt(0);

                if (firstChar === "?" || firstChar === "&") {
                    appender = "";
                }

                return url + appender + connection.qs;
            }

            throw new Error("Connections query string property must be either a string or object.");
        },

        getUrl: function (connection, transport, reconnecting, poll) {
            /// <summary>Gets the url for making a GET based connect request</summary>
            var baseUrl = transport === "webSockets" ? "" : connection.baseUrl,
                url = baseUrl + connection.appRelativeUrl,
                qs = "transport=" + transport + "&connectionToken=" + window.encodeURIComponent(connection.token);

            if (connection.groupsToken) {
                qs += "&groupsToken=" + window.encodeURIComponent(connection.groupsToken);
            }

            if (!reconnecting) {
                url += "/connect";
            } else {
                if (poll) {
                    // longPolling transport specific
                    url += "/poll";
                } else {
                    url += "/reconnect";
                }

                if (connection.messageId) {
                    qs += "&messageId=" + window.encodeURIComponent(connection.messageId);
                }
            }
            url += "?" + qs;
            url = transportLogic.prepareQueryString(connection, url);
            url += "&tid=" + Math.floor(Math.random() * 11);
            return url;
        },

        maximizePersistentResponse: function (minPersistentResponse) {
            return {
                MessageId: minPersistentResponse.C,
                Messages: minPersistentResponse.M,
                Disconnect: typeof (minPersistentResponse.D) !== "undefined" ? true : false,
                ShouldReconnect: typeof (minPersistentResponse.T) !== "undefined" ? true : false,
                LongPollDelay: minPersistentResponse.L,
                GroupsToken: minPersistentResponse.G
            };
        },

        updateGroups: function (connection, groupsToken) {
            if (groupsToken) {
                connection.groupsToken = groupsToken;
            }
        },

        ajaxSend: function (connection, data) {
            var url = connection.url + "/send" + "?transport=" + connection.transport.name + "&connectionToken=" + window.encodeURIComponent(connection.token),
                onFail = function (error, connection) {
                    $(connection).triggerHandler(events.onError, [error, data]);
                };

            url = transportLogic.prepareQueryString(connection, url);
            
            return $.ajax(
                $.extend({}, $.signalR.ajaxDefaults, {
                    xhrFields: { withCredentials: connection.withCredentials },
                    url: url,
                    type: connection.ajaxDataType === "jsonp" ? "GET" : "POST",
                    contentType: signalR._.defaultContentType,
                    dataType: connection.ajaxDataType,
                    data: {
                        data: data
                    },
                    success: function (result) {
                        var res;

                        if (result) {
                            try {
                                res = connection._parseResponse(result);
                            }
                            catch (error) {
                                onFail(error, connection);
                                connection.stop();
                                return;
                            }

                            $(connection).triggerHandler(events.onReceived, [res]);
                        }
                    },
                    error: function (error, textStatus) {
                        if (textStatus === "abort" || textStatus === "parsererror") {
                            // The parsererror happens for sends that don't return any data, and hence
                            // don't write the jsonp callback to the response. This is harder to fix on the server
                            // so just hack around it on the client for now.
                            return;
                        }

                        onFail(error, connection);
                    }
                }));
        },

        ajaxAbort: function (connection, async) {
            if (typeof (connection.transport) === "undefined") {
                return;
            }

            // Async by default unless explicitly overidden
            async = typeof async === "undefined" ? true : async;

            var url = connection.url + "/abort" + "?transport=" + connection.transport.name + "&connectionToken=" + window.encodeURIComponent(connection.token);
            url = transportLogic.prepareQueryString(connection, url);

            $.ajax(
                $.extend({}, $.signalR.ajaxDefaults, {
                    xhrFields: { withCredentials: connection.withCredentials },
                    url: url,
                    async: async,
                    timeout: 1000,
                    type: "POST",
                    contentType: connection.contentType,
                    dataType: connection.ajaxDataType,
                    data: {}
                }));

            connection.log("Fired ajax abort async = " + async + ".");
        },

        processMessages: function (connection, minData) {
            var data;
            // Transport can be null if we've just closed the connection
            if (connection.transport) {
                var $connection = $(connection);

                // Update the last message time stamp
                transportLogic.markLastMessage(connection);

                if (!minData) {
                    return;
                }

                data = this.maximizePersistentResponse(minData);

                if (data.Disconnect) {
                    connection.log("Disconnect command received from server.");

                    // Disconnected by the server
                    connection.stop(false, false);
                    return;
                }

                this.updateGroups(connection, data.GroupsToken);

                if (data.Messages) {
                    $.each(data.Messages, function (index, message) {
                        $connection.triggerHandler(events.onReceived, [message]);
                    });
                }

                if (data.MessageId) {
                    connection.messageId = data.MessageId;
                }
            }
        },

        monitorKeepAlive: function (connection) {
            var keepAliveData = connection._.keepAliveData;

            // If we haven't initiated the keep alive timeouts then we need to
            if (!keepAliveData.monitoring) {
                keepAliveData.monitoring = true;

                // Initialize the keep alive time stamp ping
                transportLogic.markLastMessage(connection);

                // Save the function so we can unbind it on stop
                connection._.keepAliveData.reconnectKeepAliveUpdate = function () {
                    // Mark a new message so that keep alive doesn't time out connections
                    transportLogic.markLastMessage(connection);
                };

                // Update Keep alive on reconnect
                $(connection).bind(events.onReconnect, connection._.keepAliveData.reconnectKeepAliveUpdate);

                connection.log("Now monitoring keep alive with a warning timeout of " + keepAliveData.timeoutWarning + " and a connection lost timeout of " + keepAliveData.timeout + ".");
            }
            else {
                connection.log("Tried to monitor keep alive but it's already being monitored.");
            }
        },

        stopMonitoringKeepAlive: function (connection) {
            var keepAliveData = connection._.keepAliveData;

            // Only attempt to stop the keep alive monitoring if its being monitored
            if (keepAliveData.monitoring) {
                // Stop monitoring
                keepAliveData.monitoring = false;

                // Remove the updateKeepAlive function from the reconnect event
                $(connection).unbind(events.onReconnect, connection._.keepAliveData.reconnectKeepAliveUpdate);

                // Clear all the keep alive data
                connection._.keepAliveData = {};
                connection.log("Stopping the monitoring of the keep alive.");
            }
        },

        startHeartbeat: function (connection) {
            beat(connection);
        },

        markLastMessage: function (connection) {
            connection._.lastMessageAt = new Date().getTime();
        },

        markActive: function (connection) {
            if (transportLogic.verifyLastActive(connection)) {
                connection._.lastActiveAt = new Date().getTime();
                return true;
            }

            return false;
        },

        ensureReconnectingState: function (connection) {
            if (changeState(connection,
                        signalR.connectionState.connected,
                        signalR.connectionState.reconnecting) === true) {
                $(connection).triggerHandler(events.onReconnecting);
            }
            return connection.state === signalR.connectionState.reconnecting;
        },

        clearReconnectTimeout: function (connection) {
            if (connection && connection._.reconnectTimeout) {
                window.clearTimeout(connection._.reconnectTimeout);
                delete connection._.reconnectTimeout;
            }
        },

        verifyLastActive: function (connection) {
            if (new Date().getTime() - connection._.lastActiveAt >= connection.reconnectWindow) {
                connection.log("There has not been an active server connection for an extended periord of time. Stopping connection.");
                connection.stop();
                return false;
            }

            return true;
        },

        reconnect: function (connection, transportName) {
            var transport = signalR.transports[transportName],
                that = this;

            // We should only set a reconnectTimeout if we are currently connected
            // and a reconnectTimeout isn't already set.
            if (isConnectedOrReconnecting(connection) && !connection._.reconnectTimeout) {
                // Need to verify before the setTimeout occurs because an application sleep could occur during the setTimeout duration.
                if (!transportLogic.verifyLastActive(connection)) {
                    return;
                }

                connection._.reconnectTimeout = window.setTimeout(function () {
                    if (!transportLogic.verifyLastActive(connection)) {
                        return;
                    }

                    transport.stop(connection);

                    if (that.ensureReconnectingState(connection)) {
                        connection.log(transportName + " reconnecting.");
                        transport.start(connection);
                    }
                }, connection.reconnectDelay);
            }
        },

        handleParseFailure: function (connection, result, errorMessage, onFailed) {
            // If we're in the initialization phase trigger onFailed, otherwise stop the connection.
            if (connection.state === signalR.connectionState.connecting) {
                connection.log("Failed to parse server response while attempting to connect.");
                onFailed();
            }
            else {
                $(connection).triggerHandler(events.onError, ["SignalR: failed at parsing response: " + result + ".  With error: " + errorMessage]);
                connection.stop();
            }
        },

        foreverFrame: {
            count: 0,
            connections: {}
        }
    };

}(window.jQuery, window));
/* jquery.signalR.transports.webSockets.js */
// Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.md in the project root for license information.

/*global window:false */
/// <reference path="jquery.signalR.transports.common.js" />

(function ($, window, undefined) {
    "use strict";

    var signalR = $.signalR,
        events = $.signalR.events,
        changeState = $.signalR.changeState,
        transportLogic = signalR.transports._logic;

    signalR.transports.webSockets = {
        name: "webSockets",

        supportsKeepAlive: true,

        timeOut: 3000,

        send: function (connection, data) {
            connection.socket.send(data);
        },

        start: function (connection, onSuccess, onFailed) {
            var url,
                opened = false,
                that = this,
                initialSocket,
                timeOutHandle,
                reconnecting = !onSuccess;

            if (!window.WebSocket) {
                onFailed();
                return;
            }

            if (!connection.socket) {
                if (connection.webSocketServerUrl) {
                    url = connection.webSocketServerUrl;
                }
                else {
                    url = connection.wsProtocol + connection.host;
                }

                url += transportLogic.getUrl(connection, this.name, reconnecting);

                connection.log("Connecting to websocket endpoint '" + url + "'.");
                connection.socket = new window.WebSocket(url);

                // Issue #1653: Galaxy S3 Android Stock Browser fails silently to establish websocket connections. 
                if (onFailed) {
                    initialSocket = connection.socket;
                    timeOutHandle = window.setTimeout(function () {
                        if (initialSocket === connection.socket) {
                            connection.log("WebSocket timed out trying to connect.");
                            onFailed();
                        }
                    }, that.timeOut);
                }

                connection.socket.onopen = function () {
                    window.clearTimeout(timeOutHandle);
                    opened = true;
                    connection.log("Websocket opened.");
                };

                connection.socket.onclose = function (event) {
                    // Only handle a socket close if the close is from the current socket.
                    // Sometimes on disconnect the server will push down an onclose event
                    // to an expired socket.
                    window.clearTimeout(timeOutHandle);

                    if (this === connection.socket) {
                        if (!opened) {
                            if (onFailed) {
                                onFailed();
                            }
                            else if (reconnecting) {
                                that.reconnect(connection);
                            }
                            return;
                        }
                        else if (typeof event.wasClean !== "undefined" && event.wasClean === false) {
                            // Ideally this would use the websocket.onerror handler (rather than checking wasClean in onclose) but
                            // I found in some circumstances Chrome won't call onerror. This implementation seems to work on all browsers.
                            $(connection).triggerHandler(events.onError, [event.reason]);
                            connection.log("Unclean disconnect from websocket: " + event.reason || "[no reason given].");
                        }
                        else {
                            connection.log("Websocket closed.");
                        }

                        that.reconnect(connection);
                    }
                };

                connection.socket.onmessage = function (event) {
                    var data,
                        $connection = $(connection);

                    try {
                        data = connection._parseResponse(event.data);
                    }
                    catch (error) {
                        transportLogic.handleParseFailure(connection, event.data, error.message, onFailed);
                        return;
                    }
                    
                    if (onSuccess) {
                        onSuccess();
                        onSuccess = null;
                    } else if (changeState(connection,
                                         signalR.connectionState.reconnecting,
                                         signalR.connectionState.connected) === true) {
                        $connection.triggerHandler(events.onReconnect);
                    }

                    transportLogic.clearReconnectTimeout(connection);

                    if (data) {
                        // data.M is PersistentResponse.Messages
                        if ($.isEmptyObject(data) || data.M) {
                            transportLogic.processMessages(connection, data);
                        } else {
                            // For websockets we need to trigger onReceived
                            // for callbacks to outgoing hub calls.
                            $connection.triggerHandler(events.onReceived, [data]);
                        }
                    }
                };
            }
        },

        reconnect: function (connection) {
            transportLogic.reconnect(connection, this.name);
        },

        lostConnection: function (connection) {
            this.reconnect(connection);

        },

        stop: function (connection) {
            // Don't trigger a reconnect after stopping
            transportLogic.clearReconnectTimeout(connection);

            if (connection.socket !== null) {
                connection.log("Closing the Websocket.");
                connection.socket.close();
                connection.socket = null;
            }
        },

        abort: function (connection, async) {
            transportLogic.ajaxAbort(connection, async);
        }
    };

}(window.jQuery, window));
/* jquery.signalR.transports.serverSentEvents.js */
// Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.md in the project root for license information.

/*global window:false */
/// <reference path="jquery.signalR.transports.common.js" />

(function ($, window, undefined) {
    "use strict";

    var signalR = $.signalR,
        events = $.signalR.events,
        changeState = $.signalR.changeState,
        transportLogic = signalR.transports._logic;

    signalR.transports.serverSentEvents = {
        name: "serverSentEvents",

        supportsKeepAlive: true,

        timeOut: 3000,

        start: function (connection, onSuccess, onFailed) {
            var that = this,
                opened = false,
                $connection = $(connection),
                reconnecting = !onSuccess,
                url,
                connectTimeOut;

            if (connection.eventSource) {
                connection.log("The connection already has an event source. Stopping it.");
                connection.stop();
            }

            if (!window.EventSource) {
                if (onFailed) {
                    connection.log("This browser doesn't support SSE.");
                    onFailed();
                }
                return;
            }

            url = transportLogic.getUrl(connection, this.name, reconnecting);

            try {
                connection.log("Attempting to connect to SSE endpoint '" + url + "'.");
                connection.eventSource = new window.EventSource(url);
            }
            catch (e) {
                connection.log("EventSource failed trying to connect with error " + e.Message + ".");
                if (onFailed) {
                    // The connection failed, call the failed callback
                    onFailed();
                }
                else {
                    $connection.triggerHandler(events.onError, [e]);
                    if (reconnecting) {
                        // If we were reconnecting, rather than doing initial connect, then try reconnect again
                        that.reconnect(connection);
                    }
                }
                return;
            }

            // After connecting, if after the specified timeout there's no response stop the connection
            // and raise on failed
            connectTimeOut = window.setTimeout(function () {
                if (opened === false && connection.eventSource) {
                    connection.log("EventSource timed out trying to connect.");
                    connection.log("EventSource readyState: " + connection.eventSource.readyState + ".");

                    if (!reconnecting) {
                        that.stop(connection);
                    }

                    if (reconnecting) {
                        // If we're reconnecting and the event source is attempting to connect,
                        // don't keep retrying. This causes duplicate connections to spawn.
                        if (connection.eventSource.readyState !== window.EventSource.OPEN) {
                            // If we were reconnecting, rather than doing initial connect, then try reconnect again
                            that.reconnect(connection);
                        }
                    } else if (onFailed) {
                        onFailed();
                    }
                }
            },
            that.timeOut);

            connection.eventSource.addEventListener("open", function (e) {
                connection.log("EventSource connected.");

                if (connectTimeOut) {
                    window.clearTimeout(connectTimeOut);
                }

                transportLogic.clearReconnectTimeout(connection);

                if (opened === false) {
                    opened = true;

                    if (onSuccess) {
                        onSuccess();
                    } else if (changeState(connection,
                                         signalR.connectionState.reconnecting,
                                         signalR.connectionState.connected) === true) {
                        // If there's no onSuccess handler we assume this is a reconnect
                        $connection.triggerHandler(events.onReconnect);
                    }
                }
            }, false);

            connection.eventSource.addEventListener("message", function (e) {
                var res;

                // process messages
                if (e.data === "initialized") {
                    return;
                }

                try {
                    res = connection._parseResponse(e.data);
                }
                catch (error) {
                    transportLogic.handleParseFailure(connection, e.data, error.message, onFailed);
                    return;
                }

                transportLogic.processMessages(connection, res, onSuccess);
            }, false);

            connection.eventSource.addEventListener("error", function (e) {
                // Only handle an error if the error is from the current Event Source.
                // Sometimes on disconnect the server will push down an error event
                // to an expired Event Source.
                if (this === connection.eventSource) {
                    if (!opened) {
                        if (onFailed) {
                            onFailed();
                        }

                        return;
                    }

                    connection.log("EventSource readyState: " + connection.eventSource.readyState + ".");

                    if (e.eventPhase === window.EventSource.CLOSED) {
                        // We don't use the EventSource's native reconnect function as it
                        // doesn't allow us to change the URL when reconnecting. We need
                        // to change the URL to not include the /connect suffix, and pass
                        // the last message id we received.
                        connection.log("EventSource reconnecting due to the server connection ending.");
                        that.reconnect(connection);
                    } else {
                        // connection error
                        connection.log("EventSource error.");
                        $connection.triggerHandler(events.onError);
                    }
                }
            }, false);
        },

        reconnect: function (connection) {
            transportLogic.reconnect(connection, this.name);
        },

        lostConnection: function (connection) {
            this.reconnect(connection);
        },

        send: function (connection, data) {
            transportLogic.ajaxSend(connection, data);
        },

        stop: function (connection) {
            // Don't trigger a reconnect after stopping
            transportLogic.clearReconnectTimeout(connection);

            if (connection && connection.eventSource) {
                connection.log("EventSource calling close().");
                connection.eventSource.close();
                connection.eventSource = null;
                delete connection.eventSource;
            }
        },

        abort: function (connection, async) {
            transportLogic.ajaxAbort(connection, async);
        }
    };

}(window.jQuery, window));
/* jquery.signalR.transports.foreverFrame.js */
// Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.md in the project root for license information.

/*global window:false */
/// <reference path="jquery.signalR.transports.common.js" />

(function ($, window, undefined) {
    "use strict";

    var signalR = $.signalR,
        events = $.signalR.events,
        changeState = $.signalR.changeState,
        transportLogic = signalR.transports._logic,
        createFrame = function () {
            var frame = window.document.createElement("iframe");
            frame.setAttribute("style", "position:absolute;top:0;left:0;width:0;height:0;visibility:hidden;");
            return frame;
        },
        // Used to prevent infinite loading icon spins in older versions of ie
        // We build this object inside a closure so we don't pollute the rest of   
        // the foreverFrame transport with unnecessary functions/utilities.
        loadPreventer = (function () {
            var loadingFixIntervalId = null,
                loadingFixInterval = 1000,
                attachedTo = 0;

            return {
                prevent: function () {
                    // Prevent additional iframe removal procedures from newer browsers
                    if (signalR._.ieVersion <= 8) {
                        // We only ever want to set the interval one time, so on the first attachedTo
                        if (attachedTo === 0) {
                            // Create and destroy iframe every 3 seconds to prevent loading icon, super hacky
                            loadingFixIntervalId = window.setInterval(function () {
                                var tempFrame = createFrame();

                                window.document.body.appendChild(tempFrame);
                                window.document.body.removeChild(tempFrame);

                                tempFrame = null;
                            }, loadingFixInterval);
                        }

                        attachedTo++;
                    }
                },
                cancel: function () {                   
                    // Only clear the interval if there's only one more object that the loadPreventer is attachedTo
                    if (attachedTo === 1) {
                        window.clearInterval(loadingFixIntervalId);
                    }

                    if (attachedTo > 0) {
                        attachedTo--;
                    }
                }
            };
        })();

    signalR.transports.foreverFrame = {
        name: "foreverFrame",

        supportsKeepAlive: true,

        timeOut: 3000,

        // Added as a value here so we can create tests to verify functionality
        iframeClearThreshold: 50,

        start: function (connection, onSuccess, onFailed) {
            var that = this,
                frameId = (transportLogic.foreverFrame.count += 1),
                url,
                frame = createFrame(),
                frameLoadHandler = function () {
                    connection.log("Forever frame iframe finished loading and is no longer receiving messages, reconnecting.");
                    that.reconnect(connection);
                };

            if (window.EventSource) {
                // If the browser supports SSE, don't use Forever Frame
                if (onFailed) {
                    connection.log("This browser supports SSE, skipping Forever Frame.");
                    onFailed();
                }
                return;
            }

            frame.setAttribute("data-signalr-connection-id", connection.id);

            // Start preventing loading icon
            // This will only perform work if the loadPreventer is not attached to another connection.
            loadPreventer.prevent();

            // Build the url
            url = transportLogic.getUrl(connection, this.name);
            url += "&frameId=" + frameId;

            // Set body prior to setting URL to avoid caching issues.
            window.document.body.appendChild(frame);

            connection.log("Binding to iframe's load event.");

            if (frame.addEventListener) {
                frame.addEventListener("load", frameLoadHandler, false);
            } else if (frame.attachEvent) {
                frame.attachEvent("onload", frameLoadHandler);
            }

            frame.src = url;
            transportLogic.foreverFrame.connections[frameId] = connection;

            connection.frame = frame;
            connection.frameId = frameId;

            if (onSuccess) {
                connection.onSuccess = function () {
                    connection.log("Iframe transport started.");
                    onSuccess();
                };
            }

            // After connecting, if after the specified timeout there's no response stop the connection
            // and raise on failed
            window.setTimeout(function () {
                if (connection.onSuccess) {
                    connection.log("Failed to connect using forever frame source, it timed out after " + that.timeOut + "ms.");
                    that.stop(connection);

                    if (onFailed) {
                        onFailed();
                    }
                }
            }, that.timeOut);
        },

        reconnect: function (connection) {
            var that = this;

            // Need to verify before the setTimeout occurs because an application sleep could occur during the setTimeout duration.
            if (!transportLogic.verifyLastActive(connection)) {
                return;
            }

            window.setTimeout(function () {
                // Verify that we're ok to reconnect
                if (!transportLogic.verifyLastActive(connection)) {
                    return;
                }

                if (connection.frame && transportLogic.ensureReconnectingState(connection)) {
                    var frame = connection.frame,
                        src = transportLogic.getUrl(connection, that.name, true) + "&frameId=" + connection.frameId;
                    connection.log("Updating iframe src to '" + src + "'.");
                    frame.src = src;
                }
            }, connection.reconnectDelay);
        },

        lostConnection: function (connection) {
            this.reconnect(connection);
        },

        send: function (connection, data) {
            transportLogic.ajaxSend(connection, data);
        },

        receive: function (connection, data) {
            var cw,
                body;

            transportLogic.processMessages(connection, data);
            // Delete the script & div elements
            connection.frameMessageCount = (connection.frameMessageCount || 0) + 1;
            if (connection.frameMessageCount > signalR.transports.foreverFrame.iframeClearThreshold && connection.state === $.signalR.connectionState.connected) {
                connection.frameMessageCount = 0;
                cw = connection.frame.contentWindow || connection.frame.contentDocument;
                if (cw && cw.document && cw.document.body) {
                    body = cw.document.body;

                    // Remove all the child elements from the iframe's body to conserver memory
                    while (body.firstChild) {
                        body.removeChild(body.firstChild);
                    }
                }
            }
        },

        stop: function (connection) {
            var cw = null;

            // Stop attempting to prevent loading icon
            loadPreventer.cancel();

            if (connection.frame) {
                if (connection.frame.stop) {
                    connection.frame.stop();
                } else {
                    try {
                        cw = connection.frame.contentWindow || connection.frame.contentDocument;
                        if (cw.document && cw.document.execCommand) {
                            cw.document.execCommand("Stop");
                        }
                    }
                    catch (e) {
                        connection.log("Error occured when stopping foreverFrame transport. Message = " + e.message + ".");
                    }
                }

                // Ensure the iframe is where we left it
                if (connection.frame.parentNode === window.document.body) {
                    window.document.body.removeChild(connection.frame);
                }

                delete transportLogic.foreverFrame.connections[connection.frameId];
                connection.frame = null;
                connection.frameId = null;
                delete connection.frame;
                delete connection.frameId;
                delete connection.frameMessageCount;
                connection.log("Stopping forever frame.");
            }
        },

        abort: function (connection, async) {
            transportLogic.ajaxAbort(connection, async);
        },

        getConnection: function (id) {
            return transportLogic.foreverFrame.connections[id];
        },

        started: function (connection) {
            if (connection.onSuccess) {
                connection.onSuccess();
                connection.onSuccess = null;
                delete connection.onSuccess;
            } else if (changeState(connection,
                                   signalR.connectionState.reconnecting,
                                   signalR.connectionState.connected) === true) {
                // If there's no onSuccess handler we assume this is a reconnect
                $(connection).triggerHandler(events.onReconnect);
            }
        }
    };

}(window.jQuery, window));
/* jquery.signalR.transports.longPolling.js */
// Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.md in the project root for license information.

/*global window:false */
/// <reference path="jquery.signalR.transports.common.js" />

(function ($, window, undefined) {
    "use strict";

    var signalR = $.signalR,
        events = $.signalR.events,
        changeState = $.signalR.changeState,
        isDisconnecting = $.signalR.isDisconnecting,
        transportLogic = signalR.transports._logic;

    signalR.transports.longPolling = {
        name: "longPolling",

        supportsKeepAlive: false,

        reconnectDelay: 3000,

        init: function (connection, onComplete) {
            /// <summary>Pings the server to ensure availability</summary>
            /// <param name="connection" type="signalr">Connection associated with the server ping</param>
            /// <param name="onComplete" type="Function">Callback to call once initialization has completed</param>

            var that = this,
                pingLoop,
                // pingFail is used to loop the re-ping behavior.  When we fail we want to re-try.
                pingFail = function (reason) {
                    if (isDisconnecting(connection) === false) {
                        connection.log("Server ping failed because '" + reason + "', re-trying ping.");
                        connection._.pingLoopId = window.setTimeout(pingLoop, that.reconnectDelay);
                    }
                };

            connection.log("Initializing long polling connection with server.");
            pingLoop = function () {
                // Ping the server, on successful ping call the onComplete method, otherwise if we fail call the pingFail
                transportLogic.pingServer(connection).done(onComplete).fail(pingFail);
            };

            pingLoop();
        },

        start: function (connection, onSuccess, onFailed) {
            /// <summary>Starts the long polling connection</summary>
            /// <param name="connection" type="signalR">The SignalR connection to start</param>
            var that = this,
                fireConnect = function () {
                    tryFailConnect = fireConnect = $.noop;

                    connection.log("Longpolling connected.");
                    onSuccess();

                    // Reset onFailed to null because it shouldn't be called again
                    onFailed = null;
                },
                tryFailConnect = function () {
                    if (onFailed) {
                        onFailed();
                        onFailed = null;
                        connection.log("LongPolling failed to connect.");
                        return true;
                    }

                    return false;
                },
                privateData = connection._,
                reconnectErrors = 0,
                fireReconnected = function (instance) {
                    window.clearTimeout(privateData.reconnectTimeoutId);
                    privateData.reconnectTimeoutId = null;

                    if (changeState(connection,
                                    signalR.connectionState.reconnecting,
                                    signalR.connectionState.connected) === true) {
                        // Successfully reconnected!
                        connection.log("Raising the reconnect event.");
                        $(instance).triggerHandler(events.onReconnect);
                    }
                },
                // 1 hour
                maxFireReconnectedTimeout = 3600000;

            if (connection.pollXhr) {
                connection.log("Polling xhr requests already exists, aborting.");
                connection.stop();
            }

            privateData.reconnectTimeoutId = null;
            privateData.pollTimeoutId = null;

            // We start with an initialization procedure which pings the server to verify that it is there.
            // On scucessful initialization we'll then proceed with starting the transport.
            that.init(connection, function () {
                connection.messageId = null;

                privateData.pollTimeoutId = window.setTimeout(function () {
                    (function poll(instance, raiseReconnect) {
                        var messageId = instance.messageId,
                            connect = (messageId === null),
                            reconnecting = !connect,
                            polling = !raiseReconnect,
                            url = transportLogic.getUrl(instance, that.name, reconnecting, polling);

                        // If we've disconnected during the time we've tried to re-instantiate the poll then stop.
                        if (isDisconnecting(instance) === true) {
                            return;
                        }

                        connection.log("Opening long polling request to '" + url + "'.");
                        instance.pollXhr = $.ajax(
                            $.extend({}, $.signalR.ajaxDefaults, {
                                xhrFields: { withCredentials: connection.withCredentials },
                                url: url,
                                type: "GET",
                                dataType: connection.ajaxDataType,
                                contentType: connection.contentType,
                                success: function (result) {
                                    var delay = 0,
                                        minData,
                                        data,
                                        shouldReconnect;

                                    connection.log("Long poll complete.");

                                    // Reset our reconnect errors so if we transition into a reconnecting state again we trigger
                                    // reconnected quickly
                                    reconnectErrors = 0;

                                    try {
                                        minData = connection._parseResponse(result);
                                    }
                                    catch (error) {
                                        transportLogic.handleParseFailure(instance, result, error.message, tryFailConnect);
                                        return;
                                    }

                                    // If there's currently a timeout to trigger reconnect, fire it now before processing messages
                                    if (privateData.reconnectTimeoutId !== null) {
                                        fireReconnected();
                                    }

                                    fireConnect();

                                    if (minData) {
                                        data = transportLogic.maximizePersistentResponse(minData);
                                    }

                                    transportLogic.processMessages(instance, minData);

                                    if (data &&
                                        $.type(data.LongPollDelay) === "number") {
                                        delay = data.LongPollDelay;
                                    }

                                    if (data && data.Disconnect) {
                                        return;
                                    }

                                    if (isDisconnecting(instance) === true) {
                                        return;
                                    }

                                    shouldReconnect = data && data.ShouldReconnect;
                                    if (shouldReconnect) {
                                        // Transition into the reconnecting state
                                        transportLogic.ensureReconnectingState(instance);
                                    }

                                    // We never want to pass a raiseReconnect flag after a successful poll.  This is handled via the error function
                                    if (delay > 0) {
                                        privateData.pollTimeoutId = window.setTimeout(function () {
                                            poll(instance, shouldReconnect);
                                        }, delay);
                                    } else {
                                        poll(instance, shouldReconnect);
                                    }
                                },

                                error: function (data, textStatus) {
                                    // Stop trying to trigger reconnect, connection is in an error state
                                    // If we're not in the reconnect state this will noop
                                    window.clearTimeout(privateData.reconnectTimeoutId);
                                    privateData.reconnectTimeoutId = null;

                                    if (textStatus === "abort") {
                                        connection.log("Aborted xhr requst.");
                                        return;
                                    }

                                    if (!tryFailConnect()) {
                                        // Increment our reconnect errors, we assume all errors to be reconnect errors
                                        // In the case that it's our first error this will cause Reconnect to be fired
                                        // after 1 second due to reconnectErrors being = 1.
                                        reconnectErrors++;

                                        if (connection.state !== signalR.connectionState.reconnecting) {
                                            connection.log("An error occurred using longPolling. Status = " + textStatus + ".  Response = " + data.responseText + ".");
                                            $(instance).triggerHandler(events.onError, [data.responseText]);
                                        }

                                        // We check the state here to verify that we're not in an invalid state prior to verifying Reconnect.
                                        // If we're not in connected or reconnecting then the next ensureReconnectingState check will fail and will return.
                                        // Therefore we don't want to change that failure code path.
                                        if ((connection.state === signalR.connectionState.connected ||
                                            connection.state === signalR.connectionState.reconnecting) &&
                                            !transportLogic.verifyLastActive(connection)) {
                                            return;
                                        }

                                        // Transition into the reconnecting state
                                        // If this fails then that means that the user transitioned the connection into the disconnected or connecting state within the above error handler trigger.
                                        if (!transportLogic.ensureReconnectingState(instance)) {
                                            return;
                                        }

                                        privateData.pollTimeoutId = window.setTimeout(function () {
                                            // If we've errored out we need to verify that the server is still there, so re-start initialization process
                                            // This will ping the server until it successfully gets a response.
                                            that.init(instance, function () {
                                                // Call poll with the raiseReconnect flag as true
                                                poll(instance, true);
                                            });
                                        }, that.reconnectDelay);
                                    }
                                }
                            }));


                        // This will only ever pass after an error has occured via the poll ajax procedure.
                        if (reconnecting && raiseReconnect === true) {
                            // We wait to reconnect depending on how many times we've failed to reconnect.
                            // This is essentially a heuristic that will exponentially increase in wait time before
                            // triggering reconnected.  This depends on the "error" handler of Poll to cancel this 
                            // timeout if it triggers before the Reconnected event fires.
                            // The Math.min at the end is to ensure that the reconnect timeout does not overflow.
                            privateData.reconnectTimeoutId = window.setTimeout(function () { fireReconnected(instance); }, Math.min(1000 * (Math.pow(2, reconnectErrors) - 1), maxFireReconnectedTimeout));
                        }
                    }(connection));

                    // Set an arbitrary timeout to trigger onSuccess, this will alot for enough time on the server to wire up the connection.
                    // Will be fixed by #1189 and this code can be modified to not be a timeout
                    window.setTimeout(function () {
                        // Trigger the onSuccess() method because we've now instantiated a connection
                        fireConnect();
                    }, 250);
                }, 250); // Have to delay initial poll so Chrome doesn't show loader spinner in tab
            });
        },

        lostConnection: function (connection) {
            throw new Error("Lost Connection not handled for LongPolling");
        },

        send: function (connection, data) {
            transportLogic.ajaxSend(connection, data);
        },

        stop: function (connection) {
            /// <summary>Stops the long polling connection</summary>
            /// <param name="connection" type="signalR">The SignalR connection to stop</param>
            window.clearTimeout(connection._.pollTimeoutId);
            window.clearTimeout(connection._.reconnectTimeoutId);

            delete connection._.pollTimeoutId;
            delete connection._.reconnectTimeoutId;

            if (connection.pollXhr) {
                connection.pollXhr.abort();
                connection.pollXhr = null;
                delete connection.pollXhr;
            }
        },

        abort: function (connection, async) {
            transportLogic.ajaxAbort(connection, async);
        }
    };

}(window.jQuery, window));
/* jquery.signalR.hubs.js */
// Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.md in the project root for license information.

/*global window:false */
/// <reference path="jquery.signalR.core.js" />

(function ($, window, undefined) {
    "use strict";

    // we use a global id for tracking callbacks so the server doesn't have to send extra info like hub name
    var eventNamespace = ".hubProxy";

    function makeEventName(event) {
        return event + eventNamespace;
    }

    // Equivalent to Array.prototype.map
    function map(arr, fun, thisp) {
        var i,
            length = arr.length,
            result = [];
        for (i = 0; i < length; i += 1) {
            if (arr.hasOwnProperty(i)) {
                result[i] = fun.call(thisp, arr[i], i, arr);
            }
        }
        return result;
    }

    function getArgValue(a) {
        return $.isFunction(a) ? null : ($.type(a) === "undefined" ? null : a);
    }

    function hasMembers(obj) {
        for (var key in obj) {
            // If we have any properties in our callback map then we have callbacks and can exit the loop via return
            if (obj.hasOwnProperty(key)) {
                return true;
            }
        }

        return false;
    }

    function clearInvocationCallbacks(connection, error) {
        /// <param name="connection" type="hubConnection" />
        var callbacks = connection._.invocationCallbacks,
            callback;

        if (hasMembers(callbacks)) {
            connection.log("Clearing hub invocation callbacks with error: " + error + ".");
        }

        // Reset the callback cache now as we have a local var referencing it
        connection._.invocationCallbackId = 0;
        delete connection._.invocationCallbacks;
        connection._.invocationCallbacks = {};

        // Loop over the callbacks and invoke them.
        // We do this using a local var reference and *after* we've cleared the cache
        // so that if a fail callback itself tries to invoke another method we don't 
        // end up with its callback in the list we're looping over.
        for (var callbackId in callbacks) {
            callback = callbacks[callbackId];
            callback.method.call(callback.scope, { E: error });
        }
    }

    // hubProxy
    function hubProxy(hubConnection, hubName) {
        /// <summary>
        ///     Creates a new proxy object for the given hub connection that can be used to invoke
        ///     methods on server hubs and handle client method invocation requests from the server.
        /// </summary>
        return new hubProxy.fn.init(hubConnection, hubName);
    }

    hubProxy.fn = hubProxy.prototype = {
        init: function (connection, hubName) {
            this.state = {};
            this.connection = connection;
            this.hubName = hubName;
            this._ = {
                callbackMap: {}
            };
        },

        hasSubscriptions: function () {
            return hasMembers(this._.callbackMap);
        },

        on: function (eventName, callback) {
            /// <summary>Wires up a callback to be invoked when a invocation request is received from the server hub.</summary>
            /// <param name="eventName" type="String">The name of the hub event to register the callback for.</param>
            /// <param name="callback" type="Function">The callback to be invoked.</param>
            var self = this,
                callbackMap = self._.callbackMap;

            // Normalize the event name to lowercase
            eventName = eventName.toLowerCase();

            // If there is not an event registered for this callback yet we want to create its event space in the callback map.
            if (!callbackMap[eventName]) {
                callbackMap[eventName] = {};
            }

            // Map the callback to our encompassed function
            callbackMap[eventName][callback] = function (e, data) {
                callback.apply(self, data);
            };

            $(self).bind(makeEventName(eventName), callbackMap[eventName][callback]);

            return self;
        },

        off: function (eventName, callback) {
            /// <summary>Removes the callback invocation request from the server hub for the given event name.</summary>
            /// <param name="eventName" type="String">The name of the hub event to unregister the callback for.</param>
            /// <param name="callback" type="Function">The callback to be invoked.</param>
            var self = this,
                callbackMap = self._.callbackMap,
                callbackSpace;

            // Normalize the event name to lowercase
            eventName = eventName.toLowerCase();

            callbackSpace = callbackMap[eventName];

            // Verify that there is an event space to unbind
            if (callbackSpace) {
                // Only unbind if there's an event bound with eventName and a callback with the specified callback
                if (callbackSpace[callback]) {
                    $(self).unbind(makeEventName(eventName), callbackSpace[callback]);

                    // Remove the callback from the callback map
                    delete callbackSpace[callback];

                    // Check if there are any members left on the event, if not we need to destroy it.
                    if (!hasMembers(callbackSpace)) {
                        delete callbackMap[eventName];
                    }
                }
                else if (!callback) { // Check if we're removing the whole event and we didn't error because of an invalid callback
                    $(self).unbind(makeEventName(eventName));

                    delete callbackMap[eventName];
                }
            }

            return self;
        },

        invoke: function (methodName) {
            /// <summary>Invokes a server hub method with the given arguments.</summary>
            /// <param name="methodName" type="String">The name of the server hub method.</param>

            var self = this,
                connection = self.connection,
                args = $.makeArray(arguments).slice(1),
                argValues = map(args, getArgValue),
                data = { H: self.hubName, M: methodName, A: argValues, I: connection._.invocationCallbackId },
                d = $.Deferred(),
                callback = function (minResult) {
                    var result = self._maximizeHubResponse(minResult);

                    // Update the hub state
                    $.extend(self.state, result.State);

                    if (result.Error) {
                        // Server hub method threw an exception, log it & reject the deferred
                        if (result.StackTrace) {
                            connection.log(result.Error + "\n" + result.StackTrace + ".");
                        }
                        d.rejectWith(self, [result.Error]);
                    } else {
                        // Server invocation succeeded, resolve the deferred
                        d.resolveWith(self, [result.Result]);
                    }
                };

            connection._.invocationCallbacks[connection._.invocationCallbackId.toString()] = { scope: self, method: callback };
            connection._.invocationCallbackId += 1;

            if (!$.isEmptyObject(self.state)) {
                data.S = self.state;
            }

            connection.send(self.connection.json.stringify(data));

            return d.promise();
        },

        _maximizeHubResponse: function (minHubResponse) {
            return {
                State: minHubResponse.S,
                Result: minHubResponse.R,
                Id: minHubResponse.I,
                Error: minHubResponse.E,
                StackTrace: minHubResponse.T
            };
        }
    };

    hubProxy.fn.init.prototype = hubProxy.fn;

    // hubConnection
    function hubConnection(url, options) {
        /// <summary>Creates a new hub connection.</summary>
        /// <param name="url" type="String">[Optional] The hub route url, defaults to "/signalr".</param>
        /// <param name="options" type="Object">[Optional] Settings to use when creating the hubConnection.</param>
        var settings = {
            qs: null,
            logging: false,
            useDefaultPath: true
        };

        $.extend(settings, options);

        if (!url || settings.useDefaultPath) {
            url = (url || "") + "/signalr";
        }
        return new hubConnection.fn.init(url, settings);
    }

    hubConnection.fn = hubConnection.prototype = $.connection();

    hubConnection.fn.init = function (url, options) {
        var settings = {
            qs: null,
            logging: false,
            useDefaultPath: true
        },
            connection = this;

        $.extend(settings, options);

        // Call the base constructor
        $.signalR.fn.init.call(connection, url, settings.qs, settings.logging);

        // Object to store hub proxies for this connection
        connection.proxies = {};

        connection._.invocationCallbackId = 0;
        connection._.invocationCallbacks = {};

        // Wire up the received handler
        connection.received(function (minData) {
            var data, proxy, dataCallbackId, callback, hubName, eventName;
            if (!minData) {
                return;
            }

            if (typeof (minData.I) !== "undefined") {
                // We received the return value from a server method invocation, look up callback by id and call it
                dataCallbackId = minData.I.toString();
                callback = connection._.invocationCallbacks[dataCallbackId];
                if (callback) {
                    // Delete the callback from the proxy
                    connection._.invocationCallbacks[dataCallbackId] = null;
                    delete connection._.invocationCallbacks[dataCallbackId];

                    // Invoke the callback
                    callback.method.call(callback.scope, minData);
                }
            } else {
                data = this._maximizeClientHubInvocation(minData);

                // We received a client invocation request, i.e. broadcast from server hub
                connection.log("Triggering client hub event '" + data.Method + "' on hub '" + data.Hub + "'.");

                // Normalize the names to lowercase
                hubName = data.Hub.toLowerCase();
                eventName = data.Method.toLowerCase();

                // Trigger the local invocation event
                proxy = this.proxies[hubName];

                // Update the hub state
                $.extend(proxy.state, data.State);
                $(proxy).triggerHandler(makeEventName(eventName), [data.Args]);
            }
        });

        connection.error(function (errData, origData) {
            var callbackId, callback;

            if (connection.transport && connection.transport.name === "webSockets") {
                // WebSockets connections have all callbacks removed on reconnect instead
                // as WebSockets sends are fire & forget
                return;
            }

            if (!origData) {
                // No original data passed so this is not a send error
                return;
            }

            try {
                origData = connection.json.parse(origData);
            } catch (e) {
                // The original data is not a JSON payload so this is not a send error
                return;
            }

            callbackId = origData.I;
            callback = connection._.invocationCallbacks[callbackId];

            // Verify that there is a callback bound (could have been cleared)
            if (callback) {
                // Delete the callback
                connection._.invocationCallbacks[callbackId] = null;
                delete connection._.invocationCallbacks[callbackId];

                // Invoke the callback with an error to reject the promise
                callback.method.call(callback.scope, { E: errData });
            }
        });

        connection.reconnecting(function () {
            if (connection.transport && connection.transport.name === "webSockets") {
                clearInvocationCallbacks(connection, "Connection started reconnecting before invocation result was received.");
            }
        });

        connection.disconnected(function () {
            clearInvocationCallbacks(connection, "Connection was disconnected before invocation result was received.");
        });
    };

    hubConnection.fn._maximizeClientHubInvocation = function (minClientHubInvocation) {
        return {
            Hub: minClientHubInvocation.H,
            Method: minClientHubInvocation.M,
            Args: minClientHubInvocation.A,
            State: minClientHubInvocation.S
        };
    };

    hubConnection.fn._registerSubscribedHubs = function () {
        /// <summary>
        ///     Sets the starting event to loop through the known hubs and register any new hubs 
        ///     that have been added to the proxy.
        /// </summary>
        var connection = this;

        if (!connection._subscribedToHubs) {
            connection._subscribedToHubs = true;
            connection.starting(function () {
                // Set the connection's data object with all the hub proxies with active subscriptions.
                // These proxies will receive notifications from the server.
                var subscribedHubs = [];

                $.each(connection.proxies, function (key) {
                    if (this.hasSubscriptions()) {
                        subscribedHubs.push({ name: key });
                        connection.log("Client subscribed to hub '" + key + "'.");
                    }
                });

                if (subscribedHubs.length === 0) {
                    connection.log("No hubs have been subscribed to.  The client will not receive data from hubs.  To fix, declare at least one client side function prior to connection start for each hub you wish to subscribe to.");
                }

                connection.data = connection.json.stringify(subscribedHubs);
            });
        }
    };

    hubConnection.fn.createHubProxy = function (hubName) {
        /// <summary>
        ///     Creates a new proxy object for the given hub connection that can be used to invoke
        ///     methods on server hubs and handle client method invocation requests from the server.
        /// </summary>
        /// <param name="hubName" type="String">
        ///     The name of the hub on the server to create the proxy for.
        /// </param>

        // Normalize the name to lowercase
        hubName = hubName.toLowerCase();

        var proxy = this.proxies[hubName];
        if (!proxy) {
            proxy = hubProxy(this, hubName);
            this.proxies[hubName] = proxy;
        }

        this._registerSubscribedHubs();

        return proxy;
    };

    hubConnection.fn.init.prototype = hubConnection.fn;

    $.hubConnection = hubConnection;

}(window.jQuery, window));
/* jquery.signalR.version.js */
// Copyright (c) Microsoft Open Technologies, Inc. All rights reserved. See License.md in the project root for license information.

/*global window:false */
/// <reference path="jquery.signalR.core.js" />
(function ($, undefined) {
    $.signalR.version = "1.2.2";
}(window.jQuery));
