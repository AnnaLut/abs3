$(document).ready(function () {

    auth_nd = bars.extension.getParamFromUrl('nd', location.href);

    var dialog = $("#dialogAuthorication").kendoWindow({
        title: "Авторизація",
        modal: true,
        draggable: false,
        visible: false,
        width: 300
    }).data("kendoWindow");


    ///start
    bars.ui.loader('body', true);
    GetStaticData();
    bars.ui.loader('body', false);


    function GetStaticData() {
        $.ajax({
            type: "POST",
            async: true,
            dataType: "json",
            url: bars.config.urlContent("/CreditUI/NewCredit/GetAuthData/"),
            data: { nd: auth_nd },
            success: function (data) {
                if (data.ERROR !== null)
                    bars.ui.error({
                        title: "Помилки при вибірці даних кредитного договору",
                        text: data.ERROR
                    });
                else
                    SetStatic(data);
            }
        });
    }

    function SetStatic(data) {
        $("#auth_cc_id").val(data.CC_ID);
        $("#auth_date").val(data.DATE_START);
        $("#auth_type").kendoDropDownList({ dataSource: [{ ID: 1, NAME: "Повна" }, { ID: 0, NAME: "Проста" }], dataTextField: "NAME", dataValueField: "ID" });
        if (data.PRINSIDER !== 99)
            if (data.INSFO === "1")
                ConfirmInsider();
            else
                ConfirmInsiderWithoutForm();
        else
            dialog.open().center(); 
    }

    function ConfirmInsider() {
        TemplateConfirm("<b>Увага!</b><br>Позичальник є пов’язаною з банком особою <b>(інсайдером).</b><br><br>" +
                            "Підтвердити здійснення авторизації?");
    }

    function ConfirmInsiderWithoutForm() {
        TemplateConfirm("<b>Увага!</b><br>Позичальник є пов’язаною з банком особою <b>(інсайдером).</b><br><br>" +
                        "<b><span style='color:red'>НЕ ЗАПОВНЕНО АНКЕТУ ІНСАЙДЕРА</span></b><br><br>" +
                            "Підтвердити здійснення авторизації?");
    }


    function TemplateConfirm(text) {
        bars.ui.approve({
            text: text,
            func: function () { dialog.open().center(); },
            nfunc: function () { window.close(); }
        });
    }

    $("#bt_auth_ok").click(function () {
        $.ajax({
            async: true,
            type: 'POST',
            url: bars.config.urlContent('/CreditUI/NewCredit/Authorize'),
            dataType: 'json',
            data: {
                nd: auth_nd,
                type: $("#auth_type").data("kendoDropDownList").value(),
                pidstava: $("#auth_pidst").val(),
                initiative: $("#auth_initiative").val()
            },
            success: function (data) {
                if (data === "Ok") 
                    bars.ui.alert({ text: "Авторизація успішно зроблена!" });
                else
                    bars.ui.error({
                        title: "Помилки при авторизації кредитного договору",
                        text: data
                    });
            }
        });
    });
})