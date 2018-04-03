// необходимые глобальные переменные
    var maxWait = 60;
    var checkWait = 5;
    var curWait = checkWait;
    var isAnswerRetr = false;
    var sQueryId = null;
    var nRepeaterId = null;

//=================================================

// отрабатываем загрузку страницы
function PageLoadHeader()
{
    // переход по нажатию Enter    
    AddListeners('ctl00_edDogNum,ctl00_edDogDat_TextBox', 'onkeydown', TreatEnterAsTab);
    // даты
    curDate = gE('ctl00_edDogDat_TextBox').value;

    fnInitDate('ctl00_edDogDat');
    
    // если оба поля поиска не заполнены то дисейблим кнопку
    fnShowButtons();
    gE('ctl00_edDogNum').attachEvent('onblur', fnShowButtons);
    gE('ctl00_edDogDat_TextBox').attachEvent('onblur', fnShowButtons);
    
    // показываем описание состояния
    fnShowState();
}

// показываем описание состояния
function fnShowState()
{
    gE('tdSearchResult1').innerText = gE('ctl00_hStateTitle').value;
    gE('ctl00_tdSearchResult2').value = gE('ctl00_hStateDesc').value;

    var sCode = gE('ctl00_hState').value;
    var sColor = '';

    // разукрашиваем
    switch (sCode)
    {
        case '0' :            
            // Запрос поставлен в очередь
            sColor = 'DarkBlue'

            break;
        case '1' :
            // Произошла ошибка
            sColor = 'DarkRed'

            break;
        case '2' :            
            // договор найден
            sColor = 'DarkGreen'

            break;
    }    
    gE('tdSearchResult1').style.color = sColor;
    gE('ctl00_tdSearchResult2').style.color = sColor;
    
    // если оба поля поиска не заполнены то дисейблим кнопку
    fnShowButtons();
}

// поиск кредитного договора
function fnSearchClick()
{
    var sCCId = trim(gE('ctl00_edDogNum').value);
    var sDDat = trim(gE('ctl00_edDogDat_TextBox').value);
    var sType = trim(gE('ctl00_hDogType').value);

    // запускаем сервис    
    var srvResult = PageService.GetSearchResult( sCCId, sDDat, sType).value;

    // обработка результата работы сервиса
    return fnProcessSrvResult(srvResult);
}

// выбор кредитного договора
function fnSelectClick()
{
    // отправляем на сервер
    __doPostBack('', '');
}

// нажата кнопка отмена
function fnCancelClick()
{
    gE('ctl00_edDogNum').value = '';
    gE('ctl00_edDogNum').focus();
    window['ctl00_edDogDat'].SetValue(curDate);
    
    fnShowButtons();
    
    gE('ctl00_hStateTitle').value = '';
    gE('ctl00_hStateDesc').value = '';
    fnShowState();
    
    // вытираем из сессии запись
    PageService.ClearSessionData();

    // отправляем на сервер
    __doPostBack('', '');
}

// обработка результата работы сервиса
function fnProcessSrvResult(srvResult)
{
    var stateCode = srvResult[0];
    var stateTitle = srvResult[1];
    var stateMsg1 = srvResult[2];
    var stateMsg2 = srvResult[3];
    
    switch (stateCode)
    {
        case '0' :            
            // Запрос поставлен в очередь
            fnSvrQuery(stateCode, stateTitle, stateMsg1);

            break;
        case '1' :
            // Произошла ошибка
            fnSvrError(stateCode, stateTitle, stateMsg1);

            break;
        case '2' :            
            // договор найден
            fnSvrFound(stateCode, stateMsg1);

            break;
    }

    return true;
}

// запрос поставлен в очередь
function fnSvrQuery(sCode, sTitle, sMsg)
{
    gE('ctl00_hState').value = sCode;
    gE('ctl00_hTmp').value = sMsg;
    
    gE('ctl00_hStateTitle').value = sTitle;
    gE('ctl00_hStateDesc').value = <BarsLocalize key="labProwloVremeni" /> + '0' + <BarsLocalize key="labSek" />;
    fnShowState();
    
    // ожидание ответа инфор запроса
    fnWaitForAnswer();
    
    // фокус
    gE('ctl00_btSearch').focus();
}

// произошла ошибка в сервисе
function fnSvrError(sCode, sTitle, sMsg)
{
    gE('ctl00_hState').value = sCode;

    gE('ctl00_hStateTitle').value = sTitle + ' : ';
    gE('ctl00_hStateDesc').value = sMsg;
    fnShowState();
    
    // фокус
    gE('ctl00_btCancel').focus();
}

// договор найден
function fnSvrFound(sCode, sMsg)
{
    gE('ctl00_hState').value = sCode;
    
    gE('ctl00_hStateTitle').value = <BarsLocalize key="labClient" />;
    gE('ctl00_hStateDesc').value = sMsg;
    fnShowState();
    
    // фокус
    gE('ctl00_btSelect').focus();
}

// ожидание ответа инфор запроса
function fnWaitForAnswer()
{
    sQueryId = gE('ctl00_hTmp').value;

    // засыпаем на 5 сек, функция обработки очередного вызова информ запроса
    nRepeaterId = window.setInterval("doNextLoop()", checkWait*1000);
}

// прекращаем ожидание ответа информ запроса
function endLooping(arrResult)
{
    // прекращаем запросы
    window.clearInterval(nRepeaterId);
    
    var arrRes;
    
    switch (arrResult[0])
    {
        case '1' :
            // данные получены все ок
            arrRes = new Array('2', arrResult[1], arrResult[2], arrResult[3]);
        
            break;
        case '2' :
            // ошибка
            arrRes = new Array('1', arrResult[1], arrResult[2]);
            
            break;
    }
    
    // обрабатіваем результат
    fnProcessSrvResult(arrRes);
}

// функция обработки очередного вызова информ запроса
function doNextLoop()
{
    var dopSrvResult = PageService.GetQueryAnswer( sQueryId ).value;
    
    // берем результат запроса
    var pQStatus = dopSrvResult[0];
    var pQTitle = dopSrvResult[1];
    var pQMsg1 = dopSrvResult[2];
    var pQMsg2 = dopSrvResult[3];
    
    // разбераем результат запроса
    if (pQStatus == '0')
    {
        // овета нет, продолжаем ждать
        gE('ctl00_hStateDesc').value = <BarsLocalize key="labProwloVremeni" /> + curWait + <BarsLocalize key="labSek" />;
        fnShowState();
        curWait += checkWait;
    }
    else
    {
        // есть ответ/ошибка
        endLooping(dopSrvResult);
    }
    
    // если вышло время ожидание, то тоже прекращаем
    if (maxWait < curWait)
    {
        var errRes = new Array('2', <BarsLocalize key="labProizowlaOwibka" />, <BarsLocalize key="labIstekloVremiaOgidaniaOtveta" />);
        endLooping(errRes);
    }
}
// смотрим если заполнены оба поля выбора, то открываем кнопки
function fnShowButtons()
{
    var bCCId = (trim(gE('ctl00_edDogNum').value) != '');
    var bDDat = (trim(gE('ctl00_edDogDat_TextBox').value) != initDate);
    var bHasDog = (gE('ctl00_hState').value == '2');

    if (bCCId && bDDat)
    {
        gE('ctl00_btSearch').disabled = false;
        if (bHasDog)
        {
            gE('ctl00_btSelect').disabled = false;        
        }
        else
        {
            gE('ctl00_btSelect').disabled = true;        
        }
    }
    else
    {
        gE('ctl00_btSearch').disabled = true;
        gE('ctl00_btSelect').disabled = true;        
    }
}