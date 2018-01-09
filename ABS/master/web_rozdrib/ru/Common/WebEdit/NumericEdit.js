var controls = new Array();
var dot = (parseFloat("1.1") == 1)?(","):(".");
var comma = (dot == ".")?(","):(".");
function ParseF(val)
{
  return parseFloat(val.replace(comma,dot));
}

//only digits
function init_num(id)
{
 document.getElementById(id).attachEvent("onkeypress",doNumOnly);
}
//currency
function init_sum(id)
{
 document.getElementById(id).attachEvent("onkeypress",doSum);
}

function init_numPlus(id)
{
 document.getElementById(id).attachEvent("onkeypress",doNumPlusStar);
}

function init_numedit(id,defaultValue,decimals,groupSeparator)
{
  document.getElementById(id).attachEvent("onkeydown",doKeyDown);
  document.getElementById(id).attachEvent("onkeypress",doKeyPress);
  document.getElementById(id).attachEvent("onfocusin",doToNum);
  document.getElementById(id).attachEvent("onfocusout",doToTxt);
  controls[id] = new Object();
  controls[id].elem = document.getElementById(id)
  if(decimals == null) controls[id].decimals = 2;
  else controls[id].decimals = decimals;
  if(groupSeparator == null) controls[id].groupSeparator = " "; 
  else controls[id].groupSeparator = groupSeparator;
  
  if(defaultValue != null) {
   document.getElementById(id).value = defaultValue;
  }
  document.getElementById(id).value = ToTxt(id);
}
function doKeyPress(e)
{
	if(e.keyCode == 1102) e.keyCode = 44;
}
function doToNum(e)
{
 e.srcElement.value = ToNum(e.srcElement.id);
}
function doToTxt(e)
{
 e.srcElement.value = ToTxt(e.srcElement.id);
}
//Возвращает числовое значение
function GetValue(id)
{
 return ToNum(id);
}
//Устанавливает числовое значение
function SetValue(id,value)
{
  document.getElementById(id).value = value;
  document.getElementById(id).value = ToTxt(id);
}
function FixedValue(id)
{
  var elem = document.getElementById(id);	 
  if(elem.disabled) elem.disabled = false;  
  elem.value = ToNum(id);
}
function UnFixedValue(id)
{
  document.getElementById(id).value = ToTxt(id);
}
//Обработка нажатой клавиши
function doKeyDown(e)
{
   var value = e.srcElement.value;
   var key = e.keyCode;
   //minus
   if(key==109 || key==189) {
      e.srcElement.value = e.srcElement.value*(-1);
      e.srcElement.value = ToNum(e.srcElement.id);
      return false;
   }
   //dot
   if((key==190 || key==110) && (value.indexOf(comma) != -1 || value.indexOf(dot) != -1 || value.length == 0) ) return false;
   //is digit
   var ok = (key==190 || key==110 || key==109 || key==189 || (key > 95 && key < 107) || (key > 47 && key < 58) || key == 37 || key == 39 || key == 46 || key == 9);
   if(key > 8 && !ok) return false;
}
//Только цифры
function doNumOnly(e)
{
   var key = e.keyCode;
   if(key > 31 && (key < 48 || key > 57)) return false;
}
function doNumPlusStar(e)
{
   var key = e.keyCode;
   if(key > 31 && (key < 48 || key > 57) && key != 42) return false;
}
function doSum(e)
{
  if(e.keyCode == 44) e.keyCode = 46;
  var key = e.keyCode;
  if(e.srcElement.value.indexOf('.') > 0 && key == 46) return false;
  if(key > 31 && (key < 48 || key > 57) && key != 46) return false;
}
//Преобразование значения в текст (потеря фокуса)
function ToTxt(id)
{
 var value = document.getElementById(id).value;
 if(value==null || value=="" || value==" ") return "";
 value = value.replace(/ /g,"");
 value = ParseF(value);
 value = value.toFixed(controls[id].decimals).toString();
 if(value.indexOf(dot) == -1 && value != "") value = value + dot+'00000000'.substring(0,controls[id].decimals);
 else if(value.length-value.indexOf(dot)-1<controls[id].decimals)
 	  value = value+'00000000'.substring(0,controls[id].decimals - value.length + value.indexOf(dot)+1);
 var beforedot = (value.indexOf(dot) != -1) ? (value.substring(0,value.indexOf(dot))) : "";
 var afterdot = value.substring(beforedot.length);
 var new_beforedot = "";
 var len = beforedot.length;
 for(i = len; i>0; i--)
 {
  if(i % 3 == 0 && i != len) new_beforedot += controls[id].groupSeparator;
  new_beforedot += beforedot.substring(len-i,len-i+1);
 }
 if(new_beforedot.indexOf("-"+controls[id].groupSeparator) != -1 ) new_beforedot = new_beforedot.substring(0,1)+new_beforedot.substring(2);
 return (new_beforedot + afterdot);
}
//Пребразования текста в число (получение фокуса)
function ToNum(id)
{
 var value = document.getElementById(id).value;
 value = value.replace(comma,dot);
 if(value.indexOf(dot) == -1 && value != "") value = value + dot+'00000000'.substring(0,controls[id].decimals);
 var new_value = "";
 new_value = value.replace(/ /g,"");
 return new_value;  
}

//Блок для преобразования денежной суммы прописью

//Формат вызова из скрипта: ConvertNumToCurr(num,cur,lang)
//где num - числовое значение суммы
//    cur - знак валюты ("UAH","RUB","UER","USD",...)
//    lang = {"ua","ru"} - язык, по умолчанию - ru;
//возвращает искомую стоку 

//Масив доступных валют
var lang = "ru";
var curr = new Array();
curr["ua"] = new Array();
curr["ru"] = new Array();

curr["ru"]["UAH"] = new Array(false, "грн.", "грн.", "грн.", "коп.", "коп.", "коп.");
curr["ru"]["RUB"] = new Array(true, "рубль", "рубля", "рублей", "копейка", "копейки", "копеек");
curr["ru"]["EUR"] = new Array(true, "евро", "евро", "евро", "евроцент", "евроцента", "евроцентов");           
curr["ru"]["USD"] = new Array(true, "доллар", "доллара", "долларов", "цент", "цента", "центов");          

curr["ua"]["UAH"] = new Array(false, "грн.", "грн.", "грн.", "коп.", "коп.", "коп.");
curr["ua"]["RUB"] = new Array(true, "рубль", "рубля", "рублів", "копійка", "копійки", "копійок");
curr["ua"]["EUR"] = new Array(true, "євро", "євро", "євро", "євроцент", "євроцента", "євроцентів");           
curr["ua"]["USD"] = new Array(true, "долар", "долара", "доларів", "цент", "цента", "центів");          

var hunds = new Array();
hunds["ru"] = new Array("", "сто ", "двести ", "триста ", "четыреста ","пятьсот ", "шестьсот ", "семьсот ", "восемьсот ", "девятьсот ");
hunds["ua"] = new Array("", "сто ", "двісті ", "триста ", "чотириста ","п`ятсот ", "шістсот ", "сімсот ", "вісімсот ", "дев`ятсот ");
var tens = new Array();
tens["ru"] = new Array("", "десять ", "двадцать ", "тридцать ", "сорок ", "пятьдесят ","шестьдесят ", "семьдесят ", "восемьдесят ", "девяносто ");
tens["ua"] = new Array("", "десять ", "двадцять ", "тридцять ", "сорок ", "п`ятдесят ","шістдесят ", "семдесят ", "вісімдесят ", "дев`яносто ");
var frac20 = new Array();
frac20["ru"] = new Array("", "один ", "два ", "три ", "четыре ", "пять ", "шесть ","семь ", "восемь ", "девять ", "десять ", "одиннадцать ","двенадцать ", "тринадцать ", "четырнадцать ", "пятнадцать ","шестнадцать ", "семнадцать ", "восемнадцать ", "девятнадцать ");
frac20["ua"] = new Array("", "один ", "два ", "три ", "чотири ", "п`ять ", "шість ","сім ", "вісім ", "дев`ять ", "десять ", "одинадцять ","дванадцять ", "тринадцять ", "чотирнадцять ", "п`ятнадцять ","шістнадцять ", "сімнадцять ", "вісімнадцять ", "дев`ятнадцять ");

var thousands = new Array();
thousands["ru"] = new Array(false, "тысяча", "тысячи", "тысяч");
thousands["ua"] = new Array(false, "тисяча", "тисячі", "тисяч");
var millions = new Array();
millions["ru"] = new Array(true, "миллион", "миллиона", "миллионов");
millions["ua"] = new Array(true, "мільйон", "мільйона", "мільйонів");
var billions = new Array();
billions["ru"] = new Array(true, "миллиард", "миллиарда", "миллиардов");
billions["ua"] = new Array(true, "мільярд", "мільярда", "мільярдів");
var trillions = new Array();
trillions["ru"] = new Array(true, "триллион", "триллиона", "триллионов");
trillions["ua"] = new Array(true, "трильйон", "трильйона", "трильйонів");
var trilliards = new Array();
trilliards["ru"] = new Array(true, "триллиард", "триллиарда", "триллиардов");
trilliards["ua"] = new Array(true, "триліард", "триліарда", "триліардів");
var mns = new Array();
mns["ru"] = "минус ";
mns["ua"] = "мінус ";


function Str(val,male,one,two,five)
{
 var num = Math.floor(val % 1000);
 if(val < 1) return "";
 if(0 == num) return "";
 if(!male){
   frac20[lang][1] = "одна ";
   if(lang == "ua") frac20[lang][2] = "дві ";
   else frac20[lang][2] = "две ";
 }
 var r = hunds[lang][Math.floor(num / 100)];
 if(Math.floor(num % 100) < 20)
 {
   r += frac20[lang][Math.floor(num % 100)];
 }
 else
 {
   r += tens[lang][Math.floor((num % 100) / 10)];
   r += frac20[lang][Math.floor(num % 10)];
 }
 r += Case(num, one, two, five);
 if(r.length != 0) r += " ";
 return r;
}

function Case(val,one,two,five)
{
  var t = (val % 100 > 20) ? (val % 10) : (val % 20);
  switch (t)
  {
    case 1: return one;
    case 2: case 3: case 4: return two;
    default: return five;
  }
}

function ConvertNumToCurr(num,cur,lng)
{
 if(lng) lang = lng;	 
 var currentCur = curr[lang][cur];
 return NumToStr(num,currentCur[0],currentCur[1],currentCur[2],currentCur[3],currentCur[4],currentCur[5],currentCur[6]);
}

function NumToStr(val,male,seniorOne,seniorTwo,seniorFive,juniorOne,juniorTwo,juniorFive)
{
 var minus = false;
 if(val < 0) { val = - val; minus = true; }
 var n = Math.floor(val);
 var remainder = Math.floor(( val - n + 0.005 ) * 100);
 var r = "";
 if(0 == n) r += "0 ";
 if(Math.floor(n % 1000) != 0)
	r += Str(n, male, seniorOne, seniorTwo, seniorFive);
 else
    r += seniorFive + " ";
 n /= 1000;
 r = Str(n, thousands[lang][0],thousands[lang][1],thousands[lang][2],thousands[lang][3]) + r;
 n /= 1000;
 r = Str(n, millions[lang][0], millions[lang][1], millions[lang][2], millions[lang][3]) + r;
 n /= 1000;
 r = Str(n, billions[lang][0], billions[lang][1], billions[lang][2], billions[lang][3]) + r;
 n /= 1000;
 r = Str(n, trillions[lang][0], trillions[lang][1], trillions[lang][2], trillions[lang][3]) + r;
 n /= 1000;
 r = Str(n, trilliards[lang][0], trilliards[lang][1], trilliards[lang][2], trilliards[lang][3]) + r;
 
 if(minus) r  = mns[lang] + r;
 r += remainder + " ";
 r += Case(remainder, juniorOne, juniorTwo, juniorFive);
 r = r.substr(0,1).toUpperCase()+r.substr(1);
 return r;
}