// JScript File

function test()
{
  var grd  = document.getElementById('gv');
  var row  = grd.rows(1);
  var cell = row.cells(2).innerText;
  alert(cell);
}


/*
 * Функфия выполняет наложение подписи
 */
function GetSigns()
{    
    
    var prev_status = status;
    var status_prefix = document.getElementById('hd_status_sign').value;
        
    var TT_INT = document.getElementById('hd_tt_int').value;
    var TT_EXT = document.getElementById('hd_tt_ext').value;
    var INT_FLAG = parseInt(document.getElementById('hd_int_flag').value);
    var EXT_FLAG = parseInt(document.getElementById('hd_ext_flag').value);
    var params = new Array();
	params['INTSIGN'] = 2;
	params['VISASIGN'] = 1;
	params['SEPNUM'] = 2;
	params['SIGNTYPE'] = "VEG";
	params['SIGNLNG'] = 90;
	params['DOCKEY'] = document.getElementById('hd_key_id').value;
	params['REGNCODE'] = document.getElementById('hd_regncode').value;
	params['BDATE'] = document.getElementById('hd_debug_bankdate').value;
		
	var signDoc = new obj_Sign();	
	
	if( ! signDoc.initObject(params) )	return false;
          
    var grd = document.getElementById('gv');
    var rowsCount = grd.rows.length;
    var firstRow = 1;    
    var str_signs = new String();
    for(i=firstRow; i<rowsCount; i++)
    {
	    var curRow = grd.rows[i];	    	    
	    	    	    
	    var MFOA = curRow.cells(1).innerText;
	    var MFOB = curRow.cells(3).innerText;
	    var VOB  = curRow.cells(6).innerText;	 
	    var BUFFER  = curRow.cells(14).innerText;
	    var BUFFER_INT  = curRow.cells(15).innerText;	 
	    var REF  = curRow.cells(16).innerText;
	    var DOCN = curRow.cells(7).innerText;	    	    
	    
	    var params1 = new Array();
	    params1['FLI'] = '0'; // нам не важен	    
	    if(MFOA==MFOB) 
	        params1['SIGN_FLAG'] = INT_FLAG;
	    else 
	        params1['SIGN_FLAG'] = EXT_FLAG;
	    signDoc.initSystemParams(params1);
		
		var loc_key = signDoc.getIdOper();
		loc_key = (loc_key.length > 6)?(loc_key.substring(2)):(loc_key);
        document.getElementById('hd_key_id').value = loc_key;

	    // замена локального ID ключа, на случай отладочного	    
	    BUFFER = BUFFER.substr(0,428) + loc_key + BUFFER.substr(434,10);
	    
        var params2 = new Array();
        params2['VOB'] = VOB;
        params2['VOB2SEP'] = null;
        params2['DocN'] = DOCN;
        params2['DOCREF'] = REF;
        params2['BUFFER'] = BUFFER;
        params2['BUFFER_INT'] = BUFFER_INT;
    	
        signDoc.initDocParams(params2);
		
        var sign_res = signDoc.getSign();        
        // если ошибка, то просто пропускаем этот документ
        if(!sign_res) 
        {	        
	        return false;
        }
        else
        {
	        if(str_signs.length>0) str_signs += ";";
	        str_signs += signDoc.DOCSIGN_INT + "," + signDoc.DOCSIGN;
	        
        }
        status = status_prefix+" "+i;                
	}
    document.getElementById('hd_signatures').value = str_signs;
	status = prev_status;
	return true;
}