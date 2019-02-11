(function() {
    $.support.cors = true;

    _signer = {};
    var TOKEN_ID = "vega2";
    var MODULE_NAME = "vega2";
    //var _SIGNER_URL = 'http://local.barscryptor.net:31140/';
    var _SIGNER_URL = 'http://localhost:31140/';
    //var _SIGNER_URL = 'http://127.0.0.1:31140/';


    var _SIGNER_URLS = 'https://local.barscryptor.net:31139/';

    var SIGNER_URL = location.protocol.toLowerCase() == 'http:' ? _SIGNER_URL : _SIGNER_URLS;

    function Signer(url_) {
        var start_url = url_;

        this.GetKeys = function(obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'keys', cbSuccess, cbError);
        };

        this.GetTokens = function(cbSuccess, cbError) {
            makeQuery('', 'tokens', cbSuccess, cbError);
        };

        this.Init = function(obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'init', cbSuccess, cbError);
        };

        this.Sign = function(obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'sign', cbSuccess, cbError);
        };

        this.SignFile = function(obj, cbSuccess, cbError) {
            makeQuery(JSON.stringify(obj), 'signFile', cbSuccess, cbError);
        };

        this.Validate = function(obj, cbSuccess, cbError) {
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

    _signer.g_signer = new Signer(SIGNER_URL);

    _signer.keys = {};
    _signer.currentKeyToUse = {};

    _signer.initSign = function(cbFunc) {
        _signer.g_signer.Init({ TokenId: TOKEN_ID, ModuleName: MODULE_NAME },
            function(response) {
                if (response.State == "OK") {
                    _signer.g_signer.GetKeys({ TokenId: TOKEN_ID, ModuleName: MODULE_NAME },
                        function(keyResponse) {
                            if (keyResponse.State == "OK" && keyResponse.Keys.length > 0) {
                                _signer.keys = keyResponse.Keys;

                                $.ajax({
                                    type: 'GET',
                                    url: bars.config.urlContent("/api/SignStatFiles/SignFiles/GetCurrentUserSubjectSN"),
                                    success: function(result) {
                                        for (var i = 0; i < _signer.keys.length; i++) {
                                            if (_signer.keys[i].SubjectSN.toLowerCase() == result.toLowerCase()) {
                                                _signer.currentKeyToUse = _signer.keys[i];
                                            }
                                        }

                                        if (_signer.currentKeyToUse.Id) {
                                            if (cbFunc) cbFunc();
                                        } else {
                                            showBarsErrorAlert("Ключ в базі даних не співпадає з ключем на носії, зверніться до адміністратора!");
                                        }
                                    },
                                    error: function() {
                                        showBarsErrorAlert("Відбулась помилка при запиті цлюча ЕЦП з бази даних!");
                                    }
                                });

                            } else {
                                showBarsErrorAlert("Не знайдено особистих ключів на носії!");
                            }
                        },
                        function() {
                            showBarsErrorAlert("Помилка зв'язку з ЕЦП клієнтом!");
                        });
                }
                else {
                    showBarsErrorAlert('Помилка ініціалізації програмного забезпечення для накладення ЕЦП.<br />Зверніться до адміністратора. ' + response.Error);
                }
            }, function(jqXHR, textStatus, errorThrown) {
                showBarsErrorAlert("Помилка зв'язку з ЕЦП клієнтом!");
            });
    };


    _signer.sign = function(_buffer, cb) {
        var query = { TokenId: TOKEN_ID, IdOper: _signer.currentKeyToUse.Id, Encoding: 'UTF8', Buffer: _buffer };
        _signer.g_signer.Sign(query,
            function(res) {
                res.buffer = _buffer;
                if (res.State === "OK") {
                    cb.call(null, res);
                } else {
                    showBarsErrorAlert(res.Error || res.State);
                }
            },
            function(jqXHR, textStatus, errorThrown) {
                showBarsErrorAlert(jqXHR);
            });
    };

    _signer.signFile = function(_buffer, cb) {
        var query = {
            TokenId: TOKEN_ID,
            ModuleName: TOKEN_ID,
            IdOper: _signer.currentKeyToUse.Id,
            Encoding: 'UTF8',
            FileHash: _buffer,
            SignatureType: 1,
            //GetTimeStampSig: 'false',
            GetTimeStampContent: 'false'
        };

        _signer.g_signer.SignFile(query,
            function(res) {
                res.buffer = _buffer;
                if (res.State === "OK") {
                    cb.call(null, res);
                } else {
                    showBarsErrorAlert(res.Error || res.State);
                }
            },
            function(jqXHR, textStatus, errorThrown) {
                showBarsErrorAlert(jqXHR);
            });
    };

    window.$signer = _signer;
})();