// служебные функция JavaScript
//первичное заполнение объектов
function InitObjects()
{
	//сервис готов
	locked  = false;
	
	//вставляем значения
	if(parent.obj_Parameters['EditType'] != "Reg")
	{
		getEl('ed_RATING').value = parent.obj_Parameters['RATING'];
		if(trim(parent.obj_Parameters['MFO']).length != 0)
		{
			getEl('ed_MFO').value = parent.obj_Parameters['MFO'];
			GetMfoCom(trim(parent.obj_Parameters['MFO']));										
		}				
		getEl('ed_ALT_BIC').value = parent.obj_Parameters['ALT_BIC'];
		getEl('ed_BIC').value = parent.obj_Parameters['BIC'];
		getEl('ed_KOD_B').value = parent.obj_Parameters['KOD_B'];
		getEl('ed_RUK').value = parent.obj_Parameters['RUK'];
		getEl('ed_BUH').value = parent.obj_Parameters['BUH'];
		getEl('ed_TELR').value = parent.obj_Parameters['TELR'];
		getEl('ed_TELB').value = parent.obj_Parameters['TELB'];
	}
	//нерезиденты банки не заполняют следущие поля
	var MainRekvTab = parent.document.frames['Tab0'];
	if(MainRekvTab != null)
		if(gE(MainRekvTab,'ddl_CODCAGENT').selectedIndex != -1)
		{	
			var tmp = gE(MainRekvTab,'ddl_CODCAGENT').item(gE(MainRekvTab,'ddl_CODCAGENT').selectedIndex).value.substr(0,1);
			if(tmp == '1')
			{
				if(parent.obj_Parameters['ReadOnly'] != 'true')
				{
					getEl('ed_MFO').disabled = false;
					getEl('lb_1').disabled = false;
					getEl('ed_KOD_B').disabled = false;
				}
			}
			else
			{
				getEl('ed_MFO').disabled = true;
				getEl('lb_1').disabled = true;
				getEl('ed_KOD_B').disabled = true;
			}
		}
		
    HideProgress();
}			
//поиск поиск наименования банка
function GetMfoCom(val)
{		
	var input = new Array();
	var output = new Array();

	input.val = val;

	output = GetWebServiceData('GetMfoCom', input, 1);
	
	lb_title_bank.innerText = output;						
}

