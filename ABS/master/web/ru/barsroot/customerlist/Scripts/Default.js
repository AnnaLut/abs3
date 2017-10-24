var accessmode = null;
//Вычитка параметров
function InitDefaultParams() {
    accessmode = getParamFromUrl("accessmode", location.href);
    webService.useService("CustService.asmx?wsdl", "Cust"); //Создание обьэкта вебсервиса	
    var user_params = "PAGESIZE_CUSTLIST;SORT_CUSTLIST";
    //webService.Cust.callService(onGetUserParams,"GetUserParams",user_params,'wr_custlist');
    InitDefault();
}
function onGetUserParams(result) {
    if (!getError(result)) return;
    var params = result.value;
    if (params != "") {
        if (params.split(';')[0] != "")
            pageSize = parseInt(params.split(';')[0]);
        if (params.split(';')[1] != "")
            v_data[3] = params.split(';')[1];
    }
    InitDefault();
}
//---------------------------------------------------------------------
//Инициализация Default.aspx
function InitDefault() {
    var custtype = getParamFromUrl("custtype", location.href);
    LoadDefault();
    LoadXslt("Xslt/Customers_" + getCurrentPageLanguage() + ".xsl");
    v_data[2] = 'AND a.date_off IS NULL';
    CheckCustType();
    var obj = new Object();
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = 'CustService.asmx';
    obj.v_serviceMethod = 'GetData';
    if (accessmode == "0")
        v_data[10] = "_FM";
    //obj.v_serviceFuncAfter = "LoadDefault";
    obj.v_showFilterOnStart = true;
    obj.v_filterTable = "customer";

    var menu = new Array();
    menu[document.all.btKontr.title] = "fnRedirPer()";
    if (accessmode == "0") {
        if (custtype != "0") {
            document.getElementById("btAll").style.visibility = "hidden";
            document.getElementById("btCorp").style.visibility = "hidden";
            document.getElementById("btBank").style.visibility = "hidden";
            document.getElementById("btAcc").style.visibility = "hidden";
        }
        document.getElementById("btReg").style.visibility = "hidden";
        document.getElementById("btClose").style.visibility = "hidden";
        document.getElementById("btResurect").style.visibility = "hidden";
        document.getElementById("btHist").style.visibility = "hidden";
    }
    else {
        menu[document.all.btAcc.title] = "fnRedirAcc()";
        menu[document.all.btHist.title] = "fnShowHist()";
        menu[document.all.btReg.title] = "fnRegKontr()";
        menu[document.all.btClose.title] = "fnCloseKontr()";
    }
    obj.v_menuItems = menu;
    obj.v_customViewState = "CustomVS";
    obj.v_enableViewState = true;
    fn_InitVariables(obj);
    InitGrid();
}
//Проверка типа просматриваемых контрагентов
function CheckCustType() {
    var custtype = getParamFromUrl("custtype", location.href);
    var isSpd = (getParamFromUrl("spd", location.href))?(true):(false);
    if (custtype == "" || custtype == 0) return;
    document.getElementById("btAll").disabled = true;
    setStyleButton(document.getElementById("btAll"), "outset");
    document.getElementById("btCorp").disabled = true;
    document.getElementById("btBank").disabled = true;
    if (custtype == 1) {
        v_data[1] = "AND a.custtype = 1";
        setStyleButton(document.getElementById("btBank"), "inset");
        document.getElementById("btPersonSPD").disabled = true;
        document.getElementById("btPerson").disabled = true;
    }
    else if (custtype == 2) {
        v_data[1] = "AND a.custtype = 2";
        setStyleButton(document.getElementById("btCorp"), "inset");
        document.getElementById("btPersonSPD").disabled = true;
        document.getElementById("btPerson").disabled = true;
    }
    else if (custtype == 3) {
        if (!isSpd) {
            v_data[1] = "AND a.custtype = 3 and trim(a.sed)!=91";
            setStyleButton(document.getElementById("btPerson"), "inset");
        }
        else {
            v_data[1] = "AND a.custtype = 3 and trim(a.sed)='91'";
            setStyleButton(document.getElementById("btPersonSPD"), "inset");
            document.getElementById("btPerson").disabled = true;
        }
    }
    else if (custtype == 4) {
        v_data[1] = "AND a.custtype = 3";
        setStyleButton(document.getElementById("btPerson"), "inset");
        document.getElementById("btCredits").style.visibility = "visible";
    }
    else if (custtype == 5) {
        // ФЛ за исключением ФОПов и частных нотариусов
        v_data[1] = "AND a.custtype = 3 and a.sed != '91' and a.ise not in ('14101', '14201')";
        setStyleButton(document.getElementById("btPerson"), "inset");
    }
}
function fnCredits() {
    if (selectedRowId == null) return;
    document.location.href = "/barsroot/credit/default.aspx?rnk=" + selectedRowId;
}

function CustomVS(obj) {
    obj.btBank = document.getElementById("btBank").style.borderTopStyle;
    obj.btAll = document.getElementById("btAll").style.borderTopStyle;
    obj.btPerson = document.getElementById("btPerson").style.borderTopStyle;
    obj.btPersonSPD = document.getElementById("btPersonSPD").style.borderTopStyle;
    obj.btCorp = document.getElementById("btCorp").style.borderTopStyle;
    obj.btShow = document.getElementById("btShow").style.borderTopStyle;
}
//Load Default.aspx
function LoadDefault() {
    setStyleButton(document.getElementById("btBank"), getViewStateParam("btBank"));
    setStyleButton(document.getElementById("btAll"), getViewStateParam("btAll"));
    setStyleButton(document.getElementById("btPerson"), getViewStateParam("btPerson"));
    setStyleButton(document.getElementById("btPersonSPD"), getViewStateParam("btPersonSPD"));
    setStyleButton(document.getElementById("btCorp"), getViewStateParam("btCorp"));
    setStyleButton(document.getElementById("btShow"), getViewStateParam("btShow"));

    if (document.getElementById("btAll").src == "") {
        document.getElementById("btAll").src = image1.src;
        document.getElementById("btPerson").src = image2.src;
        document.getElementById("btCorp").src = image3.src;
        document.getElementById("btBank").src = image4.src;
        document.getElementById("btShow").src = image5.src;
        document.getElementById("btReg").src = image6.src;
        document.getElementById("btClose").src = image7.src;
        document.getElementById("btResurect").src = image8.src;
        document.getElementById("btRefresh").src = image9.src;
        document.getElementById("btFilter").src = image10.src;
        document.getElementById("btKontr").src = image12.src;
        document.getElementById("btAcc").src = image13.src;
        document.getElementById("btHist").src = image14.src;
        document.getElementById("Choose").src = image15.src;
        document.getElementById("btCredits").src = image16.src;
        document.getElementById("btPersonSPD").src = image17.src;
    }
}

//Открыть счета контрагента
function fnRedirAcc() {
    if (selectedRowId == null) return;
    else {
        if (accessmode == "0")
          document.location.href = "custacc.aspx?type=0&rnk=" + selectedRowId + "&mod=ro";
        else
          document.location.href = "CustAcc.aspx?type=0&rnk=" + selectedRowId;
    }
}
//---------------------------------------------------------------------
//Зарегестрировать контрагента
function fnRegKontr() {
    var custtype = getParamFromUrl("custtype", location.href);
    var url = "/barsroot/clientregister/";
    if (custtype == 1) url += "default.aspx?client=bank";
    else if (custtype == 2) url += "default.aspx?client=corp";
    else if (custtype == 3 || custtype == 4) url += "default.aspx?client=person";
    else url += "default.aspx?client=all";
    document.location.href = url;
}
//---------------------------------------------------------------------
//Закрыть контрагента
function fnCloseKontr() {
    if (selectedRowId == null) return;
    else {
        var message = LocalizedString('Message14') + "(rnk=" + selectedRowId + ")?";
        var result = Dialog(message, 0);
        if (result == 1) webService.Cust.callService(onCloseCustomer, "CloseCustomer", selectedRowId);
    }
}
function onCloseCustomer(result) {
    if (!getError(result)) return;
    if (result.value == "") {
        Dialog(LocalizedString('Message15'), 1);
        ReInitGrid();
    }
    else Dialog(result.value, 1);
}
//---------------------------------------------------------------------
//Ввостановить клиента
function fnResurect() {
    if (selectedRowId == null) return;
    else {
        var message = LocalizedString('Message16') + "(rnk=" + selectedRowId + ")?";
        var result = Dialog(message, 0);
        if (result == 1) webService.Cust.callService(onResurectCustomer, "ResurectCustomer", selectedRowId);
    }
}
function onResurectCustomer(result) {
    if (!getError(result)) return;
    if (result.value == "") {
        Dialog(LocalizedString('Message17'), 1);
        ReInitGrid();
    }
    else Dialog(result.value, 1);
}
//Просмотр контрагента
function fnRedirPer() {
    var custtype = getParamFromUrl("custtype", location.href);
    if (selectedRowId == null) return;
    if (accessmode == "0") {
        if (custtype == "0")
          document.location.href = "/barsroot/clientregister/registration.aspx?readonly=1&rnk=" + selectedRowId;
        else if (document.getElementById("r_" + row_id).BR_OWN == 1)
          document.location.href = "/barsroot/clientregister/registration.aspx?readonly=2&rnk=" + selectedRowId;
        else
          document.location.href = "/barsroot/clientregister/registration.aspx?readonly=3&rnk=" + selectedRowId;
    }
    else {
        if (document.getElementById("r_" + row_id).DAT_OFF != "") {
          document.location.href = "/barsroot/clientregister/registration.aspx?readonly=1&rnk=" + selectedRowId;
        }
        else
          document.location.href = "/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + selectedRowId;
    }
}
//---------------------------------------------------------------------
function fnShowHist() {
    if (selectedRowId == null) return;
    else document.location.href = "CustHistory.aspx?mode=2&rnk=" + selectedRowId + "&type=0";
}
//---------------------------------------------------------------------
//Нажатие
function fnAll() {
    setStyleButton(document.getElementById("btAll"), "inset");
    setStyleButton(document.getElementById("btPerson"), "outset");
    setStyleButton(document.getElementById("btPersonSPD"), "outset");
    setStyleButton(document.getElementById("btCorp"), "outset");
    setStyleButton(document.getElementById("btBank"), "outset");
    v_data[1] = ""; v_data[4] = 0;
    ReInitGrid();
}
function fnPerson() {
    setStyleButton(document.getElementById("btAll"), "outset");
    setStyleButton(document.getElementById("btPerson"), "inset");
    setStyleButton(document.getElementById("btPersonSPD"), "outset");
    setStyleButton(document.getElementById("btCorp"), "outset");
    setStyleButton(document.getElementById("btBank"), "outset");
    v_data[1] = "AND a.custtype = 3 and trim(a.sed)!=91"; v_data[4] = 0;
    ReInitGrid();
}
function fnPersonSPD() {
    setStyleButton(document.getElementById("btAll"), "outset");
    setStyleButton(document.getElementById("btPersonSPD"), "inset");
    setStyleButton(document.getElementById("btPerson"), "outset");
    setStyleButton(document.getElementById("btCorp"), "outset");
    setStyleButton(document.getElementById("btBank"), "outset");
    v_data[1] = "AND a.custtype = 3 and trim(a.sed)=91"; v_data[4] = 0;
    ReInitGrid();
}
function fnCorp() {
    setStyleButton(document.getElementById("btAll"), "outset");
    setStyleButton(document.getElementById("btPerson"), "outset");
    setStyleButton(document.getElementById("btPersonSPD"), "outset");
    setStyleButton(document.getElementById("btCorp"), "inset");
    setStyleButton(document.getElementById("btBank"), "outset");
    v_data[1] = "AND a.custtype = 2"; v_data[4] = 0;
    ReInitGrid();
}
function fnBank() {
    setStyleButton(document.getElementById("btAll"), "outset");
    setStyleButton(document.getElementById("btPerson"), "outset");
    setStyleButton(document.getElementById("btPersonSPD"), "outset");
    setStyleButton(document.getElementById("btCorp"), "outset");
    setStyleButton(document.getElementById("btBank"), "inset");
    v_data[1] = "AND a.custtype = 1"; v_data[4] = 0;
    ReInitGrid();
}
function fnShow() {
    if (document.getElementById("btShow").style.borderTopStyle == "inset") {
        setStyleButton(document.getElementById("btShow"), "outset");
        v_data[2] = "AND a.date_off IS NULL";
    }
    else {
        setStyleButton(document.getElementById("btShow"), "inset");
        v_data[2] = ""; v_data[4] = 0;
    }
    ReInitGrid();
}
//---------------------------------------------------------------------
//Перечитать данные
function fnRefresh() {
    v_data[4] = 0;
    ReInitGrid();
}