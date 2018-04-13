// Скрипт обслуживающий диалог Info.aspx

// необходимые глобальные переменные

//=================================================

// отрабатываем загрузку страницы
function PageLoad()
{
}

// Перечать договора
function fnDogTextPrint()
{
    var sNd = gE('ctl00_ContentPH_hNd').value;
    var strDialogLink = 'dialog.aspx?type=metatab';
    strDialogLink += '&role=WR_CREDIT';
    strDialogLink += "&tail='ND=" + sNd + "'";
    strDialogLink += '&tabname=CC_V_PK_DOC_SCHEME';
    
    var result = window.showModalDialog(strDialogLink, "", "dialogWidth:650px;center:yes;edge:sunken;help:no;status:no;");
    
    if(result) __doPostBack("__Page", 'evnPrintDog$' + result[0]);
}

// печать графика погашения кредита
function fnGPKPrint()
{
    __doPostBack("__Page", 'evnPrintGPK$');
}
