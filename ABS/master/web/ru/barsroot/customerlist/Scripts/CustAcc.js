//CustAcc
function InitCustAccParams() {
    rnk = getParamFromUrl("rnk", location.href);
    type = getParamFromUrl("type", location.href);
    nd = getParamFromUrl("nd", location.href);
    LocalizeHtmlTitles(type); // Локализация
    webService.useService("CustService.asmx?wsdl", "CustAcc"); //Создание обьэкта вебсервиса
    InitCustAcc();
    //load from cookie
    if (getCookie('kv'))
        gE('tbFindKv').value = getCookie('kv');
    if (getCookie('nls'))
        gE("tbFindNls").value = getCookie('nls');
    if (getCookie('nms'))
        gE("tbFindNms").value = getCookie('nms');
    if (getCookie('pap') && gE("ddPap"))
        gE("ddPap").selectedIndex = getCookie('pap');
    if (getCookie('ddBranches') && gE("ddBranches"))
        gE("ddBranches").selectedIndex = getCookie('branch');
    /*if (getCookie('ddWhereClause'))
    gE("ddWhereClause").selectedIndex = getCookie('ddWhereClause');*/
}
var colBrach = "";
function InitCustAcc() {
    init_num("tbFindNls");

    var obj = new Object();

    var full = (type == 0) ? (true) : (false);
    v_data[2] = "AND a.dazs IS NULL";
    v_data[9] = rnk;
    v_data[10] = type;
    v_data[11] = nd;
    v_data[12] = getParamFromUrl("acc", location.href);
    v_data[13] = getParamFromUrl("nls", location.href);
    v_data[14] = getParamFromUrl("lcv", location.href);
    v_data[15] = getParamFromUrl("Dat1", location.href);
    v_data[16] = getParamFromUrl("Dat2", location.href);
    v_data[17] = getParamFromUrl("cp_ref", location.href);

    var mod = getParamFromUrl("mod", location.href);
    if (mod == "ro") full = false;
    /*var where_clause = getParamFromUrl("where_clause",location.href);
    if(where_clause == 'current_branch')
    where_clause = "AND branch like sys_context('bars_context','user_branch_mask') and branch != sys_context('bars_context','user_branch')"; 
    v_data[1] = where_clause;
    */
    // показать колонку branch
    var colBrach = "";
    if (type == 1) {
        if (gE("ddWhereClause").value != "")
            v_data[1] = gE("ddWhereClause").value;
        colBrach = "Br";
    }
    else if (type == 2) {
        v_data[1] = "and a.branch like '" + gE("ddBranches").value + "%'";
    }
    else if (type == 5) {
        if (gE("ddWhereClause").value != "")
            v_data[1] = gE("ddWhereClause").value.replace(':p_nd', getParamFromUrl("bpkw4nd", location.href));
        colBrach = "Br";
    }
    else if (type == 9) {
        v_data[1] = gE("ddWhereClause").value.replace(':cp_ref', getParamFromUrl("cp_ref", location.href));
    }
    else if (type == 10) {
        v_data[1] = gE("ddWhereClause").value.replace(':nd', getParamFromUrl("e_deal_nd", location.href));
    }
    else if (type == 11) {
        v_data[1] = gE("ddWhereClause").value.replace(':nd', getParamFromUrl("premium_banking", location.href));
    }

    if (type == 0) document.getElementById("lbType").innerText = LocalizedString('Message1');
    else if (type == 1) document.getElementById("lbType").innerText = LocalizedString('Message2');
    else if (type == 2) document.getElementById("lbType").innerText = LocalizedString('Message3');
    else if (type == 3) document.getElementById("lbType").innerText = LocalizedString('Message4') + nd + ".";
    else if (type == 4) document.getElementById("lbType").innerText = LocalizedString('Message5');
    else if (type == 9) document.getElementById("lbType").innerText = LocalizedString('Message5');

    LoadXslt("Xslt/CustAcc" + colBrach + "_" + getCurrentPageLanguage() + ".xsl");
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = 'CustService.asmx';
    obj.v_serviceMethod = 'GetCustAcc';
    obj.v_serviceFuncAfter = "LoadCustAcc";

    obj.v_showFilterOnStart = false;
    obj.v_filterInMenu = false;
    if (full)
        obj.v_filterTable = "accounts";
    else
        obj.v_filterTable = "saldo";
    var menu = new Array();
    if (full) menu[document.all.btOpen.title] = "fnOpenAcc()";
    menu[document.all.btEdit.title] = "fnViewAcc()";

    if (full || mod == "del") menu[document.all.btClose.title] = "fnCloseAcc()";
    if (full || mod == "del") menu[document.all.btReanim.title] = "fnReanimAcc()";

    menu[document.all.btHistAcc.title] = "fnShowHistAcc()";
    menu[document.all.btHist.title] = "fnShowHist()";

    obj.v_menuItems = menu;
    obj.v_enableViewState = true;
    fn_InitVariables(obj);
    InitGrid();
}

function LoadCustAcc() {
    var mod = getParamFromUrl("mod", location.href);
    document.getElementById("lbNmk").innerText = returnServiceValue[2].text;
    if (type == 1 || type == 2 || type == 3 || mod == "ro") SetReadOnly();
    if (type == 1) {
        //document.getElementById("lbNmk").innerText = (parent.frames.length != 0) ? (parent.frames[0].document.getElementById("textLogin").innerText) : ("");
    }
    else if (type == 2)
        document.getElementById("lbNmk").innerText = (parent.frames.length != 0 && parent.frames[0].document.getElementById("ed_Tobo")) ? (parent.frames[0].document.getElementById("ed_Tobo").innerText) : ("");
    if (document.getElementById("btShow").src == "") {
        document.getElementById("btShow").src = image1.src;
        document.getElementById("btOpen").src = image2.src;
        document.getElementById("btEdit").src = image3.src;
        document.getElementById("btClose").src = image4.src;
        document.getElementById("btReanim").src = image5.src;
        document.getElementById("btReg").src = image6.src;
        document.getElementById("btRefresh").src = image7.src;
        document.getElementById("btFilter").src = image8.src;
        document.getElementById("btDiscard").src = image10.src;
        document.getElementById("btHist").src = image11.src;
        document.getElementById("btHistAcc").src = image12.src;
        document.getElementById("forbLinkAcc").src = image13.src;
    }
}
function SetReadOnly() {
    var mod = getParamFromUrl("mod", location.href);

    document.getElementById("btOpen").style.filter = 'progid:DXImageTransform.Microsoft.Alpha( style=0,opacity=25)progid:DXImageTransform.Microsoft.BasicImage(grayScale=1)';
    document.getElementById("btReg").style.filter = 'progid:DXImageTransform.Microsoft.Alpha( style=0,opacity=25)progid:DXImageTransform.Microsoft.BasicImage(grayScale=1)';
    document.getElementById("btOpen").disabled = true;
    document.getElementById("btReg").disabled = true;

    if (mod != "del") {
        document.getElementById("btClose").style.filter = 'progid:DXImageTransform.Microsoft.Alpha( style=0,opacity=25)progid:DXImageTransform.Microsoft.BasicImage(grayScale=1)';
        document.getElementById("btReanim").style.filter = 'progid:DXImageTransform.Microsoft.Alpha( style=0,opacity=25)progid:DXImageTransform.Microsoft.BasicImage(grayScale=1)';
        document.getElementById("btClose").disabled = true;
        document.getElementById("btReanim").disabled = true;
    }
}

//Открыть новый счет 
function fnOpenAcc() {
    //window.location.replace('/barsroot/viewaccounts/accountform.aspx?type=4&acc=0&rnk=' + rnk + "&accessmode=1");
    document.location.href = '/barsroot/viewaccounts/accountform.aspx?type=4&acc=0&rnk=' + rnk + '&accessmode=1';
}
//Просмотр атрибутов счета
function fnViewAcc() {
    if (selectedRowId == null) return;
    else {
        debugger;
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/custacc/start/"),
            data: { acc: selectedRowId, nbs: "" },
            success: function(result) {
                //var mod = getParamFromUrl("mod", location.href);
                //if (type == 1 || type == 2 || type == 3 || mod == "ro") acces_mode = 0;
                //window.location.replace('/barsroot/viewaccounts/accountform.aspx?type=' + type + '&acc=' + selectedRowId + '&rnk=' + rnk + '&accessmode=' + acces_mode);

                if (result.rez === 1) {
                    document.location.href = '/barsroot/viewaccounts/accountform.aspx?type=' + type + '&acc=' + selectedRowId + '&rnk=' + rnk + '&accessmode=1';
                } else if (result.rez === 2) {
                    document.location.href = '/barsroot/viewaccounts/accountform.aspx?type=' + type + '&acc=' + selectedRowId + '&rnk=' + rnk + '&accessmode=0';
                } else {
                    bars.ui.alert({ text: result.msg });
                }
            }
        });
    }
}

//Запуск закрытия счета
function fnRunCloseAcc(nls, vid) {
    var flagEnhCheck = (ModuleSettings && ModuleSettings.Accounts && ModuleSettings.Accounts.EnhanceCloseCheck == true);
    if (flagEnhCheck && vid != 0) {
        var html = '<div><b>Вкажіть причину закриття рахунку ' + nls + ' (acc:' + selectedRowId + '):</b></div><br/>\
                    <div><label><input type="radio" id="closureReason3" name="closureReason" value="3" /> за ініциативою клієнта</label> </div>\
                    <div><label><input type="radio" id="closureReason5" name="closureReason" value="5" /> не за ініциативою клієнта</label> </div>\
                    ';
        alertify.confirm(html, function (e) {
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
                    closeAcc(selectedRowId, closureReason);
                }

            } else { }
        });

    } else {
        var message = LocalizedString('Message6') + " " + nls + " (acc=" + selectedRowId + ")?";
        var result = Dialog(message, 0);
        if (result == 1) {
            closeAcc(selectedRowId, null);
        }
    }
}

//Закрыть текущий счет
function fnCloseAcc() {
    alertify.set({
        labels: {
            ok: "Продовжити",
            cancel: "Відмінити"
        },
        modal: true
    });

    if (selectedRowId == null) {
        alertify.alert("Не вибрано жодного рахунку");
    } else {;
        var nls  = document.getElementById("NLS_" + row_id).innerHTML;
		var vid  = document.getElementById("VID_" + row_id).innerHTML;
		var ob22 = $("#r_" + row_id).children()[1].innerHTML;

        //перевірка группи клієнта та рахунку до закриття
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/custacc/start/"),
			success: function (result) {
				if (result !== 0) {
					fnRunCloseAcc(nls, vid);
				} else if (checkOperCloseRights.accCanBeClosed(nls, ob22)) {
					fnRunCloseAcc(nls, vid);
				} else {
					alert("Відсутні права на закриття рахунку " + nls + ", ob22 " + ob22);
				}
            }
        });
    }
}

function fnExportToExcel() {
    webService.CustAcc.callService(onExportExcel, "ExportExcel", v_data);
}

function onExportExcel(result) {
    if (!getError(result)) return;
    location.href = "/barsroot/cim/handler.ashx?action=download&fname=accounts.xls&file=" + result.value;
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
            webService.Tmp.callService(onCloseAcc, "CloseAccount", selectedRowId, promptNum);
            return;
        }
    }
    else
        Dialog(msg, 1);
    ReInitGrid();
}


function fnIntState() {
    if (selectedRowId == null) return;
    window.showModalDialog("/barsroot/tools/int_statement.aspx?acc=" + selectedRowId + "&" + Math.random(), "", "dialogWidth:800px;dialogHeight:600px;center:yes;edge:sunken;scroll:no;help:no;status:no;");
}



//Реанимировать закрытый счет
function fnReanimAcc() {
    if (selectedRowId == null) return;
    else {
        var message = LocalizedString('Message7');
        var result = Dialog(message, 0);
        if (result == 1) webService.CustAcc.callService(onReanimAcc, "ReanimAcc", selectedRowId);
    }
}
function onReanimAcc(result) {
    if (!getError(result)) return;
    Dialog(result.value, 1);
    ReInitGrid();
}
//Перерегистрировать на другого контрагента
function fnReRegistr() {
    //TODO
    //Вместо CustDic вызывать стандартный справочник для контагентов
    if (selectedRowId == null) return;
    else {
        var message = LocalizedString('Message8');
        var result = Dialog(message, 0);
        if (result == 1) {
            result = window.showModalDialog("CustDic.aspx", "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
            if (result == null) return;
            webService.CustAcc.callService(onReRegistr, "ReRegistr", selectedRowId, v_data[9], result);
        }
    }
}
function onReRegistr(result) {
    if (!getError(result)) return;
    if (result.value != 0) {
        Dialog(LocalizedString('Message10'), 1);
        ReInitGrid();
    }
    else Dialog(LocalizedString('Message11'), 1);
}
function gE(id) {
    return document.getElementById(id);
}
// Поиск 
function QuickFind() {
    var where = "";
    var nls = gE("tbFindNls").value;
    if (nls)
        where += " and a.nls like '" + nls + "%'";
    var kv = gE("tbFindKv").value;
    if (kv) {
        if (isNaN(kv))
            where += " and a.lcv like UPPER('" + kv + "%')";
        else
            where += " and a.kv=" + kv;
    }
    var nms = gE("tbFindNms").value.replace('*', '%').replace('*', '%');
    if (nms)
        where += " and UPPER(a.nms) like UPPER('" + nms + "%')";
    var pap = gE("ddPap").value;
    if (pap != "")
        where += " and a.pap=" + pap;

    var rnk = gE("tbFindRNK").value;
    if (rnk != "" && !isNaN(rnk))
        where += " and a.rnk=" + rnk;

    var okpo = gE("tbFindOKPO").value;
    if (okpo != "" && !isNaN(okpo)) {
        where += " and a.rnk in (select RNK from V_CUSTOMER where okpo ='" + okpo + "')";
    }

    if (type == 2) {
        var branch = gE("ddBranches").value;
        where += " and a.branch like '" + branch + "%'";
    }
    else if (type == 1) {
        var clause = gE("ddWhereClause").value;
        if (clause)
            where += " " + clause;
    }
    if (type == 5) {
        var clause = gE("ddWhereClause").value;
        if (clause) {
            where += " " + clause.replace(':p_nd', getParamFromUrl("bpkw4nd", location.href));
        }
    }
    if (type == 9) {
        var clause = gE("ddWhereClause").value;
        if (clause) {
            where += " " + clause.replace(':cp_ref', getParamFromUrl("cp_ref", location.href));
        }
    }
    if (type == 10) {
        var clause = gE("ddWhereClause").value;
        if (clause) {
            where += " " + clause.replace(':nd', getParamFromUrl("e_deal_nd", location.href));
        }
    }
    if (type == 11) {
        var clause = gE("ddWhereClause").value;
        if (clause) {
            where += " " + clause.replace(':nd', getParamFromUrl("premium_banking", location.href));
        }
    }

    //save to cookie
    document.cookie = "kv=" + kv;
    document.cookie = "nls=" + nls;
    document.cookie = "nms=" + nms;
    document.cookie = "pap=" + gE("ddPap").selectedIndex;
    if (gE("ddBranches"))
        document.cookie = "branch like" + gE("ddBranches").selectedIndex + "%'";
    if (gE("ddWhereClause"))
        document.cookie = "ddWhereClause=" + gE("ddWhereClause").selectedIndex;

    v_data[1] = where;
    ReInitGrid();
}


//Показать\спрятать закрытые счета
function fnShowHide() {
    if (document.getElementById("btShow").style.borderTopStyle == "inset") {
        setStyleButton(document.getElementById("btShow"), "outset");
        v_data[2] = "AND a.dazs IS NULL";
    }
    else {
        setStyleButton(document.getElementById("btShow"), "inset");
        v_data[2] = ""; v_data[4] = 0;
    }
    ReInitGrid();
}
//История изменения параметров счета
function fnShowHist() {
    if (selectedRowId == null) return;
    else
        //window.location.replace("custhistory.aspx?mode=1&rnk=" + selectedRowId + "&type=" + type);
        document.location.href = "custhistory.aspx?mode=1&rnk=" + selectedRowId + "&type=" + type;
}
//История счета
function fnShowHistAcc() {
    if (selectedRowId == null) return;
    else
        //window.location.replace("showhistory.aspx?acc=" + selectedRowId + "&type=" + type);
        document.location.href = "showhistory.aspx?acc=" + selectedRowId + "&type=" + type;
}
//Локализация
function LocalizeHtmlTitles(type) {
    LocalizeHtmlTitle("btShow");
    LocalizeHtmlTitle("btOpen");
    if (type == 0)
        document.getElementById('btEdit').title = LocalizedString("forbtEdit");
    else
        document.getElementById('btEdit').title = LocalizedString("forbtView");
    LocalizeHtmlTitle("btClose");
    LocalizeHtmlTitle("btReanim");
    LocalizeHtmlTitle("btReg");
    LocalizeHtmlTitle("btRefresh");
    LocalizeHtmlTitle("btFilter");
    LocalizeHtmlTitle("btHistAcc");
    LocalizeHtmlTitle("btHist");
    //LocalizeHtmlTitle("btPrint");
    LocalizeHtmlTitle("btDiscard");
}

function selectKV(tbox) {
    var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=TABVAL&tail=""    &role=', null, 'dialogHeight:600px; dialogWidth:600px');
    if (result != null) {
        document.getElementById(tbox).value = result[0];
    }
}

function getCookie(name) {
    var cookie = " " + document.cookie;
    var search = " " + name + "=";
    var setStr = null;
    var offset = 0;
    var end = 0;
    if (cookie.length > 0) {
        offset = cookie.indexOf(search);
        if (offset != -1) {
            offset += search.length;
            end = cookie.indexOf(";", offset);
            if (end == -1) {
                end = cookie.length;
            }
            setStr = unescape(cookie.substring(offset, end));
        }
    }
    return (setStr);
}
function fnClickLinkAcc() {
    if (selectedRowId == null) {
        alertify.alert("Не вибрано жодного рахунку");
    }
    else {
        var nls = document.getElementById("NLS_" + row_id).innerHTML;
        var lcv = document.getElementById("LCV_" + row_id).innerHTML;

        document.location.href = '/barsroot/customerlist/custacc.aspx?type=6&nls=' + nls + '&lcv=' + lcv + '&mod=ro';
    }
}

function fnClickVal() {
    document.location.href = '/barsroot/customerlist/total_currency.aspx';
}

function fnClickTurn() {
    if (selectedRowId == null) {
        alertify.alert("Не вибрано жодного рахунку");
    }
    else {
        document.location.href = '/barsroot/customerlist/turn4day.aspx?acc=' + selectedRowId;
    }
}
function fnClickTurnPeriod() {

    // window.showModalDialog('/barsroot/customerlist/dlg_date.aspx', top, 'status:no;resizable:no;help:no;scroll:no;dialogWidth:500Px;dialogHeight:400Px');
    document.location.href = '/barsroot/customerlist/dlg_date.aspx';

}

function fnClickClientCard() {
    if (selectedRowId == null) {
        alertify.alert("Не вибрано жодного рахунку");
    }
    else {
        var rnk = document.getElementById("RNK_" + row_id).innerHTML;
        document.location.href = '/barsroot/clientregister/registration.aspx?readonly=1&rnk=' + rnk;
    }
}

function switchView(elem) {
    var showDK = document.getElementById("cbShowDK").checked;
    var showEQ = document.getElementById("cbShowEq").checked;
    v_data[18] = (showEQ) ? ("1") : ("0");
    LoadXslt("Xslt/CustAcc" + colBrach + "_" + ((showDK) ? ("DK_") : ("")) + ((showEQ) ? ("EQ_") : ("")) + getCurrentPageLanguage() + ".xsl");
    InitGrid();
}