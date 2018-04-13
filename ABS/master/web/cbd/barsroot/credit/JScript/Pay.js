// Скрипт обслуживающий диалог Pay.aspx

// необходимые глобальные переменные

//=================================================

// отрабатываем загрузку страницы
function PageLoad()
{
    // переход по нажатию Enter    
    AddListeners('ctl00_ContentPH_slctType,ctl00_ContentPH_edSumm', 'onkeydown', TreatEnterAsTab);
    
    // сумма прописью
    if (gE('ctl00_ContentPH_edSumm')) gE('ctl00_ContentPH_edSumm').attachEvent('onblur', fnWriteSummPr);

    // ставим фокус на первый контрол ввода
    if (gE('ctl00_ContentPH_slctType')) gE('ctl00_ContentPH_slctType').focus();

    // контролы ввода суммы
    if (gE('ctl00_ContentPH_edSumm')) init_numedit('ctl00_ContentPH_edSumm', ParseF(gE('ctl00_ContentPH_edSumm').value), 2, ' ');
}

// записываем сумму прописью
function fnWriteSummPr()
{
    if (gE('ctl00_ContentPH_edSumm'))
    {
        var nSumm = GetValue('ctl00_ContentPH_edSumm');
        var sSumm = ConvertNumToCurr(nSumm, 'UAH', 'ru');
        gE('ctl00_ContentPH_tdSummPr').innerText = sSumm;
    }
}

// валидация введенных данных
function fnCheckFieldsV()
{
    var maxSumm = ParseF(fnDelAllWS( gE('ctl00_ContentPH_hMaxSumm').value ));
    // контролы ввода суммы
    if (gE('ctl00_ContentPH_edSumm').value == "0.00" || ParseF(fnDelAllWS( gE('ctl00_ContentPH_edSumm').value )) > maxSumm)
    {
        requiredFieldAlert(gE('ctl00_ContentPH_edSumm'), <BarsLocalize key="labNevernaiaSumma" />); 
        return false;
    }
    
    return true;
}

// поиск договора
function fnFindDogLocal(type)
{
    if (gE('ctl00_ContentPH_edSumm')) gE('ctl00_ContentPH_edSumm').value = '0.00';
    fnFindDog(type);
}

// переходим на карточку документа
function fnGoDocCard(sRef)
{
    location.replace('/barsroot/documentview/default.aspx?ref=' + sRef);
}