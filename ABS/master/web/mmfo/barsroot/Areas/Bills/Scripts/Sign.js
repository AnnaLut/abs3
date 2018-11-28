(function () {
    var SYGNER_URL_HTTPS = 'https://local.barscryptor.net:31139/';
    var SYGNER_URL_HTTP = 'http://localhost:31140/';
    var signer = {};
    signer.Keys = [];
    signer.Tokens = [];

    signer.getQuery = function getQuery(index) {
        if (signer.Tokens.length > 0)
            return { TokenId: signer.Tokens[index].TokenId, ModuleName: signer.Tokens[index].TokenId };
        return '';
    }

    signer.getSignData = function (tokenIndex, keyIndex, data, buffer) {
        if (signer.Tokens.length > 0)
            return { TokenId: signer.Tokens[tokenIndex].TokenId, ModuleName: signer.Tokens[tokenIndex].TokenId, data: JSON.stringify(data), IdOper: signer.Keys[keyIndex].Id, Encoding: 'UTF8', Buffer: buffer };
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

        function makeQuerySign(json, url, cbSuccess, cbError) {
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

        function makeGetQuery(url, cbSuccess, cbError) {
            $.ajax({
                type: 'GET',
                url: start_url + url,
                crossDomain: true,
                success: cbSuccess,
                error: cbError
            });
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
                    barsUiError({ title: ' Помилка', text: data.Error });
            }, function (err) {
                barsUiError({ text: err, title: ' Помилка' });
            });
        }
    }

    signer.InitTokens = function (func) {    
        signer.signer.GetTokens(function (data) {
            if (data.State === 'OK' && data.Tokens.length > 0) {
                signer.Tokens = data.Tokens;
                signer.signer.Init(signer.getQuery(0), function (data) {
                    if (data.State === 'OK' && data.KeyStorage === 1) {
                        signer.signer.GetKeys(signer.getQuery(0), function (data) {
                            if (data.State === 'OK' && data.Keys.length > 0)
                                signer.Keys = data.Keys;
                            else
                                signer.Keys = [];
                            if (func)
                                func();
                        }, function (err) {
                            barsUiError({ text: 'Помилка при отриманні списку ключів', title: ' Помилка!!!' });
                        });
                    }
                }, function (err) {
                    barsUiError({ text: 'Помилка при ініціалізації BarsCryptor', title: 'Увага' });
                });
            }
        }, function (err) {
            barsUiError({ text: 'Увімкніть BarsCryptor, або завантажте актуальну версію', title: ' Увага!!!' });
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