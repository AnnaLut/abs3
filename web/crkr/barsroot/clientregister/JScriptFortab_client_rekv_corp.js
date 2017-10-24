// служебные функция JavaScript
//первичное заполнение объектов
function InitObjects()
{
	locked = false;
	
	//вставляем значения
	if(parent.obj_Parameters['EditType'] != "Reg")
	{
		getEl('ed_NMKU').value = parent.obj_Parameters['NMKU'];
		getEl('ed_RUK').value = parent.obj_Parameters['RUK'];
		getEl('ed_BUH').value = parent.obj_Parameters['BUH'];
		getEl('ed_TELR').value = parent.obj_Parameters['TELR'];
		getEl('ed_TELB').value = parent.obj_Parameters['TELB'];
		getEl('ed_E_MAIL').value = parent.obj_Parameters['E_MAIL'];
		getEl('ed_TEL_FAX').value = parent.obj_Parameters['TEL_FAX'];
		
		getEl('ed_SEAL_ID').value = parent.obj_Parameters['SEAL_ID'];
		ChangePictureFile();
	}	
	DisableAll(document, parent.obj_Parameters['ReadOnly']);			
		
    HideProgress();
}			
//поиск поиск наименования банка
function GetMfoCom(val)
{		
	var input = new Array();
	var output = new Array();

	input.val = trim(val.value);

	output = GetWebServiceData('GetMfoCom', input, 1);
	
	val.title = output;						
}

function MyBeforeCellChange(gn, id)
{
	ToDoOnChange();
}
function MyBeforeEnterEditMode(gn, id)
{
	var row = igtbl_getRowById(id);
	var col = id.slice(id.lastIndexOf('_')+1);
	var cell = row.getCell(col);
	var colKey = cell.Column.Key;
	var docs = Array('MFO', 'KV', 'NAME', 'COUNTRY');
	var docsTabs = Array('BANKS', 'TABVAL', 'CUSTOMER_ADDRESS_TYPE', 'COUNTRY');
	var docsTails = Array('', '', 'ID not in (1)', '');

	for(i=0; i<docs.length; i++)
		if(colKey == docs[i]) 
			{
				var result = window.showModalDialog('dialog.aspx?type=metatab&tabname='+docsTabs[i]+'&tail=\''+escape(docsTails[i])+'\'&role=WR_CUSTREG',window, 'dialogHeight:600px; dialogWidth:600px');
				if(result != null)
				{
					// id типа адреса				
					if(colKey == 'NAME')
					{
						row.getCell(col-1).setValue(result[0]);
						cell.setValue(result[1]);												
					}
					else
					{
						cell.setValue(result[0]);
					}
				}
			}
}
function MyAddRow(grdName)
{
	igtbl_addNew(grdName,0);
}
function MyDeleteRow(grdName)
{
	igtbl_deleteSelRows(grdName);
}
//-- показываем спилсок доступных файлов в базе
function ShowSealHelp()
{
	var result = window.showModalDialog('LoadFile.aspx?rand=' + Math.random(),window, 'dialogHeight:600px; dialogWidth:800px');
	if(result != null)
	{
		document.getElementById('ed_SEAL_ID').value = result;
		ChangePictureFile();
		ToDoOnChange();
	}
}
//-- показываем файл который соответствует записи в полет Ид. Граф...
function ChangePictureFile()
{
	var id = trim(document.getElementById('ed_SEAL_ID').value);
	document.getElementById('img_picture').src = 'pictureFile.aspx?id=' + id;
}
