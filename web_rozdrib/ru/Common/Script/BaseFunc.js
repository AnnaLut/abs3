/*
  Список функций:
  1) base$getParam - возвращает значение параметры из текущей адресной строки;
  2) base$encodeBase64 - кодировка строки в base64
  3) base$decodeBase64 - раскодировка строки из base64
  4) base$byteArrayToHexStr - ковертирование масива байтов в 16-ричную строку
*/


/****************************************************************
  Возвращает значение параметры из текущей адресной строки
****************************************************************/
function base$getParam( name )
{
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results == null )
    return "";
  else
    return results[1];
}

/****************************************************************
  Кодировка\раскодировка строки в base64
****************************************************************/
var b64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

function base$encodeBase64(str) {  
   var o1, o2, o3, h1, h2, h3, h4, bits, i=0, enc='';
   str = encodeUTF8(str);  // encode multi-byte chars into UTF-8 for byte-array

   do {  // pack three octets into four hexets
      o1 = str.charCodeAt(i++);
      o2 = str.charCodeAt(i++);
      o3 = str.charCodeAt(i++);
      
      bits = o1<<16 | o2<<8 | o3;
      
      h1 = bits>>18 & 0x3f;
      h2 = bits>>12 & 0x3f;
      h3 = bits>>6 & 0x3f;
      h4 = bits & 0x3f;
      
      // end of string? index to '=' in b64
      if (isNaN(o3)) h4 = 64;
      if (isNaN(o2)) h3 = 64;
      
      // use hexets to index into b64, and append result to encoded string
      enc += b64.charAt(h1) + b64.charAt(h2) + b64.charAt(h3) + b64.charAt(h4);
   } while (i < str.length);
   
   return enc;
}

function base$decodeBase64(str) {
   var o1, o2, o3, h1, h2, h3, h4, bits, i=0, enc='';

   do {  // unpack four hexets into three octets using index points in b64
      h1 = b64.indexOf(str.charAt(i++));
      h2 = b64.indexOf(str.charAt(i++));
      h3 = b64.indexOf(str.charAt(i++));
      h4 = b64.indexOf(str.charAt(i++));
      
      bits = h1<<18 | h2<<12 | h3<<6 | h4;
      
      o1 = bits>>16 & 0xff;
      o2 = bits>>8 & 0xff;
      o3 = bits & 0xff;
      
      if (h3 == 64)      enc += String.fromCharCode(o1);
      else if (h4 == 64) enc += String.fromCharCode(o1, o2);
      else               enc += String.fromCharCode(o1, o2, o3);
   } while (i < str.length);

   return decodeUTF8(enc);  // decode UTF-8 byte-array back to Unicode
}

function encodeUTF8(str) {  // encode multi-byte string into utf-8 multiple single-byte characters 
  str = str.replace(
      /[\u0080-\u07ff]/g,  // U+0080 - U+07FF = 2-byte chars
      function(c) { 
        var cc = c.charCodeAt(0);
        return String.fromCharCode(0xc0 | cc>>6, 0x80 | cc&0x3f); }
    );
  str = str.replace(
      /[\u0800-\uffff]/g,  // U+0800 - U+FFFF = 3-byte chars
      function(c) { 
        var cc = c.charCodeAt(0); 
        return String.fromCharCode(0xe0 | cc>>12, 0x80 | cc>>6&0x3F, 0x80 | cc&0x3f); }
    );
  return str;
}

function decodeUTF8(str) {  // decode utf-8 encoded string back into multi-byte characters
  str = str.replace(
      /[\u00c0-\u00df][\u0080-\u00bf]/g,                 // 2-byte chars
      function(c) { 
        var cc = (c.charCodeAt(0)&0x1f)<<6 | c.charCodeAt(1)&0x3f;
        return String.fromCharCode(cc); }
    );
  str = str.replace(
      /[\u00e0-\u00ef][\u0080-\u00bf][\u0080-\u00bf]/g,  // 3-byte chars
      function(c) { 
        var cc = (c.charCodeAt(0)&0x0f)<<12 | (c.charCodeAt(1)&0x3f<<6) | c.charCodeAt(2)&0x3f; 
        return String.fromCharCode(cc); }
    );
  return str;
}

/****************************************************************
  Ковертирование масива байтов в 16-ричную строку
****************************************************************/
function base$byteArrayToHexStr(b) {  // convert byte array to hex string for displaying test vectors
  var s = '';
  for (var i=0; i<b.length; i++) s += b[i].toString(16) + ' ';
  return s;
}