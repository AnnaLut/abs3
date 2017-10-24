$(document).ready(function () {
    function saveAdm(funcType) {
        var admCode = funcType === "create" ? $("#admCode").val().replace(/ /g, "") : $("#admCodeEdit").val(),
            admName = funcType === "create" ? $("#admName").val() : $("#admNameEdit").val(),
            appType = funcType === "create" ? $("#admAppType").data("kendoDropDownList").value() : $("#admAppTypeEdit").data("kendoDropDownList").value();

        return {
            admCode: admCode,
            admName: admName,
            appType: appType
        }
    }

    function validFormData(code, name) {
        if (name === "" && code === "") {
            bars.ui.error({ text: "Не вказано назву та код АРМу" });
            return false;
        } else if (name !== "" && code === "") {
            bars.ui.error({ text: "Не вказано код АРМу" });
            return false;
        } else if (name === "" && code !== "") {
            bars.ui.error({ text: "Не вказано назву АРМу" });
            return false;
        } else {
            return true;
        }
    }

    // save "Create"
    $("#saveCreateAdm-btn").click(
        function() {
            var name = $("#admName").val(),
                code = $("#admCode").val();
            if (validFormData(code, name)) {
                var model = saveAdm("create");
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/adm/CreateAdm"),
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(model),
                    traditional: true
                }).done(function(result) {
                    bars.ui.alert({ text: result.message });
                    $("#CreateAdm-Window").data("kendoWindow").close();
                    $("#ADMGrid").data("kendoGrid").dataSource.read();
                });
            }
        }
    );

    $("#cencelCreateAdm-btn").click(
        function () {
            var window = $("#CreateAdm-Window").data("kendoWindow");
            window.close();
        }
    );

    // save "Edit"
    $("#saveEditAdm-btn").click(function() {
        var name = $("#admNameEdit").val(),
            code = $("#admCodeEdit").val();
        if (validFormData(code, name)) {
            var model = saveAdm("edit");
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/admin/adm/EditAdm"),
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(model),
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result.message });
                $("#EditAdm-Window").data("kendoWindow").close();
                $("#ADMGrid").data("kendoGrid").dataSource.read();
            });
        }
    });

    $("#cencelEditAdm-btn").click(function() {
        var window = $("#EditAdm-Window").data("kendoWindow");
        window.close();
    });
});