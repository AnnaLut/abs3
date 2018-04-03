//Переменные
var ottisk_name = "ottisk";
var noprint = true;
var allDocs = new Array();
var refs = new Array();
var id_fio = null;
//Print
var print_now = true; //Печать сразу или с параметрами
var print_from_txt = false; //Печать с помощью екзешника


//Для корректной работы с числами 
var dot = (parseFloat("1.1") == 1)?(","):(".");
var comma = (dot == ".")?(","):(".");
function ParseF(val)
{
  return parseFloat(val.toString().replace(comma,dot));
}

var sel_row_id;
//Возвращает значение параметра из стрoки url
function getParamFromUrl(param,url)
{
 url = url.substring(url.indexOf('?')+1); 
 for(i = 0; i < url.split("&").length; i++)
 if(url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1]; 
 return "";
}
//Диалоговое окно
function Dialog(message,type)
{
  return window.showModalDialog("dialog.aspx?type="+type+"&message="+escape(message),"","dialogHeight:160px;center:yes;edge:sunken;help:no;status:no;");
}
//Обработка ошибок от веб-сервиса
function getError(result)
{
  if(result.error) {
  	  var xfaultcode   = result.errorDetail.code; 
      var xfaultstring = result.errorDetail.string;
      var xfaultsoap   = result.errorDetail.raw;
      window.showModalDialog("dialog.aspx?type=4&message="+xfaultcode+"&source="+escape(xfaultstring)+"&trace="+xfaultsoap,"","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
	  return false;
 }
 return true;
}
//
function SearchArray(arr,id)
{
 var array = new Array();
 var j = 0,i = 0;
 for(i = 0; i< arr.length; i++)
 {
  if(arr[i][0] == id) array[j++] = arr[i];
 }
 return array;
}
function CopyArray(array)
{
  var arr = new Array();
  var j = 0,i = 0;
  for(i = 0; i < array.length; i++ )
  {
    arr[i] = new Array();
    for(j = 0; j < array[i].length; j++ )
		arr[i][j] = array[i][j];
  }
  return arr;
}

function CopyArray2(arr)
{
  var array = new Array();
  var i = 0; 
  for(i = 0; i < arr.length; i++)
  {
    array[i] = arr[i];
  }
  return array;
}
//Проверка счета на контрольный розряд
function checkNls(mfo,nls0)
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
