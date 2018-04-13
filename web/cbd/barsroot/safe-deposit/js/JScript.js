function Visit()
{
    var SAFE_ID = document.getElementById('SAFE_ID').value;
    var DPT_ID = document.getElementById('DPT_ID').value;
    var hSAFENUM = document.getElementById('hSAFENUM').value;
    
    /// Нічого не вибрали
    if (isEmpty(SAFE_ID))
    {
        alert('Выберите сейф!');
        return true;
    }    
    if (isEmpty(DPT_ID))
    {
        alert('По сейфу №' + hSAFENUM + ' нет активных договоров!');
        return true;
    }
    
    var url = "safevisit.aspx?SKRN_ND=" + DPT_ID;
    url +="&safe_id=" + SAFE_ID;
    location.replace(encodeURI(url));
    return true;    
}

function Attorney() {
    var SAFE_ID = document.getElementById('SAFE_ID').value;
    var DPT_ID = document.getElementById('DEAL_REF').value;
   // var hSAFENUM = document.getElementById('hSAFENUM').value;

    /// Нічого не вибрали
    if (isEmpty(SAFE_ID)) {
        alert('Выберите сейф!');
        return true;
    }
    if (isEmpty(DPT_ID)) {
        alert('По сейфу №' + hSAFENUM + ' нет активных договоров!');
        return true;
    }

    var url = "safeattorney.aspx?SKRN_ND=" + DPT_ID;
    url += "&safe_id=" + SAFE_ID;
    location.replace(encodeURI(url));
    return true;
}

function GetNewTemplate()
{
    var url = 'dialog.aspx?type=metatab&role=wr_metatab&tabname=DOC_SCHEME&tail="ID LIKE \'%SKRN%\'"';
    url +="&code=" + Math.random();
    
    var result = window.showModalDialog(url,"",
    "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");    
    
    if (result != null)    
    {
        document.getElementById('template').value = result[0];
        document.getElementById('insert').value = result[0];
        
        __doPostBack('','');
    }
    
    return true;
}
///
function ckSelected()
{
    var nd = document.getElementById('deal_id').value;
    var adds = document.getElementById('adds').value;
    var template = document.getElementById('template').value;
    
    if ( isEmpty(nd) || isEmpty(adds) || isEmpty(template) )
    {
        alert('Виберите документ!');
        return true;
    }
    
    return false;
}
///
function ShowDoc(ID,ND,ADDS)
{
    var url = "WebPrint.aspx?nd=" + ND;
    url += "&template=" + ID;
    url += "&adds=" + ADDS;
    url +="&close_window=1&trace=true&code=" + Math.random();
        
//	var result = window.showModalDialog(encodeURI(url), null,
//	"dialogWidth:100px; dialogHeight:100px; center:yes; status:no");    
    var top = window.screen.height/2 - 50;
    var left = window.screen.width/2 - 50;

	window.open(encodeURI(url),"_blank",
	"left=" + left + ",top=" + top + 
	",height=100px,width=100px,menubar=no,toolbar=no,location=no,titlebar=no");
}
///
function PrintDialog()
{
    var SAFE_ID = document.getElementById('SAFE_ID').value;
    var DPT_ID = document.getElementById('DPT_ID').value;
    var hSAFENUM = document.getElementById('hSAFENUM').value;
    
    /// Нічого не вибрали
    if (isEmpty(SAFE_ID))
    {
        alert('Выберите сейф!');
        return true;
    }    
    if (isEmpty(DPT_ID))
    {
        alert('По сейфу №' + hSAFENUM + ' нет активных договоров!');
        return true;
    }
    
    var url = "safedealprint.aspx?nd=" + DPT_ID;
    url +="&safe_id=" + SAFE_ID;
    location.replace(encodeURI(url));
    return true;    
}
///
function ShowArchive()
{
   location.replace('safeportfolio.aspx?type=arc'); 
}
///
function OpenSafeRef()
{
    var url = '../barsweb/references/refbook.aspx?tabid=918&mode=RW';
    location.replace(url);
}
/// Фінансова картка рахунку
function ShowDocCard(ref)
{
    var url = "/barsroot/documentview/default.aspx?ref="+ref;
    //url +="&code=" + Math.random();   

	var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:800px; dialogHeight:600px; center:yes; status:no");
}
///
function getDealId()
{
    var SAFE_ID = document.getElementById('SAFE_ID').value;
    var DPT_ID = document.getElementById('DPT_ID').value;
    var hSAFENUM = document.getElementById('hSAFENUM').value;   
    
    /// Нічого не вибрали
    if (isEmpty(SAFE_ID))
    {
        alert('Выберите сейф!');
        return true;
    }    
    if (isEmpty(DPT_ID))
    {
        alert('По сейфу №' + hSAFENUM + ' нет активных договоров!');
        return true;
    }
    
    var url = "safedealdocs.aspx?nd=" + DPT_ID;
    url +="&safe_id=" + SAFE_ID;
    location.replace(encodeURI(url));
    return true;
}
///
function validateParams()
{
    if (document.getElementById('DAT1'))
    {
        var DAT1 = document.getElementById('DAT1').value;
        if (isEmpty(DAT1))
        {
            alert('Необходимо ввести дату!');
            focusControl('DAT1');
            return true;
        }
    }
    if (document.getElementById('DAT2'))
    {
        var DAT2 = document.getElementById('DAT2').value;
        if (isEmpty(DAT2))
        {
            alert('Необходимо ввести дату!');
            focusControl('DAT2');
            return true;
        }
    }
    if (document.getElementById('NUMPAR'))
    {
        var NUMPAR = document.getElementById('NUMPAR').value;
        if (isEmpty(NUMPAR))
        {
            alert('Необходимо ввести реквизит!');
            focusControl('NUMPAR');
            return true;
        }
    }
    
    return false;
}
///
function ckClient()
{
    var SAFE_ID = document.getElementById('SAFE_ID').value;
    var DPT_ID = document.getElementById('DPT_ID').value;
    var FIO = document.getElementById('FIO').value;
    var hSAFENUM = document.getElementById('hSAFENUM').value;   
    
    /// Нічого не вибрали
    if (isEmpty(SAFE_ID))
    {
        alert('Выберите сейф!');
        return true;        
    }    
    if (isEmpty(DPT_ID))
    {
        alert('По сейфу №' + hSAFENUM + ' нет активных договоров!');
        return true;        
    }
    if (isEmpty(FIO))
    {
        alert('Не определен клиент - арендатор сейфа №' + hSAFENUM);
        return true;        
    }

    location.replace('safedocinput.aspx?safe_id=' + SAFE_ID + '&nd=' + DPT_ID);
    return true;
}
///
function ckField()
{
    var refs = document.getElementById('REF').value;
    if (isEmpty(refs))
    {
        alert('Заполните поле!');
        focusControl('REF');
        return true;
    }
    return false;
}
///
function getDealtoBindDoc()
{
    var SAFE_ID = document.getElementById('SAFE_ID').value;
    var DPT_ID = document.getElementById('DPT_ID').value;
    var hSAFENUM = document.getElementById('hSAFENUM').value;       
    
    /// Нічого не вибрали
    if (isEmpty(SAFE_ID))
    {
        alert('Выберите сейф!');
        return true;
    }    
    if (isEmpty(DPT_ID))
    {
        alert('По сейфу №' + hSAFENUM + ' нет активных договоров!');
        return true;
    }
    
    var url = "dialog/binddocuments.aspx?nd=" + DPT_ID;
    url +="&code=" + Math.random();
    
    window.showModalDialog(encodeURI(url),"",
    "dialogWidth:600px;dialogHeight:400px;center:yes;edge:sunken;help:no;status:no;scroll:no;");

    return true;
}
/// Відкрити додаткові реквізити
function openDopReqv()
{
    var deal_ref = document.getElementById('DEAL_REF').value;
    if (isEmpty(deal_ref))
    {
        alert('Сформируйте договор!');
        return true;
    }
    
    var url = "dialog/extraproperties.aspx?safe_id=";
    url += document.getElementById('SAFE_ID').value;
    url += "&deal_ref=" + deal_ref;
    url +="&code=" + Math.random();
    
    window.showModalDialog(encodeURI(url),"",
    "dialogWidth:600px;dialogHeight:400px;center:yes;edge:sunken;help:no;status:no;");    
    
    return true;    
}
/// Вибрати клієнта з довідника
function GetClientRnk()
{
    /// Якщо договір вже заключений - вибирати клієнта з довідника не можна
//    if (isNotEmpty(document.getElementById('DEAL_REF').value))
//        return true;
    
    var result = 
    window.showModalDialog(
    "dialog.aspx?type=metatab&tail='custtype in (2,3)'&role=wr_metatab&tabname=V_CUSTOMER", "",
    "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");    
    
    if (result != null)    
    {
        document.getElementById('RNK').value = result[0];
        __doPostBack('','');
    }
    
    return true;
}
/// Перевірка договора перед закриттям
function ckOSTC()
{
    var ostc = document.getElementById('OSTC').value;
    if (isEmpty(ostc)) return false;
    
    var dostc = parseFloat(ostc);
    if (dostc > 0)
    {
        alert('Закрытие невозможно! Сейф используется!');
        focusControl('OSTC');
        return true;
    }
    
    return false;
}
/// Авторозрахунок дати завершення (терміну) з введених даних
function CalcDate()
{
    var term = document.getElementById('TERM');
    var dat_end = document.getElementById('DAT_END');
    var dat_begin = document.getElementById('DAT_BEGIN');

    if (event.srcElement == term)    
    {   
        if (isEmpty(dat_begin.value) || isEmpty(term.value) || parseFloat(term.value) <= 0 )     
            return;
            
        var dateend = fnDateParse(dat_begin.value);
        dateend.setDate(dateend.getDate() + (term.value * 1) - 1);
        var strDatEnd = fnDateToString(dateend);
        window['DAT_END'].SetValue(strDatEnd);                            
        window['DAT_END'].Initialize();        
        document.getElementById('DAT_END').focus();
        
        //PageMethods.CkDate(fnDateParse(dat_end.value), OnSucceeded, OnFailed);	           
    }
    else if (event.srcElement == dat_end)    
    {
        if (isEmpty(dat_begin.value) ||isEmpty(dat_end.value) )     
            return;

        var one_day=1000*60*60*24;

        document.getElementById('TERM').value = 
            Math.ceil((fnDateParse(dat_end.value).getTime() - 
             fnDateParse(dat_begin.value).getTime() + 1)/(one_day));
             
        PageMethods.CkDate(fnDateParse(dat_end.value), OnSucceeded, OnFailed);	   
    }
    else if (event.srcElement == dat_begin)    
    {
        if (isEmpty(dat_begin.value) ||isEmpty(dat_end.value) )     
            return;

        var one_day=1000*60*60*24;

        document.getElementById('TERM').value = 
            Math.ceil((fnDateParse(dat_end.value).getTime() - 
             fnDateParse(dat_begin.value).getTime() + 1)/(one_day));    
    }
}
/// Дата - в dd/mm/yyyy
function fnDateToString(DAT)
{
    var nYear = DAT.getYear();
    var nMonth = DAT.getMonth() + 1;
    var nDay = DAT.getDate();
    
    if (('' + nDay).length == 1) nDay = '0' + nDay;
    if (('' + nMonth).length == 1) nMonth = '0' + nMonth;
    if (('' + nYear).length == 1) nYear = '000' + nYear;
    if (('' + nYear).length == 2) nYear = '00' + nYear;
    if (('' + nYear).length == 3) nYear = '0' + nYear;
    
    return (nDay + '/' + nMonth + '/' + nYear); 
}
// разбор строки в дату
function fnDateParse(sDate)
{
    var nYear = sDate.substring(6);
    var nMonth = sDate.substring(3, 5) - 1;
    var nDay = sDate.substring(0, 2);
    
    return new Date(nYear, nMonth, nDay);
}
/// Перевірка форми на заповнення перед збереженням
function FormNotFilled()
{
    var arr = new Array();
    arr[0] = 'DEAL_NUM';arr[1] = 'DAT_BEGIN';arr[2] = 'DEAL_DATE';arr[3] = 'TERM';
    arr[4] = 'DAT_END';arr[5] = 'FIO';arr[6] = 'OKPO';arr[7] = 'JOKPO';arr[8] = 'DOC';
    arr[9] = 'ISSUED'; arr[10] = 'NMK'; arr[11] = 'ADDRESS'; arr[12] = 'KEY_NUM';
    arr[14] = 'KEYS_COUNT';

  

    if (document.getElementById('CUSTTYPE').value == "2") {
        arr[15] = 'MFO';
        arr[16] = 'NLSK';
//        arr[17] = 'TRUSTEE_FIO';
//        arr[18] = 'TRUSTEE_OKPO';
//        arr[19] = 'TRUSTEE_DOC';
//        arr[20] = 'TRUSTEE_ISSUED';



//        var _div = document.getElementById('divTrustee');
//        _div.className = "mn";

    }
   


    for (var id in arr)
    {
        var elem = document.getElementById(arr[id]);
        if (elem != null)
        {
            if (isEmpty(elem.value))
            {
                alert('Заполните обязательное поле!');
                focusControl(arr[id]);
                return true;
            }
        }
    }
    
    return false;
}
/// Перевірка сейфу перед видаленням
function InvalidSafe()
{
    var SAFE_ID = document.getElementById('SAFE_ID').value;
    var DPT_ID = document.getElementById('DPT_ID').value;
    var hSAFENUM = document.getElementById('hSAFENUM').value;           
    
    /// Нічого не вибрали
    if (isEmpty(SAFE_ID))
    {
        alert('Выберите сейф!');
        return true;
    }    
    if (isNotEmpty(DPT_ID))
    {
        alert('По сейфу №' + hSAFENUM + ' существует активный договор №' + DPT_ID);
        return true;
    }
    return false;
}
/// Дістати номер рахунку за замовчуванням
function getNLS()
{
   var SAFE_ID = document.getElementById('SAFE_ID').value;
   if (isNotEmpty(SAFE_ID))
       PageMethods.GetNls(SAFE_ID, OnSucceeded, OnFailed);	
}
/// Перевірка на існування ід для скриньки
function ckSafeId()
{
   var SAFE_ID = document.getElementById('SAFE_ID').value;
   if (isNotEmpty(SAFE_ID))
       PageMethods.SafeIdExists(SAFE_ID, OnSucceeded, OnFailed);	
}
/// Створити новий депозитний сейф
function CreateSafe()
{
    var url = 'dialog/createsafe.aspx';
    url +="?code=" + Math.random();
        
    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:400px; dialogHeight:200px; center:yes; status:no");	    
//	window.open(encodeURI(url),"_blank","");
}
/// Сховати / показати довірену особу
function showTrustee() 
{
	var _div = document.getElementById('divTrustee');
	if (_div.className == "mo")
	{_div.className = "mn";
		
		document.getElementById('btShowTrustee').value = "-";
		document.getElementById('btShowTrustee').title = "Спрятать";
	}
	else if (_div.className == "mn")
	{
		_div.className = "mo";
		document.getElementById('btShowTrustee').value = "+";
		document.getElementById('btShowTrustee').title = "Показать";
	}
}
/// Фокусує на контролі
function focusControl(id)
{
	var control = document.getElementById(id);
	if (control.readonly || control.disabled) return;
	control.focus(); 
}
/// Вибір типу клієнта
function GetCustType()
{
    var custtype = document.getElementById('listCustType');

	window.returnValue = custtype.options[custtype.selectedIndex].value;
	window.close();    
}
/// Додати/редагувати довіреність на депозитну скриньку
function AddAttorney(par) {
    var DPT_ID = document.getElementById('DPT_ID').value;
    var RNK = document.getElementById('RNK').value;

    /// Нічого не вибрали
    if (isEmpty(DPT_ID)) {
        alert('Выберите договір!');
        return false;
    }
    if (isEmpty(RNK) & par=='edit') {
        alert('Выберите довіреність для редагування!');
        return false;
    }

    var url;
    var custtype;
    /// Створити новий 
            url = 'dialog/safe_openattorney.aspx?dpt_id=' + DPT_ID;
    /// якщо видрали довіренысть для редагування 
            if (!isEmpty(RNK) & par == 'edit')
            {
                url += "&rnk=" + RNK;
            }
            url += "&mode=" + par;
            url += "&code=" + Math.random();
            custtype = window.showModalDialog(encodeURI(url), null,




	        "dialogWidth:600px; dialogHeight:400px; center:yes; status:no");
    return false;

}

/// Відкрити (Створити) депозитну скриньку
/// 1 - індивідуальні рахунки майбутніх прибутків
function OpenSafeEx(ind_acc)
{
    var SAFE_ID = document.getElementById('SAFE_ID').value;
    var DPT_ID = document.getElementById('DPT_ID').value;
    var hSAFENUM = document.getElementById('hSAFENUM').value;               
    
    /// Нічого не вибрали
    if (isEmpty(SAFE_ID))
    {
        alert('Выберите сейф!');
        return false;
    }
    
    var url;
    var custtype;
    /// Створити новий договір
    if (isEmpty(DPT_ID))
    {
        if (isEmpty(ind_acc))
        {
            url = 'dialog/custtype.aspx';
            custtype = window.showModalDialog(encodeURI(url),null,
	        "dialogWidth:300px; dialogHeight:150px; center:yes; status:no");	            
        }
        else
        {
            url = 'dialog/safe_opendeal.aspx?safe_id=' + SAFE_ID;
            url +="&code=" + Math.random();            
            custtype = window.showModalDialog(encodeURI(url),null,
	        "dialogWidth:600px; dialogHeight:400px; center:yes; status:no");	            
        }

        if (isEmpty(ind_acc))
        {	    
	        if (custtype == 2 || custtype == 3)
	        {
	            url = 'safedeposit.aspx?';
                url += 'safe_id=' + SAFE_ID;
                url += '&custtype=' + custtype;
                location.replace(encodeURI(url));
	        }
	        else
	        {
	            alert('Выберите тип клиента!');
                return false;	        
	        }
	    }
	    else
	    {
            if (custtype == null || custtype[0] == null || custtype[1] == null)
            {
                return false;
            }

            url = 'safedeposit.aspx?';
            url += 'safe_id=' + SAFE_ID;
            url += '&custtype=' + custtype[1];
            url += '&deal_id=' + custtype[0];
            
            if (custtype[2] != null)
                url += '&rnk=' + custtype[2];
            
            location.replace(encodeURI(url));
	    }
    }
    /// Відкрити поточний
    else
    {
        url = 'safedeposit.aspx?';
        url += 'safe_id=' + SAFE_ID;
        url += '&dpt_id=' + DPT_ID;
        location.replace(encodeURI(url));
    }
    return false;
    
}
/// Відкрити (Створити) депозитну скриньку
function OpenSafe()
{
    OpenSafeEx();
}
/// Чи є порожнім значенням
function isNotEmpty(val)
{
	if (val == null || val == ' ' || val == 'null' || val == '' || val == '&nbsp' || val == '&nbsp;' || val == '01/01/0001') 
	    return false;
	return true;
}
/// Чи є порожнім значенням
function isEmpty(val)
{
	return !isNotEmpty(val);
}
// Callback function invoked on successful 
// completion of the page method.
function OnSucceeded(result, userContext, methodName) 
{    
    if (methodName == 'GetNls')
    {
        if (isEmpty(document.getElementById('NLS').value))
            document.getElementById('NLS').value = result;
    }
    else if (methodName == 'SafeIdExists')
    {  
        if (result == 1)
        {        
           alert('Сейф с указаным номером уже существует!');
           focusControl('SAFE_ID');
        }
        else   
           getNLS();
    }
    else if (methodName == 'CkDate')
    {
        if (isEmpty(result)) return;
        
        var dat_end_string = document.getElementById('datEndString').value;
        var dat_end = document.getElementById(dat_end_string);
        
        if ( fnDateParse(result) > fnDateParse(dat_end.value) )
            if (confirm ('Дата окончания договора выпала на выходной день, установить дату окончания на следующий рабочий день (' + result + ')?')  ) {
                var strDatEnd = result;
                window[dat_end_string].SetValue(strDatEnd);
                window[dat_end_string].Initialize();
                
                                       
            }         
    }
}
// Callback function invoked on failure 
// of the page method.
function OnFailed(error, userContext, methodName) 
{   
    if(error !== null) 
    {
        window.showModalDialog("dialog.aspx?type=err","",
        "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");    
    }
}

/// Вибрати клієнта з довідника
function GetClient()
{
    var result = 
    window.showModalDialog(
    "dialog.aspx?type=metatab&tail='custtype=" + 
    document.getElementById("ddClientType").item(document.getElementById("ddClientType").selectedIndex).value
     + "'&role=wr_metatab&tabname=V_CUSTOMER","",
    "dialogWidth:600px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");    
    
    if (result != null)    
    {
        document.getElementById('RNK').value = result[0];
        document.getElementById('RNK_').value = result[0];
        document.getElementById('FIO').value = result[1];
    }
    
    return true;
}
function ckDate()
{
    var dat_end = document.getElementById('DAT2');
    PageMethods.CkDate(fnDateParse(dat_end.value), OnSucceeded, OnFailed);
}