if (!('bars' in window)) window['bars'] = {};
bars.http = bars.http || {};

bars.http.ajax = function (options) {
    options = $.extend(
        {
            url: document.location.href ,
            type: 'GET',
            //contentType: 'application/json',
            data: {},
            success: function() { },
            dataType: 'text',
            async: true
        }, options);
    return $.ajax(options);
}
bars.http.head = function (options) {
    if (typeof (options) !== 'object') {
        options = { url: options };
        if (arguments[1]) { options.data = arguments[1]; }
        if (arguments[2]) { options.success = arguments[2]; }
        if (arguments[3]) { options.dataType = arguments[3]; }
    }
    options.type = 'HEAD';
    return bars.http.ajax(options); 
}
bars.http.options = function (options) {
    if (typeof (options) !== 'object') {
        options = { url: options };
        if (arguments[1]) { options.data = arguments[1]; }
        if (arguments[2]) { options.success = arguments[2]; }
        if (arguments[3]) { options.dataType = arguments[3]; }
    }
    options.type = 'OPTIONS';
    return bars.http.ajax(options); 
}
bars.http.get = function (options) {
    if (typeof (options) !== 'object') {
        options = { url: options };
        if (arguments[1]) { options.data = arguments[1]; }
        if (arguments[2]) { options.success = arguments[2]; }
        if (arguments[3]) { options.dataType = arguments[3]; }
    }
    options.type = 'GET';
    return bars.http.ajax(options); 
}
bars.http.post = function(options) {
    if (typeof (options) !== 'object') {
        options = { url: options };
        if (arguments[1]) { options.data = arguments[1]; }
        if (arguments[2]) { options.success = arguments[2]; }
        if (arguments[3]) { options.dataType = arguments[3]; }
    }
    options.type = 'POST';
    return bars.http.ajax(options);
}
bars.http.put = function(options) {
    if (typeof (options) !== 'object') {
        options = { url: options };
        if (arguments[1]) { options.data = arguments[1]; }
        if (arguments[2]) { options.success = arguments[2]; }
        if (arguments[3]) { options.dataType = arguments[3]; }
    }
    options.type = 'PUT';
    return bars.http.ajax(options);
}
bars.http.patch = function(options) {
    if (typeof (options) !== 'object') {
        options = { url: options };
        if (arguments[1]) { options.data = arguments[1]; }
        if (arguments[2]) { options.success = arguments[2]; }
        if (arguments[3]) { options.dataType = arguments[3]; }
    }
    options.type = 'PATCH';
    return bars.http.ajax(options);
}
bars.http['delete'] = function(options) {
    if (typeof (options) !== 'object') {
        options = { url: options };
        if (arguments[1]) { options.data = arguments[1]; }
        if (arguments[2]) { options.success = arguments[2]; }
        if (arguments[3]) { options.dataType = arguments[3]; }
    }
    options.type = 'DELETE';
    return bars.http.ajax(options);
}
bars.http.trace = function(options) {
    if (typeof (options) !== 'object') {
        options = { url: options };
        if (arguments[1]) { options.data = arguments[1]; }
        if (arguments[2]) { options.success = arguments[2]; }
        if (arguments[3]) { options.dataType = arguments[3]; }
    }
    options.type = 'TRACE';
    return bars.http.ajax(options);
}
bars.http.connect = function(options) {
    if (typeof (options) !== 'object') {
        options = { url: options };
        if (arguments[1]) { options.data = arguments[1]; }
        if (arguments[2]) { options.success = arguments[2]; }
        if (arguments[3]) { options.dataType = arguments[3]; }
    }
    options.type = 'CONNECT';
    return bars.http.ajax(options);
}