var g_gridCounter = 0;
var g_gridDocForKvitCounter = 0;

//*** Start Centura parameters ***
var g_isClaims = false;
var g_strIoInd = "O";               // available: '0', 'I'
var g_sUserF = 1;                   // available: 0, number
var g_strPar02 = 'F';               // available: 'E', 'N', 'F', 'EN'
var g_sFILTRS = {
    urgently: "v.swref in (select swref from SW_OPERW where tag='72' and value like '%EARLY%' ) and",
    noturgently: "v.swref NOT in (select swref from SW_OPERW where tag='72' and value like '%EARLY%' ) and"
};
var g_sFILTR = "";
//*** End Centura parameters ***
var g_globalOptionsIds = ['SW_D07', 'SWT_DESC', 'SWTVFDOC', 'SWTDVCUR', 'SWTDVMNI', 'SWTDVMAX', 'SW_NR20', 'VISASIGN', 'CRYPTO_CA_KEY'];
var g_globalOptionsValues = null;

var g_initedGridDocForKvit = false;
var g_DocForKvit = null;

// doc kvit buttons filters
var g_pbTimerOn = false;
var g_pbTimerOnID = null;
var g_pbTimerOnTime = 3.0*60.0*1000.0;
var g_swiftUsers = null;

var g_mainGridNeedSelectFirstRow = false;
var g_mainGridInited = false;

var g_gridMainSelected = null;

var IS_DEBUG = false;

var g_specSymbols = ['\b', '\f', '\n', '\r', '\t'];

function DebugLog(obj) {
    if(IS_DEBUG){
        console.log(obj);
    }
}

function parseNLS(sValu) {
    var NLS_B = "";
    var nlsMinLen = 4;
    var initIndex = -1;
    for(var i = 1; i < sValu.length; i++){
        if(sValu[i] != "" && !isNaN(sValu[i])){
            if(initIndex == -1 && (i + nlsMinLen) <= sValu.length){
                var isNls = true;
                for(var j = i+1; j < nlsMinLen; j++){
                    if(isNaN(sValu[j]) || sValu[i] == ""){
                        isNls = false;
                        break;
                    }
                }
                if(isNls){
                    initIndex = i;
                }
            }
            if(initIndex != -1){
                NLS_B += sValu[i];
            }
        }
        else if(initIndex != -1){
            break;      // end of NLS number
        }
    }
    return NLS_B;
}

function linkToSWREF(SWREF) {
    return '<a href="#" onclick="OpenSWREF(\''+SWREF+'\')" style="color: blue">' + SWREF + '</a>';
}

function OpenSWREF(SWREF) {
    if(SWREF != null && SWREF !== "null"){
        OpenBarsDialog("/barsroot/documentview/view_swift.aspx?swref=" + SWREF);
    }
    else{ bars.ui.error({ title: 'Помилка', text: "Неправильний SWREF!" }); }
}

var g_mainColumns = [
    {
        field: "block",
        title: "",
        filterable: false,
        sortable: false,
        template: "<input type='checkbox' class='chkFormols' />",
        headerTemplate: "<input type='checkbox' class='chkFormolsAll' id='check-all' onclick='checkAll(this)' title='Всі'/>",
        width: "3%"
    },
    // {
    //     title: "№ п/п",
    //     template: "#= ++g_gridCounter #",
    //     width: "4%"
    // },
    {
        template:'#= linkToSWREF(SWREF) #',
        field: "SWREF",
        title: "Реф.",
        width: "8%"
    },
    {
        field: "MT",
        title: "Тип",
        width: "4%"
    },
    {
        field: "IO_IND",
        title: "Вх-Вих",
        width: "4%"
    },
    {
        field: "SENDER",
        title: "Відправник"
        //width: "40px"
    },
    {
        field: "TRN",
        title: "SWIFT реф."
        //width: "50px"
    },
    // {
    //     field: "SENDER_NAME",
    //     title: "Відправник",
    //     width: "15%"
    // },
    // {
    //     field: "RECEIVER",
    //     title: "RECEIVER",
    //     width: "10%"
    // },
    // {
    //     field: "RECEIVER_NAME",
    //     title: "Отримувач",
    //     width: "15%"
    // },
    // {
    //     field: "PAYER",
    //     title: "PAYER",
    //     width: "10%"
    // },
    // {
    //     field: "PAYEE",
    //     title: "PAYEE",
    //     width: "10%"
    // },
    {
        field: "CURRENCY",
        title: "Вал",
        width: "4%"
    },
    // {
    //     field: "KV",
    //     title: "KV",
    //     width: "10%"
    // },
    // {
    //     field: "DIG",
    //     title: "DIG",
    //     width: "10%"
    // },
    {
        field: "AMOUNT",
        title: "Сума",
        template: '#=kendo.toString(AMOUNT,"n")#',
        format: '{0:n}',
        attributes: { "class": "money" },
        width: "8%"
    },
    // {
    //     field: "ACCD",
    //     title: "ACCD",
    //     width: "10%"
    // },
    // {
    //     field: "ACCK",
    //     title: "ACCK",
    //     width: "10%"
    // },
    {
        field: "DATE_IN",
        title: "Дата надходження",
        width: "13%",
        template: "<div style='text-align:center;'>#=(DATE_IN == null) ? ' ' : kendo.toString(DATE_IN,'dd.MM.yyyy  HH:mm:ss')#</div>"
    },
    {
        field: "VDATE",
        title: "Дата валют.",
        width: "7%",
        template: "<div style='text-align:center;'>#=(VDATE == null) ? ' ' : kendo.toString(VDATE,'dd.MM.yyyy')#</div>"
    }
    // {
    //     field: "DATE_REC",
    //     title: "DATE_REC",
    //     width: "10%",
    //     template: "<div style='text-align:center;'>#=(DATE_REC == null) ? ' ' : kendo.toString(DATE_REC,'dd.MM.yyyy')#</div>"
    // },
    // {
    //     field: "DATE_PAY",
    //     title: "DATE_PAY",
    //     width: "10%",
    //     template: "<div style='text-align:center;'>#=(DATE_PAY == null) ? ' ' : kendo.toString(DATE_PAY,'dd.MM.yyyy')#</div>"
    // },
    // {
    //     field: "VDATE",
    //     title: "VDATE",
    //     width: "10%",
    //     template: "<div style='text-align:center;'>#=(VDATE == null) ? ' ' : kendo.toString(VDATE,'dd.MM.yyyy')#</div>"
    // },
    // {
    //     field: "ID",
    //     title: "Виконавець",
    //     width: "10%"
    //     ,editor: categoryDropDownEditor
    //     ,template: "#= getDDNameById(ID) #"
    // }
    // {
    //     field: "FIO",
    //     title: "Виконавець",
    //     width: "10%"
    // }
    // {
    //     field: "TRANSIT",
    //     title: "TRANSIT",
    //     width: "10%"
    // },
    // {
    //     field: "TAG20",
    //     title: "TAG20",
    //     width: "10%"
    // }
];

function getDDNameById(id) {
    return getNameById(id, g_swiftUsers, 'ID', 'FIO');
}

function categoryDropDownEditor(container, options) {
    $('<input required name="' + options.field + '"/>')
        .appendTo(container)
        .kendoDropDownList({
            dataTextField: "FIO",
            dataValueField: "ID",
            dataSource: {data: g_swiftUsers}
        });
}


function preFormated(data) { return '<pre>' + data + '</pre>'; }

function getGlobalOption(ID) {
    return (g_globalOptionsValues != null && g_globalOptionsValues[ID] != null) ?
        g_globalOptionsValues[ID].Value : null;
}

function docinput(data, APROC, BPROC) {
    var title = "Створення платежу референції №";
    var url = "/docinput/docinput.aspx?";
    var first = true;
    for(var key in data){
        if(key === "SWREF"){
            title += data[key];
        }
        else{
            var value = key + "=" + data[key];
            if(first){
                first = false;
            }
            else{
                value = "&" + value;
            }
            url += value;
        }
    }
    // enable checkbox in document form
    url += "&attrMode=1";
    if(APROC != null && APROC != ""){
        url += "&APROC=" + APROC;
    }
    if(BPROC != null && BPROC != ""){
        url += "&BPROC=" + BPROC;
    }

    bars.ui.dialog({
        title: title,
        content: {
            url: bars.config.urlContent(url)
        },
        modal: false,
        close: function () {
            var win = this;
            var windowElement = $("#barsUiAlertDialog");
            var iframeDomElement = windowElement.children("iframe")[0];
            var iframeWindowObject = iframeDomElement.contentWindow;
            var iframeDocumentObject = iframeDomElement.contentDocument;

            if(iframeDocumentObject.getElementById("OutRef") == null){
                bars.ui.error({ title: 'До відома', text: 'Документ не оплачено!'});
                return;
            }

            var ref = iframeDocumentObject.getElementById("OutRef").value;
            // OK!!!!
            if (ref) {
                //bars.ui.alert({ text: "Операція успішно виконана." });
                g_mainGridNeedSelectFirstRow = true;
                updateMainGrid();

                // if(g_strPar02.indexOf('EN') != -1){
                //     stmtDocumentLink(data.SWREF, g_sUserF, ref);  //  nIsp = nN -> userID | g_sUserF
                // }
                // else{
                //     impmsgDocumentLink(ref, data.SWREF, false);
                // }
            }
            else {
                bars.ui.error({ title: 'До відома', text: 'Документ не оплачено!'});
            }
        },

        iframe: true,
        width: '650px',
        height: '600px',
        buttons: [{
            text: 'Закрити',
            click: function () {
                var win = this;
                win.close();
            }
        }]
    });
}

function SearchDocForKvit() {
    var gridMain = $("#gridMain").data("kendoGrid");
    var selectedItemMain = gridMain.dataItem(gridMain.select());

    g_DocForKvit = { isDocForKvit2 :$("#searchDocForKvit2").is(":visible") };
    if(g_DocForKvit['isDocForKvit2']){
        g_DocForKvit['strVDocMin'] = kendo.toString($("#searchDate1").data("kendoDatePicker").value(), "dd/MM/yyyy");
        g_DocForKvit['strVDocMax'] = kendo.toString($("#searchDate2").data("kendoDatePicker").value(), "dd/MM/yyyy");
    }
    else{
        function checkDate(id, globalKey, direct) {
            var nVDoc = g_globalOptionsValues[globalKey].Value ? parseInt(g_globalOptionsValues[globalKey].Value) : 0;
            var strVDoc = new Date(selectedItemMain.VDATE);
            strVDoc.setDate(strVDoc.getDate() + nVDoc*direct);
            g_DocForKvit[id] = kendo.toString(strVDoc, "dd/MM/yyyy")
        }
        checkDate("strVDocMin", 'SWTDVMNI', -1);
        checkDate("strVDocMax", 'SWTDVMAX',  1);
    }

    if (selectedItemMain) {
        g_DocForKvit['Ccy'] = selectedItemMain.CURRENCY;

        g_DocForKvit['AccDb'] = null;
        g_DocForKvit['AccKr'] = null;
        g_DocForKvit['Amnt'] = null;
        g_DocForKvit['Tag20'] = null;
        g_DocForKvit['Ref'] = $('#searchRef').val() != "" ? $('#searchRef').val() : null;

        if($('#pbPreFilter').prop("checked")){
            g_DocForKvit['AccDb'] = selectedItemMain.ACCD;
            g_DocForKvit['AccKr'] = selectedItemMain.ACCK;
            g_DocForKvit['Amnt'] = selectedItemMain.AMOUNT*100.0;
        }

        if($('#pbFilterSwRef').prop("checked")){
            g_DocForKvit['Tag20'] = selectedItemMain.TAG20;
            g_DocForKvit['Amnt'] = selectedItemMain.AMOUNT*100.0;
        }
    }

    DebugLog(g_DocForKvit);

    WaitingForID(true, ".search-docForKvit");
    if(g_initedGridDocForKvit){
        updateGridDocForKvit();
    }
    else{
        g_initedGridDocForKvit = true;
        initGridDocForKvit();
    }
}

// Global Option - wtf?
function loadGlobalOption() {
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/loadglobaloption"),
        success: function (data) {
            g_globalOptionsValues = {};
            for(var i = 0; i < g_globalOptionsIds.length; i++){
                g_globalOptionsValues[g_globalOptionsIds[i]] = data[g_globalOptionsIds[i]];
            }
            // console.log(g_globalOptionsValues);
        },
        complete: function(jqXHR, textStatus){ },
        error: function (jqXHR, textStatus, errorThrown) {
            bars.ui.error({ title: 'Помилка', text: "Не вдалось прочитати глобальні дані! Перезавантажте сторінку." });
        },
        data: JSON.stringify(g_globalOptionsIds)
    } });
}

function fullPaymentData(mainRow, opCodeRow) {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/fullpaymentdata"),
        success: function (data) {
            if(data != null){

                Waiting(false);

                DebugLog(mainRow);

                var sCharSet = data.TransbackInfo.chrset;
                var nTransBack = data.TransbackInfo.transback;

                var strNlsA = mainRow.NLSA;
                //var strNlsB = mainRow.NLSB;

                var nTmpS = (mainRow.AMOUNT * 100.0).toFixed(2);

                var nTmp = -1;
                var nFlg = -1;
                var nDigB = 0;
                var fCanTranslit = false;

                var strMfoB = data.ImpDocParams.p_docMfoB;
                // var nKvA_TT = data.ImpDocParams.p_docCurCode;
                var strNlsB = data.ImpDocParams.p_docAccNum;
                var strOkpoB = data.ImpDocParams.p_docRcvrId;
                var strNamB = data.ImpDocParams.p_docRcvrName;
                var nAmnt = data.ImpDocParams.p_docAmount;
                var dtVDat = data.ImpDocParams.p_docValueDate;

                if(g_strPar02.indexOf('F') != -1){
                    strOkpoB = data.PGetRcvr.okpo_;
                    strMfoB = data.PGetRcvr.mfo_;
                    strNlsB = data.PGetRcvr.nls_;
                    nTmp = data.PGetRcvr.kv_;
                    strNamB = data.PGetRcvr.nazv_;
                    nAmnt = data.PGetRcvr.sum_;
                    dtVDat = data.PGetRcvr.datv_;
                    nFlg = data.PGetRcvr.val_;
                }

                var payDate = null;
                var bankDate = null;
                try{
                    payDate = new Date(parseInt(dtVDat.substr(6)));
                }
                catch (ex){
                    payDate = dtVDat;   // error
                    if(IS_DEBUG){console.warn("Can't convert payDate "+dtVDat);}
                }
                if(payDate == null){
                    payDate = mainRow.VDATE;
                }

                try{
                    bankDate = new Date(parseInt(data.Bankdate.substr(6)));
                }
                catch (ex){
                    bankDate = data.Bankdate;   // error
                    if(IS_DEBUG){console.warn("Can't convert bankDate "+data.Bankdate);}
                }

                var sTT = opCodeRow.TT;
                var dfNazn = "";
                //nId   = GetUserId()

                var sTTN = data.Payment.name;
                var sFlags = data.Payment.flags;
                var nFli = data.Payment.fli;
                var nFlv = data.Payment.flv;
                var nDk = data.Payment.dk;
                var nSk = data.Payment.sk;
                var sTNlsA = data.Payment.nlsa;
                var sTNlsB = data.Payment.nlsb;
                var nKvA_TT = data.Payment.KV;
                var nKvB_TT = data.Payment.KVK;

                //**
                var aFlg = sFlags.split("");    // create Array
                aFlg[3] = "1";      //date valut

                //**
                var bFixValD1 = true;
                var dFixValD1 = payDate;

                if((getGlobalOption('SWTDVCUR') === '1') ||
                    (nFli === 1 && (getGlobalOption('SWTVFDOC') !== '1' || payDate < bankDate))){
                    dFixValD1 = bankDate;
                }

                //**
                if(mainRow.CURRENCY){
                    if(!nFlv){
                        nKvB_TT = data.CurrencyCode.KV;
                        nDigB   = data.CurrencyCode.DIG;
                    }
                }

                var nS = nAmnt;     //nAmnt/SalNumberPower(10, nDigA);
                // if(nS === 0){
                //     nS = null;
                // }

                var sNlsA_TT = (nDk === 1 || nDk === 3) ? ((strNlsA) ? strNlsA : sTNlsA) : ((strNlsB) ? strNlsB : sTNlsA);
                var sNlsB_TT = (nDk === 1 || nDk === 3) ? ((strNlsB) ? strNlsB : sTNlsB) : ((strNlsA) ? strNlsA : sTNlsB);

                //

                DebugLog({sTT:sTT, nDk:nDk, mainRow_MT:mainRow.MT});

                if((sTT === 'D07' && getGlobalOption('SW_D07') === "1")){
                    strOkpoB = "";
                    //strNamB = "";
                    nS = nTmpS;
                    sNlsB_TT = "";
                }

                if(nS == null || nS === 'null'){
                    if(IS_DEBUG){console.warn("nS = null "+nS);}
                    nS = 0;     // bad
                }
                if(nS === 0){
                    nS = nTmpS;        // get sum from main form
                }
                if((sTT === 'D07' && getGlobalOption('SW_D07') === "1")){
                    dfNazn = 'Комісія за п/д на суму ' + kendo.toString(nAmnt/100.0, "n");
                    dfNazn += " " + mainRow.CURRENCY;

                    if(payDate != null && payDate !== 'null'){
                        dfNazn += ' від ' + kendo.toString(payDate,'dd/MM/yyyy');
                    }
                    if(data['BankName'].sNameBank != null && data['BankName'].sNameBank !== "null"){
                        dfNazn += ' - ' + data['BankName'].sNameBank;
                    }

                    if(strNamB != null && strNamB != ""){
                        dfNazn += " "+strNamB;
                    }

                    else if(IS_DEBUG){
                        console.warn("sNameBank ="+data['BankName'].sNameBank);
                    }
                }

                if(sTT === '830' && getGlobalOption('SW_D07') === "1" && (mainRow.MT === 490 || mainRow.MT === 456)){
                    sNlsB_TT = sNlsA_TT;
                    sNlsA_TT = "";
                }

                var sBankB_TT = (strMfoB != null && strMfoB !== "null") ? strMfoB : "";

                if(aFlg[9] === "0"){
                    var nSk_TT = "";
                }

                fCanTranslit = (mainRow.TRN.indexOf('+') == 0) || nTransBack;
                if(mainRow.TRN.indexOf('+') == 0)        //SalStrLeftX( sMtRef, 1) = '+'
                {
                    sCharSet = 'RUR6';
                }
                else if(!sCharSet){
                    sCharSet = 'TRANS';
                }

                /////// Multiline Field: dfSwtMes ////////
                var dfSwtMes = 'From: ' + mainRow.SENDER + ', ' + 'To: ' + mainRow.RECEIVER;

                // mt=103 and 53, 54 logic

                var mt_103_830_nlsb = {};

                var DRESDEFF = false;
                var COSBUAUK = false;

                var dfValD1 = null;

                data.OperwData.forEach(function (element, index, array) {
                    var sTag = element.tag;
                    var sOpt = element.opt;
                    var sValu = element.value;
                    var swift2Str = element.swift2Str;

                    var sTmp = ':' + sTag + sOpt + ':' + sValu;
                    dfSwtMes = dfSwtMes + sTmp;

                    if(mainRow.MT === 103){
                        if(sTag === '53' && sValu != null){
                            DRESDEFF = sValu.indexOf("DRESDEFF") != -1;
                        }
                        if(sTag === '54' && sValu != null){
                            COSBUAUK = sValu.indexOf("COSBUAUK") != -1;
                        }
                    }
                    var i,v;
                    if(mainRow.MT === 202){
                        if(sTT == '830' && sTag === '59' || sTag === '58' && sValu != null){
                            v = replaceAll(sValu, " ", "");
                            for(i = 0; i < g_specSymbols.length; i++){
                                v = replaceAll(v, g_specSymbols[i], "");
                            }
                            sNlsB_TT = parseNLS(v);
                        }
                    }

                    if(mainRow.MT === 103 && sTT == '830' && sValu != null){
                        if(sTag === '57' || sTag === '59' || sTag === '72'){
                            v = replaceAll(sValu, " ", "");
                            for(i = 0; i < g_specSymbols.length; i++){
                                v = replaceAll(v, g_specSymbols[i], "");
                            }
                            mt_103_830_nlsb[sTag] = parseNLS(v);
                        }
                    }

                    if(sTag === '32'){
                        sTmp = sValu.substr(0, 6);
                        var y = "20" + sTmp.substr(0, 2);
                        var m = sTmp.substr(2, 2);
                        var d = sTmp.substr(4, 4);
                        dfValD1 = d+"/"+m+"/"+y;        //dd/MM/yyyy
                    }
                    if(sTag === '70'){
                        if(fCanTranslit){
                            sValu = swift2Str;          // swift2Str = SqlCreator.SwiftToStr
                        }
                        if(getGlobalOption('SWT_DESC') === '1'){
                            dfNazn = dfNazn + sValu;
                        }
                    }
                });

                if(mainRow.MT === 103 && sTT == '830'){
                    if(mt_103_830_nlsb['57'] != undefined && mt_103_830_nlsb['57'].length > 4){
                        sNlsB_TT = mt_103_830_nlsb['57'];
                    }
                    else if(mt_103_830_nlsb['72'] != undefined && mt_103_830_nlsb['72'].length > 4){
                        sNlsB_TT = mt_103_830_nlsb['72'];
                    }
                    else if(mt_103_830_nlsb['59'] != undefined && mt_103_830_nlsb['59'].length > 4){
                        sNlsB_TT = mt_103_830_nlsb['59'];
                    }
                }

                if(g_strPar02.indexOf('E') != -1 && g_strPar02.indexOf('N') != -1 && getGlobalOption('SWT_DESC') === '1'){
                    dfNazn = dfNazn + data.TT;
                }

                // debugger;
                //////////////////////////////////////////
                //********** replace null values **********
                if (sNlsA_TT == null || sNlsA_TT === "null") {
                    if(IS_DEBUG){console.warn("sNlsA_TT = null "+sNlsA_TT);}
                    sNlsA_TT = "";
                }
                if (strOkpoB == null || strOkpoB === "null") {
                    if(IS_DEBUG){console.warn("strOkpoB = null "+strOkpoB);}
                    strOkpoB = "";
                }
                if (nKvA_TT == null || nKvA_TT === "null") {
                    if(IS_DEBUG){console.warn("nKvA_TT = null "+nKvA_TT);}
                    //nKvA_TT = nKvB_TT;
                    nKvA_TT = mainRow.KV;
                }
                if (sNlsB_TT == null || sNlsB_TT === "null") {
                    if(IS_DEBUG){console.warn("sNlsB_TT = null "+sNlsB_TT);}
                    sNlsB_TT = "";
                }
                if (strNamB == null || strNamB === "null") {
                    if(IS_DEBUG){console.warn("strNamB = null "+strNamB);}
                    strNamB = "";
                }

                dfNazn = replaceAll(dfNazn, "'", " ");

                // mt=103 and 53, 54 logic
                if(mainRow.MT === 103){
                    var NLS_V_CORR_ACC = data.NLS_V_CORR_ACC;
                    if(NLS_V_CORR_ACC != null && NLS_V_CORR_ACC != ""){
                        sNlsA_TT = NLS_V_CORR_ACC;
                    }

                    if(DRESDEFF && COSBUAUK){
                        sNlsA_TT = "";
                    }
                }
                if (( sTT == '830' && mainRow.MT === 900)) {
                    if (mainRow.NLSB != null && mainRow.NLSB != "") {
                        sNlsB_TT = mainRow.NLSB;
                    }
                }
                if((mainRow.MT === 900 || mainRow.MT === 190) && sTT === 'D07'){
                    if (mainRow.NLSB != null && mainRow.NLSB != "") {
                        sNlsA_TT = mainRow.NLSB;
                    }
                }
                ///

                //*****************************************
                var docinputData = {
                    SWREF: mainRow.SWREF,
                    tt: sTT,
                    Id_A: "",
                    Nls_A: sNlsA_TT,
                    Kv_A: nKvA_TT,
                    Nam_A: "",
                    Id_B: strOkpoB,
                    Nls_B: sNlsB_TT,
                    Kv_B: nKvB_TT,
                    Nam_B: strNamB,
                    Mfo_B: sBankB_TT,
                    Nazn: dfNazn
                };
                if(dfValD1 != null){
                    docinputData["DatV"] = dfValD1;
                }

                if((getGlobalOption('SW_D07') === "1" && sTT === 'D07') || sTT === 'D06'){
                    docinputData['SumA_t'] = nS;
                    docinputData['SumB_t'] = nDigB;
                }
                else{
                    docinputData['SumC_t'] = nS;
                }

                // if(sTT === "D90"){
                //     docinputData['flag_se'] = 1;        //enable edit sum
                // }
                docinputData['flag_se'] = 1;        //enable edit sum
                if (mainRow.MT === 103 || mainRow.MT === 190) {
                    docinputData['Nls_A_Editable'] = 1;
                }

                var APROC_sw_190 = mainRow.MT === 190 && sTT === 'D07' ? "bars_swift.pay_190_stmt(:REF, " + mainRow.SWREF + ");" : "";
                var user = g_sUserF != 0 ? "user_id()" : "0";
                var APROC = "";
                if(g_strPar02.indexOf('EN') != -1){
                    APROC = encodeURI("set role bars_access_defrole@begin bars_swift.stmt_document_link(" + mainRow.SWREF + ", " + user + ", bars_swift.t_listref(:REF), 0);" + APROC_sw_190 + " end;");
                }
                else{
                    APROC = encodeURI("set role bars_access_defrole@begin bars_swift.impmsg_document_link(:REF, " + mainRow.SWREF + "); bars.p_swt_copy_attribute(:REF);" + APROC_sw_190 + " end;");
                }

                var BPROC = "";
                if(nFli === 1){ // todo: investigate this
                    //BPROC = encodeURI("set role bars_access_defrole@begin bars_swift.impmsg_document_storetag(:REF, " + data["SWREF"] + ", " + user + "); end;");
                }

                DebugLog(docinputData);
                docinput(docinputData, APROC, BPROC);
            }
            else{
                //error
                Waiting(false);
            }
        },
        complete: function(jqXHR, textStatus){ },
        data: JSON.stringify({
            SENDER: mainRow.SENDER,
            SWREF: mainRow.SWREF,
            SLCV: mainRow.CURRENCY,
            TT: opCodeRow.TT,
            IS_IMPMSGDOCGETPARAMS: (g_strPar02.indexOf('F') != -1),
            g_sUserF: g_sUserF,
            is_TransactionType: (g_strPar02.indexOf('E') != -1 && g_strPar02.indexOf('N') != -1 && getGlobalOption('SWT_DESC') === '1')
        })
    } });
}

function impmsgDocumentLink(REF, SWREF, isCloseDocForKvit) {
    Waiting(true);
    if(isCloseDocForKvit){
        WaitingForID(true, ".search-docForKvit");
    }
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/impmsgDocumentLink"),
        success: function (data) {
            bars.ui.alert({ text: "Операція успішно виконана." });
            g_mainGridNeedSelectFirstRow = true;
            updateMainGrid();
            if(isCloseDocForKvit){
                WaitingForID(false, ".search-docForKvit");
                $("#dialogDocForKvit").data('kendoWindow').close();
            }
        },
        complete: function(jqXHR, textStatus){ Waiting(false); if(isCloseDocForKvit){WaitingForID(false, ".search-docForKvit");} },
        // IsKvit2 - using procedure without dates limitation
        data: JSON.stringify( { REF: REF, SWREF: SWREF, IsKvit2: $("#searchDocForKvit2").is(":visible") })
    } });
}

function stmtDocumentLink(nSwRef, sUserF, m_nRef) {
    Waiting(true);
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/stmtdocumentlink"),
        success: function (data) {
            bars.ui.alert({ text: "Операція успішно виконана." });
            updateMainGrid();
        },
        complete: function(jqXHR, textStatus){ Waiting(false); },
        data: JSON.stringify( { nSwRef: nSwRef, sUserF: sUserF, m_nRef: m_nRef })
    } });
}

function usersLod(io) {
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/swiftusers"),
        success: function (data) {
            g_swiftUsers = data;
        },
        complete: function(jqXHR, textStatus){ },
        data: JSON.stringify({io: io })
    } });
}

//  arrMsg<number>
function messageDelete(arrMsg) {
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/impmsgmessagedelete"),
        success: function (data) {
            bars.ui.notify("Видалення", "Вибрані повідомлення успішно видалені", 'success', {autoHideAfter: 5*1000});
            g_mainGridNeedSelectFirstRow = true;
            updateMainGrid();
        },
        error: function(jqXHR, textStatus, errorThrown){
            //bars.ui.alert({ text: "Помилка видалення повідомлень." });
        },
        data: JSON.stringify(arrMsg)
    } });
}

// messages<Array>   = [ {SWREF:1, ID:123, TARGET_ID:null}, ..., ]
function messageChangeUser(messages, linkedUserFIO) {
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/impmsgmessagechangeuser"),
        success: function (data) {
            if(g_sUserF === 1){
                bars.ui.notify("Розподілення", "Операцію успішно виконано", 'success', {autoHideAfter: 5*1000});
            }
            else{
                bars.ui.notify("Розподілення", "Вибрані повідомлення успішно розподілено "+linkedUserFIO, 'success', {autoHideAfter: 5*1000});
            }
            g_mainGridNeedSelectFirstRow = true;
            updateMainGrid();
        },
        error: function(jqXHR, textStatus, errorThrown){
            //bars.ui.alert({ text: "Помилка розподілення повідомлень." });
        },
        data: JSON.stringify(messages)
    } });
}

function GetAndFillRowData(SWREF, SENDER, RECEIVER) {
    // console.log(SWREF, SENDER, RECEIVER);
    Waiting(true);
    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: 'application/json',
        data: JSON.stringify( { SWREF: SWREF, SENDER: SENDER, RECEIVER: RECEIVER }),
        url: bars.config.urlContent("/api/claimsrowdatacent"),
        complete: function (jqXHR, textStatus) { Waiting(false); },
        success: function (data) {
            // console.log(data);
            var line = "";
            // line += "Sender  :\t" + data['SenderTitle'][0].name + "\n";
            // line += "Receiver:\t" + data['ReceiverTitle'][0].name + "\n";

            line += "Sender  :\t" + SENDER + "\n";
            line += "Receiver:\t" + RECEIVER + "\n";

            if(data["Data"].length > 0){
                line += data["Data"][0]["RESULT"];
            }

            // for (var i = 0; i < data["Data"].length; i++) {
            //     var o = data["Data"][i];
            //     if (o.VALUE !== "" && o.VALUE != null) {
            //         var key = "\t" + o.TAG;
            //         if (o.OPT !== "" && o.OPT != null) {
            //             key += o.OPT;
            //         }
            //         line += PadRight(key, 6, ' ');
            //
            //         var value = Replace(o.VALUE, '\r', ' ');
            //         value = Replace(value, '\n', ' ');
            //
            //         line += ":\t" + value;
            //         if (i < data["Data"].length) {
            //             line += '\n';
            //         }
            //     }
            // }
            $("#textAreaClaimsRow").show();
            var doc_h = $(document).height();
            var h = 55*doc_h/100;   //"550px"
            $("#textAreaClaimsRow").css( "height", h);
            $("#textAreaClaimsRow").val(line);
        }
    });
}

function detailInit(e) {
    Waiting(true);
    $("<div/>").appendTo(e.detailCell).kendoGrid({
        dataSource: {
            type: "aspnetmvc-ajax",
            schema: {
                data: "Data",
                model: {
                    fields: {
                        SenderTitle: { type: "string" },
                        ReceiverTitle: { type: "string" },
                        Result: { type: "string" },
                        SenderChrset: {type: "string"},
                        SenderTransback: {type: "number"},
                        ReceiverChrset: {type: "string"},
                        ReceiverTransback: {type: "number"}
                    }
                }
            },
            transport: {
                read: {
                    url: bars.config.urlContent("/api/claimsrowdata"),
                    data: { SWREF: e.data.SWREF, SENDER: e.data.SENDER, RECEIVER: e.data.RECEIVER},
                    complete: function (jqXHR, textStatus) {
                        Waiting(false);
                    }
                }
            },
            serverPaging: false,
            serverSorting: false,
            serverFiltering: false,
            pageSize: 10
        },
        scrollable: false,
        sortable: false,
        pageable: false,
        columns: [
            { field: "SenderTitle", width: 150, title: "Відправник" },
            { field: "ReceiverTitle", width: 150, title: "Отримувач"},
            { field: "Result", width: 300, title: "Дані", template:'#= preFormated(Result) #'}
        ]
    });
}

function opervisa(Sign, visaSign, REF, SWREF, MT) {
    WaitingForID(true, ".search-docForKvit");
    AJAX({ srcSettings: {
        url: bars.config.urlContent("/api/signmt900"),
        success: function (data) {
            AJAX({ srcSettings: {
                url: bars.config.urlContent("/api/opervisa"),
                success: function (data) {
                    impmsgDocumentLink(REF, SWREF, true);       //var nRef_ = data['nRef'];
                },
                complete: function(jqXHR, textStatus){ WaitingForID(false, ".search-docForKvit"); },
                error: function (jqXHR, textStatus, errorThrown) {bars.ui.error({ title: 'Помилка', text: "Не вдалось злінкувати документ" });},
                data: JSON.stringify({nRef: data['nRef'], nGrp: data['nGrp'], nTmp: data['nTmp'], m_lsSign: Sign, visaSign: visaSign})
            } });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            WaitingForID(false, ".search-docForKvit");
            bars.ui.error({ title: 'Помилка', text: "Не вдалось злінкувати документ" });
        },
        data: JSON.stringify({nRef: REF, nMt: MT})
    } });
}

function onClickDocKvitBtn(btn) {
    var gridDocForKvit = $("#gridDocForKvit").data("kendoGrid");
    var selectedItemDocForKvit = gridDocForKvit.dataItem(gridDocForKvit.select());

    switch (btn.id){

        case "impmsg_document_link":          //
            var gridMain = $("#gridMain").data("kendoGrid");
            if(gridMain){
                var selectedItemMain = gridMain.dataItem(gridMain.select());

                if(selectedItemMain && selectedItemDocForKvit){
                    if(selectedItemDocForKvit.REF != null && selectedItemDocForKvit.REF > 0){

                        //900/910
                        if(getGlobalOption('SW_NR20') === "1" && (selectedItemMain.MT == 900 || selectedItemMain.MT == 910)){
                            var visaSign = getGlobalOption('VISASIGN') === "1";
                            if(visaSign){
                                WaitingForID(true, ".search-docForKvit");

                                // 1. get user_keyid and sign_type
                                AJAX({ srcSettings: {
                                    url: bars.config.urlContent("/api/swiftgetsigninfo"),
                                    success: function (data) {
                                        var user_keyid = data['Data']['user_keyid'];
                                        var sign_type = data['Data']['sign_type'];

                                        // 2. get nGrp
                                        AJAX({ srcSettings: {
                                            url: bars.config.urlContent("/api/swiftgetgrp"),
                                            success: function (data) {
                                                if (parseInt(data['sos']) == 5) {
                                                    WaitingForID(false, ".search-docForKvit");
                                                    impmsgDocumentLink(selectedItemDocForKvit.REF, selectedItemMain.SWREF, true);
                                                    return;
                                                }

                                                var nGrp = data['nGrp'];

                                                // 3. get buffer
                                                AJAX({ srcSettings: {
                                                    url: bars.config.urlContent("/checkinner/Service.asmx/GetDataForVisaExt"),
                                                    success: function (data) {
                                                        if(data["d"] == null){
                                                            WaitingForID(false, ".search-docForKvit");
                                                            bars.ui.error({ title: 'Помилка', text: "Не вдалось отримати дані, спробуйте повторно" });
                                                        }
                                                        else{
                                                            if(data["d"]["Code"] == "ERROR"){
                                                                WaitingForID(false, ".search-docForKvit");
                                                                bars.ui.error({ title: 'Помилка', text: data["d"]["Text"] });
                                                            }
                                                            else{
                                                                var options = {
                                                                    ModuleType: sign_type,
                                                                    KeyId: user_keyid,
                                                                    CaKey: g_globalOptionsValues['CRYPTO_CA_KEY'].Value
                                                                };

                                                                barsCrypto.setDebug(true);
                                                                barsCrypto.init(options);

                                                                var xml_visaData = new ActiveXObject('MSXML2.DOMDocument');
                                                                xml_visaData.loadXML(data["d"].DataXml);
                                                                var Docs = GetDocsFromXML(xml_visaData);
                                                                var par = 0;    // 0 - visa
                                                                // 4. sign
                                                                SignDocsRecursive(Docs.length, Docs, nGrp, par,
                                                                    function (Docs) {
                                                                        var str_putVisaData = createOutXml(Docs, nGrp, par, options);

                                                                        // Повертаємо сформований XML
                                                                        var tmp_xml_putVisaData = new ActiveXObject('MSXML2.DOMDocument');
                                                                        tmp_xml_putVisaData.loadXML(str_putVisaData);

                                                                        // 5. put visa
                                                                        AJAX({ srcSettings: {
                                                                            url: bars.config.urlContent("/checkinner/Service.asmx/PutVisasExt"),
                                                                            success: function (data) {
                                                                                if(data["d"]["Code"] == "ERROR"){
                                                                                    bars.ui.error({ title: 'Помилка', text: data["d"]["Text"] });
                                                                                }
                                                                                else{
                                                                                    // 6. finish!!!
                                                                                    bars.ui.success({ title: 'До відома', text: data["d"]["Text"] });
                                                                                    impmsgDocumentLink(selectedItemDocForKvit.REF, selectedItemMain.SWREF, true);
                                                                                }
                                                                            },
                                                                            complete: function(jqXHR, textStatus){ WaitingForID(false, ".search-docForKvit"); },
                                                                            error: function (jqXHR, textStatus, errorThrown) {bars.ui.error({ title: 'Помилка', text: "Помилки візування документів" });},
                                                                            data: JSON.stringify({XmlData: encodeURI(tmp_xml_putVisaData.xml), Type: "", StpDocs: null})
                                                                        } });
                                                                    },
                                                                    function (errorText) {
                                                                        WaitingForID(false, ".search-docForKvit");
                                                                        bars.ui.error({ title: 'Помилки накладання ЕЦП', text: errorText });
                                                                    });
                                                            }
                                                        }
                                                    },
                                                    error: function (jqXHR, textStatus, errorThrown) {
                                                        WaitingForID(false, ".search-docForKvit");
                                                    },
                                                    data: JSON.stringify({
                                                        grpId: nGrp,
                                                        refs: [selectedItemDocForKvit.REF],
                                                        type: "",
                                                        keyId: user_keyid,
                                                        keyHash: "",
                                                        signType: sign_type
                                                    })
                                                } });
                                            },
                                            error: function (jqXHR, textStatus, errorThrown) {
                                                WaitingForID(false, ".search-docForKvit");
                                                bars.ui.error({ title: 'Помилка', text: "Не вдалось отримати групу" });
                                            },
                                            data: JSON.stringify({nRef: selectedItemDocForKvit.REF, nMt: selectedItemMain.MT})
                                        } });
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                        WaitingForID(false, ".search-docForKvit");
                                        bars.ui.error({ title: 'Помилка', text: "Не вдалось отримати дані 'docsign'" });
                                    }
                                } });
                            }
                            else{
                                opervisa("", visaSign, selectedItemDocForKvit.REF, selectedItemMain.SWREF, selectedItemMain.MT);
                            }
                        }
                        else {
                            impmsgDocumentLink(selectedItemDocForKvit.REF, selectedItemMain.SWREF, true);
                        }
                    }
                    return;
                }
            }
            bars.ui.error({ text: "Документи не відмічені!" });
            break;

        case "pbViewDoc":
            if (selectedItemDocForKvit && selectedItemDocForKvit.REF != null) {
                // var url = "/barsroot/documentview/default.aspx?ref=" + selectedItemDocForKvit.REF;
                // window.showModalDialog(encodeURI(url), null, "dialogWidth:800px; dialogHeight:600px; center:yes; status:no");
                OpenBarsDialog("/barsroot/documentview/default.aspx?ref=" + selectedItemDocForKvit.REF);
            }
            else{
                bars.ui.error({ text: "Документи не відмічені!" });
            }
            break;

        default:
            break;
    }
}

function onActivateDocForKvit() {
    if(g_initedGridDocForKvit){
        var g = $("#gridDocForKvit").data("kendoGrid");
        g.dataSource.data([]);
    }

    var grid = $('#gridMain').data("kendoGrid");
    var row = grid.dataItem(grid.select());

    function checkDate(id, globalKey, direct) {
        var d = kendo.toString($(id).data("kendoDatePicker").value(), "MM.dd.yyyy");
        if(d == null || d == "" || d == undefined){
            var nVDoc = g_globalOptionsValues[globalKey].Value ? parseInt(g_globalOptionsValues[globalKey].Value) : 0;
            var strVDoc = new Date(row.VDATE);
            strVDoc.setDate(strVDoc.getDate() + nVDoc*direct);
            $(id).data("kendoDatePicker").value(kendo.toString(strVDoc, "dd.MM.yyyy"));
        }
    }

    if($("#searchDocForKvit2").is(":visible")){
        $('#searchRef').data("kendoNumericTextBox").value(null);
        checkDate("#searchDate1", 'SWTDVMNI', -1);
        checkDate("#searchDate2", 'SWTDVMAX',  1);
    }
    else{
        SearchDocForKvit();
    }
}

function onClickBtn(btn) {
    var grid = $('#gridMain').data("kendoGrid");
    var row = null;
    if(grid){
        row = grid.dataItem(grid.select());
    }

    switch (btn.id){

        case "pbPrint":
            var forPrint = [];
            grid.tbody.find("input:checked").closest("tr").each(function (index) {
                var uid = $(this).attr('data-uid');
                var item = grid.dataSource.getByUid(uid);
                forPrint.push(item.SWREF);
            });
            if(forPrint.length > 0){
                var SWREF = "";
                for(var i = 0; i < forPrint.length; i++){
                    SWREF += forPrint[i];
                    if(i < forPrint.length - 1){
                        SWREF += ";";
                    }
                }
                OpenSWREF(SWREF);
            }
            else{
                bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
            }
            break;

        case "pbTimerOn":
            g_pbTimerOn = !g_pbTimerOn;
            if (!bars.test.hasIE || bars.test.hasIE === '10'){
                // btn.style = g_pbTimerOn ? "opacity: 1.0" : "opacity: 0.3";
                var opacityStr = g_pbTimerOn ? "1.0" : "0.3";
                $("#pbTimerOn").css("opacity", opacityStr);
            }
            else{
                var opacity = g_pbTimerOn ? 100 : 30;
                btn.style.filter = "alpha(opacity="+opacity+")";
            }

            bars.ui.notify("Автоматичне оновлення", g_pbTimerOn ? "Увімкнено" : "Вимкнено", "info", {autoHideAfter: 5*1000});

            if(g_pbTimerOn){
                g_pbTimerOnID = setInterval(function () { updateMainGrid(); }, g_pbTimerOnTime);
            }
            else{
                if(g_pbTimerOnID != null){
                    clearInterval(g_pbTimerOnID);
                    g_pbTimerOnID = null;
                }
            }
            break;

        case "pbDelete":
            var forDel = [];
            var dataSource = grid.dataSource;
            grid.tbody.find("input:checked").closest("tr").each(function (index) {
                var uid = $(this).attr('data-uid');
                var item = dataSource.getByUid(uid);
                forDel.push(item.SWREF);
            });
            if(forDel.length > 0){
                bars.ui.confirm({text: "Видалити відмічені записи?"}, function () {
                    messageDelete(forDel);
                });
            }
            else{
                bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
            }
            break;

        case "SAM_DoubleClick":     // dbl click
            if (row) {
                selectOpCode();
            }
            else {
                bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
            }
            break;

        case "pbFindMatch":         // two blue arrows
        case "pbFindMatch2":         // two blue arrows
            if(btn.id == "pbFindMatch"){
                $("#searchDocForKvit1").show();
                $("#searchDocForKvit2").hide();
            }
            else{
                $("#searchDocForKvit1").hide();
                $("#searchDocForKvit2").show();
            }
            if(!row){
                bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
                return;
            }
            $("#dialogDocForKvit").data('kendoWindow').center().open();
            break;

        case "pbUserList":          // two guys
            OpenBarsDialog("/barsroot/ndi/referencebook/GetRefBookData/?tableName=SW_STAFF_LIST&accessCode=0", 
                {close: function () {
                    usersLod(g_strIoInd);
                    Search();
                }});
            break;

        case "pbSwitch":            // blue squares
            g_strIoInd = (g_strIoInd === "O") ? "I" : "O";
            usersLod(g_strIoInd);
            Waiting(true);
            g_mainGridNeedSelectFirstRow = true;
            updateMainGrid();
            break;

        // case "pbDetails":           // yellow folder
        //     break;

        case "pbApplyToAll":        // green OK
            //if(g_sUserF !== 0){ bars.ui.error({ title: 'Доступ користувача', text: "Заборонено!" }); return; }
            selectLinkUsers();
            break;

        case "pbApplyToAllUsers":
            bars.ui.confirm({text: "Розподілити повідомлення по користувачам?"}, function () {
                var ch = grid.dataSource.hasChanges();      // return Boolean
                if(ch){
                    var forLink = [];
                    var data = grid.dataSource.data();
                    for (var idx = 0; idx < data.length; idx++) {
                        var item = data[idx];
                        if (item.dirty) {
                            // changed row
                            if(g_sUserF == 1){
                                forLink.push({SWREF: item.SWREF, ID: item.ID, TARGET_ID: null});
                            }
                            else{
                                forLink.push({SWREF: item.SWREF, ID: null, TARGET_ID: item.ID});
                            }
                            //console.log("SWREF="+item.SWREF + " ID="+item.ID + " FIO="+item.FIO);
                        }
                    }
                    if(forLink.length > 0){
                        var linkedUserFIO = g_sUserF == 1 ? "" : getDDNameById(forLink[0].TARGET_ID);
                        messageChangeUser(forLink, linkedUserFIO);
                    }
                    else {
                        bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
                    }
                }
                else{
                    bars.ui.error({ title: 'Помилка', text: "Користувачі не вибрані!" });
                }
            });
            break;

        case "pbReject":            // red arrow-arc button
            bars.ui.confirm({text: "Відмовитись від розподілених повідомлень?"}, function () {
                confirmLinkUsers();
            });
            break;
        default:
            break;
    }
}

function updateGridDocForKvit() {
    var grid = $("#gridDocForKvit").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function initGridDocForKvit() {
    // Waiting(true);
    fillKendoGrid("#gridDocForKvit", {
            type: "webapi",
            // sort: [ { field: "SWREF", dir: "desc" } ],
            pageSize: 10,
            transport: { read: {
                url: bars.config.urlContent("/api/docForKvit"),
                data: function () { return g_DocForKvit; }
            } },
            schema: {
                model: {
                    fields: {
                        REF: { type: "number" },
                        VDAT: { type: "date" },
                        NLSA: { type: "string" },
                        NLSB: { type: "string" },
                        AMOUNT: { type: "number" },
                        LCV: { type: "string" },
                        DIG: { type: "number" },
                        DK: { type: "number" },
                        NAZN: { type: "string" },
                        TAG20: { type: "string" },
                        TT: { type: "string" },
                        NEXTVISAGRP: { type: "string" }
                    }
                }
            }
        }, {
            pageable: {
                previousNext: true,
                refresh: true,
                pageSizes: [10, 20, 50, 200, 1000],
                buttonCount: 3,
                messages: {
                    itemsPerPage: ''
                }
            },
            dataBound: function () {
                WaitingForID(false, ".search-docForKvit");

                var grid = this;
                for (var i = 0; i < grid.columns.length; i++) {
                    grid.autoFitColumn(i);      // add horizontal scroll for grid
                }
            },
            columns: [
                {
                    title: "№ п/п",
                    template: "#= ++g_gridDocForKvitCounter #",
                    width: "3%"
                },
                {
                    field: "REF",
                    title: "Референс",
                    width: "10%"
                },
                {
                    field: "VDAT",
                    title: "Дата<br>валютир.",
                    width: "10%",
                    template: "<div style='text-align:center;'>#=(VDAT == null) ? ' ' : kendo.toString(VDAT,'dd.MM.yyyy')#</div>"
                },
                {
                    field: "NLSA",
                    title: "Рахунок A",
                    width: "10%"
                },
                {
                    field: "NLSB",
                    title: "Рахунок B",
                    width: "10%"
                },
                {
                    field: "AMOUNT",
                    title: "Сума",
                    width: "10%",
                    template: '#=kendo.toString(AMOUNT,"n")#',
                    format: '{0:n}',
                    attributes: { "class": "money" }

                },
                {
                    field: "LCV",
                    title: "Валюта",
                    width: "10%"
                },
                // {
                //     field: "DIG",
                //     title: "DIG",
                //     width: "10%"
                // },
                {
                    field: "DK",
                    title: "Д/К",
                    width: "10%"
                },
                {
                    field: "TAG20",
                    title: "Поле20",
                    width: "10%"
                },
                {
                    field: "TT",
                    title: "Код оп",
                    width: "10%"
                },
                {
                    field: "NAZN",
                    title: "Призначення",
                    width: "10%"
                }
                // {
                //     field: "NEXTVISAGRP",
                //     title: "NEXTVISAGRP",
                //     width: "10%"
                // }
            ],
            dataBinding: function() { g_gridDocForKvitCounter = (this.dataSource.page() -1) * this.dataSource.pageSize(); }
        },
        "#docForKvitTitle-template");
}

function updateMainGrid() {
    $('.chkFormolsAll').prop('checked', false);
    $("#textAreaClaimsRow").val("");
    $("#textAreaClaimsRow").hide();
    var grid = $("#gridMain").data("kendoGrid");
    if (grid){grid.dataSource.fetch();}
}

function initMainGrid() {
    if (g_sUserF == 0 || true) {
        g_mainColumns.push({
            field: "ID",
            title: "Виконавець",
            width: "22%"
            ,editor: g_sUserF == 0 ? categoryDropDownEditor : null
            ,template: "#= getDDNameById(ID) #"
        });
    }

    fillKendoGrid("#gridMain", {
        type: "webapi",
        // sort: [ { field: "SWREF", dir: "desc" } ],
        transport: {
            read: {
                url: bars.config.urlContent("/api/searchclaims"),
                data: function () {
                    var filter = g_sFILTR;

                    var vDATE = kendo.toString($("#searchDate").data("kendoDatePicker").value(), "ddMMyyyy");
                    if(vDATE != null){
                        filter += " v.vDATE >= to_date('" + vDATE + "','ddmmyyyy') and ";
                    }
                    filter += (g_sUserF == 0) ? " (v.id is null or v.id=0) and" : " v.id = user_id() and";
                    if(g_isClaims){
                        filter += " v.SWREF in (select swref from sw_operw where tag='50' and opt IN ('K', 'F') and Upper(value) like '%CLAIMS%') and";
                    }
                    return {
                        sFILTR: filter,
                        strIoInd: g_strIoInd
                    };
                }
            }
        }, pageSize: 10,
        schema: {
            model: {
                fields: {
                    SWREF: { editable: false,type: "number" },
                    MT: { editable: false,type: "number" },
                    TRN: { editable: false,type: "string" },
                    SENDER: { editable: false,type: "string" },
                    SENDER_NAME: { editable: false,type: "string" },
                    RECEIVER: { editable: false,type: "string" },
                    RECEIVER_NAME: { editable: false,type: "string" },
                    PAYER: { editable: false,type: "string" },
                    PAYEE: { editable: false,type: "string" },
                    CURRENCY: { editable: false,type: "string" },
                    KV: { editable: false,type: "number" },
                    DIG: { editable: false,type: "number" },
                    AMOUNT: { editable: false,type: "number" },
                    ACCD: { editable: false,type: "number" },
                    ACCK: { editable: false,type: "number" },
                    IO_IND: { editable: false,type: "string" },
                    DATE_IN: { editable: false,type: "date" },
                    DATE_OUT: { editable: false,type: "date" },
                    DATE_REC: { editable: false,type: "date" },
                    DATE_PAY: { editable: false,type: "date" },
                    VDATE: { editable: false,type: "date" },
                    ID: { type: "number" },
                    FIO: { type: "string" },
                    TRANSIT: { editable: false,type: "string" },
                    TAG20: { editable: false,type: "string" },
                    NLSA: { editable: false,type: "string" },
                    NLSB: { editable: false,type: "string" },
                    block: {editable: false}
                }
            }
        }
    }, {
        // detailInit: detailInit,
        dataBound: function(e) {
            Waiting(false);

            var grid = this;
            // var count = grid.dataSource.total();
            // var page = grid.dataSource.page();
            // var pageSize = grid.dataSource.pageSize();

            var doc_h = $(document).height();
            var h = 24*doc_h/100;
            $('#gridMain .k-grid-content').height(h);

            // todo: dbl click event
            // var grid = this;
            grid.tbody.find("tr").dblclick(function (e) {
                e.preventDefault();
                //var dataItem = grid.dataItem(this);
                selectOpCode();
            });

            if(g_mainGridNeedSelectFirstRow){
                g_mainGridNeedSelectFirstRow = false;
                if(grid.dataSource.total() > 0){
                    setTimeout(function () {
                        grid.select(e.sender.tbody.find("tr:first"));
                    }, 50)
                }
            }

            markDuplicatedRows();
            //this.expandRow(this.tbody.find("tr.k-master-row").first());
        },

        change: function () {
            var grid = $('#gridMain').data("kendoGrid");
            if (grid)
                var row = grid.dataItem(grid.select());
                if(g_gridMainSelected != null && g_gridMainSelected.SWREF != row.SWREF){
                    grid.closeCell();       // close cell focus
                }
                g_gridMainSelected = row;
            GetAndFillRowData(row.SWREF, row.SENDER, row.RECEIVER);
        },
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
        editable: g_sUserF == 0,
        reorderable: true,
        columns: g_mainColumns,
        pageable: {
            messages: {
                allPages: "Всі"
            },
            refresh: true,
            pageSizes: [10, 50, 200, 1000, "All"],
            buttonCount: 5
        },
        dataBinding: function() { g_gridCounter = (this.dataSource.page() -1) * this.dataSource.pageSize(); }
        },
        g_sUserF === 1 ? "#mainUserTitle-template" : "#mainTitle-template"
    );
    setGridNavigationChbx("#gridMain");
}

function markDuplicatedRows() {
    var grid = $('#gridMain').data("kendoGrid");
    grid.tbody.find('>tr').each(function () {
        var dataItem = grid.dataItem(this);

        if (dataItem.IS_PDE == 1) {
            $(this).addClass('k-row_red-yellow');
        }
    });
}

function selectLinkUsers() {
    var isChecked = false;
    $('#gridMain').data("kendoGrid").tbody.find("input:checked").closest("tr").each(function (index) {
        isChecked = true;
        return false;
    });

    if(!isChecked){
        bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
        return;
    }

    var dstDataSource = {
        pageSize: 12,
        schema: {
            model: {
                fields: {
                    FIO: { type: "string" },
                    ID: { type: "number" }
                }
            }
        },
        data: g_swiftUsers
    };
    var blockGridData = new kendo.data.DataSource(dstDataSource);
    var blockGridSettings = {
        resizable: true,
        editable: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        dataSource: blockGridData,
        dataBound: function () {
            var grid = this;

            grid.tbody.find("tr").dblclick(function (e) {
                e.preventDefault();
                confirmLinkUsers();
            });
        },
        columns: [
            {
                field: "FIO",
                title: "Назва"
            },
            {
                field: "ID",
                title: "Ідентифікатор"
            }
        ]
    };
    $("#gridLinkUsers").kendoGrid(blockGridSettings);
    $('#dialogLinkUsers').data('kendoWindow').center().open();
}

function confirmLinkUsers() {
    $("#dialogLinkUsers").data('kendoWindow').close();

    var gridLinkUsers = $('#gridLinkUsers').data("kendoGrid");
    if (gridLinkUsers || g_sUserF == 1) {
        var grid = $('#gridMain').data("kendoGrid");
        var rowLinkUsers = g_sUserF == 1 ? null : gridLinkUsers.dataItem(gridLinkUsers.select());
        var linkedUserFIO = rowLinkUsers ? rowLinkUsers.FIO : "";
        var linkedUserID = rowLinkUsers ? rowLinkUsers.ID : null;
        // var gridElems = grid.dataSource.data();
        // gridElems.forEach(function (element, index, array){
        //     element.set('FIO', linkedUserFIO);
        //     element.set('ID', linkedUserID);
        // });
        var forLink = [];
        var dataSource = grid.dataSource;
        grid.tbody.find("input:checked").closest("tr").each(function (index) {
            var uid = $(this).attr('data-uid');
            var item = dataSource.getByUid(uid);
            forLink.push({SWREF: item.SWREF, ID: g_sUserF == 1 ? item.ID : null, TARGET_ID: linkedUserID});
            // item.set('FIO', linkedUserFIO);
            // item.set('ID', linkedUserID);
        });
        if(forLink.length > 0){
            messageChangeUser(forLink, linkedUserFIO);
        }
        else{
            bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
        }
        //grid.refresh();
    }
}

function confirmSelectOpCode() {
    $("#dialogSelectOpCode").data('kendoWindow').close();

    var gridOpCode = $('#gridSelectOpCode').data("kendoGrid");
    if (gridOpCode) {
        var rowOpCode = gridOpCode.dataItem(gridOpCode.select());
        if (rowOpCode) {
            var grid = $('#gridMain').data("kendoGrid");
            var row = grid.dataItem(grid.select());
            if(row){
                if (row.AMOUNT === 0) {
                    bars.ui.error({ title: 'Помилка', text: 'Сума для оплати - нульова, створення платежу неможливе!' });
                }
                else{
                    fullPaymentData(row, rowOpCode);
                }
            }
            else{
                bars.ui.error({ title: 'Помилка', text: "Документи не відмічені!" });
            }
        }
        else {
            bars.ui.error({ title: 'Помилка', text: 'Не вибрано код операції!' });
        }
    }
}

function selectOpCode() {
    var dstDataSource = {
        pageSize: 12,
        schema: {
            model: {
                fields: {
                    TT: { type: "string" },
                    NAME: { type: "string" }
                }
            }
        },
        //type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/listOperationsForProcessing"),
                data: function () { return { sUserF: g_sUserF, strIoInd: g_strIoInd }; },
                complete: function (data, status) {                    
                    if (status === "success") {
                        // your code that will be executed once the request is done
                        if (data.responseJSON.length > 0) {
                            $("#dialogSelectOpCode").data('kendoWindow').center().open();
                        }
                        else {
                            bars.ui.error({ title: 'Помилка', text: 'Операції відсутні!' });
                        }
                    }
                }
            }
        }
    };
    var blockGridData = new kendo.data.DataSource(dstDataSource);
    var blockGridSettings = {
        resizable: true,
        editable: false,
        selectable: "row",
        scrollable: true,
        sortable: true,
        dataSource: blockGridData,
        dataBound: function () {
            var grid = this;

            grid.tbody.find("tr").dblclick(function (e) {
                e.preventDefault();
                confirmSelectOpCode();
            });
        },
        columns: [
            {
                field: "TT",
                title: "Код оп.",
                width: "10%"
            },
            {
                field: "NAME",
                title: "Назва",
                width: "90%"
            }
        ]
    };
    $("#gridSelectOpCode").kendoGrid(blockGridSettings);    
}

function fillTitle(sFILTR) {
    if(sFILTR === "urgently"){
        $("#title").html("SWIFT. Обробка прийнятих повідомлень(термінових)");
    }
    else if(sFILTR === "noturgently"){
        $("#title").html("SWIFT. Обробка прийнятих повідомлень(не термінових)");
    }
    else if(g_isClaims){
        $("#title").html("SWIFT. CLAIMS. Обробка прийнятих повідомлень");
    }
    else if(g_sUserF === 1){
        $("#title").html(g_strPar02.indexOf('F') != -1 ? "SWIFT. Обробка прийнятих повідомлень (Всіх)": "SWIFT. Обробка прийнятих повідомлень");
    }
    else{
        $("#title").html(g_strPar02.indexOf('F') != -1 ? "SWIFT. МВПС Розподіл/Обробка прийнятих повідомлень": "SWIFT. Розподіл/Обробка прийнятих повідомлень");
    }
}

function Search() {
    if(g_mainGridInited){
        Waiting(true);
        updateMainGrid();
    }
    else{
        g_mainGridInited = true;
        Waiting(true);
        initMainGrid();
    }
}

function checkAll(ele) {
    var state = $(ele).is(':checked');
    $('.chkFormols').prop('checked', state == true);
}

$(document).ready(function () {
    loadGlobalOption();

    var strIoInd = bars.extension.getParamFromUrl('strIoInd');
    if(strIoInd !== null){ g_strIoInd = strIoInd; }

    // nIsp -> sUserF !!!! see in Centura
    var sUserF = bars.extension.getParamFromUrl('sUserF');
    if(sUserF !== null){ g_sUserF = sUserF; }

    var strPar02 = bars.extension.getParamFromUrl('strPar02');
    if (strPar02 !== null) { g_strPar02 = strPar02; }

    var isClaims = bars.extension.getParamFromUrl('isClaims');
    if (isClaims !== null) { g_isClaims = isClaims === "true"; }

    var sFILTR = bars.extension.getParamFromUrl('sFILTR');
    if (sFILTR !== null) {
        g_sFILTR = g_sFILTRS[sFILTR];
    }

    DebugLog("g_sUserF="+g_sUserF+" g_strPar02="+g_strPar02 + " isClaims="+g_isClaims + " strIoInd="+g_strIoInd + " g_sFILTR="+g_sFILTR);

    usersLod(g_strIoInd);
    fillTitle(sFILTR);

    InitGridWindow({ windowID: "#dialogSelectOpCode", srcSettings: { width: "900px", title: "Вибір банківської операції." } });
    InitGridWindow({windowID: "#dialogLinkUsers", srcSettings: {title: "Розподілення по виконавцям."}});
    InitGridWindow({windowID: "#dialogDocForKvit", srcSettings: {width: "1280px",
        title: "Підбір документу для квитовки.", activate: onActivateDocForKvit}});

    $('#confirmSelectOpCode').click(confirmSelectOpCode);
    $('#confirmLinkUsers').click(confirmLinkUsers);

    $("#searchDate").kendoDatePicker({ format: "dd.MM.yyyy" });

    $('#SearchBtn').click(Search);

    $('#SearchDocForKvitBtn1').click(SearchDocForKvit);
    $('#SearchDocForKvitBtn2').click(SearchDocForKvit);
    $("#searchDate1").kendoDatePicker({ format: "dd.MM.yyyy" });
    $("#searchDate2").kendoDatePicker({ format: "dd.MM.yyyy" });
    $("#searchRef").kendoNumericTextBox({
        format: "#",
        decimals: 0
    });

    // $(document.body).keydown(function (e) { if (e.keyCode == KEY_CODE_ENTER) {
    //     e.preventDefault(); // Stops IE from triggering the button to be clicked
    //     Search();
    // } });

});