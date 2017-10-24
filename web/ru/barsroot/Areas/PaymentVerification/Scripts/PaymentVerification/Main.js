//******************************************
var SMS_SENT = "СМС успішно відправлено. Введіть код підтвердження.";
var PHONE_EMPTY = 'Телефон клієнта не знайдено! Перейдіть до карточки клієнта для заповнення.';
var PHOTO_EMPTY = 'Фото клієнта не знайдено! Перейдіть до карточки клієнта для заповнення.';
var RNK_ERROR = 'РНК клієнта неправильне!';
var SMS_SUCCESS = "Код успішно підтверджено.";
//******************************************
var AUTO_HIDE_AFTER = 8*1000;
var IS_CHECK_PHOTO = true;
//******************************************

// refresh phone number and photo from DB
function Refresh() {
    TryGetPhone($("#rnk").val(), true);
}

// open link to client card
function toKK() {
    var rnk = $("#rnk").val();
    document.location.href = "/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + rnk;
}

//async get photo from DB
function GetPhoto(rnk, successCallback) {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/pvgetphoto"),
        success: successCallback,
        error: function(jqXHR, textStatus, errorThrown){            //bars.ui.alert({ text: "ERROR" });
            Waiting(false);
        },
        data: JSON.stringify({rnk: rnk, image_type: "PHOTO_WEB"})
        //data: JSON.stringify({rnk: rnk, image_type: "PHOTO_JPG"})
    } });
}

//async get phone from DB
function GetPhone(rnk, successCallback) {
    Waiting(true);

    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/pvgetphone"),
        success: successCallback,
        error: function(jqXHR, textStatus, errorThrown){            //bars.ui.alert({ text: "ERROR" });
            Waiting(false);
        },
        data: JSON.stringify({rnk: rnk})
    } });
}

//async send smc or code
function Send(rnk, phone, code, skipcode, successCallback) {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/pvcellphone"),
        success: successCallback,
        error: function(jqXHR, textStatus, errorThrown){            //bars.ui.alert({ text: "ERROR" });
            Waiting(false);
        },
        data: JSON.stringify({rnk: rnk, phone: phone, code: code, skipcode: skipcode})
    } });
}

// event from button
function OnSendSms() {
    SendSms(false);
}

function SendSms(activateSmsElems) {
    if(!CheckPhone()) {return;}

    var rnk = $("#rnk").val();
    var phone = $("#phone").val();

    Send(rnk, phone, "", true, function (data) {
        Waiting(false);
        if(data.Status != "ERROR"){
            bars.ui.notify("До відома", SMS_SENT, 'success', {autoHideAfter: AUTO_HIDE_AFTER});
            if(activateSmsElems){
                SmsElemsDisabled(false);
            }
        }
        else{
            bars.ui.notify("Помилка", data.Message, 'error', {autoHideAfter: AUTO_HIDE_AFTER});
        }
    });
}

function CheckPhone() {
    var rnk = $("#rnk").val();
    var phone = $("#phone").val();
    if(phone == null || phone === ""){
        bars.ui.error({ title: 'Помилка', text: PHONE_EMPTY});
        return false;
    }
    return true;
}

// event from button
function ConfirmSms() {
    if(!CheckPhone()) {return;}

    var code = $("#smsCode").val();
    if(code == null || code === ""){
        bars.ui.error({ title: 'Помилка', text: 'СМС-код відсутній, або неправильний!'});
        return;
    }

    var rnk = $("#rnk").val();
    var phone = $("#phone").val();

    Send(rnk, phone, code, false, function (data) {
        Waiting(false);
        if(data.Status != "ERROR"){
            $("#FireBtnText").hide();
            bars.ui.success({
                text: SMS_SUCCESS,
                close: function () {
                    FireBtn();
                }
            });
        }
        else{
            bars.ui.notify("Помилка", data.Message, 'error', {autoHideAfter: AUTO_HIDE_AFTER});
        }
    });
}

// event from button
function FireBtn() {
    window.returnValue = true;
    window.close();
}

function SmsElemsDisabled(flag) {
    $("#ConfirmSmsBtn").prop("disabled", flag);
    $("#SendSmsBtn").prop("disabled", flag);
    $("#smsCode").prop("disabled", flag);
}

function TryGetPhone(rnk, sendSms) {
    GetPhone(rnk, function (data) {
        Waiting(false);
        $("#title").html("Додаткова верифікація - <b>" + data['NMK'] + "</b>");
        if(data['PHONE'] != null && data['PHONE'] != ""){
            $("#phone").val(data['PHONE']);

            if(IS_CHECK_PHOTO){
                GetPhoto(rnk, function (data) {
                    Waiting(false);
                    if(data['Data']){
                        $("#kkPhoto").attr('src', data['Data']);
                        if(sendSms){
                            SendSms(true);
                        }
                    }
                    else{
                        bars.ui.error({ title: 'Помилка', text: PHOTO_EMPTY});
                    }
                });
            }
            else if(sendSms){
                SendSms(true);
            }
        }
        else{
            bars.ui.error({ title: 'Помилка', text: PHONE_EMPTY});
        }
    });
}

$(document).ready(function () {
    var rnk = bars.extension.getParamFromUrl('rnk');
    if(rnk != null && rnk != ""){
        $("#rnk").val(rnk);
        TryGetPhone(rnk, true);
    }
    else{
        bars.ui.error({ title: 'Помилка', text: RNK_ERROR});
    }
    SmsElemsDisabled(true);

    $('#ConfirmSmsBtn').click(ConfirmSms);
    $('#SendSmsBtn').click(OnSendSms);
    $('#RefreshBtn').click(Refresh);
});