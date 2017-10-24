///
function LoadQuery()
{
	window.document.getElementById("DptNum").attachEvent("onkeydown",doNum);
	window.document.getElementById("OKPO").attachEvent("onkeydown",doNum);
	window.document.getElementById("DocNumber").attachEvent("onkeydown",doNum);
	
	window.document.getElementById("FirstName").attachEvent("onkeydown",doAlpha);
	window.document.getElementById("LastName").attachEvent("onkeydown",doAlpha);
	window.document.getElementById("Patronimic").attachEvent("onkeydown",doAlpha);
	window.document.getElementById("DocSerial").attachEvent("onkeydown",doAlpha);				

    webService.useService("QueryService.asmx?wsdl","Que");        
}
function SubmitQuery()
{
    var data = new Array();
    
    data[0] = window.document.getElementById('listType').value;
    data[1] = window.document.getElementById('listBranch').value;
    data[2] = window.document.getElementById('DptNum').value;
    data[3] = window.document.getElementById('FirstName').value;
    data[4] = window.document.getElementById('Patronimic').value;
    data[5] = window.document.getElementById('LastName').value;
    data[6] = window.document.getElementById('OKPO').value;
    data[7] = window.document.getElementById('DocSerial').value;
    data[8] = window.document.getElementById('DocNumber').value;
    data[9] = window.document.getElementById('DocDate_TextBox').value;
    data[10] = GetValue('Sum');
    
    webService.Que.callService(onSubmitQuery, "SubmitQuery",data);       
}
function onSubmitQuery(result)
{
    if (!getError(result)) return;
    
    BarsAlert("Повідомлення","Запит успішно прийнятий!",4,0);
    location.replace('QueryAnswer.aspx');
}
function GetQueries()
{
    if(!isPostBack) 
	    FillGrid_Queries();
	else 
	    ReInitGrid();
}
// Заповнення гріда учасників протокола
function FillGrid_Queries()
{
    webService.useService("QueryService.asmx?wsdl","Load");
	
	LoadXslt('XSL/QueryState.xsl');
  	var obj = new Object();
	obj.v_serviceObjName = 'webService';
	obj.v_serviceName = 'QueryService.asmx';
	obj.v_serviceMethod = 'LoadQueries';
	obj.v_showFilterOnStart = false;
    obj.v_filterTable = "GQ_QUERY";
    v_data[3] = "QUERY_ID DESC";
	fn_InitVariables(obj);	
	InitGrid();
	isPostBack = true;			
}
function Response(txt)
{
    if ( (txt==null) || (txt=='') )
    {
        BarsAlert("Помилка","Не вибрано жоден інформаційний запит!",1,0);
        return;
    }
    
    location.replace("QueryResult.aspx?query_id=" + txt);
}
function LoadResponse()
{
    var query = searchURLforREF('query_id');   
    
    webService.useService("QueryService.asmx?wsdl","Que");         
    webService.Que.callService(onLoadResponse, "LoadResponse",query);           
}
function onLoadResponse(result)
{
    if (!getError(result)) return;
    var resp = result.value;
    
    window.document.getElementById('ID').value = searchURLforREF('query_id');    
    window.document.getElementById('Branch').value = resp[12].text;
    window.document.getElementById('DptNum').value = resp[13].text;
    window.document.getElementById('LastName').value = resp[16].text;        
    window.document.getElementById('FirstName').value = resp[14].text;        
    window.document.getElementById('Patronimic').value = resp[15].text;        
    window.document.getElementById('OKPO').value = resp[17].text;        
    window.document.getElementById('DocSerial').value = resp[18].text;  
    window.document.getElementById('DocNumber').value = resp[19].text;  
    window['DocDate'].SetValue(resp[20].text);      
    window.document.getElementById('Sum').value = resp[21].text*1 / 100;                

    window.document.getElementById('ErrorMessage').value = resp[1].text;    
           
    window.document.getElementById('DPT_NLS').value = resp[2].text;                
    window.document.getElementById('DPT_KV').value = resp[3].text;                
    window.document.getElementById('DPT_OST').value = resp[4].text*1 / 100;                
    window.document.getElementById('DPT_OST_A').value = resp[5].text*1 / 100;                
    window.document.getElementById('INT_NLS').value = resp[6].text;                
    window.document.getElementById('INT_KV').value = resp[7].text;                
    window.document.getElementById('INT_OST').value = resp[8].text*1 / 100;                
    window.document.getElementById('INT_OST_A').value = resp[9].text*1 / 100;                
    window.document.getElementById('TransfAm').value = resp[10].text*1 / 100;                
    window.document.getElementById('DocRef').value = resp[11].text; 
    
    init_numedit("Sum",(""==document.getElementById("Sum").value)?(0):(document.getElementById("Sum").value),2);
    init_numedit("DPT_OST",(""==document.getElementById("DPT_OST").value)?(0):(document.getElementById("DPT_OST").value),2);
    init_numedit("DPT_OST_A",(""==document.getElementById("DPT_OST_A").value)?(0):(document.getElementById("DPT_OST_A").value),2);
    init_numedit("INT_OST",(""==document.getElementById("INT_OST").value)?(0):(document.getElementById("INT_OST").value),2);
    init_numedit("INT_OST_A",(""==document.getElementById("INT_OST_A").value)?(0):(document.getElementById("INT_OST_A").value),2);
    init_numedit("TransfAm",(""==document.getElementById("TransfAm").value)?(0):(document.getElementById("TransfAm").value),2); 
    
    window.document.getElementById('TNLS').value = resp[22].text;    
    window.document.getElementById('ORGAN').value = resp[23].text;
    window.document.getElementById('BDAY').value = resp[24].text;
    window.document.getElementById('ADR').value = resp[25].text;
    
    if (resp[11].text == null || resp[11].text == '')
    {
        window.document.getElementById('btPay').disabled = true;        
    }
    else
    {
        window.document.getElementById('btPay').disabled = false;        
    }
}

function PayDoc()
{
	var url = "/barsroot/DocInput/DocInput.aspx?tt=DP4";
	
	var sum = parseFloat(document.getElementById("TransfAm").value);
	sum = Math.round(sum * 100);
	
	if (sum == null || sum <= 0)
	{
        BarsAlert("Помилка","Нульова сума! Оплата неможлива!",1,0);
        return;	    
	}
		
    url += "&SumC_t=" + sum;
	
	url += "&nd=" + window.document.getElementById('DptNum').value;
	
	url += "&Kv_A=" + window.document.getElementById('INT_KV').value;
	url += "&Kv_B=" + window.document.getElementById('INT_KV').value;
	url += "&Nls_A=" + window.document.getElementById('TNLS').value;

    var dop_rec = '';
	dop_rec += "&reqv_FIO=" + window.document.getElementById('LastName').value + ' ' +
        window.document.getElementById('FirstName').value + ' ' +
        window.document.getElementById('Patronimic').value;        

	dop_rec += "&reqv_PASP=паспорт" ;
	dop_rec += "&reqv_PASPN="+ window.document.getElementById('DocSerial').value + ' '
	    + window.document.getElementById('DocNumber').value;
	dop_rec += "&reqv_ATRT=" +window.document.getElementById('ORGAN').value + ' ' 
	    + window.document.getElementById('DocDate_TextBox').value;
	dop_rec += "&reqv_ADRES=" + window.document.getElementById('ADR').value;
	dop_rec += "&reqv_DT_R=" + window.document.getElementById('BDAY').value;
	
	url += dop_rec;
				
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	  
	
	sum = sum / 100;

	var dpf = ckDPF(window.document.getElementById("INT_KV").value,sum);
	if (dpf > 0)
	{		
		dpf = Math.round(dpf);		
		DPF(dpf,document.getElementById("INT_KV").value,
		document.getElementById("DptNum").value,dop_rec);
	}
}
// Оплата операції викупу центів
function DPF(sum,kv,dpt_id,dop_rec)
{
	var op_name = 'DPF';
	if (op_name == '' || op_name == "")
		return;
		
	var url = "/barsroot/DocInput/DocInput.aspx?tt="+op_name;
	url += "&nd="		+ dpt_id;
	url += "&Kv_A="		+ kv;
	url += "&Kv_B=980";
	url += "&SumA_t="	+ sum;
	url += dop_rec;
	
	window.showModalDialog(encodeURI(url),null,
	"dialogWidth:700px; dialogHeight:800px; center:yes; status:no");	
}
// Перевірка на наявність центів для викупу
function ckDPF(kv,sum)
{
	sum = sum * 100;
	if (kv == 980)
		return 0;
	if (kv == 978)
		return sum%500;
	else
		return sum%100;
}
function ClearQuest()
{
    var query = searchURLforREF('query_id');   
    
    var callObj = window.document.getElementById("webService").createCallOptions();
	
    callObj.async = false;
    callObj.funcName = 'ClearQuest';
    callObj.params = new Array();
    callObj.params.query = query;

    var result = webService.Que.callService(callObj);
    if (result.error) 
    {
        window.showModalDialog("dialog.aspx?type=err",
            "","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        return false;
    }

    BarsAlert("Повідомлення","Запит успішно закрито!",4,0);    
}
//function onClearQuest(result)
//{
//    if (!getError(result)) return;
//    BarsAlert("Повідомлення","Запит успішно закрито!",4,0);    
//    location.replace('QueryAnswer.aspx');
//}
