// Скрипт обслуживающий страницу New.aspx

// вычесляет и устанавливает в поле возраст в 
// зависимости от даты рождения
function fnCountAge()
{    
    var dBDate = fnDateParse(gE('edBDAT_TextBox').value);
    var dCurDate = new Date();
    var dDif = dCurDate.getFullYear() - dBDate.getFullYear();
    
    if(dCurDate.getMonth() - dBDate.getMonth() < 0)
        dDif--;
    else if(dCurDate.getMonth() - dBDate.getMonth() == 0 && dCurDate.getDate() - dBDate.getDate() < 0)
        dDif--;
    
    gE('edAge').value = dDif;
}
// проверка заполнености необходимых полей закладки оценки фин сост заемщика
function fnCheckFieldsFinStan()
{
    // проверка заполнености полей общая
    if (!fnCheckFields())
        return false;
    
    // берем данные из грида
    var grd = gE('gvProductParams');
    var curRowIdx = 1;
    var curRow = grd.rows[curRowIdx];
    var nMaxSumm = ParseF(fnDelAllWS( gE('ddlCreditCur').item(gE('ddlCreditCur').selectedIndex).smax ));    
    var nMaxTerm = ParseF(fnDelAllWS( curRow.cells[1].innerText ));    
    
    // Доход не должн быть нулевой
    if ( ParseF(fnDelAllWS(gE('edSalarySumm').value)) <= 0 )
    {
        requiredFieldAlert(gE('edSalarySumm'), 'Доход должен быть не нулевой!'); 
        return false;
    }
    
    // Сумма не должна быть нулевой и не привышать допустимый
    if ( ParseF(fnDelAllWS(gE('edCreditSumm').value)) <= 0 || ParseF(fnDelAllWS(gE('edCreditSumm').value)) > nMaxSumm )
    {
        requiredFieldAlert(gE('edCreditSumm'), 'Недопустимая сумма!'); 
        return false;
    }
    
    // Период не должен быть нулевой и не привышать допустимый
    if ( ParseF(fnDelAllWS(gE('ddlCreditTerm').value)) <= 0 || ParseF(fnDelAllWS(gE('ddlCreditTerm').value)) > nMaxTerm )
    {
        requiredFieldAlert(gE('ddlCreditTerm'), 'Недопустимый срок!'); 
        return false;
    }
    
    return true;
}
// проверка заполнености необходимых полей закладки регистрации контрагента
function fnCheckFieldsClient()
{
    // проверка заполнености полей общая
    if (!fnCheckFields())
        return false;
        
    // дата выдачи паспорта должна быть минимум на 16 больше даты рождения
    var BDat = fnDateParse(gE('edClientBDAT_TextBox').value);
    var DatV = fnDateParse(gE('edClientDATV_TextBox').value);   
    var PassportDate = new Date(BDat.getFullYear() + 16, BDat.getMonth(), BDat.getDate());
    
    if (PassportDate > DatV)
    {
        requiredFieldAlert(gE('edClientDATV_TextBox'), 'Недопустимая дата выдачи паспорта!'); 
        return false;
    }   
    
    return true;
}
// проверка заполнености необходимых полей закладки регистрации нового потребительского кредита
function fnCheckCredit()
{
    // проверка заполнености полей общая
    if (!fnCheckFields())
        return false;
        
    // Сумма не должна быть нулевой
    if ( ParseF(fnDelAllWS(gE('edProductPrice').value)) < 0 )
    {
        requiredFieldAlert(gE('edProductPrice'), 'Недопустимая сумма!'); 
        return false;
    }

    return true;
}

// отрабатываем загрузку страницы
function PageLoad()
{
    // определяем состояние
    var sState = gE('hState').value;
    
    switch (sState)
    {
        // Закладка оценки фин сост заемщика
        case '0':
            // переход по нажатию Enter    
            AddListeners('ddlProductName,edBDAT_TextBox,edOKPO,edChildNum,ddlMarried,ddlJobType,ddlPost,ddlEducation,edLastJob,edLastLive,edCreditSumm,ddlCreditCur,edSalarySumm,ddlCreditTerm,ddlCreditHistory,ddlDeposits', 'onkeydown', TreatEnterAsTab);
            // контролы ввода суммы
            if (gE('edCreditSumm') != null) init_numedit('edCreditSumm', ParseF(fnDelAllWS(gE('edCreditSumm').value)), 2, ' ');
            if (gE('edSalarySumm') != null) init_numedit('edSalarySumm', ParseF(fnDelAllWS(gE('edSalarySumm').value)), 2, ' ');

            break;

        // Закладка регистрации контрагента
        case '1':
            // переход по нажатию Enter    
            AddListeners('edClientF,edClientI,edClientO,edClientBDAT_TextBox,edClientOKPO,edClientSER,edClientNUM,edClientKEM,edClientDATV_TextBox,edClientIDX,edClientREG,edClientDST,edClientTWN,edClientSTR,edClientTEL1,edClientTEL2', 'onkeydown', TreatEnterAsTab);
            // инициализация контрола ввода даты
            fnInitDate('edClientBDAT');
            fnInitDate('edClientDATV');
        
        break;

        // Закладка регистрации нового потребительского кредита    
        case '2':
            // переход по нажатию Enter    
            AddListeners('lstTorg,lstPotr,tblFreeTorg,edFreeTorgName,edFreeTorgMFO,edFreeTorgNLS,edFreeTorgOKPO,edProductPrice,edProductPay,edProductDate_TextBox,edProductInfo', 'onkeydown', TreatEnterAsTab);
            // контролы ввода суммы
            if (gE('edProductPrice') != null) init_numedit('edProductPrice', 0, 2, ' ');
            if (gE('edProductPay') != null) init_numedit('edProductPay', 0, 2, ' ');
            // инициализация контрола ввода даты
            if (gE('edProductDate') != null) fnInitDate('edProductDate');

        break;
    }

    // Отображение результатов регистрации        
    // ставим фокус на первый контрол
    if (gE('btFinish') != null) gE('btFinish').focus();
}
// скрываем/показываем реквизиты свободного торговца
function fnFreeTorgChange()
{
    // если выбран свободный торговец
    var bShowFreeTorg = (gE('lstTorg').value == '0')?(true):(false);
    
    // прячем/показываем
    gE('trFreeTorgTitle').style.visibility = (bShowFreeTorg)?("visible"):("hidden");
    gE('trFreeTorgData').style.visibility = (bShowFreeTorg)?("visible"):("hidden");
    
    // Наименование тоговца
    gE('edFreeTorgName').cntltype = (bShowFreeTorg)?("s"):("none");
    // МФО банка
    gE('edFreeTorgMFO').cntltype = (bShowFreeTorg)?("s"):("none");
    // Номер счета
    gE('edFreeTorgNLS').cntltype = (bShowFreeTorg)?("s"):("none");
    // Идент. код
    gE('edFreeTorgOKPO').cntltype = (bShowFreeTorg)?("s"):("none");
}
// показываем детализацию дохода
function fnShowSalaryDetail()
{
    var nSurveyId = gE('hSurveyId').value;
    var result = window.showModalDialog('salarydetail.aspx?sid=' + nSurveyId + '&rand=' + Math.random(), null, 'dialogHeight:600px; dialogWidth:800px');
	if(result != null)
	{
        gE('edSalarySumm').value = result;
    }
}