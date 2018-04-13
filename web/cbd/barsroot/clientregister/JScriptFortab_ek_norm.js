// служебные функция JavaScript
var ServiceUrl = '/barsroot/clientregister/defaultWebService.asmx';
var isFS = null;//проверим существование обьекта (параметр EN_FS!=1) 
$(function () {
  isFS = document.getElementById('ed_FS') ? true : false; //проверим существование обьекта (параметр EN_FS!=1) 
  InitObjects();
});
function ExecSync(method, args) {
    var executor = new Sys.Net.XMLHttpSyncExecutor();
    var request = new Sys.Net.WebRequest();

    request.set_url(ServiceUrl + '/' + method);
    request.set_httpVerb('POST');
    request.get_headers()['Content-Type'] = 'application/json; charset=utf-8';
    request.set_executor(executor);
    if (args)
        request.set_body(Sys.Serialization.JavaScriptSerializer.serialize(args));
    request.invoke();

    if (executor.get_responseAvailable()) {
        return (executor.get_object());
    }

    return (false);
}

function GetHelpValue(edObj, ddlObj, tblName) {
    var tail = "(d_close is null or d_close>=bankdate)";
    if (tblName == 'ISE') {
        var rezId = getParamFromUrl('rezid', parent.document.frames['Tab0'].location.href);
        var bPersonSPD = getParamFromUrl('spd', parent.document.frames['Tab0'].location.href);
        var nCType = getParamFromUrl('client', parent.document.frames['Tab5'].location.href);
        var tail = "(d_close is null or d_close>=bankdate)";
        var tailAdd = '';
        if (rezId == 1) {
            if (nCType == 'bank' || nCType == 'corp') {
                tailAdd = ' k072 not in __bktOp__ __prime__L__prime__,__prime__N__prime__,__prime__0__prime__ __bktCl__ ';
            } else {
                if (bPersonSPD == 0 && parent.flagEnhCheck) { //для Надра N,R
                    tailAdd += ' k072 in __bktOp__ __prime__N__prime__,__prime__R__prime__ __bktCl__';
                } else if (bPersonSPD == 0) {
                    tailAdd += ' k072=__prime__N__prime__ ';
                } else {
                    tailAdd += ' k072=__prime__L__prime__ ';
                }
            }
        } else {
            tailAdd = ' k072=__prime__0__prime__ ';
        }

        tail += " and __bktOp__ ise=__prime__00000__prime__ or ise in __bktOp__ select k070 from kl_k070 where " + tailAdd + "__bktCl__ __bktCl__";
    }
    var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=' + tblName + '&tail=\''+tail+'\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:800px');
    //var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=' + tblName + '&tail=\'(d_close is null or d_close>bankdate)\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:800px');
    if (result != null) {
        if (result[0] != null && result[1] != null) {
            edObj.value = result[0];
            ddlObj.item(0).text = result[1];
        }
    }
}
function GetOEHelpValue() {
    var ved = getEl('ed_VED').value;

    var input = new Array();
    var output = new Array();

    input.ved = ved;

    output = GetWebServiceData('GetOESQL', input, 1);
    output = output.replace("'", "\'");
    if (output == "") output = "(d_close is null or d_close>bankdate)";
    else output += " and (d_close is null or d_close>bankdate)";
    var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=OE&tail="' + output + '"&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px');
    if (result != null) {
        if (result[0] != null && result[1] != null) {
            getEl('ed_OE').value = result[0];
            getEl('ddl_OE_com').item(0).text = result[1];
        }
    }
}
function MyChengeEnable(Flag) {
  var blFlag = new Boolean();
  blFlag = true;
  if (Flag == 'false' || Flag == false) blFlag = false;

  parent.obj_Parameters['NEkPres'] = blFlag;
  document.getElementById('ed_ISE').disabled = !blFlag;
  if (isFS) { //проверим существование обьекта (параметр EN_FS!=1)
    document.getElementById('ed_FS').disabled = !blFlag;
  }
  document.getElementById('ed_VED').disabled = !blFlag;
  //document.getElementById('ed_OE').disabled = !blFlag;
  document.getElementById('ed_K050').disabled = !blFlag;

  document.getElementById('ddl_ISE_com').disabled = !blFlag;
  if (isFS) { //проверим существование обьекта (параметр EN_FS!=1)
    document.getElementById('ddl_FS_com').disabled = !blFlag;
  }
  document.getElementById('ddl_VED_com').disabled = !blFlag;
  document.getElementById('ddl_OE_com').disabled = !blFlag;
  document.getElementById('ddl_SED_com').disabled = !blFlag;

  document.getElementById('lb_1').disabled = !blFlag;
  if (isFS) { //проверим существование обьекта (параметр EN_FS!=1)  
    document.getElementById('lb_2').disabled = !blFlag;
  }
  document.getElementById('lb_3').disabled = !blFlag;
  document.getElementById('lb_4').disabled = !blFlag;
  document.getElementById('lb_5').disabled = !blFlag;
}
// служебные функция JavaScript
//первичное заполнение объектов
function InitObjects() {
    locked = false;
    //необходимые установки

    if (parent.obj_Parameters['Par_EN'] == "1") {
        getEl('ckb_main').checked = true;
        getEl('ckb_main').disabled = true;
        MyChengeEnable(true);
    }
    else {
        if (parent.obj_Parameters['EditType'] == "ReReg") {
            getEl('ckb_main').checked = true;
            MyChengeEnable(true);
        }
        else if (parent.obj_Parameters['EditType'] == "Reg") {
            getEl('ckb_main').checked = false;
            MyChengeEnable(false);
        }
    }
    if (parent.flagEnhCheck) {
        document.getElementById('ckb_main').checked = true;
        document.getElementById('ckb_main').disabled = true;
    }

    if (getParamFromUrl('spd', document.location.href) == 1) {
        document.getElementById('ed_FS').disabled = true;
        document.getElementById('ddl_FS_com').disabled = true;
        document.getElementById('ed_K050').disabled = true;
        document.getElementById('ddl_K050_com').disabled = true;
    }
    //вставляем дефолтные значения при регистрации
    if (parent.obj_Parameters['EditType'] == "Reg") {
        var defEkNorm = ExecSync('GetDefEkNorm').d;
        //дафолтне значення так як ОЕ не використо
        $('#ed_OE').val(defEkNorm.OE ? defEkNorm.OE : '00000');
        if (defEkNorm.ISE) { $('#ed_ISE').val(defEkNorm.ISE); GetIseCom(defEkNorm.ISE); }
        if (defEkNorm.FS && isFS) { $('#ed_FS').val(defEkNorm.FS); GetFsCom(defEkNorm.FS); }
        if (!parent.flagEnhCheck) {
            if (defEkNorm.VED) { $('#ed_VED').val(defEkNorm.VED); GetVedCom(defEkNorm.VED); }
            if (defEkNorm.K050) { $('#ed_K050').val(defEkNorm.K050); GetK050Com(defEkNorm.K050); }
            if (defEkNorm.SED) { $('#ed_SED').val(defEkNorm.SED); GetSedCom(defEkNorm.SED); }
        }
        if (getParamFromUrl('spd', document.location.href) == '1') {
          $('#ed_K050').val('910'); GetK050Com('910');
          $('#ed_SED').val('91'); GetSedCom('91');
        }
       
    }

    //вставляем значения
    if (parent.obj_Parameters['EditType'] != "Reg") {
        if (trim(parent.obj_Parameters['ISE']) != '') { getEl('ed_ISE').value = parent.obj_Parameters['ISE']; GetIseCom(trim(parent.obj_Parameters['ISE'])); }
        if (trim(parent.obj_Parameters['FS']) != '' && isFS) { getEl('ed_FS').value = parent.obj_Parameters['FS']; GetFsCom(trim(parent.obj_Parameters['FS'])); }
        if (trim(parent.obj_Parameters['VED']) != '') { getEl('ed_VED').value = parent.obj_Parameters['VED']; GetVedCom(trim(parent.obj_Parameters['VED'])); }
        if (trim(parent.obj_Parameters['OE']) != '') {
          getEl('ed_OE').value = parent.obj_Parameters['OE'];
          //GetOeCom(trim(parent.obj_Parameters['OE']));
        } else {
          $('#ed_OE').val('00000');
        }
        // TODO: проследить чтоб параметр K050 появился в колекции parent.obj_Parameters['K050']
        if (trim(parent.obj_Parameters['K050']) != '') { getEl('ed_K050').value = parent.obj_Parameters['K050']; GetK050Com(trim(parent.obj_Parameters['K050'])); }
        if (trim(parent.obj_Parameters['SED']) != '') { getEl('ed_SED').value = parent.obj_Parameters['SED']; GetSedCom(trim(parent.obj_Parameters['SED'])); }
    }

    DisableAll(document, parent.obj_Parameters['ReadOnly']);

    HideProgress();
}
//поиск по Ise
function GetIseCom(val) {
    var input = new Array();
    var output = new Array();

    input.val = val;

    output = GetWebServiceData('GetIseCom', input, 1);
    if (output == "Not found")
        getEl("ed_ISE").value = "";
    //отчищаем дропдаун
    getEl('ddl_ISE_com').options.length = 0;
    var newItem = document.createElement("OPTION");
    getEl('ddl_ISE_com').options.add(newItem);
    newItem.value = val;
    newItem.innerText = trim(output);
}
//поиск по Fs
function GetFsCom(val) {
    var input = new Array();
    var output = new Array();

    input.val = val;
    input.CType = parent.obj_Parameters['CUSTTYPE'];

    var ddCA = gE(parent.document.frames['Tab0'], 'ddl_CODCAGENT');
    try {
        input.Codcagent = ddCA.item(ddCA.selectedIndex).value.slice(2);
    }
    catch (e) {
      input.Codcagent = parent.obj_Parameters['CODCAGENT'];
    }

    output = GetWebServiceData('GetFsCom', input, 1);
    if (output == "Not found") {
      getEl("ed_FS").value = "";
      alert("Вказана форма власності не існує для даного типу клієнта!");
      document.getElementById('ed_FS').disabled = false;
      document.getElementById('ddl_FS_com').disabled = false;
      try {
        getEl("ed_FS").focus();
      } catch (e) {}
    }

    //отчищаем дропдаун
    getEl('ddl_FS_com').options.length = 0;
    var newItem = document.createElement("OPTION");
    getEl('ddl_FS_com').options.add(newItem);
    newItem.value = val;
    newItem.innerText = trim(output);
}
//поиск по Ved
function GetVedCom(val) {
    var input = new Array();
    var output = new Array();

    input.val = val;
    input.txt = new String();
    input.oelist = new String();

    output = GetWebServiceData('GetVedCom', input, 1);
    if (output.txt == "Not found")
        getEl("ed_VED").value = "";
    //отчищаем дропдаун
    getEl('ddl_VED_com').options.length = 0;
    var newItem = document.createElement("OPTION");
    getEl('ddl_VED_com').options.add(newItem);
    newItem.value = val;
    newItem.innerText = trim(output.txt);

    if (getEl('tmpOEList') == null) {
        var newEl = document.createElement('<input type=hidden id=tmpOEList value=' + ((trim(output.oelist) == '') ? ('') : (trim(output.oelist))) + '>');
        document.body.appendChild(newEl);
    }

    getEl('tmpOEList').value = ((trim(output.oelist) == '') ? ('') : (trim(output.oelist)));
}
//поиск по Oe
function GetOeCom(val) {
    var input = new Array();
    var output = new Array();

    input.val = val;
    input.vedVal = getEl('ed_VED').value;

    output = GetWebServiceData('GetOeCom', input, 1);
    if (output == "Not found")
        getEl("ed_OE").value = "";
    //отчищаем дропдаун
    getEl('ddl_OE_com').options.length = 0;
    var newItem = document.createElement("OPTION");
    getEl('ddl_OE_com').options.add(newItem);
    newItem.value = val;
    newItem.innerText = trim(output);
}
//все разрешенные Oe
function GetOeList(oelist) {
    var input = new Array();
    var output = new Array();

    input.oelist = getEl('tmpOEList').value;
    input.val = new Array();
    input.txt = new Array();

    output = GetWebServiceData('GetOeList', input, 1);
    //отчищаем дропдаун
    getEl('ddl_OE_com').options.length = 0;
    for (var i = 0; i < output.val.length; i = i + 1) {
        var newItem = document.createElement("OPTION");
        getEl('ddl_OE_com').options.add(newItem);
        newItem.value = trim(output.val[i]);
        newItem.innerText = trim(output.txt[i]);
    }
}
//поиск по K050
function GetK050Com(val) {
    var input = new Array();
    var output = new Array();

    input.val = val;

    output = GetWebServiceData('GetK050Com', input, 1);
    if (output == "Not found")
        getEl("ed_K050").value = "";
    //отчищаем дропдаун
    getEl('ddl_K050_com').options.length = 0;
    var newItem = document.createElement("OPTION");
    getEl('ddl_K050_com').options.add(newItem);
    newItem.value = val;
    newItem.innerText = trim(output);

    // заполняем SED
    CalcSedValue(val);
}

//TODO: перевести на вычитку параметра SED по параметру K050

function CalcSedValue(k050) {
    var input = new Array();
    var output = new Array();

    input.k050 = k050;


    output = GetWebServiceData('CalcSedValue', input, 1);

    // обработываем значение sed и комментарий
    if (output == "Not found") {
        getEl("ed_SED").value = "";
        getEl('ddl_SED_com').options.length = 0;
    }
    else {
        getEl("ed_SED").value = trim(output);
        GetSedCom(trim(output));
    }
}

//поиск по Sed
function GetSedCom(val) {
    var input = new Array();
    var output = new Array();

    input.val = val;

    output = GetWebServiceData('GetSedCom', input, 1);
    if (output == "Not found")
        getEl("ed_SED").value = "";
    //отчищаем дропдаун
    getEl('ddl_SED_com').options.length = 0;
    var newItem = document.createElement("OPTION");
    getEl('ddl_SED_com').options.add(newItem);
    newItem.value = val;
    newItem.innerText = trim(output);
}
//все Sed
function GetSedList() {
    var input = new Array();
    var output = new Array();

    input.val = new Array();
    input.txt = new Array();

    output = GetWebServiceData('GetSedList', input, 1);
    //отчищаем дропдаун
    getEl('ddl_SED_com').options.length = 0;
    for (var i = 0; i < output.val.length; i = i + 1) {
        var newItem = document.createElement("OPTION");
        getEl('ddl_SED_com').options.add(newItem);
        newItem.value = trim(output.val[i]);
        newItem.innerText = trim(output.txt[i]);
    }
}
//при выборе из дроп даунов вставляем в эдиты
function PutItem(edit, ddlist) {
    if (ddlist.selectedIndex != -1) edit.value = ddlist.item(ddlist.selectedIndex).value;
}

function getParamFromUrl(param, url) {
    url = url.substring(url.indexOf('?') + 1);
    for (var i = 0; i < url.split("&").length; i++)
        if (url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1];
    return "";
}

/************************************************************************************************/
function newContent(link, target) {
    /*
    link - URL адрес подгружаемой страницы
    target - DIV в который мы подгружаем контент
    */
    var contaner = document.getElementById(target);

    contaner.innerHTML = 'Загрузка ...';

    var resource = getRequest();
    if (resource) {
        resource.open('get', link);
      resource.onreadystatechange = function() {
        /*Получаем значение, указывающее текущее состояние элемента управления*/
        if (resource.readyState == 4) {
          contaner.innerHTML = resource.responseText;
        }
      };
      resource.send(null);
    }
    else {
        document.location = link;
    }
}
/* Функция для получения метода для работы с браузерами */
function getRequest() {
  try {
    return new XMLHttpRequest();
  } catch(e) {
    try {
      return new ActiveXObject('Msxml2.XMLHTTP');
    } catch(e) {
      try {
        return new ActiveXObject('Microsoft.XMLHTTP');
      } catch(e) {
        return null;
      }
    }
  }
}