function InitObjects()
{
    HideProgress();
}
function MyBeforeCellChange(gn, id)
{
	ToDoOnChange();
}
function MyBeforeCellUpdate(gn, id, newValue)
{
	var row = igtbl_getRowById(id);
	var col = id.slice(id.lastIndexOf('_')+1);
	var cell = row.getCell(col);
	var colKey = cell.Column.Key;
	
	var checkType;
	var idx = 0;

	//-- даты
	var dates = Array('BDATE','EDATE','TRUST_REGDAT','DOC_DATE','BIRTHDAY');
	//-- маски
	var masks = Array('SIGN_PRIVS');
	var masksExpr = Array(/0|1/);
	var masksAlert = Array('0 - нет, 1 - есть право подписи!');

	for(i=0; i<dates.length; i++)
		if(colKey == dates[i]) 
		{
			checkType = 'date';
			idx = i;
		}
	for(i=0; i<masks.length; i++)
		if(colKey == masks[i]) 
		{
			checkType = 'mask';
			idx = i;
		}
	
	if(trim(newValue) != '')
	{
		switch (checkType)
		{
			case 'date' :
				if(!isDate(newValue))
				{
					alert(LocalizedString('Mes09')/*'Введите дату(прим. 22.11.1984)'*/);
					return true;
				}
				break
			case 'mask' :
				if(trim(newValue).length > 1 || !masksExpr[idx].test(trim(newValue).substring(0, 1)))
				{
					alert(masksAlert[idx]);
					return true;
				}
				break
				
			default : return false;
		}
	}
	
	return false;
}
function MyBeforeEnterEditMode(gn, id)
{
	var row = igtbl_getRowById(id);
	var col = id.slice(id.lastIndexOf('_')+1);
	var cell = row.getCell(col);
	var colKey = cell.Column.Key;
	var docs = Array('PASPORT', 'NAME', 'NAME_DOC', 'SEX', 'SIGN_ID');
	var docsTabs = Array('PASSP', 'TRUSTEE_TYPE', 'TRUSTEE_DOCUMENT_TYPE', 'SEX', '');
	var docsTails = Array('', '', '', '', '');

	switch(colKey)
	{
		case 'PASPORT' :					
		{
			var result = window.showModalDialog('dialog.aspx?type=metatab&tabname='+docsTabs[0]+'&tail=\''+escape(docsTails[0])+'\'&role=WR_CUSTREG',window, 'dialogHeight:600px; dialogWidth:600px');
			if (result != null) 
			{
			    row.getCell(col-1).setValue(result[0]);		
			    cell.setValue(result[1]);
			}
		}
			break;
		case 'NAME' :
		{
			var result = window.showModalDialog('dialog.aspx?type=metatab&tabname='+docsTabs[1]+'&tail=\''+escape(docsTails[1])+'\'&role=WR_CUSTREG',window, 'dialogHeight:600px; dialogWidth:600px');
			if (result != null) 
			{
			    row.getCell(col-1).setValue(result[0]);		
			    cell.setValue(result[1]);
			}
		}
			break;
		case 'NAME_DOC' :
		{
			var result = window.showModalDialog('dialog.aspx?type=metatab&tabname='+docsTabs[2]+'&tail=\''+escape(docsTails[2])+'\'&role=WR_CUSTREG',window, 'dialogHeight:600px; dialogWidth:600px');
			if (result != null) 
			{
			    row.getCell(col-1).setValue(result[0]);		
			    cell.setValue(result[1]);
			}
		}
			break;
		case 'SEX' :
		{
			var result = window.showModalDialog('dialog.aspx?type=metatab&tabname='+docsTabs[3]+'&tail=\''+escape(docsTails[3])+'\'&role=WR_CUSTREG',window, 'dialogHeight:600px; dialogWidth:600px');
			if (result != null) 
			{
			    row.getCell(col-1).setValue(result[0]);		
			    cell.setValue(result[1]);
			}
		}
			break;
		case 'SIGN_ID' :
		{
			var result = window.showModalDialog('LoadFile.aspx?rand=' + Math.random(),window, 'dialogHeight:600px; dialogWidth:800px');
			if (result != null) cell.setValue(result);
		}
			break;			
	}				
}
function MyAddRow()
{
	igtbl_addNew("GridMain",0);
}
function MyDeleteRow()
{
	igtbl_deleteSelRows("GridMain");
}