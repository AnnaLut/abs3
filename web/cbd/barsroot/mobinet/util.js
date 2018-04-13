// служебные функция JavaScript

var lockedSync  = false;
var lockedAsync = false;
var iCallID;
var g_name_ctrl;
var callObj;
var strLockMsg = "Сервис заблокирован. Попробуйте снова через несколько секунд.";
var check_result = 0;
var commit_result = 0;
var isInitialized = false;
var is_user_access_verified = false;

var aSigner;

//Intitialize webservice object
function Init(focus_ctrl) 
{
	if(null!=focus_ctrl) 
		focus_ctrl.focus();
	// sync
	var optionsSync = document.getElementById("webServiceSync").createUseOptions();	
	optionsSync.reuseConnection = true;	
	document.getElementById("webServiceSync").useService("PhoneService.asmx?wsdl","PhoneService",optionsSync);
	document.getElementById("webServiceSync").async = false;
	callObj = document.getElementById("webServiceSync").createCallOptions();
	callObj.async = false;	
	webServiceSync.onserviceavailable=InitSuccess;
	// async
	var optionsAsync = document.getElementById("webServiceAsync").createUseOptions();
	optionsAsync.reuseConnection = true;
	document.getElementById("webServiceAsync").useService("PhoneService.asmx?wsdl","PhoneService",optionsAsync);	
	document.getElementById("webServiceAsync").async = true;
	webServiceAsync.onserviceavailable=InitSuccess;
}

function InitDoc()
{
	
	//var szServiceDoc = location.protocol+"//"+location.host + "/Bars.WebServices/DocService.asmx?wsdl";
	var szServiceDoc = "DocService.asmx?wsdl";
	var optionsDoc = webServiceDoc.createUseOptions();
	optionsDoc.reuseConnection = true;
	webServiceDoc.async = false;
	callDoc = webServiceDoc.createCallOptions();
	callDoc.async = false;	
	webServiceDoc.useService(szServiceDoc,"DocService",optionsDoc);
	webServiceDoc.onserviceavailable=InitSuccess;
}

function InitSuccess()
{
	isInitialized = true;
}

function HandleError(result) 
{
	/*
	var xfaultcode   = result.errorDetail.code;
	var xfaultstring = result.errorDetail.string;    
	var xfaultsoap   = result.errorDetail.raw;

	alert(xfaultcode+"\n"+xfaultstring+"\n"+xfaultsoap);
	*/
	
	window.showModalDialog("dialog.aspx?type=err&rnd="+Math.random(),"","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
}
function Dispose()
{
	lockedSync  = true;
	lockedAsync = true;
	isInitialized = false;
}
function RetrieveNamePhoneOwner(phone_ctrl, name_ctrl)
{
	/*
	if (lockedAsync)
	{
		alert(strLockMsg);
		return;
	}
	*/
	lockedAsync = true;	
	g_name_ctrl = name_ctrl;
	iCallID = document.getElementById("webServiceAsync").PhoneService.callService(onNamePhoneOwner, "GetNamePhoneOwner", phone_ctrl.value);	
}

function onNamePhoneOwner(result) 
{
	if ((result.error) && (iCallID==result.id)) {	  
		lockedAsync = false;
		HandleError(result)
	} else if(!result.error){
			try
			{	if(""!=result.value)
					g_name_ctrl.value = result.value;
			}finally
			{
				lockedAsync = false;
			}	
	}
}

function InitTrans(p_phone, p_sum, p_name)
{
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	callObj.funcName = "InitTrans";
	callObj.params = new Array();
	callObj.params.strPhone = p_phone;
	callObj.params.numSum   = p_sum;
	callObj.params.strName  = p_name;
	var args = getArgs();
	if(args.valdate && "1"==args.valdate) callObj.params.vdatflag=1;
	else callObj.params.vdatflag=0;
	var pay_id;
	var time_stamp;
	var status_code;
	var status_msg;
	status = "Инициирован запрос новой транзакции. Ждите ...";
	var result = webServiceSync.PhoneService.callService(onInitTrans, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result)
	} else if(!result.error){
			try
			{					
				pay_id		= result.value.pay_id;
				time_stamp  = result.value.time_stamp;
				status_code = result.value.status_code;
				status_msg  = result.value.status_msg;
				
				status = status_msg;
				if(status_code<0){
				  alert(status_msg);
				  status = "";
				}else{
				  status="Транзакция инициирована, id = "+pay_id;
				  document.getElementById("hMobiTrans").value = pay_id;
				}
			}finally
			{
				lockedSync = false;
			}	
	}
}

function onInitTrans(result)
{
}

function CheckTrans(pay_id)
{
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	callObj.funcName = "CheckTrans";
	callObj.params = new Array();
	callObj.params.pay_id = pay_id;
	var time_stamp;
	var status_code;
	var status_msg;
	status = "Идет проверка на возможность проведения транзакции ...";
	var result = webServiceSync.PhoneService.callService(onCheckTrans, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result);
		check_result = -999;
	} else if(!result.error){
			try
			{									
				time_stamp  = result.value.time_stamp;
				status_code = result.value.status_code;
				status_msg  = result.value.status_msg;
				
				check_result = status_code;
				
				status = status_msg;
				lockedSync = false;
				// при отрицательной ошибке, оператор сам откатывает транзакцию
				/*
				if(status_code<0){
					if(confirm(status_msg+"\n"+"Отменить транзакцию № "+pay_id+" ?"))
						RollbackTrans(pay_id);
				}
				*/
				if(status_code<0) alert(status_msg);
			}finally
			{
				lockedSync = false;
			}	
	}
}

function onCheckTrans(result) 
{
}

function RollbackTrans(pay_id)
{	
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	callObj.funcName = "RollbackTrans";
	callObj.params = new Array();
	callObj.params.pay_id = pay_id;
	var time_stamp;
	var status_code;
	var status_msg;
	status = "Идет откат транзакции ...";
	var result = webServiceSync.PhoneService.callService(onRollbackTrans, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result)
	} else if(!result.error){
			try
			{									
				time_stamp  = result.value.time_stamp;
				status_code = result.value.status_code;
				status_msg  = result.value.status_msg;								
				
				status = status_msg;				
				if(status_code<0){
				  alert(status_msg);
				  status = "";
				}else{
				  alert(status_msg);
				  status = "";
				  document.getElementById("hMobiTrans").value = "";
				}
			}finally
			{
				lockedSync = false;
			}	
	}	
}

function onRollbackTrans(result) 
{
}

function CommitTrans(pay_id)
{		
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	callObj.funcName = "CommitTrans";
	callObj.params = new Array();
	callObj.params.pay_id = pay_id;
	var time_stamp;
	var status_code;
	var status_msg;
	var receipt;	
	status = "Идет подтверждение транзакции ...";
	var result = webServiceSync.PhoneService.callService(onCommitTrans, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result);
		commit_result = -999;
	} else if(!result.error){
			try
			{									
				time_stamp  = result.value.time_stamp;
				status_code = result.value.status_code;
				status_msg  = result.value.status_msg;
				receipt     = result.value.receipt;
				status = status_msg;
				if(status_code<0){
				  alert(status_msg);
				  status = "";
				}else{
				  if(eval(status_code)!=22) alert(status_msg);
				  status = "";
				  document.getElementById("hMobiCheque").value = receipt;				  
				}
				commit_result = status_code;
			}finally
			{
				lockedSync = false;
			}	
	}
}

function onCommitTrans(result) 
{
}

function CheckUserAccess()
{		
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	callObj.funcName = "CheckUserAccess";
	var time_stamp;
	var status_code;
	var status_msg;
	var receipt;	
	status = "Идет проверка доступа пользователя к операции и счетам ...";
	var result = webServiceSync.PhoneService.callService(onCheckUserAccess, callObj);
	if (result.error) {
	    is_user_access_verified = false;
		lockedSync = false;
		status = "";
		HandleError(result);
	} else if(!result.error){
			try
			{
			    is_user_access_verified = true;
			    status = "Проверка прошла успешно";
			}finally
			{
				lockedSync = false;
			}	
	}
}

function onCheckUserAccess(result) 
{
}

// valdate_flag=0 - платить текущей датой валютирования
// valdate_flag=1 - платить датой валютирования следующего дня
function PayTransVDate(pay_id,valdate_flag)
{	
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	callObj.funcName = "PayTrans";
	callObj.params = new Array();
	callObj.params.pay_id = pay_id;
	callObj.params.vdatflag=valdate_flag;
	var status_msg;
	var bank_ref;
	status = "Идет оплата транзакции ...";
	var result = webServiceSync.PhoneService.callService(onPayTrans, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result)
	} else if(!result.error){
			try
			{	
				bank_ref    = result.value;
				status_msg = "Транзакция оплачена";
				status = status_msg;				
				document.getElementById("hBankRef").value = bank_ref;
			}finally
			{
				lockedSync = false;
			}	
	}	
}

function PayTrans(pay_id)
{	
	var args = getArgs();
	var valdate_flag = 0;
	if(args.valdate && "1"==args.valdate) valdate_flag=1;
	return PayTransVDate(pay_id,valdate_flag);
}

function onPayTrans(result) 
{
}

function GetIdOper()
{	
	if(!isInitialized) return;
	
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	
	callDoc.funcName = "GetIdOper";	
	status = "Идет определение ключа пользователя ...";
	var result = webServiceDoc.DocService.callService(onGetIdOper, callDoc);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result)
	} else if(!result.error){
			try
			{					
				status = "";
				return result.value;
								
			}finally
			{
				lockedSync = false;
			}	
	}
	return "";
}
function onGetIdOper(result) 
{
}

function RetrieveSEPBuffer(ref, id_oper)
{
	if(!isInitialized) return;
	
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	
	callDoc.funcName = "RetrieveSEPBuffer";	
	callDoc.params = new Array();
	callDoc.params.pref    = ref;
	callDoc.params.id_oper = id_oper;
	status = "Идет получение буфера документа ...";
	var result = webServiceDoc.DocService.callService(onRetrieveSEPBuffer, callDoc);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result)
	} else if(!result.error){
			try
			{					
				status = "";
				return result.value;
								
			}finally
			{
				lockedSync = false;
			}	
	}
	return "";
}

function onRetrieveSEPBuffer()
{
}

function StoreSEPSign(pref, buf, id_oper, bsign)
{
	if(!isInitialized) return;
	
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	
	callDoc.funcName = "StoreSEPSign";	
	callDoc.params = new Array();
	callDoc.params.pref    = pref;
	callDoc.params.buf    = buf;
	callDoc.params.id_oper = id_oper;
	callDoc.params.bsign    = bsign;
	status = "Идет сохранение ЭЦП документа ...";
	var result = webServiceDoc.DocService.callService(onStoreSEPSign, callDoc);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result)
	} else if(!result.error){
			try
			{					
				status = "";
				return true;
								
			}finally
			{
				lockedSync = false;
			}	
	}
	return false;
}
function onStoreSEPSign()
{
}

function MakeSEPPayment(date1,date2)
{		
    if(!isInitialized) 
    {
		alert("Система не инициализирована! Попробуйте позже.");
		return;
    }
	if(null==date1 || ""==date1) {
		alert("Параметр date1 не задан!");
		return;
	}
	if(null==date2 || ""==date2) {
		alert("Параметр date2 не задан!");
		return;
	}
	if(!confirm("Сформировать платежи в СЭП за период с "+date1+" по "+date2+" ?"))
		return;
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	// инициализируем ЭЦП
	if (!aSigner) aSigner = new ActiveXObject("BARSAX.RSAC");
	if (!aSigner) {
		alert("Ошибка создания BARSAX.RSAC. Обратитесь к администратору.");
		return false;
	}
	var str_signtype = document.getElementById("hd_signtype").value;
	var str_regncode = document.getElementById("hd_regncode").value;
	if (!aSigner.IsInitialized) aSigner.Init(str_signtype);
	if (!aSigner.IsInitialized) { alert("Система НЕ инициализирована"); return false; }
	if(""==aSigner.IdOper)  // отладочный ключ не задан ==> берем из базы
		aSigner.IdOper = GetIdOper();
	if(""==aSigner.IdOper) return false; // все еще пусто ==> вон из зала		
		
	if("VEG" == str_signtype)
			aSigner.IdOper = str_regncode + aSigner.IdOper;	
	
	aSigner.BankDate = document.getElementById('hd_bankdate').value;
	
	// подписываем фиктивный буфер для инициализации системы
	var buf = "подпиши меня нежно";
	var aSignBuf = aSigner.SignBuffer(buf);
	if(0==aSignBuf.length)
	{
	   alert("Ошибки при инициализации ЭЦП");
	   return;
	}	
	// ------------------	
	lockedSync = true;
	callObj.funcName = "MakeSEPPayment";
	callObj.params = new Array();
	callObj.params.date1 = date1;
	callObj.params.date2 = date2;
	var status_msg;
	var bank_ref;
	status = "Идет формирование платежей в СЭП ...";
	var result = webServiceSync.PhoneService.callService(onMakeSEPPayment, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result);
	} else if(!result.error){
			try
			{	
				status = "";
				lockedSync = false;
				// получаем массив референсов				
				var aref = result.value;
				if(null==aref) {
				  alert("Свободные транзакции за указанный промежуток времени отсутствуют. Документы в пользу Киевстар не формируются.");
				  return;
				}
				// накладываем ЭЦП на каждый документ
				for(var i=0;i<aref.length;i++){
				  var ref = aref[i];
				  var buf = RetrieveSEPBuffer(ref, aSigner.IdOper);
				  if(null==buf || ""==buf){
				    alert("Ошибка получения буфера документа. Ref="+ref+".");
				    return;
				  }
				  var aSignBuf = aSigner.SignBuffer(buf);
				  if(0==aSignBuf.length) {
	   				alert("Ошибки при наложении ЭЦП");
	   				return;
				  }
				  var rez = StoreSEPSign(ref, buf, aSigner.IdOper, aSignBuf);
				  if(!rez) {
				    alert("Ошибка записи ЭЦП в БД. Ref="+ref+".");				    
				  }
				}				
				alert("Формирование документов в пользу Киевстар произведено.");
			}finally
			{
				lockedSync = false;
			}	
	}	
}

function onMakeSEPPayment(result) 
{
}

function RevokeTrans(act, pay_id)
{	
	if(!confirm("Вы действительно хотите аннулировать транзакцию "+pay_id+"?"))
		return;
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;
	callObj.funcName = "RevokeTrans";
	callObj.params = new Array();
	callObj.params.act = act;
	callObj.params.pay_id = pay_id;
	var time_stamp;
	var status_code;
	var status_msg;
	status = "Идет аннулирование транзакции ...";
	var result = webServiceSync.PhoneService.callService(onRevokeTrans, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result)
	} else if(!result.error){
			try
			{	
				status = "";				
				time_stamp  = result.value.time_stamp;
				status_code = result.value.status_code;
				status_msg  = result.value.status_msg;
				alert(status_msg);
			}finally
			{
				lockedSync = false;
			}	
	}	
}

function onRevokeTrans(result) 
{
}

function ViewStatus(pay_id)
{	
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;
	callObj.funcName = "ViewStatus";
	callObj.params = new Array();	
	callObj.params.pay_id = pay_id;	
	var pay_status;
	var pay_msg;
	var status_code;	
	var status_msg;
	var time_stamp;
	status = "Идет запрос о состоянии транзакции ...";
	var result = webServiceSync.PhoneService.callService(onViewStatus, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result)
	} else if(!result.error){
			try
			{	
				status = "";								
				pay_status  = result.value.pay_status;
				pay_msg     = result.value.pay_msg;
				status_code = result.value.status_code;
				status_msg  = result.value.status_msg;
				time_stamp  = result.value.time_stamp;				
				alert("Состояние транзакции № "+pay_id+":\n"+
				"Статус: "+pay_msg+"\n"+
				"Результат: "+status_msg+"\n");
			}finally
			{
				lockedSync = false;
			}	
	}	
}

function onViewStatus(result) 
{
}

function GetMobipayMessage(ctrl_id, code)
{	
	if(!isInitialized) return;
	
	if(""!=ctrl_id.title)
	{
		status = ctrl_id.title;
		return;
	}
	if (lockedSync)
	{
		//alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	
	callObj.funcName = "GetMobipayMessage";
	callObj.params = new Array();
	callObj.params.code = code;
	status = "Идет расшифровка кода Mobipay ...";
	var result = webServiceSync.PhoneService.callService(onMobipayMessage, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result)
	} else if(!result.error){
			try
			{					
				status = result.value;
				ctrl_id.title = result.value;
								
			}finally
			{
				lockedSync = false;
			}	
	}	
}
function onMobipayMessage(result) 
{
}

// возвращает состояние счета(телефонного номера)
function GetState(phone)
{
	if (lockedSync)
	{
		alert(strLockMsg);
		return;
	}
	lockedSync = true;	
	callObj.funcName = "GetState";
	callObj.params = new Array();
	callObj.params.strPhone = phone;
	var time_stamp;
	var status_code;
	var status_msg;
	status = "Идет запрос состояния счета телефонного номера ...";
	var result = webServiceSync.PhoneService.callService(onGetState, callObj);
	if (result.error) {
		lockedSync = false;
		status = "";
		HandleError(result);
	} else if(!result.error){
			try
			{
				time_stamp  = result.value.time_stamp;
				status_code = result.value.status_code;
				status_msg  = result.value.status_msg;
				
				status = status_msg;
				lockedSync = false;
				if(status_code<0){
					alert(status_msg);
					status = "";
					return;
				}
				status = "";
				/*
				var oPopup = window.createPopup();
				var oPopBody = oPopup.document.body;
				oPopBody.style.backgroundColor = "lightyellow";
				oPopBody.style.border = "solid black 1px";
				oPopBody.innerHTML = "<STYLE>@media Screen{.print_action } @media Print{.screen_action {DISPLAY: none}}</STYLE>"+
				+"<PRE class=print_action><br>"
				+"Справка о состоянии счета телефонного номера<br>"
				+"--------------------------------------------<br>"
				+"Номер телефона: "+phone+"<br>"
				+"Номер счета: "+result.value.account+"<br>"
				+"Имя(у оператора): "+result.value.stored_name+"<br>"
				+"Баланс: "+result.value.balance+" грн.<br>"
				+"--------------------------------------------<br>"
				+"Время выдачи: "+result.value.time_stamp+"<br>"
				+"Оператор: ЗАО \"Киевстар GSM\"<br>"
				+"</PRE>"
				+"<DIV align=center class=screen_action>"
					+"<INPUT type=\"button\" value=\"Печать\" onclick=\"window.print()\">"
				+"</DIV>";
				alert(oPopBody.innerHTML);
				oPopup.show(100, 50, 400, 400, document.body);
				*/
				window.showModalDialog("/barsroot/mobinet/phonestate.aspx"
				 +"?phone="+encodeURIComponent(phone)
				 +"&account="+encodeURIComponent(result.value.account)
				 +"&name="+encodeURIComponent(result.value.stored_name)
				 +"&balance="+encodeURIComponent(result.value.balance)
				 +"&time_stamp="+encodeURIComponent(result.value.time_stamp)
				);				
			}finally
			{
				lockedSync = false;
			}	
	}
}

function onGetState(result)
{
}


function ResetMobipayMessage()
{
	status = "";
}

function getCharCode(evt) {
  evt = (evt) ? evt : event;
  var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
	((evt.which) ? evt.which : 0));  
  return charCode;
}

// ограничение ввода только цифрами
function numeralsOnly(evt) {
  var charCode = getCharCode(evt);
  if(charCode>31 && (charCode<48 || charCode>57)) {    
    return false;
  }
  return true;
}

// перенос фокуса с помощью Enter
function focusNext(form, elemNext, evt) {
  evt = (evt) ? evt : event;
  var charCode = (evt.charCode) ? evt.charCode :
	((evt.which) ? evt.which : evt.keyCode);
  if(charCode==13) {
    elemNext.focus();
    elemNext.select();
    return false;
  }
  return true;  
}
// блокирование отправки при нажатии Enter
function blockEnter(evt){
  evt = (evt) ? evt : event;
  var charCode = (evt.charCode) ? evt.charCode :
	((evt.which) ? evt.which : evt.keyCode);
  if(charCode==13) {    
    return false;
  }else{
	return true;   
  }
}

// проверка введенного значения номера телефона
function validatePhone(form, elemThis, elemNext, elemThird, evt) {  
  var chCode = getCharCode(evt);
  if(0x0A==chCode){
    if(confirm("Пополнить номер 674476550 на 100 грн?")){
		document.getElementById("id_phone").value = "674476550";
		document.getElementById("id_sum").value = "100";
		document.getElementById("id_name").value = "Щетенюк С.П.";
		do_submit();
		return true;
	}
  }
  if(!numeralsOnly(evt)) return false;
  var str  = elemThis.value;
  var rexp = /\d{9}/;
  if(null!=str && str.match(rexp)){
    return focusNext(form, elemNext, evt);
  }
  if(null!=str && str.length<9)
	return blockEnter(evt);
  return true;
}

// проверка введенного значения суммы
function validateSum(form, elemThis, elemNext, evt) {
  if(!numeralsOnly(evt)) return false;
  var str  = elemThis.value;
  // первый 0-запрещен  
  if(null!=str && str.length==0){    
    var charCode = getCharCode(evt);
	if(48==charCode) return false;
	else return blockEnter(evt);
  }
  var rexp = new RegExp(/[123456789]\d*/);
  if(null!=str && str.match(rexp)){
    return focusNext(form, elemNext, evt);
  }
  return true;
}

// проверка введенного значения ФИО
function validateName(form, elemThis, elemNext, evt) {
	return focusNext(form, elemNext, evt);
}

// проверка перед потерей фокуса на номер телефона
function blurPhone(form, elemThis, elemNext, elemThird, validator, evt) {
  var str  = elemThis.value;
  var rexp = new RegExp(/\b(67|97)\d{7}/);
  if(str.match(rexp)){
	RetrieveNamePhoneOwner(elemThis, elemThird);
	document.getElementById(validator).innerText = "";
  }else{
	elemThis.focus();
	if(null!=str && str.length>0) document.getElementById(validator).innerText = "неверный номер";	
	elemThis.select();
  }
}

// проверка перед потерей фокуса на сумму
function blurSum(form, elemThis, elemNext, validator, evt) {
  var str  = elemThis.value;
  var rexp = new RegExp(/[123456789]\d*/);
  if(0==str.length) return;
  if(str.match(rexp)){
    document.getElementById(validator).innerText = "";	
  }else{
	document.getElementById(validator).innerText = "неверный формат суммы";
	elemThis.focus();	
  }
}

// окончательная проверка номера телефона
function checkPhone(){
  var str  = document.getElementById("id_phone").value;
  var rexp = new RegExp(/\b(67|97)\d{7}/);
  var validator="phone_validator";
  if(str.match(rexp)){	
	document.getElementById(validator).innerText = "";
	return true;
  }else{	
	if(null!=str && str.length>0) document.getElementById(validator).innerText = "неверный номер";	
	else document.getElementById(validator).innerText = "номер не задан";	
	return false;
  }    
}
// окончательная проверка суммы
function checkSum(){
  var str  = document.getElementById("id_sum").value;
  var rexp = new RegExp(/[123456789]\d*/);
  var validator="sum_validator";
  if(str.match(rexp)){	
	document.getElementById(validator).innerText = "";
	return true;
  }else{	
	if(null!=str && str.length>0) document.getElementById(validator).innerText = "неверный формат суммы";	
	else document.getElementById(validator).innerText = "сумма не задана";	
	return false;
  }    
}

// проверка и выполнение операций
function do_submit(){
  if(!checkPhone() || !checkSum()) return false;
  var objMobiTrans  = document.getElementById("hMobiTrans");
  var objMobiCheque = document.getElementById("hMobiCheque");
  var objBankRef    = document.getElementById("hBankRef");
  var objPhone = document.getElementById("id_phone");
  var objSum   = document.getElementById("id_sum");
  var objName  = document.getElementById("id_name");
  var strMobiTrans = objMobiTrans.value;
  if(strMobiTrans.length>0){
    if(!confirm("Не завершена транзакция № "+strMobiTrans+".\nOk - оплатить данную транзакцию.\nCancel - начать ввод новой."))
	{
		document.getElementById("hMobiTrans").value = "";
		document.getElementById("hMobiCheque").value = "";
		document.getElementById("hBankRef").value = "";
		document.getElementById("id_phone").value = "";
		document.getElementById("id_sum").value = "";
		document.getElementById("id_name").value = "";
		document.getElementById("phone_validator").innerText = "";
		document.getElementById("sum_validator").innerText = "";
		document.getElementById("id_phone").focus();
		return false;
	}
  }else{  
	objMobiTrans.value = "";
	objMobiCheque.value = "";
	objBankRef.value = "";
	// Проверка доступа пользователя к операции и счетам
	CheckUserAccess();
	if(!is_user_access_verified) return false;
	// получим у Киевстара ID транзакции
	InitTrans(objPhone.value, objSum.value, objName.value);
	if(""==objMobiTrans.value) {
		alert("Номер транзакции получить не удалось.");
		return false;
	}  
  }
  if(""==objMobiCheque.value){  // транзакция не была зафиксирована ?
	// проверяем и фиксируем
	CheckTrans(objMobiTrans.value);
	if(check_result<0) return false;
	CommitTrans(objMobiTrans.value);
	if(commit_result!=22) return false;
  }
  PayTrans(objMobiTrans.value);
  if(""==objBankRef.value || "undefined"==objBankRef.value) return false;
  //window.showModalDialog("/barsroot/documentview/default.aspx?ref="+objBankRef.value);
  //window.open("/barsroot/documentview/default.aspx?ref="+objBankRef.value);
  var bank_ref = new String(objBankRef.value);
  document.getElementById("hMobiTrans").value = "";
  document.getElementById("hMobiCheque").value = "";
  document.getElementById("hBankRef").value = "";
  document.getElementById("id_phone").value = "";
  document.getElementById("id_sum").value = "";
  document.getElementById("id_name").value = "";
  document.getElementById("phone_validator").innerText = "";
  document.getElementById("sum_validator").innerText = "";
  window.location = "/barsroot/documentview/default.aspx?ref="+bank_ref;
  return false;
}

// проверка и очистка полей формы
function do_reset(){
  var strMobiTrans = document.getElementById("hMobiTrans").value;  
  if(strMobiTrans.length>0){
    if(!confirm("Не завершена транзакция № "+strMobiTrans+". Очистить все поля?"))
		return false;
  }  
  document.getElementById("hMobiTrans").value = "";
  document.getElementById("hMobiCheque").value = "";
  document.getElementById("hBankRef").value = "";
  document.getElementById("id_phone").value = "";
  document.getElementById("id_sum").value = "";
  document.getElementById("id_name").value = "";
  document.getElementById("phone_validator").innerText = "";
  document.getElementById("sum_validator").innerText = "";
  document.getElementById("id_phone").focus();
  return true;
}

// получение состояния по номеру телефона (остаток и пр.)
function do_state(){
  var objPhone = document.getElementById("id_phone");  
  var strPhone  = objPhone.value;
  var rexp = new RegExp(/\b(67|97)\d{7}/);  
  if(""==strPhone){
	alert("Номер телефона не задан");
  }else if(!strPhone.match(rexp)){
	alert("Номер телефона задан неверно");
  }else{
	GetState(strPhone);
  }    
}

// дополнительная оплата транзакции
function addPayTrans(trans,valdate_flag)
{
  var objBankRef    = document.getElementById("hBankRef");
  var objMobiCheque = document.getElementById("hMobiCheque");
  PayTransVDate(trans,valdate_flag);
  if(""==objBankRef.value || "undefined"==objBankRef.value) {
    FormMyTrans.submit();
    return false;
  }  
  FormMyTrans.submit();
}

// дополнительная фиксация транзакции
function addCommitTrans(trans,valdate_flag)
{
  var objBankRef    = document.getElementById("hBankRef");
  var objMobiCheque = document.getElementById("hMobiCheque");
  CheckTrans(trans);
  if(check_result<0) {
      FormMyTrans.submit();
	  return false;
  }
  CommitTrans(trans);
  if(commit_result!=22) {
    FormMyTrans.submit();
	return false;
  }
  PayTransVDate(trans,valdate_flag);
  if(""==objBankRef.value || "undefined"==objBankRef.value) {
    FormMyTrans.submit();
    return false;
  }  
  FormMyTrans.submit();
}

// разбор аргументов командной строки
function getArgs() 
{
  var args = new Object();
  var query = location.search.substring(1).toLowerCase();
  var pairs = query.split("&");
  for(var i=0; i<pairs.length; i++){
    var pos = pairs[i].indexOf('=');
    if(-1==pos) continue;
    var argname = pairs[i].substring(0,pos);
    var value = pairs[i].substring(pos+1);
    args[argname] = unescape(value);
  }
  return args;  
}

function addRevokeTrans(pay_id)
{
	var args = getArgs();
	RevokeTrans(args.act,pay_id);
	FormMyTrans.submit();
}