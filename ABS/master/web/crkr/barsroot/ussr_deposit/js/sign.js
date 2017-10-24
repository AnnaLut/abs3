// 
function GetSign(controlBuffer, controlSign, fli, inputsignflag)
{
    if(needToBeSign(fli, inputsignflag))
    {
        var params = new Array();
        params['INTSIGN'] = document.getElementById('INTSIGN').value;
        params['VISASIGN'] = document.getElementById('VISASIGN').value;
        params['SEPNUM'] = document.getElementById('SEPNUM').value;
        params['SIGNTYPE'] = document.getElementById('SIGNTYPE').value;
        params['SIGNLNG'] = document.getElementById('SIGNLNG').value;
        params['DOCKEY'] = document.getElementById('DOCKEY').value;
        params['REGNCODE'] = document.getElementById('REGNCODE').value;
        params['BDATE'] = document.getElementById('BDATE').value;

        // конструктор класса подписи
        var signDoc = new obj_Sign();

        if( signDoc.initObject(params) )
        {
            var params1 = new Array();
            /// Внутрішній підпис
            params1['SIGN_FLAG'] = '1';

            // инициализация системных параметров
            signDoc.initSystemParams(params1);
        		        		
            var params2 = new Array();
            // флаг внутренней ЭЦП
	        var num_INTSIGN = parseInt(document.getElementById('INTSIGN').value);
            if( 2 == num_INTSIGN && (1 == inputsignflag || 3 == inputsignflag)) 
                params2['BUFFER_INT'] = document.getElementById(controlBuffer).value;
            else
                params2['BUFFER'] = document.getElementById(controlBuffer).value;

            // инициализация параметров документа
            signDoc.initDocParams(params2);
            
            // берем ключь
            document.getElementById('DOCKEY').value = signDoc.getIdOper();
            
            // подписываем
            var sign_res = signDoc.getSign();
            // если ошибка, то просто пропускаем этот документ
            if(!sign_res)
            {
                signDoc.showErrorsDialog();
                return false;	
            }
            else
            {
                if( 2 == num_INTSIGN && (1 == inputsignflag || 3 == inputsignflag))             
                    document.getElementById(controlSign).value = signDoc.DOCSIGN_INT;
                else
                    document.getElementById(controlSign).value = signDoc.DOCSIGN;
                alert('Документ успішно підписаний!');                    
            }		
        }
        else return false;
    } 
    else
        alert('Підпис не потрібен!');
    
    return true;       
}

/**
 * проверяет нужно ли на текущем документе ЭЦП
 */
function needToBeSign(num_FLI, num_INPUT_SIGN_FLAG)
{
	// флаг внутренней ЭЦП
	var num_INTSIGN = parseInt(document.getElementById('INTSIGN').value);
	// флаг типа документа: 0-внутр., 1-СЭП НБУ, 2-SWIFT, 3-Процессинг СЭП
	//var num_FLI	= parseInt(form.__FLAGS.value.substring(64,65));
	// номер версии СЭП (1/2)
	var num_SEPNUM  = parseInt(document.getElementById('SEPNUM').value);
	// флаг ЭЦП при вводе (0-нет,1-внутр,2-внешн,3-внутр+внешн)
	//var num_INPUT_SIGN_FLAG = parseInt(form.__FLAGS.value.substring(1,2));
	
	//требуется внешняя подпись
	if(	(1 == num_INTSIGN && 0 == num_FLI )								// включена внешняя ЭЦП на внутренних документах
	||  (1 == num_FLI && (0 == num_INTSIGN || 1 == num_INTSIGN ))		// документ Межбанковский СЭП-НБУ
	// или включена ЭЦП 2-го вида и требуется внешняя ЭЦП на документ
	||  2 == num_INTSIGN && (2 == num_INPUT_SIGN_FLAG || 3 == num_INPUT_SIGN_FLAG)
	) return true;
	
	//требуется внутренняя ЭЦП на документ
	if( 2 == num_INTSIGN 
	&& (1 == num_INPUT_SIGN_FLAG || 3 == num_INPUT_SIGN_FLAG)
	) return true;
	
	return false;
}
