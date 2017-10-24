$(document).ready(function() {
    // MainGridToolBar:
    $("#UsersConfigToolBar").kendoToolBar({
        items: [
            { template: "<button id='pbAddUser' type='button' class='k-button' title='Додати користувача'><i class='pf-icon pf-16 pf-add_button'></i></button>" },
            { template: "<button id='pbEditUser' type='button' class='k-button' title='Редагувати користувача'><i class='pf-icon pf-16 pf-tool_pencil'></i></button>" },
            { template: "<button id='pbDropUser' type='button' class='k-button' title='Видалити користувача'><i class='pf-icon pf-16 pf-delete_button_error'></i></button>" },
            { template: "<button id='pbCloneUser' type='button' class='k-button' title='Клонувати користувача'><i class='pf-icon pf-16 pf-accept_doc'></i></button>" },
            { template: "<button id='pbSendUsersActives' type='button' class='k-button' title='Передати рахунки користувача'><i class='pf-icon pf-16 pf-list-arrow_right'></i></button>" },
            { template: "<button id='pbUnblockUser' type='button' class='k-button' title='Розблокувати користувача'><i class='pf-icon pf-16 pf-ok'></i></button>" },
            { template: "<button id='pbBlockUser' type='button' class='k-button' title='Заблокувати користувача'><i class='pf-icon pf-16 pf-delete'></i></button>" },
            { template: "<button id='pbLoadUsersRes' type='button' class='k-button' title='Вигрузити ресурси користувача'><i class='pf-icon pf-16 pf-arrow_download'></i></button>" }
        ]
    });
    // Create Window:
    $("#CreateUserWindow").kendoWindow({
        title: "Введення даних нового користувача",
        visible: false,
        width: "600px",
        height: "580px",
        resizable: false,
        actions: ["Close"]
    });

    var createFormTabs = $("#create-form-tabs").kendoTabStrip().data("kendoTabStrip");
    createFormTabs.select(0);

    //var data = [
    //    { text: "ABS", value: "abs" },
    //    { text: "Oracle", value: "ora" },
    //    { text: "Active Directory", value: "ad" }
    //];

    //function absSwitcher() {
    //    $("#abs-box").show();
    //    $("#ora-box").hide();
    //    $("#ad-box").hide();
    //}

    //function oraSwitcher() {
    //    $("#abs-box").hide();
    //    $("#ora-box").show();
    //    $("#ad-box").hide();
    //}

    //function activeDirectorySwitcher() {
    //    $("#abs-box").hide();
    //    $("#ora-box").hide();
    //    $("#ad-box").show();
    //}

    //$("#combobox").kendoComboBox({
    //    dataTextField: "text",
    //    dataValueField: "value",
    //    dataSource: data,
    //    index: 0,
    //    change: function () {
    //        switch (this.value()) {
    //            case "abs":
    //                $("input[type='password']").val("");
    //                $("#btnSave-adding").data("kendoButton").enable(false);
    //                absSwitcher();
    //                break;
    //            case "ora":
    //                $("input[type='password']").val("");
    //                $("#btnSave-adding").data("kendoButton").enable(false);
    //                oraSwitcher();
    //                break;
    //            case "ad":
    //                $("input[type='password']").val("");
    //                $("#btnSave-adding").data("kendoButton").enable(true);
    //                activeDirectorySwitcher();
    //                break;
    //        }
    //    }
    //});

    $("#dateEnd").kendoDatePicker({
        format: "dd/MM/yyyy",
        min: new Date(new Date().getTime() + 24 * 60 * 60 * 1000)
    });

    $("#addBranchBtn").kendoButton({
        click: function () {
            $("#branchWindow").data("kendoWindow").center().open();
        },
        enable: true
    });

    $("#addOraRoleBtn").kendoButton({
        click: function () {
            $("#ora-roles-Window").data("kendoWindow").center().open();
        },
        enable: true
    });

    function cleanUp() {

        $(":input").val("");

        $('#absBox :input').attr('disabled', true);
        $('#oraBox :input').attr('disabled', true);
        $('#adBox :input').attr('disabled', true);

        $("#btnSave-adding").data("kendoButton").enable(false);

        //var combobox = $("#combobox").data("kendoComboBox");
        //combobox.value("abs");
        //absSwitcher();

        if ($(":checkbox")) {
            $(":checkbox").attr("checked", false);
            $(":checkbox").attr("disabled", false);
        }

    }

    $("#pbAddUser").kendoButton({
        click: function () {
            //$("#create-form-tabs").kendoTabStrip().data("kendoTabStrip").select(0);
            cleanUp();

            var window = $("#CreateUserWindow").data("kendoWindow");
            window.center();
            window.open();
        }
    });

    $("#btnCancel-adding").kendoButton({
        click: function () {
            $("#CreateUserWindow").data("kendoWindow").close();

            $("#abs-passConfirm").css("border", "1px solid #cfdadd");
            $("#ora-passConfirm").css("border", "1px solid #cfdadd");
        },
        enable: true
    });

    // Edit Window:

    $("#EditUserWindow").kendoWindow({
        title: "Редагування даних користувача",
        visible: false,
        width: "600px",
        height: "600px",
        resizable: false,
        actions: ["Close"]
    });

    var editFormTabs = $("#edit-form-tabs").kendoTabStrip().data("kendoTabStrip");
    editFormTabs.select(0);

    $("#btnCancel-editing").kendoButton({
        click: function () {
            $("#EditUserWindow").data("kendoWindow").close();
        },
        enable: true
    });

    function initEditUserBranches(data) {
        var editTree = $("#edit-branch-treelist").data("kendoTreeList"),
            //editTreeData = editTree.dataSource.view(),
            currentBranches = data.AdditionalBranches, // ["/000001/", "/000001/000001/000001/", "/000002/"],
            arr = editTree.tbody.find("input"),
            arrlength = editTree.tbody.find("input").length,
            i = 0;
        for (i; i < currentBranches.length; i++) {
            var j = 0;
            for (j; j < arrlength; j++) {
                if (arr[j].getAttribute("data-branch") === currentBranches[i]) {
                    if (arr[j].getAttribute("data-branch") === data.BranchCode) {
                        arr[j].checked = true;
                        arr[j].disabled = true;
                    } else {
                        arr[j].checked = true;
                        arr[j].disabled = false;
                    }
                }
            }
        }
    }

    function initEditUserRoles(data) {
        var editTree = $("#edit-role-grid").data("kendoGrid"),
            currentRoles = data.UserRoles, // []
            arr = editTree.tbody.find("input"),
            arrlength = editTree.tbody.find("input").length,
            i = 0;
        for (i; i < currentRoles.length; i++) {
            var j = 0;
            for (j; j < arrlength; j++) {
                if (arr[j].getAttribute("data-selectrole") === currentRoles[i].toString()) {
                    arr[j].checked = true;
                }
            }
        }
    }


    $("#pbEditUser").kendoButton({
        click: function () {
                var gridAdmu = $("#ADMUGrid").data("kendoGrid"),
                currentRow = gridAdmu.dataItem(gridAdmu.select());

                //var branchTree = $("#treelist").data("kendoTreeList"),
                 //   roleTree = $("#role-treelist").data("kendoTreeList");

                //branchTree.dataSource.read();
                //roleTree.dataSource.read();

                $.ajax({
                    type: "GET",
                    url: bars.config.urlContent("/admin/admu/GetUserData"),
                    contentType: "application/json",
                    dataType: "json",
                    data: { loginName: currentRow.LOGIN_NAME },
                    traditional: true
                }).done(function (result) {
                    if (result.Data !== null) {
                        var div = $("#mainPart"),
                            template = kendo.template($("#Edit").html()),
                            window = $("#EditUserWindow").data("kendoWindow"),
                            authMode = $("#authMode"),
                            commDiv = $("#edComments"),
                            commTemplate = kendo.template($("#comments-template").html()),
                            data = result.Data;

                        div.html(template(data));
                        commDiv.html(commTemplate(data));

                        //initEditUserBranches(data);
                        //initEditUserRoles(data);

                        var button = $("#changePassword").kendoButton().data("kendoButton");

                        switch (data.AuthenticationModeCode) {
                            case "STAFF_USER_CBS":

                                button.enable(true);

                                var absTemplate = kendo.template($("#authMode-ABS").html());
                                authMode.html(absTemplate(data));

                                $("#ed_endDete").kendoDateTimePicker({
                                    value: data.PasswordExpiresAt,
                                    format: "dd/MM/yyyy hh:mm tt"
                                });

                                initAbsChangeOptions();

                                break;

                            case "STAFF_USER_ORA":
                                var oraTemplate = kendo.template($("#authMode-ORA").html());
                                authMode.html(oraTemplate(data));

                                button.enable(true);

                                initEditOraRoles(data);

                                $("#editOraRoleBtn").kendoButton({
                                    click: function () {
                                        $("#edit-oraRoles-Window").data("kendoWindow").center().open();
                                    },
                                    enable: true
                                });

                                initOraChangeOptions();

                                break;

                            case "STAFF_USER_AD":
                                var adTemplate = kendo.template($("#authMode-AD").html());
                                authMode.html(adTemplate);

                                initAdChangePassword();

                                break;
                        }

                        $("#editBranchBtn").kendoButton({
                            click: function () {
                                $("#editBranchWindow").data("kendoWindow").center().open();
                            },
                            enable: true
                        });

                        //initChangePasswordBtn();
                        //initDelegateUserRights(data);
                        //initCencelUserRightDelegation(data);
                        //initLockUser(data);
                        //initUnlockUser(data);

                        window.center();
                        window.open();
                    } else {
                        bars.ui.alert({ text: result.Errors.message });
                    }
                });
            },
        enable: true
    });

    // Other buttons:
    /*
    $("#pbDropUser").kendoButton({
        click: function () {
            // stub for test:
            var gridAdmu = $("#ADMUGrid").data("kendoGrid"),
                currentRow = gridAdmu.dataItem(gridAdmu.select());

            $.ajax({
                type: "GET",
                url: bars.config.urlContent("/admin/admu/GetUserData"),
                contentType: "application/json",
                dataType: "json",
                data: { loginName: currentRow.LOGIN_NAME },
                traditional: true
            }).done(function (result) {
                var data = result.data;
                bars.ui.alert({ text: "***" });

            });
        },
        enable: false
    });
    $("#pbCloneUser").kendoButton({
        click: openCloneWindow,
        enable: false
    });
    $("#pbSendUsersActives").kendoButton({
        click: openTransmitWindow,
        enable: false
    });
    $("#pbUnblockUser").kendoButton({
        click: openStatusUnblockWindow,
        enable: false
    });
    $("#pbBlockUser").kendoButton({
        click: openStatusLockWindow,
        enable: false
    });
    $("#pbLoadUsersRes").kendoButton({
        click: exportToSqlScript,
        enable: false
    });
    */
});