var diag = null;
var diagDebt = null;

Sys.Application.add_load(function () {
    curr_module = CIM.contract_module();
    curr_module.initialize(CIM.args());
});

CIM.contract_module = function () {
    var module = {}; // внутренний объект модуля 
    var selRowData = null;
    var searchMode = 0;

    //#region ******** public methods ********
    module.initialize = function (args) {

        $(".datepick").datepicker({
            showOn: "button",
            buttonImage: "/Common/Images/default/16/calendar.png",
            buttonImageOnly: true
        });

        $('#btSelClient').bind("click", function () { searchMode = 0; selectClient(); });
        $('#btSelClientByOkpo').bind("click", function () { searchMode = 1; selectClient(); });

        $('#tbClientOkpo').bind("change", function () { searchMode = 1; getClientInfo(null, $(this).val()); });
        $('#tbClientRnk').bind("change", function () { searchMode = 0; getClientInfo($(this).val(), null); });

        $("#cbSelectAll").change(
                        function () {
                            if ($("#cbSelectAll").attr("checked"))
                                $(".cssNeedApprive input[type='checkbox']").attr("checked", "checked");
                            else
                                $(".cssNeedApprive input[type='checkbox']").removeAttr("checked");
                        });
    };
    // Добавити новий контракт
    module.AddDebt = addDebt;
    module.EditDebt = addDebt;
    module.DeleteDebt = deleteDebt;

    var DebtClass = { ri: null, nb: null, ab: null, rn: null, op: null, nk: null, ak: null, nd: null, dd: null, dp: null };
    //#endregion 

    // ******** private methods ********
    function confirmAction(result, callFunc) {
        if (result) {
            eval(callFunc);
        }
    }

    function prepareDialog() {
        diagDebt = $('#dialogDebtInfo');
        try {
            diagDebt.dialog('destroy');
        }
        catch (e) { };
        diagDebt.dialog({
            autoOpen: false,
            resizable: false,
            modal: true,
            width: 700,
            buttons: {
                "Зберегти": function () {
                    if (saveDebt()) $(this).dialog("close");
                },
                "Відміна": function () {
                    $(this).dialog("close");
                }
            }
        });
    }

    // взять выделенную строку
    function getSelected(obj) {
        if (obj) selRowData = obj;
        else if ($(".selectedRow"))
            selRowData = eval('(' + $(".selectedRow").attr("rd") + ')');
        else {
            selRowData = null;
            core$WarningBox("Не виділено жодного рядка.", "Вибір контракту");
        }
        return selRowData;
    }
    var isInsert = false;
    function addDebt(elem, insert) {
        isInsert = insert;
        var rowdata = { ri: null, nb: $('span[id$="lbBranchName"]').html(), ab: $('span[id$="lbBranchAdr"]').html(), rn: null, op: null, nk: null, ak: null, nd: null, dd: null, dp: null };
        if (!insert)
            rowdata = eval('(' + elem.parent().parent().attr("rd") + ')');
        DebtClass.ri = rowdata.ri;
        $("#lbNameBank").html(rowdata.nb);
        $("#lbAdrBank").html(rowdata.ab);
        $("#tbClientOkpo").val(rowdata.op);
        $("#tbClientRnk").val(rowdata.rn);
        $("#lbClientName").html(rowdata.nk);
        $("#lbClientAdr").html(rowdata.ak);
        $("#tbContrNum").val(rowdata.nd);
        $("#tbContrDate").val(rowdata.dd);
        $("#tbPayDate").val(rowdata.dp);

        prepareDialog();
        var title = (insert) ? ("Створення запису") : ("Редагування запису");
        diagDebt.dialog('option', 'title', title);
        diagDebt.dialog('option', 'position', { my: "left top", at: "right top", of: elem });
        diagDebt.dialog('open');
    }

    function deleteDebt(elem) {
        rowdata = eval('(' + elem.parent().parent().attr("rd") + ')');
        var message = "";
        if (rowdata.fn) // есть файл 
            message = "Зняти відмітку про формування файлу " + rowdata.fn + "?";
        else
            message = "Видалити \\ зняти відмітку про підтвердження повідомлення ?";
        core$ConfirmBox(message, "Закриття повідомлення", function (result) { confirmAction(result, "deleteDebtCall(" + rowdata.ri + ", '" + rowdata.fn + "')"); });
    }

    function deleteDebtCall(ri,fn)
    {
        PageMethods.DeleteDebt(ri, fn, reloadPage, onFailed);
    }


    function saveDebt() {
        DebtClass.op = $("#tbClientOkpo").val();
        DebtClass.rn = $("#tbClientRnk").val();
        DebtClass.nk = $("#lbClientName").html();
        DebtClass.ak = $("#lbClientAdr").html();
        DebtClass.nd = $("#tbContrNum").val();
        DebtClass.dd = $("#tbContrDate").val();
        DebtClass.dp = $("#tbPayDate").val();
        DebtClass.ins = isInsert;

        PageMethods.SaveDebt(DebtClass, reloadPage, onFailed);
    }

    function reloadPage(res) {
        location.href = location.href;
    }

    function onFailed(res)
    { }

    function onFailed(error, userContext, methodName) {
        if (error !== null) {
            alert(error.get_message());
        }
    }

    function selectClient() {
        var tail = '';
        if (searchMode == 1)
            tail = "okpo like \'" + $("#tbClientOkpo").val() + "%\'";
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail="' + tail + '"&role=wr_metatab&tabname=customer', null,
						        "dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result) {
            $("#tbClientRnk").val(result[0]);
            getClientInfo(result[0], result[2]);
        }
    }

    // Получаем информацию о клиенте
    function getClientInfo(rnk, okpo) {
        if (rnk || okpo)
            PageMethods.GetClientInfo(rnk, okpo, onGetClientInfo, onFailed);
    }

    function setClientInfo(client) {
        $("#tbClientRnk").val((client) ? (client.Rnk) : (""));
        $("#tbClientOkpo").val((client) ? (client.Okpo) : (""));
        $('#lbClientName').text((client) ? (client.Name) : (""));
        $('#lbClientAdr').text((client) ? (client.Adr) : (""));
    }

    function onGetClientInfo(res) {
        if (res.Rnk > 0) {
            setClientInfo(res);
        }
        else if (res.Rnk < 0) {
            selectClient();
        }
        else {
            if (searchMode == 0) {
                core$WarningBox("Контрагента з вказаним кодом [rnk=" + $("#tbClientRnk").val() + "] не знайдено.", "Пошук контрагента");
                $("#tbClientRnk").val("").focus();
            }
            else if (searchMode == 1) {
                core$WarningBox("Контрагента з вказаним кодом [okpo=" + $("#tbClientOkpo").val() + "] не знайдено.", "Пошук контрагента");
                $("#tbClientOkpo").val("").focus();
            }
            setClientInfo(null);
        }
    }

    return module;
};
