var diag = null; // объект всплывающего окна контекстного меню

Sys.Application.add_load(function () {
    curr_module = CIM.contract_module();
    curr_module.initialize(CIM.args());
    var grid = $("#jtab");
    /*
    $("#jtab").jqGrid({
        // setup custom parameter names to pass to server
        prmNames: {
            search: "isSearch",
            nd: null,
            rows: "numRows",
            page: "page",
            sort: "sortField",
            order: "sortOrder"
        },
        // add by default to avoid webmethod parameter conflicts
        postData: { searchString: '', searchField: '', searchOper: '' },
        // setup ajax call to webmethod
        datatype: function (postdata) {
            mtype: "GET",
            $.ajax({
                url: 'contracts_list.aspx/getGridData',
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(postdata),
                dataType: "json",
                success: function (data, st) {
                    if (st == "success") {
                        var grid = jQuery("#jtab")[0];
                        grid.addJSONData(JSON.parse(data.d));
                    }
                },
                error: function () {
                    alert("Error with AJAX callback");
                }
            });
        },
        // this is what jqGrid is looking for in json callback
        jsonReader: {
            root: "rows",
            page: "page",
            total: "totalpages",
            records: "totalrecords",
            cell: "cell",
            id: "id", //index of the column with the PK in it 
            userdata: "userdata",
            repeatitems: true
        },
        colNames: ['Ід. контракту', 'Тип контракту', 'Статус'],
        colModel: [
         { name: 'contr_id', index: 'contr_id', width: 65, search: false },
         { name: 'CONTR_TYPE_NAME', index: 'CONTR_TYPE_NAME', width: 120, searchoptions: { sopt: ['eq', 'ne', 'cn'] } },
         { name: 'STATUS_NAME', index: 'STATUS_NAME', width: 120, searchoptions: { sopt: ['eq', 'ne', 'cn'] } }
        ],
        rowNum: 10,
        rowList: [10, 20, 30],
        pager: jQuery("#jpager"),
        sortname: "contr_id",
        sortorder: "desc",
        viewrecords: true,
        caption: "Перелік контрактів"
    }).jqGrid('navGrid', '#jpager', { edit: false, add: false, del: false },
    {}, // default settings for edit
    {}, // add
    {}, // delete
    { closeOnEscape: true, closeAfterSearch: true }, //search
    {}
    );*/

});

CIM.contract_module = function () {
    var module = {}; // внутренний объект модуля 
    var grid_id = null; // id головного гріда
    var mode = null;
    var isSelectMode = false;
    var selRowData = null;
    var statusDialogTimer; // таймер для показа окна состояния документа

    //#region ******** public methods ********
    module.initialize = function (args) {
        grid_id = args[0];
        mode = args[1];
        isSelectMode = (mode === "select");

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

        if (isSelectMode) {
            $(".barsGridView tr").dblclick(function () {
                returnClientId();
            });
        }
    }
    // Добавити новий контракт
    module.AddContract = addContract;
    module.CloseContract = closeContract;
    module.ResurrectContract = resurrectContract;
    module.ShowContractCard = showContractCard;
    module.ShowContractState = showContractState;
    module.ShowClientCard = showClientCard;
    module.ReturnClientId = returnClientId;
    module.CheckSanctions = checkSanctions;
    module.ShowLicenses = showLicenses;
    
    //#endregion 

    // ******** private methods ********
    function confirmAction(result, callFunc) {
        if (result) {
            eval(callFunc);
        }
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

    //#region Возврат выделеного значения строки 
    function returnClientId() {
        if (!getSelected()) return;
        window.returnVal = selRowData.ci;
        parent.core$IframeBoxClose();
    }
    //#endregion

    function addContract() {
        $(location).attr('href', 'contract_card.aspx?mode=create');
    }

    function closeContract(_id, status_id) {
        var message = "";
        if (status_id == 1) // если закрытый - восстанавливаем
            message = "Видалити контракт з номером " + _id + "?";
        else
            message = "Закрити контракт з номером " + _id + "?";
        core$ConfirmBox(message, "Закриття\\Видалити контракту", function (result) { confirmAction(result, "closeContractCall(" + _id + ")"); });
    }

    function closeContractCall(contr_id) {
        if (contr_id)
            PageMethods.CloseContract(contr_id, onCloseContract, CIM.onPMFailed);
    }
    
    function resurrectContract(_id) {
        var message = "Відновити закритий контракт з номером " + _id + "?";
        core$ConfirmBox(message, "Відновлення контракту", function (result) { confirmAction(result, "resurrectContractCall(" + _id + ")"); });
    }

    function resurrectContractCall(contr_id) {
        if (contr_id)
            PageMethods.ResurrectContract(contr_id, onCloseContract, CIM.onPMFailed);
    }

    function onCloseContract(res) {
        if (res)
            CIM.reloadAfterCallback();
    }

    function showContractCard(obj) {
        if (!getSelected(obj)) return;
        $(location).attr('href', 'contract_card.aspx?mode=view&contr_id=' + selRowData.ci);
    }

    //#region Санкції

    // Перевірка санкцій
    function checkSanctions(obj) {
        if (!getSelected(obj)) return;
        PageMethods.CheckSanction(selRowData.ci, onCheckSanctions, CIM.onPMFailed);
    }

    function onCheckSanctions(res) {
        if (res)
        {
            var message = "Перейти до перегляду довідника санкцій ?";
            if (res.Code == "0")
                 message = "Не знайдено санкцій по даному контракту (id=" + selRowData.ci + ").\n" + message;
            else if (res.Code == "1")
                message = "Знайдено недіючі санції по даному контракту (id=" + selRowData.ci + ").\n" + message;
            else if (res.Code == "2")
                message = "Знайдено діючі санкції на резидента по даному контракту (id=" + selRowData.ci + ").\n" + message;
            else if (res.Code == "3")
                message = "Знайдено діючі санкції на нерезиденту по даному контракту (id=" + selRowData.ci + ").\n" + message;
            core$ConfirmBox(message, "Санкції по контракту", function (result) { confirmAction(result, "showSanctions(" + res.Code + ")"); });
        }
    }
    function showSanctions(code)
    {
        var obj = { url: "/barsroot/cim/sanctions/default.aspx?code=" + code, width: 1000, height: 600, title: "Санкції по контракту (id=" + selRowData.ci + ")" };
        if($(location).attr('href').indexOf("mode=select") > 0)
            parent.core$IframeBox(obj);
        else 
            core$IframeBox(obj);
    }

    //#endregion

    function showContractState(obj) {
        if (!getSelected(obj)) return;
        if(isSelectMode)
            parent.location.href = 'contract_state.aspx?contr_id=' + selRowData.ci;
        else
            $(location).attr('href', 'contract_state.aspx?contr_id=' + selRowData.ci);
    }
    function showClientCard(obj) {
        if (!getSelected(obj)) return;
        core$IframeBox({ url: "/barsroot/clientregister/registration.aspx?&readonly=1&rnk=" + selRowData.rnk, width: 900, height: 600, title: "Картка клієнта (rnk=" + selRowData.rnk + ")" });
    }

    //#region Ліцензії
    function showLicenses(obj) {
        if (!getSelected(obj)) return;
        $(location).attr('href', 'licenses.aspx?contr_id=' + selRowData.ci + "&taxcode=" + selRowData.ok);
    }

    //#endregion

    //#region Панель контекстного меню
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
        selRowData = eval('(' + row.attr("rd") + ')');
        diag.find("#lbContractId").text(jsres$contract_module.contr_id + selRowData.ci);
        diag.find("#lbContractType").text(jsres$contract_module.type + selRowData.ct);
        diag.find("#lbContractNum").text(jsres$contract_module.num + selRowData.cn);

        var disabledLinks = new Array();

        // Створити новий
        diag.find("#lnCreateNew").click(function () {
            diag.dialog('close');
            addContract();
        });

        // Карточка контракту
        if (selRowData.ci)
            diag.find("#lnShowContractCard").click(function () {
                diag.dialog('close');
                showContractCard(selRowData);
            });
        else
            disabledLinks.push("#lnShowCard");

        // Переглянути статус контракту
        if (selRowData.ci)
            diag.find("#lnShowContractState").click(function () {
                diag.dialog('close');
                showContractState(selRowData);
            });
        else
            disabledLinks.push("#lnShowContractState");

        // Переглянути картку клієнта
        if (selRowData.rnk)
            diag.find("#lnShowClientCard").click(function () {
                diag.dialog('close');
                showClientCard(selRowData);
            });
        else
            disabledLinks.push("#lnShowClientCard");

        // Перегляд санкцій по контракту
        if (selRowData.ci)
            diag.find("#lnCheckSanctions").click(function () {
                diag.dialog('close');
                checkSanctions(selRowData);
            });
        else
            disabledLinks.push("#lnCheckSanctions");

        diag.find(disabledLinks.join(",")).attr("disabled", "disabled").addClass("ui-state-disabled").css("text-decoration", "none");
        // если в режиме выбора - то прячем все
        if (isSelectMode)
            diag.find('a[id*="ln"]').hide();
        diag.dialog('open');
    }
    //#endregion

    return module;
};
