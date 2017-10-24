// Формирование списка библиотек статически зависящих от DOCFUN6

var objShell = WScript.CreateObject("WScript.Shell");
WScript.Echo("Начинаю формировать список библиотек, зависимых от DOCFUN6.APL. Нажмите Ок и ждите сообщения об окончании работы.");

{
  var strUtilPath = "cbdep.exe";
  var fso, folder, fc, s, len, su;
  fso = new ActiveXObject("Scripting.FileSystemObject");
  folder = fso.GetFolder(objShell.CurrentDirectory);
  // формируем DEP-файлы
  fc = new Enumerator(folder.files);
  for (; !fc.atEnd(); fc.moveNext()) {
      s = new String("");
      s += fc.item(); len = s.length;
      su = s.toUpperCase();
      if("APL"==su.substring(len-3,len)) {
        objShell.Run("cmd.exe /C "+strUtilPath+" -s "+s+" > "+s.substring(0,len-4)+".dep",0,true);
      }
  }
  objShell.Run("cmd.exe /C find /I \"DOCFUN6.APL\" *.DEP > deplist.txt",0,true);
  objShell.Run("cmd.exe /C del *.dep",0,true);
  WScript.Echo("Список зависимых от DOCFUN6.APL библиотек сформирован в файл deplist.txt.");
}

