// отрабатываем загрузку страницы
function PageLoad()
{
    // контролы ввода суммы
    var nGuarantorNumber = ParseF(gE('hGuarantorNumber').value) + 1;
    var sEnterKeyString = '';

    for(var idx=0; idx<nGuarantorNumber; idx++)
    {
        var i = (idx==0)?(''):(idx);
        
        sEnterKeyString += (sEnterKeyString == '')?(''):(',');
        sEnterKeyString += 'ed_'+i+'083'+',';
        sEnterKeyString += 'ed_'+i+'084'+',';
        sEnterKeyString += 'ed_'+i+'085'+',';
        sEnterKeyString += 'ed_'+i+'086'+',';
        sEnterKeyString += 'ed_'+i+'087'+',';
        sEnterKeyString += 'ed_'+i+'088'+',';
        sEnterKeyString += 'ed_'+i+'095'+',';
        sEnterKeyString += 'ed_'+i+'096'+',';
        sEnterKeyString += 'ed_'+i+'097'+',';
        sEnterKeyString += 'ed_'+i+'098'+',';
        sEnterKeyString += 'ed_'+i+'099'+',';
        sEnterKeyString += 'ed_'+i+'100'+',';
        sEnterKeyString += 'ed_'+i+'101'+',';
        sEnterKeyString += 'ed_'+i+'102'+',';
        sEnterKeyString += 'ed_'+i+'103'+',';
        sEnterKeyString += 'ed_'+i+'104'+',';
        sEnterKeyString += 'ed_'+i+'105'+',';
        sEnterKeyString += 'ed_'+i+'106'+',';
        sEnterKeyString += 'ed_'+i+'107'+',';
        sEnterKeyString += 'ed_'+i+'108'+',';
        sEnterKeyString += 'ed_'+i+'109'+',';
        sEnterKeyString += 'ed_'+i+'110'+',';
        sEnterKeyString += 'ed_'+i+'111';
    }

    // переход по нажатию Enter    
    AddListeners(sEnterKeyString, 'onkeydown', TreatEnterAsTab);
}
// проверка заполнености необходимых полей
function fnCheckFieldsClient()
{
    // проверка заполнености полей общая
    if (!fnCheckFields())
        return false;
    return true;
}
// возвращаем результат и закрываем диалог
function fnCloseDialog()
{
    var resultSumm = gE('edResult').value;
    
    window.returnValue = resultSumm;
    window.close();    
}