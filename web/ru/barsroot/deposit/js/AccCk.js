// Перевірка рахунку по МФО
// err_n - ознака того що не треба вже перевіряти
// 1 - помилка в 1му контролі + фокус вже є
// 2 - помилка в 2му контролі
function chkAccount(nls,mfo,not_kasa,control_num)
{ 
  var err_n = null; 
  if (document.getElementById('err_n') != null)
      err_n = document.getElementById('err_n').value;
      
  var e2 = document.getElementById(nls);
  var e3 = document.getElementById(mfo);
  
  if (err_n != null && err_n != 0 && control_num != err_n )
     return true;

  if (control_num != null)
  {
      if (!doValueCheck(nls))
      {
         if (err_n != null) document.getElementById('err_n').value = control_num;
         return false;
      }
  }
  
  if ( e2.value == "") return true;
  
  if ( e2.value != cDocVkrz(e3.value,e2.value) ) 
  {
    if (err_n != null) document.getElementById('err_n').value = control_num;
    
	var message = LocalizedString('Mes0');//"Некорректное значение!";
	if (e3.value == "")
		message += "\n" + LocalizedString('Mes1');//"Очистите поле счёта и введите сначала МФО";
	alert(message);
	setFocus1(e2.name); 
	return false;
  }
  if (not_kasa == 1 && e2.value.substring(0,3)=='100')
  {
	var message = LocalizedString('Mes2')+ "\n" + LocalizedString('Mes3');//"Некорректно указывать здесь счёт кассы!" + "\n" + "Измените его или оставте поле пустым";
	alert(message);
	if(!e2.disabled)
		setFocus1(e2.name); 
	return false;
  }
  
  if (err_n != null) 
     document.getElementById('err_n').value = 0;
  
  return true;
}
// Встановлення фокусу на елемент
function setFocus1(ename)
{ 
	var elem = document.getElementById(ename);
    if(!elem.disabled)
    {
		elem.focus();
		elem.select();
	}
}
// Встановлення фокусу на елемент
function setFocus2(elem)
{ 
    if(!elem.disabled)
    {
		elem.focus();
		elem.select();
	}
}
// Перевірка рахунку по МФО
function cDocVkrz(mfo,nls0)
{ 
   var nls=nls0.substring(0,4)+'0'+nls0.substring(5, nls0.length );
   var m1 = '137130'         ;
   var m2 = '37137137137137' ;
   var  j = 0                ;
   for ( var i = 0; i < mfo.length; i++ )
       { j =j +  parseInt(mfo.substring(i,i+1)) * parseInt(m1.substring(i,i+1)); }

   for ( var i = 0; i < nls.length; i++ )
       { j =j +  parseInt(nls.substring(i,i+1)) * parseInt(m2.substring(i,i+1)); }
         
   return nls.substring(0,4) +
          (((j + nls.length ) * 7) % 10 ) +
          nls.substring(5, nls.length );
}
// Перевірка на заповненість
function isFilled(nls,mfo,okpo,nmk)
{  
  var str1 = nls.value; 
  var str2 = mfo.value;
  var str3 = okpo.value;
  var str4 = nmk.value;
  
  /// поля мають бути або всі заповнені або всі порожні
  if ((isEmpty(str1) && isEmpty(str2) && isEmpty(str3) && isEmpty(str4)) || 
        (isNotEmpty(str1) && isNotEmpty(str2) && isNotEmpty(str3) && isNotEmpty(str4)))
		return true;
  else 
  {
	if (isEmpty(str1)) {alert(LocalizedString('Mes4')/*"Необходимо заполнить НЛС!"*/); setFocus2(nls); }
	else if (isEmpty(str2)) {alert(LocalizedString('Mes5')/*"Необходимо заполнить МФО!"*/); setFocus2(mfo); }
	else if (isEmpty(str3)) {alert(LocalizedString('Mes44')/*"Необходимо заполнить ОКПО!"*/); setFocus2(okpo); }
	else {alert(LocalizedString('Mes45')/*"Необходимо заполнить получателя!"*/); setFocus2(nmk); }
  }
  return false;
}
// Автозаповнення ОКПО та НМК (для виплати відсотків)
function getNMKp()
{
	if (document.getElementById("MFO").value != document.getElementById("textBankMFO").value &&
	    isNotEmpty(document.getElementById("textBankMFO").value))
	{
		document.getElementById("textIntRcpName").value = document.getElementById("NMK").value;
		document.getElementById("textIntRcpOKPO").value = document.getElementById("OKPO").value;
		document.getElementById("textIntRcpName").disabled = 'disabled';
		document.getElementById("textIntRcpOKPO").disabled = 'disabled';
	}
	else
	{
		document.getElementById("textIntRcpName").disabled = '';
		document.getElementById("textIntRcpOKPO").disabled = '';	
	}
}
// Автозаповнення ОКПО та НМК (для виплати вкладу)
function getNMKv()
{
	if (document.getElementById("MFO").value != document.getElementById("textRestRcpMFO").value &&
	    isNotEmpty(document.getElementById("textRestRcpMFO").value))
	{
		document.getElementById("textRestRcpName").value = document.getElementById("NMK").value;
		document.getElementById("textRestRcpOKPO").value = document.getElementById("OKPO").value;
		document.getElementById("textRestRcpName").disabled = 'disabled';
		document.getElementById("textRestRcpOKPO").disabled = 'disabled';		
	}
	else
	{
		document.getElementById("textRestRcpName").disabled = '';
		document.getElementById("textRestRcpOKPO").disabled = '';	
	}
}
// Валідація на заповнення полів виплат
function Valid(sign)
{
	var nls = document.getElementById("textNLS");
	var mfo = document.getElementById("textMFO");
	var okpo = document.getElementById("textOKPO");
	var nmk = document.getElementById("textNMK");
	
	if (!isFilled(nls,mfo,okpo,nmk)) return false;

	if (sign == 1) PercentPay();
	else if (sign == 2) DepositReturn();
	else if (sign == 3) DepositPay();
	else if (sign == 4) DepositPercentPay();
	else if (sign == 5) DepositReturnPercent();
	
	return true;
}

// Валідація на заповненність полів рахунків та МФО
// ncase - тип перевірки рахунків: 0 - деп. + %%, 1 - деп., -1 - %%.
function Validate(ncase)
{
    if (ncase != -1)
    {
        var nls = document.getElementById("textAccountNumber");
        var mfo = document.getElementById("textRestRcpMFO");
        var okpo = document.getElementById("textRestRcpOKPO");
        var nmk = document.getElementById("textRestRcpName");

        if (!isFilled(nls, mfo, okpo, nmk)) return false;
    }

	if ( ncase != 1)
	{		
		nls = document.getElementById("textBankAccount");
		mfo = document.getElementById("textBankMFO");
		okpo = document.getElementById("textIntRcpOKPO");
		nmk  = document.getElementById("textIntRcpName");
		
		if (!isFilled(nls, mfo, okpo, nmk)) {
		    alert("Не заповнено усі реквізити рахунку для виплати відсотків!");
		    return false;
		}
	}
			
	return true;
}

// Виплата відстоків по вкладу
function PercentPay() 
{	
	var url = "/barsroot/DocInput/DocInput.aspx?";
	
	url += "tt="		+ document.getElementById("tt").value			
	url += "&nd="		+ document.getElementById("dpt_id").value;				
	
	var editor = igedit_getById("textSum");
	var sum = parseFloat(editor.getNumber());
	var denom = parseInt(document.getElementById("denom").value);
    
    sum = Math.round(sum * denom);

	if (document.getElementById("flv").value == 1)
		url += "&SumA_t="	+ sum;
	else
		url += "&SumC_t="	+ sum;

	url += "&Kv_A="		+ document.getElementById("Kv").value;
	if (document.getElementById("flv").value == 1)
		url += "&Kv_B="		+ document.getElementById("kvk").value;
	else
		url += "&Kv_B="		+ document.getElementById("Kv").value;
		
	url += "&Nls_A="	+ document.getElementById("PercentNls").value;
	
	url += "&Nls_B="	    + document.getElementById("textNLS").value;
	url += "&Mfo_B="	+ document.getElementById("textMFO").value;
	url += "&Id_B="		+ document.getElementById("textOKPO").value;
	url += "&Nam_B="	+ document.getElementById("textNMK").value;	
	
	var dop_rec = "&RNK=" + document.getElementById("RNK").value;
    dop_rec += "&code=" + Math.random();	
    url += dop_rec;

    if (document.getElementById("AfterPay").value != null &&
	document.getElementById("AfterPay").value != "")
		url += "&APROC=" + escape(document.getElementById("AfterPay").value);

    if (document.getElementById("BeforePay").value != null &&
	document.getElementById("BeforePay").value != "")
        url += "&BPROC=" + escape(document.getElementById("BeforePay").value);
    	
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");
	
	var textcrossrat = document.getElementById("CrossRat").value;
	if (parseFloat("1.1") == 1)
	    textcrossrat = textcrossrat.replace('.',',');
	else 
        textcrossrat = textcrossrat.replace(',','.');

	var rate = parseFloat(textcrossrat);
	rate = Math.round(rate * 10000) / 10000;

	if (document.getElementById("ISCASH").value == '1')
    {
		if (rate == 0 || isNaN(rate))
		{
		    var dpf = ckDPF(document.getElementById("Kv").value, sum, denom);
			if (dpf > 0)
			{		
				dpf = Math.round(dpf);
				DPF(dpf, document.getElementById("Kv").value, document.getElementById("dpt_id").value, dop_rec);
			}
		}
		else
		{
		    var dpf = ckDPF(document.getElementById("kvk").value, sum * rate, denom);
			if (dpf > 0)
			{
				dpf = Math.round(dpf);
				DPF(dpf, document.getElementById("kvk").value, document.getElementById("dpt_id").value, dop_rec);
			}
		}
	}
}

// Виплата вкладу при достроковому закритті депозиту
function DepositReturn()
{
	var url = "/barsroot/DocInput/DocInput.aspx?";
	
	url += "tt="		+ document.getElementById("tt").value			
	url += "&nd="		+ document.getElementById("dpt_id").value;	
	
	var editor = igedit_getById("SumToPay");
	var sum = parseFloat(editor.getNumber());
	var denom = parseInt(document.getElementById("denom").value);
	
    // 
    sum = Math.round(sum * denom);
	
	if (document.getElementById("flv").value == 1)
		url += "&SumA_t="	+ sum;
	else
		url += "&SumC_t="	+ sum;
	url += "&Kv_A="		+ document.getElementById("Kv").value;
	if (document.getElementById("flv").value == 1)
		url += "&Kv_B="		+ document.getElementById("kvk").value;
	else
		url += "&Kv_B="		+ document.getElementById("Kv").value;		
	
	url += "&Nls_A="	+ document.getElementById("Nls_A").value;
	
	url += "&Nls_B="	+ document.getElementById("textNLS").value;
	url += "&Mfo_B="		+ document.getElementById("textMFO").value;
	url += "&Id_B="		+ document.getElementById("textOKPO").value;
	url += "&Nam_B="	+ document.getElementById("textNMK").value;	
    
    var dop_rec = "&RNK=" + document.getElementById("RNK").value;
    dop_rec += "&code=" + Math.random();	
    
    url += dop_rec;
    
    /// Передаємо мінус - бо це зняття
    sum = -1 * sum;
			
	if (document.getElementById("AfterPay").value != null &&
	document.getElementById("AfterPay").value != "")
	    url += "&APROC=" + escape(document.getElementById("AfterPay").value.replace("#", sum));

	if (document.getElementById("BeforePay").value != null &&
	document.getElementById("BeforePay").value != "")
	    url += "&BPROC=" + escape(document.getElementById("BeforePay").value);
    	    	
	/// міняємо знак назад для виплати	
    sum = -1 * sum;

    window.showModalDialog(encodeURI(url), null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
	
	var textcrossrat = document.getElementById("CrossRat").value;
	if (parseFloat("1.1") == 1)
	    textcrossrat = textcrossrat.replace('.',',');
	else 
        textcrossrat = textcrossrat.replace(',','.');

	var rate = parseFloat(textcrossrat);
	rate = Math.round(rate * 10000) / 10000;
		
	if (document.getElementById("ISCASH").value == '1')
	{
		if (rate == 0 || isNaN(rate))
		{
		    var dpf = ckDPF(document.getElementById("Kv").value, sum, denom);
			if (dpf > 0)
			{
			    dpf = Math.round(dpf);
				DPF(dpf, document.getElementById("Kv").value, document.getElementById("dpt_id").value, dop_rec);
			}
		}
		else
		{
		    var dpf = ckDPF(document.getElementById("kvk").value, sum * rate, denom);
			if (dpf > 0)
			{
				dpf = Math.round(dpf);
				DPF(dpf, document.getElementById("kvk").value, document.getElementById("dpt_id").value, dop_rec);
			}
		}
	}
}

// Виплата депозиту по заверешенні сроку
function DepositPay()
{
	var url = "/barsroot/DocInput/DocInput.aspx?";

	url += "tt="		+ document.getElementById("tt").value;
	url += "&nd="		+ document.getElementById("dpt_id").value;	

	var denom = parseInt(document.getElementById("denom").value);

	if (document.getElementById("dptDepositToPay_t")) {
	    var editor = igedit_getById("dptDepositToPay");
	    var sum = parseFloat(editor.getNumber());
	    // Сума в цілих одиницях
	    sum = Math.round(sum * denom);
	}
	else {        
	    var editor = document.getElementById("dptDepositToPay").value;

	    editor = editor.replace(/ /g, "").replace(/,/g, "").replace(/\./g, "");

	    var sum = parseInt(editor);	    
	}
	
	if (document.getElementById("flv").value == 1)
		url += "&SumA_t="	+ sum;
	else
		url += "&SumC_t="	+ sum;
	
	url  += "&Kv_A="		+ document.getElementById("Kv").value;
	if (document.getElementById("flv").value == 1)
		url += "&Kv_B="		+ document.getElementById("kvk").value;
	else
		url += "&Kv_B="		+ document.getElementById("Kv").value;		

	url += "&Nls_A="		+ document.getElementById("Nls_A").value;
	
	url += "&Nls_B="	+ document.getElementById("textNLS").value;
	url += "&Mfo_B="	+ document.getElementById("textMFO").value;
	url += "&Id_B="	+ document.getElementById("textOKPO").value;
	url += "&Nam_B="	+ document.getElementById("textNMK").value;
	
	var dop_rec = "&RNK=" + document.getElementById("RNK").value;
    dop_rec += "&code=" + Math.random();	
    
    url += dop_rec;
    
    if (document.getElementById("AfterPay").value != null &&
	document.getElementById("AfterPay").value != "")
        url += "&APROC=" + escape(document.getElementById("AfterPay").value);

    if (document.getElementById("BeforePay").value != null &&
	document.getElementById("BeforePay").value != "")
        url += "&BPROC=" + escape(document.getElementById("BeforePay").value);

    window.showModalDialog(encodeURI(url), null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
	
	var textcrossrat = document.getElementById("CrossRat").value;
	if (parseFloat("1.1") == 1)
	    textcrossrat = textcrossrat.replace('.',',');
	else 
        textcrossrat = textcrossrat.replace(',','.');

	var rate = parseFloat(textcrossrat);
	rate = Math.round(rate * 10000) / 10000;
		
	if (document.getElementById("ISCASH").value == '1')
	{
		if (rate == 0 || isNaN(rate))
		{
		    var dpf = ckDPF(document.getElementById("Kv").value, sum, denom);
			if (dpf > 0)
			{
				dpf = Math.round(dpf);
				DPF(dpf, document.getElementById("Kv").value, document.getElementById("dpt_id").value, dop_rec);
			}
		}
		else
		{
		    var dpf = ckDPF(document.getElementById("kvk").value, sum * rate, denom);
			if (dpf > 0)
			{
				dpf = Math.round(dpf);
				DPF(dpf, document.getElementById("kvk").value, document.getElementById("dpt_id").value, dop_rec);
			}
		}
	}
}

// Виплата відсотків по завершенні сроку вкладу
function DepositPercentPay()
{
	var url = "/barsroot/DocInput/DocInput.aspx?";

	url += "tt="		+ document.getElementById("tt").value;		
	url += "&nd="		+ document.getElementById("dpt_id").value;
	
	var denom = parseInt(document.getElementById("denom").value);

	if (document.getElementById("dptPercentToPay_t")) {
	    var editor = igedit_getById("dptPercentToPay");
	    var sum = parseFloat(editor.getNumber());
	    // Сума в цілих одиницях
	    sum = Math.round(sum * denom);
	}
	else {
	    var editor = document.getElementById("dptPercentToPay").value;

	    editor = editor.replace(/ /g, "").replace(/,/g, "").replace(/\./g, "");
	    
	    var sum = parseInt(editor);
	}

	if (document.getElementById("flv").value == 1)
		url += "&SumA_t="	+ sum;
	else
		url += "&SumC_t="	+ sum; 
		
	url += "&Kv_A="		+ document.getElementById("Kv").value;
	if (document.getElementById("flv").value == 1)
		url += "&Kv_B="		+ document.getElementById("kvk").value;
	else
		url += "&Kv_B="		+ document.getElementById("Kv").value;	

	url += "&Nls_A="	+ document.getElementById("Nls_A1").value;

	url += "&Nls_B="	+ document.getElementById("textNLS").value;
	url += "&Mfo_B="		+ document.getElementById("textMFO").value;
	url += "&Id_B="		+ document.getElementById("textOKPO").value;
	url += "&Nam_B="	+ document.getElementById("textNMK").value;	
    
    var dop_rec = "&RNK=" + document.getElementById("RNK").value;
    dop_rec += "&code=" + Math.random();	
    
    if (document.getElementById("AfterPay").value != null &&
	document.getElementById("AfterPay").value != "")
        url += "&APROC=" + escape(document.getElementById("AfterPay").value);

    if (document.getElementById("BeforePay").value != null &&
	document.getElementById("BeforePay").value != "")
        url += "&BPROC=" + escape(document.getElementById("BeforePay").value);

    url += dop_rec;

    window.showModalDialog(encodeURI(url), null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
	
	var textcrossrat = document.getElementById("CrossRat").value;
	if (parseFloat("1.1") == 1)
	    textcrossrat = textcrossrat.replace('.',',');
	else 
        textcrossrat = textcrossrat.replace(',','.');

	var rate = parseFloat(textcrossrat);

	//var rate = parseFloat(document.getElementById("CrossRat").value);
	rate = Math.round(rate * 10000) / 10000;
    
    // Якщо тип рахунку KAS або KAV		
	if (document.getElementById("ISCASH").value == '1')
	{
		if (rate == 0 || isNaN(rate))
		{
		    var dpf = ckDPF(document.getElementById("Kv").value, sum, denom);
			if (dpf > 0)
			{
				dpf = Math.round(dpf);
				DPF(dpf, document.getElementById("Kv").value, document.getElementById("dpt_id").value, dop_rec);
			}
		}
		else
		{
		    var dpf = ckDPF(document.getElementById("kvk").value, sum * rate, document.getElementById("denom").value);
			if (dpf > 0)
			{
				dpf = Math.round(dpf);
				DPF(dpf, document.getElementById("kvk").value, document.getElementById("dpt_id").value, dop_rec);
			}
		}
	}
}

// Перевірка сумми
function CheckSum(etalon,tocheck,larger)
{
    var elem = document.getElementById(tocheck + "_t");
    
    if (elem)
    {
        var _toCheck = igedit_getById(tocheck);
        var SumCheck = _toCheck.getNumber();

        var _Etalon = igedit_getById(etalon);
        var SumEtal = _Etalon.getNumber()
	}
    else
    {
        var elem = document.getElementById(tocheck);

        var _toCheck = document.getElementById(tocheck).value.replace(",", ".").replace(" ", "");
        var SumCheck = parseFloat(_toCheck);

        var _Etalon = document.getElementById(etalon).value.replace(",", ".").replace(" ", "");
        var SumEtal = parseFloat(_Etalon);
	}
	
    if (SumCheck <= 0) {
		alert(LocalizedString('Mes6')/*"Невозможно выполнить операцию."*/ + "\n" + LocalizedString('Mes7')/*"Нулевая сумма!"*/);
		if (!elem.disabled)
		{
			elem.focus();
			elem.select();
		}
		return false;
	}	
	if (larger){
	    if (SumCheck < SumEtal) {
			elem.focus();
			elem.select();
			alert(LocalizedString('Mes8')/*"Сумма меньше минимальной допустимой!"*/);
			return false;
		}
		return true;
	}
	else{
	    if (SumCheck > SumEtal) {
			elem.focus();
			elem.select();
			alert(LocalizedString('Mes9')/*"Сумма больше максимальной допустимой!"*/);
			return false;
		}
		return true;
	}
	
	return true;
}

// Оплата операції викупу центів
function DPF(sum, kv, dpt_id, dop_rec)
{
	var op_name = document.getElementById('dpf_oper').value;
	if (op_name == '' || op_name == "")
		return;
		
	var url = "/barsroot/DocInput/DocInput.aspx?tt="+op_name;
	url += "&nd="		+ dpt_id;
	url += "&Kv_A="		+ kv;
	url += "&Kv_B=980";
	url += "&SumA_t="	+ sum;
	url += dop_rec;
	
	if (document.getElementById('bpp_4_cent') && document.getElementById('bpp_4_cent').value != '' 
	&& document.getElementById('bpp_4_cent').value != "")
	    url += "&APROC=" + document.getElementById('bpp_4_cent').value;
	
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
}
