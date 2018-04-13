/// Застосувати до контрола функцію перевірки на числове значення
function applyNumFunc(control_id)
{
    document.getElementById(control_id).attachEvent("onkeydown",doNum);
}
/// Застосувати до контрола функцію перевірки на буквене значення
function applyAlphaFunc(control_id)
{
    document.getElementById(control_id).attachEvent("onkeydown",doAlpha);
}
/// Застосувати до контрола функцію перевірки на буквено - числове значення
function applyNumAlphaFunc(control_id)
{
    document.getElementById(control_id).attachEvent("onkeydown",doNumAlpha);
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
// Перевірка рахунку по МФО
function ckNLS(nls,mfo)
{ 
  var e1 = document.getElementById(nls);
  var e2 = document.getElementById(mfo);

  if (isEmpty(e1.value) || isEmpty(e2.value)) return true;
  
  if ( e1.value != cDocVkrz(e2.value,e1.value) ) 
  {
	alert('Неверный контрольный разряд!');
	setFocus1(e1.name); 
	return false;
  }
  
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
