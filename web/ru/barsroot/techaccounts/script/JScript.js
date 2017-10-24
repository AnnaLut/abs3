/// Поповнення технічного рахунку
function ShowAdd(acc,dpt_id,rnk)
{
    if (confirm("Поповнити через касу?"))
        Move("DepositCoowner.aspx?action=add&cash=true&acc=" + acc + "&dpt_id=" + dpt_id);
    else if (confirm("Поповнити безготівковим переказом?"))
        Move("DepositCoowner.aspx?action=add&cash=false&acc=" + acc + "&dpt_id=" + dpt_id);        
}
/// Закриття технічного рахунку
function ShowOwner(acc,dpt_id,rnk,date_close_plan,date_close_fact)
{
    if (date_close_plan == '0' && date_close_fact == '0')
    {
        var branch = document.getElementById('ddBranch').value;
        Move("DepositCoowner.aspx?action=close&acc=" + acc + "&dpt_id=" + dpt_id +
            "&branch=" + branch);
    }
    else
        alert('Процедуру закриття неможливо виконати повторно!');
}
/// Перерахування коштів з технічного рахунку
function ShowPay(acc,dpt_id,rnk,date_close_plan,date_close_fact)
{
    if (confirm("Перерахувати кошти через касу?"))
        Move("DepositCoowner.aspx?action=pay&cash=true&acc=" + acc + "&dpt_id=" + dpt_id);
    else if (confirm("Перерахувати кошти безготівковим переказом?"))
        Move("Transfer.aspx?action=pay&cash=false&acc=" + acc + "&dpt_id=" + dpt_id + "&rnk=" + rnk);        
}
/// Картка технічного рахунку
function ShowCard(acc,dpt_id,rnk)
{
    Move("DepositTechAcc.aspx?action=show&acc=" + acc + "&rnk=" + rnk);                  
}
/// Перехід на історію рахунку
function ShowDoc(acc)
{
    Move("/barsroot/CustomerList/ShowHistory.aspx?acc=" + acc + "&type=0");
}
/// Фінансова картка рахунку
function ShowDocCard(ref)
{
    var url = "/barsroot/documentview/default.aspx?ref="+ref;

	var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:800px; dialogHeight:600px; center:yes; status:no");
}
/// Перевірка чи символ є цифрою
function doNum()
{
	if (controlKey(event)) return true;
	if (event.shiftKey == true) return false;
	var digit = ( (event.keyCode > 95 && event.keyCode < 106) 
	|| (event.keyCode > 47 && event.keyCode < 58) );	
	if((event.keyCode > 8) && !digit) return false;
	else return true;
}
/// Перевірка чи символ є буквою (допустимою комбінацією клавіш)
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
/// Перевірка на допустимість комбінації клавіш
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
/// Перевірка чи символ є буква\цифро\допустима комбінація клавіш
function doNumAlpha()
{
	if (doAlpha()) return true;
	if (doNum())   return true;
	
	return false;
}
/// Перевірка на коректність числа в контролі
function doValueCheck(id)
{
	var val = document.getElementById(id).value;
	
	if (isNaN(val))
	{
		var elem = document.getElementById(id);
		if(!elem.disabled)
		{
			alert("Некоректне значення");
			elem.focus();
			elem.select();
		}
	}
}
/// Перевірка на заповненість
function ckFill(control_id,alert_text)
{
	if (IsEmpty(document.getElementById(control_id).value))
	{
	    if (alert_text == null)
		    alert('Не вибрано жодного запису!');
		else
		    alert(alert_text);
		return false;
	}
	return true;
}
/// Перевірка на нул
function IsEmpty(val)
{
	if (val == null || val == ' ' || val == 'null' || val == '' )
		return true;
	return false;
}
/// Перехід по заданому url
function Move(url)
{
   location.replace(encodeURI(url));
}
/// Вибір шаблонів для формування
function GetTemplates()
{
	var url = "DocumentForm.aspx?";
    url +="code=" + Math.random();	
	var result = window.showModalDialog(encodeURI(url), null,
	"dialogWidth:600px; dialogHeight:400px; center:yes; status:no");
	
	if (result == null)
	{
	    alert('Не вибрано жодного документу!');
	    return false;
	}
	
	document.getElementById("Templates").value = ""; 
	for (key in result)
		document.getElementById("Templates").value += key + ";";

	if (document.getElementById("Templates").value != null 
	&& document.getElementById("Templates").value.length >0)
		document.getElementById("Templates").value 
		= document.getElementById("Templates").value.substring(0,document.getElementById("Templates").value.length-1);
    
    return true;
}
/// Вибір документів для друку
function ShowPrintDialog()
{
	var url = "DocumentPrint.aspx?dpt_id=" + document.getElementById("dpt_id").value;
	url +="&code=" + Math.random();
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:500px; dialogHeight:300px; center:yes; status:no");
}
/// Друк депозитного договору
function print_tech_agr(template)
{
//    var url = "WebPrint.aspx?SOME=C:\\Documents and Settings\\vblagun\\ASPNET.VBLAGUN\\Local Settings\\Temp\\sur\\survey.mht";
    var url = "WebPrint.aspx?dpt_id=" + document.getElementById("_ID").value + "&template=" + template;
//    var url = "WebPrint.aspx?mht_file=C:\\Documents and Settings\\vblagun\\ASPNET.VBLAGUN\\Local Settings\\Temp\\sur\\survey.mht";
	url +="&trace=true&code=" + Math.random();
	window.showModalDialog(encodeURI(url),"_blank", 
	'dialogWidth: 800px; dialogHeight: 600px; center: yes; status:no; menubar:no; toolbar:no; location:no; titlebar:no;');
}
/// Заповнення анкети
function ShowSurvey()
{
    var url = '/barsroot/Survey/Survey.aspx?par=SURVTECH&rnk=' + document.getElementById('textRNK').value;
    var top = window.screen.height/2 - 300;
    var left = window.screen.width/2 - 400;

	window.open(encodeURI(url),"_blank",
	"left=" + left + ",top=" + top + 
	",height=600px,width=800px,menubar=no,toolbar=no,location=no,titlebar=no,resizable=yes");       
}
/// 1.Оплата комісії при відкритті
/// 2.Виплата залишку при закритті
function ShowDocInput(acc_info)
{
	var url = "/barsroot/DocInput/DocInput.aspx?";
	url += "tt=" + document.getElementById("tt").value;	
	
	var dop_rec = "&nd=" + document.getElementById("dpt_id").value;
	dop_rec += "&FIO=" + document.getElementById("NMK").value;	
	dop_rec += "&PASP=" + document.getElementById("PASP").value;
	dop_rec += "&PASPN=" + document.getElementById("PASPN").value;
	dop_rec += "&ATRT=" + document.getElementById("ATRT").value;
	dop_rec += "&ADRES=" + document.getElementById("ADRES").value;
	dop_rec += "&DT_R=" + document.getElementById("DT_R").value;
	dop_rec += "&DOBR=" + document.getElementById("DT_R").value;
	
	url += dop_rec;
	
	url += "&RNK=" + document.getElementById("textRNK").value;

    var sum = Math.round(document.getElementById("textSUM").value * 100);
    var kv = document.getElementById("KV").value;
	
	if (acc_info == 1)
	{
	    /// Виплата залишку - тому додаємо рахунки і суму.
	    url += "&SumC_t=" + document.getElementById("textSUM").value * 100;
	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + document.getElementById("KV").value;
	    url += "&Kv_B=" + document.getElementById("KV").value;	    
	}
	else
	{
	    /// Оплата комісії при відкритті 
	    /// потрібно передати 0 суму щоб порахувало комісію
	    url += "&SumC_t=0";

	    if (!IsEmpty(document.getElementById("AfterPay").value))
		    url += "&APROC=" + document.getElementById("AfterPay").value;	    
	}
	
	url +="&code=" + Math.random();	
				
	var res = window.showModalDialog(encodeURI(url),null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
	
	PageMethods.KomissPaid(document.getElementById('dpt_id').value,OnSucceeded, OnFailed);
	
	/// Виплачуємо центи, якщо це виплата :-)
	var dpfSum = ckDPF(kv,sum);
    if (dpfSum > 0 && acc_info == 1)
    {
        DPF(dpfSum,kv,dop_rec);
    }    
    
    /// Якщо закриття - перевіряємо чи оплатили документ
    if (acc_info == 1)
    {
        var acc = document.getElementById('acc').value;
        PageMethods.GetOstB(acc,OnSucceeded, OnFailed);
    }   
}

// Перевірка на наявність центів для викупу
function ckDPF(kv,sum)
{
	if (kv == 980)
		return 0;
	if (kv == 978)
		return sum%500;
	else
		return sum%100;
}
// Оплата операції викупу центів
function DPF(sum,kv,dop_rec)
{
	var op_name = document.getElementById('dpf_oper').value;
	if (op_name == '' || op_name == "")
	{alert('Не знайдена операція викупу центів!');return;}
		
	var url = "/barsroot/DocInput/DocInput.aspx?tt="+op_name;
	url += "&Kv_A="		+ kv;
	url += "&Kv_B=980";
	url += "&SumA_t="	+ sum;
	url += dop_rec;
	
	url +="&code=" + Math.random();
	
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
}
/// Комісія за поповнення
function TakeAddCommission()
{
    var cash = document.getElementById('cash').value;
    var url = "/barsroot/DocInput/DocInput.aspx?";
	var dop_rec = "&nd=" + document.getElementById("DPT_ID").value;
    dop_rec += "&FIO=" + document.getElementById("NMK").value;	
    dop_rec += "&PASP=" + document.getElementById("PASP").value;
    dop_rec += "&PASPN=" + document.getElementById("PASPN").value;
    dop_rec += "&ATRT=" + document.getElementById("ATRT").value;
    dop_rec += "&ADRES=" + document.getElementById("ADRES").value;
    dop_rec += "&DT_R=" + document.getElementById("DT_R").value;
    dop_rec += "&DOBR=" + document.getElementById("DT_R").value;
    dop_rec += "&RNK=" + document.getElementById("RNK").value;
    
    /// Операція через касу
    if (cash == "1")
    {
        //document.getElementById('btAddPayment').disabled = '';                
	    url += "tt=" + document.getElementById("tt_K").value;	  
	    var sum    = Math.round(GetValue('Sum') * 100 ); 	    
	    url += "&SMAIN=" + sum;	
	    url += "&KVMAIN=" + document.getElementById("KV").value;	  
	    /// щоб обрахувалась формула комісії
	    url += "&SumC_t=0";
    }
    /// Операція безготівкова
    else
    {        
        if (!confirm('Зняти комісію?')) return;
                
        var lcv = document.getElementById("LCV").value;
        if (IsEmpty(lcv))
        {
            alert("Виберіть безготівкове поповнення!");
            return;
        }
        
        /// Операція в нац. валюті
        if (lcv == "UAH")
        {
	        url += "tt=" + document.getElementById("tt_K_N").value;	   	    	
	        url += "&SumC_t=" + Math.round(document.getElementById("SMAIN").value);        
        }
        /// Операція в іноземній валюті
        else
        {
            url += "tt=" + document.getElementById("tt_K_F").value;	   	    	
            url += "&SumA_t=" + Math.round(document.getElementById("SMAIN").value);        
        }
        url += "&SMAIN=" + Math.round(document.getElementById("SMAIN").value);
        url += "&KVMAIN=" + document.getElementById("KV").value;	  
        url += "&Kv_A=" + document.getElementById("KV").value;	          
        url += "&Nls_A=" + document.getElementById("textNLS").value;
        
        /// Додаємо процедуру після оплати, яка проставить 
        /// що по даному поповненні ми комісію вже взяли
        var after_pay_proc = document.getElementById("after_pay_proc").value;
        after_pay_proc = after_pay_proc.replace('#(REF)',document.getElementById("REF").value);        
        url += "&aftprp=" + after_pay_proc;
        url += "&aftprp_r=" + document.getElementById("after_pay_role").value;
    }

	url += dop_rec;
	url +="&code=" + Math.random();
	
    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");		    

    if (cash != "1")
        __doPostBack('','');
    else
        document.getElementById('btCommission').disabled = 'disabled';
}
/// Поповнення
function AddPayment()
{
    var cash = document.getElementById('cash').value;
    var url = "/barsroot/DocInput/DocInput.aspx?";
	var dop_rec = "&nd=" + document.getElementById("DPT_ID").value;
    dop_rec += "&FIO=" + document.getElementById("NMK").value;	
    dop_rec += "&PASP=" + document.getElementById("PASP").value;
    dop_rec += "&PASPN=" + document.getElementById("PASPN").value;
    dop_rec += "&ATRT=" + document.getElementById("ATRT").value;
    dop_rec += "&ADRES=" + document.getElementById("ADRES").value;
    dop_rec += "&DT_R=" + document.getElementById("DT_R").value;
    dop_rec += "&DOBR=" + document.getElementById("DT_R").value;
    dop_rec += "&RNK=" + document.getElementById("RNK").value;
    
    /// Операція через касу
    if (cash == "1")
    {    
        var sum    = Math.round(GetValue('Sum') * 100 );
	    url += "tt=" + document.getElementById("tt").value;

	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + document.getElementById("KV").value;
	    url += "&Kv_B=" + document.getElementById("KV").value;	    
	    url += "&SumC_t=" + sum;
	    
//	    url += "&rnk=" + document.getElementById("textRNK").value;	    	    
    }
    else
    /// не приймаються платежі по безналу
        return;

	url += dop_rec;
    url +="&code=" + Math.random();
    
    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
    
    document.getElementById('btAddPayment').disabled = 'disabled';    
    document.getElementById('btCommission').disabled = '';        
    document.getElementById('Sum').disabled = 'disabled';    	    
}

/// Перерахування коштів на касу
function Transfer()
{
    var cash = document.getElementById('cash').value;
    var url = "/barsroot/DocInput/DocInput.aspx?";
    var sum    = Math.round(GetValue('Sum') * 100 );
    if (sum < 1)
    {
        alert('Неможливо здійснити операцію з нульовою сума!');
        return false;
    }
	var dop_rec = "&nd=" + document.getElementById("DPT_ID").value;
    dop_rec += "&FIO=" + document.getElementById("NMK").value;	
    dop_rec += "&PASP=" + document.getElementById("PASP").value;
    dop_rec += "&PASPN=" + document.getElementById("PASPN").value;
    dop_rec += "&ATRT=" + document.getElementById("ATRT").value;
    dop_rec += "&ADRES=" + document.getElementById("ADRES").value;
    dop_rec += "&DT_R=" + document.getElementById("DT_R").value;
    dop_rec += "&DOBR=" + document.getElementById("DT_R").value;
    dop_rec += "&RNK=" + document.getElementById("textRNK").value;
    
    /// Операція через касу
    if (cash == "1")
    {
        document.getElementById('btPay').disabled = 'disabled';    
	    url += "tt=" + document.getElementById("tt").value;

	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + document.getElementById("KV").value;
	    url += "&Kv_B=" + document.getElementById("KV").value;	    
	    url += "&SumC_t=" + sum;
    }
    else
    /// Операція безготівкового перерахування
    {
        if (!CheckFillSideB()) return;

        var our_mfo = document.getElementById('ourMFO').value;
        var mfo_b = document.getElementById('textMFO_B').value;
        var tt;
        if (our_mfo == mfo_b)   tt = document.getElementById('tt_IN').value;
        else                    tt = document.getElementById('tt_OUT').value;

        document.getElementById('btPay').disabled = 'disabled';    
        document.getElementById('Sum').disabled = "disabled";
        document.getElementById('btPayCommission').disabled = '';        
	    
	    url += "tt=" + tt;

	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + document.getElementById("KV").value;
	    url += "&Kv_B=" + document.getElementById("KV").value;	    
	    
	    url += "&SumC_t=" + sum;

	    url += "&Nls_B=" + document.getElementById("textNLS_B").value;
	    url += "&Nazn=" + document.getElementById("textNAZN").value;	    
		url += "&Mfo_B="	+ document.getElementById("textMFO_B").value;
		url += "&Id_B="		+ document.getElementById("textOKPO_B").value;
		url += "&Nam_B="	+ document.getElementById("textNMS_B").value;
    }

	url += dop_rec;
    url +="&code=" + Math.random();	

    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	

    DisableControls();
}
/// Взяття комісії при перерахуванні коштів безготівкою
function TakeTransferComission()
{
    var cash = document.getElementById('cash').value;
    var url = "/barsroot/DocInput/DocInput.aspx?";
    var sum    = Math.round(GetValue('Sum') * 100 );
    if (sum < 1)
    {
        alert('Неможливо здійснити операцію з нульовою сума!');
        return false;
    }
	var dop_rec = "&nd=" + document.getElementById("DPT_ID").value;
    dop_rec += "&FIO=" + document.getElementById("NMK").value;	
    dop_rec += "&PASP=" + document.getElementById("PASP").value;
    dop_rec += "&PASPN=" + document.getElementById("PASPN").value;
    dop_rec += "&ATRT=" + document.getElementById("ATRT").value;
    dop_rec += "&ADRES=" + document.getElementById("ADRES").value;
    dop_rec += "&DT_R=" + document.getElementById("DT_R").value;
    dop_rec += "&DOBR=" + document.getElementById("DT_R").value;
    dop_rec += "&RNK=" + document.getElementById("textRNK").value;
    
    /// Операція через касу
    if (cash == "1")    
    {
        alert('При виплаті на касу комісія відсутня!');
        return;
    }
    else
    /// Операція безготівкового перерахування
    {
        if (!CheckFillSideB()) return;

        var our_mfo = document.getElementById('ourMFO').value;
        var mfo_b = document.getElementById('textMFO_B').value;
        var tt;
        if (our_mfo == mfo_b)   tt = document.getElementById('tt_IN_K').value;
        else                    tt = document.getElementById('tt_OUT_K').value;

        document.getElementById('btPayCommission').disabled = 'disabled'; 
	    
	    url += "tt=" + tt;

	    url += "&Nls_A=" + document.getElementById("textNLS").value;
	    url += "&Kv_A=" + document.getElementById("KV").value;
	    url += "&Kv_B=" + document.getElementById("KV").value;	    
	    
	    var kv = document.getElementById('KV').value;
	    if (kv == 980)	        url += "&SumC_t=" + sum;
	    else        	        url += "&SumA_t=" + sum;

        url += "&SMAIN=" + sum;
    }

	url += dop_rec;
    url +="&code=" + Math.random();	

    window.showModalDialog(encodeURI(url),null,
    "dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	    
    
    document.getElementById('Sum').disabled = "disabled";    
    DisableControls();
}
/// 
function DisableControls()
{
    if (document.getElementById('textNMS_B'))document.getElementById('textNMS_B').disabled = "disabled";    
    if (document.getElementById('textOKPO_B'))document.getElementById('textOKPO_B').disabled = "disabled";    
    if (document.getElementById('textNLS_B'))document.getElementById('textNLS_B').disabled = "disabled";    
    if (document.getElementById('textMFO_B'))document.getElementById('textMFO_B').disabled = "disabled";    
    if (document.getElementById('textNAZN'))document.getElementById('textNAZN').disabled = "disabled";    
}
/// Перевірка на заповнення реквізитів сторони Б 
/// при безготівковому переказі з технічного рахунку
function CheckFillSideB()
{
    if (IsEmpty(document.getElementById('textNMS_B').value))
    {
        alert('Заповніть ПІБ одержувача!');
        document.getElementById('textNMS_B').select();
        document.getElementById('textNMS_B').focus();
        return false;
    }
    if (IsEmpty(document.getElementById('textOKPO_B').value))
    {
        alert("Заповніть ідентифікаційний код одержувача!");
        document.getElementById('textOKPO_B').select();
        document.getElementById('textOKPO_B').focus();        
        return false;
    }
    if (IsEmpty(document.getElementById('textNLS_B').value))
    {
        alert("Заповніть номер рахунку одержувача!");
        document.getElementById('textNLS_B').select();
        document.getElementById('textNLS_B').focus();        
        return false;
    }                
    if (IsEmpty(document.getElementById('textMFO_B').value))
    {
        alert("Заповніть МФО рахунку одержувача!");
        document.getElementById('textMFO_B').select();
        document.getElementById('textMFO_B').focus();        
        return false;
    }
    if (IsEmpty(document.getElementById('textNAZN').value))
    {
        alert("Заповніть призначення платежу!");
        document.getElementById('textNAZN').select();
        document.getElementById('textNAZN').focus();        
        return false;
    }
    return true;
}
/// 
function CheckSum()
{
    var sumMax = Math.round(parseFloat(document.getElementById('textSUM').value) * 100.0 );
    var sum    = Math.round(GetValue('Sum') * 100.0 );
    var com    = Math.round(GetValue('Commission') * 100.0 );
    
    if (sum > sumMax)
    {
        alert('Сума більша залишку на рахунку!');
        return false;
    }
    if (sumMax - com - sum < 0)
    {
        alert('Сума більша максимальної допустимої з врахуванням комісії!');
        return false;    
    }   
    if (sum < 1)
    {
        alert("Неможливо здійснити операцію з нульовою сумою!");
        return false;
    }
    if (sum == sumMax)
    {
        if (confirm('Зняти всі кошти з рахунку?'))    return true;
        else                return false;
    }
    return true;
}
/// 
function CalculateCommission()
{
    var our_mfo = document.getElementById('ourMFO').value;
    var mfo_b = document.getElementById('textMFO_B').value;
    var tt_in = document.getElementById('tt_IN_K').value;
    var tt_out = document.getElementById('tt_OUT_K').value;
    var sum    = Math.round(GetValue('Sum') * 100.0 );
    
    if (our_mfo == mfo_b)
        PageMethods.CalculateCommission(tt_in,sum,OnSucceeded, OnFailed);
    else
        PageMethods.CalculateCommission(tt_out,sum,OnSucceeded, OnFailed);
}
/// 
function CalculateMaxSum()
{
    var our_mfo = document.getElementById('ourMFO').value;
    var mfo_b = document.getElementById('textMFO_B').value;
    var tt_in = document.getElementById('tt_IN_K').value;
    var tt_out = document.getElementById('tt_OUT_K').value;
    var sum    = Math.round(document.getElementById('textSUM').value * 100.0 );    
       
    if (our_mfo == mfo_b)
        PageMethods.CalculateMaxSum(tt_in,sum,OnSucceeded, OnFailed);
    else
        PageMethods.CalculateMaxSum(tt_out,sum,OnSucceeded, OnFailed);
}
// Callback function invoked on successful 
// completion of the page method.
function OnSucceeded(result, userContext, methodName) 
{    
    if (methodName == 'CalculateCommission')
        SetValue('Commission',result);
    else if (methodName == 'GetOstB')
    {
        var ost = parseFloat(result);
        /// Якщо виплатили всю суму - перевіряємо фактичний залишок
        if (ost == 0)
        {
              document.getElementById('btPay').disabled = "disabled";
              var acc = document.getElementById('acc').value;        
              PageMethods.GetOstC(acc,OnSucceeded, OnFailed);
//            document.getElementById('btClose').disabled = "";
        }
        else
        {
            alert('Технічний рахунок закривати не можна!\nПлановий залишок по рахунку не нульовий!\nВиплатіть залишок перед закриттям!');
            document.getElementById('btPay').disabled = "";
            document.getElementById('btClose').disabled = "disabled";
        }
    }
    else if (methodName == 'GetOstC')
    {
        var ost = parseFloat(result);
        /// Якщо виплатили всю суму - дозволяємо закривати
        if (ost == 0)
        {
            document.getElementById('btPay').disabled = "disabled";
            document.getElementById('btClose').disabled = "";
        }
        else
        {
            alert('Фактичний залишок по рахунку не нульовий!\nЗавізуйте оплачені документи та поверніться в процедуру закриття.');
            document.getElementById('btClose').disabled = "disabled";
        }
    }
    else if (methodName == 'Pay')
    {
        __doPostBack('','');
    }
    else if (methodName == 'CalculateMaxSum')
    {
        SetValue('Sum',result);
        CalculateCommission();
    }
    else if (methodName == 'KomissPaid')
    {
        if (result == 'Y')
            document.getElementById('btPay').disabled = 'disabled';
    }
}
// Callback function invoked on failure 
// of the page method.
function OnFailed(error, userContext, methodName) 
{
    if(error !== null) 
    {
        var url = "dialog.aspx?type=err";
        url +="&code=" + Math.random();
        window.showModalDialog(url,"",
        "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");    
    }
}
/// Перевірка суми при поповненні
function ckSum4Add()
{
    /// Поповнення безготівкою - суму не перевіряємо
    if (document.getElementById('Sum') == null)
        return true;
        
    var sum    = Math.round(GetValue('Sum') * 100.0 );
    
    if (sum < 1)
    {
        alert('Вкажіть будь-ласка суму!\nНеможливо виконати операцію з нульовою сумою!');
        return false;
    }    
    
    return true;
}
/// Наводимо фокус на контрол по його ід
function focusControl(id)
{
	var control = document.getElementById(id);
	if (control == null) return;
	if (control.readonly || control.disabled) return;
    control.focus();
}
/// Поповнення безготівкою: відмічаємо всі документи 
/// по яких потрібно взяти комісію
function markPayments(ref)
{
    event.srcElement.checked ? refs2pay[ref] = ref : refs2pay[ref] = null;	    
}
/// Поповнення безготівкою: відмітити всі чекбокси на сторінці
function CheckAll()
{
	var clientID = document.getElementById('clientIDs').value;
	var data = clientID.split('%');
	for(var id in data)
	{
		var ctrl = document.getElementById(data[id]);
		if (ctrl != null) ctrl.click();
	}
}
/// 
function PayCommissionAll()
{
    var parameter = null; 
	for(var ref in refs2pay)
	{
	    if (refs2pay[ref] != null)
	        (parameter == null) ? parameter = refs2pay[ref] + '%' : parameter += refs2pay[ref] + '%';
	}
	/// Якщо нічого не оплатили - то і обновляти немає чого
	if (parameter == null)
	{ alert('Виберіть документи для оплати комісії!'); return false; }
	
	/// Оплачуємо всі документи
	PageMethods.Pay(parameter,OnSucceeded, OnFailed);
}