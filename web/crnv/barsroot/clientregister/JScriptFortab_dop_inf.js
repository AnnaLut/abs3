// цвет клиента(категория риска)
function SetClientColor(colidx)
{
	var col = "white";
	if(colidx == 1) col = "lime";
	else if(colidx == 2) col = "green";
	else if(colidx == 3) col = "yellow";
	else if(colidx == 4) col = "maroon";
	else if(colidx == 5) col = "red";
	
	getEl('ed_CRISK').style.backgroundColor = col;
}			
// Принадлежность малому бизнесу
function SetMB()
{
	getEl('ed_MB').value = getEl('ddl_MB').item(getEl('ddl_MB').selectedIndex).value;
}
// служебные функция JavaScript
//первичное заполнение объектов
function InitObjects()
{
	//вставляем значения
	if(parent.obj_Parameters['EditType'] != "Reg")
	{
		getEl('ed_ISP').value = parent.obj_Parameters['ISP'];
		getEl('ed_NOTES').value = parent.obj_Parameters['NOTES'];
		getEl('ed_ADR_ALT').value = parent.obj_Parameters['ADR_ALT'];
		getEl('ed_NOM_DOG').value = parent.obj_Parameters['NOM_DOG'];
		getEl('ed_LIM_KASS').value = parent.obj_Parameters['LIM_KASS'];
		getEl('ed_LIM').value = parent.obj_Parameters['LIM'];
		getEl('ed_NOMPDV').value = parent.obj_Parameters['NOMPDV'];
		getEl('ed_RNKP').value = parent.obj_Parameters['RNKP'];
		getEl('ed_NOTESEC').value = parent.obj_Parameters['NOTESEC'];

		if(trim(parent.obj_Parameters['CRISK']).length != 0)
		{
			getEl('ddl_CRISK').selectedIndex = FindByVal(getEl('ddl_CRISK'),parent.obj_Parameters['CRISK']);
			SetClientColor(parent.obj_Parameters['CRISK']);
		}
		if(trim(parent.obj_Parameters['MB']).length != 0)
		{
			getEl('ddl_MB').selectedIndex = FindByVal(getEl('ddl_MB'),parent.obj_Parameters['MB']);
			SetMB();
		}
		DisableAll(document, parent.obj_Parameters['ReadOnly']);		
	}				
	
    HideProgress();
}			

