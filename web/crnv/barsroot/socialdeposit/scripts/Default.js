// Картка клієнта
function showClient()
{
	var rnk = document.getElementById("rnk").value;
	window.showModalDialog("Default.aspx?rnk=" + rnk + "&info=1&code=" + Math.random() ,null,
	"dialogWidth:600px; dialogHeight:600px; center:yes; status:no");
}
// Перевірка на заповненість
function ckRNK()
{
	if (document.getElementById("rnk").value == null ||
		document.getElementById("rnk").value == "null" ||
		document.getElementById("rnk").value == ""  )
	{
		alert('Виберіть клієнта');
		return false;
	}
	return true;
}
// Перевірка правильності формату номера паспорта
function ckNumber()
{
	var val = document.getElementById("textDocNumber").value;
	var docType = document.getElementById("listDocType");

	if (document.getElementById("noCheck").value == "1")
		{document.getElementById("noCheck").value = "";return;}
	document.getElementById("noCheck").value = "";
	
	if (docType.selectedIndex != 1)	return;
	var rexp = new RegExp(/\d{6}/);
	if(0==val.length) return;
	if (!rexp.test(val) || val.length > 6)
	{
		alert('Невірний формат номера паспорта!');
		document.getElementById("noCheck").value = "2";		
		document.getElementById("textDocNumber").focus();			
		document.getElementById("textDocNumber").select();
	}
}
// Перевірка правильності формату серії паспорту
function ckSerial()
{
    var val = document.getElementById("textDocSerial").value;
	var docType = document.getElementById("listDocType");

	if (document.getElementById("noCheck").value == "2")
		{document.getElementById("noCheck").value = "";return;}
	document.getElementById("noCheck").value = "";

	if (docType.selectedIndex != 1)	return;
	var rexp = new RegExp(/[A-ZА-Я]{2}/);
	if(0==val.length) return;
	if (!rexp.test(val) || val.length > 2)
	{
		document.getElementById("noCheck").value = "1";		
		alert('Невірний формат серии паспорта!');
		document.getElementById("textDocSerial").focus();	
		document.getElementById("textDocSerial").select();
	}
}
// Перевірка чи символ є цифрою
function doNum()
{
	if (controlKey(event)) return true;
	var digit = ( (event.keyCode > 95 && event.keyCode < 106) 
	|| (event.keyCode > 47 && event.keyCode < 58) );	
	if((event.keyCode > 8) && !digit) return false;
	else return true;
}
// Перевірка чи символ є буквою (допустимою комбінацією клавіш)
function doAlpha()
{
	if (controlKey(event)) return true;
	
	if (event.keyCode == 191 || event.keyCode == 220) return true;

	if (event.keyCode >= 65 && event.keyCode <= 90 || event.keyCode == 32)	
		return true;
				
	if (event.keyCode == 41 || event.keyCode == 40)
		return true;
		
	if (event.keyCode == 186 || event.keyCode == 188 || event.keyCode == 189 
	|| event.keyCode == 190 || event.keyCode == 192 || event.keyCode == 219 
	|| event.keyCode == 221 || event.keyCode == 222)
		return true;

	if (event.keyCode == 8 || event.keyCode == 9  || event.keyCode == 20 || event.keyCode == 35 
	|| event.keyCode == 36 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 45 
	|| event.keyCode == 46 ) 
		return true;
	
	return false;
}
// Перевірка на допустимість комбінації клавіш
function controlKey(event)
{
	if (event.ctrlKey == true) return true;
	if (event.shiftKey == true)
	{ 
		if (event.keyCode == 45 || event.keyCode == 46 
		|| event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 9 ) 
			return true;
		else 
			return false;
	}
	
	return ( event.keyCode == 37 || event.keyCode == 39 ||
	 event.keyCode == 8 || event.keyCode == 35 || event.keyCode == 36 
	 || event.keyCode == 46 || event.keyCode == 13 || event.keyCode == 9 );
}
// Перевірка чи символ є буква\цифро\допустима комбінація клавіш
function doNumAlpha()
{
	if (doAlpha()) return true;
	if (doNum())   return true;
	
	return false;
}
// Перевірка на коректність числа в контролі
function doValueCheck(id)
{
	var val = document.getElementById(id).value;
	
	if (isNaN(val))
	{
		var elem = document.getElementById(id);
		if(!elem.disabled)
		{
			alert('Некоректне значення!');
			elem.focus();
			elem.select();
		}
	}
}
// Перевірка (перехват) переходу по Enter
function ckBeforeGo(id)
{
	var val = document.getElementById(id).value;
	
	if (isNaN(val))
		return false;
	else
		return true;
}
// Форкусування контрола
function focusControl(id)
{
	var control = document.getElementById(id);
	if (control.readonly || control.disabled) return;
	control.focus();
}
function isNotEmpty(val)
{
	if (val != null && val != ' ' && val != 'null' && val != '' )
		return true;
	return false;
}
function isEmpty(val)
{
	return !isNotEmpty(val);
}
function getFullName()
{
	var fullName = '';
	
	if (isNotEmpty(document.getElementById('textClientLastName').value))
		fullName += document.getElementById('textClientLastName').value;
	if (isNotEmpty(document.getElementById('textClientFirstName').value))
		fullName += ' ' + document.getElementById('textClientFirstName').value;
	if (isNotEmpty(document.getElementById('textClientPatronymic').value))
		fullName += ' ' + document.getElementById('textClientPatronymic').value;
	
	document.getElementById('textClientName').value = fullName;
}
// Перевірка ДРФО
function ckOKPO()
{
	var elem = document.getElementById("textClientCode");
	if (elem.value.length < 10 && document.getElementById("textClientCode").value != '000000000')
	{
		if (confirm("Ідентифікаційний код менше 10 знаків!" + "\n" + "Замінити нулями?"))
		    document.getElementById("textClientCode").value = '000000000';
	}
}
// Вибір країни
function openCountryDialog()
{	
	var result = window.showModalDialog("dialogs/selectcountry.aspx?code=" + Math.random(),
	document.getElementById("textCountryCode").value,
	"dialogWidth:300px; dialogHeight:200px; center:yes; status:no");
	if (result != null)
	{
		document.getElementById("textCountryCode").value	= result.CountryCode;
		document.getElementById("textCountry").value		= result.Country;
		
		if (result.CountryCode == 804)
		{
		    document.getElementById('ckResident').checked = 'checked';
		    document.getElementById('ckResident').disabled = 'disabled';
		}
		else
		{
		    document.getElementById('ckResident').disabled = '';
		}
	}
}
// Вихід з модального діалогу вибору країни
function Exit() 
{
	var Result = new Array();
	Result.CountryCode = document.getElementById("listCountry").item(document.getElementById("listCountry").selectedIndex).value;
	Result.Country	   = document.getElementById("listCountry").item(document.getElementById("listCountry").selectedIndex).text;
	window.returnValue = Result;
	window.close();
}
// Виклик модального діалогу пошуку клієнтів
function openDialog(form) 
{
	var result = window.showModalDialog("SearchResults.aspx?code=" + Math.random(),form,
	"dialogWidth:600px; dialogHeight:425px; center:yes; status:no");
	document.getElementById("fRNK").value = result;
	__doPostBack('eventTarget', 'eventArgument');
}
// Підтягування у діалог пошуку клієнтів параметрів
function Fill() 
{
	document.getElementById("textClientName").value		= window.dialogArguments.textClientName.value;
	document.getElementById("textClientCode").value		= window.dialogArguments.textClientCode.value;
	document.getElementById("textClientDate_t").value	= window.dialogArguments.dtBirthDate.value;
	document.getElementById("textClientSerial").value	= window.dialogArguments.textDocSerial.value;
	document.getElementById("textClientNumber").value	= window.dialogArguments.textDocNumber.value;			
	
	document.getElementById("textClientDate_t").focus();
	document.getElementById("textClientName").focus();
}
// Перевірка на потребу заповнити діалог пошуку клієнтів
function CheckNFill() 
{
	if (document.getElementById("isPostBack").value == '0') {
		Fill();
	}
}
// Вихід з діалогу пошуку клієнтів
function SearchResultsExit() 
{
	if (document.getElementById("listSearchClient").selectedIndex != '-1')
		window.returnValue = document.getElementById("listSearchClient").item(document.getElementById("listSearchClient").selectedIndex).value;
	else
		window.returnValue = '-1';
		
	window.close();
}
function ckForm()
{
	var dptType = document.getElementById("listContractType");
    
	if (!dptType.disabled && dptType.selectedIndex == 0)
	{
		alert("Виберіть тип депозитного договору!");
		return false;	
	}
		
	var callObj = window.document.getElementById("webService").createCallOptions();
	
    callObj.async = false;
    callObj.funcName = 'CheckCardNls';
    callObj.params = new Array();
    callObj.params.nls = window.document.getElementById("textTechAcc").value;

    var result = webService.Soc.callService(callObj);
    if (result.error) 
    {
        window.showModalDialog("dialog.aspx?type=err&code=" + Math.random(),
            "","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        return false;
    }
    
    if (result.value != '0' || result.value != "0")
        return true;
    else
    {
        if (confirm("Введеного карткового рахунку не знайдено в системі!\nПродовжити відкриття депозиту?"))
            return true;
        return false;
    }
    
	return true;
}
//Selection Row
var selectedRow;
function S(id,val)
{
 if(selectedRow != null) selectedRow.style.background = '';
 document.getElementById('r_'+id).style.background = '#d3d3d3';
 selectedRow = document.getElementById('r_'+id);
 if(val) document.getElementById('trustee_id').value = val;
}
//Анкета
function ShowSurvey()
{
    window.open('/barsroot/survey/survey.aspx?par=SURVSOC0&rnk=' + document.getElementById('rnk').value,null,
	    "top=0,left=0,height=800,width=800");
}

function changeStyle()
{
	var _div = document.getElementById('full_name');
	if (_div.className == "mo")
	{
		_div.className = "mn";
		document.getElementById('btShowFullName').value = "-";
		document.getElementById('btShowFullName').title = "Звернути";
	}
	else if (_div.className == "mn")
	{
		_div.className = "mo";
		document.getElementById('btShowFullName').value = "+";
		document.getElementById('btShowFullName').title = "Розвернути";
	}
}
function AddAgreement()
{
    var url = "DepositSelectTrustee.aspx?";
    url += "dpt_id=" + document.getElementById('contract_id').value;
    url += "&dest=agreement";
    location.replace(encodeURI(url));
}
function RegTrustee()
{
    var result = window.showModalDialog("RegisterTrustee.aspx?contract_id="+document.getElementById("contract_id").value + "&code=" + Math.random(),null,
	"dialogWidth:800px; dialogHeight:700px; center:yes; status:no");	
	if(result != null)
	    __doPostBack('','');
}

function SetActiveTrustValidate()
{
  if(!selectedRow){ 
    alert("Не виділено довірену особу.");
    return false;
  }
  return true;
}
function GetTemplates()
{
	var url = "DepositContractTemplate.aspx?type=" + document.getElementById('socType').value +
	"&code=" + Math.random();
	var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:600px; dialogHeight:400px; center:yes; status:no");
	if(result){
	    document.getElementById("templates_ids").value = ""; 
	    for (key in result){
	        if(result[key])
		        document.getElementById("templates_ids").value += key + ";";
	    }    
		if(document.getElementById("templates_ids").value != "") 
		    return true;
    }
}

function ShowPrintDialog()
{
	var url = "Dialogs/DepositContractSelect.aspx?dpt_id=" + document.getElementById("contract_id").value + "&code=" + Math.random();
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:500px; dialogHeight:300px; center:yes; status:no");
}
// Друк депозитного договору (для rtf формату)
function Print(template){
	var url = "../DepositPrintContract.aspx?dpt_id="+document.getElementById("_ID").value+
	"&template="+template;
	alert(url);
	window.open(encodeURI(url),"_blank",
	"left=2000,height=10,width=10,menubar=no,toolbar=no,location=no,titlebar=no");
}
function changeConditions()
{
  if(3 == document.all.listConditions.selectedIndex)
  {
    __doPostBack('','');
  }
  else
  {
    if(document.all.listBranches)
        document.all.listBranches.style.visibility = 'hidden';
  }
  
}
function changeBranches()
{
  document.getElementById("branchid").value = document.getElementById('listBranches').selectedIndex;
}

function showHistory(acc)
{
  if(acc != "")
  window.open('/barsroot/customerlist/showhistory.aspx?acc='+acc+'&type=0',null,
	    "top=0,left=0,height=800,width=800");	    
}
function pause(millisecondi)
{
    var now = new Date();
    var exitTime = now.getTime() + millisecondi;

    while(true)
    {
        now = new Date();
        if(now.getTime() > exitTime) return;
    }
}
function show_ck()
{
	if (document.getElementById("ccdoc_id").value == "null" ||
	document.getElementById("ccdoc_id").value == null ||
	document.getElementById("ccdoc_id").value == "") 
	{
		alert("Виберіть додаткову угоду для друку!");
		return false;	
	}
	return true;
}
// Перевірка на заповненість
function agr_ck()
{
	if (document.getElementById("agr_id").value == "null" ||
	document.getElementById("agr_id").value == null ||
	document.getElementById("agr_id").value == "") 
	{
		alert("Виберіть додаткову угоду!");
		return false;	
	}
	return true;
}
// Друк дод. угоди
function AddAgreementPrint() {
	var url = "DepositPrint.aspx?";
	url += "dpt_id=" + document.getElementById("textDptId").value;
	url += "&agr_id=" + document.getElementById("textAgrId").value;
	url += "&agr_num=" + document.getElementById("textAgrNum").value;
	url += "&template=" + document.getElementById("template").value;
	url += "&code=" + Math.random();

	window.showModalDialog(url,null,
	"dialogWidth:800px; dialogHeight:800px; center:yes; status:no");		
}
// Друк дод. угоди  (для rtf формату)
function AddAgreementPrint_rtf() {
	var url = "DepositPrintContract.aspx?";
	url += "dpt_id=" + document.getElementById("dpt_id").value;
	url += "&agr_id=" + document.getElementById("textAgrId").value;
	url += "&agr_num=" + document.getElementById("textAgrNum").value;
	url += "&template=" + document.getElementById("template").value;

	window.open(encodeURI(url),"_blank",
	"left=2000,height=10,width=10,menubar=no,toolbar=no,location=no,titlebar=no");
}
// Друк дод. угоди
function printAgreement() {
	var url = "DepositPrint.aspx?";

	url += "dpt_id=" + document.getElementById("dptid").value;
	url += "&agr_id=" + document.getElementById("ccdoc_agr_id").value;
	url += "&agr_num=" + document.getElementById("ccdoc_ads").value;
	url += "&template=" + document.getElementById("ccdoc_id").value;
	url += "&code=" + Math.random();

	window.showModalDialog(url,null,
	"dialogWidth:800px; dialogHeight:800px; center:yes; status:no");		
}
// Перевірка на заповненість
function rnk_ck()
{
	if (document.getElementById("rnk").value == "null" ||
	document.getElementById("rnk").value == null ||
	document.getElementById("rnk").value == "") 
	{
		alert("Виберіть додаткову угоду для скасування!");
		return false;	
	}
	return true;
}
function Mark(type_id)
{
	event.srcElement.checked?l_agg[type_id]=type_id:l_agg[type_id]=null;
}
function Mark1()
{
	var d_id = event.srcElement.parentElement.dpt_id;
	event.srcElement.checked?l_br[d_id]=d_id:l_br[d_id]=null;
}
function FillOPTS()
{
	var str_ags = document.getElementById("ags");
	var ags_empty = 1;
	
	for (dpt in l_agg) 
	{	    
		if (l_agg[dpt] != null)
		{
		    ags_empty = 0;
			str_ags.value += dpt + ",";
		}
	}	
	if (ags_empty == 1)
	{
		alert('Не вибрано жодного типу ОСЗ!');
		return false;	
	}

	str_ags.value = str_ags.value.substring(0,str_ags.value.length - 1);
	
	return true;
}
function check(val) 
{
	var clientID = document.getElementById('clientNames').value;
	var data = clientID.split('%');
	for(var id in data)
	{
		var ctrl = document.getElementById(data[id]);
		if (ctrl != null)
			ctrl.checked = val;
	}
}
function GetParams()
{
    webService.useService('SocialService.asmx?wsdl','Ag');
    
    var arr_ags;
    var str_ags = document.getElementById("ags").value;

    if (str_ags != "" && str_ags != '' )	        
        arr_ags = str_ags.split(',');

    for (var i in arr_ags) 
    {	        
        var dat = arr_ags[i];
        l_agg[dat] = dat;    
    }	

    document.getElementById("ags").value = '';
}
function changeStyle(obj_id,control_id) 
{
	var _div = document.getElementById(obj_id);
    if (_div.className == "mo")
	{
		_div.className = "mn";
		document.getElementById(control_id).value = "-";
		document.getElementById(control_id).title = "Згорнути";
	}
	else if (_div.className == "mn")
	{
		_div.className = "mo";
		document.getElementById(control_id).value = "+";
		document.getElementById(control_id).title = "Розгорнути";
	}
}		
function ckFields()
{
    if (isEmpty(document.getElementById('textName').value))
    {
        alert('Заповніть назву ОСЗ');
        document.getElementById('textName').focus();
        return false;
    }

	var callObj = window.document.getElementById("webService").createCallOptions();
	
    callObj.async = false;
    callObj.funcName = 'req_field';
    callObj.params = new Array();
    callObj.params.atype = document.getElementById('listAgencyType').value;

    var result = webService.Ag.callService(callObj);
    if (result.error) 
    {
        window.showModalDialog("dialog.aspx?type=err&code=" + Math.random(),
            "","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        return false;
    }
    
    var arr = result.value;
    
    if (arr[0] == "1")  
        if (isEmpty(document.getElementById('textDZ').value))
        {
            alert('Заповніть рахунок дебеторської заборгованості!');
            document.getElementById('textDZ').focus();
            return false;
        }
    if (arr[1] == "1")  
        if (isEmpty(document.getElementById('textKPZ').value))
        {
            alert('Заповніть рахунок кредиторської заборгованості для поточних рахунків!');
            document.getElementById('textKPZ').focus();
            return false;
        }
    if (arr[2] == "1")  
        if (isEmpty(document.getElementById('textKCZ').value))
        {
            alert('Заповніть рахунок кредиторської заборгованості для карткових рахунків)');
            document.getElementById('textKCZ').focus();
            return false;
        }
    if (arr[3] == "1")  
        if (isEmpty(document.getElementById('textMZ').value))
        {
            alert('Заповніть рахунок комісійних доходів!');
            document.getElementById('textMZ').focus();
            return false;
        }
    
    if (!CheckNls('textDZ','D','lbВZM'))
    {
        alert('Помилка!');
        window.document.getElementById('textDZ').focus();
        window.document.getElementById('textDZ').select();
        return false;
    }
    if (!CheckNls('textKPZ','K','lbKZM'))
    {
        alert('Помилка!');    
        window.document.getElementById('textKPZ').focus();
        window.document.getElementById('textKPZ').select();
        return false;
    }    
    if (!CheckNls('textKCZ','C','lbCZM'))
    {
        alert('Помилка!');    
        window.document.getElementById('textKCZ').focus();
        window.document.getElementById('textKCZ').select();
        return false;
    }    
    if (!CheckNls('textMZ','M','lbMZM'))
    {
        alert('Помилка!');    
        window.document.getElementById('textMZ').focus();
        window.document.getElementById('textMZ').select();
        return false;
    }    
    
    return true;
}
// Перевірка на заповненість
function tr_ck()
{
	if (document.getElementById("rnk").value == "null" ||
	document.getElementById("rnk").value == null ||
	document.getElementById("rnk").value == "") 
	{
		alert("Виберіть довірену особу!");
		return false;	
	}
	return true;
}
function CheckNls(nls_name,type,lb_name)
{
    if (isEmpty(window.document.getElementById(nls_name).value))
    {
        window.document.getElementById(lb_name).innerText = '';
        return true;
    }
        
	var callObj = window.document.getElementById("webService").createCallOptions();
	
    callObj.async = false;
    callObj.funcName = 'CheckNls';
    callObj.params = new Array();
    callObj.params.agntype = document.getElementById('listAgencyType').value;
    callObj.params.nls = window.document.getElementById(nls_name).value;
    callObj.params.type = type;
    callObj.params.branch = window.document.getElementById("listBranch").value;

    var result = webService.Ag.callService(callObj);
    if (result.error) 
    {
        window.showModalDialog("dialog.aspx?type=err&code=" + Math.random(),
            "","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        return false;
    }
    
    var arr = result.value;
        
    window.document.getElementById(lb_name).innerText = arr[0];
    window.document.getElementById(nls_name).value = arr[2];
    if (arr[1] == '0' || isEmpty(arr[1]))
    {
        window.document.getElementById(lb_name).style.color = "green";
        return true;
    }
    else
    {
        window.document.getElementById(lb_name).style.color = "red";
    }   
    
    return false;
}
/// Перевірка: дата народження + 16 років >= дати видачі паспорта
function ckClRegDate(dtId,msgNum)
{
	var docType = document.getElementById("listDocType");
	if (docType.selectedIndex != 1)	return;

    var dtBirth	= igedit_getById("dtBirthDate").getDate();
    var dtPassp	= igedit_getById("dtDocDate").getDate();
    if (dtBirth == null || dtPassp == null)
    {
       dtSwitcher = 0; 
       return;
    }
    dtBirth.setFullYear(dtBirth.getFullYear() + 16);
    if (dtBirth > dtPassp)
    {
        alert("Помилка!\nМіж датою народження та датою видачі паспорту\nменше 16 років!");
        document.getElementById(dtId).focus();
        document.getElementById(dtId).select();
        dtSwitcher = msgNum;
    }
    else
        dtSwitcher = 0;
        
    dtBirth.setFullYear(dtBirth.getFullYear() - 16);
    return;
}
function Go(nd,adds,templ) {
	var url = "DepositPrint.aspx?dpt_id=" + nd + "&agr_num=" + adds
	+ "&template=" + templ;
	url += "&code=" + Math.random();

	if (adds != 0)
		url += "&agr_id=1";
	
	window.showModalDialog(url,null
	,"dialogWidth:800px; dialogHeight:800px; center:yes; status:no");	
}
function Acc(acc) {
	window.open(encodeURI("/barsroot/customerlist/showhistory.aspx?acc=" + acc + "&type=0"),null,
	"height=600,width=600,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
}
function GetRequiredFields()
{
    document.getElementById('lbBZM1').style.visibility = 'hidden';
    document.getElementById('lbKZM1').style.visibility = 'hidden';
    document.getElementById('lbCZM1').style.visibility = 'hidden';
    document.getElementById('lbMZM1').style.visibility = 'hidden';

	var callObj = window.document.getElementById("webService").createCallOptions();
	
    callObj.async = false;
    callObj.funcName = 'req_field';
    callObj.params = new Array();
    callObj.params.atype = document.getElementById('listAgencyType').value;

    var result = webService.Ag.callService(callObj);
    if (result.error) 
    {
        window.showModalDialog("dialog.aspx?type=err&code=" + Math.random(),
            "","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        return false;
    }
    
    var arr = result.value;
    
    if (arr[0] == "1")  document.getElementById('lbBZM1').style.visibility = 'visible';
    if (arr[1] == "1")  document.getElementById('lbKZM1').style.visibility = 'visible';
    if (arr[2] == "1")  document.getElementById('lbCZM1').style.visibility = 'visible';
    if (arr[3] == "1")  document.getElementById('lbMZM1').style.visibility = 'visible';
}
/// 
function DeleteAgency(AGENCY_ID)
{
    PageMethods.DeleteAgency(AGENCY_ID,OnSucceeded, OnFailed);
}
function GetStreetType()
{
    var url = 'dialog.aspx?type=metatab&role=wr_metatab&tabname=STREET_TYPES&tail=""';
    url +="&code=" + Math.random();
    
    var result = window.showModalDialog(url,"",
    "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");    
    
    if (result != null)    
    {
        document.getElementById('preClientAddress').value = result[2];
        document.getElementById('hidStreetType').value = result[2];
    }
    
    return true;
}
function CopyAddress(src_control_id,dest_control_id, init_control)
{
    if (src_control_id != null && dest_control_id != null)
    {
        if ( !( isNotEmpty(document.getElementById(dest_control_id).value) &&
                document.getElementById(dest_control_id).value != 
                document.getElementById(src_control_id).value 
               ) 
           )
        {
           if (init_control == null)
                document.getElementById(dest_control_id).value = document.getElementById(src_control_id).value;
           else if (isEmpty(document.getElementById(src_control_id).value))
                document.getElementById(dest_control_id).value = '';
           else
                document.getElementById(dest_control_id).value = document.getElementById(init_control).value + 
                    ' ' + document.getElementById(src_control_id).value;
        }
    }
    
    var dest_str = trim(document.getElementById('textFactIndex').value);
        
    if ((document.getElementById('textFactRegion').value != document.getElementById('preClientRegion').value + ' ')
    && (document.getElementById('textFactRegion').value != document.getElementById('preClientRegion').value)
    )
        dest_str = trim(dest_str) + ' ' + trim(document.getElementById('textFactRegion').value);
    
    if ((document.getElementById('textFactDistrict').value != document.getElementById('preClientDistrict').value + ' ')
    && (document.getElementById('textFactDistrict').value != document.getElementById('preClientDistrict').value)
    )
        dest_str = trim(dest_str) + ' ' + trim(document.getElementById('textFactDistrict').value);
        
    if ((document.getElementById('textFactSettlement').value != document.getElementById('preClientSettlement').value + ' ')
    && (document.getElementById('textFactSettlement').value != document.getElementById('preClientSettlement').value)
    )
        dest_str = trim(dest_str) + ' ' + trim(document.getElementById('textFactSettlement').value);

    if ((document.getElementById('textFactAddress').value != document.getElementById('preClientAddress').value + ' ')
    && (document.getElementById('textFactAddress').value != document.getElementById('preClientAddress').value)
    )
        dest_str = trim(dest_str) + ' ' + trim(document.getElementById('textFactAddress').value);
                       
    document.getElementById('textFactAddressFull').value = trim(dest_str);
}
function replaceWS(text)
{
     if(text == null) return null;
     return text.replace(/ /g,'');
}
// аналог Trim
function trim(text)
{
     if(text == null) return null;
     return text.replace(/^\s*|\s*$/g,'');
}
function validateClientSettlement(source, arguments)
{
    if ( isEmpty(document.getElementById('textClientSettlement').value) )
       {
            arguments.IsValid = false;
       }
       else
       {
            arguments.IsValid = true;
       }
}
function getFullName()
{
	var fullName = '';
	
	if (isNotEmpty(document.getElementById('textClientLastName').value))
		fullName += document.getElementById('textClientLastName').value;
	if (isNotEmpty(document.getElementById('textClientFirstName').value))
		fullName += ' ' + document.getElementById('textClientFirstName').value;
	if (isNotEmpty(document.getElementById('textClientPatronymic').value))
		fullName += ' ' + document.getElementById('textClientPatronymic').value;
	
	document.getElementById('textClientName').value = fullName;
	
    var firstName = document.getElementById('textClientFirstName').value;   
    var lastName = document.getElementById('textClientLastName').value;   
    var patronymic = document.getElementById('textClientPatronymic').value;   
    /// Якщо нічого не вказали - нічого не робимо
    if (isEmpty(firstName) && isEmpty(lastName) && isEmpty(patronymic))
        return;
    /// 1 - чоловіча стать; 2 - жіноча; 
    var sex = document.getElementById('listSex').selectedIndex;
    /// 0 - не визначена (не допускається)
    if (sex == 0)
    {
        alert('Увага! Для коректного обрахування ПІБ клієна у родовому \nвідмінку необхідно задати стать!');        
        if (BarsConfirm("","Задати чоловічу стать?",1,0,0))
        {
            document.getElementById('listSex').selectedIndex = 1;
            sex = 1;
        }
        else if (BarsConfirm("","Задати жіночу стать?",1,0,0))
        {
            document.getElementById('listSex').selectedIndex = 2;
            sex = 2;        
        }
        else
        {
            alert('ПІБ у родовому відмінку обраховуватись не буде!\nЙого потрібно задати для коректного друку договору!');
            return;
        }
    }
    
    if (sex != 0)
        PageMethods.GetNameGenitive(firstName,lastName,patronymic,sex, OnSucceeded, OnFailed);	
}
// Callback function invoked on successful 
// completion of the page method.
function OnSucceeded(result, userContext, methodName) 
{    
    if (methodName == 'GetNameGenitive')
        document.getElementById('textFIOGenitive').value = result;
    else if (methodName == 'DeleteAgency')
    {
        alert('Орган соц. захисту успішно видалений.');
        __doPostBack('','');
    }        
}
// Callback function invoked on failure 
// of the page method.
function OnFailed(error, userContext, methodName) 
{
    if(error !== null) 
    {
        var url = "dialog.aspx?type=err";
        url +="&code=" + Math.random();
        //alert(error);
        window.showModalDialog(url,"",
        "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");    
    }
}
function checkAddress(source, arguments)            
{
    if (    (isEmpty(document.getElementById('textClientIndex').value)       &&
             isEmpty(document.getElementById('textClientRegion').value)      &&
             isEmpty(document.getElementById('textClientDistrict').value)    &&
             isEmpty(document.getElementById('textClientAddress').value) )    
       )
       {
            alert('Заповніть хоча б одне поле адреси крім населеного пункта!');
            arguments.IsValid = false;
       }
       else
       {
            arguments.IsValid = true;
       }
}
function EnableResident()
{
    if (event.srcElement.checked)
        document.getElementById('resid_checked').value = "1";
    else 
        document.getElementById('resid_checked').value = "0";
}
// Перевірка на заповненість
function tmpl_ck()
{
	if (document.getElementById("Template_id").value == null ||
	document.getElementById("Template_id").value == "") 
	{
		alert("Виберіть шаблон!");
		return false;	
	}
	return true;
}
/// Поповнення технічного рахунку
function AskTransferType()
{
    if (confirm("Виплата через касу?"))
    {
        document.getElementById("cash").value = 'true';
        return true;
    }
    else if (confirm("Виплата безготівковим переказом?"))
    {
        document.getElementById("cash").value = 'false';
        return true;        
    }
    
    return false;
}
/// Наводимо фокус на контрол по його ід
function focusControl(id)
{
	var control = document.getElementById(id);
	if (control == null) return;
	if (control.readonly || control.disabled) return;
    control.focus();
}
/// Перевірка на заповненість
function ckFill(control_id,alert_text)
{
	if (IsEmpty(document.getElementById(control_id).value))
	{
	    if (alert_text == null)
		    alert('Не вибрано жодного запису!');
		else
		    alert(alert_text);
		return false;
	}
	return true;
}
/// Перевірка на нул
function IsEmpty(val)
{
	if (val == null || val == ' ' || val == 'null' || val == '' )
		return true;
	return false;
}
/// 
function CheckSum()
{
    var sumMax = Math.round(parseFloat(document.getElementById('textSUM').value) * 100.0 );
    var sum    = Math.round(GetValue('Sum') * 100.0 );
    var com    = Math.round(GetValue('Commission') * 100.0 );
    
    if (sum > sumMax)
    {
        alert('Сума більша залишку на рахунку!');
        return false;
    }
    if (sumMax - com - sum < 0)
    {
        alert('Сума більша максимальної допустимої з врахуванням комісії!');
        return false;    
    }   
    if (sum < 1)
    {
        alert("Неможливо здійснити операцію з нульовою сумою!");
        return false;
    }
    if (sum == sumMax)
    {
        if (confirm('Зняти всі кошти з рахунку?'))    return true;
        else                return false;
    }
    return true;
}
/// Перерахування коштів на касу
function Transfer()
{
    var cash = document.getElementById('cash').value;
    var url = "/barsroot/DocInput/DocInput.aspx?";
    var sum    = Math.round(GetValue('Sum') * 100 );
    if (sum < 1)
    {
        alert('Неможливо здійснити операцію з нульовою сума!');
        return false;
    }
	var dop_rec = "&nd=" + document.getElementById("DPT_ID").value;    
    dop_rec += "&RNK=" + document.getElementById("textRNK").value;
    
    /// Операція через касу
    if (cash == "1")
    {
        document.getElementById('btPay').disabled = 'disabled';    
	    url += "tt=" + document.getElementById("tt").value;

	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + document.getElementById("KV").value;
	    url += "&Kv_B=" + document.getElementById("KV").value;	    
	    url += "&SumC_t=" + sum;
    }
    else
    /// Операція безготівкового перерахування
    {
        if (!CheckFillSideB()) return;

        var our_mfo = document.getElementById('ourMFO').value;
        var mfo_b = document.getElementById('textMFO_B').value;
        var tt;
        if (our_mfo == mfo_b)   tt = document.getElementById('tt_IN').value;
        else                    tt = document.getElementById('tt_OUT').value;

        document.getElementById('btPay').disabled = 'disabled';    
        document.getElementById('Sum').disabled = "disabled";
        /// Для ощадбанку комісій не платимо
        //document.getElementById('btPayCommission').disabled = '';        
	    
	    url += "tt=" + tt;

	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + document.getElementById("KV").value;
	    url += "&Kv_B=" + document.getElementById("KV").value;	    
	    
	    url += "&SumC_t=" + sum;

	    url += "&Nls_B=" + document.getElementById("textNLS_B").value;
	    url += "&Nazn=" + document.getElementById("textNAZN").value;	    
		url += "&Mfo_B="	+ document.getElementById("textMFO_B").value;
		url += "&Id_B="		+ document.getElementById("textOKPO_B").value;
		url += "&Nam_B="	+ document.getElementById("textNMS_B").value;
    }

	url += dop_rec;
    url +="&code=" + Math.random();	

    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	

    /// Операція через касу
    if (cash == "1")
    {
        var dpf = ckDPF(document.getElementById("KV").value,sum/100);
			if (dpf > 0)
			{		
				dpf = Math.round(dpf);		
				DPF(dpf,document.getElementById("Kv").value,
				document.getElementById("DPT_ID").value,dop_rec);
			}
	}
			
    DisableControls();
}
/// Перевірка на заповнення реквізитів сторони Б 
/// при безготівковому переказі з технічного рахунку
function CheckFillSideB()
{
    if (IsEmpty(document.getElementById('textNMS_B').value))
    {
        alert('Заповніть ПІБ одержувача!');
        document.getElementById('textNMS_B').select();
        document.getElementById('textNMS_B').focus();
        return false;
    }
    if (IsEmpty(document.getElementById('textOKPO_B').value))
    {
        alert("Заповніть ідентифікаційний код одержувача!");
        document.getElementById('textOKPO_B').select();
        document.getElementById('textOKPO_B').focus();        
        return false;
    }
    if (IsEmpty(document.getElementById('textNLS_B').value))
    {
        alert("Заповніть номер рахунку одержувача!");
        document.getElementById('textNLS_B').select();
        document.getElementById('textNLS_B').focus();        
        return false;
    }                
    if (IsEmpty(document.getElementById('textMFO_B').value))
    {
        alert("Заповніть МФО рахунку одержувача!");
        document.getElementById('textMFO_B').select();
        document.getElementById('textMFO_B').focus();        
        return false;
    }
//    if (IsEmpty(document.getElementById('textNAZN').value))
//    {
//        alert("Заповніть призначення платежу!");
//        document.getElementById('textNAZN').select();
//        document.getElementById('textNAZN').focus();        
//        return false;
//    }
    return true;
}
// Перевірка на наявність центів для викупу
function ckDPF(kv,sum)
{
	if (kv == 980)
		return 0;
	if (kv == 978)
		return sum%500;
	else
		return sum%100;
}
// Оплата операції викупу центів
function DPF(sum,kv,dop_rec)
{
	var op_name = document.getElementById('dpf_oper').value;
	if (op_name == '' || op_name == "")
	{alert('Не знайдена операція викупу центів!');return;}
		
	var url = "/barsroot/DocInput/DocInput.aspx?tt="+op_name;
	url += "&Kv_A="		+ kv;
	url += "&Kv_B=980";
	url += "&SumA_t="	+ sum;
	url += dop_rec;
	
	url +="&code=" + Math.random();
	
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
}
/// 
function DisableControls()
{
    if (document.getElementById('textNMS_B'))document.getElementById('textNMS_B').disabled = "disabled";    
    if (document.getElementById('textOKPO_B'))document.getElementById('textOKPO_B').disabled = "disabled";    
    if (document.getElementById('textNLS_B'))document.getElementById('textNLS_B').disabled = "disabled";    
    if (document.getElementById('textMFO_B'))document.getElementById('textMFO_B').disabled = "disabled";    
    if (document.getElementById('textNAZN'))document.getElementById('textNAZN').disabled = "disabled";    
}
/// Взяття комісії при перерахуванні коштів безготівкою
function TakeTransferComission()
{
    var cash = document.getElementById('cash').value;
    var url = "/barsroot/DocInput/DocInput.aspx?";
    var sum    = Math.round(GetValue('Sum') * 100 );
    if (sum < 1)
    {
        alert('Неможливо здійснити операцію з нульовою сума!');
        return false;
    }
	var dop_rec = "&nd=" + document.getElementById("DPT_ID").value;
    dop_rec += "&FIO=" + document.getElementById("NMK").value;	
    dop_rec += "&PASP=" + document.getElementById("PASP").value;
    dop_rec += "&PASPN=" + document.getElementById("PASPN").value;
    dop_rec += "&ATRT=" + document.getElementById("ATRT").value;
    dop_rec += "&ADRES=" + document.getElementById("ADRES").value;
    dop_rec += "&DT_R=" + document.getElementById("DT_R").value;
    dop_rec += "&DOBR=" + document.getElementById("DT_R").value;
    dop_rec += "&RNK=" + document.getElementById("textRNK").value;
    
    /// Операція через касу
    if (cash == "1")    
    {
        alert('При виплаті на касу комісія відсутня!');
        return;
    }
    else
    /// Операція безготівкового перерахування
    {
        if (!CheckFillSideB()) return;

        var our_mfo = document.getElementById('ourMFO').value;
        var mfo_b = document.getElementById('textMFO_B').value;
        var tt;
        if (our_mfo == mfo_b)   tt = document.getElementById('tt_IN_K').value;
        else                    tt = document.getElementById('tt_OUT_K').value;

        document.getElementById('btPayCommission').disabled = 'disabled'; 
	    
	    url += "tt=" + tt;

	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + document.getElementById("KV").value;
	    url += "&Kv_B=" + document.getElementById("KV").value;	    
	    
	    var kv = document.getElementById('KV').value;
	    if (kv == 980)	        url += "&SumC_t=" + sum;
	    else        	        url += "&SumA_t=" + sum;

        url += "&SMAIN=" + sum;
    }

	url += dop_rec;
    url +="&code=" + Math.random();	

    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	    
    
    document.getElementById('Sum').disabled = "disabled";    
    DisableControls();
}
/// Перевірка суми при поповненні
function ckSum4Add()
{
    /// Поповнення безготівкою - суму не перевіряємо
    if (document.getElementById('Sum') == null)
        return true;
        
    var sum    = Math.round(GetValue('Sum') * 100.0 );
    
    if (sum < 1)
    {
        alert('Вкажіть будь-ласка суму!\nНеможливо виконати операцію з нульовою сумою!');
        return false;
    }    
    
    return true;
}
/// Поповнення
function AddPayment()
{
    var cash = document.getElementById('cash').value;
    var url = "/barsroot/DocInput/DocInput.aspx?";
	var dop_rec = "&nd=" + document.getElementById("DPT_ID").value;
    dop_rec += "&RNK=" + document.getElementById("RNK").value;
    
    /// Операція через касу
    if (cash == "1")
    {    
        var sum    = Math.round(GetValue('Sum') * 100 );
	    url += "tt=" + document.getElementById("tt").value;

	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + document.getElementById("KV").value;
	    url += "&Kv_B=" + document.getElementById("KV").value;	    
	    url += "&SumC_t=" + sum;
	    
//	    url += "&rnk=" + document.getElementById("textRNK").value;	    	    
    }
    else
    /// не приймаються платежі по безналу
        return;

	url += dop_rec;
    url +="&code=" + Math.random();
    
    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
    
    document.getElementById('btAddPayment').disabled = 'disabled';    
    document.getElementById('btCommission').disabled = 'disabled';        
    document.getElementById('Sum').disabled = 'disabled';    	    
}
/// Комісія за поповнення
function TakeAddCommission()
{
    var cash = document.getElementById('cash').value;
    var url = "/barsroot/DocInput/DocInput.aspx?";
	var dop_rec = "&nd=" + document.getElementById("DPT_ID").value;
    dop_rec += "&FIO=" + document.getElementById("NMK").value;	
    dop_rec += "&PASP=" + document.getElementById("PASP").value;
    dop_rec += "&PASPN=" + document.getElementById("PASPN").value;
    dop_rec += "&ATRT=" + document.getElementById("ATRT").value;
    dop_rec += "&ADRES=" + document.getElementById("ADRES").value;
    dop_rec += "&DT_R=" + document.getElementById("DT_R").value;
    dop_rec += "&DOBR=" + document.getElementById("DT_R").value;
    dop_rec += "&RNK=" + document.getElementById("RNK").value;
    
    /// Операція через касу
    if (cash == "1")
    {
        //document.getElementById('btAddPayment').disabled = '';                
	    url += "tt=" + document.getElementById("tt_K").value;	  
	    var sum    = Math.round(GetValue('Sum') * 100 ); 	    
	    url += "&SMAIN=" + sum;	
	    url += "&KVMAIN=" + document.getElementById("KV").value;	  
	    /// щоб обрахувалась формула комісії
	    url += "&SumC_t=0";
    }
    /// Операція безготівкова
    else
    {        
        if (!confirm('Зняти комісію?')) return;
                
        var lcv = document.getElementById("LCV").value;
        if (IsEmpty(lcv))
        {
            alert("Виберіть безготівкове поповнення!");
            return;
        }
        
        /// Операція в нац. валюті
        if (lcv == "UAH")
        {
	        url += "tt=" + document.getElementById("tt_K_N").value;	   	    	
	        url += "&SumC_t=" + Math.round(document.getElementById("SMAIN").value);        
        }
        /// Операція в іноземній валюті
        else
        {
            url += "tt=" + document.getElementById("tt_K_F").value;	   	    	
            url += "&SumA_t=" + Math.round(document.getElementById("SMAIN").value);        
        }
        url += "&SMAIN=" + Math.round(document.getElementById("SMAIN").value);
        url += "&KVMAIN=" + document.getElementById("KV").value;	  
        url += "&Kv_A=" + document.getElementById("KV").value;	          
        url += "&Nls_A=" + document.getElementById("textNLS").value;
        
        /// Додаємо процедуру після оплати, яка проставить 
        /// що по даному поповненні ми комісію вже взяли
        var after_pay_proc = document.getElementById("after_pay_proc").value;
        after_pay_proc = after_pay_proc.replace('#(REF)',document.getElementById("REF").value);        
        url += "&aftprp=" + after_pay_proc;
        url += "&aftprp_r=" + document.getElementById("after_pay_role").value;
    }

	url += dop_rec;
	url +="&code=" + Math.random();
	
    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");		    

    if (cash != "1")
        __doPostBack('','');
    else
        document.getElementById('btCommission').disabled = 'disabled';
}
///
/// Перерахування коштів на касу
function PayOff()
{
    var url = "/barsroot/DocInput/DocInput.aspx?";
    var sum = document.getElementById("sum").value;
    if (sum < 1)
    {
        alert('Залишок нульовий!');
        return false;
    }
    
	var dop_rec = "&nd=" + document.getElementById("contract_id").value;    
    dop_rec += "&RNK=" + document.getElementById("rnk").value;   
     
    url += "tt=" + document.getElementById("tt").value;    
    url += "&Nls_A=" + document.getElementById("nls_a").value;
    url += "&Kv_A=" + document.getElementById("kv").value;
    url += "&Kv_B=" + document.getElementById("kv").value;	    
    url += "&SumC_t=" + sum;

	url += dop_rec;
    url +="&code=" + Math.random();	

    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	

    var dpf = ckDPF(document.getElementById("kv").value,sum/100);
	if (dpf > 0)
	{		
		dpf = Math.round(dpf);		
		DPF(dpf,document.getElementById("kv").value,
		document.getElementById("contract_id").value,dop_rec);
	}
}