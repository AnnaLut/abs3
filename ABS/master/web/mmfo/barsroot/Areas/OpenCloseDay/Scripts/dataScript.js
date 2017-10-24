$(document).ready(function () {

    //Введення технологічного парлю
   /* var myWindow = $("#window"),
            undo = $("#undo");

    undo.click(function () {
        myWindow.data("kendoWindow").open();
        undo.fadeOut();
    });

    function onClose() {
        undo.fadeIn();
    }

    myWindow.kendoWindow({
        width: "300px",
        height: "200px",
        title: "Закриття банківського дня",
        visible: false,
        resizable: false,
        actions: [
            "Close"
        ],
        close: onClose
    }).data("kendoWindow").center().open();
    */
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
            url: bars.config.urlContent("/opencloseday/closeday/currentdate?passValue=" + passValue),
            dateType: "json",
            data: passValue,
            success: function (data) {
                debugger;
                if (data.State == "Error") {
                    bars.ui.error({ title: 'Помилка', text: data.Error });
                    $("#pass").val("");
                } else {
                    //$("#window").data("kendoWindow").close();
                    //$("#pass").val("");
                    debugger;
                    $(".form-horizontal").remove();
                    $(".container").append(data);
                    //myWindow.data("kendoWindow").open();
                    //$("#window").data("kendoWindow").open();
                }
            }
        });

    });

    $("#btnCancel").click(function () {
        $(".container").remove();
    });





});