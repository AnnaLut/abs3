//Начальная инициализация
window.onload = function() {
    webService.useService("DocService.asmx?wsdl", "Doc");
    chkErrMessage(document.forms[0].__ERRMESS.value);
    FillNlsB(document);
    // если 15 флаг, то фокус на первый доп-реквизит
    if (document.getElementById("__FLAGS").value.substr(15, 1) == "1") {
        var reqvs = document.getElementById("Drecs_ids").value.split(',');
        for (i = 0; i < reqvs.length - 1; i++) {
            var elem = document.getElementById(reqvs[i]);
            if (!elem.readOnly && !elem.disabled) {
                elem.focus();
                break;
            }
        }
        document.getElementById('SumA').tabIndex = 200;
        document.getElementById('SumB').tabIndex = 201;
        document.getElementById('SumC').tabIndex = 202;
    }
    // если 16 флаг, то запрещаем ввод суммы
    if (document.getElementById("__FLAGS").value.substr(16, 1) == "1") {
        document.getElementById('SumA').readOnly = true;
        document.getElementById('SumB').readOnly = true;
        document.getElementById('SumC').readOnly = true;
    }
    // если 24 флаг - показываем ввод суб-счета
    if (document.getElementById("__FLAGS").value.substr(24, 1) == "1")
        document.getElementById('trSubAccount').style.display = "block";

    FillForm(this.document, decodeURI(this.location.search.substring(1)));

    InitSumFields();
    AttachFocus(document.getElementById("Nazn"));
    AttachFocus(document.getElementById("Nls_A"));
    AttachFocus(document.getElementById("Nls_B"));
    AttachFocus(document.getElementById("Mfo_A"));
    AttachFocus(document.getElementById("Mfo_B"));
    AttachFocus(document.getElementById("Sk"));
    SetOnFocusLogic("Id_A,Id_B,Nam_A,Nam_B,SumA,SumB,SumC,DocN,DocD,VobList");
    CheckNls();
    if (document.getElementById('__ND').value != "" || document.getElementById("__TT").value.substr(0, 2) == 'АД' || location.search.indexOf("refDoc=") > 0)
        reTransNazn(document.getElementById('DocInputForm'));

    //Если задан курс и сумма А то вычисляем сумму В
    if (GetValue("SumA") != 0 && GetValue("CrossRat") != 0) {
        SumA_Blur();
        document.getElementById('SumB').readOnly = true;
    }
    //Дата валютирования
    if (document.getElementById("__FLAGS").value.substr(3, 1) == "0" && document.getElementById("__FLAGS").value.substr(49, 1) == "0") {
        document.getElementById("Details").deleteRow(2);
    }
    //Заполняем поле остток на счете А
    fnFillOst();
    if (init_numPlus)
        init_numPlus("Nls_A");
    else
        init_num("Nls_A");
    if (init_numPlus)
        init_numPlus("Nls_B");
    else
        init_num("Nls_B");
    init_num("Mfo_A");
    init_num("Mfo_B");
    init_num("Id_A");
    init_num("Id_B");
    init_num("tbSubAccount");
    IniDateTimeControl("DocD");
    if (document.getElementById("DatV_TextBox"))
        IniDateTimeControl("DatV");
    if (document.getElementById("DatV2_TextBox"))
        IniDateTimeControl("DatV2");
    document.getElementById("Id_A").attachEvent("onfocusout", checkOKPO);
    document.getElementById("Id_B").attachEvent("onfocusout", checkOKPO);
    //Переводим titles html-контролов
    LocalizeHtmlTitles();
    document.attachEvent("onkeydown", hookHotKey);

    // Проверка на наличие формулы счетов 
    attachReqvFunc();
    //  
    SumFormulaCalc();
    // комисия в ПФ
    if (document.getElementById("reqv_SCPFU")) {
        document.getElementById("SumA").execFunc = true;
    }
};

function hookHotKey() {
    var key = event.keyCode;
    //alt + F10 - оплата
    if (event.altKey && key == 121) {
        document.all.btPayIt.focus();
        document.all.btPayIt.fireEvent("onclick");
    }
    //alt + F5 - печать тикета
    if (event.altKey && key == 116 && document.all.btPrintDoc.style.visibility != "hidden")
        document.all.btPrintDoc.fireEvent("onclick");
    //alt + F11 - ввод нового документа
    if (event.altKey && key == 122 && document.all.btSameDoc.style.visibility != "hidden")
        document.all.btSameDoc.fireEvent("onclick");
    //alt + F6 - вытяжка документа
    //if(event.ctrlKey && key == 117)
    //  setFixedValues();
    //alt + F7 - инкасвторы (podotw)
    if (event.altKey && key == 118 && document.getElementById("__FLAGS").value.substr(35, 1) == "1")
        selectPodotw();
}

function selectPodotw() {
    webService.Doc.callService(onSelectPodotwMod0, "SelectPodotw", document.getElementById("Nls_A").value, 0);
}
function onSelectPodotwMod0(result) {
    if (!getError(result, true)) return;
    var count = result.value[0];
    if (count == 1) {
        onSelectPodotw(result);
    }
    else if (count != 0) {
        var result = ShowMetaTable('PODOTCH', '"WHERE EXISTS (select id FROM podotw WHERE id=PODOTCH.id AND tag=\'NLS\' AND val=\'' + document.getElementById("Nls_A").value + '\')"');
        if (result != null && result[0]) {
            if (null == webService.Doc)
                webService.useService("DocService.asmx?wsdl", "Doc");
            webService.Doc.callService(onSelectPodotw, "SelectPodotw", result[0], 1);
        }
    }
    else {
        var result = ShowMetaTable('PODOTCH', '"WHERE NOT EXISTS (select id FROM podotw WHERE id=PODOTCH.id AND tag=\'NLS\')"');
        if (result != null && result[0]) {
            if (null == webService.Doc)
                webService.useService("DocService.asmx?wsdl", "Doc");
            webService.Doc.callService(onSelectPodotw, "SelectPodotw", result[0], 1);
        }
    }
}

function onSelectPodotw(result) {
    if (!getError(result, true)) return;
    for (i = 0; i <= result.value.length; i++) {
        if (result.value[i]) {
            var req = "reqv_" + result.value[i].substr(0, result.value[i].indexOf("="));
            var val = result.value[i].substr(result.value[i].indexOf("=") + 1);
            if (document.getElementById(req))
                document.getElementById(req).value = val;
        }
    }
}

function setFixedValues() {
    var elem = document.getElementById("__fixValues");
    elem.value = (elem.value == 1) ? (0) : (1);
    document.all.lbFixValues.style.visibility = (elem.value == 1) ? ("visible") : ("hidden");
}

function checkOKPO() {
    if (event.srcElement.value != "")
        isFilledOkpo(event.srcElement);
}

function GetBankName(evt) {
    var charCode = getCharCode(evt);
    var VK_F8 = 119;
    if (VK_F8 == charCode) {
        evt.srcElement.value = document.getElementById('__BANKNAME').value;
    }
}

function IniDateTimeControl(name) {
    window[name] = new RadDateInput(name, "Windows");
    window[name].PromptChar = " ";
    window[name].DisplayPromptChar = "_";
    window[name].SetMask(rdmskr(1, 31, false, true), rdmskl('/'), rdmskr(1, 12, false, true), rdmskl('/'), rdmskr(1, 2999, false, true));
    window[name].RangeValidation = true;
    window[name].SetMinDate('01/01/1980 00:00:00');
    window[name].SetMaxDate('31/12/2099 00:00:00');
    window[name].SetValue(document.getElementById(name + "_TextBox").value);
    window[name].Initialize();
}

function fnFillOst() {
    var pap = document.getElementById('__PAP').value;
    var ctrl = "";
    if (document.getElementById("__FLAGS").value.substr(37, 1) == "1")
        ctrl = "__OSTC";
    else
        ctrl = "__OSTB";
    if (document.getElementById(ctrl).value == "") {
        document.getElementById('tbZn').value = "";
        document.getElementById('tbOst').value = "";
        return;
    }

    var val = (document.getElementById(ctrl).value == "") ? (0) : (document.getElementById(ctrl).value);
    var dig_a = (document.getElementById("__DIGA").value == "") ? (2) : (document.getElementById("__DIGA").value);
    var ost = Math.pow(10, dig_a * (-1)) * parseFloat(val);
    var bcolor = "", fcolor = "";
    if (document.getElementById("__FLAGS").value.substr(37, 1) == "1")
        bcolor = "#C0FFFF";
    else
        bcolor = "#C0FFC0";

    if (pap == "2" && ost < 0)
        fcolor = "red";
    else if (pap == "1" && ost > 0)
        fcolor = "green";
    else
        fcolor = "navy";
    if (ost < 0) {
        document.getElementById('tbZn').value = "Д";
        ost = ost * (-1);
    }
    else if (ost > 0)
        document.getElementById('tbZn').value = "К";
    else
        document.getElementById('tbZn').value = "";

    document.getElementById('tbZn').style.backgroundColor = bcolor;
    document.getElementById('tbOst').style.backgroundColor = bcolor;
    document.getElementById('tbZn').style.color = fcolor;
    document.getElementById('tbOst').style.color = fcolor;

    init_numedit("tbOst", ost, dig_a);
}

//Устанавливаем в зависимости от валюты количество знаков после запятой в суммах
var isSumBlurAttached = false;
function InitSumFields() {
    var dig_a = (document.getElementById("__DIGA").value == "") ? (2) : (document.getElementById("__DIGA").value);
    var dig_b = (document.getElementById("__DIGB").value == "") ? (2) : (document.getElementById("__DIGB").value);
    init_numedit("SumA", ("" == document.getElementById("SumA").value) ? (0) : (document.getElementById("SumA").value), dig_a);
    init_numedit("SumB", ("" == document.getElementById("SumB").value) ? (0) : (document.getElementById("SumB").value), dig_b);
    init_numedit("SumC", ("" == document.getElementById("SumC").value) ? (0) : (document.getElementById("SumC").value), dig_a);
    init_numedit("CrossRat", ("" == document.getElementById("CrossRat").value) ? (0) : (document.getElementById("CrossRat").value), (document.getElementById("__FLAGS").value.substr(58, 1) == "1" || document.getElementById("__FLAGS").value.substr(14, 1) == "1") ? (2) : (6));

    if (!isSumBlurAttached) {
        document.getElementById("SumA").attachEvent("onblur", checkSumLength);
        document.getElementById("SumB").attachEvent("onblur", checkSumLength);
        document.getElementById("SumC").attachEvent("onblur", checkSumLength);
        isSumBlurAttached = true;
    }
}
function checkSumLength(e) {
    var val = GetValue(e.srcElement.id).toString().replace('.', '').replace(',', '');
    if (val.length > 15) {
        alert(LocalizedString('Message25'));
        e.srcElement.focus();
    }
}

//Сохраняем кореспондента в справочник alien и назначение
function fnSaveAlien() {
    webService.useService("DocService.asmx?wsdl", "Doc");
    var data = new Array();
    //межбанк	
    if (document.getElementById("__FLAGS").value.substr(64, 1) == "1"
  || document.getElementById("__FLAGS").value.substr(27, 1) == "1") {
        data[0] = document.getElementById("Nls_B").value;
        data[1] = document.getElementById("Mfo_B").value;
        data[2] = document.getElementById("Nam_B").value;
        data[3] = document.getElementById("Id_B").value;
        data[4] = document.getElementById("Kv_B").value;
        data[5] = document.getElementById("Nazn").value;
    }
    else {
        data[0] = document.getElementById("Nazn").value;
    }
    webService.Doc.callService(onInsertAttr, "InsertAttr", data);
}
function onInsertAttr(result) {
    if (!getError(result, true)) return;
    document.getElementById("btSaveAlien").style.visibility = "hidden";
    Dialog(LocalizedString('Message2'), "alert");
}

//Проверка счета на допуск
function CheckNls() {
    if ("" != document.getElementById("Nls_A").value && "" != document.getElementById("Kv_A").value && ("" == document.getElementById("Nam_A").value || "" == document.getElementById("Id_A").value)) {
        if ("" == document.getElementById("Id_A").value)
            alert("Не введено ОКПО клієнта рахунка " + document.getElementById("Nls_A").value + "(" + document.getElementById("Kv_A").value + ")");
        else
            alert(LocalizedString('Message7') + document.getElementById("Nls_A").value + "(" + document.getElementById("Kv_A").value + ")");
        document.getElementById("Nls_A").readOnly = false;
        document.getElementById("Nls_A").style.borderStyle = "inset";
        document.getElementById("Nls_A").style.backgroundColor = "white";
    }
    if ("" != document.getElementById("Nls_B").value && "" != document.getElementById("Kv_B").value && "" == document.getElementById("Id_B").value) {
        if (document.getElementById("Mfo_B").value != "" && document.getElementById("Mfo_B").value != document.getElementById("Mfo_A").value || document.getElementById("__FLAGS").value.substr(27, 1) == "1")
            cDocHand(1, document.forms[0]);
        else {
            alert(LocalizedString('Message7') + document.getElementById("Nls_B").value + "(" + document.getElementById("Kv_B").value + ")");
            document.getElementById("Nls_B").value = "";
            document.getElementById("Id_B").value = "";
            document.getElementById("Nam_B").value = "";
            document.getElementById("Nls_B").readOnly = false;
            document.getElementById("Nls_B").style.borderStyle = "inset";
            document.getElementById("Nls_B").style.backgroundColor = "white";
        }
    }
}

//Оплата через веб-сервс
function callOplDoc(form) {
    var data = new Array();
    data[0] = form.__DOCREF.value;
    data[1] = form.__FLAGS.value;
    data[2] = document.getElementById("__TT").value;
    data[3] = form.__DK.value;
    data[4] = form.__DOCSIGN.value;
    var id_o = form.__DOCKEY.value;
    if (id_o.length > 6)
        id_o = id_o.substr(id_o.length - 6);

    data[5] = id_o;

    data[6] = form.DocN.value;
    data[7] = form.DocD_TextBox.value;
    data[8] = form.Nls_A.value;
    data[9] = form.Nam_A.value.replace(/&/g, 'amp;').replace(/</g, 'lt;').replace(/>/g, 'gt;');
    data[10] = form.Mfo_A.value;
    data[11] = form.Kv_A.value;
    data[12] = form.Id_A.value;
    data[13] = form.Nls_B.value;
    data[14] = form.Nam_B.value.replace(/&/g, 'amp;').replace(/</g, 'lt;').replace(/>/g, 'gt;');
    data[15] = form.Mfo_B.value;
    data[16] = form.Kv_B.value;
    data[17] = form.Id_B.value;
    data[18] = form.Nazn.value.replace(/&/g, 'amp;').replace(/</g, 'lt;').replace(/>/g, 'gt;');
    data[19] = GetValue("SumA");
    data[20] = GetValue("SumB");
    data[21] = GetValue("SumC");

    // если сумма отрицательная, то меняем DK
    if (GetValue("SumC") < 0) {
        data[21] = GetValue("SumC") * (-1);
        data[3] = (data[3] == "1") ? ("0") : ("1");
    }

    data[22] = form.Sk.value;
    if (isQdoc())
        data[23] = getParamFromUrl("vob", location.search);
    else {
        if (form.VobList.options.length > 0)
            data[23] = form.VobList.options[form.VobList.selectedIndex].value;
        else
            data[23] = "";
    }

    data[24] = getParamFromUrl("aftprp", location.search);
    data[25] = getParamFromUrl("aftprp_r", location.search);

    data[26] = form.Drecs_ids.value;

    if (form.DatV_TextBox) data[27] = form.DatV_TextBox.value;
    else data[27] = "";
    if (form.DatV2_TextBox) data[28] = form.DatV2_TextBox.value;
    else data[28] = "";
    // приоритет документа
    if (document.getElementById("cbPriority"))
        data[29] = (document.getElementById("cbPriority").checked) ? ("1") : ("0");
    else
        data[29] = "0";
    data[30] = GetValue("CrossRat");
    data[31] = form.__DOCSIGN_INT.value;
    data[32] = form.__DIGA.value;
    data[33] = form.__DIGB.value;
    data[34] = form.__SIGNCC.value;

    if (isQdoc())
        data[35] = form.__QDOC_DATP.value; //decodeURIComponent(getParamFromUrl("datp",location.search));
    else
        data[35] = form.__DATP.value;

    data[36] = unescape(decodeURI(getParamFromUrl("APROC", location.search)));
    data[37] = unescape(decodeURI(getParamFromUrl("BPROC", location.search)));
    // Drec
    data[38] = form.Drec.value;

    var tags = new Array();
    for (i = 0; i < form.Drecs_ids.value.split(',').length - 1; i++) {
        var id = form.Drecs_ids.value.split(',')[i];
        try {
            tags[i] = eval("document.all." + id + ".value");
        }
        catch (e) {
            tags[i] = document.getElementById(id).value;
        }
    }

    data[39] = escape(gDocBufferInt);
    data[40] = escape(gDocBufferExt);
    data[41] = form.__ND.value;
    data[42] = form.tbSubAccount.value; // Суб. счет
    // чеки
    var checkDocsList = new Array();
    if (form.__FLAGS.value.substr(61, 1) == "1") {
        if (document.getElementById('gvLinkedDocs')) {
            var rows = document.getElementById('gvLinkedDocs').rows;
            for (i = 1; i < rows.length; i++) {
                var checkInfo = new Object();
                checkInfo.ID = rows[i].cells[1].innerHTML;
                checkInfo.Sk = rows[i].cells[2].innerHTML;
                checkInfo.S = rows[i].cells[3].innerHTML;
                checkInfo.Nazn = rows[i].cells[4].innerHTML;
                checkInfo.Nls = rows[i].cells[5].innerHTML;
                checkInfo.NlsName = rows[i].cells[6].innerHTML;
                checkDocsList.push(checkInfo);
            }
        }
    }
    webService.useService("DocService.asmx?wsdl", "Doc");
    webService.Doc.callService(onPayDoc, "PayDoc", data, tags, checkDocsList);
}
function onPayDoc(result) {
    gDocBufferInt = null;
    gDocBufferExt = null;
    if (!(document.getElementById("btPayIt").disabled = getError(result, true))) return;
    DisableControls(true);
    document.getElementById("OutRef").value = result.value;
    document.getElementById("__DOCREF").value = result.value;
    Dialog(LocalizedString('Message3') + "<BR>" + LocalizedString('Message4') + " " + result.value, "alert");
    if (document.getElementById("__FLAGS").value.substring(46, 47) == "1") {
        if (document.getElementById("__TICTOFILE").value == '1')
            __doPostBack("btFile", "");
        else
            PrintDoc();
    }
    cDocHand(0, document.forms[0], true);
    document.getElementById("dF12").style.visibility = "hidden";

    //если форма ввода поднята из формы информационных запросов
    if (isQdoc())
        try {
        //window.navigate("/Qdocs/default.aspx?rrp_rec="+getParamFromUrl("rrp_rec",location.search));
            location.replace("/barsroot/qdocs/default.aspx?rrp_rec=" + getParamFromUrl("rrp_rec", location.search));
        }
        catch (e) {
            return;
        }

    if (document.getElementById('fvLinkedDocs')) {
        document.getElementById('fvLinkedDocs').style.visibility = 'hidden';
        hideColumn();
    }
}

function isQdoc() {
    return ("" != getParamFromUrl("qdoc", location.search) && "" != getParamFromUrl("rrp_rec", location.search));
}

function DublicateDoc() {
    if (confirm("Продублювати поточний документ?")) {
        var ref = document.getElementById("OutRef").value;
        var tt = document.getElementById("__TT").value; //getParamFromUrl("tt", location.search);
        location.replace("docinput.aspx?tt=" + tt + "&refDoc=" + ref);
    }
}

function getCookie(par) {
    var pageCookie = document.cookie;
    var pos = pageCookie.indexOf(par + '=');
    if (pos != -1) {
        var start = pos + par.length + 1;
        var end = pageCookie.indexOf(';', start);
        if (end == -1) end = pageCookie.length;
        var value = pageCookie.substring(start, end);
        value = unescape(value);
        return value;
    }
}

function setCookie(name, val) {
    var date = new Date((new Date()).getTime() + 24 * 3600000);
    document.cookie = name + '=' + val + "; expires=" + date.toGMTString();
    document.getElementById("__FR_BM").value = val;
}

//Деактивация всех контролов
var controls = new Array("VobList", "DocN", "DatV_TextBox", "DatV2_TextBox", "DocD_TextBox", "Id_A", "Nam_A", "Kv_A", "Nls_A", "Mfo_A", "SumA", "SumB", "SumC", "CrossRat", "btPayIt", "Id_B", "Nam_B", "Kv_B", "Nls_B", "Sk", "Mfo_B", "Nazn", "cbPriority");
function DisableControls(disabled) {
    for (i = 0; i < controls.length; i++) {
        if (document.getElementById(controls[i]))
            document.getElementById(controls[i]).disabled = disabled;
    }
    for (i = 0; i < document.getElementById("Drecs_ids").value.split(',').length - 1; i++) {
        document.getElementById(document.getElementById("Drecs_ids").value.split(',')[i]).disabled = disabled;
    }
    if (document.getElementById("part_FIO_SURNAME")) {
        document.getElementById("part_FIO_SURNAME").disabled = disabled;
        document.getElementById("part_FIO_NAME").disabled = disabled;
        document.getElementById("part_FIO_PATR").disabled = disabled;
    }
    if (disabled) {
        document.getElementById("btSaveAlien").style.visibility = "visible";
        //if(document.getElementById("__TICTOFILE").value == '1')
        document.getElementById("btFile").style.visibility = 'visible';
        document.getElementById("btPrintDoc").style.visibility = 'visible';
        document.getElementById("btPrintDoc").attachEvent("onclick", PrintDoc);
        document.getElementById("btBuhModel").style.visibility = 'visible';
        document.getElementById("OutRef").style.visibility = 'visible';
        document.getElementById("btDuplicate").style.visibility = 'visible';
        document.getElementById("btBuhModel").attachEvent("onclick", ShowBuhModel);
        document.getElementById("trOptions").style.visibility = 'visible';
        document.getElementById("trOptions").style.position = 'relative';

        if (document.getElementById("__TICTOFILE").value != '2') {
            document.getElementById("btMenuPrint").style.visibility = 'visible';
            document.getElementById("btMenuPrint").attachEvent("onclick", MenuPrint);
        }
        if (parent.frames[0]) {
            document.getElementById("btSameDoc").style.visibility = 'visible';
            document.getElementById("btSameDoc").attachEvent("onclick", SameDoc);
        }
        var printTrnModel = getCookie("prnModelDocInp");
        if (printTrnModel) {
            document.getElementById("cbPrintTrnModel").checked = (printTrnModel == 1) ? (true) : (false);
        }
        // Fast Report 
        if (ModuleSettings && ModuleSettings.Documents && ModuleSettings.Documents.EnhancePrint == true) {
            var vodList = document.getElementById("VobList");
            if (vodList.selectedIndex >= 0 && vodList.options[vodList.selectedIndex].frt) {
                document.getElementById("__FR_TMPL").value = vodList.options[vodList.selectedIndex].frt;
                document.getElementById("__FR_BM").value = (document.getElementById("cbPrintTrnModel").checked) ? (1) : (0);
                document.getElementById("btFR_PDF").style.visibility = 'visible';
            }
        }
    }
}
//Розбор назначения по-умолчанию
function reTransNazn(form) {
    if (form.Nazn.disabled)
        return;
    if (null == webService.Doc)
        webService.useService("DocService.asmx?wsdl", "Doc");
    webService.Doc.callService(onTransNazn, "TransNazn", form.__NAZN.value, document.getElementById("__TT").value, form.Nls_A.value, form.Mfo_A.value, form.Kv_A.value, GetValue("SumA") * 100, form.Nls_B.value, form.Mfo_B.value, form.Kv_B.value, GetValue("SumB") * 100, form.__ND.value);
}
function onTransNazn(result) {
    if (result.error)
        alert(LocalizedString('Message5'));
    else
        document.getElementById("NAZN").value = result.value.replace(/\r*\n*/g, '');
}

// попытка вычислить формулу по данным на странице
function CalcFormulaClient(sFormula, pars, vals) {
    pars = new Array();
    vals = new Array();
    // подстановка основных реквизитов
    var main_reqvs = "KVA=Kv_A,NLSA=Nls_A,NAMA=Nam_A,IDA=Id_A,MFOB=Mfo_B,KVB=Kv_B,NLSB=Nls_B,NAMB=Nam_B,IDB=Id_B,SK=Sk,SA=SumA,SB=SumB,S=SumC".split(',');
    for (i = 0; i < main_reqvs.length - 1; i++) {
        var nameInForm = main_reqvs[i].split("=")[0];
        var name = main_reqvs[i].split("=")[1];
        var val = document.getElementById(name).value;
        sFormula = sFormula.replace("#(" + nameInForm + ")", val);
    }
    sFormula = sFormula.replace("#(TT)", document.getElementById("__TT").value);
    // подстановка все доп. реквизитов
    var reqvs = document.getElementById("Drecs_ids").value.split(',');
    for (i = 0; i < reqvs.length - 1; i++) {
        var val = trim(document.getElementById(reqvs[i]).value);
        var name = trim(reqvs[i].replace('reqv_', '').toUpperCase());
        pars.push(name); vals.push(val);
        while (sFormula.indexOf("#(" + name + ")") >= 0)
            sFormula = sFormula.replace("#(" + name + ")", val);
    }
    return sFormula;
}

// Формула суммы
var cur_sumelem = null;
function Sum_Calc(formula, form, elem) {
    var result = formula;
    var pars = new Array();
    var vals = new Array();
    result = CalcFormulaClient(result, pars, vals);
    try {
        result = eval(result);
        SetValue(elem.id, result);
    }
    catch (e) {
        cur_sumelem = elem.id;

        //webService.Doc.callService(onSum_Calc, "FormulaCalc", result, pars, vals);
        var callObj = webService.createCallOptions();
        callObj.async = false;
        callObj.funcName = "FormulaCalc";
        callObj.params = new Array();
        callObj.params.Formula = result;
        callObj.params.pars = pars;
        callObj.params.vals = vals;
        result = webService.Doc.callService(callObj);
        if (result.error) return;
        var sum = result.value;
        if (!sum) return;
        var dig = 2;
        if (cur_sumelem == "SumB")
            dig = (document.getElementById("__DIGB").value == "") ? (2) : (document.getElementById("__DIGB").value);
        else
            dig = (document.getElementById("__DIGA").value == "") ? (2) : (document.getElementById("__DIGA").value);
        sum = Math.pow(10, dig * (-1)) * sum;
        SetValue(cur_sumelem, sum);
    }

    if (elem.id == "SumA" || elem.id == "SumB") CrossCalc();
}
function onSum_Calc(result) {
    if (result.error) return;
    var sum = result.value;
    if (!sum) return;
    var dig_a = (document.getElementById("__DIGA").value == "") ? (2) : (document.getElementById("__DIGA").value);
    sum = Math.pow(10, dig_a * (-1)) * sum;
    SetValue(cur_sumelem, sum);
    if (cur_sumelem == "SumA" || cur_sumelem == "SumB") CrossCalc();
}

function CrossCalc() {
    var elemA = GetValue("SumA");
    var elemB = GetValue("SumB");
    if (elemA > 0 && elemB > 0)
        SetValue("CrossRat", elemB / elemA);
}

function SumFormulaCalc() {
    // SumA 
    var elem = document.getElementById("SumA");
    if (elem.formula)
        Sum_Calc(elem.formula, document.forms[0], elem);
    // SumB 
    var elem = document.getElementById("SumB");
    if (elem.formula)
        Sum_Calc(elem.formula, document.forms[0], elem);
    // SumC 
    var elem = document.getElementById("SumC");
    if (elem.formula)
        Sum_Calc(elem.formula, document.forms[0], elem);
}

function NaznCalc(retry) {
    // Вычисляем формулы суммы
    SumFormulaCalc();

    if (!document.getElementById("Nazn").formula)
        document.getElementById("Nazn").formula = document.getElementById("Nazn").value;
    var result = document.getElementById("Nazn").formula;
    if (!retry && document.getElementById("Nazn").value.indexOf("#(") < 0) return;
    var reqvs = document.getElementById("Drecs_ids").value.split(',');
    for (i = 0; i < reqvs.length - 1; i++) {
        var val = document.getElementById(reqvs[i]).value;
        var name = reqvs[i].replace('reqv_', '').toUpperCase();
        while (result.indexOf("#(" + name + ")") >= 0)
            result = result.replace("#(" + name + ")", val);
    }
    // Поиск выражений типа #{XXX} и попытка их вычисления
    var formulaRe = /#\{(\S*)\}/g;
    while ((resultRe = formulaRe.exec(result)) != null) {
        try {
            var exp = eval(resultRe[1]);
            result = result.replace(resultRe[0], exp);
        }
        catch (e) { }
    }

    if (result.length > 160)
        result = result.substr(0, 160);
    document.getElementById("Nazn").value = result;
}

function attachReqvFunc() {
    var formulaNlsA = (document.getElementById("Nls_A").formula) ? (document.getElementById("Nls_A").formula) : ("");
    var formulaNlsB = (document.getElementById("Nls_B").formula) ? (document.getElementById("Nls_B").formula) : ("");
    var formulaNazn = document.getElementById("Nazn").value;
    if (formulaNlsA.indexOf('#') >= 0 || formulaNlsB.indexOf('#') >= 0 || formulaNazn.indexOf('#') >= 0) {
        var reqvs = document.getElementById("Drecs_ids").value.split(',');
        for (i = 0; i < reqvs.length - 1; i++) {
            var name = "#(" + reqvs[i].replace('reqv_', '') + ")";
            if (formulaNlsA.indexOf(name) >= 0)
                document.getElementById(reqvs[i]).attachEvent("onchange", NlsACalcOnReqv);
            if (formulaNlsB.indexOf(name) >= 0)
                document.getElementById(reqvs[i]).attachEvent("onchange", NlsCalcOnReqv);
            if (formulaNazn.indexOf(name) >= 0)
                document.getElementById(reqvs[i]).attachEvent("onchange", NaznCalcOnReqv);
        }
    }

    var formulaSumA = (document.getElementById("SumA").formula) ? (document.getElementById("SumA").formula) : ("");
    var formulaSumB = (document.getElementById("SumB").formula) ? (document.getElementById("SumB").formula) : ("");
    var formulaSumC = (document.getElementById("SumC").formula) ? (document.getElementById("SumC").formula) : ("");
    var formulaSum = formulaSumA + formulaSumB + formulaSumC;
    if (formulaSum.indexOf('#') >= 0) {
        var main_reqvs = "ND=DocN,KVA=Kv_A,NLSA=Nls_A,NAMA=Nam_A,IDA=Id_A,MFOB=Mfo_B,KVB=Kv_B,NLSB=Nls_B,NAMB=Nam_B,IDB=Id_B,SK=Sk,SA=SumA,SB=SumB,S=SumC".split(',');
        for (i = 0; i < main_reqvs.length - 1; i++) {
            var nameInForm = main_reqvs[i].split("=")[0];
            var name = main_reqvs[i].split("=")[1];
            var val = document.getElementById(name).value;
            if (formulaSum.indexOf(nameInForm))
                document.getElementById(name).attachEvent("onchange", SumFormulaCalc);
        }
    }
}

// Расчет формулы счета по доп-реквизиту (NlsB)
function NlsCalcOnReqv() {
    var elem = event.srcElement;
    if (elem.value != "") {
        var formula = document.getElementById("Nls_B").formula;
        var reqvs = document.getElementById("Drecs_ids").value.split(',');
        var pars = new Array();
        var vals = new Array();
        for (i = 0; i < reqvs.length - 1; i++) {
            var name = "#(" + reqvs[i].replace('reqv_', '') + ")";
            if (formula.indexOf(name) >= 0) {
                pars.push(reqvs[i].replace('reqv_', ''));
                vals.push(document.getElementById(reqvs[i]).value);
            }
        }
        webService.Doc.callService(onFormulaCalcNlsB, "FormulaCalc", formula, pars, vals);
    }
}
function onFormulaCalcNlsB(result) {
    if (result.error) return;
    var nlsB = result.value;
    var isRO = document.getElementById("Nls_B").readOnly;
    document.getElementById("Nls_B").value = nlsB;
    if (isRO) document.getElementById("Nls_B").readOnly = false;
    document.getElementById("Nls_B").fireEvent("onblur");
    if (isRO) document.getElementById("Nls_B").readOnly = true;
}

// Расчет формулы счета по доп-реквизиту (NlsA)
function NlsACalcOnReqv() {
    var elem = event.srcElement;
    if (elem.value != "") {
        var formula = document.getElementById("Nls_A").formula;
        var reqvs = document.getElementById("Drecs_ids").value.split(',');
        var pars = new Array();
        var vals = new Array();
        for (i = 0; i < reqvs.length - 1; i++) {
            var name = "#(" + reqvs[i].replace('reqv_', '') + ")";
            if (formula.indexOf(name) >= 0) {
                pars.push(reqvs[i].replace('reqv_', ''));
                vals.push(document.getElementById(reqvs[i]).value);
            }
        }
        webService.Doc.callService(onFormulaCalcNlsA, "FormulaCalc", formula, pars, vals);
    }
}
function onFormulaCalcNlsA(result) {
    if (result.error) return;
    var nlsA = result.value;
    var isRO = document.getElementById("Nls_A").readOnly;
    document.getElementById("Nls_A").value = nlsA;
    if (isRO) document.getElementById("Nls_A").readOnly = false;
    document.getElementById("Nls_A").fireEvent("onblur");
    if (isRO) document.getElementById("Nls_A").readOnly = true;
}

// Расчет формулы назначения по доп-реквизиту
function NaznCalcOnReqv() {
    if (!document.getElementById("Nazn").formula)
        document.getElementById("Nazn").formula = document.getElementById("Nazn").value;
    var elem = event.srcElement;
    if (elem.value != "") {
        var formula = document.getElementById("Nazn").formula;
        var reqvs = document.getElementById("Drecs_ids").value.split(',');
        var pars = new Array();
        var vals = new Array();
        for (i = 0; i < reqvs.length - 1; i++) {
            var name = "#(" + reqvs[i].replace('reqv_', '') + ")";
            if (formula.indexOf(name) >= 0) {
                pars.push(reqvs[i].replace('reqv_', ''));
                vals.push(document.getElementById(reqvs[i]).value);
            }
        }
        webService.Doc.callService(onFormulaCalcNazn, "FormulaCalc", formula, pars, vals);
    }
}
function onFormulaCalcNazn(result) {
    if (result.error) {
        NaznCalc(true);
        return;
    }
    var nazn = result.value;
    document.getElementById("Nazn").value = nazn;
}

//Работа с номиналом
function Nom_Calc(formula, form) {
    var elem = GetValue("CrossRat");
    var denom = 100;
    if (document.getElementById("__DIGA").value == "3")
        denom = 1000;

    if (elem != 0)
        webService.Doc.callService(onTransNom, "TransNom", formula, elem * denom, document.getElementById("__TT").value, form.Nls_A.value, form.Mfo_A.value, form.Kv_A.value, GetValue("SumA") * denom, form.Nls_B.value, form.Mfo_B.value, form.Kv_B.value, GetValue("SumB") * denom, form.__ND.value);
}
function onTransNom(result) {
    if (!getError(result, true)) return;
    if (result.error)
        alert(LocalizedString('Message6') + "\nTrace:" + result.errorDetail.string);
    else {
        var denom = 100;
        if (document.getElementById("__DIGA").value == "3")
            denom = 1000;

        var sum = parseFloat(result.value) / denom;
        SetValue("SumC", sum);
        document.getElementById("SumC").focus();
    }
}
//Ввод такого же документа
function SameDoc() {
    location.reload();
}
//Печать тикета
var window_print;
var key = "print_now&";
function PrintDoc() {
    if (window_print) window_print.close();
    var ref = document.getElementById("__DOCREF").value;
    if ("" != ref)
        webService.Doc.callService(onPrint, "GetFileForPrint", ref, document.getElementById("cbPrintTrnModel").checked);
}
function onPrint(result) {
    if (!getError(result)) return;
    var top = window.screen.height / 2 - 100;
    var left = window.screen.width / 2 - 180;
    if ("" == key) top = window.screen.height / 2 - 100;
    var filename = result.value;
    if (document.getElementById("__TICTOFILE").value == '2')
        barsie$print(filename);
    else
        window_print = window.open("dialog.aspx?" + key + "type=print_tic&filename=" + filename, "", "height=200px,width=350px,status=no,toolbar=no,menubar=no,location=no,left=" + left + ",top=" + top);
    key = "print_now&";
}

function PrintDocMatrixPrinter() {
    var ref = document.getElementById("__DOCREF").value;
    if ("" != ref)
        webService.Doc.callService(onPrintDocMatrixPrinter, "GetFileForPrint", ref);
}
function onPrintDocMatrixPrinter(result) {
    if (!getError(result)) return;
    var filename = result.value;
    PrintMatrPrinter(filename);
}

// Показать банковские проводки
function ShowBuhModel() {
    var ref = document.getElementById("__DOCREF").value;
    if ("" != ref)
        window.showModalDialog("/barsroot/documentview/buhmodel.aspx?ref=" + ref, "", "dialogHeight:500px;dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
}

function MenuPrint() {
    PrintDoc();
    key = "";
}

function capitaliseFirstLetter(string) {
    string = trim(string).replace(/ /g, '');
    return string.toUpperCase();
}
function setFio() {
    var suname = capitaliseFirstLetter(document.getElementById('part_FIO_SURNAME').value);
    var alphaExp = /^[a-zA-Zа-яА-Яа-яА-ЯіІїЇєЄ]{0,1}[a-zA-Zа-яА-Яа-яА-ЯіІїЇєЄ\-\`\']{1,69}$/;
    if (event.srcElement.id == "part_FIO_SURNAME" && suname.length > 0 && (suname.length < 2 || !suname.match(alphaExp))) {
        alert("Прізвище має бути більше 1-го символу та містити лише літери");
        suname = '';
        document.getElementById('part_FIO_SURNAME').value = suname;
        document.getElementById('part_FIO_SURNAME').focus();    
    }

    var name = capitaliseFirstLetter(document.getElementById('part_FIO_NAME').value);
    if (event.srcElement.id == "part_FIO_NAME" && name.length > 0 && (name.length < 2 || !name.match(alphaExp))) {
        alert("Ім'я має бути більше 1-го символу та містити лише літери");
        name = '';
        document.getElementById('part_FIO_NAME').value = name;
        document.getElementById('part_FIO_NAME').focus();
    }
    var patronym = capitaliseFirstLetter(document.getElementById('part_FIO_PATR').value);
    if (event.srcElement.id == "part_FIO_PATR" && patronym.length > 0 && (patronym.length < 2 || !patronym.match(alphaExp))) {
        alert("По-батькові має бути більше 1-го символу та містити лише літери");
        patronym = '';
        document.getElementById('part_FIO_PATR').value = patronym;
        document.getElementById('part_FIO_PATR').focus();
    }
    document.getElementById("reqv_FIO").value = suname + " " + name + " " + patronym;
}

//Для работы с полями-справочниками
function AttachFocus(elem) {
    elem.attachEvent("onfocusin", ShowF12);
    elem.attachEvent("onfocusout", HideF12);
}
function SetOnFocusLogic(str) {
    var controls = str.split(',');
    for (i = 0; i < controls.length; i++)
        if (document.getElementById(controls[i]))
            document.getElementById(controls[i]).attachEvent("onfocusin", hf12);
}

function ShowF12() {
    if (!event.srcElement.readOnly) {
        document.getElementById("bf12").style.visibility = "visible";
        document.getElementById("dF12").style.left = 586;
        var range = event.srcElement.createTextRange();
        document.getElementById("dF12").style.top = range.boundingTop + document.body.scrollTop - 3;
        document.getElementById("dF12").style.visibility = "visible";
    }
}
var lastElementForF12;
function HideF12() {
    lastElementForF12 = event.srcElement;
    document.getElementById("dF12").style.visibility = "hidden";
}
function hf12() {
    document.getElementById("bf12").style.visibility = "hidden";
}
function pushF12() {
    event.keyCode = 123;
    lastElementForF12.focus();
    lastElementForF12.fireEvent("onkeydown", event);
}
//Показываем справочник
function ShowMetaTable(tabname, sqltail) {
    if (null == sqltail) sqltail = "";
    var result = window.showModalDialog("dialog.aspx?type=metatab&tail=" + sqltail + "&role=wr_doc_input&tabname=" + tabname,
			"",
			"dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
    return result;
}

function textMaxLength(text, maxLength) {
    var maxlength = new Number(maxLength);
    if (text.value.length > maxlength) {
        text.value = text.value.substring(0, maxlength);
        alert(" Довжина поля не більше " + maxlength + " символів.");
    }
}

function CalcPFC() {
    var sum = GetValue("SumB");
    var req = document.getElementById("reqv_SCPFU");
    if (req.formula) {
        var denom = 100;
        if (document.getElementById("__DIGA").value == "3")
            denom = 1000;
        webService.Doc.callService(onCalcPFC, "TransNom", "(" + req.formula + ")",  0, document.getElementById("__TT").value, document.getElementById("Nls_A").value, document.getElementById("Mfo_A").value, document.getElementById("Kv_A").value, GetValue("SumA") * 100, document.getElementById("Nls_B").value, document.getElementById("Mfo_B").value, document.getElementById("Kv_B").value, GetValue("SumB") * denom, document.getElementById("__ND").value);
    } else
        req.value = sum * 1.05;
}
function onCalcPFC(result) {
    if (!getError(result, true)) return;
    var denom = 100;
    if (document.getElementById("__DIGA").value == "3")
        denom = 1000;
    var sum = parseFloat(result.value) / denom;
    document.getElementById("reqv_SCPFU").value = sum;
}

/*************************************************************************/
/***********Tools*********************************************************/
/*************************************************************************/
function getParamFromUrl(param, url) {
    url = url.substring(url.indexOf('?') + 1);
    for (i = 0; i < url.split("&").length; i++)
        if (url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1];
    return "";
}
//Диалоговое окно
function Dialog(message, type) {
    return window.showModalDialog("dialog.aspx?type=" + type + "&message=" + escape(message), "", "dialogHeight:160px;center:yes;edge:sunken;help:no;status:no;");
}
//Обработка ошибок от веб-сервиса
function getError(result, modal) {
    if (result.error) {
        if (window.dialogArguments || parent.frames.length == 0 || modal) {
            window.showModalDialog("dialog.aspx?type=err&" + Math.random(), "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        }
        else
            location.replace("dialog.aspx?type=err&" + Math.random());
        return false;
    }
    return true;
}