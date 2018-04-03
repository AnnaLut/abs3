//------Открывает страничку "список виз даной групы"----
function GetDocsList(GRPID)
{
	var args = unescape(location.search.substring(1, location.search.length));
	var type  = args.split('=')[1];
	if(type=="3")
	    location.replace('verifdoc.aspx?grpid=' + GRPID);
	else
	    location.replace('Documents.aspx?type=' + type + '&grpid=' + GRPID);
}

//Верификация ввода
function initverifdoc()
{
  webService.useService("Service.asmx?wsdl","Verif");
  webService.Verif.callService(onCheckVerifAbility,"CheckVerifAbility");
  init_num("txtNlsA");
  init_num("txtNlsB");
  init_num("txtMfoB");
  init_num("txtOkpoB");
  init_numedit("txtSum");
}
function onCheckVerifAbility(result)
{
 if(!getError(result)) return;
 fillDataVerif();
}
function fillDataVerif()
{
  var obj = new Object();
  LoadXslt("Xslt/Verif_"+getCurrentPageLanguage()+".xsl");
  v_data[10] = getParamFromUrl("grpid",location.href);
  obj.v_serviceObjName = 'webService';
  obj.v_serviceName = 'Service.asmx';
  obj.v_serviceMethod = 'GetVerifDocData';
  obj.v_serviceFuncAfter = 'CheckColumns';
  obj.v_filterTable = "oper";
  
  fn_InitVariables(obj);	
  InitGrid();
}

function hideColumn(elem)
{
    var colNum = 3;
    if(elem.id == "cbNlsA") colNum = 3;
    else if(elem.id == "cbMfoB") colNum = 4;
    else if(elem.id == "cbNlsB") colNum = 5;
    else if(elem.id == "cbOkpoB") colNum = 6;
    
    var oTable = document.getElementById("tblVerif");
    for (curr_row = 0; curr_row < oTable.rows.length; curr_row++)
    {
       oRow = oTable.rows[curr_row];
       
       if(curr_row == 0)
        oRow.cells[colNum].innerText = (elem.checked)?(oRow.cells[colNum].title):("");
       else 
        oRow.cells[colNum].innerText = "";
       oRow.cells[colNum].style.padding = (elem.checked)?(1):(0);
       oRow.cells[colNum].style.borderWidth = (elem.checked)?(1):(0);
       oRow.cells[colNum].style.width = (elem.checked)?("100"):("0");
       oRow.cells[colNum+1].style.borderLeftWidth = (elem.checked)?(1):(0);
       if(colNum > 3)
          oRow.cells[colNum-1].style.borderLeftWidth = (elem.checked)?(1):(0);
    }   
}
function HideTextFields()
{
  document.all.txtNlsA.style.visibility = "hidden";
  document.all.txtNlsB.style.visibility = "hidden";
  document.all.txtMfoB.style.visibility = "hidden";
  document.all.txtOkpoB.style.visibility = "hidden";
  document.all.txtSum.style.visibility = "hidden";
}
function verifData(elem)
{
  var currval = elem.value;
  var realval = "";
  if(elem.id == "txtNlsA")
      realval = selectedRow.NLSA;
  else if(elem.id == "txtMfoB")
      realval = selectedRow.MFOB;
  else if(elem.id == "txtNlsB")
      realval = selectedRow.NLSB;
  else if(elem.id == "txtOkpoB")
      realval = selectedRow.ID_B;
  else if(elem.id == "txtSum"){
      realval = selectedRow.SUM;
      currval = parseFloat(currval);
  }
  if(currval != realval){
     alert(LocalizedString('Message3')/*'Неверное значение!'*/);
     currCell.innerText = "";
  }
  else
  {
    currCell.innerText = elem.value;
    verifAllData();
  }
  elem.style.visibility = "hidden";
}

function verifAllData()
{
  var res = (document.all.cbNlsA.checked)?(document.getElementById("c1_"+row_id).innerText!=""):(true);
  res = res && ((document.all.cbMfoB.checked)?(document.getElementById("c2_"+row_id).innerText!=""):(true));
  res = res && ((document.all.cbNlsB.checked)?(document.getElementById("c3_"+row_id).innerText!=""):(true));
  res = res && ((document.all.cbOkpoB.checked)?(document.getElementById("c4_"+row_id).innerText!=""):(true));
  res = res && (document.getElementById("c5_"+row_id).innerText!="");
  if(res){
    if(!putVisa(0)) 
        currCell.innerText = "";
    HideTextFields();
  }
}

var currCell = null;
function showControl(cell,elem)
{
  currCell = cell;
  HideTextFields();
  elem.style.top = cell.offsetTop+75;
  elem.style.left = cell.offsetLeft+10;
  elem.style.width = cell.offsetWidth-5;
  elem.value = cell.innerText;
  elem.style.visibility = "visible";
  elem.focus();
}

function showNlsA()
{
    showControl(event.srcElement, document.all.txtNlsA);
}
function showMfoB()
{
    showControl(event.srcElement, document.all.txtMfoB);
}
function showNlsB()
{
    showControl(event.srcElement, document.all.txtNlsB);
}
function showOkpoB()
{
    showControl(event.srcElement, document.all.txtOkpoB);
}
function showSum()
{
    showControl(event.srcElement, document.all.txtSum);
}

function RefreshClk()
{
  ReInitGrid();
}
function CheckColumns()
{
  if(!document.all.cbNlsA.checked)
    document.all.cbNlsA.fireEvent("onclick");
  if(!document.all.cbNlsB.checked)
    document.all.cbNlsB.fireEvent("onclick");
  if(!document.all.cbMfoB.checked)
    document.all.cbMfoB.fireEvent("onclick");
  if(!document.all.cbOkpoB.checked)
    document.all.cbOkpoB.fireEvent("onclick");
}

//Visa

function putVisa(par)
{
	var grpId = document.getElementById('hid_grpid').value;
	var refs = new Array();
	refs[0] = selectedRowId;
	    var msg = escape(LocalizedString('Message1')+" (ref="+selectedRowId+")?"/*'Визировать документ?'*/);
		if(par == 10)
		{
			msg = escape(LocalizedString('Message2')/*'Вернуть документ?'*/);		
		}
		
		var ask = window.showModalDialog("dialog.aspx?type=confirm&message="+msg, 'dialogHeight:300px; dialogWidth:400px');
		if(ask == '1')
		{
			document.getElementById("webService").useService('Service.asmx?wsdl','PutVisaService');	
			document.getElementById("webService").async = false;

			var callObj = document.getElementById("webService").createCallOptions();
			callObj.async = false;
			callObj.funcName = 'GetDataForVisa';
			callObj.params = new Array();
			callObj.params.grpId = grpId;
			callObj.params.refs = refs;
			callObj.params.type = 3;
			callObj.params.output = new Array();

			var result = webService.PutVisaService.callService(callObj);
			if (result.error) 
			{
				window.showModalDialog("dialog.aspx?type=err","","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
			} 
			else
			{					
				if(result.value[0].text != 0)
				{
					var msg = escape(result.value[0].text);
					if(msg.length > 1800) msg = msg.substr(0,1800) + escape('..............');
					window.showModalDialog("dialog.aspx?type=1&message="+msg, 'dialogHeight:300px; dialogWidth:400px');
				}
				if(result.value[1].text != 0)
				{
					xml_visaData.loadXML(result.value[1].text);
					
					//---------------------------------------------------------
					// проверяем и подписываем
					    var params = new Array();
                		params['INTSIGN'] = document.getElementById('__INTSIGN').value;
                		params['VISASIGN'] = document.getElementById('__VISASIGN').value;
						params['SEPNUM'] = document.getElementById('__SEPNUM').value;
						params['SIGNTYPE'] = document.getElementById('__SIGNTYPE').value;
						params['SIGNLNG'] = document.getElementById('__SIGNLNG').value;
						params['DOCKEY'] = document.getElementById('__DOCKEY').value;
						params['REGNCODE'] = document.getElementById('__REGNCODE').value;
						params['BDATE'] = document.getElementById('__BDATE').value;
						
						var signDoc = new obj_Sign();
						
						if( signDoc.initObject(params) )
						    xml_putVisaData = SignDocs(xml_visaData, grpId, par, signDoc);
						    
						signDoc.showErrorsDialog();
					//---------------------------------------------------------
					
					//собственно визируем					
					var callObj = document.getElementById("webService").createCallOptions();
					callObj.async = false;
					callObj.funcName = 'PutVisas';
					callObj.params = new Array();
					callObj.params.VisaData = encodeURI(xml_putVisaData.xml);
					callObj.params.type = 3;
					callObj.params.output = new Array();
					var result1 = webService.PutVisaService.callService(callObj);
					if (result1.error)
					{
					    window.showModalDialog("dialog.aspx?type=err","","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
					    return false;
					} 
					else
					{
						var msg1 = escape(result1.value.text);
						if(msg1.length > 2000)
						{
							msg1 = msg1.substring(0, 2000) + escape('<BR>...');
						}
						window.showModalDialog("dialog.aspx?type=1&message="+msg1, 'dialogHeight:300px; dialogWidth:400px');
						RefreshClk();
						return true;
					}
				}	
			}
	}
}



//Обработка ошибок от веб-сервиса
function getError(result)
{
  if(result.error){
     if(window.dialogArguments){
       window.showModalDialog("dialog.aspx?type=err","","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
  } 
  else
     location.replace("dialog.aspx?type=err");
   return false;
 }
 return true;
}
function getParamFromUrl(param,url)
{
 url = url.substring(url.indexOf('?')+1); 
 for(i = 0; i < url.split("&").length; i++)
 if(url.split("&")[i].split("=")[0] == param) return url.split("&")[i].split("=")[1]; 
 return "";
}