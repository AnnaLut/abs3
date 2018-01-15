/**
 * Created by serhii.karchavets on 26-Dec-17.
 */

angular.module(globalSettings.modulesAreas).factory("signService", function () {
    var _URL_HTTP = 'http://localhost:31140/';
    var _URL_HTTPS = 'https://local.barscryptor.net:31139/';

    function _Signer(url_) {
        var start_url = url_;

        this.GetKeys = function (obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'keys', cbSuccess, cbError);
        };

        this.GetTokens = function (cbSuccess, cbError) {
            makeQuery('', 'tokens', cbSuccess, cbError);
        };

        this.Init = function (obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'init', cbSuccess, cbError);
        };

        this.Sign = function (obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'sign', cbSuccess, cbError);
        };

        this.Validate = function (obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'validate', cbSuccess, cbError);
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
    }

    var _toHex = function(val) {
        var str = encodeURIComponent(val);
        var hex = '';
        for (var i = 0; i < str.length; i++) {
            hex += str.charCodeAt(i).toString(16);
        }    
        return hex;
    }

    var _Init = function (TokenId, ModuleName, succsessCB, errorCb) {
        if(_signer === null)
            _signer = new _Signer(location.protocol !== 'https:' ? _URL_HTTP : _URL_HTTPS);

        _signer.Init({ TokenId: TokenId, ModuleName: ModuleName },
            function (response) {
                if (response.State === "OK") {
                    succsessCB();
                }
                else {
                    errorCb('Помилка ініціалізації програмного забезпечення для накладення ЕЦП.' +
                        ' Зверніться до адміністратора. ' + response.Error);
                }
            }, function () { errorCb("Помилка зв'язку з ЕЦП клієнтом!"); });
    };

    var _GetKeys = function (TokenId, ModuleName, succsessCB, errorCb) {
        _signer.GetKeys({ TokenId: TokenId, ModuleName: ModuleName },
            function (keyResponse) {
                if (keyResponse.State === "OK" && keyResponse.Keys.length > 0) {
                    succsessCB(keyResponse.Keys);
                } else {
                    errorCb("Не знайдено особистих ключів на носії!");
                }
            },
            function () { errorCb("Помилка зв'язку з ЕЦП клієнтом!"); });
    };

    var _Sign = function (TokenId, signId, buffer, succsessCB, errorCb) {
        var query = { TokenId: TokenId, IdOper: signId, Encoding: 'UTF8', Buffer: _toHex(buffer) };
        _signer.Sign(query, function (response) {
            if (response.State === "OK") {
                succsessCB(response.Sign);
            } else {
                errorCb('Помилка накладення ЕЦП. Зверніться до адміністратора. ' + response.Error);
            }
        }, function () { errorCb("Помилка зв'язку з ЕЦП клієнтом!"); });
    };

    var _signer = null;

    return {
        Init: function (TokenId, ModuleName, succsessCB, errorCb) {
            _Init(TokenId, ModuleName, succsessCB, errorCb);
        },
        GetKeys: function (TokenId, ModuleName, succsessCB, errorCb) {
            _GetKeys(TokenId, ModuleName, succsessCB, errorCb);
        },
        Sign: function (TokenId, signId, buffer, succsessCB, errorCb) {
            _Sign(TokenId, signId, buffer, succsessCB, errorCb);
        }
    };
});

