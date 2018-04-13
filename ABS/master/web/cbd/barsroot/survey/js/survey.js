/// Завантаження анкети
function LoadSurvey()
{   
    var surid = searchURLforREF("surid",0);
    var par = searchURLforREF("par",0);
    if (!par && !surid) {BarsAlert("Анкетування", "Сторінка викликана без необхідних параметрів!",1,1); return;}
    var rnk = searchURLforREF("rnk",1);
    if (!rnk) {BarsAlert("Анкетування", "Сторінка викликана без необхідних параметрів!",1,1); return;}
    
    s_info = new Array();
       
    webService.useService("SurveyService.asmx?wsdl","Sur");    
    
    var dont_ask = searchURLforREF("dont_ask",0);
        
    if (dont_ask != null)
        surid?LoadSurveyGroup(surid,rnk,1,"surid"):LoadSurveyGroup(par,rnk,1,"params");
    else
    {
        if (BarsConfirm("Анкетування","Бажаєте заповнити анкету?",1,1,0))
            surid?LoadSurveyGroup(surid,rnk,1,"surid"):LoadSurveyGroup(par,rnk,1,"params");
        else
            surid?Decline(rnk,surid,"surid"):Decline(rnk,par,"params");        
    }
}

/// Перехоплення помилок
function getError(result)
{
	if(result.error){
	   window.showModalDialog("dialog.aspx?type=err&code=" + Math.random(),null,
	   "dialogWidth:700px; dialogHeight:500px; center:yes; status:no");	
		return false;
	}
	return true;
}

/// Обробка отриманих даних при завантажені анкети
function onLoadSurvey(result)
{
    if(!getError(result)) return;
    grp = result.value;

    if (grp[0].length > 0)
    {
        s_info[0] = grp[0][2].text; // ід сесії
        s_info[1] = grp[0][0].text; // імя анкети
        s_info[2] = grp[0][1].text; // шаблон анкети
    }
    
    /// Розбір відомостей про групу
    window.document.getElementById('lbTitle').innerText = s_info[1];
    clearRows();
    
    /// Завершення анкетування
    if (grp.length == 1)
    {
        webService.Sur.callService(Dummy, "WrapUp", s_info[0]);
        location.replace('Default.aspx');
    }
        
    /// Розбір отриманої групи питань    
    for (var i = 1; i < grp.length; i++)
    {       
        /// Обробляємо кожне питання групи
        var quest = grp[i];        
        window.document.getElementById('grp_name').innerText = quest[1].text;
        addRow(quest);
    }    
    
    window.document.getElementById('btNext').style.visibility = "visible";
    window.document.getElementById('btPrint').style.visibility = "visible";
}
/// Перевірка на заповненість контролів
function CkAns()
{
    if (grp == null)
    { BarsAlert("Анкетування", "Не ініціалізовані дані!",1,1);return; }
    
    for (var i = 1; i < grp.length; i++)
    {       
        /// Обробляємо кожне питання групи
        var quest = grp[i];        
        /// Якщо на питання не відповіли
        /// повідомляємо про це клієнту
        if (!CkAnsForQuest(quest))
            return false;
    }    
    
    return true;
}
/// Запис відповідей в базу
function SubmitGroup()
{
    if (grp == null)
    { alert('Не ініціалізовані дані!'); return; }
       
    var ans_arr = new Array();
        
    /// Ініціалізуємо масив відповідей
    /// 0-ва стрічка -- системні параметри
    ans_arr[0] = new Array();
    ans_arr[0][0] = s_info[0];      /// Ід сесії

    /// Записуємо ід питання та відповідь (тип + значення)
    var j = 0;
    for (var i = 1; i < grp.length; i++)
    {           
        // Якщо переглядаємо один з варіантів відповіді
        // то його пропускаємо
        if (i > 1 && grp[i][3].text == grp[i-1][3].text)
            {continue;}
        else
        {j++; ans_arr[j] = new Array();}
        
        ans_arr[j][0] = grp[i][3].text; /// ід
        ans_arr[j][1] = grp[i][6].text; /// тип
        /// answer
        if (ans_arr[j][1] == '3' || ans_arr[j][1] == '4' || ans_arr[j][1] == '1' || ans_arr[j][1] == '2')
        {
            /// текст або число
            ans_arr[j][2] = window.document.getElementById(ans_arr[j][0]).value;
        }
        else if (ans_arr[j][1] == '5')
        {
            /// дата
            if (window.document.getElementById(ans_arr[j][0] + '_TextBox').value == '01/01/1900')
                ans_arr[j][2] = null;
            else
                ans_arr[j][2] = window.document.getElementById(ans_arr[j][0] + '_TextBox').value;
        }
    }    
    
    webService.Sur.callService(onSubmitGroup, "SubmitGroup",ans_arr);   
}
///
function onSubmitGroup(result)
{
    if(!getError(result)) return; 

    var par = searchURLforREF("par",0);
    var surid = searchURLforREF("surid",0);
    if (!par && !surid) {BarsAlert("Анкетування", "Сторінка викликана без необхідних параметрів!",1,1); return;}
    
    var rnk = searchURLforREF("rnk",1);

    surid?LoadSurveyGroup(surid, rnk, grp[1][2].text*1 + 1, "surid"):LoadSurveyGroup(par, rnk, grp[1][2].text*1 + 1, "params");
}
/// Записуємо в базу відмову 
/// користувача заповняти анкету
function Decline(rnk,par,tr)
{
    webService.Sur.callService(Dummy, "Decline",rnk,par,tr);
}
/// Функція обробки помилок при виклику веб-сервіса
/// ставиться, якщо нетреба обробляти завершення запису
function Dummy(result)
{ 
    if(!getError(result)) return; 
    location.replace("Default.aspx");
}
/// Завантаження групи питань з анкети
function LoadSurveyGroup(par,rnk,grp_id,tr)
{   
    webService.Sur.callService(onLoadSurvey, "LoadSurvey",par,grp_id,rnk,tr);
}
/// Перевірка, чи є дочірні (запуск)
function GetChildren()
{
    var rnk = searchURLforREF("rnk",1);
    var par = searchURLforREF("par",1);
    var surid = searchURLforREF("surid",0);
    if (!par && !surid) {BarsAlert("Анкетування", "Сторінка викликана без необхідних параметрів!",1,1); return;}

    var q = event.srcElement;

    surid?webService.Sur.callService(onGetChildren, "GetChildren",surid,q.id,q.value,"surid",rnk,s_info[0]):webService.Sur.callService(onGetChildren, "GetChildren",par,q.id,q.value,"params",rnk,s_info[0]);
}
/// Перевірка, чи є дочірні (в базі)
function onGetChildren(result)
{
    if(!getError(result)) return;
    var new_quest = result.value;
    var offset = -1;
    
    for (var i = 0; i < new_quest.length; i++)
    {       
        /// Обробляємо кожне питання групи
        var quest = new_quest[i];        
        /// Потрібно сховати питання
        if (quest[1].text == "0")
        {
            grp = DeleteQuestion(quest[0].text,grp);
            HideQuest(quest[0].text);
        }
        else
        {
            /// Додаємо інформацію про питання в змінну
            grp = Insert(grp,quest,quest[15].text);            
            var prev_quest = new_quest[i-1];
            /// Якщо створюється нове питання - вказуємо, що треба 
            /// вставити в таблицю наступну стрічку
            if (i == 0 || quest[3].text != prev_quest[3].text)
                offset += 1;            
            InsertQuestion(quest,quest[15].text,offset);
        }
    }        
}
/// 
function PrintSurvey()
{
    if (grp == null)
    {
        BarsAlert("Анкетування","Інформація про анкету відсутня!\nЗайдіть у функцію анкетування ще раз.",1,1);
        return;
    }    
    
    webService.Sur.callService(onPrintSurvey, "PrintSurvey",s_info[2]);            
}
function onPrintSurvey(result)
{
    if(!getError(result)) return;    
    
    var url = "WebPrint.aspx?trace=true&mht_file=" + result.value;

	window.showModalDialog(encodeURI(url),"_blank", 
	'dialogWidth: 800px; dialogHeight: 600px; center: yes; status:no; menubar:no; toolbar:no; location:no; titlebar:no;');    
}