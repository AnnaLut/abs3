var tmpStringValue;


// сокращение пробелов по краям
function trim(a)
{
	if(a == null) return null;
	return a.replace(/^\s*|\s*$/g,"");
}
// проверка правильности числа
function isNumber(a)
{
	var flag = false;
	var re = RegExp("\\d*");
				
	if(a.replace(".","").replace(",","").replace("-","").replace(re,"") == "") flag = true;
		
	if(a.charAt(0) == "." || a.charAt(0) == ",") flag = false;
	if(a.replace("-","") != a)
	{
		if(a.indexOf("-") != 0) flag = false;
	}
	
		
	return flag;
}
//=========================отработка событий=================

function BarsWeb_Controls_NumericDataInput_KeyDown(control, evt)
{
	if(evt.keyCode>=65 && evt.keyCode<=90)
	{
		evt.returnValue = false;
	}
	else
	{
		tmpStringValue = control.value;
	}
}
function BarsWeb_Controls_NumericDataInput_KeyUp(control, evt)
{
	if(!(evt.keyCode>=65 && evt.keyCode<=90))
	{
		if(!isNumber(control.value)) control.value = tmpStringValue;
	}
}

