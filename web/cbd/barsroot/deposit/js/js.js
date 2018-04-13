/// Первинний внесок при відкритті вкладу
function FirstPayment()
{
	var url = "/barsroot/DocInput/DocInput.aspx?";
	url += "tt="		+ document.getElementById("TT").value				
	var textsum = document.getElementById("SumC_t").value;
	/// Якщо в нас зовсім погано з культурою на клієнті
	if (parseFloat("1.1") == 1)
		textsum = textsum.replace('.',',');
	else 
		textsum = textsum.replace(',','.');

	var sum = parseFloat(textsum);
	if (document.getElementById("denom").value == "1000") 
    {
	    sum = Math.round(sum * 1000);
	}
	else 
    {
	    sum = Math.round(sum * 100);
	}
	if (sum != null && sum > 0)
		url += "&SumC_t=" + sum;
	
	url += "&nd=" + document.getElementById("dpt_id").value;
	url += "&Kv_A=" + document.getElementById("Kv").value;
	url += "&Kv_B=" + document.getElementById("Kv").value;
	url += "&Nls_A=" + document.getElementById("textDepositAccount").value;

    url += "&RNK=" + document.getElementById("rnk").value;
    url +="&code=" + Math.random();
    
    if (document.getElementById("AfterPay").value != null &&
	document.getElementById("AfterPay").value != "")
		url += "&APROC=" + document.getElementById("AfterPay").value;
				
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
	
	__doPostBack('','');
}
// Поповнення рахунку
function AddSum()
{
    var textMinAddSum = document.getElementById("textMinAddSum").value;

    if (document.getElementById("textContractCurrency").value == "XAU") {
        var textsum = document.getElementById("ContractAddSumGrams").value;
    }
    else
    {
        var textsum = document.getElementById("textContractAddSum").value;
    }

	/// Якщо в нас зовсім погано з культурою на клієнті
	if (parseFloat("1.1") == 1)
	{
		textsum = textsum.replace('.',',');
		textMinAddSum = textMinAddSum.replace('.',',');
    }
	else 
	{
		textsum = textsum.replace(',','.');
		textMinAddSum = textMinAddSum.replace(',','.');
	}

	var sum		= parseFloat(textsum);
	var minSum	= parseFloat(textMinAddSum);

	if ( sum >= minSum )
	{			
	    sum = Math.round(sum * 100);
	    /// Стоп правило на максимальну суму
	    PageMethods.CheckStopFunction(sum, document.getElementById("Kv_B").value,
	        document.getElementById("Nls_A").value, document.getElementById("dpt_id").value,
	        OnSucceeded, OnFailed);
				
		return true;
	}
	else
    {
	    alert(LocalizedString('Mes30')/*'Сумма пополнения меньше минимальной допустимой суммы!'*/);

        document.getElementById("textContractAddSum_t").focus();
        document.getElementById("textContractAddSum_t").select();

        return false;
    }
}

// Вибір коду території (для УПБ)
function showTerritory()
{
    var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=TERRITORY&tail=""&role=WR_CUSTREG', 'dialogHeight:700px; dialogWidth:700px');
    if (result != null && result[0] != null)
    {
        if (result[0] != null)
        {            
            document.getElementById('textClientTerritory').value = result[0];
        }
        if (result[1] != null) 
        {
            document.getElementById('preClientSettlement').value = "";
            document.getElementById('hidSettlementType').value = "";
            document.getElementById('textClientSettlement').value = result[1];
        }
        if (result[3] != null)
        {
            document.getElementById('preClientRegion').value = "";
            document.getElementById('textClientRegion').value = result[3];
        }
        
        if (result[4] != null)
        {
            document.getElementById('preClientDistrict').value = "";
            document.getElementById('textClientDistrict').value = result[4];
        }
        
        // автозаповнення фактичної адреси
        if (isEmpty(document.getElementById('textFactSettlement').value))
            document.getElementById('textFactSettlement').value = document.getElementById('textClientSettlement').value;

        if (isEmpty(document.getElementById('textFactRegion').value))
            document.getElementById('textFactRegion').value = document.getElementById('textClientRegion').value;

        if (isEmpty(document.getElementById('textFactDistrict').value))
            document.getElementById('textFactDistrict').value = document.getElementById('textClientDistrict').value;
    }
}

function showOrganization()
{
    var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=ORGANDOK&tail=""&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:400px');
    
    if (result != null && result[1] != null)
    {
        document.getElementById('textDocOrg').value = result[1];
    }
}

// Довідник ДПА 
function showTaxAgencyCode()
{
    var result = window.showModalDialog('dialog.aspx?type=metatab&role=ABS_ADMIN&tabname=SPR_OBL' +
        '&tail="C_REG > 0"&pk=C_REG&sk=NAME_REG', 'dialogHeight:500px; dialogWidth:700px');

    if (result != null) 
    {
        if (result[0] != null)
            document.getElementById('textTaxAgencyCode').value = result[0];

        if (result[1] != null)
            document.getElementById('textTaxAgencyName').value = result[1];
    }
}

// Довідник кодів органів реєстрації
function showRegAgencyCode()
{
    var result = window.showModalDialog('dialog.aspx?type=metatab&role=ABS_ADMIN&tabname=SPR_REG' +
        '&tail="C_REG = ' + document.getElementById('textTaxAgencyCode').value + '"&pk=C_DST&sk=NAME_STI',
        'dialogHeight:500px; dialogWidth:700px');

    if (result != null)
    {
        if (result[0] != null)
            document.getElementById('textRegAgencyCode').value = result[0];

        if (result[1] != null)
            document.getElementById('textRegAgencyName').value = result[1];
    }
}

// Вибір країни
function openCountryDialog()
{	
    var url = "SelectCountry.aspx";
    url +="?code=" + Math.random();

	var result = window.showModalDialog(url,
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
		    document.getElementById('ckResident').checked = false;
		    document.getElementById('ckResident').disabled = false;
		    EnableResident();
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

/// Ознака резидентності клієнта
function EnableResident()
{
    if (event.srcElement.checked) {
        document.getElementById('resid_checked').value = "1";
        document.getElementById('textClientCode').value = "";
        document.getElementById('textClientCode').readOnly = false;
        document.getElementById('textClientCode').style.backgroundColor = "";
        document.getElementById('textClientCode').style.color = "";
        document.getElementById('listClientCodeType').disabled = false;
    }
    else {
        document.getElementById('resid_checked').value = "0";
        document.getElementById('textClientCode').value = "000000000";
        document.getElementById('textClientCode').readOnly = true;
        // document.getElementById('textClientCode').className = "MyDisabled";
        document.getElementById('textClientCode').style.backgroundColor = "#E8E8E8";
        document.getElementById('textClientCode').style.color = "#B5B5B5";
        document.getElementById('listClientCodeType').disabled = true;
    }
}

// Вибір операції (поповнення \ часткове зняття коштів) при зміні суми депозита
function getOP()
{
	window.returnValue = document.getElementById("op_id").value;
	window.close();
}
// Діалог вибору операції на дод. угоду на зміну суми депозита
function openOPDialog(form)
{
	if (document.getElementById("hid_agr_id").value != "2" &&
	    document.getElementById("hid_agr_id").value != "14" 
	)
		return true;
		
    if (document.getElementById("hid_agr_id").value == "2")
    {
	    var url = "Ask.aspx";
	    url +="?code=" + Math.random();
	    var result = window.showModalDialog(url, form,
	    "dialogWidth:350px; dialogHeight:200px; center:yes; status:no");
	    if (result == null)
	    {
		    alert(LocalizedString('Mes31')/*"Не выбрана операция!"*/ + "\n" + LocalizedString('Mes32')/*"Для продолжения выберите операцию."*/);
		    return false;
	    }
	    else
	    {
		    document.getElementById("OP").value = result;
		    return true;
	    }
	}
	else 
	{
	    var url = "dialog/depositwornoutbills.aspx";
	    url +="?code=" + Math.random();
	    
	    var result = window.showModalDialog(url, form,
	    "dialogWidth:350px; dialogHeight:200px; center:yes; status:no");
	    if (result == null)
	    {
		    alert('Не вказана сума!');
		    return false;
	    }
	    else
	    {
		    document.getElementById("WORNSUM").value = result;
		    return true;
	    }	    
	}
}
// Виклик модального діалогу пошуку клієнтів
function searchOwner(form) {
    var url = "SearchResults.aspx?code=" + Math.random();

    var result = window.showModalDialog(url, form, "dialogWidth:700px; dialogHeight:425px; center:yes; status:no");

    document.getElementById("RNK_TR").value = document.getElementById("RNK").value;
    document.getElementById("RNK").value = result;
    
    __doPostBack('eventTarget', 'eventArgument');
}

// Виклик модального діалогу пошуку клієнтів
function openDialog(form) 
{
    var url = "SearchResults.aspx?code=" + Math.random();

	var result = window.showModalDialog(url, form, "dialogWidth:600px; dialogHeight:425px; center:yes; status:no");

	document.getElementById("fRNK").value = result;

	__doPostBack('eventTarget', 'eventArgument');
}
// Підтягування у діалог пошуку клієнтів параметрів
function Fill() 
{
    if (window.dialogArguments.textClientName)
        document.getElementById("textClientName").value = window.dialogArguments.textClientName.value;
        
    if (window.dialogArguments.textClientCode)
        document.getElementById("textClientCode").value = window.dialogArguments.textClientCode.value;
	
  if (window.dialogArguments.textBirthDate)
    document.getElementById("textClientDate").value = window.dialogArguments.textBirthDate.value;
  else
    document.getElementById("textClientDate").value = window.dialogArguments.dtBirthDate.value;
    
	document.getElementById("textClientSerial").value = window.dialogArguments.textDocSerial.value;
	document.getElementById("textClientNumber").value = window.dialogArguments.textDocNumber.value;			
	
	// document.getElementById("textClientDate_t").focus();
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
// Друк депозитного договору
function DepositSearchPrint() 
{	
    var url = "DepositPrint.aspx";
    url +="?code=" + Math.random();
	window.showModalDialog(url, null,
	"dialogWidth:800px; dialogHeight:800px; center:yes; status:no");		
}
// Друк депозитного договору
function Print() {	
    var url = "DepositPrint.aspx?dpt_id="+document.getElementById("dpt_id").value;
    url +="&code=" + Math.random();
	
	window.open(encodeURI(url),"_blank",
	"height=600,width=800,menubar=no,toolbar=no,location=no,titlebar=no");

	//window.showModalDialog(url, null,
	//"dialogWidth:800px; dialogHeight:800px; center:yes; status:no");		
}
// Друк депозитного договору (для rtf формату)
function Print_rtf(){
	var url = "DepositPrintContract.aspx?dpt_id="+document.getElementById("dpt_id").value;
	window.open(encodeURI(url),"_blank",
	"left=2000,height=10,width=10,menubar=no,toolbar=no,location=no,titlebar=no");
}
// Друк депозитного договору (для rtf формату)
function Print_rtf(template){
	var url = "../DepositPrintContract.aspx?dpt_id="+document.getElementById("dpt_id").value+
	"&template="+template;
	window.open(encodeURI(url),"_blank",
	"left=2000,height=10,width=10,menubar=no,toolbar=no,location=no,titlebar=no");
}
//
function ShowPrintDialog()
{
	var url = "dialog/DepositContractSelect.aspx?dpt_id=" + document.getElementById("dpt_id").value;
	url +="&code=" + Math.random();
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:500px; dialogHeight:300px; center:yes; status:no");
}
// Друк дод. угоди
function AddAgreementPrint(dpt_id, agr_id, agr_num, template) {
	var url = "DepositPrint.aspx?";
	url += "dpt_id=" + dpt_id;
	url += "&agr_id=" + agr_id;
	url += "&agr_num=" + agr_num;
	url += "&template=" + template;
	url +="&code=" + Math.random();

	window.open(encodeURI(url),"_blank",
	"height=800,width=800,menubar=no,toolbar=no,location=no,titlebar=no");

	//window.showModalDialog(url,null,
	//"dialogWidth:800px; dialogHeight:800px; center:yes; status:no");		
}
// Друк дод. угоди  (для rtf формату)
function AddAgreementPrint_rtf(dpt_id, agr_id, agr_num, template) {
	var url = "DepositPrintContract.aspx?";
	url += "dpt_id=" + dpt_id;
	url += "&agr_id=" + agr_id;
	url += "&agr_num=" + agr_num;
	url += "&template=" + template;
    url +="&code=" + Math.random();
    
	window.open(encodeURI(url),"_blank",
	"left=2000,height=10,width=10,menubar=no,toolbar=no,location=no,titlebar=no");
}
// Друк дод. угоди
function printAgreement() {
	var url = "DepositPrint.aspx?";

	url += "dpt_id=" + document.getElementById("dpt_id").value;
	url += "&agr_id=" + document.getElementById("ccdoc_agr_id").value;
	url += "&agr_num=" + document.getElementById("ccdoc_ads").value;
	url += "&template=" + document.getElementById("ccdoc_id").value;
    url +="&code=" + Math.random();

	window.showModalDialog(url,null,
	"dialogWidth:800px; dialogHeight:800px; center:yes; status:no");		
}
// Картка клієнта
function showClient()
{
	var rnk = document.getElementById("rnk").value;
	window.showModalDialog("DepositClient.aspx?rnk=" + rnk + "&info=1" + "&code=" + Math.random()
	,null,"dialogWidth:800px; dialogHeight:800px; center:yes; status:no");
}
// Картка клієнта
function showClientExt()
{
	var rnk = document.getElementById("rnk").value;
	window.showModalDialog("DepositClient.aspx?ext=1&code=" + Math.random()
	,null,"dialogWidth:800px; dialogHeight:600px; center:yes; status:no");
}

// Фокусування контрола
function focusControl(id)
{
	var control = document.getElementById(id);
	if (control.readonly || control.disabled) return;
	control.focus();
}

/// Чи є порожнім значенням
function isNotEmpty(val)
{
	if (val == null || val == ' ' || val == 'null' || val == '' || val == '&nbsp' || val == '&nbsp;' || val == '01/01/0001') 
	    return false;
	return true;
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
	
	document.getElementById('textClientName').value = fullName.toUpperCase();
	
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
//        alert('Увага! Для коректного обрахування ПІБ клієна у родовому \nвідмінку необхідно задати стать!');        
//        if (BarsConfirm("","Задати чоловічу стать?",1,0,0))
//        {
//            document.getElementById('listSex').selectedIndex = 1;
//            sex = 1;
//        }
//        else if (BarsConfirm("","Задати жіночу стать?",1,0,0))
//        {
//            document.getElementById('listSex').selectedIndex = 2;
//            sex = 2;        
//        }
//        else
//        {
//            alert('ПІБ у родовому відмінку обраховуватись не буде!\nЙого потрібно задати для коректного друку договору!');
//            return;
//        }
        if (BarsConfirm("", "Клієнт чоловічої статі?", 1, 0, 0)) 
        {
            document.getElementById('listSex').selectedIndex = 1;
            sex = 1;
        }
        else 
        {
            document.getElementById('listSex').selectedIndex = 2;
            sex = 2;
            alert('Клієнту задано жіночу стать.');
        }
    }
    
    if (sex != 0)
        PageMethods.GetNameGenitive(firstName,lastName,patronymic,sex, OnSucceeded, OnFailed);	
}

// Розбір урл при друці
function getURL() {
	var url = location.href;
	var data = url.split('?');
	url = data[1];
	if (url == null) return;
	var par = url.split('&');
	var dpt_id; var agr_id; var template;var agr_num;
	for(var i=0; i<par.length; i++)
	{
		var pos = par[i].indexOf('=');
			if (par[i].substring(0,pos) == "dpt_id")
					dpt_id		= par[i].substring(pos+1);
			else if (par[i].substring(0,pos) == "agr_id")
					agr_id		= par[i].substring(pos+1);
			else if (par[i].substring(0,pos) == "agr_num")
					agr_num		= par[i].substring(pos+1);
			else if (par[i].substring(0,pos) == "template")
					template	= par[i].substring(pos+1);										
	}
	if (agr_id != null)
	{
    	window.frames["contents"].location.replace("DepositPrintContract.aspx?dpt_id=" + 
    	dpt_id + "&agr_id=" + agr_id + "&template=" + template  + "&agr_num=" + agr_num);
    	window.frames["header"].location.replace("cmd.aspx?dpt_id=" + 
    	dpt_id + "&agr_id=" + agr_id + "&template=" + template  + "&agr_num=" + agr_num);
    }
    else if (template != null)
    {
    	window.frames["contents"].location.replace("DepositPrintContract.aspx?dpt_id=" + 
    	dpt_id + "&template=" + template);    		
    	window.frames["header"].location.replace("cmd.aspx?dpt_id=" + 
    	dpt_id + "&template=" + template);    		    	    	
    }
    else
    {
    	window.frames["contents"].location.replace("DepositPrintContract.aspx?dpt_id=" + dpt_id);    		    
    	window.frames["header"].location.replace("cmd.aspx?dpt_id=" + dpt_id);    		    
    }
}
function addControl()
{
	if (document.getElementById('dptBlankNum')!=null)
	{
		document.getElementById('dptBlankNum').attachEvent('onkeydown',doNum);
		document.getElementById('deadBlankNum').attachEvent('onkeydown',doNum);
	}
}
function EnableBlank()
{  
    if (document.getElementById('tbBlanks'))
    {
        var mode = !document.getElementById('ckUse').checked;
        
        document.getElementById('dptBlankNum').disabled = mode;
        
        /// Якщо друкуємо перший раз - не трогаємо зіпсований бланк
        if(document.getElementById('FIRST_PRINT').value == '0')
            document.getElementById('deadBlankNum').disabled = mode;

        var dptBlankVal = document.getElementById('DptBlankNumValidator');
        ValidatorEnable(dptBlankVal, document.getElementById('ckUse').checked); 
        
        /// Якщо друкуємо перший раз - не трогаємо зіпсований бланк
        if(document.getElementById('FIRST_PRINT').value == '0')
        {
            var deadBlankVal = document.getElementById('deadBlankNumValidator');
            ValidatorEnable(deadBlankVal, document.getElementById('ckUse').checked); 
        }
        
//        var ax = parent.frames["contents"].document.getElementById("BarsPrint");
//        ax.PrintPage(header,footer);
        
//	    var inHTML = parent.frames["contents"].document.body.innerHTML;
//	    var start_pos = inHTML.search('<P>br</P>');
//	    start_pos += 9;
//	    var end_pos = inHTML.search('<P>cbr</P>');
//	    var end = inHTML.length;
//	    
//	    /// якщо потрібно щось вставити
//	    if (document.getElementById('ckUse').checked && (start_pos + 3 > end_pos))
//	    {
//            parent.frames["contents"].document.body.innerHTML = 
//	            inHTML.substring(0,start_pos) + 
//	            document.getElementById('print_buf').value + 
//	            inHTML.substring(end_pos,end);	            	    
//	            
//	        document.getElementById('print_buf').value = '';	        
//	    }
//	    else if (!document.getElementById('ckUse').checked)
//	    {
//	        document.getElementById('print_buf').value 
//	            = parent.frames["contents"].document.body.innerHTML.slice(start_pos,end_pos);
//    	    
//	        parent.frames["contents"].document.body.innerHTML = 
//	            inHTML.substring(0,start_pos) + inHTML.substring(end_pos,end);	            
//	    }
    }
}
//
function resize()
{
	var frameset = window.parent.document.getElementById('mFrameSet');

	if (document.getElementById("tbBlanks") == null)
		frameset.rows = "30,*";
	else
		frameset.rows = "120,*";
}

//function insertActiveX()
//{		
//    alert("da");
//    str_object_barsie='<OBJECT id="BarsPrint" '+
//        'classid="CLSID:0E21DB0E-5A6E-435B-885B-04D3D92AA3BE" '+
//        'BORDER=0 VSPACE=0 HSPACE=0 ALIGN=TOP HEIGHT=0% WIDTH=0%></OBJECT>';
//    var elem =parent.frames["contents"].document.createElement(str_object_barsie);
//    alert(elem);
//    parent.frames["contents"].document.body.insertAdjacentElement("beforeEnd",elem);
//}

// Друк документа
function printcmd(){
	try {	
//        // Автоматичний друк на принтер по замовчуванню
//        var ax = parent.frames["contents"].document.getElementById("BarsPrint");
//        var header = (document.getElementById("hidHeader")==null?'':document.getElementById("hidHeader").value);
//        var footer = (document.getElementById("hidFooter")==null?'':document.getElementById("hidFooter").value);
//
//        ax.PrintPage(header,footer);
//        
//        hideProgress();
//        alert('Документ був успішно відправлений на друк.');
        
        // Друк через вибір принтера
		parent.frames['contents'].focus();
		parent.frames['contents'].print(); 
	}
	catch(e){alert(e.message);}
}
// Друк документа
function printcmd_withfooter(footer){
	try {	
        var ax = parent.frames["contents"].document.getElementById("BarsPrint");

        ax.PrintPage("",footer);

        hideProgress();
        alert('Документ був успішно відправлений на друк.');        
	}
	catch(e){alert(e.message);}
}

//
function returnAcc(branch, nls, fio, okpo)
{
    var Result = new Array();

	Result.mfo = branch;
	Result.nls = nls;
	Result.fio = fio;
	Result.okpo = okpo;
	window.returnValue = Result;
	window.close();	
}
//
function SearchAccounts(type, nls, mfo, okpo, fio)
{
    var url = "DepositCardAcc.aspx?";
	url += "mfo=" + document.getElementById("MFO").value;
	url += "&okpo=" + document.getElementById("OKPO").value;
	url += "&rnk=" + document.getElementById("rnk").value;
	url += "&cur_id=" + document.getElementById("cur_id").value;
	url += "&type=" + type;
	url += "&code=" + Math.random();

	var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:600px; dialogHeight:400px; center:yes; status:no");
	
	if (result != null)
	{
	    document.getElementById(mfo).value = result.mfo;
	    document.getElementById(nls).value = result.nls;
	    document.getElementById(fio).value = result.fio;

	    document.getElementById(okpo).value = document.getElementById("OKPO").value;
	}
}

// реквізити вибраної БПК
function get_CardNls()
{
    var url = "DepositCardAcc.aspx?";    
    // url += "&okpo=" + document.getElementById("OKPO").value;
    url += "&rnk=" + document.getElementById("rnk").value;
    url += "&cur_id=" + document.getElementById("cur_id").value;
    url += "&code=" + Math.random();

    var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:600px; dialogHeight:400px; center:yes; status:no");

    if (result != null)
    {
        document.getElementById('textRestRcpMFO').value = result.mfo;
        document.getElementById('textAccountNumber').value = result.nls;
        document.getElementById('textRestRcpName').value = result.fio;
        document.getElementById('textRestRcpOKPO').value = result.okpo;
        
        // якщо депозит без капіталізації
        if (document.getElementById('textBankAccount'))
        {
            document.getElementById('textBankMFO').value = result.mfo;
            document.getElementById('textBankAccount').value = result.nls;
            document.getElementById('textIntRcpName').value = result.fio;
            document.getElementById('textIntRcpOKPO').value = result.okpo;
        }
    }
}
// реквізити дострокової виплати валютного депозиту в грн (Yurchenko)
function get_Nlsb()
{
    var url = "DepositCardAcc.aspx?";    
    // url += "&okpo=" + document.getElementById("OKPO").value;
    url += "&rnk=" + document.getElementById("rnk").value;
    url += "&cur_id=980";
    url += "&mode=cardn";
    url += "&code=" + Math.random();

    var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:600px; dialogHeight:400px; center:yes; status:no");

    if (result != null)
    {
        document.getElementById('textMFO').value = result.mfo;
        document.getElementById('textNLS').value = result.nls;
        document.getElementById('textNMK').value = result.fio;
        document.getElementById('textOKPO').value = result.okpo;
        
       
    }
}


// реквізити кредитних рахунків під заставу депозиту (Yurchenko)
function get_CreditNls()
{
    var url = "DepositCardAcc.aspx?";    
    // url += "&okpo=" + document.getElementById("OKPO").value;
    url += "&rnk=" + document.getElementById("rnk").value;
    url += "&cur_id=" + document.getElementById("cur_id").value;
    url += "&mode=pawn";
    url += "&code=" + Math.random();

    var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:600px; dialogHeight:400px; center:yes; status:no");

    if (result != null)
    {
        //document.getElementById('textRestRcpMFO').value = result.mfo;
        //document.getElementById('textAccountNumber').value = result.nls;
        //document.getElementById('textRestRcpName').value = result.fio;
        //document.getElementById('textRestRcpOKPO').value = result.okpo;
        
        // рахунки виплати відсотків
        if (document.getElementById('textBankAccount'))
        {
            document.getElementById('textBankMFO').value = result.mfo;
            document.getElementById('textBankAccount').value = result.nls;
            document.getElementById('textIntRcpName').value = result.fio;
            document.getElementById('textIntRcpOKPO').value = result.okpo;
        }
    }
}

//
// Сброс картсчета выплаты капитала - отмена ДУ на изменение счета выплаты капитала
// Pavlenko Inga BRSMAIN-2719 15/07/2014
function CleanRetDepositAccounts()
{
   document.getElementById('textAccountNumber').value = "";
   document.getElementById('textRestRcpName').value = "";
   document.getElementById('textRestRcpMFO').value = "";
   document.getElementById('textRestRcpOKPO').value = "";
}    

// Сброс картсчета выплаты %% - отмена ДУ на изменение счета выплаты %
// Pavlenko Inga BRSMAIN-2719 15/07/2014
function CleanRetPercentAccounts()
{
   document.getElementById('textBankAccount').value = "";
   document.getElementById('textIntRcpName').value = "";
   document.getElementById('textBankMFO').value = "";
   document.getElementById('textIntRcpOKPO').value = "";
}    


//
function GetTemplates()
{
	var vidd = document.getElementById('vidd').value;
	var url = "dialog/DepositContractTemplate.aspx?vidd="+ vidd;
	url +="&code=" + Math.random();
	var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:600px; dialogHeight:400px; center:yes; status:no");
	
	document.getElementById("Templates").value = ""; 
	for (key in result)
		document.getElementById("Templates").value += key + ";";

	if (document.getElementById("Templates").value != null 
	&& document.getElementById("Templates").value.length >0)
		document.getElementById("Templates").value 
		= document.getElementById("Templates").value.substring(0,document.getElementById("Templates").value.length-1);
}
function EnableDptType()
{
	var dptType = document.getElementById("listDepositType");
	if (event.srcElement.checked)
		dptType.disabled = false;
	else
		dptType.disabled = true;		
}
function EnableBranch()
{
	var dptType = document.getElementById("listBranch");
	if (event.srcElement.checked)
		dptType.disabled = false;
	else
		dptType.disabled = true;		
}
function CkDateCtrl()
{
	var dptDate = document.getElementById("dtDptEndDate_t");
	var ctrl = event.srcElement;
	if (ctrl.value == -10 || ctrl.value == 10)
		dptDate.disabled = true;
	else
		dptDate.disabled = false;
}
function Mark()
{
	var d_id = event.srcElement.dpt_id;
	event.srcElement.checked?l_arr[d_id]=d_id:l_arr[d_id]=null;
}
function check() 
{
	//var clientID = document.getElementById('clientNames').value;
	//var data = clientID.split('%');
	var obj_arr = document.getElementById('gridDeposits').getElementsByTagName('input');
	for(var id = 0; id < obj_arr.length; id ++)
	{
		if (obj_arr[id] != null)
		{
		    if (obj_arr[id].dpt_id)
		    {
			    obj_arr[id].click();
			}
	    }
	}
}

function FillDpts()
{
	var str_dpt = document.getElementById("dpts");
	if (l_arr.length == 0)
	{
	    // Не выбран ни один депозит!
        alert(LocalizedString('Mes34'));
		return false;
	}
	for (dpt in l_arr) 
	{
		if (l_arr[dpt] != null)
			str_dpt.value += dpt + ",";
	}	

	str_dpt.value = str_dpt.value.substring(0,str_dpt.value.length - 1);
	
	return true;
}

function PrintLetters(val)
{
	val = unescape(val);
	var file_names = val.split('?');
	for (var i = 0; i<file_names.length; i++)
	{
		var url = "dialog.aspx?type=print_html&filename=" + file_names[i]
			+ "&print_now=1";

	    var top = window.screen.height/2 - 50;
        var left = window.screen.width/2 - 100;

	    //window.showModalDialog(encodeURI(url),null,
	    //"dialogWidth:200px; dialogHeight:100px; center:yes; status:no");	

		window.open(encodeURI(url),"_blank",
		"left=" + left + ",top=" + top + 
		",height=100px,width=200px,menubar=no,toolbar=no,location=no,titlebar=no");
	}
}
function openSign()
{
	var dpt_id = document.getElementById("dpt_id").value;
	var url = "dialog/DepositSignDialog.aspx?dpt_id="+ dpt_id ;
	window.open(encodeURI(url),"_blank",
	"left=200,top=200,height=400,width=600,menubar=no,toolbar=no,location=no,titlebar=no")
	return false;
}
function getDocsToSign(template)
{
	event.srcElement.checked?l_sgn[template]=template:l_sgn[template]=null;	
}
function getTemplatesToSign()
{
	var str_sign = document.getElementById("templ");
	str_sign.value = "";
	
	for (dpt in l_sgn) 
		str_sign.value += dpt + ",";

	if (str_sign.value == "")
	{
		alert(LocalizedString('Mes35')/*'Не выбран ни один документ!'*/);
		return false;
	}

	str_sign.value = str_sign.value.substring(0,str_sign.value.length - 1);
	return true;	
}
function DptAttr()
{
	var dpt_id = document.getElementById("dpt_id").value;
	
	var url = "dialog/DptField.aspx?dpt_id="+ dpt_id;
	
	window.open(encodeURI(url),"_blank",
	"left=200,top=200,height=400,width=600,menubar=no,toolbar=no,location=no,titlebar=no,status=yes");
}
function Correct(info_id)
{
	var url = "dialog/DepositBFRowCorrection.aspx?"
	+"info_id="+ info_id;
	
	url +="&code=" + Math.random();				
	
	var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:500px; dialogHeight:450px; center:yes; status:no");	

	var theform;
	if (window.navigator.appName.toLowerCase().indexOf("netscape") > -1) {
		theform = document.forms["dptFileForm"];
	}
	else {
		theform = document.dptFileForm;
	}
	document.getElementById('bf_reload').value = "1";
	theform.submit();
}
function Correct_ext(info_id)
{
	var url = "dialog/depositbfrowcorrection_ext.aspx?"
	+"info_id="+ info_id;
	
	url +="&code=" + Math.random();				
	
	var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:800px; dialogHeight:800px; center:yes; status:no");	

	var theform;
	if (window.navigator.appName.toLowerCase().indexOf("netscape") > -1) {
		theform = document.forms["dptFileForm"];
	}
	else {
		theform = document.dptFileForm;
	}
	document.getElementById('bf_reload').value = "1";
	theform.submit();
}

function GetFile(filename,dat,header_id)
{
	location.replace('DepositFile.aspx?filename=' + filename + '&dat=' + dat + '&header_id=' + header_id);
}
function GetFileExt(filename,dat,header_id)
{
    var url = 'DepositFile_ext.aspx?filename=' + filename + '&dat=' + dat + '&header_id=' + header_id + 
        document.getElementById('redir_uri_add').value;
	location.replace(url);
}

function OpenSurvey(url)
{
    var top = window.screen.height/2 - 300;
    var left = window.screen.width/2 - 400;
    
    url +="&code=" + Math.random();		

	window.open(encodeURI(url),"_blank",
	"left=" + left + ",top=" + top + 
	",height=600px,width=800px,menubar=no,toolbar=no,location=no,titlebar=no,resizable=yes,scrollbars=yes");   
}
/// 
function SaveComment()
{
    var comm = document.getElementById('textContractComments').value;

    var dpt_id = document.getElementById('dpt_id').value;

    PageMethods.SaveComment(comm,dpt_id,OnSucceeded, OnFailed);
}
// Callback function invoked on successful 
// completion of the page method.
function OnSucceeded(result, userContext, methodName) 
{    
    if (methodName == 'SaveComment')
        alert( LocalizedString('Mes42'));//'Коментар успішно збережено!'
    else if (methodName == 'GetNameGenitive')
        document.getElementById('textFIOGenitive').value = result;
    else if (methodName == 'CheckStopFunction')
    {              
        var textsum = document.getElementById("textContractAddSum").value;

	    /// Якщо в нас зовсім погано з культурою на клієнті
	    if (parseFloat("1.1") == 1)
		    textsum = textsum.replace('.',',');
	    else 
		    textsum = textsum.replace(',','.');

	    var sum		= parseFloat(textsum);
	    sum = Math.round(sum * 100);
    
		var url = "/barsroot/DocInput/DocInput.aspx?tt=" + document.getElementById("TT").value;
		url += "&nd="		+ document.getElementById("dpt_id").value;
		url += "&SumC_t="	+ sum;
		url += "&Kv_A="		+ document.getElementById("Kv_B").value;
		url += "&Kv_B="		+ document.getElementById("Kv_B").value;
		url += "&Nls_A="	+ document.getElementById("Nls_A").value;
		url += "&RNK=" + document.getElementById("rnk").value;
		url += "&bal=0";  /// Ховаєм поле з залишком на рахунку в формі вводу документу
        url += "&code=" + Math.random();		
        
        if (document.getElementById("AfterPay").value != null &&
	        document.getElementById("AfterPay").value != "")
		url += "&APROC=" + document.getElementById("AfterPay").value.replace("#",sum);
		
		window.showModalDialog(encodeURI(url),null,
		"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
		
		var dest_url = document.getElementById("dest_url").value;
		/// 
		if (isEmpty(dest_url))    
		{
		    document.getElementById("btAdd").disabled = 'disabled';
		    document.getElementById("textContractAddSum_t").disabled = 'disabled';
		}
		else
		    location.replace(dest_url);
    }  
    else if (methodName == 'GetRate')
    {
        if (isNotEmpty(result))
        {
            if (isNotEmpty(result[0]))
            {
                document.getElementById('textBasePercent').value = result[0];        
                document.getElementById('textBasePercent').fireEvent('onfocusin');
            }
            if (isNotEmpty(result[1]))
            {
                document.getElementById('ForecastPercent').value = result[1];        
                document.getElementById('ForecastPercent').fireEvent('onfocusin');
            }            
        }
    } 
    else if (methodName == 'FillInSession')
    {
        var url = "/barsroot/deposit/DepositPrint.aspx?rand=" + Math.random();
    	
	    window.showModalDialog( url, null, "dialogWidth:800px; dialogHeight:800px; center:yes; status:no" );
    } 
    else if (methodName == 'GetDatEnd')
    {
        if (isNotEmpty(result))
        {
            document.getElementById('dtContractEnd_t').value = result;
            document.getElementById('dtContractEnd').fireEvent('onfocusin');
        } 
        PageMethods.GetRate(document.getElementById("textDurationDays").value,
            document.getElementById("textDurationMonths").value,
            document.getElementById("textContractSum").value,
            document.getElementById("listContractType").options[document.getElementById("listContractType").selectedIndex].value,
            document.getElementById("nb").value,
            document.getElementById("kv").value,
            document.getElementById("denom").value,
            OnSucceeded, OnFailed);     
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
///
function CopyAddress(src_control_id, dest_control_id, init_control)
{
    if (src_control_id != null && dest_control_id != null)
    {
        if ( !( isNotEmpty(document.getElementById(dest_control_id).value) &&
                document.getElementById(dest_control_id).value != document.getElementById(src_control_id).value ) 
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
    &&  (document.getElementById('textFactSettlement').value != document.getElementById('preClientSettlement').value)
    )
        dest_str = trim(dest_str) + ' ' + trim(document.getElementById('textFactSettlement').value);

    if ((document.getElementById('textFactAddress').value != document.getElementById('preClientAddress').value + ' ')
    && (document.getElementById('textFactAddress').value != document.getElementById('preClientAddress').value)
    )
        dest_str = trim(dest_str) + ' ' + trim(document.getElementById('textFactAddress').value);
                       
    document.getElementById('textFactAddressFull').value = trim(dest_str);
}

///
function UnionClientAddress()
{
    var FullAddress = "";

    // індекс
    if (!(isEmpty(document.getElementById('textClientIndex').value)))
    {
        FullAddress = document.getElementById('textClientIndex').value + " ";
    }

    // область
    if (!(isEmpty(document.getElementById('textClientRegion').value)))
    {
        FullAddress += document.getElementById('preClientRegion').value + " " +
            document.getElementById('textClientRegion').value + " ";
    }

    // Район
    if (!(isEmpty(document.getElementById('textClientDistrict').value)))
    {
        FullAddress += document.getElementById('preClientDistrict').value + " " +
            document.getElementById('textClientDistrict').value + " ";
    }

    // Населений пункт
    if (!(isEmpty(document.getElementById('textClientSettlement').value)))
    {
        FullAddress += document.getElementById('preClientSettlement').value + " " + 
            document.getElementById('textClientSettlement').value + " ";
    }
    
    // Вулиця 
    if (!(isEmpty(document.getElementById('textClientAddress').value)))
    {
        FullAddress += document.getElementById('preClientAddress').value + " " +
            document.getElementById('textClientAddress').value;
    }

    // Повна адреса порписки
    document.getElementById('textClientAddressFull').style.visibility = "visible";
    document.getElementById('textClientAddressFull').value = trim(FullAddress);
}
///
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
/// Фінансова картка рахунку
function ShowDocCard(ref)
{
    var url = "/barsroot/documentview/default.aspx?ref="+ref;
    
	var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:800px; dialogHeight:600px; center:yes; status:no");
}
/// 
function DelBonusRequest(bonus_id)
{
    document.getElementById('bonus_id').value = bonus_id;
    __doPostBack('','');    
}
///
function FormBonusRequest(BONUS_ID)
{
    document.getElementById('ins_bonus_id').value = BONUS_ID;
    __doPostBack('','');    
}
/// 
function ConfirmDelete(REQ_ID)
{
    document.getElementById('hidConfirmDelete').value = REQ_ID;
    __doPostBack('','');    
}
/// 
function DeclineDelete(REQ_ID)
{
    document.getElementById('hidDeclineDelete').value = REQ_ID;
    __doPostBack('','');    
}
///
function DETAILS(REQ_ID)
{
    document.getElementById('SelId').value = REQ_ID;
    __doPostBack('','');    
}
///
function NoComiss(REQ_ID,AGR_ID)
{
    document.getElementById('confirm_reqid').value = REQ_ID;
    document.getElementById('confirm_agr_type').value = AGR_ID;
    __doPostBack('','');    
}
///
function DelComissRequest(REQ_ID)
{
    document.getElementById('reqid').value = REQ_ID;
    __doPostBack('','');    
}
///
function ckFileHeader()
{ 
    var elem;
    //----------------
    elem = document.getElementById('FILENAME');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('FILENAME');
        return true;
    }
    //----------------
    elem = document.getElementById('DAT');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('DAT');
        return true;
    }
    //----------------
//    elem = document.getElementById('INFO_NUM');
//    if (isEmpty(elem.value))
//    {
//        alert('Заповніть обовязкове значення!');
//        focusControl('INFO_NUM');
//        return true;
//    }
    //----------------
    elem = document.getElementById('HEADER_LENGTH');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('HEADER_LENGTH');
        return true;
    }    
    //----------------
    elem = document.getElementById('MFO_A');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('MFO_A');
        return true;
    }    
    //----------------
    elem = document.getElementById('NLS_A');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('NLS_A');
        return true;
    }    
    //----------------
    elem = document.getElementById('MFO_B');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('MFO_B');
        return true;
    }    
    //----------------
    elem = document.getElementById('NLS_B');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('NLS_B');
        return true;
    }    
    //----------------
    elem = document.getElementById('DK');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('DK');
        return true;
    }    
    //----------------
    elem = document.getElementById('SUM');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('SUM');
        return true;
    }    
    //----------------
    elem = document.getElementById('TYPE');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('TYPE');
        return true;
    }    
    //----------------
    elem = document.getElementById('NAME_A');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('NAME_A');
        return true;
    }    
    //----------------
    elem = document.getElementById('NAME_B');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('NAME_B');
        return true;
    }      
    //----------------
    elem = document.getElementById('DPT_CODE');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('DPT_CODE');
        return true;
    }      
    //----------------
    elem = document.getElementById('BRANCH_CODE');
    if (isEmpty(elem.value))
    {
        alert('Заповніть обовязкове значення!');
        focusControl('BRANCH_CODE');
        return true;
    }      
    //----------------  
//    elem = document.getElementById('INFO_NUM');
//    if (parseFloat(elem.value) < 1)
//    {
//        alert('Значення має бути більше нуля!');
//        focusControl('INFO_NUM');
//        return true;    
//    }
    //----------------        
//    elem = document.getElementById('HEADER_LENGTH');
//    if (parseFloat(elem.value) < 1)
//    {
//        alert('Значення має бути більше нуля!');
//        focusControl('HEADER_LENGTH');
//        return true;    
//    }
    //----------------            
//    elem = document.getElementById('SUM');
//    if (parseFloat(elem.value) < 1)
//    {
//        alert('Значення має бути більше нуля!');
//        focusControl('SUM');
//        return true;    
//    }    
  
    return false;
}
///
function FormRate(req_id,reqc_expdate,reqc_newint)
{
    document.getElementById('hid_req_id').value = req_id;
    document.getElementById('hid_new_rate').value = trim(reqc_newint);
    document.getElementById('hid_new_date').value = reqc_expdate;
    __doPostBack('','');
}

// Перегляд картки депозитного договору
function ShowDepositCard(dpt_id)
{
    ShowDepositCardExt(dpt_id, "");
}

// // Перегляд картки депозитного договору (розширена)
function ShowDepositCardExt(dpt_id, mode)
{
    var url = "DepositContractInfo.aspx?dpt_id=" + dpt_id + "&readonly=true" + mode;
    url +="&code=" + Math.random();
    var top = window.screen.height/2 - 400;
    var left = window.screen.width/2 - 400;

	window.open(encodeURI(url),"_blank",
	"left=" + left + ",top=" + top + 
	",height=800px,width=800px,menubar=no,toolbar=no,location=no,titlebar=no,resizable=yes,scrollbars=yes");
}

///
function RegisterNewInheritor()
{
    var url = "depositclient.aspx?customer=1&inherit=true";
    url +="?code=" + Math.random();

	var obj = window.showModalDialog(encodeURI(url),null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	    
	
	if (obj != null)
	{
	    document.getElementById('hidRNK').value = obj[0];
	    document.getElementById('hidFIO').value = obj[1];
	    document.getElementById('RNK').value = obj[0];
	    document.getElementById('FIO').value = obj[1];
	    if (document.getElementById('fvInheritor_INHERIT_ID'))
	        document.getElementById('fvInheritor_INHERIT_ID').value = obj[0];
	}
}
///
function RegisterNewInheritorSimplify() {
    var url = "depositclient.aspx?customer=1&inherit=true&simplify=true";
    url += "?code=" + Math.random();

    var obj = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");

    if (obj != null) {
        document.getElementById('hidRNK').value = obj[0];
        document.getElementById('hidFIO').value = obj[1];
        document.getElementById('RNK').value = obj[0];
        document.getElementById('FIO').value = obj[1];
        if (document.getElementById('fvInheritor_INHERIT_ID'))
            document.getElementById('fvInheritor_INHERIT_ID').value = obj[0];
    }
}
///
function ckInherit()
{
    if (isEmpty(document.getElementById('inherit_id').value))
    {
        alert('Виберіть спадкоємця!');
        return false;
    }
    return true;
}
///
function InheritPercent()
{
    if (!ckInherit()) return;
    
    var url = 'depositpercentpay.aspx?';
    url += 'dpt_id=' + document.getElementById('dpt_id').value;
    url += '&tt=' + document.getElementById('TT_P').value;
    url += '&inherit_id=' + document.getElementById('inherit_id').value;
    
    location.replace(encodeURI(url));
}
///
function InheritReturn()
{
    if (!ckInherit()) return;

    //var url = 'depositreturn.aspx?';
    var url = 'depositselecttt.aspx?';
    url += 'dpt_id=' + document.getElementById('dpt_id').value;
    url += '&inherit_id=' + document.getElementById('inherit_id').value;
    url += '&dest=return';
    url += '&tt=' + document.getElementById('TT_R').value;
    
    location.replace(encodeURI(url));    
}
///
function InheritClose()
{
    if (!ckInherit()) return;
    
    //var url = 'depositclosepayit.aspx?';
    var url = 'depositselecttt.aspx?';
    url += 'dpt_id=' + document.getElementById('dpt_id').value;
    url += '&inherit_id=' + document.getElementById('inherit_id').value;
    url += '&dest=close';
    url += '&tt=' + document.getElementById('TT_C').value;;
    
    location.replace(encodeURI(url));    
}

///
///
///
function GetRate()
{
//    for(i=0; i<1000;i++)
//    {     

    PageMethods.GetRate(document.getElementById("textDurationDays").value,
        document.getElementById("textDurationMonths").value,
        document.getElementById("textContractSum").value,
        document.getElementById("listContractType").options[document.getElementById("listContractType").selectedIndex].value,
        document.getElementById("nb").value,
        document.getElementById("kv").value,
        document.getElementById("denom").value,
        OnSucceeded, OnFailed);
//    }
}

// Довідник типів вулиць
function GetStreetType()
{
    var url = 'dialog.aspx?type=metatab&role=ABS_ADMIN&tabname=ADDRESS_STREET_TYPE&tail=""&pk=VALUE&sk=NAME';
    url +="&code=" + Math.random();
    
    var result = window.showModalDialog(url,"",
    "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");    
    
    if (result != null)    
    {
        document.getElementById('preClientAddress').value = result[0];
        document.getElementById('hidStreetType').value = result[0];
    }
    
    return true;
}

// Довідник типів населених пунктів
function GetLocalityType()
{
    var url = 'dialog.aspx?type=metatab&role=ABS_ADMIN&tabname=ADDRESS_LOCALITY_TYPE&tail=""&pk=VALUE&sk=NAME';
    url += "&code=" + Math.random();

    var result = window.showModalDialog(url, "",
    "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");

    if (result != null)
    {
        document.getElementById('preClientSettlement').value = result[0];
        document.getElementById('hidSettlementType').value = result[0];
    }

    return true;
}

function enablePrintButton()
{
    window.frames["header"].document.getElementById('btPrint').disabled = '';
}

function Go(nd,adds,agr_id,templ) 
{
    PageMethods.FillInSession(nd, adds, templ, agr_id,
        OnSucceeded, OnFailed);
}
function CalcEndDate()
{
    PageMethods.GetDatEnd(document.getElementById("dtContractBegin_t").value,
        document.getElementById("textDurationMonths").value,
        document.getElementById("textDurationDays").value,
        OnSucceeded, OnFailed);        
}
function Edit_client(rnk)
{
	var url = "/barsroot/clientregister/registration.aspx?readonly=0&rnk="+ rnk;	
	//url +="&code=" + Math.random();				
	
	window.open(encodeURI(url),"_blank",
	"height=600,width=800,menubar=no,toolbar=no,location=no,titlebar=no");
}
function Edit_account(acc,rnk)
{   
	var url = '/barsroot/viewaccounts/accountform.aspx?type=1&acc=' + acc + '&rnk='+ rnk + '&accessmode=1';	
	
	window.open(encodeURI(url),"_blank",
	"height=600,width=800,menubar=no,toolbar=no,location=no,titlebar=no");
}
/// 
function CheckSum4Trans()
{
    var denom = 100;

    if (document.getElementById("denom").value == "1000") 
    {
        denom = 1000;
    }

    var sumMax = Math.round(parseFloat(document.getElementById('maxSUM').value) * denom);
    var sum = Math.round(GetValue('Sum') * denom);
    var com = Math.round(GetValue('Commission') * denom);
    
    if (sum > sumMax)
    {
        alert('Сума більша максимально допустимої!');
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

///
/// Перерахування коштів на касу
///
function Transfer()
{
    var cash = document.getElementById('cash').value;
    var url = "/barsroot/DocInput/DocInput.aspx?";

    var denom = parseInt(document.getElementById("denom").value);
    var sum = Math.round(GetValue('Sum') * denom);
        
    // var com = Math.round(GetValue('Commission') * denom);

    if (sum < 1)
    {
        alert('Неможливо здійснити операцію з нульовою сума!');
        return false;
    }
    
	var dop_rec = "&RNK=" + document.getElementById("textRNK").value;
    
    /// Операція через касу
    if (cash == "1")
    {
        var currency = document.getElementById("KV").value;

        document.getElementById('btPay').disabled = 'disabled';

        // Для виплати золота з поточного рах. (Ощадбанк)
        if (currency == "959")
        {
            // Залишок на рахунку
            var dpt_saldo = Math.round(parseFloat(document.getElementById('textSUM').value) * denom);
            dop_rec += "&reqv_METAL=" + document.getElementById("METAL").value;
            dop_rec += "&reqv_RNK=" + document.getElementById("textRNK").value;
            // Різниця між залишком та сумою зняття
            var dpf = (dpt_saldo - sum);

            if ((dpf > 0) && confirm('Здійснити викуп залишку в сумі ' + (dpf / denom) + '? \nOk - повне зняття, Отмена - часткове зняття в набраних злитках.'))
                {
                DPF(dpf, currency, document.getElementById("DPT_ID").value, dop_rec);
                sum = dpt_saldo;
                }
         }
         else
         {  
            // викуп нерозмінного залишку валюти	  
            var dpf = ckDPF(currency, sum, denom);
            if (dpf > 0) 
            {
                dpf = Math.round(dpf);
                DPF(dpf, currency, document.getElementById("DPT_ID").value, dop_rec);
            }
         }


        url += "tt=" + document.getElementById("tt").value;
	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + currency;
	    url += "&Kv_B=" + currency;
	    url += "&SumC_t=" + sum;
	    url += "&nd=" + document.getElementById("DPT_ID").value;

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
	    url += "&nd=" + document.getElementById("DPT_ID").value;		
    }

	if (document.getElementById('rbMain').checked)
    {
	    url += "&BPROC=" + document.getElementById("before_pay").value;
	}

	url += dop_rec;
    url +="&code=" + Math.random();	

    window.showModalDialog(encodeURI(url), null, "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");
			
    DisableControls();
}
/// Перевірка на заповнення реквізитів сторони Б 
/// при безготівковому переказі з технічного рахунку
function CheckFillSideB()
{
    if (isEmpty(document.getElementById('textNMS_B').value))
    {
        alert('Заповніть ПІБ одержувача!');
        document.getElementById('textNMS_B').select();
        document.getElementById('textNMS_B').focus();
        return false;
    }
    if (isEmpty(document.getElementById('textOKPO_B').value))
    {
        alert("Заповніть ідентифікаційний код одержувача!");
        document.getElementById('textOKPO_B').select();
        document.getElementById('textOKPO_B').focus();        
        return false;
    }
    if (isEmpty(document.getElementById('textNLS_B').value))
    {
        alert("Заповніть номер рахунку одержувача!");
        document.getElementById('textNLS_B').select();
        document.getElementById('textNLS_B').focus();        
        return false;
    }                
    if (isEmpty(document.getElementById('textMFO_B').value))
    {
        alert("Заповніть МФО рахунку одержувача!");
        document.getElementById('textMFO_B').select();
        document.getElementById('textMFO_B').focus();        
        return false;
    }
//    if (isEmpty(document.getElementById('textNAZN').value))
//    {
//        alert("Заповніть призначення платежу!");
//        document.getElementById('textNAZN').select();
//        document.getElementById('textNAZN').focus();        
//        return false;
//    }
    return true;
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

////////////////////////////////
/// Для депозитного портфеля ///
////////////////////////////////
function InitFilter() {
    var tbl = document.getElementById('FILTER');
    if (isEmpty(document.getElementById('FILTER_POS').value)) {
        insFilterElem(tbl.rows.length, 'BRANCH', '', getFilterName('BRANCH'));
        insFilterElem(tbl.rows.length, 'ISP', '', getFilterName('ISP'));
        insFilterElem(tbl.rows.length, 'VIDD', '', getFilterName('VIDD'));
        insFilterElem(tbl.rows.length, 'CUR_CODE', '', getFilterName('CUR_CODE'));
        insFilterElem(tbl.rows.length, 'NBS', '', getFilterName('NBS'));
    }
    else {
        var pos_array = document.getElementById('FILTER_POS').value.split(';');
        var ord_array = document.getElementById('CLIENT_FILTER').value.split(';');
        for (var i = 0; i < pos_array.length; i++) {
            var pos = pos_array[i].indexOf('=');
            var ord = '';
            for (var j = 0; j < ord_array.length; j++) {
                var pos_j = ord_array[j].indexOf('=');
                if (ord_array[j].substring(0, pos_j) ==
    		        (pos_array[i].substring(0, pos) + '_ORD')) {
                    ord = ord_array[j].substring(pos_j + 1);
                    break;
                }
            }
            insFilterElem(pos_array[i].substring(pos + 1),
			    pos_array[i].substring(0, pos),
			    ord,
			    getFilterName(pos_array[i].substring(0, pos)));
        }
    }
}
function insFilterElem(pos, ID, sort, name) {
    var tbl = document.getElementById('FILTER');
    var row = tbl.insertRow(pos);
    row.id = ID;
    row.setAttribute('pos', pos);
    var cellLink = row.insertCell(0);
    cellLink.innerHTML = '<A href=# onclick="ReSort(' + "'" + ID + "'" + ')">+</a>';
    //cellLink.className = 'InfoText';
    cellLink.style.textAlign = 'center';
    var cellOrd = row.insertCell(1);
    cellOrd.id = ID + '_ORD';
    cellOrd.innerText = sort;
    //cellOrd.className = 'InfoText95';    
    var cellDesc = row.insertCell(2);
    cellDesc.innerText = name;
    cellDesc.className = 'InfoText95';
}
function ReSort(id) {
    var tbl = document.getElementById('FILTER');
    var obj = document.getElementById(id + '_ORD');
    /// !!! ТРЕБА проставляти цей атрибут pos при змінах
    /// Не приймав участь в сортуванні
    if (isEmpty(obj.innerText)) {
        var newSort = GetMaxFilter() + 1;
        CorrectFilterPos(document.getElementById(id).attributes['pos'].value, 'down');
        tbl.deleteRow(document.getElementById(id).attributes['pos'].value);
        /// Враховуємо один рядок шапки
        insFilterElem(5, id, newSort, getFilterName(id))
    }
    else {
        CorrectFilterOrder(parseFloat(obj.innerText));
        CorrectFilterPos(document.getElementById(id).attributes['pos'].value, 'up');
        // тому що вставка буде вище в таблиці
        tbl.deleteRow(parseFloat(document.getElementById(id).attributes['pos'].value));
        insFilterElem(1, id, '', getFilterName(id))
    }
}
function CorrectFilterOrder(delOrd) {
    var arr = new Array('BRANCH_ORD', 'ISP_ORD', 'VIDD_ORD', 'CUR_CODE_ORD', 'NBS_ORD');

    for (var i = 0; i < arr.length; i++) {
        var tmp = document.getElementById(arr[i]).innerText;
        if (parseFloat(tmp) > delOrd)
            document.getElementById(arr[i]).innerText = parseFloat(tmp) - 1;
    }
}
function CorrectFilterPos(delPos, up_down) {
    var arr = new Array('BRANCH', 'ISP', 'VIDD', 'CUR_CODE', 'NBS');

    for (var i = 0; i < arr.length; i++) {
        var tmp = document.getElementById(arr[i]).attributes['pos'].value;
        if (parseFloat(tmp) > delPos && up_down == 'down')
            document.getElementById(arr[i]).setAttribute('pos', parseFloat(tmp) - 1);
        else if (parseFloat(tmp) < delPos && up_down == 'up')
            document.getElementById(arr[i]).setAttribute('pos', parseFloat(tmp) + 1);
    }
}
function GetMaxFilter() {
    var arr = new Array('BRANCH_ORD', 'ISP_ORD', 'VIDD_ORD', 'CUR_CODE_ORD', 'NBS_ORD');
    var max = 0;

    for (var i = 0; i < arr.length; i++) {
        var tmp = document.getElementById(arr[i]).innerText;
        if (parseFloat(tmp) > max)
            max = parseFloat(tmp);
    }
    return max;
}
function getFilterName(id) {
    if (id == 'BRANCH') return 'Відділення';
    if (id == 'ISP') return 'Виконавець';
    if (id == 'VIDD') return 'Вид вкладу';
    if (id == 'CUR_CODE') return 'Валюта';
    if (id == 'NBS') return 'Бал.рахунок';
}
function GetFilter() {
    var arr = new Array('BRANCH_ORD', 'ISP_ORD', 'VIDD_ORD', 'CUR_CODE_ORD', 'NBS_ORD');
    var arr_pos = new Array('BRANCH', 'ISP', 'VIDD', 'CUR_CODE', 'NBS');
    var filter = '';
    var position = '';
    for (var i = 0; i < arr.length; i++) {
        var tmp = document.getElementById(arr[i]).innerText;
        if (!isEmpty(tmp))
            filter += arr[i] + '=' + tmp + ';';
    }
    /// якщо вибраний фільтр
    if (filter.length > 1) {
        filter = filter.substring(0, filter.length - 1);
    }
    var npos;
    var p1, p2, p3, p4, p5;
    for (var j = 0; j < arr_pos.length; j++) {
        npos = document.getElementById(arr_pos[j]).attributes['pos'].value;
        if (parseFloat(npos) == 1)
            p1 = arr_pos[j] + '=' + npos + ';';
        else if (parseFloat(npos) == 2)
            p2 = arr_pos[j] + '=' + npos + ';';
        else if (parseFloat(npos) == 3)
            p3 = arr_pos[j] + '=' + npos + ';';
        else if (parseFloat(npos) == 4)
            p4 = arr_pos[j] + '=' + npos + ';';
        else if (parseFloat(npos) == 5)
            p5 = arr_pos[j] + '=' + npos + ';';
    }
    position = p1 + p2 + p3 + p4 + p5;
    position = position.substring(0, position.length - 1);

    document.getElementById('CLIENT_FILTER').value = filter;
    document.getElementById('FILTER_POS').value = position;
}

// Вибір рахунка для виплати: відсотків (DEN) / вкладу (DEP)
function showAccounts(TIP) 
{
    var result = window.showModalDialog('dialog.aspx?type=metatab&role=ABS_ADMIN&tabname=ACCOUNTS' +
        '&tail="NBS in __bktOp__ __prime__2625__prime__,__prime__2620__prime__ __bktCl__ AND DAZS Is Null AND RNK=' + document.getElementById('RNK').value +
        ' AND KV = ' + document.getElementById('KV').value +
        ' AND EBP.check_virtual_bpk __bktOp__ ACC __bktCl__ = 0 "&pk=NLS&sk=NMS',
        'dialogHeight:700px; dialogWidth:700px');

    if (result != null) 
    {
        // Рахунок виплати відсотків
        if ((TIP = 'DEN') && (TIP = 'ALL'))
        {
            if (result[0] != null) document.getElementById('textBankAccount').value = result[0];
            if (result[1] != null) document.getElementById('textIntRcpName').value = result[1];

            document.getElementById('textBankMFO').value = document.getElementById('MFO').value;
            document.getElementById('textIntRcpOKPO').value = document.getElementById('OKPO').value;
            
            if (isEmpty(document.getElementById('textIntRcpName').value))
                document.getElementById('textIntRcpName').value = document.getElementById('NMK').value
        }

        // Рахунок виплати вкладу
        if ((TIP = 'DEP') && (TIP = 'ALL'))
        {
            if (result[0] != null) document.getElementById('textAccountNumber').value = result[0];
            if (result[1] != null) document.getElementById('textRestRcpName').value = result[1];

            document.getElementById('textRestRcpMFO').value = document.getElementById('MFO').value;
            document.getElementById('textRestRcpOKPO').value = document.getElementById('OKPO').value;

            if (isEmpty(document.getElementById('textRestRcpName').value))
                document.getElementById('textRestRcpName').value = document.getElementById('NMK').value
        }
    }
}

// Створення Додаткової Угоди (ДУ)
function AddAgreement() {
    var var_dpt_id = document.getElementById("dpt_id").value;
    location.replace("DepositSelectTrustee.aspx?dpt_id=" + var_dpt_id + "&dest=agreement");
}

//
function PadLeft(str, len)
{
    return PadLeft( str, len, " ");
}

//
function PadLeft(str, len, chr)
{
    if (str.length >= len)
    {
        return str.substr(0, len);
    }
    else
    {
        var out = str;

        while (out.length < len)
        {
            out = (out + chr);
        }
        
        return str;
    }    
}
//ф-ція перевірки підписаного договору
function check_sign()
{
	
	if (!document.getElementById('eadPrintContract_cbSigned').checked)
	{
	 if (confirm('Не проставлена відмітка про підписання договіру клієнтом, продовжити?'))    return false;
        	else                return true;
	}
	
}
