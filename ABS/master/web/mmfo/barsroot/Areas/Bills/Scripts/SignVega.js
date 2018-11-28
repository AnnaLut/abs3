/*!
 * jQuery-ajaxTransport-XDomainRequest - v1.0.1 - 2013-10-17
 * https://github.com/MoonScript/jQuery-ajaxTransport-XDomainRequest
 * Copyright (c) 2013 Jason Moon (@JSONMOON)
 * Licensed MIT (/blob/master/LICENSE.txt)
 */
(function ($) { if (!$.support.cors && $.ajaxTransport && window.XDomainRequest) { var n = /^https?:\/\//i; var o = /^get|post$/i; var p = new RegExp('^' + location.protocol, 'i'); var q = /text\/html/i; var r = /\/json/i; var s = /\/xml/i; $.ajaxTransport('* text html xml json', function (i, j, k) { if (i.crossDomain && i.async && o.test(i.type) && n.test(i.url) && p.test(i.url)) { var l = null; var m = (j.dataType || '').toLowerCase(); return { send: function (f, g) { l = new XDomainRequest(); if (/^\d+$/.test(j.timeout)) { l.timeout = j.timeout } l.ontimeout = function () { g(500, 'timeout') }; l.onload = function () { var a = 'Content-Length: ' + l.responseText.length + '\r\nContent-Type: ' + l.contentType; var b = { code: 200, message: 'success' }; var c = { text: l.responseText }; try { if (m === 'html' || q.test(l.contentType)) { c.html = l.responseText } else if (m === 'json' || (m !== 'text' && r.test(l.contentType))) { try { c.json = $.parseJSON(l.responseText) } catch (e) { b.code = 500; b.message = 'parseerror' } } else if (m === 'xml' || (m !== 'text' && s.test(l.contentType))) { var d = new ActiveXObject('Microsoft.XMLDOM'); d.async = false; try { d.loadXML(l.responseText) } catch (e) { d = undefined } if (!d || !d.documentElement || d.getElementsByTagName('parsererror').length) { b.code = 500; b.message = 'parseerror'; throw 'Invalid XML: ' + l.responseText; } c.xml = d } } catch (parseMessage) { throw parseMessage; } finally { g(b.code, b.message, c, a) } }; l.onprogress = function () { }; l.onerror = function () { g(500, 'error', { text: l.responseText }) }; var h = ''; if (j.data) { h = ($.type(j.data) === 'string') ? j.data : $.param(j.data) } l.open(i.type, i.url); l.send(h) }, abort: function () { if (l) { l.abort() } } } } }) } })(jQuery);

(function () {
    var SYGNER_URL_HTTPS = 'https://local.barscryptor.net:31139/';
    var SYGNER_URL_HTTP = 'http://local.barscryptor.net:31140/';
    var signer = {};
    signer.Keys = [];
    signer.Tokens = [];

    signer.getQuery = function getQuery(index) {
        if (signer.Tokens.length > 0 && signer.Tokens[0] !== undefined && signer.Tokens[0] !== null) {
            var moduleName = signer.Tokens[index].ModuleName != null && signer.Tokens[index].ModuleName != undefined ? signer.Tokens[index].ModuleName : signer.Tokens[index].TokenId;
            return JSON.stringify({ "TokenId": signer.Tokens[index].TokenId, "ModuleName": moduleName });
        }
        return '';
    }

    signer.getSignData = function (tokenIndex, keyIndex, data, buffer) {
        if (signer.Tokens.length > 0 && signer.Tokens[0] !== undefined && signer.Tokens[0] !== null) {
            return JSON.stringify({ TokenId: signer.Tokens[tokenIndex].TokenId, IdOper: signer.Keys[keyIndex].Id, Encoding: "UTF8", Buffer: buffer });
        }
        return '';
    }

    function Signer(url_) {
        var start_url = url_;

        this.GetKeys = function (obj, cbSuccess, cbError) {
            makeQuery(obj, 'keys', cbSuccess, cbError);
        };

        this.GetTokens = function (cbSuccess, cbError) {
            makeQuery('', 'tokens', cbSuccess, cbError);
        };

        this.Init = function (obj, cbSuccess, cbError) {
            makeQuery(obj, 'init', cbSuccess, cbError);
        };

        this.Sign = function (obj, cbSuccess, cbError) {
            makeQuery(obj, 'sign', cbSuccess, cbError);
        };

        this.Validate = function (obj, cbSuccess, cbError) {
            makeQuery(obj, 'validate', cbSuccess, cbError);
        };

        this.GetVersion = function (cbSuccess, cbError) {
            makeGetQuery('version', cbSuccess, cbError);
        };

        function makeQuery(json, url, cbSuccess, cbError) {
            var isIE = (navigator.userAgent.indexOf("MSIE") != -1);
            if (isIE) {
                $.support.cors = true;
                $.ajax({
                    type: 'POST',
                    headers: {
                        'Access-Control-Allow-Origin': '*'
                    },
                    url: start_url + url,
                    crossDomain: true,
                    data: json,
                    dataType: 'json',
                    success: cbSuccess,
                    error: cbError
                });
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: start_url + url,
                    crossDomain: true,
                    data: json,
                    dataType: 'json',
                    success: cbSuccess,
                    error: cbError
                });
            }
        }

        function makeQuerySign(json, url, cbSuccess, cbError) {
            var isIE = (navigator.userAgent.indexOf("MSIE") != -1);
            if (isIE) {
                $.support.cors = true;
                $.ajax({
                    headers: {
                        'Access-Control-Allow-Origin': '*'
                    },
                    type: 'POST',
                    url: start_url + '1' + url,
                    crossDomain: true,
                    data: json,
                    dataType: 'json',
                    success: cbSuccess,
                    error: cbError
                });
            }
            else {
                $.ajax({
                    type: 'POST',
                    url: start_url + '1' + url,
                    crossDomain: true,
                    data: json,
                    dataType: 'json',
                    success: cbSuccess,
                    error: cbError
                });
            }
        }

        function makeGetQuery(url, cbSuccess, cbError) {
            var isIE = (navigator.userAgent.indexOf("MSIE") != -1);
            if (isIE) {
                $.support.cors = true;
                $.ajax({
                    headers: {
                        'Access-Control-Allow-Origin': '*'
                    },
                    type: 'GET',
                    url: start_url + url,
                    crossDomain: true,
                    success: cbSuccess,
                    error: cbError
                });
            }
            else {
                $.ajax({
                    type: 'GET',
                    url: start_url + url,
                    crossDomain: true,
                    success: cbSuccess,
                    error: cbError
                });
            }
        }
    }

    var SYGNER_URL = location.protocol !== 'https:' ? SYGNER_URL_HTTP : SYGNER_URL_HTTPS;

    signer.signer = new Signer(SYGNER_URL);
    function initSuccess(data) {
        if (data.State === 'OK' && data.KeyStorage === 1) {
            signer.signer.GetKeys(signer.getQuery(0), function (data) {
                if (data.State === 'OK' && data.Keys.length > 0)
                    signer.Keys = data.Keys;
                else if (data.State !== 'OK')
                    bars.ui.error({ title: ' Помилка', text: data.Error });
            }, function (err) {
                bars.ui.error({ text: err, title: ' Помилка' });
            });
        }
    }

    signer.InitTokens = function (func, initTokens) {
        signer.signer.GetTokens(function (data) {
            if (data.State === 'OK' && data.Tokens.length > 0) {
                var arr = [];
                arr.push(data.Tokens[3]);
                signer.Tokens = arr;//data.Tokens;
                initTokens();
                signer.signer.Init(signer.getQuery(0), function (data) {
                    if (data.State === 'OK') { // && data.KeyStorage === 1
                        signer.signer.GetKeys(signer.getQuery(0), function (data) {
                            if (data.State === 'OK' && data.Keys.length > 0)
                                signer.Keys = data.Keys;
                            else
                                signer.Keys = [];
                            if (func)
                                func();
                        }, function (err) {
                            bars.ui.error({ text: 'Помилка при отриманні списку ключів', title: ' Помилка!!!' });
                        });
                    }
                    else if (data.State === "Error")
                        bars.ui.error({ text: data.Error, title: ' Помилка!!!' });
                }, function (err) {
                    bars.ui.error({ text: 'Помилка при ініціалізації BarsCryptor', title: 'Увага' });
                });
            }
        }, function (err) {
            bars.ui.error({ text: err.statusText, title: ' Увага!!!' }); //'Увімкніть BarsCryptor, або завантажте актуальну версію'
        });
    }

    window.$sign = signer;
})();

var Hex = {
    encodeToHex: function (str) {
        var r = "";
        var e = str.length;
        var c = 0;
        var h;
        while (c < e) {
            h = str.charCodeAt(c++).toString(16);
            while (h.length < 2) h = "0" + h;
            r += h;
        }
        return r;
    },
    decodeFromHex: function (str) {
        var r = "";
        var e = str.length;
        var s;
        while (e >= 0) {
            s = e - 3;
            r = String.fromCharCode("0x" + str.substring(s, e)) + r;
            e = s;
        }
        return r;
    }
};