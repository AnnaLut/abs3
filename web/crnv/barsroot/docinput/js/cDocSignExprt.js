var aSigner;	// объект для наложения ЭЦП

window.attachEvent("onload",InitActiveX);

function InitActiveX()
{
  try
  {
	  var avialibleAx = new ActiveXObject("BARSAX.RSAC");
  }
  catch(e)
  {
	  alert(LocalizedString('Message20'));
	  //alert("Не обнаружено необходимых для цифровой подписи компонентов.\nПосле установки предложенных компонент повторите оплату.");
	  ShowDownloadPage();
	  return;
  }
  var version = document.getElementById("BARSAXVER").value;
  if("" == version) version = "-1,-1,-1,-1";
  str_object_barsax= '<OBJECT id="oSignerCheckVersion" '+
					 'codeBase="/Common/Script/Components/barsax.cab#version='+version+'" '+
	                 'classid="clsid:DD447E04-7CAE-498B-8C0B-17C8C99C31C9" '+
					 'VIEWASTEXT BORDER=0 VSPACE=0 HSPACE=0 ALIGN=TOP HEIGHT=0% WIDTH=0%></OBJECT>';
  var elem = document.createElement(str_object_barsax);
  document.body.insertAdjacentElement("beforeEnd",elem);
}

/**
 * InitSigner() - выполняет инициализацию объекта для наложения ЭЦП
 */
function InitSigner(strSignType)
{
	try
	{
	  if(parent.frames.length != 0 && parent.frames["header"].oSigner != null)
         aSigner = parent.frames["header"].oSigner;
	  if (!aSigner) aSigner = new ActiveXObject("BARSAX.RSAC");
	  if(parent.frames.length != 0)
         parent.frames["header"].oSigner = aSigner;
	}
	catch(e)
	{
	  alert(LocalizedString('Message20'));
	  //alert("Не обнаружено необходимых для цифровой подписи компонентов.\nПосле установки предложенных компонент повторите оплату.");
	  ShowDownloadPage();
	  return;
	}
	if (!aSigner.IsInitialized) aSigner.Init(strSignType);
	if (!aSigner.IsInitialized) 
	{ 
		//if(1 == confirm("Система безопасности НЕ инициализирована.\nВозможно не установлены все необходимые компоненты. Показать окно загрузки компонент?"))
		if(1 == confirm(LocalizedString('Message21')))
		{
		  ShowDownloadPage();
		}
		return false; 
	}
	return true;
}

function ShowDownloadPage()
{
  window.showModalDialog("/Common/Script/Components/DownloadPage.htm?key"+Math.random(),window,"dialogHeight:380px;center:yes;edge:sunken;help:no;status:no;");
}


function signDocs()
{  
    //
    //глобальные параметры подписи
    //
    var params = new Array();
    
    params['DOCKEY'] = document.getElementById('DOCKEY').value;
    params['SEPNUM'] = document.getElementById('SEPNUM').value;
    params['SIGNTYPE'] = document.getElementById('SIGNTYPE').value;
    params['REGNCODE'] = document.getElementById('REGNCODE').value;    
    
    // необходимо подписать по принципу СЭП
    if(!InitSigner(params['SIGNTYPE'])) return false;
    // банковская дата    
    aSigner.BankDate = document.getElementById('BDATE').value;
    // обработка версии СЭП (1/2)
    if (1 == params['SEPNUM'])
	    aSigner.BufferEncoding = "DOS";
    else 
	    aSigner.BufferEncoding = "WIN"; 
    //Для VEG-подписи добавляем 2 символа из REGNCODE
    if("VEG" == params['SIGNTYPE'])
	    aSigner.IdOper = params['REGNCODE'].value + params['DOCKEY'];
    else
	    aSigner.IdOper = params['DOCKEY'];
    // обратное присвоение на случай если ключ прописан локально в реестре
    params['DOCKEY'] = aSigner.IdOper;	
    if(params['DOCKEY'].length > 6)
	    params['DOCKEY'] = params['DOCKEY'].substring(params['DOCKEY'].length-6);
	// запомнить IDOPER		
    var idOper = document.getElementById('IDOPER');
    if (idOper != null)
      idOper.value = params['DOCKEY'];
    //
    // цикл по всем строкам
    //
    var grid = document.getElementById('gv');
    if (null == grid) return;
    var rowsCount = grid.rows.length;
    var firstRow = 1;
    var aSigns = "";
    for( i = firstRow; i < rowsCount ; i++)
    {  
	    var curRow = grid.rows[i];
	    //продолжать дальше только если чекбокс отмечен 
	    var checkBox = grid.rows[i].cells[0].firstChild;
	    if (checkBox == null) 
	      continue;
	    if (!checkBox.checked)
	      continue;
	    
		// формирование буфера для наложения ЭЦП
		var str_buf = curRow.cells[2].innerText;
		// наложение самой ЭЦП
		var aSignBuf = aSigner.SignBufferHex(str_buf);
		
		if( 0 == aSignBuf.length )
		{ 
			alert(LocalizedString('Message22'));//alert("Ошибки при наложении ЭЦП");
			return false; 
		}
		else
		{ 
		    var docId = curRow.cells[1].innerText;
            aSigns += docId+"|"+curRow.cells[3].innerText+"="+aSignBuf+";";
		}
		
	}
	// передать данные серверу
    var theForm = document.forms['formDocExport'];
    if (null != theForm && "" != aSigns )
    {
      theForm.SIGNS.value = aSigns;
      theForm.submit();      
    }
}
