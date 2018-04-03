function trim(a)
{
	if(a == null) return null;
	return a.toString().replace(/^\s*|\s*$/g,'');
}
// разбор строки в дату
function fnDateParse(sDate)
{
    var nYear = sDate.substring(6);
    var nMonth = sDate.substring(3, 5) - 1;
    var nDay = sDate.substring(0, 2);
    
    return new Date(nYear, nMonth, nDay);
}
// сообщение о том что поле неверно заполнено и установка на него фокуса
function requiredFieldAlert(edit_obj, text)
{
    alert(text);
    edit_obj.focus();
}
// Функция проверки валидности ОКПО
function checkOKPO(edit, date)
{
    var strOKPO = trim(edit.value);
    var dDate = ( trim(date.value) == '' ? new Date(1899,11,31) : fnDateParse(date.value) );
    var strOKPONew = '';
    var m7_ = '';
    var c1_ = '';
    var c2_ = '';
    var kc_ = 0;
    var sum_ = 0;
    
    if(strOKPO == '')
    {
        // пустое поле пропускаем 
        
        return true;
    }
    else if(strOKPO == '99999' || strOKPO == '000000000')
    {
        // ОКПО 99999 и 000000000 пропускаем как валидные
        
        return true;
    }
    else if(strOKPO.length < 8)
    {
        // дополняем нулями слева до восьми символов
        var cnt = 8 - strOKPO.length;
        for(j=0; j<cnt; j++) strOKPO = '0' + strOKPO;
        edit.value = strOKPO;
        
        return checkOKPO(edit, date);
    }
    else if(strOKPO.length == 10)
    {
        // ДРФО 
        var msecDay = 1000*60*60*24;
        var firstDay = new Date(1899,11,31);
		var birthDay = fnDateParse(date.value);
		var differ = (birthDay - firstDay) / msecDay;
		differ = Math.round(differ);
		
		if (differ < 10) 
		{
		    requiredFieldAlert(date, 'Заполните дату рождения');
		    return false;
		}
		
		if(strOKPO != differ + strOKPO.substring(5))
		{
            requiredFieldAlert(edit, 'Неверный идент. код');
            return false;
		}
        
        return true;
    } 
    else if(strOKPO.length == 9)
    {
        // ДПА не проверяется
        return true;
    }
    else if(strOKPO.length == 8)
    {
        // ЄДРПОУ проверяется
 
        if(strOKPO < '30000000' || strOKPO > '60000000') m7_ = '1234567';
        else m7_ = '7123456';
        
        for(i=0; i<7; i++)
        {
            c1_ = strOKPO.substr(i, 1);
            c2_ = m7_.substr(i, 1);
            
            sum_ += parseInt(c1_)*parseInt(c2_);
        }
        
        kc_ = sum_ % 11;
        
        if(kc_ == 10)
        {
            if(strOKPO < '30000000' || strOKPO > '60000000') m7_ = '3456789';
            else m7_ = '9345678'; 
         
            sum_ = 0;

            for(i=0; i<7; i++)
            {
                c1_ = strOKPO.substr(i, 1);
                c2_ = m7_.substr(i, 1);
            
                sum_ += parseInt(c1_)*parseInt(c2_);
            }
         
            kc_ = sum_ % 11;
         
            if(kc_ == 10) kc_= 0;
        }  
        
        strOKPONew = strOKPO.substr(0, 7) + kc_;
        
        if(strOKPONew == strOKPO) return true;
        else 
        {
            requiredFieldAlert(edit, 'Неверный идент. код');
            return false;
        }
    }    
    else
    {
        requiredFieldAlert(edit, 'Неверный идент. код');
        return false;
    }
}

//------------------------------------------------------------------------------------------
function GetRNKRefer(btControl)
{
	var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=CUSTOMER&tail=\'\'&role=WR_CUSTREG', window, 'dialogHeight:600px; dialogWidth:600px');
	if (result != null) 
	{
	    var sRes = result[0];
	    var sRow = btControl.id.replace('gvRelData_ctl', '').replace('_btEdRnk', '');
	    __doPostBack('gvRelData','SET_RNK$' + sRow + ';' + sRes);
	}
	
	return false;
}
function GetCountryRefer(btControl)
{
	var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=COUNTRY&tail=\'\'&role=WR_CUSTREG', window, 'dialogHeight:600px; dialogWidth:600px');
	if (result != null) 
	{
	    var sRes = result[0];
	    var sEdId = btControl.id.replace('btEdCountry', 'edEdCountry');
	    document.getElementById(sEdId).value = sRes;
	}
	
	return false;
}
function GetRegionRefer(btControl)
{
	var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=SPR_OBL&tail=\'\'&role=WR_CUSTREG', window, 'dialogHeight:600px; dialogWidth:600px');
	if (result != null) 
	{
	    var sRes = result[0];
	    var sEdId = btControl.id.replace('btEdRegion', 'edEdRegion');
	    document.getElementById(sEdId).value = sRes;
	}
	
	return false;
}
function GetFSRefer(btControl)
{
	var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=FS&tail=\'\'&role=WR_CUSTREG', window, 'dialogHeight:600px; dialogWidth:600px');
	if (result != null) 
	{
	    var sRes = result[0];
	    var sEdId = btControl.id.replace('btEdFS', 'edEdFS');
	    document.getElementById(sEdId).value = sRes;
	}
	
	return false;
}
function GetVEDRefer(btControl)
{
	var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=VED&tail=\'\'&role=WR_CUSTREG', window, 'dialogHeight:600px; dialogWidth:600px');
	if (result != null) 
	{
	    var sRes = result[0];
	    var sEdId = btControl.id.replace('btEdVED', 'edEdVED');
	    document.getElementById(sEdId).value = sRes;
	}
	
	return false;
}
function GetSEDRefer(btControl)
{
	var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=SED&tail=\'\'&role=WR_CUSTREG', window, 'dialogHeight:600px; dialogWidth:600px');
	if (result != null) 
	{
	    var sRes = result[0];
	    var sEdId = btControl.id.replace('btEdSED', 'edEdSED');
	    document.getElementById(sEdId).value = sRes;
	}
	
	return false;
}
function GetISERefer(btControl)
{
	var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=ISE&tail=\'\'&role=WR_CUSTREG', window, 'dialogHeight:600px; dialogWidth:600px');
	if (result != null) 
	{
	    var sRes = result[0];
	    var sEdId = btControl.id.replace('btEdISE', 'edEdISE');
	    document.getElementById(sEdId).value = sRes;
	}
	
	return false;
}
function GetSeal(imgObj, curid)
{
	var result = window.showModalDialog('tab_linked_custs_seal_img.aspx?mode=set&id=' + curid, null, 'dialogHeight:450px; dialogWidth:350px');

    if (result != null)    
    {
        document.getElementById('edSIGN_ID').value = result;
        document.getElementById('imgSeal').src = 'tab_linked_custs_seal_img.aspx?mode=throw&id=' + result;
    }
    
    return false;
}
function CheckGridFields(imgObj)
{
    var UpdateID = imgObj.id;

    var OkpoObj = document.getElementById(UpdateID.replace('imgUpdate', 'edEdOkpo'));
    var BDayObj = document.getElementById(UpdateID.replace('imgUpdate', 'edEdBDay'));

    
    if (OkpoObj.value != '' && !checkOKPO(OkpoObj, BDayObj)) return false;
    
    return true;
}