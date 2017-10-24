$(document).ready(function() {

    function saveRoleCreating() {
        var roleCode = $("#roleCode").val(),
            roleName = $("#roleName").val();

        return {
            roleCode: roleCode,
            roleName: roleName
        }
    }

    function saveRoleEditing() {
        var roleCode = $("#edit-roleCode").val(),
            roleName = $("#edit-roleName").val();

        return {
            roleCode: roleCode,
            roleName: roleName
        }
    }

    // save "Create"
    $("#saveCreateRole-btn").click(
         function () {
            var name = $("#roleName").val(),
                code = $("#roleCode").val();
            if (name === "" && code === "") {
                bars.ui.error({ text: "Не вказано назву та код для ролі" });
            } else if (name !== "" && code === "") {
                bars.ui.error({ text: "Не вказано код для ролі" });
            } else if (name === "" && code !== "") {
                bars.ui.error({ text: "Не вказано назву для ролі" });
            } else {
                var model = saveRoleCreating();
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/roles/CreateRole"),
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(model),
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result.message });
                    $("#CreateRole-Window").data("kendoWindow").close();
                    $("#RolesGrid").data("kendoGrid").dataSource.read();
                });
            }
        }
    );

    $("#cencelCreateRole-btn").click(
        function () {
            var window = $("#CreateRole-Window").data("kendoWindow");
            window.close();
        }
    );

    // save "Edit"
    $("#saveEditRole-btn").click(
        function () {
            var name = $("#edit-roleName").val();
            if (name === "") {
                bars.ui.error({ text: "Не вказано назву для ролі" });
            } else {
                var model = saveRoleEditing();
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/roles/EditRole"),
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(model),
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result.message });
                    $("#EditRole-Window").data("kendoWindow").close();
                    $("#RolesGrid").data("kendoGrid").dataSource.read();
                });
            } 
        }
    );

    $("#cencelEditRole-btn").click(
        function () {
            var window = $("#EditRole-Window").data("kendoWindow");
            window.close();
        }
    );
});