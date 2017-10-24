function moneyFormat(money) {
    return (money === null) ? '' : kendo.toString(money, '###,##0.00').replace(new RegExp(",", 'g'), ' ');
}

function disabledButtons(condition, id) {
    if (condition) {
        $(id).removeAttr("disabled");
    } else {
        $(id).attr("disabled", "disabled");
    }
}

function CatchErrors(data) {
    if (data.Status != "ok") {
        bars.ui.error({
            title: "Помилка ",
            text: data.Status,
            width: '800px',
            height: '600px'
        });
        return false;
    }
    return true;
}

function CheckColor(value) {
    return "<b style='color:" + ((value < 0) ? 'red' : 'blue') + "'>" + moneyFormat(value) + "</b>";
}

function GetStaticData(url) {
    $.ajax({
        type: "POST",
        async: true,
        dataType: "json",
        url: bars.config.urlContent(url),
        data: { nd: globalID },
        success: function (data) {
            SetStatic(data);
        }
    });
}