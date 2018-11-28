var saveResultFunc,
    saveUrl = '';


//
(function () {
    window.parent.$sign.InitTokens(InitElements, InitElements);
})();

//
function InitElements() {
    createOptions('ddSecDeviceType', window.parent.$sign.Tokens);
    createOptions('ddSecFiles', window.parent.$sign.Keys);
}

//
function ClearDDList(id) {
    var ddList = document.getElementById(id);
    if (ddList !== null)
        while (ddList.options.length)
            ddList.remove(0);
}

//
function createOptions(element, arr) {
    ClearDDList(element);
    var select = document.getElementById(element);
    if (arr && arr.length > 0 && arr[0] !== undefined && arr[0] !== null) {
        $('#btReadKey').removeProp('disabled');
        for (var i = 0; i < arr.length; ++i) {
            var option = document.createElement('option');
            if (arr[i]["TokenId"])
                option.value = arr[i].TokenId;
            else
                option.value = arr[i].Id;
            option.innerHTML = arr[i].Name;
            select.appendChild(option);
        }
    }
    else {
        $('#btReadKey').prop('disabled', 'disabled');
        $(element).empty();
    }
}

//
function onRefresh() {
    window.parent.$sign.InitTokens(InitElements, InitElements);
}

//
function onDeviceChange() {
    var tokens = window.parent.$sign.Tokens;
    var index = document.getElementById('ddSecDeviceType').options.selectedIndex;
    window.parent.$sign.signer.GetKeys(window.parent.$sign.getQuery(index), function (data) {
        if (data.State === 'OK' && data.Keys.length > 0)
            window.parent.$sign.Keys = data.Keys;
        else
            window.parent.$sign.Keys = [];
        createOptions('ddSecFiles', window.parent.$sign.Keys);
    }, function (err) {
        bars.ui.error({ text: 'Виникла помилка при запиті до BarsCryptor', title: ' Помилка' });
    });
}
