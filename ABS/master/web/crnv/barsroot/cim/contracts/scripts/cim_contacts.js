var diag = null; // объект всплывающего окна контекстного меню

Sys.Application.add_load(function () {
    curr_module = CIM.contract_module();
    curr_module.initialize(CIM.args());
});

CIM.contract_module = function () {
    var module = {}; // внутренний объект модуля 
    var grid_id = null; // id головного гріда

    var statusDialogTimer; // таймер для показа окна состояния документа

    // ******** public methods ********
    module.initialize = function (args) {
        grid_id = args[0];
        if (document.getElementById(grid_id))
            document.getElementById(grid_id).oncontextmenu = function () { return false; };
        if (diag) diag.dialog("destroy");
        diag = $('#dialogContractInfo');
        diag.dialog({
            autoOpen: false,
            resizable: false
        });
        // при відведенні курсору з вікна інф. вікна - ховати його по таймауту
        diag.dialog("widget").unbind().hover(function () { clearTimeout(statusDialogTimer); }, hideStatusDialog);

        $(".barsGridView td").mousedown(function (e) {
            if (e.button == 2) {
                e.preventDefault;
                $(this).click();
                showStatusDialog($(this));
                return false;
            }
            else if (e.button == 1)
                hideStatusDialog();
            return true;
        });
    }
    // Добавити новий контракт
    module.AddContract = addContract;
    module.CloseContract = closeContract;
    module.ShowContractCard = showContractCard;
    module.ShowContractState = showContractState;
    module.ShowClientCard = showClientCard;
    // ********************************

    // ******** private methods ********
    function confirmAction(result, callFunc) {
        if (result) {
            eval(callFunc);
        }

    }

    function addContract() {
        $(location).attr('href', 'contract_card.aspx?mode=create');
    }

    function closeContract(_id, status_id) {
        var message = "";
        if (status_id == 1) // если закрытый - восстанавливаем
            message = "Відновити закритий контракт з номером " + _id + "?";
        else
            message = "Закрити/видалити контракт з номером " + _id + "?";
        core$ConfirmBox(message, "Закриття\відновлення контракту", function (result) { confirmAction(result, "closeContractCall(" + _id + ")"); });
    }

    function closeContractCall(contr_id) {
        if (contr_id)
            PageMethods.CloseContract(contr_id, onCloseContract, CIM.onPMFailed);
    }

    function onCloseContract(res) {
        if (res)
            CIM.reloadAfterCallback();
    }

    function showContractCard(_id) {
        var id = _id;
        if (!id || id == undefined) {
            var rowdata = eval('(' + $(".selectedRow").attr("rowdata") + ')');
            id = rowdata.ci;
        }
        $(location).attr('href', 'contract_card.aspx?mode=view&contr_id=' + id);
    }

    function showContractState(_id) {
        var id = _id;
        if (!id) {
            var rowdata = eval('(' + $(".selectedRow").attr("rowdata") + ')');
            id = rowdata.ci;
        }
        $(location).attr('href', 'contract_state.aspx?contr_id=' + id);
    }
    function showClientCard(_rnk) {
        var rnk = _rnk;
        if (!rnk) {
            var rowdata = eval('(' + $(".selectedRow").attr("rowdata") + ')');
            rnk = rowdata.rnk;
        }
        $(location).attr('href', '/barsroot/clientregister/registration.aspx?&readonly=1&rnk=' + rnk);
    }

    // Ховаємо панель-акселератор
    function hideStatusDialog() {
        statusDialogTimer = setTimeout(function () { diag.dialog('close'); }, 500);
    }

    // Показати панель-акселератор з інформацією про когтракт
    function showStatusDialog(elem) {
        clearTimeout(statusDialogTimer);
        if (!elem) elem = $(this);
        diag.dialog('option', 'title', jsres$contract_module.action);
        var x = elem.offset().left + elem.outerWidth() - 4;
        var y = elem.offset().top - $(document).scrollTop() + elem.outerHeight() - 4;
        diag.dialog("option", "position", [x, y]);
        // очищаємо попередні властивості
        diag.find("a").css("cursor", "pointer")
                        .removeAttr("disabled")
                        .css("text-decoration", "underline")
                        .removeClass("ui-state-disabled")
                        .unbind('click')
                        .hover(function () { $(this).css("text-decoration", "none"); },
                               function () { $(this).css("text-decoration", "underline"); });
        // Інформація про контракт
        var row = elem.parent();
        var rowdata = eval('(' + row.attr("rowdata") + ')');
        diag.find("#lbContractId").text(jsres$contract_module.contr_id + rowdata.ci);
        diag.find("#lbContractType").text(jsres$contract_module.type + rowdata.ct);
        diag.find("#lbContractNum").text(jsres$contract_module.num + rowdata.cn);

        var disabledLinks = new Array();

        // Створити новий
        diag.find("#lnCreateNew").click(function () {
            diag.dialog('close');
            addContract();
        });

        // Карточка контракту
        if (rowdata.ci)
            diag.find("#lnShowContractCard").click(function () {
                diag.dialog('close');
                showContractCard(rowdata.ci);
            });
        else
            disabledLinks.push("#lnShowCard");

        // Переглянути статус контракту
        if (false) /*TODO пока отключаем */ //rowdata.ci)
            diag.find("#lnShowContractState").click(function () {
                diag.dialog('close');
                showContractState(rowdata.ci);
            });
        else
            disabledLinks.push("#lnShowContractState");

        // Переглянути картку клієнта
        if (rowdata.rnk)
            diag.find("#lnShowClientCard").click(function () {
                diag.dialog('close');
                showClientCard(rowdata.rnk);
            });
        else
            disabledLinks.push("#lnShowClientCard");

        diag.find(disabledLinks.join(",")).attr("disabled", "disabled").addClass("ui-state-disabled").css("text-decoration", "none");

        diag.dialog('open');
    }

    // ********************************

    return module;
};
