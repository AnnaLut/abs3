var kCapitalLetter = 0;
var kSmallLetter = 1;
var kDigit = 2;
var kPunctuation = 3;
var kAlpha =  4;


//window.attachEvent("onload",DefaultInit);

function DefaultInit()
{
	InitPasswordPolicyParams(6,3,2,'gor',"txtPasswordNew");
	InitAddPolicyParam(document.all.txtUserName,document.all.txtPasswordOld);
}
var oPasswordPolicyParams = new Object();
// Иициализация проверки
function InitPasswordPolicyParams(nPasswordLength,nMaxSeqLength,nCharacterSets,sUserSysName,ID,btnID)
{
	CreateElement(ID);
	// Длинна пароля
	oPasswordPolicyParams.nPasswordLength = nPasswordLength;
	// максимальная допустимая длина повторяющихся симолов или последовалельностей
	oPasswordPolicyParams.nMaxSeqLength = nMaxSeqLength;
	// Количество типов символов: буквы латинского алфавита(a...юz), цифры(0...9) и специальные символы (@!#$....)
	if(nCharacterSets > 3) nCharacterSets = 3;
	oPasswordPolicyParams.nCharacterSets = nCharacterSets;
	// Системное имя пользователя
	oPasswordPolicyParams.arrNames = new Array();
	if(sUserSysName != null && sUserSysName != ""){
		oPasswordPolicyParams.arrNames[oPasswordPolicyParams.arrNames.length] = sUserSysName.toLowerCase()
		oPasswordPolicyParams.arrNames[oPasswordPolicyParams.arrNames.length] = revertStr(sUserSysName.toLowerCase());
	}	
	oPasswordPolicyParams.btnID = btnID;
}

function focusOut()
{
	if(document.getElementById('strongPswDiv'))
		document.getElementById('strongPswDiv').style.visibility = "hidden";
}

function InitAddPolicyParam(elemLogin,elemPsw)
{
	if(document.getElementById('strongPswDiv'))
		document.getElementById('strongPswDiv').style.visibility = "visible";
	// Логин
	if(elemLogin.value != null && elemLogin.value != ""){
		oPasswordPolicyParams.arrNames[oPasswordPolicyParams.arrNames.length] = elemLogin.value.toLowerCase()
		oPasswordPolicyParams.arrNames[oPasswordPolicyParams.arrNames.length] = revertStr(elemLogin.value.toLowerCase());
	}	
		
	// Старый пароль
	oPasswordPolicyParams.sOldPassword = elemPsw.value.toLowerCase();	
}

function EvalPwdStrength(edit){
	var text = edit.value.toLowerCase();
	var errMsg = "";
	var checkLehgth = IsLongEnough(text, oPasswordPolicyParams.nPasswordLength);
	if(!checkLehgth) errMsg += "<li>Довжина пароля повинна бути більше " + oPasswordPolicyParams.nPasswordLength + " символів.\n"
		
	var checkCharSets =  SpansEnoughCharacterSets(text, oPasswordPolicyParams.nCharacterSets);
	if(!checkCharSets) errMsg += "<li>Пароль повинен містити " + oPasswordPolicyParams.nCharacterSets + " типи символів із трьох: букви латинского алфавіту(a..z), цифри(0..9) и спеціальні символи(@!#$....)\n";
	
	var checkUserName = IsNotContainsDefineStr(text,oPasswordPolicyParams.arrNames);
	if(!checkUserName) errMsg += "<li>Пароль не повинен містити ім'я користувача системи або логіна.\n";
	
	var checkSeqRepeat = IsNotContainsRepeatSequence(text,oPasswordPolicyParams.nMaxSeqLength);
	if(!checkSeqRepeat) errMsg += "<li>Пароль містить більше " + oPasswordPolicyParams.nMaxSeqLength + " символів, що повторюються.\n";
	
	var checkDigSequence = IsNotContainsSequence(text,oPasswordPolicyParams.nMaxSeqLength,1);
	if(!checkDigSequence) errMsg += "<li>Пароль містить цифрову послідовність.\n";
	
	var checkCharSequence = IsNotContainsSequence(text,oPasswordPolicyParams.nMaxSeqLength,2);
	if(!checkCharSequence) errMsg += "<li>Пароль містить алфавітну послідовність.\n";
	
	var checkKeyboardSequence = IsNotContainsSequence(text,oPasswordPolicyParams.nMaxSeqLength,3);
	if(!checkKeyboardSequence) errMsg += "<li>Пароль містить клавіатурну послідовність.\n";
	
	var checkDiffPsw = DiffernceBetweenPsw(text,oPasswordPolicyParams.sOldPassword);
	if(!checkDiffPsw) errMsg = "<li>Новий пароль відрізняється від старого менш ніж 3 символами.\n";
	
	var result = checkLehgth && checkCharSets && checkUserName && checkSeqRepeat && checkDigSequence && checkCharSequence && checkKeyboardSequence && checkDiffPsw;
	var vColor = "red";
	if(result){	
		vColor = "green";
		errMsg = "Пароль пройшов перевірку.";
		document.getElementById(oPasswordPolicyParams.btnID).disabled = false;
	}
	else
	{
		vColor = "red";
		document.getElementById(oPasswordPolicyParams.btnID).disabled = true;
	}
    document.getElementById('strongPswDiv').style.color = vColor;
	document.getElementById('messagePswDiv').style.color = vColor;
	document.getElementById('messagePswDiv').style.borderColor = vColor;
	document.getElementById('messagePswDiv').innerHTML = errMsg;
}

function CharacterSetChecks(type, fResult){
	this.type = type;
	this.fResult = fResult;
}

// Проверка типа символа
function isctype(character, type){
	var fResult = false;
	switch(type){
		case kCapitalLetter:
		if((character >= 'A') && (character <= 'Z')){
			fResult = true;
		}
		break;
		case kSmallLetter:
		if ((character >= 'a') && (character <= 'z')){
			fResult = true;
		}
		break;
		case kDigit:
		if ((character >= '0') && (character <= '9')){
			fResult = true;
		}
		break;
		case kPunctuation:
		if ("!@#$%^&*()_+-='\";:[{]}\|.>,</?`~".indexOf(character) >= 0){
			fResult = true;
		}
		break;
		case kAlpha:
		if (isctype(character, kCapitalLetter) || isctype(character, kSmallLetter)){
			fResult = true;
		}
		break;
		default:
		break;
	}
	return fResult;
}

//Елементы отображения
function CreateElement(ID)
{
	if(document.getElementById('strongPswDiv') == null){
		document.body.insertBefore(document.createElement("<div id=strongPswDiv title=\"Индикатор нетривиальности пароля\""+
	 	     "style=\"visibility:hidden;cursor:arrow;font-family:Verdana;font-weight:bold;font-size:12pt;color:red;border-width:1;BORDER-STYLE: solid;border-color:navy;"+
	 	     "z-index:100;width:48px;position:absolute;"+
	 	     "left:expression(document.all."+ID+".offsetLeft+document.all."+ID+".offsetWidth+4);"+
	 	     "top:expression(document.all."+ID+".offsetTop-3);\"></div>"));
	   
	   document.body.insertBefore(document.createElement("<div id=messagePswDiv "+
	 	     "style=\"visibility:hidden;font-family:Verdana;font-weight:normal;font-size:8pt;background-color:white;color:red;border-width:1;BORDER-STYLE:solid;border-color:red;"+
	 	     "z-index:100;width:300px;position:absolute;"+
	 	     "left:expression(document.all."+ID+".offsetLeft+document.all."+ID+".offsetWidth+4);"+
	 	     "top:expression(document.all."+ID+".offsetTop+20);\"></div>"));
	   
	   document.getElementById('strongPswDiv').innerHTML = "[!]&nbsp;<input title='Показати детальну інформацію' onclick='clickBtn(this)' type=button style='height:22px' value='>'>";
	}
}

function clickBtn(btn)
{
	if(btn.value == ">")
	{
		btn.value = "<";
		document.getElementById('messagePswDiv').style.visibility = "visible";
		btn.title = "Сховати детальну інформацію";
	}
	else
	{
		btn.value = ">";
		document.getElementById('messagePswDiv').style.visibility = "hidden";
		btn.title = "Показати детальну інформацію";
	}
}

function revertStr(str)
{
	var strLen = str.length - 1;
	var flush = "";
	for(i = strLen; i > -1; i--) 
		flush += str.charAt(i);
	return(flush);
} 


var digit_seq = '012345678987654321';
var char_seq = 'abcdefghijklmnopqrstuvwxyzyxwvutsrqponmlkjihgfedcba';
var keyboard_seq = "qwertyuiop[]asdfghjkl;''zxcvbnm,./.,mnbvcxz'';lkjhgfdsa][poiuytrewq";
function IsNotContainsRepeatSequence(strWord,nSeqLength)
{
   var index = 0;
   var prevChar,currChar,nCurSeqLen = 0;
   for(index = 0; index < strWord.length; index++ )
   {
   	   prevChar = currChar;
   	   currChar = strWord.charAt(index);
   	   if(prevChar){
   	   	   if(currChar == prevChar){
   	   	      nCurSeqLen ++;
   	   	   	  if(nCurSeqLen >= nSeqLength) return false;
   	   	      
   	   	   }
   	   	   else 
   	   	   	  nCurSeqLen = 0;
   	   }
   }
   return true;
}

function DiffernceBetweenPsw(newPsw,oldPsw)
{
	if(oldPsw.length - newPsw.length > 0) return true;
	var diff = newPsw.length - oldPsw.length;
	var index = 0;
    if (diff < 3){
    	for(index = 0; index < Math.min(newPsw.length,oldPsw.length); index++){
    		if(newPsw.charAt(index) != oldPsw.charAt(index)) 
    			diff ++; 
    	}
    }
	if (diff < 3) return false;
    return true;
}

function IsNotContainsSequence(strWord,nSeqLength,type)
{
   if(strWord.length < nSeqLength ) return true;
   var index = 0;
   var cur_seq;
   switch(type)
   {
   	   case 1 : cur_seq = digit_seq;break;
   	   case 2 : cur_seq = char_seq;break;
   	   case 3 : cur_seq = keyboard_seq;break;
   }
   for(index = 0; index < cur_seq.length; index++)
   {
      cur_seq = cur_seq.substr(1) + cur_seq.substr(0,1);
	  if(strWord.indexOf(cur_seq.substr(0,nSeqLength)) > 0){return false;}
   }
   return true;
}

function IsNotContainsDefineStr(strWord,strs)
{
	var index = 0;
	for(index = 0; index < strs.length; index++)
	{
		if(strWord.indexOf(strs[index]) >= 0) return false;
	}
	return true;
}
function r(txt)
{
	document.getElementById("txtUserName").value = txt;
}
function IsLongEnough(strWord, nAtLeastThisLong){
	if ((strWord == null) || isNaN(nAtLeastThisLong)){
		return false;
	}
	else if (strWord.length < nAtLeastThisLong){
		return false;
	}
	return true;
}
function SpansEnoughCharacterSets(strWord, nAtLeastThisMany){
	var nCharSets = 0;
	var characterSetChecks = new Array(
	new CharacterSetChecks(kCapitalLetter, false),
	new CharacterSetChecks(kSmallLetter, false),
	new CharacterSetChecks(kDigit, false),
	new CharacterSetChecks(kPunctuation, false)
	);
	if ((strWord == null) || isNaN(nAtLeastThisMany)){
		return false;
	}
	for(var index = 0; index < strWord.length; index++){
		for(var nCharSet = 0; nCharSet < characterSetChecks.length;nCharSet++){
			if (!characterSetChecks[nCharSet].fResult && isctype(strWord.charAt(index), characterSetChecks[nCharSet].type)){
				characterSetChecks[nCharSet].fResult = true;
				break;
			}
		}
	}
	for(var nCharSet = 0; nCharSet < characterSetChecks.length;nCharSet++){
		if (characterSetChecks[nCharSet].fResult){
			nCharSets++;
		}	
	}
	if (nCharSets < nAtLeastThisMany){
		return false;
	}
	return true;
}