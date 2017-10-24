/**
 * Created by serhii.karchavets on 30.08.2016.
 */
var TOKEN_ID = "iit";
var MODULE_NAME = "iit";
var SYGNER_URL = 'https://local.barscryptor.net:31139/';


function Signer(url_) {
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
        //console.log("data="+json +" url="+start_url+url);
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

var g_signer = new Signer(SYGNER_URL);
function AbleBtns() {
    $('#approveMatching').removeAttr("disabled");
    $('#approveMatchingConvert').removeAttr("disabled");
    $('#SendBtn').removeAttr("disabled", "disabled");
    $('#SendBtnHistory').removeAttr("disabled", "disabled");
}
function initSign(ids, KvitType, gridForRefresh) {
    debugger;
        //$('#approveMatching').prop("disabled", true);
    g_signer.Init({ TokenId: TOKEN_ID, ModuleName: MODULE_NAME },
        function (response) {
            if (response.State == "OK") {
                AbleBtns();
                g_signer.GetKeys({ TokenId: TOKEN_ID, ModuleName: MODULE_NAME },
                    function (keyResponse) {
                        if (keyResponse.State == "OK" && keyResponse.Keys.length > 0) {
                            AbleBtns();
                            var signId = keyResponse.Keys[0].Id;
                            for (var i = 0; i < ids.length; i++) {   //  keyResponse.Keys -> Array : {Id: "", Name: ""}
                                prepareSign(signId, ids[i], KvitType, gridForRefresh);
                                AbleBtns();
                            }

                        } else {
                            bars.ui.error({ title: 'ЕЦП!', text: "Не знайдено особистих ключів на носії!" });
                        }
                    },
                    function () {
                        AbleBtns();
                        bars.ui.error({ title: 'ЕЦП!', text: "Помилка зв'язку з ЕЦП клієнтом!" });
                    
                    });
            }
            else {
                AbleBtns();
                bars.ui.error({
                    title: 'ЕЦП!', text: 'Помилка ініціалізації програмного забезпечення для накладення ЕЦП.' +
                    ' Зверніться до адміністратора. ' + response.Error
                });
            }
        }, function () {
            AbleBtns();
            bars.ui.error({ title: 'ЕЦП!', text: "Помилка зв'язку з ЕЦП клієнтом!" });
        });
        
}

// get HEX buffer from DB for <id>
function prepareSign(signId, id, KvitType, gridForRefresh) {
    //console.log("prepareSign " +"signId="+signId+" id="+id+" KvitType="+KvitType);
    debugger;
    Waiting(true);
    AJAX({
        srcSettings: {
            data: JSON.stringify({ ID: id, Type: 1, KvitType: KvitType }),        // Type = 1 - get hex; Type = 0 - get base64
            url: bars.config.urlContent("/api/pfu/filesgrid/prepareformatchingstatus"),
            complete: function () { Waiting(false); },
            success: function (data) {
                //console.log(data);
                signFire(signId, id, data, KvitType, gridForRefresh);
            }
        }
    });
}

// create Sign in BarsCryptor for <buffer> & <signId>
function signFire(signId, id, buffer, KvitType, gridForRefresh) {
    //var query = {TokenId: TOKEN_ID, IdOper: signId, Encoding: 'UTF8', Buffer: toHex("Hello world!")};
    var query = { TokenId: TOKEN_ID, IdOper: signId, Encoding: 'UTF8', Buffer: toHex(buffer) };
    g_signer.Sign(query, function (response) {
        if (response.State == "OK") {
            finalizze(id, response.Sign, KvitType, gridForRefresh);
        } else {
            bars.ui.error({ title: 'ЕЦП!', text: 'Помилка накладення ЕЦП. Зверніться до адміністратора. ' + response.Error });
        }
    }, function () {
        bars.ui.error({ title: 'ЕЦП!', text: "Помилка зв'язку з ЕЦП клієнтом!" });
    });
}

// change state for emvelope & put sign into DB for <id>
function finalizze(id, sign, KvitType, gridForRefresh) {
    Waiting(true);
    var url = ""
    if (gridForRefresh === "SentConvertsgrid")
        url = "/api/pfu/filesgrid/regenmatching"
    else
        url = "/api/pfu/filesgrid/readyformatching"
    AJAX({
        srcSettings: {
            data: JSON.stringify({ Id: id, Sign: sign, KvitType: KvitType }),
            url: bars.config.urlContent(url),
            complete: function () { Waiting(false); },
            success: function (data) {
                bars.ui.notify("Зміна статусу", "Реєстр №" + id + " успішно помічено до відправки", 'success');
                $(gridForRefresh).data("kendoGrid").dataSource.read();
            }
        }
    });
}