/// Вичитуємо з урл параметр
/// якщо його нема - повертаємо на 
/// сторінку по замовчуванню
function searchURLforREF(par1)
{
    var res,success = 0;
		
	var url = decodeURI(location.href);
	var data = url.split('?');
	var params = data[1];
	if (params == null && params == '' && params == "") 
	    {
	        BarsAlert("Помилка","Невірно вказані параметри!",1,0);
	        location.replace('Default.aspx');
	    }
	var par = params.split('&');
	
	for(var i=0; i<par.length; i++)
	{
		var pos = par[i].indexOf('=');
		if (par[i].substring(0,pos) == par1) //"ref"
		{
			res	= par[i].substring(pos+1);
		    success = 1;
		}
	}		
	if (success != 1)
	{
	    BarsAlert("Помилка","Невірно вказані параметри!",1,0);
	    location.replace('Default.aspx');
	    return null;
	}

	return res;
}

/// Перехоплення помилок
function getError(result)
{
	if(result.error){
	   window.showModalDialog("dialog.aspx?type=err&code=" + Math.random(),null,
	   "dialogWidth:700px; dialogHeight:500px; center:yes; status:no");	
		return false;
	}
	return true;
}
///
function ShowMetaTable()
{
    var url = encodeURI("dialog.aspx?type=metatab&tail=''&role=start1&tabname=branch");
    var result = window.showModalDialog(url,"",
      "dialogWidth:650px;dialogHeight:700px;center:yes;edge:sunken;help:no;status:no;");

    if (result != null)
    {
        window.document.getElementById('listBranch').options[0].value = result[0];
        window.document.getElementById('listBranch').options[0].text = result[1];
    }
}
function CheckControls()
{    
    if (IsEmptyText('DptNum'))   
    {BarsAlert("Помилка","Заповніть будь-ласка номер депозиту!",1,0);FocusElem('DptNum');return false;}
    if (IsEmptyText('FirstName'))   
    {BarsAlert("Помилка","Заповніть будь-ласка ім\'я!",1,0);FocusElem('FirstName');return false;}
    if (IsEmptyText('Patronimic'))   
    {BarsAlert("Помилка","Заповніть будь-ласка по-батькові!",1,0);FocusElem('Patronimic');return false;}
    if (IsEmptyText('LastName'))   
    {BarsAlert("Помилка","Заповніть будь-ласка прізвище!",1,0);FocusElem('LastName');return false;}
    if (IsEmptyText('OKPO'))   
    {BarsAlert("Помилка","Заповніть будь-ласка ідентифікаційний код!",1,0);FocusElem('OKPO');return false;}
    if (IsEmptyText('DocSerial'))   
    {BarsAlert("Помилка","Заповніть будь-ласка серію паспорта!",1,0);FocusElem('DocSerial');return false;}
    if (IsEmptyText('DocNumber'))   
    {BarsAlert("Помилка","Заповніть будь-ласка номер паспорта!",1,0);FocusElem('DocNumber');return false;}        
    
    return true;
}
function IsEmptyText(el_id)
{
    var txt = window.document.getElementById(el_id).value;
    return (txt==null || txt=='' || txt == "");
}
function FocusElem(el_id)
{
    var elem = window.document.getElementById(el_id);
    elem.focus();elem.select();
}
// Перевірка правильності формату номера паспорта
function ckNumber()
{
	var val = window.document.getElementById("DocNumber").value;
	if (noCheck == 2) return;
	    
	noCheck = 0;
		
	var rexp = new RegExp(/\d{6}/);
	if(0==val.length) return;
	if (!rexp.test(val) || val.length > 6)
	{
	    BarsAlert("Помилка","Невірний формат номера паспорта!",1,0);
		noCheck = 1;		
		window.document.getElementById("DocNumber").focus();			
		window.document.getElementById("DocNumber").select();
	}
}
// Перевірка правильності формату серії паспорту
function ckSerial()
{
	var val = document.getElementById("DocSerial").value;
	if (noCheck == 1)return;
	
	noCheck = 0;

	var rexp = new RegExp(/[A-Z]{2}/);
	if(0==val.length) return;
	if (!rexp.test(val) || val.length > 2)
	{
	    noCheck = 2;
	    BarsAlert("Помилка","Невірний формат серії паспорта!",1,0);
		window.document.getElementById("DocSerial").focus();	
		window.document.getElementById("DocSerial").select();
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

IE4 = document.all;

/// BarsAlert(title,message,icon,modality)
/// BarsAlert("DHTML Lab","No confusing captions",4,0)
function BarsAlert(title,mess,icon,mods) {
   (IE4) ? makeMsgBox(title,mess,icon,0,0,mods) : alert(mess);
}

/// BarsConfirm(title,message,icon,default button,modality)
/// BarsConfirm("DHTML Lab Confirmation Request","Are you confused yet?",1,1,0)
/// icon: 0 - no icon, else - question icon
/// default button: 0 - first; 1 - second
function BarsConfirm(title,mess,icon,defbut,mods) {
   if (IE4) {
      icon = (icon==0) ? 0 : 2;
      defbut = (defbut==0) ? 0 : 1;
      retVal = makeMsgBox(title,mess,icon,4,defbut,mods);
      retVal = (retVal==6);
   }
   else {
      retVal = confirm(mess);
   }
   return retVal;
}

/// BarsPrompt(title,message,default response)
/// BarsPrompt("DHTML Lab User Input Request","Enter your name, please:","Ishmael")
function BarsPrompt(title,mess,def) {
   retVal = (IE4) ? makeInputBox(title,mess,def) : prompt(mess,def);
   return retVal;
}
/// BarsIEBox(title,message,icon,button group,default button,modality)
/// BarsIEBox("DHTML Lab Explorer Dialog","All options enabled",1,2,2,1)
function BarsIEBox(title,mess,icon,buts,defbut,mods) {
   retVal = (IE4) ? makeMsgBox(title,mess,icon,buts,defbut,mods) : null;
   return retVal;
}
