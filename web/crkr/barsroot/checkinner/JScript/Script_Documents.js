// служебные функция JavaScript
var ServiceUrl = '/barsroot/checkinner/Service.asmx';
function sleep(msec) {
    var start = new Date().getTime();
    while (new Date().getTime() - start < msec);
}
function ExecSync(method, args) {
    var executor = new Sys.Net.XMLHttpSyncExecutor();
    var request = new Sys.Net.WebRequest();

    request.set_url(ServiceUrl + '/' + method);
    request.set_httpVerb('POST');
    request.get_headers()['Content-Type'] = 'application/json; charset=utf-8';
    request.set_executor(executor);
    request.set_body(Sys.Serialization.JavaScriptSerializer.serialize(args));

    ShowProgress();
    request.invoke();
    HideProgress();

    if (executor.get_responseAvailable()) {
        var obj = executor.get_object();
        // корректная отработка ошибки
        if (!obj.d) {
            var messages;
            var array = obj.Message.split('ORA');
            if (array.length > 0) {
                var docArray = obj.Message.split('DOC');
                if (docArray.length > 1) {
                    messages = 'DOC' + docArray[1].split('----')[0];
                } else {
                    messages = obj.Message;
                }
            } else {
                messages = obj.Message;
            }
            alert('Помилки при виклику веб-сервісу: ' + messages);
            //obj.Code = 'ERROR';
            return (false);
            //throw new Error('Помилки при виклику веб-сервісу: ' + obj.Message + obj.StackTraceInput);
        }

        return (obj);
    }

    return (false);
}

//--Выбираем параметр "група визирования"
var GrpId = '';
var xml_visaData = new ActiveXObject('MSXML2.DOMDocument');
var xml_putVisaData = new ActiveXObject('MSXML2.DOMDocument');
var type = '';

var xml_putedVisasData = new ActiveXObject('MSXML2.DOMDocument');
var xslt_putedVisasXslt = new ActiveXObject('MSXML2.DOMDocument');

xml_putedVisasData.async = false;
xslt_putedVisasXslt.async = false;

function getError(result) {
    if (result.error) {
        if (window.dialogArguments) {
            window.showModalDialog("dialog.aspx?type=err", "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        }
        else
            location.replace("dialog.aspx?type=err");
        return false;
    }

    return true;
}

function InitOjects() {
    // отображение наложеных виз
    xslt_putedVisasXslt.load('Xslt/PutedVisasTable_' + getCurrentPageLanguage() + '.xsl');
    //-- группа
    v_data[9] = getEl('hid_grpid').value;
    //-- тип
    var args = unescape(location.search.substring(1, location.search.length));
    var pars = args.split('&')[0];
    type = pars.split('=')[1];
    v_data[10] = type;

    LoadXslt('Xslt/Data_' + getCurrentPageLanguage() + '.xsl');
    v_data[3] = 'REF DESC'; //order

    var obj = new Object();
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = 'Service.asmx';
    obj.v_serviceMethod = 'GetData';
    obj.pageSize = 10;
    //------функции-----
    obj.v_serviceFuncAfter = 'AfterLoadFunction';
    obj.v_funcOnSelect = 'RowSelected'

    var menu = new Array();
    menu[LocalizedString('Message4')/*"Открыть карточку документа"*/] = "ShowDocCard(-1)";
    obj.v_menuItems = menu;
    //obj.v_xmlFilenameFilter = 'Xml/OPER_FILTER.xml';
    obj.v_filterInMenu = false;

    obj.v_enableViewState = true; //включаем ViewState

    // новый фильтр
    obj.v_showFilterOnStart = false;
    obj.v_filterTable = "oper";

    fn_InitVariables(obj);
    InitGrid();
}

function AfterLoadFunction() {
    // запоминаем данные о наложеных визах и параметрах документа
    xml_putedVisasData.loadXML(returnServiceValue[2].text);
    // кол-во и сумма документов
    var lbAggs = document.getElementById('lbAggs');
    lbAggs.innerText = 'к-ть: ' + returnServiceValue[3].text + '; сума: ' + returnServiceValue[4].text;
}
function SelectAll() {
    var chkboxes = document.getElementsByName('cnkbox');
    for (i = 0; i < chkboxes.length; i++) {
        chkboxes[i].checked = !(chkboxes[i].checked);
    }
}
function RowSelected() {
    DocVisas(selectedRowId);
}
function ShowDocCard(ref) {
    if (ref == -1) {
        if (selectedRowId != null) {
            window.showModalDialog('/barsroot/documentview/default.aspx?ref=' + selectedRowId, null, 'dialogHeight:600px; dialogWidth:800px');
        }
    }
    else {
        window.showModalDialog('/barsroot/documentview/default.aspx?ref=' + ref, null, 'dialogHeight:600px; dialogWidth:800px');
    }
}
function FilterButtonPressed() {
    ShowModalFilter();
}
function RefreshButtonPressed() {
    ReInitGrid();
}
function StornoButtonPressed() {
    var ask_reason = window.showModalDialog('StornoReason.aspx?type=' + type, 'dialogHeight:300px; dialogWidth:400px');
    if (ask_reason != null) {
        PutVisaButtonPressed(ask_reason);
    }
    else {
        var msg = escape(LocalizedString('Message5')/*'Сторнирование отменено!'*/);
        window.showModalDialog('dialog.aspx?type=1&message=' + msg, 'dialogHeight:300px; dialogWidth:400px');
    }
}
function OneStepBackButtonPressed() {
    PutVisaButtonPressed(-1);
}

function PutVisaButtonPressed(par) {
    var grpId = document.getElementById('hid_grpid').value;
    var chkbList = document.getElementsByName('cnkbox');
    var chkbListChecked = new Array();

    var idx = 0;
    for (i = 0; i < chkbList.length; i++) {
        if (chkbList[i].checked) {
            chkbListChecked[idx] = chkbList[i].id.substring(5);
            idx++;
        }
    }

    // выходим если документы не отмечены
    if (chkbListChecked.length == 0) {
        var msg = escape(LocalizedString('Message6')/*'Документы не отмечены!'*/);
        window.showModalDialog("dialog.aspx?type=1&message=" + msg, 'dialogHeight:300px; dialogWidth:400px');
    }

    // продолжаем
    var msg = escape(LocalizedString('Message7')/*'Визировать отмеченые документы?'*/);
    if (par != 0) msg = escape(LocalizedString('Message8')/*'Сторнировать отмеченые документы?'*/);
    if (par == -1) msg = escape(LocalizedString('Message9')/*'Вернуть на одну визу отмеченые документы?'*/);

    // общая сумма выбраных документов
    var summ = 0;
    for (i = 0; i < chkbListChecked.length; i++) {
        var summObj = document.getElementById('sum_' + chkbListChecked[i]);
        var summText = summObj.innerText;
        summText = summText.replace(/ /g, '');

        var summFloat = (summText == '' ? 0 : parseFloat(summText));
        summ += summFloat;
    }
    msg += '<br> ( ' + escape(LocalizedString('Message12')) + " - <span style='color:green'>" + chkbListChecked.length + '</span>,<br>' + escape(LocalizedString('Message11')) + "<span style='color:red'>" + FormatNumber(summ, 2) + '</span> )'; /*'на суму '*/

    var ask = window.showModalDialog("dialog.aspx?type=confirm&message=" + msg, 'dialogHeight:300px; dialogWidth:400px');
    if (ask == '1') {
        var MakeData4VisaResult = ExecSync('GetDataForVisa', { grpId: grpId, refs: chkbListChecked, type: type }).d;

        // показываем ошибки если были при подготовке данных
        if (MakeData4VisaResult && MakeData4VisaResult.Code == 'ERROR') {
            var msg = escape(LocalizedString('Message10')/*'Нет документов для визирования!'*/);
            window.showModalDialog("dialog.aspx?type=1&message=" + msg, 'dialogHeight:300px; dialogWidth:400px');

            DocVisas(-1);
            ReInitGrid();

            return;
        }
        else if (MakeData4VisaResult && MakeData4VisaResult.Code == 'WARNING') {
            var msg = escape(MakeData4VisaResult.Text);
            if (msg.length > 1800) msg = msg.substr(0, 1800) + escape('..............');
            window.showModalDialog("dialog.aspx?type=1&message=" + msg, 'dialogHeight:300px; dialogWidth:400px');
        }

        // загружаем ответный Xml
        xml_visaData.loadXML(MakeData4VisaResult.DataXml);

        //---------------------------------------------------------
        // проверяем и подписываем если это не сторнирование
        var params = new Array();
        params['INTSIGN'] = document.getElementById('__INTSIGN').value;
        params['VISASIGN'] = document.getElementById('__VISASIGN').value;
        params['SEPNUM'] = document.getElementById('__SEPNUM').value;
        params['SIGNTYPE'] = document.getElementById('__SIGNTYPE').value;
        params['SIGNLNG'] = document.getElementById('__SIGNLNG').value;
        params['DOCKEY'] = document.getElementById('__DOCKEY').value;
        params['REGNCODE'] = document.getElementById('__REGNCODE').value;
        params['BDATE'] = document.getElementById('__BDATE').value;

        // наложение ЭЦП через ActiveX
        var signDoc = new obj_Sign();
        if (signDoc.initObject(params))
            xml_putVisaData = SignDocs(xml_visaData, grpId, par, signDoc);
        signDoc.showErrorsDialog();

        //собственно визируем					
        var VisaResult = ExecSync('PutVisas', { XmlData: encodeURI(xml_putVisaData.xml), Type: type }).d;
        if (VisaResult && VisaResult.Code == 'OK') {
            var msg1 = escape(VisaResult.Text);
            if (msg1.length > 2000) {
                msg1 = msg1.substring(0, 2000) + escape('<BR>...');
            }

            var dialogUrl = 'dialog.aspx?type=1&message=' + msg1;
            var dialogOptions = 'width=400, height=300, toolbar=no, location=no, directories=no, menubar=no, scrollbars=yes, resizable=yes, status=no';
            window.open(dialogUrl, 'view_window', dialogOptions);

            DocVisas(-1);
            ReInitGrid();
        }
    }
}
function makeError(str) {
    var result = "";
    var len = str.split("---").length - 1;
    var min = 1;
    if (len == 3) min = 0;
    for (i = 1; i < len / 2; i++) {
        result += i + str.split("---")[i] + "<BR>" + str.split("---")[len - i - min] + "<BR>";
    }
    return result;
}
function SignDocs(xmlDoc, grpId, par, objSign) {
    /* Структура входящего XML xmlDoc:
    <docs4visa>
      <doc ref="ref" err="1" erm="ффффф" />
      <doc ref="ref" err="0" erm="..." grp="grp" f_pay="f_pay" f_sign="f_sign" f_check="f_check">
        <bufs inner_buf="inSign" outer_buf="outSign" />
      </doc>
    </docs4visa>  
    */

    var str_putVisaData = '<?xml version="1.0" encoding="utf-8" ?>';
    str_putVisaData += '<docs4visa grpid="' + grpId + '" par="' + par + '">';

    var docNodes = xmlDoc.getElementsByTagName('doc');
    for (ii = 0; ii < docNodes.length; ii++) {

        var ref = docNodes[ii].getAttribute('ref');
        var err = docNodes[ii].getAttribute('err');

        // если ошибочный то переходим к след
        if (err == '1') continue;

        var f_sign = docNodes[ii].getAttribute('f_sign');
        var f_check = docNodes[ii].getAttribute('f_check');

        // буффера для подписи
        var bufs = docNodes[ii].firstChild;
        var inSign = bufs ? bufs.getAttribute('inner_buf') : '';
        var outSign = bufs ? bufs.getAttribute('outer_buf') : '';

        var params1 = new Array();
        params1['FLI'] = '0'; // нам не важен
        params1['SIGN_FLAG'] = f_sign;
        params1['CHECK_FLAG'] = f_check;

        objSign.initSystemParams(params1);

        var ECP = PutDocECP(ref, inSign, outSign, objSign, par);
        //  в случае удачной проверки\наложения ЭЦП
        if (ECP[0] == 1) {
            str_putVisaData += '<doc ref="' + ref + '" key="' + ECP[3] + '">';
            str_putVisaData += '<bufs inner_buf="' + inSign + '" outer_buf="' + outSign + '" />';
            str_putVisaData += '<ecps inner_ecp="' + ECP[1] + '" outer_ecp="' + ECP[2] + '" />';
            str_putVisaData += '</doc>';
        }
    }
    str_putVisaData += '</docs4visa>';

    var tmp_xml_putVisaData = new ActiveXObject('MSXML2.DOMDocument');
    tmp_xml_putVisaData.loadXML(str_putVisaData);

    return tmp_xml_putVisaData;
}
function PutDocECP(ref, insign, outsign, objSign, par) {
    var ECP = new Array();
    ECP[0] = 1; // 0-ошибка, 1-успех
    ECP[1] = '';
    ECP[2] = '';
    ECP[3] = '';

    var params2 = new Array();
    params2['VOB'] = '0'; //?????
    params2['VOB2SEP'] = '0'; //?????
    params2['DocN'] = '0'; //?????
    params2['DOCREF'] = ref;
    params2['BUFFER'] = outsign;
    params2['BUFFER_INT'] = insign;

    objSign.initDocParams(params2);

    // для проверки используем другой флаг, не учитываем внеш подпись
    var tmp_f_sign = objSign.num_SIGN_FLAG;

    if (tmp_f_sign == '3') objSign.num_SIGN_FLAG = '1';
    else if (tmp_f_sign == '2') objSign.num_SIGN_FLAG = '0';

    // если это операция сторнирования то ЭЦП не проверяется
    if (par == 0) {
        // -- проверка ЭЦП пропускаем этот документ --
        var verify_res = objSign.VerifySignature();
        // -- неуспешная проверка --
        if (!verify_res) {
            ECP[0] = 0;
            return ECP;
        }
    }

    // возвращаем флаг
    objSign.num_SIGN_FLAG = tmp_f_sign;

    var sign_res = objSign.getSign();
    // если ошибка, то просто пропускаем этот документ
    if (!sign_res) {
        ECP[0] = 0;
        return ECP;
    }
    else {
        ECP[1] = objSign.DOCSIGN_INT;
        ECP[2] = objSign.DOCSIGN;
        ECP[3] = (objSign.DOCKEY.length > 6) ? (objSign.DOCKEY.substring(2)) : (objSign.DOCKEY);
    }

    return ECP;
}
function DocVisas(ref) {
    if (ref != -1) {
        // отображаем таблицу наложеных виз
        var xml_tmp = new ActiveXObject('MSXML2.DOMDocument');
        xml_tmp.appendChild(xml_putedVisasData.getElementsByTagName('nd_' + ref).item(0).cloneNode(true));

        document.getElementById('div_visas').innerHTML = xml_tmp.transformNode(xslt_putedVisasXslt.documentElement);
    }
    else {
        //отчистка таблицы
        document.getElementById('div_visas').innerHTML = '';
    }
}
/*
* Форматирование строкового представления числа
*/
function FormatNumber(num, decimalNum) {
    var tmpNum = num;

    if (tmpNum < 1) {
        var tmpStr = FormatNumber(10 + tmpNum, decimalNum);
        var lng = tmpStr.length;

        return tmpStr.substring(1, lng);
    }
    else {
        tmpNum *= Math.pow(10, decimalNum);
        tmpNum = Math.round(tmpNum);

        var tmpStr = new String(tmpNum);
        var lng = tmpStr.length;
        tmpStr = tmpStr.substring(0, lng - decimalNum) + '.' + tmpStr.substring(lng - decimalNum, lng);
        lng = tmpStr.length;

        var idx = lng - decimalNum - 4;
        while (idx > 0) {
            tmpStr = tmpStr.substring(0, idx) + ' ' + tmpStr.substring(idx, lng);
            lng = tmpStr.length;
            idx -= 3;
        }

        return tmpStr;
    }
}
