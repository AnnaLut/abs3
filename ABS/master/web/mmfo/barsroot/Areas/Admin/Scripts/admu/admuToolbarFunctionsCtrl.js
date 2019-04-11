$(document).ready(function () {

    // MainGridToolBar:
    $("#UsersConfigToolBar").kendoToolBar({
        items: [
            { template: "<button id='pbAddUser' type='button' class='k-button' title='Додати користувача'><i class='pf-icon pf-16 pf-add_button'></i></button>" },
            { template: "<button id='pbEditUser' type='button' class='k-button' title='Редагувати користувача'><i class='pf-icon pf-16 pf-tool_pencil'></i></button>" },
            { template: "<button id='pbDropUser' type='button' class='k-button' title='Видалити користувача'><i class='pf-icon pf-16 pf-delete_button_error'></i></button>" },
            // { template: "<button id='pbCloneUser' type='button' class='k-button' title='Клонувати користувача'><i class='pf-icon pf-16 pf-accept_doc'></i></button>" },
            // { template: "<button id='pbSendUsersActives' type='button' class='k-button' title='Передати рахунки користувача'><i class='pf-icon pf-16 pf-list-arrow_right'></i></button>" },
            { template: "<button id='pbUnblockUser' type='button' class='k-button' title='Розблокувати користувача'><i class='pf-icon pf-16 pf-security_unlock'></i></button>" },
            { template: "<button id='pbBlockUser' type='button' class='k-button' title='Заблокувати користувача'><i class='pf-icon pf-16 pf-security_lock'></i></button>" },
            // { template: "<button id='pbLoadUsersRes' type='button' class='k-button' title='Вигрузити ресурси користувача'><i class='pf-icon pf-16 pf-arrow_download'></i></button>" }
            { template: "<button id='pbFilter' type='button' class='k-button' title='Складний фільтр'><i class='pf-icon pf-16 pf-filter-ok'></i></button>" },
            { template: "<button id='pbRefresh' type='button' class='k-button' title='Оновити грід'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>" }
        ]
    });

    // Create user
    $("#CreateUserWindow").kendoWindow({
        title: "Введення даних нового користувача",
        visible: false,
        width: "600px",
        height: "590px",
        resizable: false,
        actions: ["Close"],
        open: function () {
            var createFormTabs = $("#create-form-tabs").kendoTabStrip().data("kendoTabStrip");
            if (createFormTabs) {
                createFormTabs.select(0);
            }
        }
    });

    var createFormTabs = $("#create-form-tabs").kendoTabStrip().data("kendoTabStrip");
    createFormTabs.select(0);

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

        if ($(":checkbox")) {
            $(":checkbox").attr("checked", false);
            $(":checkbox").attr("disabled", false);
        }
    }

    $("#pbAddUser").kendoButton({
        click: function () {
            cleanUp();

            $("#role-treelist").data("kendoGrid").dataSource.read();

            var window = $("#CreateUserWindow").data("kendoWindow");
            window.center();
            window.open();
        }
    });



    $("#pbFilter").kendoButton({
        click: function () {
            bars.ui.getFiltersByMetaTable(function (response) {
                if (response.length > 0) {
                    var grid = $("#ADMUGrid").data("kendoGrid");

                    paramObj.urlParams = response.join(' and ');
                    //localStorage.setItem('paramObj', JSON.stringify(paramObj));

                    //grid.dataSource.read({
                    //    parameters: paramObj.urlParams
                    //});

                    grid.dataSource.read();
                }
            }, { tableName: "V_STAFF_USER_ADM" });
        }
    });

    $("#pbRefresh").kendoButton({
        click: function () {
            paramObj.urlParams = '';

            //$("#ADMUGrid").data("kendoGrid").dataSource.read({
            //    parameters: paramObj.urlParams
            //});
            $("#ADMUGrid").data("kendoGrid").dataSource.read();
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

    // -------- EDIT -----

    $("#EditUserWindow").kendoWindow({
        title: "Редагування даних користувача",
        visible: false,
        width: "600px",
        height: "580px",
        resizable: false,
        actions: ["Close"],
        open: function () {
            var createFormTabs = $("#edit-form-tabs").kendoTabStrip().data("kendoTabStrip");
            if (createFormTabs) {
                createFormTabs.select(0);
            }
        }
    });

    var editFormTabs = $("#edit-form-tabs").kendoTabStrip().data("kendoTabStrip");
    editFormTabs.select(0);

    $("#btnCancel-editing").kendoButton({
        click: function () {
            $("#EditUserWindow").data("kendoWindow").close();
        },
        enable: true
    });

    $("#ed_addOraRoleBtn").kendoButton({
        click: function () {
            $("#edit-oraRoles-Window").data("kendoWindow").center().open();
        },
        enable: true
    });

    // ********************************************************************************************************

    function initChangePasswordBtn() {
        $("#changePassword").kendoButton({
            click: function () {

                var gridAdmu = $("#ADMUGrid").data("kendoGrid"),
                    currentRow = gridAdmu.dataItem(gridAdmu.select());

                if (currentRow.AUTHENTICATION_MODE_ID === "STAFF_USER_ORA") {
                    $("#chPassConfirm-ORA").val("");
                    $("#chPass-ORA").val("");

                    var winChPass = $("#changePass-ORA").data("kendoWindow");
                    winChPass.center();
                    winChPass.open();
                } else if (currentRow.AUTHENTICATION_MODE_ID === "STAFF_USER_CBS") {
                    $("#chPassConfirm-ABS").val("");
                    $("#chPass-ABS").val("");

                    var winChPass = $("#changePass-ABS").data("kendoWindow");
                    winChPass.center();
                    winChPass.open();
                }
            },
            enable: false
        });
    }

    function initAbsChangeOptions(authMode) {

        $("#changePass-ABS").kendoWindow({
            title: "Редагування паролю користувача ABS",
            visible: false,
            width: "400px",
            resizable: false,
            actions: ["Close"]
        });

        function changeUserAbsPassword() {
            var login = $("#ed_login").val(),
                password = hex_sha1($("#chPass-ABS").val());

            return {
                login: login,
                password: password
            }
        }

        $("#saveChPass-ABS").kendoButton({
            click: function () {
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/admu/ChangeAbsUserPassword"), // todo
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(changeUserAbsPassword()),
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result.Message });
                    $("#changePass-ABS").data("kendoWindow").close();
                });
            },
            enable: false
        });

        $("#cencelChPass-ABS").kendoButton({
            click: function () {
                $("#changePass-ABS").data("kendoWindow").close();
                $("#chPassConfirm-ABS").css("border", "1px solid #cfdadd");
            },
            enable: true
        });

        function absChangePasswordCompare() {
            var password = $("#chPass-ABS").val(),
                confirmPass = $("#chPassConfirm-ABS").val();
            if (password === confirmPass) {
                $("#saveChPass-ABS").data("kendoButton").enable(true);
                $("#chPassConfirm-ABS").change(function () {
                    $(this).css("border", "1px solid #cfdadd");
                });
            } else {
                $("#saveChPass-ABS").data("kendoButton").enable(false);
                $("#chPassConfirm-ABS").change(function () {
                    $(this).css("border", "1px solid red");
                });
            }
        }
        $("#chPassConfirm-ABS").keyup(absChangePasswordCompare);
    }

    function initOraChangeOptions(authMode) {

        $("#changePass-ORA").kendoWindow({
            title: "Редагування паролю користувача Oracle",
            visible: false,
            width: "400px",
            resizable: false,
            actions: ["Close"]
        });

        function changeUserOraPassword() {
            var login = $("#ed_login").val(),
                password = $("#chPass-ORA").val();

            return {
                login: login,
                password: password
            }
        }

        $("#saveChPass-ORA").kendoButton({
            click: function () {
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/admu/ChangeOraUserPassword"), // todo
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(changeUserOraPassword()),
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result.Message });
                    $("#changePass-ORA").data("kendoWindow").close();
                });
            },
            enable: false
        });

        $("#cencelChPass-ORA").kendoButton({
            click: function () {
                $("#changePass-ORA").data("kendoWindow").close();
                $("#chPassConfirm-ORA").css("border", "1px solid #cfdadd");
            },
            enable: true
        });

        function oraChangePasswordCompare() {
            var password = $("#chPass-ORA").val(),
                confirmPass = $("#chPassConfirm-ORA").val();
            if (password === confirmPass) {
                $("#saveChPass-ORA").data("kendoButton").enable(true);
                $("#chPassConfirm-ORA").change(function () {
                    $(this).css("border", "1px solid #cfdadd");
                });
            } else {
                $("#saveChPass-ORA").data("kendoButton").enable(false);
                $("#chPassConfirm-ORA").change(function () {
                    $(this).css("border", "1px solid red");
                });
            }
        }
        $("#chPassConfirm-ORA").keyup(oraChangePasswordCompare);
    }

    function initAdChangePassword() {
        $("#changePassword").kendoButton({
            enable: false
        });
    }

    function initDelegateUserRights(data) {
        /*  Кнопка активна тільки для статусів користувача: Активний, Блокований  */
        $("#delegateUserRightsWindow").kendoWindow({
            title: "Делегування прав користувача",
            visible: false,
            width: "600px",
            resizable: false,
            actions: ["Close"]
        });

        $("#delegateDateFrom").kendoDatePicker({
            format: "dd/MM/yyyy"
        });

        $("#delegateDateTo").kendoDatePicker({
            format: "dd/MM/yyyy"
        });

        $("#delegate").kendoButton({
            click: function () {

                var winDelegate = $("#delegateUserRightsWindow").data("kendoWindow"),
                    delegateBox = $("#delegateBox"),
                    delegateTemplate = kendo.template($("#delegate-template").html());

                delegateBox.html(delegateTemplate(data));
                winDelegate.center();
                winDelegate.open();
            },
            enable: function () {
                if (data.UserStateCode === "ACTIVE" || data.UserStateCode === "LOCKED") {
                    return true;
                } else {
                    return false;
                }
            }()
        });

        function delegateUserRights() {
            return {
                login: $("#ed_login").val(),
                delegatedUser: $("#delegatedUserTarget").val(),
                validFrom: $("#delegateDateFrom").data("kendoDatePicker").value(),
                validTo: $("#delegateDateTo").data("kendoDatePicker").value(),
                comment: $("#delegationComment").val()
            }
        }

        $("#saveDelegateOptions").kendoButton({
            click: function () {
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/admu/DelegateUserRights"), // todo
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(delegateUserRights()),
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result.Message });
                    $("#delegateUserRightsWindow").data("kendoWindow").close();
                });
            },
            enable: true
        });

        $("#cencelDelegateOptions").kendoButton({
            click: function () {
                $("#delegateUserRightsWindow").data("kendoWindow").close();
            }
        });
    }

    function initCencelUserRightDelegation(data) {
        /*  Кнопка активна тільки для статусів користувача: «Права користувача делеговано»  */
        $("#cencelDelegate").kendoButton({
            click: function () {
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/admu/CencelDelegateUserRights"), // todo
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify({ login: $("#ed_login").val() }),
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result.Message });
                });
            },
            enable: function () {
                if (data.DelegatedUserLogin !== "null") {
                    return true;
                } else {
                    return false;
                }
            }()
        });
    }

    function unlockUser() {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/admin/admu/UnlockUser"),
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(function () {
                var gridADMU = $("#ADMUGrid").data("kendoGrid");
                var currentRow = gridADMU.dataItem(gridADMU.select());
                return {
                    login: currentRow.LOGIN_NAME
                }
            }()),
            traditional: true
        }).done(function (result) {
            bars.ui.alert({ text: result.Message });
            var gridADMU = $("#ADMUGrid").data("kendoGrid");
            var currentRow = gridADMU.dataItem(gridADMU.select());
            currentRow.set("STATE_ID", 2);
            currentRow.set("STATE_NAME", "Активний");

            var lockButton = $("#lock").data("kendoButton");
            if (lockButton) {
                lockButton.enable(true);
            }
            var unlockButton = $("#unlock").data("kendoButton");
            if (unlockButton) {
                unlockButton.enable(false);
            }

            var window = $("#EditUserWindow").data("kendoWindow");
            window.close();
        });
    };

    function lockUser() {
        function lockUserData() {
            return {
                login: $("#lock_login").val(),
                comment: $("#lockComment").val()
            }
        }

        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/admin/admu/LockUser"), // todo
            contentType: "application/json",
            dataType: "json",
            data: JSON.stringify(lockUserData()),
            traditional: true
        }).done(function (result) {
            bars.ui.alert({ text: result.Message });
            var gridADMU = $("#ADMUGrid").data("kendoGrid");
            var currentRow = gridADMU.dataItem(gridADMU.select());
            currentRow.set("STATE_ID", 3);
            currentRow.set("STATE_NAME", "Заблокований");
            var lockButton = $("#lock").data("kendoButton");
            if (lockButton) {
                lockButton.enable(false);
            }
            var unlockButton = $("#unlock").data("kendoButton");
            if (unlockButton) {
                unlockButton.enable(true);
            }
            $("#lockWindow").data("kendoWindow").close();

            var window = $("#EditUserWindow").data("kendoWindow");
            window.close();
        });
    }

    function lockUserConfirm() {
        var winLock = $("#lockWindow").data("kendoWindow"),
            lockInfoBox = $("#lockInfoBox"),
            lockTemplate = kendo.template($("#lockUser-template").html());
        var gridAdmu = $("#ADMUGrid").data("kendoGrid"),
            currentRow = gridAdmu.dataItem(gridAdmu.select());

        lockInfoBox.html(lockTemplate({ UserName: currentRow.USER_NAME, LoginName: currentRow.LOGIN_NAME }));
        winLock.center();
        winLock.open();
    };

    function initLockUser(data) {
        $("#lock").kendoButton({
            click: function () {
                lockUserConfirm();
            }
        });
    }

    function initUnlockUser(data) {
        $("#unlock").unbind("click");

        $("#unlock").kendoButton({
            click: function () {
                bars.ui.confirm({
                    text: 'Розблокувати користувача?'
                }, function () {
                    unlockUser();
                });
            }
        });
    }

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
                        branchListCheckedRefresh("#edit-branch-treelist", arr[j], true);
                    } else {
                        arr[j].checked = true;
                        arr[j].disabled = false;
                    }
                }
            }
        }
    }


    function initEditOraRoles(data) {
        var editTree = $("#edit-oraRoles-grid").data("kendoGrid"),
            currentRoles = data.UserOraRoles, // []
            arr = editTree.tbody.find("input"),
            arrlength = editTree.tbody.find("input").length,
            i = 0;
        for (i; i < currentRoles.length; i++) {
            var j = 0;
            for (j; j < arrlength; j++) {
                if (arr[j].getAttribute("data-oraRole") === currentRoles[i]) {
                    arr[j].checked = true;
                }
            }
        }
    }

    $("#pbEditUser").kendoButton({
        click: function () {
            cleanUp();

            var gridAdmu = $("#ADMUGrid").data("kendoGrid"),
                currentRow = gridAdmu.dataItem(gridAdmu.select());

            if (currentRow) {
                $("#edit-role-grid").data("kendoGrid").dataSource.read();
                bars.ui.loader('#allMenus', true);
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
                            edSignBox = $("#ed_signBox"),
                            edSignTemplate = kendo.template($("#edSignContent").html()),
                            template = kendo.template($("#Edit").html()),
                            window = $("#EditUserWindow").data("kendoWindow"),
                            authMode = $("#authMode"),
                            commDiv = $("#edComments"),
                            commTemplate = kendo.template($("#comments-template").html()),
                            data = result.Data;

                        div.html(template(data));
                        edSignBox.html(edSignTemplate(data));
                        commDiv.html(commTemplate(data));


                        var divDelegation = $("#delegationBody");
                        template = kendo.template($("#Delegation").html());
                        divDelegation.html(template(data));

                        // Auth checkboxes init:
                        $('#ed_absBox :input').attr('disabled', !data.IsNativeAuth);
                        $('#ed_useAbs').prop('checked', data.IsNativeAuth);

                        $('#ed_oraBox :input').attr('disabled', !data.IsOracleAuth);
                        $('#ed_useOra').prop('checked', data.IsOracleAuth);

                        $('#ed_adBox :input').attr('disabled', !data.IsAdAuth);
                        $('#ed_useAd').prop('checked', data.IsAdAuth);

                        var divAuthTempBox = $('#authTempBox'),
                            tempAuth = kendo.template($("#authTemp").html());

                        divAuthTempBox.html(tempAuth(data));

                        // hidden:
                        //initEditUserBranches(data);
                        //initEditUserRoles(data);
                        //var button = $("#changePassword").kendoButton().data("kendoButton");

                        $("#editBranchBtn").kendoButton({
                            click: function () {
                                $("#editBranchWindow").data("kendoWindow").center().open();
                            },
                            enable: true
                        });

                        initChangePasswordBtn();
                        initDelegateUserRights(data);
                        initCencelUserRightDelegation(data);
                        initLockUser(data);
                        initUnlockUser(data);
                        $("#lock").data("kendoButton").enable(data.UserStateCode === "ACTIVE");
                        $("#unlock").data("kendoButton").enable(data.UserStateCode !== "ACTIVE");
                        window.center();
                        window.open();
                    } else {
                        bars.ui.alert({ text: result.Errors.message });
                    }
                    bars.ui.loader('#allMenus', false);
                });
            } else {
                bars.ui.alert({ text: "Оберіть запис!" });
            }
        },
        enable: true
    });
    $("#pbDropUser").kendoButton({
        click: function () {
            bars.ui.confirm({ text: 'Користувача буде видалено, продовжити?' }, function () {
                var gridAdmu = $("#ADMUGrid").data("kendoGrid"),
                    currentRow = gridAdmu.dataItem(gridAdmu.select());

                $.ajax({
                    type: "GET",
                    url: bars.config.urlContent("/admin/admu/CloseUser"),
                    contentType: "application/json",
                    dataType: "json",
                    data: { login: currentRow.LOGIN_NAME },
                    traditional: true
                }).done(function (result) {
                    gridAdmu.dataSource.read();
                    bars.ui.alert({ text: result.message });
                });
            });
        },
        enable: true
    });
    $("#pbCloneUser").kendoButton({
        //click: openCloneWindow,
        enable: false
    });
    $("#pbSendUsersActives").kendoButton({
        //click: openTransmitWindow,
        enable: false
    });
    $("#pbUnblockUser").kendoButton({
        click: function () {
            bars.ui.confirm({
                text: 'Розблокувати користувача?'
            }, function () {
                unlockUser();
            });
        },
        enable: false
    });
    $("#pbBlockUser").kendoButton({
        click: lockUserConfirm,
        enable: false
    });

    $("#saveLockOptions").kendoButton({
        click: function () {
            lockUser();
        }
    });

    $("#cencelLockOptions").kendoButton({
        click: function () {
            $("#lockWindow").data("kendoWindow").close();
        }
    });

    $("#pbLoadUsersRes").kendoButton({
        //click: exportToSqlScript,
        enable: false
    });

    $("#lockWindow").kendoWindow({
        title: "Блокувати користувача",
        visible: false,
        width: "400px",
        resizable: false,
        actions: ["Close"]
    });
});