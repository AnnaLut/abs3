// кросс-браузерные функции

// кросс-браузерная привязка обработчика события к элементу
// событие представлено в виде 'on'+'event', н-р: 'onload', 'onclick'
function CrossAddEventListener(elem,evt,func)
{
	if( elem.addEventListener ) {
		elem.addEventListener(evt.substr(2),func,false);
	}else if ( elem.attachEvent ) {
		elem.attachEvent(evt,func);
	} else {
		elem.evt = func;
	}
}
// кросс-браузерное отвязывание обработчика события от элемента
function CrossRemoveEventListener(elem,evt,func)
{
	if( elem.removeEventListener ) {
		elem.removeEventListener(evt.substr(2),func,false);
	}else if ( elem.detachEvent ) {
		elem.detachEvent(evt,func);
	} else {
		elem.evt = null;
	}
}		

// TreatEnterAsTab - при нажатии Enter генерируем событие нажатия Tab
// т.е. осуществляем переход между контролами при нажатии Enter
function TreatEnterAsTab(evt){
	evt = (evt) ? evt : event;
	var charCode = (evt.charCode)?evt.charCode:((evt.which)?evt.which:evt.keyCode);			
	if(charCode==13){				
		var elem = (evt.target) ? evt.target : ( (evt.srcElement) ? evt.srcElement : null );				
		if(elem){	
		    // Если многострочний ввод, то игнорируем				
		    if(elem.type == "textarea" && elem.id != "Nazn") return true;
			if(event.charCode)  event.which   = 9;
			if(event.which)		event.which   = 9;
			if(event.keyCode)	event.keyCode = 9;					
			elem.fireEvent('onkeydown',event);
			return true;
		}
	}
	return true;
}
// AddListeners - добавляет обработчики к элементам
// cslID - список идентификаторов элементов, разделенных запятой,
//         н-р, "Nls_A,Kv_A,Sum_A,Nls_B,Kv_B,Sum_B"
// evt - событие
// fp - функция-обработчик события
// Пример вызова: AddListeners("ida,idb,idc", 'onkeydown', TreatEnterAsTab)
function AddListeners(cslID, evt, fp){  
	var lst = cslID.split(',');
	for(i=0;i<lst.length;i++)
		if (document.getElementById(lst[i]) != null)
			CrossAddEventListener(document.getElementById(lst[i]),evt,fp);
}

// возвращает код нажатой клавиши/символа
function getCharCode(evt) {
  evt = (evt) ? evt : event;
  var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
	((evt.which) ? evt.which : 0));  
  return charCode;
}

// ограничение ввода только цифрами (без знака минус и запятой)
function numeralsOnly(evt) {
  var charCode = getCharCode(evt);
  if(charCode>31 && (charCode<48 || charCode>57)) {    
    return false;
  }
  return true;
}

// ограничение ввода только цифрами (со знаком минус и запятой)
function decimalOnly(evt) {
  var charCode = getCharCode(evt);
  if( charCode<32 ||
      charCode>44 && charCode>47 ||
      charCode>47 && charCode>58
    ) {
    return true;
  }else{
    return false;
  }
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
