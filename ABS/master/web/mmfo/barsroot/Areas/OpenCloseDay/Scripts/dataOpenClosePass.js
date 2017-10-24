$(document).ready(function () {
    $("#confirm").click(function () {
        var dd = new Date().getDate();
        var mm = new Date().getMonth() + 1;
        if (dd < 10) {
            dd = '0' + dd;
        }
        if (mm < 10) {
            mm = '0' + mm;
        }
        var datePass = mm.toString() + dd.toString();

        var passValue = document.getElementById("pass").value;

        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/opencloseday/openclose/currentdate?passValue=" + passValue),
            dateType: "json",
            data: passValue,
            success: function (data) {
                if (data.State == "Error") {
                    bars.ui.error({ title: 'Помилка', text: data.Error });
                    $("#pass").val("");
                } else {
                    debugger;
                    location.href = bars.config.urlContent("/opencloseday/openclose/currentdate?passValue=" + passValue);            
                    //$(document).remove();
                    //$("#mainFrame").remove();
                    //$("#main1").append(data);
                    //$(".form-horizontal").remove();
                    //$(".container").append(data);
                }
            }
        });

    });

    $("#pass").keypress(function (e) {
        if (e.which == 13) {
            $("#confirm").click();
        }
    });

    $("#btnCancel").click(function () {
        $(".container").remove();
    });



});