// JScript File
function selectDeposit()
{
    var dptnum = document.getElementById('DPT_ID').value;
    if (dptnum != null)    
    {       
        document.getElementById('tblDeposit').style.visibility = 'visible';
        
        PageMethods.GetBlocking(dptnum, "1", OnSucceeded, OnFailed);        
        PageMethods.GetDptDates(dptnum,OnSucceeded, OnFailed);        
    }
}
// Callback function invoked on successful 
// completion of the page method.
function OnSucceeded(result, userContext, methodName) 
{    
    if (methodName == 'GetDptDates')
    {
        if (result != null)
        {
            if (result[0] != null)
            {
                document.getElementById('DATBEGIN').value = result[0];
                window['DATBEGIN'].SetValue(result[0]);          
            }
            if (result[1] != null)
            {            
                document.getElementById('DATEND').value = result[1];
                window['DATEND'].SetValue(result[1]);          
            }
        }
    }
    else if (methodName == 'CheckMFO')
    {
        // Немає такого мфо
        if ( parseFloat(result) == 0 )
        {
            alert('Введене МФО не знайдене!');
            document.getElementById(document.getElementById('NOWCKMFO').value).focus();
            document.getElementById(document.getElementById('NOWCKMFO').value).select();
        }
    }
    else if (methodName == 'GetBlocking')
    {
        if (result != null)
        {
            if (result[0] != null)
            {
                document.getElementById('lbBLKD').innerText = result[0];
            }
            if (result[1] != null)
            {            
                document.getElementById('lbBLKK').innerText = result[1];
            }
        }        
    }
}
// Callback function invoked on failure 
// of the page method.
function OnFailed(error, userContext, methodName) 
{
    if(error !== null) 
    {
        var url = "dialog.aspx?type=err";
        url +="?code=" + Math.random();
        window.showModalDialog(url,"",
        "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");    
    }
}
function ckMFO(ctrl_id)
{
    if (isNotEmpty(document.getElementById(ctrl_id).value))
    {
        document.getElementById('NOWCKMFO').value = ctrl_id;
        PageMethods.CheckMFO(document.getElementById(ctrl_id).value,OnSucceeded, OnFailed);            
    }
}
function Verify(idx)
{
    var errn = document.getElementById('err_n').value;
    if (isNotEmpty(errn) && errn != event.srcElement.id)
        return;

    var mfo = document.getElementById('MFO' + idx).value;
    var nls = document.getElementById('ACC' + idx).value;
    
    if (isNotEmpty(mfo) && isNotEmpty(nls))
    {
        if (nls != cDocVkrz(mfo,nls))
        {
            alert('Невірний контрольний розряд!');
            focusControl('ACC' + idx);
            document.getElementById('ACC' + idx).select();
            document.getElementById('err_n').value = 'ACC' + idx;
        }
        else
            document.getElementById('err_n').value = '';
    }
    else
        document.getElementById('err_n').value = '';
}
function ckCtrls()
{
    var overall = 0;
	var data = document.getElementById('SUM_TOVALIDATE').value.split(';');
	for(var id in data)
	{
        if (! isEmpty(document.getElementById(data[id]).value))
        {
		    overall += parseFloat(trim_ex(document.getElementById(data[id]).value));
		    
		    if (parseFloat(trim_ex(document.getElementById(data[id]).value)) > 0)
		    {
		       var elem_arr = new Array('CUR','MFO','ACC','KV','OKPO','NAME','DPTYPE','CARD');   
		       var postfix = data[id].substring(3);
		       for(var sub in elem_arr)
		       {
    	           if (document.getElementById(elem_arr[sub] + postfix))
    	           {
    	                if (isEmpty(document.getElementById(elem_arr[sub] + postfix).value))
    	                {
    	                    alert('Заповніть значення!');
    	                    document.getElementById(elem_arr[sub] + postfix).focus();
    	                    document.getElementById(elem_arr[sub] + postfix).select();
    	                    return false;
    	                }
    	           }
		       }
		    }
	    }
	}
	
	if (overall <= 0)
	{
	    alert('Сума операції нульова!');
	    return false;
    }
	
	if (parseFloat(trim_ex(document.getElementById('MAXSUM').value)) < overall)
	{
	    alert('Сума перевищує максимальну допустиму!');
	    return false;
    }
    return true;
}
/// Фінансова картка рахунку
function ShowDocCard(ref)
{
    var url = "/barsroot/documentview/default.aspx?ref="+ref;

    var top = window.screen.height/2 - 400;
    var left = window.screen.width/2 - 400;

	window.open(encodeURI(url),"_blank",
	"left=" + left + ",top=" + top + 
	",height=800px,width=800px,menubar=no,toolbar=no,location=no,titlebar=no,resizable=yes,scrollbars=yes");
    
//	var result = window.showModalDialog(encodeURI(url), null,
//	"dialogWidth:800px; dialogHeight:600px; center:yes; status:no");
}
function ShowDocs()
{
    var url = "showdoc.aspx?dpt_id=" + document.getElementById('DPT_ID').value;
    url +="&code=" + Math.random();

    var top = window.screen.height/2 - 400;
    var left = window.screen.width/2 - 400;

	window.open(encodeURI(url),"_blank",
	"left=" + left + ",top=" + top + 
	",height=800px,width=800px,menubar=no,toolbar=no,location=no,titlebar=no,resizable=yes,scrollbars=yes");

//	var result = window.showModalDialog(encodeURI(url), null,
//	"dialogWidth:800px; dialogHeight:600px; center:yes; status:no");    
}
function ShowHistory()
{
    var url = "history.aspx?dpt_id=" + document.getElementById('DPT_ID').value;
    url +="&code=" + Math.random();

    var top = window.screen.height/2 - 400;
    var left = window.screen.width/2 - 400;

	window.open(encodeURI(url),"_blank",
	"left=" + left + ",top=" + top + 
	",height=800px,width=800px,menubar=no,toolbar=no,location=no,titlebar=no,resizable=yes,scrollbars=yes");
}
function trim_ex(val)
{
    return val.replace(/ /g,"");
}
function ShowDepositCard(dpt_id)
{
    var url = "/barsroot/deposit/depositcontractinfo.aspx?dpt_id=" + dpt_id + "&readonly=true";
    url +="&code=" + Math.random();
    var top = window.screen.height/2 - 400;
    var left = window.screen.width/2 - 400;

	window.open(encodeURI(url),"_blank",
	"left=" + left + ",top=" + top + 
	",height=800px,width=800px,menubar=no,toolbar=no,location=no,titlebar=no,resizable=yes,scrollbars=yes");
}
function Acc(acc) {
	window.open(encodeURI("/barsroot/customerlist/showhistory.aspx?acc=" + acc + "&type=0"),null,
	"height=600,width=600,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
}
function AccCard(acc) {
	window.open(encodeURI("/barsroot/viewaccounts/accountform.aspx?type=2&acc=" + acc + "&rnk=&accessmode=1"),null,
	"height=600,width=600,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
}
function GetClientCard(rnk) {
	window.open(encodeURI("/barsroot/clientregister/registration.aspx?readonly=1&rnk=" + rnk),null,
	"height=600,width=600,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
}
