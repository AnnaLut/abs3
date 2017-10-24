function InitManualTable(tabName)
{
	LoadXslt('/Common/ManualTable/ManualTableXsl_' + getCurrentPageLanguage() + '.xsl');
	v_data[3] = 'ID ASC';//order
	var obj = new Object();
	obj.v_serviceObjName = 'webService';
	obj.v_serviceName = location.protocol +'//'+ location.hostname;
    if(location.port != "" && location.port != "80") obj.v_serviceName += ":"+location.port;
    obj.v_serviceName += '/barsroot/webservices/WebServices.asmx';
	obj.v_serviceMethod = 'GetManualTable';
	obj.v_xmlFilenameFilter = '/Common/ManualTable/ManualTableXsl_' + getCurrentPageLanguage() + '.xml'
	fn_InitVariables(obj);	
	InitGrid();
 }

function InitMetaTable()
{
	LoadXslt('/Common/ManualTable/MetaTableXsl_' + getCurrentPageLanguage() + '.xsl');
	var obj = new Object();
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = location.protocol +'//'+ location.hostname;
    if(location.port != "" && location.port != "80") obj.v_serviceName += ":"+location.port;
    obj.v_serviceName += '/barsroot/webservices/WebServices.asmx';
    obj.v_serviceMethod = 'GetMetaTable';
    obj.v_serviceFuncAfter = 'InitSelection';
    obj.v_xmlFilenameFilter = '/Common/ManualTable/ManualTableXsl_' + getCurrentPageLanguage() + '.xml'
    fn_InitVariables(obj);	
	InitGrid();
}
function InitMetaTable_Req()
{
	LoadXslt('/Common/ManualTable/MetaTableXsl_' + getCurrentPageLanguage() + '.xsl');
	var obj = new Object();
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = location.protocol +'//'+ location.hostname;
    if(location.port != "" && location.port != "80") obj.v_serviceName += ":"+location.port;
    obj.v_serviceName += '/barsroot/webservices/WebServices.asmx';
    obj.v_serviceMethod = 'GetMetaTable_Req';
    obj.v_serviceFuncAfter = 'InitSelection';
    obj.v_xmlFilenameFilter = '/Common/ManualTable/ManualTableXsl_' + getCurrentPageLanguage() + '.xml'
    fn_InitVariables(obj);	
	InitGrid();
}

function InitMetaTable_Base()
{
	LoadXslt('/Common/ManualTable/MetaTableXsl_' + getCurrentPageLanguage() + '.xsl');
	var obj = new Object();
    obj.v_serviceObjName = 'webService';
    obj.v_serviceName = location.protocol +'//'+ location.hostname;
    if(location.port != "" && location.port != "80") obj.v_serviceName += ":"+location.port;
    obj.v_serviceName += '/barsroot/webservices/WebServices.asmx';
    obj.v_serviceMethod = 'GetMetaTable_Base';
    obj.v_serviceFuncAfter = 'InitSelection';
    obj.v_xmlFilenameFilter = '/Common/ManualTable/ManualTableXsl_' + getCurrentPageLanguage() + '.xml'
    fn_InitVariables(obj);	
	InitGrid();
}
function InitSelection()
{
  if(document.getElementById("r_1")){
   document.all.dGridMeta.focus();
   document.getElementById("r_1").fireEvent("oncontextmenu");
 }
}