function InitSob()
{
 //Локализация
 LocalizeHtmlTitles();
 var data = parent.acc_obj.value;
 acc = getParamFromUrl("acc",location.href);
 accessmode = getParamFromUrl("accessmode",location.href);
 if(accessmode != 1) document.all.a_d.style.visibility = 'hidden';
 LoadXslt("Xslt/SobData_"+getCurrentPageLanguage()+".xsl");
 v_data[0] = acc;
 v_data[3] = 'a.fdat';
 var obj = new Object();
 obj.v_serviceObjName = 'webService';
 obj.v_serviceName = 'AccService.asmx';
 obj.v_serviceMethod = 'GetSob';
 obj.v_funcCheckValue = 'fnCheckSob';
 obj.v_funcDelRow = 'onDelRow';
 fn_InitVariables(obj);	
 InitGrid();
}
function fnCheckSob()
{
 SaveS(selectedRowId,document.getElementById("FDAT").value,document.getElementById("TXT").value);
}
function Add()
{
 var currDate = new Date();
 AddRow('ID');
 document.getElementById('FDAT').value = currDate.getDate()+"/"+eval(currDate.getMonth()+1)+"/"+currDate.getFullYear();
 document.getElementById('ISP').value = parent.acc_obj.value[54].text;
 document.getElementById('FIO').value = parent.acc_obj.value[57].text;
}
function onDelRow(node)
{
 if(node.childNodes[0].text == '' || node.childNodes[0].text.substring(0,1) == 'n')
   parent.edit_data.value.sob.tbl[node.childNodes[0].text] = null;
 else 
   SaveS(selectedRowId,'del','');
}
//Локализация
function LocalizeHtmlTitles() { 
    LocalizeHtmlTitle("add");
    LocalizeHtmlTitle("del");
}