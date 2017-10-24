$(document).ready(function () {
    
    function getCheckedBranches() {
        var tree = $("#treelist").data("kendoTreeList"),
            checkedList = tree.tbody.find("input:checked"),
            i = 0,
            branchList = [];
        for (i; i < checkedList.length; i++) {
            branchList.push(checkedList[i].getAttribute("data-branch"));
        }
        return branchList.toString();
    }

    function getCheckedRoles() {
        var tree = $("#role-treelist").data("kendoGrid"),
            checkedList = tree.tbody.find("input:checked"),
            i = 0,
            roleList = [];
        for (i; i < checkedList.length; i++) {
            roleList.push(checkedList[i].getAttribute("data-selectrole"));
        }
        return roleList.toString();
    }

    function absPasswordCompare() {
        var password = $("#abs-password").val(),
            confirmPass = $("#abs-passConfirm").val();
        if (password && password === confirmPass) {
            
            $("#btnSave-adding").data("kendoButton").enable(true);
           
            $("#abs-passConfirm").change(function () {
                $(this).css("border", "1px solid #cfdadd");
            });
        } else {
            $("#btnSave-adding").data("kendoButton").enable(false);
            $("#abs-passConfirm").change(function() {
                $(this).css("border", "1px solid red");
            });
        }
    }

    $("#abs-passConfirm, #abs-password").keyup(absPasswordCompare);

    function oraPasswordCompare() {
        var password = $("#ora-password").val(),
            confirmPass = $("#ora-passConfirm").val();
        if (password && password === confirmPass) {

            $("#btnSave-adding").data("kendoButton").enable(true);
            $("#ora-passConfirm").change(function () {
                $(this).css("border", "1px solid #cfdadd");
            });

        } else {
            $("#btnSave-adding").data("kendoButton").enable(false);
            $("#ora-passConfirm").change(function () {
                $(this).css("border", "1px solid red");
            });

        }
    }

    $("#ora-passConfirm, #ora-password").keyup(oraPasswordCompare);

    function adEntredConfirm() {
        var login = $("#adLogin").val();
        if (login) {
            $("#btnSave-adding").data("kendoButton").enable(true);
            $("#adLogin").change(function () {
                $(this).css("border", "1px solid #cfdadd");
            });
        } else {
            $("#btnSave-adding").data("kendoButton").enable(false);
            $("#adLogin").change(function () {
                $(this).css("border", "1px solid red");
            });
            
        }
    }
    $("#adLogin").keyup(adEntredConfirm);
    $("#adLogin").on('keypress', function () {
        var the_domain = $(this).val();

        // strip off "http://" and/or "www."
        the_domain = the_domain.replace("http://", "");
        the_domain = the_domain.replace("www.", "");

        var reg = /^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$/;
        if (reg.test(the_domain) === false) {
            $('#adLogin').focus();
            $('.rez').text('Недопустиме доменне ім\'я.\r\nПриклад: user01name.user01Soname');
        } else {
            $('.rez').text('');
        }
    });
    

    //new checkbox Auth btnSave validation:

    $('#absBox :input').attr('disabled', true);
    $('#oraBox :input').attr('disabled', true);
    $('#adBox :input').attr('disabled', true);

    var adChangeCheck = function() {
        if (($("#useOra").is(":checked") && $("#ora-password").val() && $("#ora-password").val() === $("#ora-passConfirm").val())
            || ($("#useAbs").is(":checked") && $("#abs-password").val() && $("#abs-password").val() === $("#abs-passConfirm").val())) {
            return true;
        } else {
            return false;
        }
    }

    var oraChangesCheck = function() {
        if (($("#useAd").is(":checked") && $("#adLogin").val())
            || ($("#useAbs").is(":checked") && $("#abs-password").val() && $("#abs-password").val() === $("#abs-passConfirm").val())) {
            return true;
        } else {
            return false;
        }
    }

    var absChangeCheck = function() {
        if ( (($("#useAd").is(":checked") && $("#adLogin").val()) 
            || ($("#useAbs").is(":checked") && $("#abs-password").val() && $("#abs-password").val() === $("#abs-passConfirm").val())) ) {
            return true;
        } else {
            return false;
        }
    }

    $("#useAbs").change(function () {
        $("#btnSave-adding").data("kendoButton").enable(false);
        if ($(this).is(":checked")) {
            $('#absBox :input').removeAttr('disabled');
        } else {
            if (absChangeCheck()) {
                $("#btnSave-adding").data("kendoButton").enable(true);
            }
            $('#absBox :input').val("");
            $('#absBox :input').attr('disabled', true);
        }
    });
    $("#useOra").change(function () {
        $("#btnSave-adding").data("kendoButton").enable(false);
        if ($(this).is(":checked")) {
            $('#oraBox :input').removeAttr('disabled');
        } else {
            if (oraChangesCheck()) {
                $("#btnSave-adding").data("kendoButton").enable(true);
            }
            $('#oraBox :input').val("");
            $('#oraBox :input').attr('disabled', true);
        }
    });
    $("#useAd").change(function () {
        $("#btnSave-adding").data("kendoButton").enable(false);
        if ($(this).is(":checked")) {
            $('#adBox :input').removeAttr('disabled');
        } else {
            if (adChangeCheck()) {
                $("#btnSave-adding").data("kendoButton").enable(true);
            }
            $('#adBox :input').val("");
            $('#adBox :input').attr('disabled', true);

            $('.rez').text('');
        }
    });

    function createUserObjectModel() {

        var login = $("#login").val(),
            name = $("#name").val(),
            branchId = $("#branchId").val(),

            canSelectBranch = $("#canSelectBranch").is(":checked"),
            extendedAccess = $("#extendedAccess").is(":checked"),
            tokenSign = $("#digitalSign").val(),

            absAuth = $("#useAbs").is(":checked"),
            absPass = hex_sha1($("#abs-password").val()),
            
            oraAuth = $("#useOra").is(":checked"),
            oraPass = $("#ora-password").val(),
            role = $("#ora-roles").val(),
            
            adAuth = $("#useAd").is(":checked"),
            adLogin = $("#adLogin").val(),

            //selBranches = getCheckedBranches(),
            selRoles = getCheckedRoles();

        return {
            login: login,
            name: name,
            defaultBranch: branchId,
            
            canSelectBranch: canSelectBranch,
            extendeAccess: extendedAccess,
            token: tokenSign,

            absAuth: absAuth,
            absPass: absPass,

            oraAuth: oraAuth,
            oraPass: oraPass,
            oraRoles: role,

            adAuth: adAuth,
            adLogin: adLogin,

            //branches: selBranches,
            webRoles: selRoles
        }
    }

    // Save adding:
    $("#btnSave-adding").kendoButton({
        click: function () {
            if ($("#digitalSign").val().length === 6) {
                debugger;
                var model = createUserObjectModel();
                debugger;
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/admu/CreateUser"),
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(model),
                    traditional: true
                }).done(function(result) {
                    if (result.Errors) {
                        bars.ui.error({ text: result.Errors.message });
                    } else {
                        bars.ui.alert({ text: result.Message });
                    }
                    $("#CreateUserWindow").data("kendoWindow").close();
                    $("#ADMUGrid").data("kendoGrid").dataSource.read();
                });
            } else {
                bars.ui.error({ text: "Довжина ключа цифрового підпису має бути 6 символів!" });
                var createFormTabs = $("#create-form-tabs").kendoTabStrip().data("kendoTabStrip");
                if (createFormTabs) {
                    createFormTabs.select(0);
                }
            }
        },
        enable: false
    });
    

    function getEditCheckedBranches() {
        var tree = $("#edit-branch-treelist").data("kendoTreeList"),
            checkedList = tree.tbody.find("input:checked"),
            i = 0,
            branchList = [];
        for (i; i < checkedList.length; i++) {
            branchList.push(checkedList[i].getAttribute("data-branch"));
        }
        return branchList.toString();
    }

    function getEditCheckedRoles() {
        var grid = $("#edit-role-grid").data("kendoGrid"),
            checkedList = grid.tbody.find("input:checked"),
            i = 0,
            roleList = [];
        for (i; i < checkedList.length; i++) {
            roleList.push(checkedList[i].getAttribute("data-selectrole"));
        }
        return roleList.toString();
    }

    $("#ed_useAbs").change(function () {
        $("#btnSave-editing").data("kendoButton").enable(false);
        if ($(this).is(":checked")) {
            $('#ed_absBox :input').removeAttr('disabled');
        } else {
            //if (absChangeCheck()) {
                $("#btnSave-editing").data("kendoButton").enable(true);
            //}
            $('#ed_absBox :input').val("");
            $('#ed_absBox :input').attr('disabled', true);
        }
    });
    $("#ed_useOra").change(function () {
        $("#btnSave-editing").data("kendoButton").enable(false);
        if ($(this).is(":checked")) {
            $('#ed_oraBox :input').removeAttr('disabled');
        } else {
            //if (oraChangesCheck()) {
                $("#btnSave-editing").data("kendoButton").enable(true);
            //}
            $('#ed_oraBox :input').val("");
            $('#ed_oraBox :input').attr('disabled', true);
        }
    });
    $("#ed_useAd").change(function () {
        $("#btnSave-editing").data("kendoButton").enable(false);
        if ($(this).is(":checked")) {
            $('#ed_adBox :input').removeAttr('disabled');
        } else {
            //if (adChangeCheck()) {
                $("#btnSave-editing").data("kendoButton").enable(true);
            //}
            $('#ed_adBox :input').val("");
            $('#ed_adBox :input').attr('disabled', true);
            $('.rez').text('');
        }
    });

    $("#ed_adLogin").on('keypress', function () {
        var the_domain = $(this).val();

        // strip off "http://" and/or "www."
        the_domain = the_domain.replace("http://", "");
        the_domain = the_domain.replace("www.", "");

        var reg = /^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9]\.[a-zA-Z]{2,}$/;
        if (reg.test(the_domain) === false) {
            $('#ed_adLogin').focus();
            $('.rez').text('Недопустиме доменне ім\'я.\r\nПриклад: user01name.user01Soname');
        } else {
            $('.rez').text('');
        }
    });

    function absEditedPasswordCompare() {
        var password = $("#ed_abs-password").val(),
            confirmPass = $("#ed_abs-passConfirm").val();
        if (password && password === confirmPass) {

            $("#btnSave-editing").data("kendoButton").enable(true);

            $("#ed_abs-passConfirm").change(function () {
                $(this).css("border", "1px solid #cfdadd");
            });
        } else {
            $("#btnSave-editing").data("kendoButton").enable(false);
            $("#ed_abs-passConfirm").change(function () {
                $(this).css("border", "1px solid red");
            });
        }
    }

    $("#ed_abs-passConfirm, #ed_abs-password").keyup(absEditedPasswordCompare);

    function oraEditedPasswordCompare() {
        var password = $("#ed_ora-password").val(),
            confirmPass = $("#ed_ora-passConfirm").val();
        if (password && password === confirmPass) {

            $("#btnSave-editing").data("kendoButton").enable(true);
            $("#ed_ora-passConfirm").change(function () {
                $(this).css("border", "1px solid #cfdadd");
            });

        } else {
            $("#btnSave-editing").data("kendoButton").enable(false);
            $("#ed_ora-passConfirm").change(function () {
                $(this).css("border", "1px solid red");
            });

        }
    }

    $("#ed_ora-passConfirm, #ed_ora-password").keyup(oraEditedPasswordCompare);

    function adEditedEntredConfirm() {
        var login = $("#ed_adLogin").val();
        if (login) {
            $("#btnSave-editing").data("kendoButton").enable(true);
            $("#adLogin").change(function () {
                $(this).css("border", "1px solid #cfdadd");
            });
        } else {
            $("#btnSave-editing").data("kendoButton").enable(false);
            $("#ed_adLogin").change(function () {
                $(this).css("border", "1px solid red");
            });
        }
    }
    $("#ed_adLogin").keyup(adEditedEntredConfirm);

    function createEditUserObjectModel() {
        return {
            LoginName: $("#ed_login").val(),
            UserName: $("#ed_name").val(),
            BranchCode: $("#ed_branchId").val(),
            CanSelectBranch: $("#ed_canSelectBranch").is(":checked") ? 1 : 0,
            ExtendedAccess: $("#ed_extendedAccess").is(":checked") ? 1 : 0,
            SecurityToken: $("#ed_digitalSign").val(),
            UseNativeAuth: $("#ed_useAbs").is(":checked") ? 1 : 0,
            CoreBankingPassword: $("#ed_abs-password").val() ? hex_sha1($("#ed_abs-password").val()) : null,
            UseOracleAuth: $("#ed_useOra").is(":checked") ? 1 : 0,
            OraclePassword: $("#ed_ora-password").val(),
            OracleRoles: $("#edit-ora-roles").val(),
            UseAdAuth: $("#ed_useAd").is(":checked") ? 1 : 0,
            ActiveDirectoryName: $("#ed_adLogin").val(),
            UserRoles: getEditCheckedRoles()
        }
    }

    // Save Editing:
    $("#btnSave-editing").kendoButton({
        click: function () {
            debugger;
            var model = createEditUserObjectModel();
            if (model != null) {
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/admu/EditUser"),
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(model),
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result.message });
                    $("#EditUserWindow").data("kendoWindow").close();
                    $("#ADMUGrid").data("kendoGrid").dataSource.read();
                });
            } else {
                bars.ui.alert({ text: "Не визначено режим автентифікації користувача." });
            } 
        },
        enable: true
    });
});