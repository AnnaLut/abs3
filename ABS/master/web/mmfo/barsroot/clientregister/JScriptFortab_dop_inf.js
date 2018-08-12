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
    if (parent.obj_Parameters['EditType'] != "Reg" || parent.isRegisterByScb())
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

    $(function () {
        // init для ІПН (COBUMMFO-7835)
        var ctrl_NOMPDV = $('#ed_NOMPDV');

        if (parent.obj_Parameters['CUSTTYPE'] === 'person') {
            ctrl_NOMPDV.numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
            ctrl_NOMPDV.attr('maxlength', '10');
        }
        else
            ctrl_NOMPDV.numberMask({ beforePoint: 12, pattern: /^[0-9]*$/ });

        ctrl_NOMPDV.focus(function () {
            var val_OKPO = parent.valOKPO;
            if (parent.obj_Parameters['CUSTTYPE'] === 'person') {
                if (this.value.length === 0) {
                    this.value = val_OKPO;
                    ToDoOnChange();
                }
            }
            else {
                if (this.value.length === 0 && val_OKPO.length > 0) {
                    this.value = val_OKPO.slice(0, 7);
                    ToDoOnChange();
                }
            }
        });
        // перевірки для ІПН (COBUMMFO-7835)
        ctrl_NOMPDV.blur(function () {
            if (this.value.length > 0) {
                var reg = /^[0-9]*$/;//маска для вылідації цифр
                if (!reg.test(this.value)) {
                    alert('Ідн. податковий номер містить недопустимі символи. Введіть ІПН повторно.');
                    return false;
                }

                if (parent.obj_Parameters['CUSTTYPE'] === 'person') {
                    if (this.value !== parent.valOKPO) {
                        alert('Ідн. податковий номер має співпадати з ідентифікаційним кодом. Введіть ІПН повторно.');
                        return false;
                    }
                }
                else {
                    if (this.value.slice(0, 7) !== parent.valOKPO.slice(0, 7)) {
                        alert('Ідн. податковий номер має відповідати ідентифікаційному коду. Введіть ІПН повторно.');
                        return false;
                    }
                }
            }
        });
    });
	
    HideProgress();
}

function showUsersHandBoock(elem) {
    window.parent.bars.ui.handBook('V_STAFF_MANAGERS', function (data) {
        if (data.length > 0) {
            PutIntoEdit(getEl('ed_ISP'), data[0].ID);
        } else {
            PutIntoEdit(getEl('ed_ISP'), '');
        }
    });

   // var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=staff&tail=\'\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px');
   // if (result != null) PutIntoEdit(getEl('ed_ISP'), result[0]);
    ToDoOnChange();
}