Number.prototype.toMoneyString = function () {
    var c = 2,
        d = ',',
        t = ' ';
    var n = this,
        c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};
function convertToMoneyStr(val) {
    if (isNaN(val)) return (0).toMoneyString();

    return (+val).toMoneyString();
};

function dateCompare(d1, d2) {
    // compares dates by year, month and day
    // 0 - the dates are equal
    // 1 - d1 larger 
    // 2 - d2 is larger
    var _d1 = {
        year: +d1.getFullYear(),
        month: d1.getMonth() + 1,
        day: d1.getDate()
    }
    var _d2 = {
        year: +d2.getFullYear(),
        month: d2.getMonth() + 1,
        day: d2.getDate()
    }
    if (_d1.year > _d2.year) return 1;
    if (_d2.year > _d1.year) return 2;

    if (_d1.month > _d2.month) return 1;
    if (_d2.month > _d1.month) return 2;

    if (_d1.day > _d2.day) return 1;
    if (_d2.day > _d1.day) return 2;

    return 0;
};

function goToSomewhere(_url) {
    var url = encodeURI(_url);
    bars.ui.loader('body', true);
    window.location.href = url;
};

function showBarsErrorAlert(message, func) {
    func = func || function () { };
    bars.ui.error(
        {
            text: message.replace("ы", "і"),
            deactivate: func
        });
};

function getUrlParameter(param) {
    var PageURL = window.location.search.substring(1);
    var URLVariables = PageURL.split('&');
    for (var i = 0; i < URLVariables.length; i++) {
        var ParameterName = URLVariables[i].split('=');
        if (ParameterName[0].toUpperCase() == param.toUpperCase()) {
            return decodeURIComponent(ParameterName[1]);
        }
    }
};

function bindSelectOnFocus() {
    $("input").bind("focus", function () {
        var input = $(this);
        clearTimeout(input.data("selectTimeId"));

        var selectTimeId = setTimeout(function () {
            input.select();
        });

        input.data("selectTimeId", selectTimeId);
    }).blur(function (e) {
        clearTimeout($(this).data("selectTimeId"));
    });
};

function checkValForEdit(val, defValue) {
    var type = typeof val;
    if (val === undefined || val == null || val == "") return defValue;
    if (defValue === "") val = replaceAll(val, '"', '&quot;');
    return $.trim(val);
};

function replaceAll(target, search, replacement) {
    target = target.toString();
    return target.split(search).join(replacement);
};

//'enable' = false - add attr 'disabled'
//'enable' = true - remove attr 'disabled'
function enableElem(selector, enable) {
    if (!enable) {
        $(selector).attr('disabled', 'disabled');
    } else {
        $(selector).removeAttr('disabled');
    }
};

function createCookie(name, value, days) {
    var expires;

    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    } else {
        expires = "";
    }
    document.cookie = encodeURIComponent(name) + "=" + encodeURIComponent(value) + expires + "; path=/";
};

function readCookie(name, defaultVal) {
    var nameEQ = encodeURIComponent(name) + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return decodeURIComponent(c.substring(nameEQ.length, c.length));
    }
    return defaultVal;
};

function eraseCookie(name) {
    createCookie(name, "", -1);
};

function openDoc(ref) {
    if (ref === undefined || ref == null || ref == '') return;

    if (window.showModalDialog)
        window.showModalDialog('/barsroot/documents/item/?id=' + ref, null, 'dialogWidth:720px;dialogHeight:550px');
    else {
        var w = 720;
        var h = 550;

        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2);

        var targetWin = window.open('/barsroot/documents/item/?id=' + ref, '', 'modal=yes, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    }
};

//default options for getAnimationForKWindow function
//options = {
//      animationType: {
//          open: 'down',
//          close: 'up'
//      },
//      openDuration: 300,
//      closeDuration : 300
//}
function getAnimationForKWindow(options) {
    if (+isIE() === 8) return {};

    options = $.extend(true,
        {
            animationType: {
                open: 'down',
                close: 'up'
            },
            openDuration: 300,
            closeDuration: 300
        },
        options
    );

    return {
        open: {
            effects: "slideIn:" + options.animationType.open + " fade:in",
            duration: options.openDuration
        },
        close: {
            effects: "slideIn:" + options.animationType.close + " fade:in",
            reverse: true,
            duration: options.closeDuration
        }
    }
};

// returns 'false' if it is not IE and if it's IE, returns it's version
function isIE() {
    var myNav = navigator.userAgent.toLowerCase();
    return (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;
}

var GUID = function b(a) {
    return a ? (a ^ Math.random() * 16 >> a / 4).toString(16) : ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, b)
};

function lpad(value, length, padVal) {
    return (value.toString().length < length) ? lpad(padVal + value, length, padVal) : value;
}

function rpad(value, length, padVal) {
    return (value.toString().length < length) ? rpad(value + padVal, length, padVal) : value;
}

function toHex(val) {
    var str = encodeURIComponent(val);
    var hex = '';
    for (var i = 0; i < str.length; i++) {
        hex += str.charCodeAt(i).toString(16);
    }

    return hex;
}

function onEscKeyUp(e) {
    if (e.keyCode == 27) {
        var visibleWindow = $(".k-window:visible > .k-window-content:last");
        if (visibleWindow.length)
            visibleWindow.data("kendoWindow").close();
    }
};
$(document).on('keyup', onEscKeyUp);

function clearSelection() {
    try {
        if (window.getSelection) {
            if (window.getSelection().empty) {
                window.getSelection().empty();
            } else if (window.getSelection().removeAllRanges) {
                window.getSelection().removeAllRanges();
            }
        } else if (document.selection) {
            document.selection.empty();
        }
    } catch (e) {

    }
};

function DownloadFileFromBase64(base64, fileName) {
    var form = $('<form method="POST" action="' + bars.config.urlContent("/SalaryBag/SalaryBag/ConvertBase64ToFileUrlDecoded") + '" id="download_form"></form>');
    form.append($('<input type="hidden" name="base64" value="' + base64 + '" />'));
    form.append($('<input type="hidden" name="contentType" value="attachment" />'));
    form.append($('<input type="hidden" name="fileName" value="' + encodeURIComponent(fileName) + '" />'));
    form.appendTo($('body'));
    form.submit();

    setTimeout(function () {
        form.remove();
    }, 500);
}