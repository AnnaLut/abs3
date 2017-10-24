function InitRates()
{
 var data = parent.acc_obj.value;
 acc = getParamFromUrl("acc",location.href);
 accessmode = getParamFromUrl("accessmode",location.href);
 if(accessmode != 1) document.all.def.disabled = true;
 LoadXslt("Xslt/RatesData_"+getCurrentPageLanguage()+".xsl");
 v_data[0] = acc;
 v_data[3] = 'a.name';
 var obj = new Object();
 obj.v_serviceObjName = 'webService';
 obj.v_serviceName = 'AccService.asmx';
 obj.v_serviceMethod = 'GetRates';
 obj.v_funcCheckValue = 'fnCheckRates';
 obj.v_serviceFuncAfter = 'AfterRatesTable';
 fn_InitVariables(obj);	
 InitGrid();
}
function AfterRatesTable() {
    if(returnServiceValue[2].text)
        document.getElementById("tdRatesName").innerHTML += "<br>(" + returnServiceValue[2].text + ")";
}
function fnCheckRates()
{
 var re = / /g;
 document.all.TAR.value = document.all.TAR.value.replace(re,'');
 document.all.PR.value = document.all.PR.value.replace(re,'');
 document.all.SMIN.value = document.all.SMIN.value.replace(re, '');
 document.all.KV_SMIN.value = document.all.KV_SMIN.value.replace(re, '');
 document.all.SMAX.value = document.all.SMAX.value.replace(re, '');
 document.all.KV_SMAX.value = document.all.KV_SMAX.value.replace(re, '');
 document.all.BDAT.value = document.all.BDAT.value.replace(re,'');
 document.all.EDAT.value = document.all.EDAT.value.replace(re,'');
 re = /,/g;
 document.all.TAR.value = document.all.TAR.value.replace(re,'.');
 document.all.PR.value = document.all.PR.value.replace(re,'.');
 document.all.SMIN.value = document.all.SMIN.value.replace(re, '.');
 document.all.SMAX.value = document.all.SMAX.value.replace(re,'.');
 SaveR(selectedRowId,
     document.all.TAR.value,
     document.all.PR.value,
     document.all.SMIN.value,
     document.all.SMAX.value,
     document.all.BDAT.value,
     document.all.EDAT.value,
     document.all.KV_SMIN.value,
     document.all.KV_SMAX.value);
}
function onDef()
{
 parent.edit_data.value.rates.tbl = new Array();
 parent.edit_data.value.rates.edit = false;
 ReInitGrid();
 //InitGrid();
}