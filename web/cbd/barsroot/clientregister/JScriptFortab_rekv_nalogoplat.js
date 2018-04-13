$(function() {
    $('#ed_DATET,#ed_DATEA').mask("99.99.9999");
    $('#ed_TAXF').numberMask({ beforePoint: 10, pattern: /^[0-9]*$/ });
});

// делаем на странице все недоступным
function MyChengeEnable(Flag)
{
	var blFlag = true;
	if(Flag == 'false' || Flag == false) blFlag = false;
	parent.obj_Parameters['RNlPres'] = blFlag;
	document.getElementById('ddl_C_REG').disabled = !blFlag;
	document.getElementById('ddl_C_DST').disabled = !blFlag;
	document.getElementById('ed_ADM').disabled = !blFlag;
	document.getElementById('ed_RGADM').disabled = !blFlag;
	document.getElementById('ed_RGTAX').disabled = !blFlag;
	document.getElementById('ed_TAXF').disabled = !blFlag;
	document.getElementById('ed_DATET').disabled = !blFlag;
	document.getElementById('ed_DATEA').disabled = !blFlag;
	document.getElementById('lb_1').disabled = !blFlag;
	document.getElementById('lb_2').disabled = !blFlag;
}
//первичное заполнение объектов
function InitObjects()
{
	locked = false;
	//необходимые установки
	if(parent.obj_Parameters['EditType'] == "ReReg") 
	{
		document.getElementById('ckb_main').checked = true;
		MyChengeEnable(true);
	}
	else if(parent.obj_Parameters['EditType'] == "Reg") 
	{
		//document.getElementById('ckb_main').checked = false;
		//MyChengeEnable(false);
	}
	
	// снимаем галочку если ничего не заполнено
	if ( trim(parent.obj_Parameters['C_REG']) == '-1'
	    && trim(parent.obj_Parameters['C_DST']) == '-1'
	    && (trim(parent.obj_Parameters['ADM']) == '' || trim(parent.obj_Parameters['ADM']) == null)
	    && (trim(parent.obj_Parameters['TAXF']) == '' || trim(parent.obj_Parameters['TAXF']) == null)
	    && (trim(parent.obj_Parameters['RGADM']) == '' || trim(parent.obj_Parameters['RGADM']) == null)
	    && (trim(parent.obj_Parameters['RGTAX']) == '' || trim(parent.obj_Parameters['RGTAX']) == null)
	    && (trim(parent.obj_Parameters['DATET']) == '' || trim(parent.obj_Parameters['DATET']) == null)
	    && (trim(parent.obj_Parameters['DATEA']) == '' || trim(parent.obj_Parameters['DATEA']) == null)
	    )
	    {
	        document.getElementById('ckb_main').checked = false;
	        document.getElementById('ckb_main').disabled = false;
		    MyChengeEnable(false);
	    }
	
	if (parent.flagEnhCheck) {
	    document.getElementById('ckb_main').checked = true;
	    document.getElementById('ckb_main').disabled = true;
	    MyChengeEnable(true);
	}
    //перевірка якщо фіз особа не СПД або банк (для Ощада)
	if ((parent.obj_Parameters['CUSTTYPE'] == 'person'
        && parent.obj_Parameters['SED'].replace(/^\s+|\s+$/gm, '') != '91')
        || parent.obj_Parameters['CUSTTYPE'] == 'bank') {

	    document.getElementById('ckb_main').checked = false;
	    document.getElementById('ckb_main').disabled = false;
	    MyChengeEnable(false);

	    $('#lb_1, #lb_2, #lb_3, #lb_4').hide();
	}

    GetC_dstList();
	
	//вставляем значения
	if(parent.obj_Parameters['EditType'] != "Reg")
	{
		if(trim(parent.obj_Parameters['C_REG']).length != 0)
		{
			document.getElementById('ddl_C_REG').selectedIndex = FindByVal(document.getElementById('ddl_C_REG'), trim(parent.obj_Parameters['C_REG']));
		}				
		GetC_dstList();	
		
		if(trim(parent.obj_Parameters['C_DST']).length != 0)
		{
			document.getElementById('ddl_C_DST').selectedIndex = FindByVal(document.getElementById('ddl_C_DST'), trim(parent.obj_Parameters['C_DST']));
		}
		
		document.getElementById('ed_ADM').value = trim(parent.obj_Parameters['ADM']);
		document.getElementById('ed_TAXF').value = trim(parent.obj_Parameters['TAXF']);
		document.getElementById('ed_RGADM').value = trim(parent.obj_Parameters['RGADM']);
		document.getElementById('ed_RGTAX').value = trim(parent.obj_Parameters['RGTAX']);
		document.getElementById('ed_DATET').value = trim(parent.obj_Parameters['DATET']);
		document.getElementById('ed_DATEA').value = trim(parent.obj_Parameters['DATEA']);
	}
	DisableAll(document, parent.obj_Parameters['ReadOnly']);
	if (parent.location.href.indexOf("readonly=3") > 0)
	{
	    document.getElementById('ckb_main').checked = false;
	}
	
    HideProgress();
}	
//Районная НИ		
function GetC_dstList()
{
	var C_reg = document.getElementById('ddl_C_REG').selectedIndex;
	if(C_reg != 0)
	{		
		var input = new Array();
		var output = new Array();

		input.C_reg = document.getElementById('ddl_C_REG').item(C_reg).value;
		input.val = new Array();
		input.txt = new Array();

		output = GetWebServiceData('GetC_dstList', input, 1);
		
		//отчищаем дропдаун
		document.getElementById('ddl_C_DST').options.length = 0;						
							
		for(i=0; i<output.val.length; i++)
		{
			//наполняем результатами
			var NewItem = document.createElement("OPTION");
			document.getElementById('ddl_C_DST').options.add(NewItem);
			NewItem.value = output.val[i];
			NewItem.innerText = output.txt[i];
							
			NewItem.value = trim(NewItem.value);
			NewItem.innerText = trim(NewItem.innerText);
		}
	}
	else
	{
		//отчищаем дропдаун
		document.getElementById('ddl_C_DST').options.length = 0;						
	}				
}

