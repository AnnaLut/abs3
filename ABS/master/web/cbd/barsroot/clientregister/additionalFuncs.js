// аналог trim
function trim(a)
{
	if(a == null) return null;
	return a.toString().replace(/^\s*|\s*$/g,'');
}
// проверка правильности даты
function isDate(fld)
{
	var mo, day, yr;
	var entry = fld.value;
	if(entry == null) entry = fld;
	var re = /\b\d{1,2}\.\d{1,2}\.\d{4}\b/;
	
	if(re.test(entry))
	{
		var delimChar = '.';
		var delim1 = entry.indexOf(delimChar);
		var delim2 = entry.lastIndexOf(delimChar);
		
		day = parseInt(entry.substring(0, delim1), 10);
		mo = parseInt(entry.substring(delim1+1, delim2), 10);
		yr = parseInt(entry.substring(delim2+1), 10);
		
		var testDate = new Date(yr, mo-1, day);

		if(testDate.getDate() == day)
		{
			if(testDate.getMonth() + 1 == mo)
			{
				if(testDate.getFullYear() == yr)
				{
					return true;					
				}
				else
				{
					alert(LocalizedString('Mes13')/*'Дата введена с ошибкой.'*/);			
				}
			}
			else
			{
				alert(LocalizedString('Mes14')/*'Месяц записан с ошибкой.'*/);			
			}
		}
		else
		{
			alert(LocalizedString('Mes15')/*'Число указано с ошибкой.'*/);			
		}
	}	
	else
	{
		alert(LocalizedString('Mes16')/*'Неправильный формат даты. Используйте формат dd.MM.yyyy'*/);
	}
	return false;
}
function isDateCheck(edit)
{
	if(trim(edit.value) != '' && !isDate(edit))
	{
		edit.focus();
		edit.select();
	}
}
// проверка правильности числа
function isNumber(a)
{
	var flag = false;
		
	var re = RegExp('\\d*');
	a = a.replace(re,'');
	
	if(trim(a.replace('.','').replace(',','').replace('-','')) == '') flag = true;
				
	if(a.charAt(a.length-1) == '.' || a.charAt(a.length-1) == ',') flag = false;
	if(a.charAt(0) == '.' || a.charAt(0) == ',') flag = false;
	if(a.replace('-','') != a)
	{
		if(a.indexOf('-') != 0) flag = false;
	}
				
	return flag;
}
//реакция если введено не число в числовое поле
function isNumberCheck(edit)
{
	if(!isNumber(edit.value))
	{
		alert(LocalizedString('Mes17')/*'Введите число'*/);
		edit.focus();
	}
}
//реакция если введено пустое значение в эдит
function isEmpty(edit) {
  return (edit == null || edit.value == null || trim(edit.value).length == 0);
}
function isEmptyCheck(edit)
{
	if(isEmpty(edit))
	{
		alert('Не заповнено обов`язкове поле');	
		edit.focus();
	}
}
//задизейблить все сразу
function DisableAll(elem, flag)
{
	var boolFlag = ((flag == 'true')?(true):(false));
	var myTags = new Array('input','table','select','img');
	
	if(boolFlag)
	{
		for(i=0; i<myTags.length; i++)
		{
			var tmp = document.getElementsByTagName(myTags[i]);
			for(j=0; j<tmp.length; j++)
				if(tmp[j].disabled != null) tmp[j].disabled = boolFlag;
		}
	}
}

function DisableAllImg(elem, flag) {
    var boolFlag = ((flag == 'true') ? (true) : (false));
    var myTags = new Array('input', 'select');

    if (boolFlag) {
        for (i = 0; i < myTags.length; i++) {
            var tmp = document.getElementsByTagName(myTags[i]);
            for (j = 0; j < tmp.length; j++)
                if (tmp[j].type && tmp[j].type == "image") {
                    tmp[j].style.visibility = "hidden";
                }
        }
    }
}


//поиск индекса в ДДЛ по заданому значению
function FindByVal(ddl, val)
{				
	for(i=0; i<ddl.options.length; i++)
	{
		if(ddl.item(i).value == val)
		{
			return i;
		}
	}
	return 0;
}			
// возвращает елемент
function getEl(elName)
{
	return (document.getElementById(elName));
}
//достаем элемент из фрейма
function gE(curFrm, elName)
{	
  if (curFrm != null && curFrm.document) return (curFrm.document.getElementById(elName));
	else return null;
}
//вставляет значение в эдит
function PutIntoEdit(edit, val)
{
	var myVal = String();
	myVal = val;
	if(myVal != null && myVal != "undifined" && myVal != "")
	{
		edit.value = myVal;
	}
}
//отслеживаем изменения
function ToDoOnChange(flag) {
  if (parent.location.href.toLowerCase().indexOf("readonly=1") < 0) {
    parent.document.getElementById('bt_reg').disabled = false;
  }
  //document.getElementById('').change += function() { ChangeMobilePhone(); };
}
function ControlsOnChange()
{
	var tags = new Array('INPUT','SELECT');
	for(i=0;i<tags.length;i++)
	{
		var tmp = document.getElementsByTagName(tags[i]);
		for(j=0;j<tmp.length;j++)
		{
			if(tmp[j].onchange != null && tmp[j].onchange != '')
				tmp[j].onchange += ToDoOnChange;
			else tmp[j].onchange = ToDoOnChange;			
			alert(tmp[j].id + ' : ' + tmp[j].onchange);
		}
	}
}			
function GetWebServiceData(strFuncName, arrPars, bParent)
{
	//проверяем не занят ли сервис
	var result; 
	if (bParent == 0)
	{
		callObj.funcName = strFuncName;
		callObj.params = arrPars;
	    result = document.getElementById("webService").WebService.callService(callObj);
	}
	else 
	{
		parent.callObj.funcName = strFuncName;
		parent.callObj.params = arrPars;
	    result = parent.document.getElementById("webService").WebService.callService(parent.callObj);
	}
				
	if (result.error) 
	{
        if(window.dialogArguments)
        {
            window.showModalDialog("dialog.aspx?type=err","","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        } 
        else
            location.replace("dialog.aspx?type=err");
        
        return false;
	} 
	else
	{	
		return result.value;
	}
}
function ShowProgress() {
  var top = document.documentElement.clientHeight / 2 - 15;
  var left = document.body.offsetWidth / 2 - 50;
  var sImg = '<div style="position: absolute; top:' + top + 'px; background:white; left:' + left + 'px; width:101px; height:33px;" ></div>';
  oImg = document.createElement(sImg);
  oImg.innerHTML = '<img src=/Common/Images/process.gif>';

  document.body.insertAdjacentElement("beforeEnd", oImg);
}
function HideProgress() {
  parent.curTabCount++;

  if (parent.curTabCount == 4)
    parent.document.body.removeChild(parent.oImg);
}
