//Показать историю изменения клиента
function InitCustHistory() {
    $(".ctrl-date").datepicker({
        changeMonth: true,
        changeYear: true,
        buttonImageOnly: true,
        buttonImage: "/Common/Images/default/16/calendar.png ",
        showButtonPanel: true,
        showOn: "both",
        dateFormat: "dd.mm.yy"
    });
    $(".ctrl-date").attr('readOnly', 'true');

    var el = $("#date1");

    LocalizeHtmlTitles();
    LoadXslt("Xslt/History_" + getCurrentPageLanguage() + ".xsl");
    rnk = getParamFromUrl("rnk", location.href);
    var mode = getParamFromUrl("mode", location.href);
    var type = getParamFromUrl("type", location.href);
    dd_data["cmb1"] = 'dialog.aspx?type=metatab&tail="tabid in (SELECT tabid FROM acc_par WHERE pr=' + mode + ')"&role=wr_metatab&tabname=META_TABLES';
    if (mode == 1)
        lbHist.innerText = LocalizedString('Message12');
    else if (mode == 2)
        lbHist.innerText = LocalizedString('Message13');
    //v_data[3] = 'h.dat desc, t.tabid, h.idupd desc';
    v_data[3] = 'h.idupd desc, h.dat desc, t.tabid';
    v_data[9] = rnk;
    v_data[10] = document.getElementById("date1").value;
    v_data[11] = document.getElementById("date2").value;
    v_data[12] = mode;
    v_data[13] = type;
    var obj = new Object();
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = 'CustService.asmx';
    obj.v_serviceMethod = 'ShowHistory';
    obj.v_serviceFuncAfter = "LoadCustHistory";
    obj.v_notFill = true;
    if (v_data[10] && v_data[11]) {
        obj.v_notFill = false;
    }
    fn_InitVariables(obj);
    InitGrid(v_NotFill);
    if (v_NotFill) {
        LoadCustHistory();
        alertify.alert("Для пошуку вкажіть дату початку і кінця необхідного періоду.");
    }
}
function LoadCustHistory() {
    if (document.getElementById("btRefresh").src == "") {
        document.getElementById("btRefresh").src = image1.src;
        document.getElementById("btClose").src = image3.src;
    }
    if (returnServiceValue) {
        document.getElementById("date1").value = returnServiceValue[2].text;
        document.getElementById("date2").value = returnServiceValue[3].text;
        document.getElementById("lbNmk").innerText = returnServiceValue[4].text;
    }
}
//История
function fnRefreshHist() {
    var filter = "";
    if (document.getElementById('cmb1').value != 0) filter += "AND t.tabid=" + document.getElementById('cmb1').value;
    if (document.getElementById('cmb2').value != 0) filter += "AND c.colid=" + document.getElementById('cmb2').value;
    v_data[0] = filter;
    v_data[10] = document.getElementById("date1").value;
    v_data[11] = document.getElementById("date2").value;

    if (!(v_data[10] && v_data[11])) {
        alertify.alert("Для пошуку вкажіть дату початку і кінця необхідного періоду.");
        return;
    }

    ReInitGrid();
}
function fnCmb1() {
    if (document.getElementById('cmb1').value != "") {
        document.getElementById('cmb2').disabled = false;
        var val = document.getElementById('cmb1').value;
        dd_data["cmb2"] = 'dialog.aspx?type=metatab&tail="tabid=' + val + ' AND colid in (select colid from acc_par where tabid=' + val + ')"&role=wr_metatab&tabname=meta_columns';
    }
}
//Локализация
function LocalizeHtmlTitles() {
    LocalizeHtmlTitle("btRefresh");
    LocalizeHtmlTitle("btClose");
}
function getValueForCmd1(ddlist) {
    if (ddlist.selectedIndex == 1) {
        var result = window.showModalDialog(dd_data[ddlist.id], "", "dialogWidth:450px;center:yes;edge:sunken;help:no;status:no;");
        if (result != null) {
            ddlist.options[1].value = result[0];
            ddlist.options[1].text = result[1];
            fnCmb1();
        }
    }
}