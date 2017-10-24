function getParam(param) {
    var pageURL = window.location.search.substring(1);
    var URLVariables = pageURL.split('&');
    for (var i = 0; i < URLVariables.length; i++) {
        var parameterName = URLVariables[i].split('=');
        if (parameterName[0] == param) {
            return parameterName[1];
        }
    }
}

function toHex(val) {
    var str = encodeURIComponent(val);
    var hex = '';
    for (var i = 0; i < str.length; i++) {
        hex += str.charCodeAt(i).toString(16);
    }

    return hex;
}

function NullOrValue(val) {
    val = $.trim(val);
    switch (val) {
        case "":
        case undefined:
        case typeof this === 'undefined':
            return null;
        default:
            return val;
    }
}

function isEmpty(str) {
    return (!str || 0 === str.length);
}

function searchStates(res) {
    if (res.items !== undefined) {
        for (var i = 0; i < res.items.length; i++) {
            var stateVal = "";
            switch (res.items[i].state) {
                case 'NEW':
                    stateVal = 'Новий';
                    break;
                case 'IN_CHECK':
                    stateVal = 'Виконується перевірка';
                    break;
                case 'CHECKED':
                    stateVal = 'Перевірено';
                    break;
                case 'IN_PAY':
                    stateVal = 'В процесі оплати';
                    break;
                case 'PAYED':
                    stateVal = 'Оплачено';
                    break;
                default:
                case 'ERROR':
                    stateVal = 'Помилка';
                    break;
            }

            res.items[i].state = stateVal;
        }
    }
}