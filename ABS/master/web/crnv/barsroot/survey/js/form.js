/*
arr[0]  - grp_id
arr[1]  - grp_name
arr[2]  - grp_ord
arr[3]  - quest_id
arr[4]  - quest_name
arr[5]  - quest_ord
arr[6]  - fmt_id
arr[7]  - list_id
arr[8]  - quest_multi
arr[9]  - fl_parent
arr[10] - answer_key
arr[11] - answer_value
arr[12] - answer_ord
arr[13] - answer_default
arr[14] - answer_type
arr[15] - default answer
*/
/// Очищення таблиці від попередньої групи питань
function clearRows()
{
  var tbl = document.getElementById('Quest');
  var lastRow = tbl.rows.length;
  while (lastRow > 2) 
  {
    tbl.deleteRow(lastRow - 1);    
    lastRow = tbl.rows.length;
  }
}
/// Формування стрічки таблиці по рядку з бази
function addRow(arr)
{
  /// Нове питання - створюємо рядок
  if (window.document.getElementById(arr[3].text)==null)
  {
      var tbl = document.getElementById('Quest');
      var lastRow = tbl.rows.length;  
      var row = tbl.insertRow(lastRow);

      /// Номер питання
      var cellNum = row.insertCell(0);
//      var qNum = document.createTextNode(arr[3].text);
//      cellNum.appendChild(qNum);

      /// Текст питання
      var cellText = row.insertCell(1);
      var qText = document.createTextNode(arr[4].text);
      cellText.appendChild(qText);
      
      /// Відповідь на питання
      var cellAns = row.insertCell(2);
      /// Вільна відповідь 3-текст, 4-число, 5-дата
      if (arr[6].text == "3")
      {
          var ans = document.createElement('input');
          ans.type = 'text';
          ans.className = 'InfoText';
          ans.id = arr[3].text;
          ans.tabIndex = arr[3].text;
          /// якщо є значення по замовчуванню
          if (!IsEmptyText(arr[15].text))
              ans.value = arr[15].text;
          if (arr[9].text == "1")
              ans.attachEvent("onfocusout",GetChildren);

          cellAns.appendChild(ans);    
      }
      else if (arr[6].text == "4")
      {
          var ans = document.createElement('input');
          ans.type = 'text';
          ans.className = 'InfoText';
          ans.id = arr[3].text;
          ans.tabIndex = arr[3].text;            
          /// якщо є значення по замовчуванню
          if (!IsEmptyText(arr[15].text))
              ans.value = arr[15].text;        
          if (arr[9].text == "1")
              ans.attachEvent("onfocusout",GetChildren);
              
          ans.attachEvent("onkeydown",doNum);
          cellAns.appendChild(ans); 
      }
      else if (arr[6].text == "5")
      {
          cellAns.innerHTML = "<input id='" + arr[3].text + "' type='hidden'><input id='" + arr[3].text + "_Value' type='hidden' name='" + arr[3].text + "'><input id='" + arr[3].text + "_TextBox' tabIndex='" + arr[3].text + "' name='" + arr[3].text + "_TextBox' " + "style='TEXT-ALIGN:center'>";
          window[arr[3].text] = new RadDateInput(arr[3].text, 'Windows');
          window[arr[3].text].PromptChar='_'; 
          window[arr[3].text].DisplayPromptChar='_';
          window[arr[3].text].SetMask(rdmskr(1, 31, false, true),rdmskl('/'),rdmskr(1,12, false, true),rdmskl('/'),rdmskr(1, 2099, false, true));	
          window[arr[3].text].RangeValidation=true; 
          window[arr[3].text].SetMinDate('01/01/1900 00:00:00'); 
          window[arr[3].text].SetMaxDate('31/12/2099 00:00:00'); 
          window[arr[3].text].SetValue('01/01/1900');          
          /// якщо є значення по замовчуванню
          if (!IsEmptyText(arr[15].text))
              window[arr[3].text].SetValue(arr[15].text);
           
          window[arr[3].text].Initialize();
      }
      /// Вибір з допустимих
      else if (arr[6].text == "1" || arr[6].text == "2")
      {
          var ans = document.createElement('select');
          ans.id = arr[3].text;
          ans.className = 'InfoText';
          ans.tabIndex = arr[3].text;
          ans.options[0] = new Option(arr[11].text, arr[10].text);
          if (arr[9].text == "1")
            ans.attachEvent("onchange",GetChildren);
          if (arr[13].text == "1")
            ans.options[0].selected = true;
          cellAns.appendChild(ans); 
      }
  } 
  /// Рядок з варіантом відповіді 
  else
  {
    var ans = document.getElementById(arr[3].text);
    ans.options[ans.options.length] = new Option(arr[11].text, arr[10].text);
    if (arr[13].text == "1")
        ans.options[ans.options.length - 1].selected = true;
  }  
}
/// Перевірка чи на питання відповіли
/// якщо ні - видається повідомлення
function CkAnsForQuest(quest)
{
   if (window.document.getElementById(quest[3].text)==null)
   {
        alert('Питання №'+ quest[5].text +' не існує! Некоректно заповнена сторінка!');
        return false;
   }

   return true;
}
/// Вичитуємо з урл параметр
/// якщо його нема - повертаємо на 
/// сторінку по замовчуванню
/// par2 = 0 - параметр не обовязковий
/// par2 = інакше - параметр обовязковий 
function searchURLforREF(par1,par2)
{
    var res,success = 0;
		
	var url = decodeURI(location.href);
	var data = url.split('?');
	var params = data[1];
	if (params == null && params == '' && params == "") 
	    location.replace('Default.aspx');
	var par = params.split('&');
	
	for(var i=0; i<par.length; i++)
	{
		var pos = par[i].indexOf('=');
		if (par[i].substring(0,pos) == par1) //"ref"
		{
			res	= par[i].substring(pos+1);
		    success = 1;
		}
	}		
	if (success != 1 && par2 != 0)
	{
	    alert('Помилка! Некоректно вказана сторінка');
	    location.replace('Default.aspx');
	    return null;
	}

	return res;
}
/// Вставка в масив iObj елемента Elem
/// після елемента з ід qID
function Insert(iObj,Elem,qID)
{
    var result = new Array();
    var j = 1;
    result[0] = iObj[0];
    for (var i = 1; i < iObj.length; i++)
    {
        if ( iObj[i][3].text != qID && iObj[i][3].text != Elem[3].text )
            result[j] = iObj[i]; 
        else if ( i == iObj.length - 1 )
        {
            result[j] = iObj[i];
            result[j+1] = Elem;
            j++;
        }
        else if (iObj[i+1][3].text == qID || iObj[i+1][3].text == Elem[3].text)
            result[j] = iObj[i]; 
        else
        {
                result[j] = iObj[i];
                result[j+1] = Elem;
                j++;
        }
        
        j++;
    }
    return result;
}
/// Видалення з обєкту iObj всіх входжень
/// елемента з ід quest_id
function DeleteQuestion(quest_id,iObj)
{
    var result = new Array();
    result[0] = iObj[0];
    var j = 1;
    for (var i = 1; i < iObj.length; i++)
        if (iObj[i][3].text != quest_id)
            result[j++] = iObj[i];
    
    return result;           
}
/// Сховати питання з ід questID
function HideQuest(questID)
{
      var tbl = document.getElementById('Quest');
      var elQuest = document.getElementById(questID);
      if (elQuest != null)  
        tbl.deleteRow(elQuest.parentElement.parentElement.rowIndex);
}
/// Вставити на форму питання arr після питання з ід qID 
/// OFSET - зміщення
function InsertQuestion(arr,qID,OFSET)
{
  /// Нове питання - створюємо рядок
  if (window.document.getElementById(arr[3].text)==null)
  {
      var tbl = document.getElementById('Quest');
      var prevQuest = document.getElementById(qID);  
      var row = tbl.insertRow(prevQuest.parentElement.parentElement.rowIndex + 1 + OFSET);

      /// Номер питання
      var cellNum = row.insertCell(0);
//      var qNum = document.createTextNode(arr[3].text);
//      cellNum.appendChild(qNum);

      /// Текст питання
      var cellText = row.insertCell(1);
      var qText = document.createTextNode(arr[4].text);
      cellText.appendChild(qText);
      
      /// Відповідь на питання
      var cellAns = row.insertCell(2);
      /// Вільна відповідь 3-текст, 4-число, 5-дата
      if (arr[6].text == "3")
      {
          var ans = document.createElement('input');
          ans.type = 'text';
          ans.className = 'InfoText';
          ans.id = arr[3].text;
          ans.tabIndex = arr[3].text;
          if (arr[9].text == "1")
              ans.attachEvent("onfocusout",GetChildren);

          cellAns.appendChild(ans);    
      }
      else if (arr[6].text == "4")
      {
          var ans = document.createElement('input');
          ans.type = 'text';
          ans.className = 'InfoText';
          ans.id = arr[3].text;
          ans.tabIndex = arr[3].text;                    
          if (arr[9].text == "1")
              ans.attachEvent("onfocusout",GetChildren);
              
          ans.attachEvent("onkeydown",doNum);
          cellAns.appendChild(ans); 
      }
      else if (arr[6].text == "5")
      {
          cellAns.innerHTML = "<input id='" + arr[3].text + "' type='hidden'><input id='" + arr[3].text + "_Value' type='hidden' name='" + arr[3].text + "'><input id='" + arr[3].text + "_TextBox' tabIndex='" + arr[3].text + "' name='" + arr[3].text + "_TextBox' " + "style='TEXT-ALIGN:center'>";
          window[arr[3].text] = new RadDateInput(arr[3].text, 'Windows');
          window[arr[3].text].PromptChar='_'; 
          window[arr[3].text].DisplayPromptChar='_';
          window[arr[3].text].SetMask(rdmskr(1, 31, false, true),rdmskl('/'),rdmskr(1,12, false, true),rdmskl('/'),rdmskr(1, 2099, false, true));	
          window[arr[3].text].RangeValidation=true; 
          window[arr[3].text].SetMinDate('01/01/1900 00:00:00'); 
          window[arr[3].text].SetMaxDate('31/12/2099 00:00:00'); 
          window[arr[3].text].SetValue('01/01/1900');                     
          window[arr[3].text].Initialize();
      }
      /// Вибір з допустимих
      else if (arr[6].text == "1" || arr[6].text == "2")
      {
          var ans = document.createElement('select');
          ans.id = arr[3].text;
          ans.className = 'InfoText';
          ans.tabIndex = arr[3].text;
          ans.options[0] = new Option(arr[11].text, arr[10].text);
          if (arr[9].text == "1")
            ans.attachEvent("onchange",GetChildren);
          if (arr[13].text == "1")
            ans.options[0].selected = true;
          cellAns.appendChild(ans); 
      }
  } 
  /// Такий контрол вже є
  else
  {
    var ans = document.getElementById(arr[3].text);
    /// Перевіряємо чи не дубль
    if (ans.type != 'select-one')
        return;
    for (var i = 0; i<ans.options.length; i++)
        if (ans.options[i].value == arr[11].text)
            return;
    /// Дубля не знайдено - можна вставляти            
    ans.options[ans.options.length] = new Option(arr[11].text, arr[10].text);
    if (arr[13].text == "1")
        ans.options[ans.options.length - 1].selected = true;    
  }  
}