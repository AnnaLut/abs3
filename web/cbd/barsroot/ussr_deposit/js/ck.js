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
// Форкусування контрола
function focusControl(id)
{
	var control = document.getElementById(id);
	if (control.readonly || control.disabled) return;
	control.focus();
}
/// Чи є порожнім значенням
function isNotEmpty(val)
{
	if (val == null || val == ' ' || val == 'null' || val == '' || val == '&nbsp' || val == '&nbsp;' || val == '01/01/0001') 
	    return false;
	return true;
}
function isEmpty(val)
{
	return !isNotEmpty(val);
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
function ckSerial()
{
    // ENTER пускаємо далі
    if (event.keyCode == 13)
    {
        document.getElementById('btSearch').click();        
        return true;
    }
        
    if ((event.keyCode >= 1040 && event.keyCode <= 1071) || event.keyCode == 1025)
        return true;
        
    alert('Допустимими значеннями є лише літери кирилицею у верхньому регістрі!');
    return false;
}
function pressSearch()
{
    // ENTER 
    if (event.keyCode == 13)
    {
        document.getElementById('btSearch').click();        
        return true;
    }
}   