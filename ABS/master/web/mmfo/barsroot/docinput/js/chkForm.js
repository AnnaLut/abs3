
function isqdoc() {
    return "" != getParamFromUrl("qdoc", location.search) && "" != getParamFromUrl("rrp_rec", location.search);
};

function GetPublicFlag(rnk) {
    $.ajax({
        type: "POST",
        url: encodeURI("/barsroot/clientregister/defaultWebService.asmx/GetPublicFlagByRnk"),
        data: { rnk: rnk },
        async: false,
        success: function (result) {
            if (result && result.text && result.text != '') {
                alert(result.text);
            }
        }
    })
}

function Validate(form) {
    if (!chkMandDrec(form)) return false;
    if (!chkQDoc(form)) return false;
    if (!chkDrec(form)) return false;
    if (!isFilled(5, form.Nls_A)) return false;
    if (!isFilled(2, form.Kv_A)) return false;
    if (!isFilled(3, form.Nam_A)) return false;
    if (!isFilledOkpo(form.Id_A)) return false;
    if (!isFilled(5, form.Nls_B)) return false;
    if (!isFilled(2, form.Kv_B)) return false;
    if (!isFilled(3, form.Nam_B)) return false;
    if (!isFilledOkpo(form.Id_B)) return false;
    if (!isFilled(3, form.Nazn)) return false;
    NaznCalc();

    if (typeof form !== "undefined" && typeof form.__RNK_A !== "undefined" && typeof form.__RNK_A.value !== "undefined") GetPublicFlag(form.__RNK_A.value);
    if (typeof form !== "undefined" && typeof form.__RNK_B !== "undefined" && typeof form.__RNK_B.value !== "undefined") GetPublicFlag(form.__RNK_B.value);

    // Провека курса валют (что не поменялся за момент первой загрузки формы)
    var l_flags = document.getElementById("__FLAGS").value;
    if (l_flags.substr(65, 1) == "1" && l_flags.substr(11, 1) == "1")
        chkRates(form);

    // Кастомная проверка реквизитов
    if (!chkCustomReq()) return false;

    if (form.Nls_B.value != cDocVkrz(form.Mfo_B.value, form.Nls_B.value)) {
        alert(LocalizedString('Message1'));
        setFocus1(form.Nls_B.name, form); return false;
    }

    if (form.Nazn.value.length > 160) {
        alert(LocalizedString('Message24') + " " + form.Nazn.value.length + " )");
        return false;
    }

    if (!isFilled(1, form.Sk)) return false;
    if (!isFilled(6, form.Mfo_A)) return false;
    if (!isFilled(6, form.Mfo_B)) return false;

    if (!isqdoc()) {
        if (!chkSUM("SumA")) return false;
        if (!chkSUM("SumB")) return false;
        if (!chkSUM("SumC")) return false;
        // временно убрал проверки на дату документа и две даты валютирования(+/- 10 дней от банковской)
        // Сергею Горобцу необходимо реализовать корректную работу с корректирующими проводками,
        // после чего восстановить проверки, см. Centura
        if (!chkDate("DocD_TextBox")) return false;
        if (!chkDate("DatV_TextBox")) return false;
        if (!chkDate("DatV2_TextBox")) return false;
    }

    if (document.getElementById("__VOBCONFIRM").value == '1' && form.VobList.options.length > 1)
        if (Dialog(LocalizedString('Message8') + " <br>'" +
            form.VobList.options[form.VobList.selectedIndex].text +
            "'(VOB=" + form.VobList.options[form.VobList.selectedIndex].value + ")?", "confirm") != 1) return false;

    // show customer verification card, if needed
    if (form.__IS_NEED_CHECK_TT.value == 1) {
        var tt = document.getElementById("__TT").value;
        var ttCheckedRes = CheckTTForPayVerification(tt);
        if (ttCheckedRes) {
            var rnk = form.__RNK_A.value;
            var result = window.showModalDialog(encodeURI('/barsroot/PaymentVerification/PaymentVerification?rnk=' + rnk),
                null, 'dialogWidth: 640px; dialogHeight: 480px; center: yes; status: no');
            if (!result) {
                return;
            }
        }
    }

    //    Перевірка на блокування рахунків 2625, 2605     (COBUMMFO-3907)
    var nls = form.__DK.value != 0 ? form.Nls_A.value : form.Nls_B.value;
    var maskAcc = nls.slice(0, 4);
    if (maskAcc == "2625" || maskAcc == "2605") {
        if (null == webService.Doc) webService.useService("DocService.asmx?wsdl", "Doc");
        var callObj = webService.createCallOptions();
        callObj.async = false;
        callObj.funcName = "checkAcc";
        callObj.params = new Array();
        callObj.params.acc = nls;
        var result = webService.Doc.callService(callObj);
        if (result.error || result.value[0] == "1") {
            if (result.value[1] == "" || result.value[1] == null) {
                if (!confirm("Рахунок " + nls + " заблоковано. Бажаєте продовжити?")) {
                    return false;
                }
            }
            else {
                alert(result.value[1]);
                return false;
            }
        }
    }

    if (!(document.getElementById("btPayIt").disabled = AskBeforePay())) return false;

    // новый режим работы с подпись
    if (document.getElementById("__SIGN_MIXED_MODE").value === "1") {
        signDocMixedMode(form, function (result) {
            document.getElementById("btPayIt").disabled = true;
            callOplDoc(form, result);
        },
            function (errorText) {
                document.getElementById("btPayIt").disabled = false;
                alert(errorText);
            });
    }
    else { // все по старому
        if (!(document.getElementById("btPayIt").disabled = signDoc(form))) return false;
        callOplDoc(form);
    }

    return false;
}
/*Trim for string */
//-------------------------------------
function trim(stringToTrim) {
    if (stringToTrim)
        return stringToTrim.replace(/^\s+|\s+$/g, "");
    else return "";
}
function ltrim(stringToTrim) {
    if (stringToTrim)
        return stringToTrim.replace(/^\s+/, "");
    else return "";
}
function isEmpty(src) {
    return trim(src.toString()) == '';
}
//-------------------------------------
function chkRates(form) {
    var ratePrev = GetValue("CrossRat");
    cDocHand(5, form);
    var rateNew = GetValue("CrossRat");
    if (ratePrev != rateNew)
        alert("Увага!\nЗа час вводу документу змінився курс.\nСтаре значення: " + ratePrev + "\nНове  значення: " + rateNew + "\nЗначення суми буде автоматично перераховано.");
}

//-------------------------------------
function chkDate(name) {
    var elem = document.getElementById(name);
    if (!elem) return true;
    // При корректирующих проводках не проверяем дату
    var vobList = document.getElementById("VobList");
    if (vobList.options.length > 0) {
        if (vobList.options[vobList.selectedIndex].value == "96" ||
            vobList.options[vobList.selectedIndex].value == "99")
            return true;
    }

    var s_bdate = document.getElementById("__BDATE").value;
    var bdate = new Date("20" + s_bdate.substr(0, 2), parseFloat(s_bdate.substr(2, 2)) - 1, s_bdate.substr(4, 2));
    var curdate = new Date(elem.value.substr(6, 4), parseFloat(elem.value.substr(3, 2)) - 1, elem.value.substr(0, 2));
    var before10days = new Date(bdate);
    var after10days = new Date(bdate);
    before10days.setDate(bdate.getDate() - 30);
    after10days.setDate(bdate.getDate() + 30);
    if (curdate > after10days || curdate < before10days) {
        alert(LocalizedString('Message32'));
        elem.focus();
        return false;
    }
    //Предупреждение, если дата валютирования отличается от текущей
    if (name.indexOf("DatV") >= 0 && bdate.toDateString() != curdate.toDateString()) {
        var res = confirm(LocalizedString('Message33'));
        if (res == 0) {
            elem.focus();
            return false;
        }
    }

    return true;
}

//проверка данных для информационных зарпосов
function chkQDoc(form) {
    //сие условие однозначно идентифицирует информационный запрос
    if ("" != getParamFromUrl("qdoc", location.search) && "" != getParamFromUrl("rrp_rec", location.search)) {
        var qDoc = decodeURIComponent(getParamFromUrl("qdoc", location.search));

        //проверка допустимых значений для параметра qDoc
        if ("+" != qDoc && "-" != qDoc && "!" != qDoc && "?" != qDoc && "*" != qDoc)
            return false;

        //Если данный параметр не равен знаку вопроса, то ничего делать не нужно
        //Все уже сделано в форме qDocs и нужно просто принять документ
        if ("?" != qDoc)
            return true;

        var old_NlsB = getParamFromUrl("nls_b", location.search);
        var old_IdB = getParamFromUrl("id_b", location.search);
        var new_NlsB = form.Nls_B.value;
        var new_IdB = form.Id_B.value;

        var dRec = "";
        var dRecElement = document.getElementById("?");
        if (null != dRecElement)
            dRec = dRecElement.value;

        if (21 != dRec.length) {
            //Ошибка определения доп. реквизита СЭП
            alert(LocalizedString('Message30'));
            return false;
        }

        if (old_NlsB != new_NlsB && old_IdB != new_IdB) {
            //запрос на возврат документа
            if (Dialog(LocalizedString('Message29'), "confirm") != 1) return false;

            var newLink = location.href;

            newLink = newLink.replace("?qdoc=" + getParamFromUrl("qdoc", location.search),
                "?qdoc=" + encodeURIComponent("-"));

            newLink = newLink.replace("&tt=" + document.getElementById("__TT").value,
                "&tt=" + form.qDocsTT_dk2.value);

            newLink = newLink.replace("&nazn=" + getParamFromUrl("nazn", location.search),
                "&nazn=" + encodeURIComponent(form.qDocsNaznReturn.value));

            newLink = newLink.replace("&drec_?=" + getParamFromUrl("drec_?", location.search),
                "&drec_-=" + encodeURIComponent(dRec.replace("?", "-")));

            location.replace(newLink);
            return false;
        }
        else if (old_NlsB != new_NlsB) {
            //уточнение счета получателя  
            if (Dialog(LocalizedString('Message28'), "confirm") != 1) return false;
            dRecElement.value = dRec.replace("?", "+");
            form.Nazn.value = form.qDocsNaznNls.value;
            return true;
        }
        else if (old_IdB != new_IdB) {
            //уточнение кода получателя
            if (Dialog(LocalizedString('Message27'), "confirm") != 1) return false;
            dRecElement.value = dRec.replace("?", "!");
            form.Nazn.value = form.qDocsNaznOkpo.value;
            return true;
        }
        else {
            //счет и код получателя в норме, предложить удалить информационный запрос
            if (Dialog(LocalizedString('Message26'), "confirm") != 1) return false;
            location.replace("/barsroot/qdocs/default.aspx?rrp_rec=" + getParamFromUrl("rrp_rec", location.search));
        }

    }
    return true;
}

function chkOst() {
    if (document.getElementById("SumC").style.visibility == 'hidden') return true;
    var sum = GetValue("SumC");
    var ost = GetValue("tbOst");
    if (parseFloat(ost) < parseFloat(sum)) {
        if (Dialog(LocalizedString('Message9'), "confirm") == 1) return true;
    }
    else return true;
    document.getElementById("SumC").focus();
    document.getElementById("SumC").select();
    return false;
}

function showLcv(type, lcv) {
    if (document.getElementById("__FLAGS").value.substr(65, 1) == "1") {
        if (type == 0)
            document.getElementById("LabelSumALcv").innerText = lcv;
        else
            document.getElementById("LabelSumBLcv").innerText = lcv;
    }
}

function checkKv(type, form) {
    var elem = (type == 0) ? (form.Kv_A) : (form.Kv_B);
    if (elem.value == "") return false;
    if (null == webService.Doc) webService.useService("DocService.asmx?wsdl", "Doc");
    var callObj = webService.createCallOptions();
    callObj.async = false;
    callObj.funcName = "checkKV";
    callObj.params = new Array();
    callObj.params.kv = elem.value;
    callObj.params.colname = (isNaN(elem.value)) ? ("lcv") : ("kv");

    var result = webService.Doc.callService(callObj);
    if (result.error || result.value[0] == "") {
        alert(LocalizedString('Message31') + elem.value);
        elem.value = "";
        showLcv(type, "");
        return false;
    }
    else {
        elem.value = result.value[0];
        showLcv(type, result.value[1]);
        var dig = result.value[2];
        if (dig) {
            if (type == 0) form.__DIGA.value = dig;
            if (type == 1) form.__DIGB.value = dig;
            InitSumFields();
        }
    }
    // MultyCurrency
    if (document.getElementById("__FLAGS").value.substr(65, 1) == "1")
        return true;

    //KV_A
    if (type == 0) {
        form.Kv_A.value = form.Kv_A.value.toUpperCase();
        form.Kv_B.value = form.Kv_A.value;
        form.Kv_B.fireEvent("onchange");
    }
    //KV_B
    else if (type == 1) {
        form.Kv_B.value = form.Kv_B.value.toUpperCase();
        form.Kv_A.value = form.Kv_B.value;
        if (form.Nls_B.value != "" && form.Kv_B.value != "") {
            n = 1;
            form.Nls_B.fireEvent("onblur");
            if (form.Mfo_B.value != form.__OURMFO.value) n = 6;
            cDocHand(n, form);
        }
        if (form.Nls_A.value != "" && form.Kv_A.value != "") {
            cDocHand(0, form);
        }
    }
    //EQ
    if (document.getElementById("__FLAGS").value.substr(14, 1) == "1")
        cDocHand(8, form);
}

function isFilled(n, elem) {
    if (elem.style.visibility == 'hidden') return true;
    elem.value = ltrim(elem.value);
    var str = elem.value;
    if (str == null || str.length < n) { alert(elem.title + ".\n" + LocalizedString('Message10') + n + LocalizedString('Message11')); elem.focus(); return false; } else { return true };
}

function isFilledOkpo(elem) {
    if (elem.style.visibility == 'hidden' || elem.readOnly) return true;
    var str = elem.value;
    if (isNaN(str)) { alert(elem.title + ".\n " + LocalizedString('Message12')); return false; }

    if ((str.length > 8 && str.length < 11) || str == '99999')
        return true;

    if (str != null && str.length < 8) {
        str = '00000000'.substring(0, 8 - str.length) + str;
        elem.value = str;
    }
    if (str != '00000000' && str == v_okpo(str))
        return true;
    else { alert(elem.title + ".\n " + LocalizedString('Message13')); elem.focus(); return false; };
}

function v_okpo(okpo) {
    var ln = okpo.length, m7, sum;
    if (ln == 8) {
        if (okpo < '30000000' || okpo > '60000000') m7 = '1234567';
        else m7 = '7123456';
        sum = 0;
        for (i = 0; i < 7; i++) {
            sum = sum + okpo.substr(i, 1) * m7.substr(i, 1);
        }
        kc = sum % 11;
        if (kc == 10) {
            if (okpo < '30000000' || okpo > '60000000') m7 = '3456789';
            else m7 = '9345678';
            sum = 0;
            for (i = 0; i < 7; i++) {
                sum = sum + okpo.substr(i, 1) * m7.substr(i, 1);
            }
            kc = sum % 11;
            if (kc == 10) kc = 0;
        }
        okpon = okpo.substr(0, 7).concat(kc);
    }
    else
        okpon = okpo;
    return okpon;
}

function chkSUM(id) {
    var elem = GetValue(id);
    if (elem > 0 || document.getElementById(id).style.visibility == 'hidden') return true;
    alert(LocalizedString('Message14'));
    document.getElementById(id).focus();
    document.getElementById(id).select();
    return false;
}
//Проверка обязательных допреквизитов
function chkMandDrec(form) {
    //Обязательные поля
    var names = form.document.getElementById("Mand_Drecs_ids").value;
    var pairs = names.split(",");
    for (var i = 0; i < pairs.length - 1; i++) {
        if (form.document.getElementById(pairs[i]).value == "") {
            alert(LocalizedString('Message15'));
            var elem = form.document.getElementById(pairs[i]);
            if (!(elem.disabled || elem.readOnly))
                form.document.getElementById(pairs[i]).focus();
            return false;
        }
    }
    return true;
}

// Специфические проверки реквизитов - хардкод, плохо, но пока по другому никак 
function chkCustomReq(reqName) {
    var checkAll = false;
    if (!reqName)
        checkAll = true;
    if (reqName == 'IDDO' || checkAll) {
        var elem = document.getElementById('reqv_IDDO');
        if (elem && elem.value) {
            var reqDateS = elem.value;
            elem.value = reqDateS.replace(/\//g, '.');
            // проверяем формат даты DD.MM.YYYY
            if (!/^\d{1,2}(\.|\/)\d{1,2}(\.|\/)\d{4}$/.test(reqDateS)) {
                alert('Невірний формат дати реквізиту [Дійсний до (ID-картка)], вкажіть у форматі DD.MM.YYYY');
                elem.value = '';
                return false;
            }
        }
    }
    // Дата рождения DRDAY
    if (reqName == 'DRDAY' || checkAll) {
        var elem = document.getElementById('reqv_DRDAY');
        if (elem && elem.value) {
            var reqDateS = elem.value;
            elem.value = reqDateS.replace(/\//g, '.');
            // проверяем формат даты DD.MM.YYYY
            if (!/^\d{1,2}(\.|\/)\d{1,2}(\.|\/)\d{4}$/.test(reqDateS)) {
                alert('Невірний формат дати реквізиту [Дата народження], вкажіть у форматі DD.MM.YYYY');
                elem.value = '';
                return false;
            }
            // пробуем перевести в Date
            var reqDateD;
            try {
                reqDateD = new Date(reqDateS.substr(6, 4), parseFloat(reqDateS.substr(3, 2)) - 1, reqDateS.substr(0, 2));
            } catch (e) {
                alert('Невірне значення дати реквізиту [Дата народження].');
                elem.value = '';
                return false;
            }
            // Дата документа - строка
            var docDateS = document.getElementById("DocD_TextBox").value;
            // Дата документа - дата
            var docDateD = new Date(docDateS.substr(6, 4), parseFloat(docDateS.substr(3, 2)) - 1, docDateS.substr(0, 2));
            // разниница дат
            var diff = Math.floor(docDateD.getTime() - reqDateD.getTime());
            if (diff < 0) {
                alert('Невірне значення реквізиту [Дата народження] - дата народження більша за дату документа.');
                elem.value = '';
                return false;
            }
            var day = 1000 * 60 * 60 * 24;
            var days = diff / day;
            // 5 843.87518 - 16 років
            if (days < 5844) {
                alert('Невірне значення реквізиту [Дата народження] - різниця з датою документа менше 16 років.');
                elem.value = '';
                return false;
            }
            // 36 524.2199 - 100 років
            else if (days > 36524) {
                alert('Невірне значення реквізиту [Дата народження] - різниця з датою документа більше 100 років.');
                elem.value = '';
                return false;
            }
        }
    }

    // Проверки по SWIFT
    var flagEnhCheck = (ModuleSettings && ModuleSettings.Documents && ModuleSettings.Documents.EnhanceSwiftCheck == true);
    var isSwt = document.getElementById("reqv_f") && document.getElementById("reqv_f").value == "MT 103";
    if (flagEnhCheck && isSwt && document.getElementById('reqv_57D')) {
        if (!document.getElementById('reqv_57D').value && document.getElementById('Kv_A').value == "643") {
            alert('Для SWIFT платежу у валюті 643 потрібно вказати реквізит 57D.');
            document.getElementById('reqv_57D').focus();
            return false;
        }
    }

    return true;
}

//Проверка доп. реквизитов по полю chkr + формирование значения drec
function chkDrec(form) {
    var names = form.document.getElementById("Drecs_ids").value;
    var pairs = names.split(",");
    if (null == webService.Doc) webService.useService("DocService.asmx?wsdl", "Doc");
    var callObj = webService.createCallOptions();
    callObj.async = false;
    callObj.funcName = "CheckDopReq";
    // Очищаем поле Drec
    var drec = form.Drec.value;
    form.Drec.value = "";
    for (var i = pairs.length - 2; i >= 0; i--) {
        var reqEl = form.document.getElementById(pairs[i]);
        if (document.getElementsByName(pairs[i]).length > 1) {
            for (j = 0; j < document.getElementsByName(pairs[i]).length; j++) {
                reqEl = document.getElementsByName(pairs[i])[j];
                if (reqEl.tag == pairs[i].replace('reqv_', '')) break;
            }
        }

        // Вичисление значений для доп. реквизита (Drec)
        var vspo = trim(reqEl.vspo).substr(0, 1);
        var val = trim(reqEl.value);
        if (!isEmpty(vspo) && !isEmpty(val) && vspo != "F" && vspo != "П" && vspo != "C") {
            if (isqdoc())
                form.Drec.value = val;
            else {
                // ставим спереди
                if (vspo == "f")
                    form.Drec.value = "#" + vspo + val + form.Drec.value;
                else
                    form.Drec.value += "#" + vspo + val;
            }
        }
        if (reqEl.checker && reqEl.checker != "" && reqEl.value != "" && !(reqEl.disabled || reqEl.readOnly)) {
            callObj.params = new Array();
            callObj.params.Checker = reqEl.checker;
            callObj.params.Tag = pairs[i].replace("reqv_", "").replace("$", "");
            callObj.params.Val = reqEl.value;
            callObj.params.TT = document.getElementById("__TT").value;
            callObj.params.NlsA = form.Nls_A.value;
            callObj.params.BankA = form.Mfo_A.value;
            callObj.params.KvA = form.Kv_A.value;
            callObj.params.SA = rigthMult(GetValue("SumA"), Math.pow(10, document.getElementById("__DIGA").value));
            callObj.params.NlsB = form.Nls_B.value;
            callObj.params.BankB = form.Mfo_B.value;
            callObj.params.KvB = form.Kv_B.value;
            callObj.params.SB = rigthMult(GetValue("SumB"), Math.pow(10, document.getElementById("__DIGB").value));
            var result = webService.Doc.callService(callObj);
            if (result.error || result.value == "0") {
                // пропускаем проверку для реквизита в 980 валюте
                if (callObj.params.Tag == "D6#70" && callObj.params.KvA == 980)
                    continue;
                alert(LocalizedString('Message16'));
                if (!(reqEl.disabled || reqEl.readOnly)) {
                    reqEl.focus();
                    reqEl.select();
                }
                return false;
            }
        }
    }

    if (!isEmpty(form.Drec.value) && !isqdoc())
        form.Drec.value += "#";
    if (!isEmpty(form.Drec.value))
        form.NaznS.value = '11';
    else
        form.NaznS.value = '10';

    if (isEmpty(form.Drec.value) && !isEmpty(drec)) {
        // Якщо поля Nls_B та Id_B не змінювалися, повертаємо в форму значення Drec та сповіщуємо про необхідність внесення змін в OKPO чи MFO
        if (form.__Nls_B.value === form.Nls_B.value && form.__Id_B.value === form.Id_B.value) {
            form.Drec.value = drec;
            if (form.__DK.value == 2 || form.__DK.value == 3) {
                alert(LocalizedString("Message34"));
                return false;
            }
        }
        // Якщо змінилися і Nls_B і Id_B
        if (form.__Nls_B.value !== form.Nls_B.value && form.__Id_B.value !== form.Id_B.value) {
            form.Drec.value = drec.replace(drec.charAt(1), "-");
            form.__DK.value = 2;
            return true;
        }
        // Якщо змінилося лише поле Nls_B
        if (form.__Nls_B.value !== form.Nls_B.value) {
            form.Drec.value = drec.replace(drec.charAt(1), "+");
            form.__DK.value = 3;
            return true;
        }
        // Якщо змінилося лише поле Id_B
        if (form.__Id_B.value !== form.Id_B.value) {
            form.Drec.value = drec.replace(drec.charAt(1), "!");
            form.__DK.value = 3;
            return true;
        }
    }

    return true;
}

function AskBeforePay() {
    var paramlist = "?";
    var kop_a = Math.pow(10, document.getElementById("__DIGA").value);
    var kop_b = Math.pow(10, document.getElementById("__DIGB").value);
    var elem = GetValue("SumC");
    var height = 250;
    if (elem > 0) {
        paramlist += "Sum=" + Math.round(elem * kop_a)
            + "&Kv=" + document.getElementById("Kv_A").value;
    } else {
        var elemA = GetValue("SumA");
        var elemB = GetValue("SumB");
        if (elemA > 0 && elemB > 0) {
            paramlist += "SumA=" + Math.round(elemA * kop_a)
                + "&KvA=" + document.getElementById("Kv_A").value;
            paramlist += "&SumB=" + Math.round(elemB * kop_b)
                + "&KvB=" + document.getElementById("Kv_B").value;
        } else {
            alert(LocalizedString('Message17'));
            return false;
        }
    }
    // не проверять красное сальдо и блокировку
    var flag38 = document.getElementById("__FLAGS").value.substr(38, 1);
    if (document.getElementById("__WARNPAY").value != "" && flag38 == "0") {
        var fli = (document.getElementById("Mfo_A").value == document.getElementById("Mfo_B").value) ? (1) : (0);
        var fplan = document.getElementById("__FLAGS").value.substr(37, 1);
        var dk = document.getElementById("__DK").value;
        var nlsa = document.getElementById("Nls_A").value;
        var nlsb = document.getElementById("Nls_B").value;
        paramlist += "&fPlan=" + fplan + "&fli=" + fli + "&dk=" + dk + "&nlsA=" + nlsa + "&nlsB=" + nlsb + "&" + Math.random();
        height = 400;
    }
    var result = window.showModalDialog("AskBeforePay.aspx" + paramlist, null,
        "dialogWidth:500px; dialogHeight:" + height + "px; center:yes; status:no; resizable:yes; help:no;");
    return result;
}

// проверка символа кассового плана
// и подтягивание расшифровки в назначение платежа
function chkCashSymbol() {
    var eSK = document.getElementById("Sk");
    if (eSK.style.visibility == "hidden") return true;
    var eDK = document.getElementById("__DK");
    if ("" == eSK.value) return false;
    var vSK = parseInt(eSK.value);
    var vDK = parseInt(eDK.value);
    if ((0 == vDK || 2 == vDK) && vSK < 40
        || (1 == vDK || 3 == vDK) && vSK >= 40) {
        var isOk = cDocHand(4, eSK.form);
        if (!isOk) {
            eSK.focus();
            eSK.select();
            return false;
        }
    }
    else if (isNaN(vSK)) {
        alert(LocalizedString('Message18'));
        eSK.focus();
        eSK.select();
        return false;
    }
    else {
        alert(LocalizedString('Message19'));
        eSK.focus();
        eSK.select();
        return false;
    }
    return true;
}
// проверка символа кассового плана
function chkCashSymbol_link(ctrl_nazn) {
    var eSK = event.srcElement;
    if (eSK.style.visibility == "hidden") return true;
    var eDK = document.getElementById("__DK");
    if ("" == eSK.value) return false;
    var vSK = parseInt(eSK.value);
    var vDK = parseInt(eDK.value);
    if ((0 == vDK || 2 == vDK) && vSK < 40
        || (1 == vDK || 3 == vDK) && vSK >= 40) {
        var isOk = cDocHand_link(eSK.form, 4, event.srcElement, ctrl_nazn);
        if (!isOk) {
            eSK.focus();
            eSK.select();
            return false;
        }
    }
    else if (isNaN(vSK)) {
        alert(LocalizedString('Message18'));
        eSK.focus();
        eSK.select();
        return false;
    }
    else {
        alert(LocalizedString('Message19'));
        eSK.focus();
        eSK.select();
        return false;
    }
    return true;
}

// сервис для символа кассового плана
function selectCashSymbol(evt) {
    if (evt.srcElement.readOnly) return;
    var charCode = getCharCode(evt);
    var VK_F12 = 123;
    if (VK_F12 == charCode) {
        var tail = "'sk>=40 and d_close is null'";
        var dk = document.getElementById("__DK").value;
        if (0 == dk || 2 == dk)
            tail = "'-sk>-40 and d_close is null'";
        var result = ShowMetaTable('sk', tail);
        if (result != null) {
            document.getElementById("Sk").value = result[0];
            if (document.getElementById("NAZN").value == "")
                document.getElementById("NAZN").value = result[1];
        }
    }
}
// сервис для символа кассового плана
function selectCashSymbol_link(ctrl_nazn) {
    if (event.srcElement.readOnly) return;
    var charCode = getCharCode(event);
    var VK_F12 = 123;
    if (VK_F12 == charCode) {
        var tail = "'sk>=40 and d_close is null'";
        var dk = document.getElementById("__DK").value;
        if (0 == dk || 2 == dk)
            tail = "'-sk>-40 and d_close is null'";
        var result = ShowMetaTable('sk', tail);
        if (result != null) {
            event.srcElement.value = result[0];
            if (!ctrl_nazn.value)
                ctrl_nazn.value = result[1];
        }
    }
}

function selectAccounts(evt, elem, fl) {
    if (elem.readOnly) return;
    var charCode = getCharCode(evt);
    var VK_F12 = 123;
    var e_n = 1;
    if ("Nls_B" == elem.id) e_n = 2;
    if (VK_F12 == charCode) {
        var mfo, kv;
        var dk = document.getElementById("__DK").value;
        var type = "";
        if (e_n == 1) {
            mfo = document.getElementById("Mfo_A").value;
            kv = document.getElementById("Kv_A").value;
            if (false == document.getElementById("Mfo_A").readOnly || fl == 0) type = -1;
            else type = (1 != dk) ? (1) : (0);
        }
        else {
            mfo = document.getElementById("Mfo_B").value;
            kv = document.getElementById("Kv_B").value;
            if (false == document.getElementById("Mfo_B").readOnly || fl == 0) type = -1;
            else type = (0 != dk) ? (1) : (0);
        }
        var tt = document.getElementById("__TT").value;
        var result = window.showModalDialog("dialog.aspx?type=metatab_base&role=wr_doc_input&dk=" + type + "&nls=" + elem.value + "&mfo=" + mfo + "&kv=" + kv + "&tt=" + tt,
            window,
            "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result != null) {
            if (1 == e_n) {
                if (-1 != type) {
                    document.getElementById("Nls_A").value = result[0];
                    if ("" == kv)
                        document.getElementById("Kv_A").value = result[1];
                }
                else {
                    if ("" == document.getElementById("Mfo_A").value)
                        document.getElementById("Mfo_A").value = result[0];
                    document.getElementById("Nls_A").value = result[1];
                }
            }
            else if (2 == e_n) {
                if (-1 != type) {
                    document.getElementById("Nls_B").value = result[0];
                    if ("" == kv)
                        document.getElementById("Kv_B").value = result[1];
                }
                else {
                    if ("" == document.getElementById("Mfo_B").value)
                        document.getElementById("Mfo_B").value = result[0];
                    document.getElementById("Nls_B").value = result[1];
                    document.getElementById("Nam_B").value = result[2];
                    document.getElementById("Id_B").value = result[3];
                    if ("" == kv)
                        document.getElementById("Kv_B").value = result[4];
                }
            }
        }
    }
}

function selectMfo(evt) {
    if (evt.srcElement.readOnly) return;
    var charCode = getCharCode(evt);
    var VK_F12 = 123;
    if (VK_F12 == charCode) {
        var tail = "''";
        var result = ShowMetaTable('banks', tail);
        if (result != null) {
            document.getElementById("Mfo_B").value = result[0];
            document.getElementById("Bank_B").value = result[1];
        }
    }
}

function selectNazn(evt) {
    var charCode = getCharCode(evt);
    var VK_F12 = 123;
    if (VK_F12 == charCode) {
        var tail = "'id=USER_ID order by np'";
        var result = ShowMetaTable('np', tail);
        if (result != null) {
            document.getElementById("Nazn").value = result[1];
        }
    }
}

function selectDopReq(evt, name, fl) {
    var elem = document.getElementsByName(name)[0];
    if (document.getElementsByName(name).length > 1) {
        for (i = 0; i < document.getElementsByName(name).length; i++) {
            elem = document.getElementsByName(name)[i];
            if (elem.tag == name.replace('reqv_', '')) break;
        }
    }

    var reqname = escape(elem.name.replace('reqv_', '').replace('$', ''));
    var reqvalue = escape(elem.value);
    reqname += "[split]dfNlsA[split]dfNlsB[split]dfKvA[split]dfKvB";
    reqvalue += "[split]" + document.getElementById("Nls_A").value + "[split]" + document.getElementById("Nls_B").value + "[split]" + document.getElementById("Kv_A").value + "[split]" + document.getElementById("Kv_B").value;
    var charCode = getCharCode(evt);
    var VK_F12 = 123;
    if (VK_F12 == charCode || 1 == fl) {
        var tail = "''";
        var result = window.showModalDialog("dialog.aspx?type=metatab_req&role=wr_doc_input&reqname=" + reqname + "&reqvalue=" + reqvalue,
            window,
            "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result != null) {
            if (name === "reqv_INK_I")
                BindIncasatorsData(result[0]);
            elem.value = result[0];
            elem.fireEvent("onchange");
            // COBUSUPABS-4641
            if ("reqw_D9#70" === name) {
                var reqvDA70 = document.getElementById("reqv_DA#70");
                if (reqvDA70) {
                    reqvDA70.value = result[1];
                    //reqvDA70.disabled = true;
                }
            }
        }
    }
}


function selectDopReqExt(evt, name, fl) {
    var charCode = getCharCode(evt);
    var VK_F12 = 123;
    if (VK_F12 != charCode && 1 != fl) return;

    var elem = document.getElementsByName(name)[0];
    if (document.getElementsByName(name).length > 1) {
        for (i = 0; i < document.getElementsByName(name).length; i++) {
            elem = document.getElementsByName(name)[i];
            if (elem.tag == name.replace('reqv_', '')) break;
        }
    }
    if (elem.readOnly) return;

    var reqname = escape(elem.name.replace('reqv_', '').replace('$', ''));
    var reqvalue = escape(elem.value);
    reqname += "[split]dfNlsA[split]dfNlsB[split]dfKvA[split]dfKvB";
    reqvalue += "[split]" + document.getElementById("Nls_A").value + "[split]" + document.getElementById("Nls_B").value + "[split]" + document.getElementById("Kv_A").value + "[split]" + document.getElementById("Kv_B").value;

    if (VK_F12 == charCode || 1 == fl) {
        var tail = "''";
        var result = window.showModalDialog("dialog.aspx?type=metatab_req&role=wr_doc_input&reqname=" + reqname + "&reqvalue=" + reqvalue,
            window,
            "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result != null) {
            elem.value = result[0];
            if (elem.id === 'reqv_KOD_N') {
                validateKodN();
            }
        }
    }
}

function BindIncasatorsData(id) {
    if (null == webService.Doc) webService.useService("DocService.asmx?wsdl", "Doc");
    var callObj = webService.createCallOptions();
    callObj.async = false;
    callObj.funcName = "BindIncasatorsData";
    callObj.params = new Array();
    callObj.params.id = parseInt(id);

    var result = webService.Doc.callService(callObj);
    if (result.value["StatusCode"] === 0) {
        document.getElementById('reqv_ATRT').value = result.value['Atrt'];
        document.getElementById('reqv_PASP').value = result.value['Pasp'];
        document.getElementById('reqv_PASPN').value = result.value['Paspn'];
    }
    else {
        alert('Під час привязки даних виникла помилка' + '\r\n' + result.value['ErrorMessage']);
    }
}

function validateKodN() {
    var tt = document.getElementById("__TT").value;
    var kodN = document.getElementById("reqv_KOD_N").value;
    if (null == webService.Doc)
        webService.useService("DocService.asmx?wsdl", "Doc");
    webService.Doc.callService(onCheckKodN, "CheckKodN", tt, kodN);
}

function setValidatedReq(item) {
    var elem = document.getElementById('reqv_' + item.Name);
    var elemLb = document.getElementById('lb_reqv_' + item.Name);
    if (elem) {
        elem.value = item.Value;
        elem.readOnly = (item.IsEdit) ? ('') : (true);
        elem.style.backgroundColor = (item.IsEdit) ? ('') : ('#f0f0f0');
        if (elemLb)
            elemLb.style.color = (item.IsEmpty) ? ('') : ('red');
        var drecsIds = document.getElementById('Mand_Drecs_ids').value;
        document.getElementById('Mand_Drecs_ids').value = drecsIds.replace('reqv_' + item.Name + ',', '') + ((item.IsEmpty) ? ('') : ('reqv_' + item.Name + ','));
    }
}

function onCheckKodN(result) {
    if (!getError(result, true)) return;
    // if empty - refresh 
    if (result.value.length == 0) {
        setValidatedReq({ Name: 'KOD_B', Value: '', IsEdit: true, IsEmpty: document.getElementById('reqv_KOD_B').required === '0' });
        setValidatedReq({ Name: 'KOD_G', Value: '', IsEdit: true, IsEmpty: document.getElementById('reqv_KOD_G').required === '0' });
    }
    for (var i = 0; i < result.value.length; i++) {
        var item = result.value[i];
        setValidatedReq(item);
    }
}

function selectAccounts_link(evt, elem, fl, ctrl_nls, ctrl_nms, e_n) {
    if (elem.readOnly) return;
    var charCode = getCharCode(evt);
    var VK_F12 = 123;
    if (VK_F12 == charCode) {
        var mfo, kv;
        var dk = document.getElementById("__DK").value;
        var type = "";
        if (e_n == 1) {
            mfo = document.getElementById("Mfo_A").value;
            kv = document.getElementById("Kv_A").value;
            if (false == document.getElementById("Mfo_A").readOnly || fl == 0) type = -1;
            else type = (1 != dk) ? (1) : (0);
        }
        else {
            mfo = document.getElementById("Mfo_B").value;
            kv = document.getElementById("Kv_B").value;
            if (false == document.getElementById("Mfo_B").readOnly || fl == 0) type = -1;
            else type = (0 != dk) ? (1) : (0);
        }
        var tt = document.getElementById("__TT").value;
        var result = window.showModalDialog("dialog.aspx?type=metatab_base&role=wr_doc_input&dk=" + type + "&nls=" + elem.value + "&mfo=" + mfo + "&kv=" + kv + "&tt=" + tt,
            window,
            "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result != null) {
            document.getElementById(ctrl_nls).value = result[0];
            document.getElementById(ctrl_nms).value = result[2];
        }
    }
}