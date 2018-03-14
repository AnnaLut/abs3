
var SYGNER_URL_HTTPS = 'https://local.barscryptor.net:31139/';
var SYGNER_URL_HTTP = 'http://localhost:31140/';

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
//var SYGNER_URL = SYGNER_URL_HTTP;

var g_signer = new Signer(SYGNER_URL);