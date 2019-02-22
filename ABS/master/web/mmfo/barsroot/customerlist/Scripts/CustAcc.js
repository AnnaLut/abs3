//CustAcc
var forceExecute = false;
var v_XsltTemplateFileName;
var filterState="";

function InitCustAccParams() {
    rnk = getParamFromUrl("rnk", location.href);
    type = getParamFromUrl("type", location.href);
    nd = getParamFromUrl("nd", location.href);

    par_kv = getParamFromUrl("kv", location.href);
    par_nbs = getParamFromUrl("nbs", location.href);
    par_ob22 = getParamFromUrl("ob22", location.href);

    LocalizeHtmlTitles(type); // Локализация
    webService.useService("CustService.asmx?wsdl", "CustAcc"); //Создание обьэкта вебсервиса
    InitCustAcc();
    //load from cookie
    if (!window.findls) {
        if (getCookie('kv'))
            gE('tbFindKv').value = getCookie('kv');
        if (getCookie('nls'))
            gE("tbFindNls").value = getCookie('nls');
        if (getCookie('ob22'))
            gE("tbFindOb22").value = getCookie('ob22');
        if (getCookie('nms'))
            gE("tbFindNms").value = getCookie('nms');
        if (getCookie('pap') && gE("ddPap"))
            gE("ddPap").selectedIndex = getCookie('pap');
        if (getCookie('ddBranches') && gE("ddBranches"))
            gE("ddBranches").selectedIndex = getCookie('branch');
        if (getCookie('prevXsltForm')) {
            v_XsltTemplateFileName = getCookie('prevXsltForm');
        }
    }
    /*if (getCookie('ddWhereClause'))
    gE("ddWhereClause").selectedIndex = getCookie('ddWhereClause');*/
}
var colBrach = "";
function InitCustAcc() {
    init_num("tbFindNls");

    var obj = new Object();

    var full = (type == 0) ? (true) : (false);
    v_data[2] = "AND a.dazs IS NULL";
    v_data[9] = getParamFromUrl("rnk", location.href);
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

    if (type == 1) {
        if (gE("ddWhereClause").value != "")
            v_data[1] = gE("ddWhereClause").value;
        colBrach = "Br";
    }
    else if (type == 2) {
        var where = "";
        var nls = gE("tbFindNls").value;
        if (nls)
            where += " and a.nls like '" + nls + "%'";
        v_data[1] = "and a.branch like '" + gE("ddBranches").value + "%'"+where;
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
    var showPerc = document.getElementById("cbShowProc").checked;
    v_data[21] = (showPerc) ? ("1") : ("0");

    //extra parameters 
    v_data[22] = par_kv;
    v_data[23] = par_nbs;
    v_data[24] = par_ob22;

    if (type == 0) document.getElementById("lbType").innerText = LocalizedString('Message1');
    else if (type == 1) document.getElementById("lbType").innerText = LocalizedString('Message2');
    else if (type == 2) document.getElementById("lbType").innerText = LocalizedString('Message3');
    else if (type == 3) document.getElementById("lbType").innerText = LocalizedString('Message4') + nd + ".";
    else if (type == 4) document.getElementById("lbType").innerText = LocalizedString('Message5');
    else if (type == 9) document.getElementById("lbType").innerText = LocalizedString('Message5');

    if (getCookie('prevXsltForm')) {
        v_XsltTemplateFileName = getCookie('prevXsltForm');
        eraseCookie('prevXsltForm');
    } else {
        v_XsltTemplateFileName = "Xslt/CustAcc" + colBrach + "_" + getCurrentPageLanguage() + ".xsl";
    }

    //LoadXslt("Xslt/CustAcc" + colBrach + "_" + getCurrentPageLanguage() + ".xsl");
    LoadXslt(v_XsltTemplateFileName);
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

    obj.v_funcOnSelect = "activateOnSelect";
    obj.v_funcFilterBefore = "toggleNotFillBefore";
    obj.v_funcFilter = "toggleNotFill";
    obj.v_notFill = true;
    if (type == 0
        || (type == 3 && getParamFromUrl("nd", location.href))
        || (type == 5 && getParamFromUrl("bpkw4nd", location.href))
        || (type == 4 && getParamFromUrl("acc", location.href))
        || type == 8
        || type == 9 /* перегляд рахунків угоди з АРМ Цінні Папери ->ЦП Потрфель Загальний */
    ) {
        obj.v_notFill = false;
    }

    fn_InitVariables(obj);
    InitGrid(v_NotFill);
    if (v_NotFill) {
        LoadCustAcc();
        alertify.alert("Для пошуку рахунків вкажіть параметри фільтрування.");
    }
}

function LoadCustAcc() {
    var mod = getParamFromUrl("mod", location.href);
    if (returnServiceValue) {
        document.getElementById("lbNmk").innerText = returnServiceValue[2].text;
        enableButton("btExpExcel");
        enableButton("btShow");
    } else {
        disableButton("btExpExcel");
        disableButton("btShow");
    }
    if (type == 1 || type == 2 || type == 3 || type == 8 || mod == "ro") SetReadOnly();
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
    insertXslRowSelectionTooltip();

    if (v_NotFill) {
        disableButton("btRefresh");
        
    } else {
        enableButton("btRefresh");
    }
}
function SetReadOnly() {
    var mod = getParamFromUrl("mod", location.href);
    v_data[9] = rnk;
    disableButton("btOpen");
    disableButton("btReg");

    if (mod != "del") {
        disableButton("btClose");
        disableButton("btReanim");
    }
}


//функція «співпадіння» щодо виявлення належності клієнта до публічних діячів, осіб близьких або пов’язаними з публічними особами при відкритті РНК клієнту
function fnCheckCustomer(rnk) {
    if (rnk != null && rnk !== undefined) {
        $.ajax({
            type: "POST",
            url: "/barsroot/clientregister/defaultWebService.asmx/GetPublicFlagCust",
            data: JSON.stringify({ rnk: rnk, namels: null }),
            error: function (jqXHR, textStatus, errorThrown) {
                alert("Помилка: " + errorThrown);
            },
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var compositeCode = response.d.CompositeCode;
                if (compositeCode != "") {
                    var nmk = document.getElementById("lbNmk").innerText;
                    var message = "Увага! Виявлено збіг з переліком публічних діячів № в переліку = " + compositeCode + ", (" + nmk + "). \nЗверніться до підрозділу фінансового моніторингу!";
                    alert(message);
                }
                document.location.href = "/barsroot/viewaccounts/accountform.aspx?type=4&acc=0&rnk=" + rnk + "&accessmode=1";
            }
        });
    }
}

//Открыть новый счет 
function fnOpenAcc() {
    //window.location.replace('/barsroot/viewaccounts/accountform.aspx?type=4&acc=0&rnk=' + rnk + "&accessmode=1");
    fnCheckCustomer(rnk);
}

//Просмотр атрибутов счета
function fnViewAcc() {
    if (selectedRowId == null) return;
    else {
        createCookie('prevXsltForm', v_XsltTemplateFileName);
        //document.cookie = 'prevXslForm=' + v_XsltTemplateFileName;
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/custacc/start/"),
            data: { acc: selectedRowId, nbs: "" },
            success: function (result) {
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
	} else {
		var nls = document.getElementById("NLS_" + row_id).innerHTML;
		var vid = document.getElementById("VID_" + row_id).innerHTML;
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
    webService.CustAcc.callService(onExportExcel, "ExportExcel", v_data, forceExecute);
}

function onExportExcel(result) {
    if (!getError(result)) return;
    if (-1 === result.value.indexOf(".xls")) {
        var warningMsg = "<div>Кількість запиcів на вивантаження: <strong>" + result.value + "</strong></div><br/><div>Завантаження може тривати кілька хвилин.</div><br/><div>Ви можете зберегти час, встановивши більше фільтрів пошуку.\nБажаєте встановити додаткові фільтри?</div>";

        alertify.set({
            labels: {
                ok: "Так",
                cancel: "&nbspНі&nbsp"
            },
            modal: true
        });

        alertify.confirm(warningMsg, function (e) {
            if (e) {
                return;
            } else {
                forceExecute = true;
                fnExportToExcel();
            }
        });
    } else {
        forceExecute = false;
        location.href = "/barsroot/cim/handler.ashx?action=download&fname=accounts&file=" + result.value + "&fext=xls";
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
            var vid = document.getElementById("VID_" + row_id).innerHTML;
            var flagEnhCheck = (ModuleSettings && ModuleSettings.Accounts && ModuleSettings.Accounts.EnhanceCloseCheck == true);
            var closureReason = null;
            if (flagEnhCheck && vid != 0) {
                if (document.getElementById('closureReason3').checked) {
                    closureReason = document.getElementById('closureReason3').value;
                } else if (document.getElementById('closureReason5').checked) {
                    closureReason = document.getElementById('closureReason5').value;
                }
            }
            webService.Tmp.callService(onCloseAcc, "CloseAccount", selectedRowId, promptNum, closureReason);
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
    if (!gE("tbFindNls").value && !gE("tbFindRNK").value && v_NotFill) {
        alertify.alert("Не вказаний Pахунок і РНК клієнта");
        return;
    } else if ((gE("tbFindNls").value || gE("tbFindRNK").value) && v_NotFill) {
        v_NotFill = false;
    } else if (!gE("tbFindNls").value && !gE("tbFindRNK").value) { v_NotFill = true; }

    var where = "";

    var ob22 = gE("tbFindOb22").value;
    if (ob22)
        where += " and a.ob22 like '" + ob22 + "%'";

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
    document.cookie = "kv=" + escape(kv);
    document.cookie = "nls=" + escape(nls);
    document.cookie = "nms=" + escape(nms);
    document.cookie = "pap=" + gE("ddPap").selectedIndex;
    if (gE("ddBranches"))
        document.cookie = "branch like" + gE("ddBranches").selectedIndex + "%'";
    if (gE("ddWhereClause"))
        document.cookie = "ddWhereClause=" + gE("ddWhereClause").selectedIndex;

    document.cookie = "ob22=" + escape(ob22);

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
    else {
        createCookie('prevXsltForm', v_XsltTemplateFileName);
        //window.location.replace("showhistory.aspx?acc=" + selectedRowId + "&type=" + type);
        document.location.href = "showhistory.aspx?acc=" + selectedRowId + "&type=" + type;
    }
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
    //document.location.href = '/barsroot/customerlist/total_currency.aspx';
    document.location.href = '/barsroot/customerlist/customerlist/totalcurrency';
}

function fnClickTurn() {
    if (selectedRowId == null) {
        alertify.alert("Не вибрано жодного рахунку");
    }
    else {
        document.location.href = '/barsroot/customerlist/turn4day.aspx?acc=' + selectedRowId;
    }
}

function getParamFromUrlIfExists(param) {
	var p = getParamFromUrl(param, location.href);
	if (p !== "") {
		return "&" + param + "=" + p;
	}
	return "";
}
function fnClickTurnPeriod() {

    // window.showModalDialog('/barsroot/customerlist/dlg_date.aspx', top, 'status:no;resizable:no;help:no;scroll:no;dialogWidth:500Px;dialogHeight:400Px');
	document.location.href = '/barsroot/customerlist/dlg_date.aspx?rnk=' + v_data[9] + getParamFromUrlIfExists("nd");

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
    var showPerc = document.getElementById("cbShowProc").checked;

    v_data[18] = (showEQ) ? ("1") : ("0");
    v_data[21] = (showPerc) ? ("1") : ("0");
    v_data[25] = (showDK) ? ("1") : ("0");

    v_XsltTemplateFileName = "Xslt/CustAcc" + colBrach + "_" + ((showDK) ? ("DK_") : ("")) + ((showEQ) ? ("EQ_") : ("")) + ((showPerc) ? ("PRC_") : ("")) + getCurrentPageLanguage() + ".xsl"

    LoadXslt(v_XsltTemplateFileName);
    InitGrid();
}

function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else var expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

function eraseCookie(name) {
    createCookie(name, "", -1);
}

function activateOnSelect() {
    if ("2" == type) {
        enableButton("btClose");
    }
}

function enableButton(btnName) {
    if (btnName) {
        var btn = document.getElementById(btnName);
        btn.style.filter = "";
        btn.disabled = false;
    }
}

function disableButton(btnName) {
    if (btnName) {
        var btn = document.getElementById(btnName);
        btn.style.filter = 'progid:DXImageTransform.Microsoft.Alpha( style=0,opacity=25)progid:DXImageTransform.Microsoft.BasicImage(grayScale=1)';
        btn.disabled = true;
    }
}

function toggleNotFillBefore() {
    if (!v_data[0].isEmpty() || !v_data[20].isEmpty()) {
        v_NotFill = false;
    }
    if (filterState != v_data[0] + v_data[20]) {
        v_NotFill = false;
    }
}
function toggleNotFill() {
    if (v_data[0].isEmpty() && v_data[20].isEmpty()) {
        v_NotFill = true;
    }
    filterState = v_data[0] + v_data[20];
}

String.prototype.isEmpty = function () {
    return (this.length === 0 || !this.replace(/^\s+|\s+$/g, ''));    
};