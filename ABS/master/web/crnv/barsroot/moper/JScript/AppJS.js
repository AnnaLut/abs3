// JScript File с функциями необходимыми для работы приложения

/*
 * Функфия выполняет наложение подписи
 */
function GetSigns()
{
    var params = new Array();
	params['INTSIGN'] = gE('INTSIGN').value;
	params['VISASIGN'] = gE('VISASIGN').value;
	params['SEPNUM'] = gE('SEPNUM').value;
	params['SIGNTYPE'] = gE('SIGNTYPE').value;
	params['SIGNLNG'] = gE('SIGNLNG').value;
	params['DOCKEY'] = gE('DOCKEY').value;
	params['REGNCODE'] = gE('REGNCODE').value;
	params['BDATE'] = gE('BDATE').value;
	
    // конструктор класса подписи
	var signDoc = new obj_Sign();
	
	if( signDoc.initObject(params) )
    {
        var grd = gE('grd_Data');
        var rowsCount = grd.rows.length;
        var firstRow = 1;
 	    
 	    for(i=firstRow; i<rowsCount; i++)
 	    {
		    var curRow = grd.rows[i];
		    
		    /*
		    0  REF
            1  ND
            2  MFOA
            3  NLSA
            4  OKPOA
            5  NAMEA
            6  MFOB
            7  NLSB
            8  OKPOB
            9  NAMEB
            10 S
            11 NAZN
            12 DK
            13 DATD
            14 VDAT
            15 TT
            16 VOB
            17 FLI
            18 INPUTSIGNFLAG
            19 NOMINAL
            20 SEPBUF
            21 INTBUF
            */		    
		    
    	    var params1 = new Array();
	    	params1['FLI'] = curRow.cells[17].innerText;
		    params1['SIGN_FLAG'] = curRow.cells[18].innerText;
	
            // инициализация системных параметров
    		signDoc.initSystemParams(params1);
			
		    var loc_key = signDoc.getIdOper();
		    loc_key = (loc_key.length > 6)?(loc_key.substring(2)):(loc_key);
            params['DOCKEY'].value = loc_key;
            
            var sepBuff = curRow.cells[20].innerText;
            sepBuff = sepBuff.substring(0,428) + loc_key + sepBuff.substring(434);
            
            var params2 = new Array();
	        params2['VOB'] = curRow.cells[16].innerText;
	        params2['VOB2SEP'] = curRow.cells[16].innerText;
	        params2['DocN'] = curRow.cells[1].innerText;
	        params2['DOCREF'] = curRow.cells[0].innerText;
	        params2['BUFFER'] = sepBuff;
	        params2['BUFFER_INT'] = curRow.cells[21].innerText;
	
            // инициализация параметров документа
        	signDoc.initDocParams(params2);
	    
	        // наложение подписи
        	var sign_res = signDoc.getSign();
			
		    var REF = curRow.cells[0].innerText;
		    gE('ed_hid_int_' + REF).value = signDoc.DOCSIGN_INT;
		    gE('ed_hid_ext_' + REF).value = signDoc.DOCSIGN;
		}
		    
		// есть ли ошибки
        gE('ScriptErrors').value = signDoc.showErrorsDialog();		    
		
		// берем ключ (при включеном дебаге он может отличаться)
		gE('DOCKEY').value = (signDoc.DOCKEY.length > 6)?(signDoc.DOCKEY.substring(2)):(signDoc.DOCKEY);;
	}
    else
	{
	    gE('ScriptErrors').value = '1';
	}
}