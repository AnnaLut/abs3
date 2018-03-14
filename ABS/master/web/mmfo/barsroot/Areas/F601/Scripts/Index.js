var keyId = "testId";
var tokenId = "seclib";
var moduleName = "seclib";
var itemsNumber = 20;

function SignPacketsClick() {
    bars.ui.loader('fieldset', true);

    var initObject =
        {
            TokenId: tokenId,
            ModuleName: moduleName
        };

    //request for init of seclib02:
    g_signer.Init(initObject,
        function (response) {
            if (response.State == "OK") {

                //request for keyId:
                g_signer.GetKeys(initObject,
                    function (response) {
                        if (response.State == "OK") {
                            keyId = response.Keys[0].Id;

                            //get data by portions and sign it:
                            GetData();
                        }
                        else {
                            ShowError("Помилка при отриманні ключів з бібліотеки підпису: " + + response.Error);
                        }
                    },
                    function (errorObj) {
                        ShowError("Помилка при отриманні ключів з бібліотеки підпису." + errorObj.statusText);
                    });
            }
            else {
                debugger;
                ShowError("Помилка при ініціалізації бібліотеки підпису:" + response.Error);
            }
        },
        function (errorObj) {
            debugger;
            ShowError("Помилка при ініціалізації бібліотеки підпису." + errorObj.statusText);
        });
}

function GetData() {

    $.ajax(
        {
            url: bars.config.urlContent("api/F601/F601Api/GetObjectsForSign"),
            data: { number: itemsNumber, operId: keyId },
            type: 'get',
            contentType: "application/json;charset=utf-8",
            success: function (listResponse) {
                debugger;
                if (listResponse.Data.length > 0) {
                    Sign(listResponse.Data);
                }
                else {
                    bars.ui.loader('fieldset', false);
                    bars.ui.alert({ text: "Підпис наявних пакетів даних для відправки завершено." });
                    RefreshUIData();
                }
            },
            error: function (errorObj) {
                ShowError("Помилка при отриманні даних для підпису." + errorObj.statusText);
            }
        });
}

function Sign(data) {
    var counter = data.length;

    function IsFinished() {
        counter--;
        return counter == 0;
    }

    var signObject = {
        TokenId: tokenId,
        IdOper: keyId,
        Encoding: "UTF8",
        Buffer: ""
    };

    $.each(data, function (index, item) {
        signObject.Buffer = item.ProtectedInBase64Url + '.' + item.PayloadInBase64Url;
        g_signer.Sign(signObject,
            function (signResponse) {

                if (signResponse.State = "OK") {

                    var sign = signResponse.Sign;
                    //for test:
                    //signResponse.Sign = "74657374207369676e20737472696e67";
                    debugger;

                    //write sign, SessionId, payload and protected to BD
                    $.ajax(
                        {
                            url: bars.config.urlContent("api/F601/F601Api/PostSignedObject"),
                            data:
                            JSON.stringify({
                                sessionId: item.SessionId,
                                protectedInbase64Url: item.ProtectedInBase64Url,
                                payloadInbase64Url: item.PayloadInBase64Url,
                                hexSign: signResponse.Sign
                            }),
                            type: 'post',
                            contentType: "application/json",
                            success: function () { },
                            error: function () {
                                ShowError("Помилка при записі підписаних даних в БД.");
                            }
                        });
                }
                else {
                    ShowError("Помилка при проведенні підпису:" + signResponse.error);
                }
                
                if (IsFinished()) {
                    GetData();
                }
            },
            function (errorObj) {
                debugger;
                ShowError("Помилка при проведенні підпису. Опис statusText:" + errorObj.statusText);

                if (IsFinished()) {
                    GetData();
                }
            });
    });
}

function ConvertStringToByteArray(inText) {
    var result = [];
    for (var i = 0; i < inText.length; i++) {
        result.push(inText.charCodeAt(i));
    }
    return result;
}

function ConvertStringToHex(inText) {
    var hex;
    var result = "";
    for (var i = 0; i < inText.length; i++) {
        result += inText.charCodeAt(i).toString(16);
        //result += ("000"+hex).slice(-4);
    }
    return result;
}

function ConvertHexToUTF8String(inHexString) {
    var r = decodeURIComponent(inHexString.replace(/\s+/g, '').replace(/[0-9a-f]{2}/g, '%S&'));
    return r;
}

function ConvertHexToByteArray(inHexString) {
    var bytes = [];
    for (var i = 0; i < inHexString.length; i += 2) {
        bytes.push(parseInt(inHexString.substr(i, 2), 16));
    }
    return bytes;
}

function ConvertByteArrayToBase64String(buffer) {
    var binary = '';
    var bytes = new Uint8Array(buffer);
    for (var i = 0; i < bytes.length; i++) {
        binary += String.fromCharCode(bytes[i]);
    }

    return window.btoa(binary);
}

function ShowError(errText) {
    bars.ui.loader('fieldset', false);
    bars.ui.error({ title: "Помилка", text: errText });
}

function RefreshUIData() {
    $('#CreditInfoObjectsGrid').data('kendoGrid').dataSource.read();
    $('#CreditInfoObjectsGrid').data('kendoGrid').refresh();
}
