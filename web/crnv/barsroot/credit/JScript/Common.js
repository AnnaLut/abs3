// Скрипт с общедоступными функциями

// первичная инициализация даты
var initDate = '01/01/0001';
var curDate = '01/01/0001';

// разбор строки в дату
function fnDateParse(sDate)
{
    var nYear = sDate.substring(6);
    var nMonth = sDate.substring(3, 5) - 1;
    var nDay = sDate.substring(0, 2);
    
    return new Date(nYear, nMonth, nDay);
}
// уберает из строки все пробелы
function fnDelAllWS(text)
{
    var res = text;
    for(i=0; i<text.length; i++)
        res = res.replace(' ', '');
    
    return res;
}
// инициализация контрола ввода даты
function fnInitDate(sEditName)
{
    window[sEditName] = new RadDateInput(sEditName, "Windows");			                    
    window[sEditName].PromptChar = " ";
    window[sEditName].DisplayPromptChar = "_";
    window[sEditName].SetMask(rdmskr(1, 31, false, true),rdmskl('/'),rdmskr(1,12, false, true),rdmskl('/'),rdmskr(1, 2999, false, true));
    window[sEditName].RangeValidation = true;
    window[sEditName].SetMinDate(initDate);
    window[sEditName].SetValue(gE(sEditName + '_TextBox').value);
    window[sEditName].SetMaxDate('31/12/2099 00:00:00');
    window[sEditName].Initialize();
}
// сокращенный вызов document.getElementById(text_id)
function gE(text_id) { return document.getElementById(text_id); }
// аналог Trim
function trim(text)
{
	if(text == null) return null;
	return text.replace(/^\s*|\s*$/g,'');
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
        
        return checkOKPO(edit);
    }
    else if(strOKPO.length == 10)
    {
        // ДРФО 
        if (date.value == initDate)
        {
            requiredFieldAlert(date, <BarsLocalize key="labZapolniteDatuRogdenia" />);
            return false;
        }
        
        var msecDay = 1000*60*60*24;
        var firstDay = new Date(1899,11,31);
		var birthDay = fnDateParse(date.value);
		var differ = (birthDay - firstDay) / msecDay;
		
		if(strOKPO != differ + strOKPO.substring(5))
		{
            requiredFieldAlert(edit, <BarsLocalize key="labNevernyiIdetifikacionyiKod" />);
            edit.value = '';
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
            alert(<BarsLocalize key="labNevernyiIdetifikacionyiKod" />);
            edit.focus();
            edit.select();
      
            return false;
        }
    }    
    else
    {
        alert(<BarsLocalize key="labNevernyiIdetifikacionyiKod" />);
        edit.focus();
        edit.select();

        return false;
    }
}

// функция ограничивающая ввод только цифер
function onlyNumbers(e)
{
    var keynum;
    
    if(window.event) // IE
    {
        keynum = e.keyCode;
    }
    else if(e.which) // Netscape/Firefox/Opera
    {
        keynum = e.which;
    }
    
    var keychar = String.fromCharCode(keynum);
    var numcheck = /\d/;
    
    return numcheck.test(keychar)
}

// уберает ведущий 0
function fnDelLeadZero(oEdit)
{
    var sVal = oEdit.value;    
    while (sVal.substring(0,1) == '0') sVal = sVal.substring(1);    
    if (sVal == '') sVal = '0';
    
    oEdit.value = sVal;
}
// функция проверки серии паспорта
function checkSER(edit)
{
    // пустой не проверяем
    if (edit == null || edit.value == null || trim(edit.value) == '') return true;
    
	var str2Check = trim(edit.value).toUpperCase();
	edit.value = str2Check;
	
	var rexp = new RegExp(/[A-Z]{2}/);
	
	if (!rexp.test(str2Check) || str2Check.length > 2)
	{
            alert(<BarsLocalize key="labNevernaiaSeriaPasporta" />);
            edit.focus();
            edit.select();
		
		return false;
	}
	
	return true;
}

// приостановка выполнения сценария на заданое время
Date.ONE_SECOND = 1000
Date.ONE_MINUTE = Date.ONE_SECOND * 60
Date.ONE_HOUR = Date.ONE_MINUTE * 60
Date.ONE_DAY = Date.ONE_HOUR * 24

function Sleep(sec)
{
    var then = new Date( new Date().getTime() + sec * Date.ONE_SECOND ); 
    while ( new Date() < then ) { }
}

// обновить данные договора
function fnRefreshDog(lstype, lsccid, lsdate)
{
    // если нажали обновить когда он еще не найден
    if (!lsccid || trim(lsccid) == '' || !lsdate || trim(lsdate) == '')
    {
        fnFindDog(lstype);
    }
    else
    {
        fnFindDog(lstype, escape(lsccid), escape(lsdate));
    }
}

// функция поиска договора
function fnFindDog(stype, sccid, sdate)
{
    // стандартный результат в виде масива
    var arRes = new Array();        
    
    // обновление ли это или поиск
    if (!sccid || !sdate)
    {
        var dialogRes = window.showModalDialog('Search.aspx?stype=' + stype, '', 'dialogWidth:650px;center:yes;edge:sunken;help:no;status:no;');
    }
    else
    {
        var dialogRes = window.showModalDialog('Search.aspx?stype=' + stype + '&pccid=' + sccid + '&pdate=' + sdate, '', 'dialogWidth:650px;center:yes;edge:sunken;help:no;status:no;');
    }         

    __doPostBack('', '');       
}

// проверка заполнености полей общая
function fnCheckFields()
{
    var oAllList = document.all;
    var oList = new Array();
    
    var idx = 0;
    for( i=0; i<oAllList.length; i++ )
        if (oAllList[i].cntltype)
            oList[idx++] = oAllList[i];
    
    for(i=0; i<oList.length; i++)
    {
        var oCurCntr = oList[i];
        var sCurType = oList[i].cntltype;
        
        switch (sCurType)
        {
            case 'none' :
                // пропускаем
                break;
            case 's' :
                // строка
                if( trim(oCurCntr.value) == '' )
                {
                    requiredFieldAlert(oCurCntr, <BarsLocalize key="labPoleObiazatelnoDliaZapolnenia" />); 
                    return false;
                }
                break;
            case 'd' :
                // дата
                if( oCurCntr.value == initDate )
                {
                    requiredFieldAlert(oCurCntr, <BarsLocalize key="labZapolniteDatu" />); 
                    return false;
                }
                break;
            case 'n' :
                // число
                if ( trim(oCurCntr.value) == '' )
                {
                    requiredFieldAlert(oCurCntr, <BarsLocalize key="labPoleObiazatelnoDliaZapolnenia" />); 
                    return false;
                }
                break;
            case 'l' :
                // список
                if ( oCurCntr.value == '-1' )
                {
                    requiredFieldAlert(oCurCntr, <BarsLocalize key="labPoleObiazatelnoDliaZapolnenia" />); 
                    return false;
                }
                break;
        }
    }
    
    return true;
}

//возвращает число по строке, удаляет пробелы, пустую строку переводит в 0
function fnGetNotNullNumber(text)
{
    var sInitVal = (text == '')?('0'):(text);
    
    return ParseF(fnDelAllWS(sInitVal));
}
