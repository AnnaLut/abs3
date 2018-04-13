var save_try = false;
var isNewAcc = false;
var dpt_param = null;
var flagEnhCheck = false;
var flagCheckSpecParams = false;
var localSP = new Array();
var spRequiredParams = new Array();
//Default.aspx
function InitDefault() {
    var access = 0;
    flagEnhCheck = (ModuleSettings && ModuleSettings.Accounts && ModuleSettings.Accounts.EnhanceCheck == true);
    flagCheckSpecParams = (ModuleSettings && ModuleSettings.Accounts && ModuleSettings.Accounts.CheckSpecParams == true);
    accessmode = getParamFromUrl("accessmode", location.href);
    dpt_param = getParamFromUrl("dpt", location.href);
    rnk = getParamFromUrl("rnk", location.href);
    acc = getParamFromUrl("acc", location.href);
    if (accessmode == 1) access = 1;
    if (access == 0) {
        document.getElementById("btSave").disabled = true;
        document.getElementById("btClose").disabled = true;
        document.getElementById("cbOnAllValuts").disabled = true;
        document.getElementById("btSave").style.filter = 'progid:DXImageTransform.Microsoft.Alpha( style=0,opacity=25)progid:DXImageTransform.Microsoft.BasicImage(grayScale=1)';
        document.getElementById("btClose").style.filter = 'progid:DXImageTransform.Microsoft.Alpha( style=0,opacity=25)progid:DXImageTransform.Microsoft.BasicImage(grayScale=1)';
    }
    else
        document.getElementById("cbOnAllValuts").disabled = false;
    //Загрузка картинок
    if (document.getElementById("btSave").src == "") {
        document.getElementById("btSave").src = image1.src;
        document.getElementById("btClose").src = image2.src;
        document.getElementById("btPrint").src = image3.src;
        document.getElementById("btDiscard").src = image4.src;
    }
    //Локализация
    LocalizeHtmlTitles();

    per_obj.value = new Array();
    edit_data.value = new Object();
    //General_Financial+Rights
    edit_data.value.general = new Object();
    edit_data.value.general.data = new Array();
    edit_data.value.general.edit = false;
    //SP
    edit_data.value.sp = new Object();
    edit_data.value.sp.data = new Array();
    edit_data.value.sp.edit = true; // всегда проверяем спецпараметры
    //Percent
    edit_data.value.percent = new Object();
    edit_data.value.percent.tbl = new Array();
    edit_data.value.percent.data = new Array();
    edit_data.value.percent.edittbl = false;
    edit_data.value.percent.edit = false;
    //Rates
    edit_data.value.rates = new Object();
    edit_data.value.rates.tbl = new Array();
    edit_data.value.rates.edit = false;
    //Sob
    edit_data.value.sob = new Object();
    edit_data.value.sob.tbl = new Array();
    edit_data.value.sob.edit = false;

    //Вичитка основных данных
    webService.useService("AccService.asmx?wsdl", "Acc");
    webService.Acc.callService(onPopulate, "Populate", acc, rnk);
}
function onPopulate(result) {
    if (!getError(result)) return;
    document.all.acc_obj.value = result.value;

    if ("" != result.value[59].text) new_rights = true;
    lbNmk.innerText = LocalizedString('Message2') + result.value[56].text;
    //Счет закрыт
    if ("" != result.value[10].text) accessmode = 0;

    if (result.value[0].text == "") {
        lbNls.innerText = LocalizedString('Message3');
    }
    else if (accessmode == 1)
        lbNls.innerText = LocalizedString('Message4') + " № " + result.value[0].text + ".";
    else
        lbNls.innerText = LocalizedString('Message5') + " № " + result.value[0].text + ".";

    //Отрисовка елемента webtab
    var array = new Array();
    array[LocalizedString('tb1')] = "acc_general.aspx?acc=" + acc + "&accessmode=" + accessmode;
    array[LocalizedString('tb2')] = "acc_financial.aspx?acc=" + acc + "&accessmode=" + accessmode;
    array[LocalizedString('tb3')] = "Acc_rights.aspx?acc=" + acc + "&accessmode=" + accessmode;
    if (acc == 0) {
        array[LocalizedString('tb4')] = "blank.html";
        array[LocalizedString('tb5')] = "blank.html";
        array[LocalizedString('tb6')] = "blank.html";
        array[LocalizedString('tb7')] = "blank.html";
        document.getElementById("btClose").disabled = true;
        document.getElementById("btPrint").disabled = true;
    }
    else {
        array[LocalizedString('tb4')] = "acc_sp.aspx?acc=" + acc + "&accessmode=" + accessmode;
        array[LocalizedString('tb5')] = "acc_percent.aspx?acc=" + acc + "&accessmode=" + accessmode;
        array[LocalizedString('tb6')] = "acc_rates.aspx?acc=" + acc + "&accessmode=" + (result.value[61].text == "0" ? "0" : accessmode); // + accessmode;
        array[LocalizedString('tb7')] = "acc_sob.aspx?acc=" + acc + "&accessmode=" + accessmode;
    }

    fnInitTab("webtab", array, 500, "onChangeTab");
    goPage(document.getElementById("bTab0"));

    if (dpt_param) {
        document.getElementById("bTab0").disabled = true;
        document.getElementById("bTab1").disabled = true;
        document.getElementById("bTab2").disabled = true;
        document.getElementById("bTab3").disabled = true;
        document.getElementById("bTab5").disabled = true;
        document.getElementById("bTab6").disabled = true;

        goPage(document.getElementById("bTab4"));
    }
    //---------------------------
}
//Показать список валют
function fnShowValutes() {
    var result = window.showModalDialog("ListValuts.aspx", "", "dialogWidth:800px;dialogHeight:800px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null) {
        document.getElementById("cbOnAllValuts").disabled = true;
        codValutes = result;
        OnAllValuts = true;
    }
    else {
        document.getElementById("cbOnAllValuts").checked = false;
    }
}
//Закрыть счет
/*function CloseAccount() {
    var message = LocalizedString('Message6') + "(acc=" + acc + ")?";
    var result = Dialog(message, 0);
    if (result == 1) {
        webService.useService(location.protocol + "//" + location.host + "/barsroot/webservices/WebServices.asmx?wsdl", "Tmp"); //Создание обьэкта вебсервиса
        webService.Tmp.callService(onCloseAcc, "CloseAccount", acc, 0);
    }
}*/

function CloseAccount() {
    alertify.set({
        labels: {
            ok: "Продовжити",
            cancel: "Відмінити"
        },
        modal: true
    });
    var nls = acc_obj.value[0].text;
    var vid = acc_obj.value[7].text;
    var flagEnhCheck = (ModuleSettings && ModuleSettings.Accounts && ModuleSettings.Accounts.EnhanceCloseCheck == true);
    if (flagEnhCheck && vid != 0) {
        var html = '<div><b>Вкажіть причину закриття рахунку ' + nls + ' (acc:' + acc + '):</b></div><br/>\
                    <div><label><input type="radio" id="closureReason3" name="closureReason" value="3" /> за ініциативою клієнта</label> </div>\
                    <div><label><input type="radio" id="closureReason5" name="closureReason" value="5" /> не за ініциативою клієнта</label> </div>\
                    ';
        alertify.confirm(html, function(e) {
            if (e) {
                var closureReason = null;
                if (document.getElementById('closureReason3').checked) {
                    closureReason = document.getElementById('closureReason3').value;
                } else if (document.getElementById('closureReason5').checked) {
                    closureReason = document.getElementById('closureReason5').value;
                }

                if (closureReason == null) {
                    alertify.alert("Не вказано причину. Закриття неможливе.");
                } else {
                    closeAcc(acc, closureReason);
                }

            } else {
            }
        });

    } else {
        var message = LocalizedString('Message6') + " " + nls + " (acc:" + acc + ")?";
        var result = Dialog(message, 0);
        if (result == 1) {
            closeAcc(acc, null);
        }
    }
}

function closeAcc(acc, reason) {
    webService.useService(location.protocol + "//" + location.host + "/barsroot/webservices/WebServices.asmx?wsdl", "Tmp"); //Создание обьэкта вебсервиса
    webService.Tmp.callService(onCloseAcc, "CloseAccount", acc, 0, reason);
}

function onCloseAcc(result) {
    if (!getError(result)) return;
    var msg = result.value;
    if (msg.indexOf("$$PROMPT$$") > 0) {
        var promptNum = msg.substr(msg.indexOf("$$PROMPT$$") + 10);
        msg = msg.replace("$$PROMPT$$" + promptNum, "");
        if (Dialog(msg, 0) == 1) {
            webService.Tmp.callService(onCloseAcc, "CloseAccount", acc, promptNum);
            return;
        }
    }
    else
        Dialog(msg, 1);
    exit_page();
}
//Выход
function exit_page() {
    if (CheckChange()) return;
    goBack();
}
//Закрытие окна
function CloseWindow() {
    if (CheckChange()) SaveAccount();
}
function CheckChange() {
    if (!OnAllValuts &&
     edit_data.value.general.edit == false &&
     edit_data.value.sp.edit == false &&
     edit_data.value.percent.edit == false &&
     edit_data.value.percent.edittbl == false &&
     edit_data.value.rates.edit == false &&
     edit_data.value.sob.edit == false)
        return false;
    else {
        if (Dialog(LocalizedString('Message7'), 0) == 0)
            return true;
        else false;
    }
}

//Печать
function Print() {
    var data = acc_obj.value;
    var result = window.showModalDialog(url_dlg_mod + 'DOC_SCHEME&tail="id like \'ACC%\'"', "", "dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    if (result)
        webService.Acc.callService(onGetFileForPrint, "GetFileForPrint", acc, result[0]);
}
function onGetFileForPrint(result) {
    if (!getError(result)) return;
    var link = 'WebPrint.aspx?filename=' + result.value;
    window.showModalDialog(link, '', 'dialogWidth: 900px; dialogHeight: 800px; center: yes');
}
//Проверка на заполнение атрибутов
function GetErrAccount() {
    var err = "";
    var nl = "\n";
    var page_g = document.frames("Tab0").document.all;
    var page_r = document.frames("Tab2").document.all;
    var page_p = document.frames("Tab4").document.all;
    var page_f = document.frames("Tab1").document.all;
    if (page_g.tbNls.value == "") err += LocalizedString('Message8') + nl;
    if (page_g.tb_Lcv.value == "") err += LocalizedString('Message9') + nl;
    if (page_g.tbNms.value == "") err += LocalizedString('Message10') + nl;
    if (document.getElementById("parNBSNULL").value != "1") {
        if (page_g.tbNbs.value == "") err += "Не заповнений реквізит < Балансовий рахунок >" + nl;
    }
    if (page_g.tbTip.value == "") err += LocalizedString('Message11') + nl;
    if (page_g.ddVid.options[0].text == "") err += LocalizedString('Message12') + nl;
    if (page_g.tbLspCode.value == "") err += LocalizedString('Message13') + nl;
    if (!flagEnhCheck && new_rights) {
        if (page_r.lsGroupsAcc.options.length == 0) err += LocalizedString('Message14') + nl;
    }
    else if (!flagEnhCheck && (page_r.ddGroups.options == null || page_r.ddGroups.options.length == 0)) err += LocalizedString('Message15') + nl;
    // Доп. проверка
    if (flagEnhCheck) {
        var nbs = page_g.tbNls.value.substr(0, 4);
        // проверяем необходимые реквизити
        var spErr = "";
        for (i = 0; i < spRequiredParams.length; i++) {
            var o = spRequiredParams[i];
            var editVal = (localSP[o.Id])?(localSP[o.Id].v):(null);
            if (!o.Val && !editVal) {
                // исключение для S260
                if (o.Name == "S260" && !(edit_data.value.general.data["tbLimitOs"]>0)) continue;
                spErr += " - " + o.Desc + nl;
            }
        }
        if(spErr)
            err += "Не заповнено спец. параметр(и):\n" + spErr;

        var stage1 = ",2600,2560,2570,2602,2603,2604,2605,2650,";
        if (stage1.indexOf(nbs) > 0) {
            //1.	Блокирование по Д-ту 2.	Блокирование по К-ту      
            if (page_f.ddVidBlkD.value == 0 || page_f.ddVidBlkK.value == 0) {
                // до выяснения
            }
        }
        var stage2 = ",2062,2063,2067,2071,2072,2073,2074,2077,2082,2083,2089,";
        if (stage2.indexOf(nbs) > 0) {
            if (!page_p.tbKvA.value) err += "Не задано валюту рахунку нарахованих відсотків" + nl;
            if (!page_p.tbNlsA.value) err += "Не задано рахунок нарахованих відсотків" + nl;
            if (page_p.dGrid.rows.length <= 1) err += "Не задано відсоткову ставку" + nl;
        }
    }
    return err;
}
//Сохранение счета
function SaveAccount() {
    var err = GetErrAccount();
    if (err != "" && !OnAllValuts) { alert(err); return; }
    if (!OnAllValuts &&
     edit_data.value.general.edit == false &&
     edit_data.value.sp.edit == false &&
     edit_data.value.percent.edit == false &&
     edit_data.value.percent.edittbl == false &&
     edit_data.value.rates.edit == false &&
     edit_data.value.sob.edit == false) {
        Dialog(LocalizedString('Message16'), 1);
        return;
    }

    var message;
    if (acc == 0 || OnAllValuts) {
        message = LocalizedString('Message17');
        if (OnAllValuts == false) {
            if (document.frames("Tab0").document.all.tbNbs.value == "") message += LocalizedString('Message18');
            message += LocalizedString('Message19') + document.frames("Tab0").document.all.tbNls.value + LocalizedString('Message20') + document.frames("Tab0").document.all.tb_Lcv.value + " ?";
        }
        else {
            if (document.frames("Tab0").document.all.tbNbs.value == "") message += LocalizedString('Message21');
            message += LocalizedString('Message22') + document.frames("Tab0").document.all.tbNls.value + LocalizedString('Message23');
        }
    }
    else message = LocalizedString('Message24') + document.frames("Tab0").document.all.tbNls.value + " (" + document.frames("Tab0").document.all.tb_Lcv.value + ") ?";
    if (Dialog(message, 0) == 1) {
        var valuts = null;
        var gen = null;
        var sp = null;
        var per = null;
        var pertbl = null;
        var rates = null;
        var sob = null;
        if (edit_data.value.general.edit == true) gen = ForUpdateAccount();
        if (edit_data.value.sp.edit == true || acc == 0) {
            sp = makeArray(edit_data.value.sp.data);
            sp[sp.length] = document.frames("Tab3").document.all.cbSPOpt.checked;
            sp[sp.length] = acc_obj.value[2].text;
        }
        if (edit_data.value.percent.edit == true) per = ForUpdatePercent();
        if (edit_data.value.percent.edittbl == true) {
            pertbl = makeArray(edit_data.value.percent.tbl);
            if (pertbl.length == 0) pertbl = null;
        }
        if (edit_data.value.rates.edit == true) rates = makeArray(edit_data.value.rates.tbl);
        if (edit_data.value.sob.edit == true) {
            sob = makeArray(edit_data.value.sob.tbl);
            if (sob.length == 0) sob = null;
            else sob[sob.length] = new Array(acc_obj.value[54].text);
        }
        if (OnAllValuts) {
            valuts = codValutes;
            gen = ForUpdateAccount();
        }
        // снимаем блокировку для 2900 (НАДРА) при открытии
        if(flagEnhCheck && acc == 0 && gen[10] == '2900')
        	gen[16]  = 0;
        //
        save_try = true;
        webService.Acc.callService(onSaving, "Save", acc, valuts, gen, sp, per, pertbl, rates, sob);
    }
}
function onSaving(result) {
    if (result.error && (exStr = result.errorDetail.string).indexOf("CheckSP::") > 0) {
        alert(exStr.substring(exStr.indexOf("CheckSP::") + 9, exStr.indexOf("::CheckSP")));
        return;
    }
    else if (!getError(result,true)) return;
    if (acc == 0) {
        isNewAcc = true;
        acc_obj.value[2].text = document.frames("Tab0").document.all.tbNbs.value;
        acc = result.value;
        bTab3.style.visibility = 'visible';
        bTab4.style.visibility = 'visible';
        bTab5.style.visibility = 'visible';
        bTab6.style.visibility = 'visible';
        window.frames[3].location.replace("ACc_SP.aspx?acc=" + acc + "&accessmode=" + accessmode);
        window.frames[4].location.replace("Acc_percent.aspx?acc=" + acc + "&accessmode=" + accessmode);
        window.frames[5].location.replace("Acc_Rates.aspx?acc=" + acc + "&accessmode=" + accessmode);
        window.frames[6].location.replace("Acc_Sob.aspx?acc=" + acc + "&accessmode=" + accessmode);
    }
    if (result.value != "") {
        Dialog(LocalizedString('Message25'), 1);
        edit_data.value.general.edit = false;
        edit_data.value.sp.data = new Array();
        localSP = new Array();
        edit_data.value.sp.edit = false;
        edit_data.value.percent.data = new Array();
        edit_data.value.percent.edit = false;
        edit_data.value.percent.tbl = new Array();
        edit_data.value.percent.edittbl = false;
        edit_data.value.rates.tbl = new Array();
        edit_data.value.rates.edit = false;
        edit_data.value.sob.tbl = new Array();
        edit_data.value.sob.edit = false;
        OnAllValuts = false;
        document.getElementById("cbOnAllValuts").disabled = false;
        document.getElementById("cbOnAllValuts").checked = false;
        acc_obj.value[2].text = document.frames("Tab0").document.all.tbNbs.value;
        webService.Acc.callService(onPopulate, "Populate", acc, rnk);
    }
}

function ForUpdateAccount() {
    var result = new Array();
    var data = document.all.acc_obj.value;
    result[0] = data[34].text;
    result[1] = data[22].text;
    result[2] = data[3].text;
    result[3] = data[24].text;
    result[4] = rnk;
    result[5] = data[0].text;
    result[6] = data[1].text;
    result[7] = data[4].text;
    result[8] = data[6].text;
    result[9] = data[23].text;
    result[10] = data[2].text;
    result[11] = data[5].text;
    result[12] = data[7].text;
    result[13] = data[8].text;
    result[14] = data[25].text;
    result[15] = data[26].text;
    result[16] = data[13].text;
    result[17] = data[14].text;
    result[18] = data[21].text;
    result[19] = data[28].text;
    result[20] = data[32].text;
    result[21] = data[55].text;
    result[22] = data[59].text;
    //New acc access
    if ("" != data[59].text) {
        var new_item = "", del_item = "", cur_item = "", id, status;
        for (i = 0; i < data[61].length; i++) {
            id = data[61][i].split(';')[0];
            status = data[61][i].split(';')[1];
            if (status == 1)
                new_item += " " + id + " ";
            else if (status == 0) {
                cur_item += " " + id + " ";
            }
            else if (status == -1) {
                if (new_item.indexOf(" " + id + " ") != -1)
                    new_item = new_item.replace(" " + id + " ", "");
                else
                    del_item += " " + id + " ";

                if (cur_item.indexOf(" " + id + " ") != -1)
                    cur_item = cur_item.replace(" " + id + " ", "");
            }
        }
        result[23] = new_item;
        result[24] = del_item;
        result[25] = cur_item;
    }

    var n_data = document.all.edit_data.value.general.data;
    for (key in n_data) {
        val = n_data[key];
        switch (key) {
            case "tbNms": result[7] = val; break;
            case "tbNls": result[5] = val; break;
            case "tbNbs": result[10] = val; break;
            case "tbNlsAlt": result[2] = val; break;
            case "ddValuta": result[6] = val; break;
            case "tbLspCode": result[9] = val; break;
            case "ddUser": result[9] = val; break;
            case "ddPap": result[11] = val; break;
            case "ddTip": result[8] = val; break;
            case "ddPos": result[13] = val; break;
            case "ddVid": result[12] = val; break;
            case "ddVidBlkD": result[16] = val; break;
            case "ddVidBlkK": result[17] = val; break;
            case "tbMfo": result[0] = val; break;
            case "ddMfo": result[0] = val; break;
            case "ddTobo": result[19] = val; break;
            case "tbTobo": result[19] = val; break;
            //Finaclial  
            case "tbLimitOs": result[18] = val; break;
            case "tbLimitMinus": result[18] = val; break;
            case "tbMaxLimOs": result[1] = val; break;
            //Rights  
            case "ddGroups": result[3] = val; break;
            case "Seci": result[14] = val; break;
            case "Seco": result[15] = val; break;
        }
    }
    return result;
}
/* Соответсвие идекиов масива и параметров счета 
0 == Nls;			11 == Dapp;			22 == Ostx;			33 == Lcv;
1 == Kv;			12 == MDate;		23 == Isp;			34 == ProcMfo;	
2 == Nbs;			13 == Blkd;			24 == Grp;			35 == XarStr;
3 == NlsAlt;		14 == Blkk;			25 == Seci;			36 == nId;
4 == Nms;			15 == Ostc;			26 == Seco;			37 == bdate;
5 == Pap;			16 == Dos;			27 == Rnk;
6 == Tip;			17 == Kos;			28 == Tobo;
7 == Vid;			18 == Ostq;			29 == NameNbs;
8 == Pos;			19 == Dosq;			30 == Xar;	
9 == Daos;			20 == Kosq;			31 == PapPs;
10 == Dazg;		21 == Lim;			32 == nDig;
*/
function ForUpdatePercent() {
    var result = new Array();
    var data = document.all.per_obj.value;
    result[0] = data[0].text;
    result[1] = data[1].text;
    result[2] = data[2].text;
    result[3] = data[3].text;
    result[4] = data[4].text;
    result[5] = data[5].text;
    result[6] = data[6].text;
    result[7] = data[7].text;
    result[8] = data[8].text;
    result[9] = data[9].text;
    result[10] = data[10].text;
    result[11] = data[11].text;
    result[12] = data[12].text;
    result[13] = data[13].text;
    result[14] = data[14].text;
    result[15] = data[15].text;
    result[16] = data[16].text;
    result[17] = data[24]; //id
    var n_data = document.all.edit_data.value.percent.data;
    for (key in n_data) {
        val = n_data[key];
        switch (key) {
            case "ddMetr": result[0] = val; break;
            case "ddBaseY": result[2] = val; (val == "2") ? (result[1] = 1) : (result[1] = 0); break;
            case "ddFreq": result[3] = val; break;
            case "tbStpDat": result[4] = val; break;
            case "tbAcrDat": result[5] = val; break;
            case "tbAplDat": result[6] = val; break;
            case "tbTT1": result[7] = val; break;
            case "tbTT2": result[10] = val; break;
            case "tbMFO": result[11] = val; break;
            case "tbKvC": result[12] = val; break;
            case "tbNlsC": result[13] = val; break;
            case "tbNamC": result[14] = val; break;
            case "tbNazn": result[15] = val; break;
            case "ddOstat": result[16] = val; break;
        }
    }
    return result;
}
/* Проценты
0 == Metr		11 == MFO
1 == BaseM		12 == KvC	
2 == BaseY		13 == NlsC
3 == Freq		14 == NamC	
4 == StpDat		15 == Nazn
5 == AcrDat		16 == Io
6 == AplDat		17 == NlsA
7 == TT1		18 == KvA
8 == AcrA		19 == NlsB
9 == AcrB		20 == KvB
10 == TT2		
*/
//Локализация
function LocalizeHtmlTitles() {
    LocalizeHtmlTitle("btSave");
    LocalizeHtmlTitle("btClose");
    LocalizeHtmlTitle("btPrint");
    LocalizeHtmlTitle("btDiscard");
}
                
                
                
                
                
                
