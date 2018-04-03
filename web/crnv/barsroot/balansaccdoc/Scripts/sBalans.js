//alert(LocalizedString('TestControl'));

window.onload = InitPage;
function InitPage()
{
  webService.useService("Service.asmx?wsdl","wsBalans");//Создание обьэкта вебсервиса	
  webService.wsBalans.callService(onGetGlobalData,"GetGlobalData");
  InitTable();  
}  

function onGetGlobalData(result)
{
  if(!getError(result)) return; 
  document.getElementById("ddFDat").options[0].value = result.value[0]; 
  document.getElementById("ddFDat").options[0].text = result.value[0];
  if (getParamFromUrl("par",location.href) == 9)
  {
  document.getElementById("ddTobo").options[0].value = result.value[1];
  document.getElementById("ddTobo").options[0].text = result.value[2];
  }
  PopulateTable();
}

function InitTable()  
{  
  LoadXslt("Xslt/DataBalans_"+getCurrentPageLanguage()+".xsl");
  v_data[3] = "b.nbs";
  var obj = new Object();
  obj.v_serviceObjName = 'webService';
  obj.v_serviceName = 'Service.asmx';
  obj.v_serviceMethod = 'GetData';
  obj.v_showFilterOnStart = false;
  obj.v_filterTable = "ps";
  obj.v_serviceFuncAfter = "GetSummary";
  var par = getParamFromUrl("par",location.href);
  if (par != "2" && par != "9") par = "1";
  v_data[11] = par;
  InitTobo(v_data[11]);
  
  var menu = new Array();
  menu["Исполнители"] = "fnByIsp()";
  menu["Валюта"] = "fnByVal()";
  obj.v_menuItems = menu;
  fn_InitVariables(obj);  
} 

function PopulateTable()
{
  // дата
  v_data[10] = document.getElementById("ddFDat").options[0].value;
  // Tobo
  v_data[12] = document.getElementById("ddTobo").options[0].value;
  if (document.getElementById("cbTobo").checked == true && v_data[12] == "") return;
  InitGrid();
}

function GetSummary()
{
  document.getElementById("sB").innerText = "B*";
  document.getElementById("sM").innerText = "M*";
  document.getElementById("sV").innerText = "V*";
  document.getElementById("iB_Dosr").innerText = NumberToTxt(returnServiceValue[2].text);
  document.getElementById("iB_Kosr").innerText = NumberToTxt(returnServiceValue[3].text);
  document.getElementById("iB_Dos").innerText  = NumberToTxt(returnServiceValue[4].text);
  document.getElementById("iB_Kos").innerText  = NumberToTxt(returnServiceValue[5].text);
  document.getElementById("iB_OstD").innerText = NumberToTxt(returnServiceValue[6].text);
  document.getElementById("iB_OstK").innerText = NumberToTxt(returnServiceValue[7].text);
  document.getElementById("iM_Dosr").innerText = NumberToTxt(returnServiceValue[8].text);
  document.getElementById("iM_Kosr").innerText = NumberToTxt(returnServiceValue[9].text);
  document.getElementById("iM_Dos").innerText  = NumberToTxt(returnServiceValue[10].text);
  document.getElementById("iM_Kos").innerText  = NumberToTxt(returnServiceValue[11].text);
  document.getElementById("iM_OstD").innerText = NumberToTxt(returnServiceValue[12].text);
  document.getElementById("iM_OstK").innerText = NumberToTxt(returnServiceValue[13].text);
  document.getElementById("iV_Dosr").innerText = NumberToTxt(returnServiceValue[14].text);
  document.getElementById("iV_Kosr").innerText = NumberToTxt(returnServiceValue[15].text);
  document.getElementById("iV_Dos").innerText  = NumberToTxt(returnServiceValue[16].text);
  document.getElementById("iV_Kos").innerText  = NumberToTxt(returnServiceValue[17].text);
  document.getElementById("iV_OstD").innerText = NumberToTxt(returnServiceValue[18].text);
  document.getElementById("iV_OstK").innerText = NumberToTxt(returnServiceValue[19].text);
}

//Преобразования числа в текстовый формат
//---
var dot = (parseFloat("1.1") == 1)?(","):(".");
var comma = (dot == ".")?(","):(".");
function ParseF(val)
{
  return parseFloat(val.replace(comma,dot));
}
function NumberToTxt(value)
{
 if(value==null || value=="" || value==" ") return "";
 value = value.replace("\g ","");
 value = ParseF(value);
 var exp = Math.pow(10,2);
 if(value != "") value = (Math.round(value * exp) / exp).toString();
 value = value.toString();
 if(value.indexOf(dot) == -1 && value != "") value = value + dot+'00000000'.substring(0,2);
 var beforedot = (value.indexOf(dot) != -1) ? (value.substring(0,value.indexOf(dot))) : "";
 var afterdot = value.substring(beforedot.length);
 var new_beforedot = "";
 var len = beforedot.length;
 for(i = len; i>0; i--)
 {
  if(i % 3 == 0 && i != len) new_beforedot += " ";
  new_beforedot += beforedot.substring(len-i,len-i+1);
 }
 if(new_beforedot.indexOf("- ") != -1 ) new_beforedot = new_beforedot.substring(0,1)+new_beforedot.substring(2);
 return (new_beforedot + afterdot);
}
//---//

//Dialog
function Dialog(message,type)
{
  return window.showModalDialog("dialog.aspx?type="+type+"&message="+escape(message),"","dialogHeight:160px;center:yes;edge:sunken;help:no;status:no;");
}
//Обработка ошибок от веб-сервиса
function getError(result)
{
    if(result.error){
        if(window.dialogArguments){
            window.showModalDialog("dialog.aspx?type=err","","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        } 
        else
            location.replace("dialog.aspx?type=err");
            return false;
    }
    return true;
}

function dlgFDat()
{
    var url = "dialog.aspx?type=metatab&tail='1=1 order by fdat desc'&role=wr_metatab&tabname=fdat";
    var result = window.showModalDialog(url,"","dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    var ddlist = document.getElementById("ddFDat");
    if(result!=null){
        if(ddlist.options.length == 0){
            var oOption = document.createElement("OPTION");
            ddlist.options.add(oOption);
            oOption.innerText = result[0];
            oOption.value = result[0];
        }
        else{
            ddlist.options[0].value = result[0];
            ddlist.options[0].text = result[0];
        }
        PopulateTable();
    }
 }
 
function dlgTobo()
{
    var sFilterTobo = "";
    if (v_data[11] == "2"){
        sFilterTobo = "tobo in (select tobo_id from staff_tobo where addp>1 and user_id=user_id())";
    }
    var url = "dialog.aspx?type=metatab&tail='"+sFilterTobo+"'&role=wr_metatab&tabname=our_branch";
    var result = window.showModalDialog(url,"","dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
    var ddlist = document.getElementById("ddTobo");
    if(result!=null){
        if(ddlist.options.length == 0){
            var oOption = document.createElement("OPTION");
            ddlist.options.add(oOption);
            oOption.innerText = result[0];
            oOption.value = result[0];
        }
        else{
            ddlist.options[0].value = result[0];
            ddlist.options[0].text = result[0];
        }
        PopulateTable();
    }
 }
 
 function fnByIsp()
 {
    window.location.replace("/barsroot/balansaccdoc/balansisp.aspx?tobo="+v_data[12]+"&nbs="+selectedRowId+"&fdat="+v_data[10]);
 }
 
 function fnByVal()
 {
    window.location.replace("/barsroot/balansaccdoc/balansval.aspx?tobo="+v_data[12]+"&nbs="+selectedRowId+"&fdat="+v_data[10]);
 }

//Filter
function fnFilter()
{
  HidePopupMenu(); 
  ShowModalFilter();
}

function InitTobo(Par)
{
    // 1 - Весь банк
    if (Par == 1)
    {
        document.getElementById("cbTobo").checked = false;
        document.getElementById("ddTobo").style.visibility = 'hidden';
    }
    // 2 - все доступные ТОБО с кодом привилегии
    else if (Par == 2)
    {
        document.getElementById("cbTobo").checked = true;
        document.getElementById("cbTobo").disabled = true;
    }
    // 9 - текущее ТОБО
    else if (Par == 9)
    {
        document.getElementById("cbTobo").checked = true;
        document.getElementById("cbTobo").disabled = true;
        document.getElementById("ddTobo").disabled = true;
    }
}

function SetTobo()
{
    if (document.getElementById("cbTobo").checked == true)
        document.getElementById("ddTobo").style.visibility = 'visible';
    else
        document.getElementById("ddTobo").style.visibility = 'hidden';
}

