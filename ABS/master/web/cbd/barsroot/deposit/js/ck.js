// Перевірка правильності формату номера паспорта
function ckNumber()
{
	var val = document.getElementById("textDocNumber").value;
	var docType = document.getElementById("listDocType");

	if (document.getElementById("noCheck").value == "1")
		{document.getElementById("noCheck").value = "";return;}
	document.getElementById("noCheck").value = "";

	if (docType.selectedIndex != 1) return;

	if (0 == val.length) return;

	var rexp = new RegExp(/\d{6}/);
    	
	if (!rexp.test(val) || val.length > 6)
	{
		alert(LocalizedString('Mes10')/*'Неверный формат номера паспорта!'*/);
		document.getElementById("noCheck").value = "2";		
		document.getElementById("textDocNumber").focus();			
		document.getElementById("textDocNumber").select();
	}
}
// Перевірка правильності формату серії паспорту
function ckSerial()
{
	var val = document.getElementById("textDocSerial").value;
	var docType = document.getElementById("listDocType");

	if (document.getElementById("noCheck").value == "2")
    {
	    document.getElementById("noCheck").value = "";
        return;
    }

	document.getElementById("noCheck").value = "";

    /// Ексклюзивна заявка правекса.
    //return;

	if ((docType.selectedIndex != 1) || (val.length == 0))
	    return;
	else
    {
        val = val.toUpperCase();
        document.getElementById("textDocSerial").value = val;
    }

    // var rexp = new RegExp(/[A-ZА-Я]{2}/);
    var rexp = new RegExp(/[А-Я]{2}/);

    if (!rexp.test(val) || val.length > 2)
	{
		document.getElementById("noCheck").value = "1";
		// Неверный формат серии паспорта!
        alert(LocalizedString('Mes11'));
		document.getElementById("textDocSerial").focus();	
		document.getElementById("textDocSerial").select();
	}
}
// Перевірка чи символ є цифрою
function doNum()
{
	if (controlKey(event)) return true;
	var digit = ( (event.keyCode > 95 && event.keyCode < 106) 
	|| (event.keyCode > 47 && event.keyCode < 58) );	
	if((event.keyCode > 8) && !digit) return false;
	else return true;
}
// Перевірка чи символ є буквою (допустимою комбінацією клавіш)
function doAlpha()
{
	if (controlKey(event)) return true;

	if (event.keyCode >= 65 && event.keyCode <= 90 || event.keyCode == 32)	
		return true;
				
	if (event.keyCode == 41 || event.keyCode == 40)
		return true;
		
	if (event.keyCode == 186 || event.keyCode == 188 || event.keyCode == 189 
	|| event.keyCode == 190 || event.keyCode == 192 || event.keyCode == 219 
	|| event.keyCode == 221 || event.keyCode == 222)
		return true;

	if (event.keyCode == 8 || event.keyCode == 9  || event.keyCode == 20 || event.keyCode == 35 
	|| event.keyCode == 36 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 45 
	|| event.keyCode == 46 ) 
		return true;
	
	return false;
}
// Перевірка на допустимість комбінації клавіш
function controlKey(event)
{
	if (event.ctrlKey == true) return true;
	if (event.shiftKey == true)
	{ 
		if (event.keyCode == 45 || event.keyCode == 46 
		|| event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 9 ) 
			return true;
		else 
			return false;
	}
	
	return ( event.keyCode == 37 || event.keyCode == 39 ||
	 event.keyCode == 8 || event.keyCode == 35 || event.keyCode == 36 
	 || event.keyCode == 46 || event.keyCode == 13 || event.keyCode == 9 );
}
// Перевірка чи символ є буква\цифро\допустима комбінація клавіш
function doNumAlpha()
{
	if (doAlpha()) return true;
	if (doNum())   return true;
	
	return false;
}
// Перевірка на коректність числа в контролі
function doValueCheck(id)
{
	var val = document.getElementById(id).value;
	
	if (isNaN(val))
	{
		var elem = document.getElementById(id);
		if(!elem.disabled)
		{
			alert(LocalizedString('Mes12')/*'Некорректное значение!'*/);
			elem.focus();
			elem.select();
			return false;
		}
	}
	return true;
}
// Перевірка (перехват) переходу по Enter
function ckBeforeGo(id)
{
	var val = document.getElementById(id).value;
	
	if (isNaN(val))
		return false;
	else
		return true;
}
// Перевірка (перехват) переходу по Enter
function ValidateBeforeEnter()
{	
	if (ckBeforeGo('textClientCode') && ckBeforeGo('RNK') && ckBeforeGo('textAccount') 
	&& ckBeforeGo('textDepositId') && ckBeforeGo('DocNumber'))			
		return true;
	else
		return false;
}
// Перевірка на запвненість полів перед пошуком
function validateControls()
{
	if (!ValidateBeforeEnter())
		return false;
	if (
		document.getElementById("textAccount").value.length > 0		  ||
		document.getElementById("textDepositId").value.length > 0	  ||
		document.getElementById("DocNumber").value.length > 0		  ||
		document.getElementById("RNK").value.length				> 0   ||
		document.getElementById("textClientCode").value.length	> 0   ||
		document.getElementById("textClientName").value.length	>= 1  
	)
		return true;

	alert(LocalizedString('Mes13')/*"Заполните поля для поиска!"*/);
	return false;
}

// Перевірка ДРФО
function ckOKPO()
{
    var elem = document.getElementById("textClientCode");

    // Якщо клієнт НЕрезидент то ОКПО = 9 нулям
    if (!document.getElementById("ckResident").checked)
    {
        if (elem.value == '000000000')
            return true;
        else
        {
            elem.value = '000000000';
            return false;
        }
    }
    else
    {
	    // ІПН резидента має складатися з 10 цифр
        var exp1 = /\d{10}/;
    
        // ІПН не може складатися з однакових цифр
        var exp2 = /^1{10}|2{10}|3{10}|4{10}|5{10}|6{10}|7{10}|8{10}|9{10}$/;
        
        if (!isEmpty(elem.value) && exp1.test(elem.value) && !exp2.test(elem.value))
	    {
	        // відповідність статі клієнта його ІПН по передостанній цифрі
	        var sex = elem.value.substr(8, 1);

	        if (sex == "0")
            {
	            // якщо передостання цифра = „0” - контроль не виконується
                return true;
            }
	        else 
            {
	            // для непарних верне: 1 (стать чоловіча), для парних 2 (стать жіноча)
	            sex = ((Number(sex) % 2) == 1 ? 1 : 2);

	            if (document.getElementById('listSex').selectedIndex == sex)
                {
                    //return true;

                    // перевірка по даті народження
                    var dtBirth;

                    if (document.getElementById('dtBirthDate'))
                    {
                        // тимчасово для старого модуля
                        dtBirth = igedit_getById("dtBirthDate").getDate();
                    }
                    else
                    {
                        // для нового депозитонго модуля
                        var stBirth = document.getElementById("textBirthDate").value;

                        dtBirth = new Date(stBirth.substr(6, 4), stBirth.substr(3, 2), stBirth.substr(0, 2));
                    }
                    
                    if (dtBirth == null)
                    {
                        return true;
                    }
                    else
                    {
                        // дата (31/12/1899) в JS міс. від 0 до 11
                        var dtCheck = new Date(1899, 11, 31);

                        // к-ть днів 
                        var nDays = Math.round((dtBirth - dtCheck) / (1000 * 60 * 60 * 24));

                        if (elem.value.substr(0, 5) != PadLeft(nDays.toString(), 5, '0'))
                        {
                            if (confirm("Дата народження клієнта не відповідає його індивідуальному податковому номеру!" + "\n" + "Дані введено правильно?"))
                                return true;
                            else
                            {
                                elem.select();
                                return false;
                            }

                        }
                        else
                            return true;
                    }
                }
	            else 
                {
                    // alert('Стать клієнта не відповідає його індивідуальному податковому номеру!');
                    if (confirm("Стать клієнта не відповідає його індивідуальному податковому номеру!" + "\n" + "Дані введено правильно?"))
                        return true;
                    else
                    {
                        //document.getElementById("textPhotoDate").focus();
                        elem.select();
                        return false;
                    }
	            }
	        }
	    }
	    else
        {
		    /*"Идентификационный код меньше 10 знаков! Внимание идентификационный код был изменен!"*/
		    if (confirm(LocalizedString('Mes14')+ "\n" + LocalizedString('Mes15')))
		    elem.value = '0000000000';
        }
	}
}

// Перевірка на заповненість
function agr_ck()
{
	if (document.getElementById("agr_id").value == "null" ||
	document.getElementById("agr_id").value == null ||
	document.getElementById("agr_id").value == "") 
	{
		alert(LocalizedString('Mes16')/*"Выберите доп.соглашение для заключения!"*/);
		return false;	
	}
	return true;
}
// Перевірка на заповненість
function tr_ck()
{
	if (document.getElementById("rnk").value == "null" ||
	document.getElementById("rnk").value == null ||
	document.getElementById("rnk").value == "") 
	{
		alert(LocalizedString('Mes17')/*"Выберите довереное лицо!"*/);
		return false;	
	}
	return true;
}
// Перевірка на заповненість
function show_ck()
{
	if (document.getElementById("ccdoc_id").value == "null" ||
	document.getElementById("ccdoc_id").value == null ||
	document.getElementById("ccdoc_id").value == "") 
	{
		alert(LocalizedString('Mes18')/*"Выберите доп.соглашение для печати!"*/);
		return false;	
	}
	return true;
}
// Перевірка на заповненість
function rnk_ck()
{
	if (document.getElementById("rnk").value == "null" ||
	document.getElementById("rnk").value == null ||
	document.getElementById("rnk").value == "") 
	{
		alert(LocalizedString('Mes19')/*"Выберите доп.соглашение для отмены!"*/);
		return false;	
	}
	return true;
}
// Перевірка на заповненість
function rnkb_ck()
{
	if (document.getElementById("rnk").value == "null" ||
	document.getElementById("rnk").value == null ||
	document.getElementById("rnk").value == "") 
	{
		alert(LocalizedString('Mes20')/*"Выберите активное доп. соглашение о правах бенефициара!"*/);
		return false;	
	}
	return true;
}
// Перевірка на заповненість
function tmpl_ck()
{
	if (document.getElementById("Template_id").value == null ||
	document.getElementById("Template_id").value == "") 
	{
		alert(LocalizedString('Mes21')/*"Выберите шаблон!"*/);
		return false;	
	}
	return true;
}
// Перевірка на заповненість
function tt_ck()
{
	if (document.getElementById("tt").value == null ||
		document.getElementById("tt").value == "null" ||
		document.getElementById("tt").value == ""  )
	{
		alert(LocalizedString('Mes22')/*"Выберите операцию!"*/);
		return false;
	}
	return true;
}
// Перевірка на заповненість
function ckDpt_id()
{
	if (document.getElementById("dptid").value == null ||
		document.getElementById("dptid").value == "null" ||
		document.getElementById("dptid").value == ""  )
	{
		alert(LocalizedString('Mes23')/*"Выберите депозит!"*/);
		return false;
	}
	return true;
}
// Перевірка на заповненість
function ckRNK()
{
	if (document.getElementById("rnk").value == null ||
		document.getElementById("rnk").value == "null" ||
		document.getElementById("rnk").value == ""  )
	{
		alert(LocalizedString('Mes24')/*"Выберите клиента!"*/);
		return false;
	}
	return true;
}

function ckLetter()
{
	if (isEmpty(document.getElementById('letter_id').value))
	{	
		alert(LocalizedString('Mes25')/*'Выберите письмо для формирования!'*/);
		return false;
	}
	
	return true;
}
// разбор строки в дату
function fnDateParse(sDate)
{
    var nYear = sDate.substring(6);
    var nMonth = sDate.substring(3, 5) - 1;
    var nDay = sDate.substring(0, 2);
    
    return new Date(nYear, nMonth, nDay);
}
// Перевірка на зміну дати
// без Інфраглістіка
function AddAgrIsDateChanged()
{
	var CurEndDate = fnDateParse(document.getElementById('CurEndDate').value);
	var NewEndDate = fnDateParse(document.getElementById('NewEndDate').value);
	
	if (CurEndDate == NewEndDate)
	{
		alert('Змініть мене!');
		return false;
	}
	return true;
}
// Перевірка на зміну відсоткової ставки
// без Інфраглістіка
function AddAgrIsRateChanged()
{
	var CurRate = document.getElementById('CurRate').value;
	var NewRate = document.getElementById('NewRate').value;
	
	if (CurRate == NewRate)
	{
		alert(LocalizedString('Mes26')/*"Ставка не поменялась!"*/);
		return false;
	}
	return true;
}

// Перевірка на зміну відсоткової ставки
function rateChanged()
{
	var curCtrl = igedit_getById("textCurRate");
	var curRate = curCtrl.getValue();
	var newCtrl = igedit_getById("textNewRate");
	var newRate = newCtrl.getValue();
	if (curRate == newRate)
	{
		alert(LocalizedString('Mes26')/*"Ставка не поменялась!"*/);
		return false;
	}
	return true;
}

// Перевірка на наявність центів для викупу
// kv    -> числовий код валюти
// sum   -> сума (в цілих одиницях)
// denom -> Дільник валюти
function ckDPF(kv, sum, denom) 
{
    if (kv == 980) {
        return 0;
    }
    // Евро
    else if (kv == 978) {
        return sum % 500;
    }
    // долар
    else if (kv == 840) {
        return sum % 100;
    }
    // рубль
    else if (kv == 643) {
        return sum % 500;
    }
    // метали - викуп унцій менше 1 гр. зливка (0.032 або 0.03 унції)
    else if (kv == 959 || kv == 961) {
        if (denom == 1000)
            return sum % 32;
        else
            return sum % 3;
    }
    /*
    // золото - викуп унцій до 20 гр.зливка (0.643 або 0.64 унції)
    else if (kv == 959) {
    if (denom == 1000)
    return sum % 643;
    else
    return sum % 64;
    }
    // срібло - викуп унцій до 100 гр. зливку (3.215 або 3.22 унції)
    else if (kv == 961) {
    if (denom == 1000)
    return sum % 3215;
    else
    return sum % 322;
    }
    */
    else
        return 0;
}

//
function ckForm()
{
    document.getElementById("textMinSum").focus();	
	var minSum		= parseFloat(replaceWS(document.getElementById("textMinSum").value));
	document.getElementById("textContractSum").focus();

	var curSum;
    var Currency = parseInt(document.getElementById("kv").value);
    
    // для депозитів у МЕТАЛАХ при готівковому розміщенні
    if ((Currency == 959 || Currency == 961 || Currency == 962) &&
        (document.getElementById("checkboxIsCash").checked))
    {
        curSum = parseFloat(replaceWS(document.getElementById("ContractSumGrams").value));
    }
    else
    {
        curSum = parseFloat(replaceWS(document.getElementById("textContractSum").value));
    }
	
	var dptType = document.getElementById("listContractType");

	if (dptType.selectedIndex == 0)
	{
		alert(LocalizedString('Mes28')/*"Выберите тип депозитного договора!"*/);
		return false;	
	}

	if (curSum < minSum)
	{
		alert(LocalizedString('Mes29')/*"Сумма меньше минимальной допустимой!"*/);
		return false;
	}	

	document.getElementById('btnSubmit').disabled = 'disabled';
	
	return true;
}
function ckClRegDate(dtId,msgNum)
{
	var docType = document.getElementById("listDocType");
	if (docType.selectedIndex != 1)	return;

    var dtBirth	= igedit_getById("dtBirthDate").getDate();
    var dtPassp	= igedit_getById("dtDocDate").getDate();
    if (dtBirth == null || dtPassp == null)
    {
       dtSwitcher = 0; 
       return;
    }
    dtBirth.setFullYear(dtBirth.getFullYear() + 16);
    if (dtBirth > dtPassp)
    {
        alert("Помилка! \n Між датою народження та датою видачі паспорту \n менше 16 років!");
        document.getElementById(dtId).focus();
        document.getElementById(dtId).select();
        dtSwitcher = msgNum;
    }
    else
        dtSwitcher = 0;
        
    dtBirth.setFullYear(dtBirth.getFullYear() - 16);
    return;
}

//
function checkAddress(source, arguments)            
{
    if (    (isEmpty(document.getElementById('textClientIndex').value)       &&
             isEmpty(document.getElementById('textClientRegion').value)      &&
             isEmpty(document.getElementById('textClientDistrict').value)    &&
             isEmpty(document.getElementById('textClientAddress').value) )    
       )
       {
            alert(LocalizedString('Mes43'));
            arguments.IsValid = false;
       }
       else
       {
            arguments.IsValid = true;
       }
}
function validateClientSettlement(source, arguments)
{
    if ( isEmpty(document.getElementById('textClientSettlement').value) )
       {
            arguments.IsValid = false;
       }
       else
       {
            arguments.IsValid = true;
       }
}

// Перевірка правильності вказаного номеру телефону
function PhoneVerification(PhoneNumber)
{
    // номер тел. має складатися з 9 цифр
    var exp1 = /^\d{9}$/;
    
    // номер тел. не може складатися з однакових цифр
    var exp2 = /^0{9}|1{9}|2{9}|3{9}|4{9}|5{9}|6{9}|7{9}|8{9}|9{9}$/;

    if (!isEmpty(PhoneNumber) && exp1.test(PhoneNumber) && !exp2.test(PhoneNumber)) {
        return true;
    }
    else {
       return false;
    }
}

// Перевірка заповнення телефонних номерів клієнта
function checkPhones(source, arguments) {
    
    if ( isEmpty(document.getElementById('textCellPhone').value) &&
         isEmpty(document.getElementById('textHomePhone').value) &&
         isEmpty(document.getElementById('textWorkPhone').value) )
    {
        alert('Необхідно вказати хоча б один номер телефону!');
        arguments.IsValid = false;
    }
    else
    {
        arguments.IsValid = true;
    /*
        // Перевірка мобільного телефону
        var element = document.getElementById('textCellPhone');

        if (isEmpty(element.value) || PhoneVerification(element.value)) {
            element.style.backgroundColor = "transparent";
            arguments.IsValid = true;
        }
        else {
            element.style.backgroundColor = "LightPink";
            alert('Невірний формат вказаного номеру мобільного телефону!');
            arguments.IsValid = false;
            return;
        }

        // Перевірка домашнього телефону
        element = document.getElementById('textHomePhone');

        if (isEmpty(element.value) || PhoneVerification(element.value)) {
            element.style.backgroundColor = "";
            arguments.IsValid = true;
        }
        else {
            element.style.backgroundColor = "LightPink";
            alert('Невірний формат вказаного номеру телефону!');
            arguments.IsValid = false;
            return;
        }

        // Перевірка робочого телефону
        element = document.getElementById('textWorkPhone');

        if (isEmpty(element.value) || PhoneVerification(element.value)) 
        {
            element.style.backgroundColor = "";
            arguments.IsValid = true;
        }
        else
        {
            element.style.backgroundColor = "LightPink";
            alert('Невірний формат вказаного номеру телефону!');
            arguments.IsValid = false;
            return;
        }
    */
    }
}

// Перевірка 
// для args Value має завждт бути з великої 
function checkClientCode(source, args)
{
    if (isEmpty(args.Value)) 
    {   
        if ((document.getElementById("textClientName").value.length > 2) &&
            (!isEmpty(document.getElementById("textClientDate").value) ||
            (!isEmpty(document.getElementById("textClientSerial").value) && !isEmpty(document.getElementById("textClientNumber").value))))
        {
            args.IsValid = true;
        }
        else
        {
            alert('Для пошуку необхідно вказати ПІБ клієнта та дату народження або серію та номер документу!');
            args.IsValid = false;
        }            
    }
    else
    {        
        var exp1 = /\d{10}/;
    
        var exp2 = /^1{10}|2{10}|3{10}|4{10}|5{10}|6{10}|7{10}|8{10}|9{10}$/;

        if (exp1.test(args.Value) && !exp2.test(args.Value))
            args.IsValid = true;
        else
        {
            alert('Невірний формат ІПН клієнта!');
            args.IsValid = false;
        }
    }
}

// Перевірка відповідності статі клієнта його ІПН
function CheckCodeOnSex(ClietCode)
{
	// по передостанній цифрі
    var sex = ClietCode.substr(8, 1);

	if (sex == "0")
    {
	    // якщо передостання цифра = „0” - контроль не виконується
        return true;
    }
	else 
    {
	    // для непарних верне: 1 (стать чоловіча), для парних 2 (стать жіноча)
	    sex = ((Number(sex) % 2) == 1 ? 1 : 2);

	    if (document.getElementById('listSex').selectedIndex == sex)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}

// Перевірка ОКПО по даті народження клієнта
function CheckCodeOnBirthDate(ClietCode)
{
    var dtBirth;

    if (document.getElementById("textBirthDate"))
    {
        // для нового депозитонго модуля
        var stBirth = document.getElementById("textBirthDate").value;

        if (stBirth == null) {
            return true;
        }

        dtBirth = new Date(stBirth.substr(6, 4), stBirth.substr(3, 2), stBirth.substr(0, 2));        
    }
    else
    {
        // тимчасово для старого модуля
        dtBirth = igedit_getById("dtBirthDate").getDate();

        if (dtBirth == null) {
            return true;
        }
    }
    
    // дата(31/12/1899)
    var dtCheck = new Date(1899, 11, 31);

    // к-ть днів 
    var nDays = Math.round((dtBirth - dtCheck) / (1000 * 60 * 60 * 24));

    if (ClietCode.substr(0, 5) == PadLeft(nDays.toString(), 5, '0'))
    {
        return true;
    }
    else
    {
        return false;
    }
}

function ValidateClientCode()
{
    var control = document.getElementById("textClientCode");

    if (!isEmpty(control.value) && control.value != '0000000000' && control.value != '000000000')
    {
        // Перевірка на відповідність статі клієнта
        if (!CheckCodeOnSex(control.value))
        {
            control.style.backgroundColor = "LightPink";
            document.getElementById("lbInvalidClientCode").innerText = "Не відповідає статі клієнта!";
        }

        // Перевірка на відповідність дата народження клієнта
        if (!CheckCodeOnBirthDate(control.value))
        {
            document.getElementById('lbInvalidClientCode').innerText = "Не відповідає даті народження!";
            control.style.backgroundColor = "LightPink";
        }
    }
    else
    {
        control.style.backgroundColor = "";
    }
}

// Фокусування контрола
function focusControl(id)
{
	var control = document.getElementById(id);
	if (control.readonly || control.disabled) return;
	control.focus();
}

///
function GetSum()
{
    var sum = parseFloat(replaceWS(document.getElementById('SUM').value)); 
    if ( (Math.round(sum) != sum ) || 
            (sum * 1 <= 0) )
    {
        alert('Сума має бути цілочисельною та більшою нуля!');
        return false;
    }
    
    window.returnValue = Math.round(sum * 100);
    window.close();
    return true;
}

///////////////////////////////////
// вроді вже не використовуються //
///////////////////////////////////
function ckFIO() {
    if (isEmpty(document.getElementById('textClientLastName').value)
	|| isEmpty(document.getElementById('textClientFirstName').value)
	|| isEmpty(document.getElementById('textClientPatronymic').value))
        document.getElementById('lbFIO').visible = true;
    else
        document.getElementById('lbFIO').visible = false;
}

function ckDptField() {
    var mandControls = document.getElementById("mand_field").value.split(',');
    if (isEmpty(mandControls))
        return true;
    for (var i = 0; i < mandControls.length; i++) {
        var control = mandControls[i];
        if (isEmpty(document.getElementById(control).value)) {
            alert(LocalizedString('Mes27')/*'Необходимо заполнить!'*/);
            var elem = document.getElementById(control);
            if (!elem.disabled) {
                elem.focus();
                elem.select();
            }
            return false;
        }
    }
    return true;
}

// Перевірка реквізитів виплати коштів по договору
function checkAccounts(source, args) {
    if (isEmpty(args.Value)) {
        args.IsValid = false;
        alert('Необхідно обов\’язково вказати рахунок повернення коштів!');
    }
    else {
        args.IsValid = true;
    }
}