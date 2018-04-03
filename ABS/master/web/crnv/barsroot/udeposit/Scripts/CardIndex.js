window.onload = InitCardIndex;
// Переменные с URL
var url_acc_type = null; // тип счета
var url_code_oper = null; // код операции

var slaveTableSelRow = null;
var depLinesTableSelRow = null;

//**********************************************************************//
function InitCardIndex()
{
  url_acc_type = getParamFromUrl("acc_type",location.href);
  url_code_oper = getParamFromUrl("code_oper",location.href);
  
  webService.useService("DptUService.asmx?wsdl","DPU"); 
   
  fnPopulateFirstTable();
}
//**********************************************************************//
function fnPopulateFirstTable()
{ 
  LoadXslt('Xslt/CardIndex_1.xsl');
  v_data[9] = url_acc_type;
  var obj = new Object();
  obj.v_serviceObjName = 'webService';
  obj.v_serviceName = 'DptUService.asmx';
  obj.v_serviceMethod = 'GetDepositLines';
  obj.v_serviceFuncAfter = 'InitMySelection';
  obj.v_enableViewState = true; 
  fn_InitVariables(obj);	
  InitGrid();
}

function InitMySelection()
{
  if(document.getElementById("r_1"))
  {
     document.all.tableDepositLines.focus();
     document.getElementById("r_1").fireEvent("onclick");
  }
  else
     ClearSecondTable();
}

function ClearSecondTable()
{
  // Ссылка на таблицу
  var obj_table = window.document.getElementById('secondTable');
  // Удалим все строки
  while (obj_table.rows.length > 1) obj_table.deleteRow(obj_table.rows.length - 1);
}

//**********************************************************************//
function fnPopulateSecondTable(lv_Acc)
{
  if (depLinesTableSelRow != selectedRow)
  {
    ClearSecondTable();
    depLinesTableSelRow = selectedRow;
    // Получим данные
    webService.DPU.callService(fnOnPopulateSecondTable, "GetSlaveAccounts", lv_Acc);
  }
}

function fnOnPopulateSecondTable(result)
{
  // Ссылка на таблицу
  var obj_table = window.document.getElementById('secondTable');
 
  if(!getError(result)) return;
  
  var data = result.value;
  for (var i=0; i<data.length; i++)
  {
    var obj_row = obj_table.insertRow(i+1);
    for (var j=0; j<data[i].length; j++)
    {
       if (j==0)
       {
         obj_row.id = "sr_" + i + "_" + j;
         obj_row.acc = data[i][j];
         if (i==0)
         {
           slaveTableSelRow = obj_row;
           obj_row.style.backgroundColor = '#d3d3d3';           
         }
         obj_row.attachEvent("onclick",SelectMyRow);
       }
       else
       {
         var obj_cell = obj_row.insertCell(j-1);
         obj_cell.innerText = data[i][j];
         switch(j)
         {           
            case 3:
            obj_cell.style.textAlign = 'left';
            break;
            
            case 4:           
            case 5:
            obj_cell.style.textAlign = 'right';
            break;
            
            default:
            obj_cell.style.textAlign = 'center';
            break;
         }
       }
    }
  }
  
}
//**********************************************************************//

function SelectMyRow()
{
  var row = event.srcElement.parentElement;
  if (slaveTableSelRow!= null) slaveTableSelRow.style.backgroundColor = row.style.backgroundColor;
  slaveTableSelRow =  row;    
  row.style.backgroundColor = '#d3d3d3';
}

//**********************************************************************//

function fnSeize()
{
  if (selectedRow.acc > 0 && selectedRow.ref1 > 0)
  {
    if (confirm('Документ с референсом ' + selectedRow.ref1 + 
    '\n по счету ' + selectedRow.nls + '/' + selectedRow.kv + ' будет изъят!' ))
        webService.DPU.callService(fnOnSeize, "SeizeFromCardIndex", selectedRow.acc, selectedRow.ref1);
  }
}
function fnOnSeize(result)
{
  if(!getError(result)) return;
  if (result.value > 0) fnPopulateFirstTable();
  else alert('Невозможно изъять документ из картотеки!');
}
//**********************************************************************//

function fnRefresh()
{
  fnPopulateFirstTable();
}
//**********************************************************************//

function fnRegister()
{
  if (slaveTableSelRow && selectedRow)
  {
    if (confirm('Сумма ' + selectedRow.sum + '/' + selectedRow.kv + 
    ' будет провдена по счету ' + slaveTableSelRow.cells[1].innerText + '/' + slaveTableSelRow.cells[0].innerText + ' !' ))
        webService.DPU.callService(fnOnRegister, "Register", selectedRow.vdat, selectedRow.sk, slaveTableSelRow.acc, selectedRow.ref1, selectedRow.acc);
  }
}
function fnOnRegister(result)
{
  if(!getError(result)) return;
  if (result.value > 0) 
  {
    fnPopulateFirstTable();
    alert('Выполнено!');
  }
  else alert('Невозможно провести сумму по внесистемному счету!');
}
//**********************************************************************//

function fnViewDoc()
{
    location.replace("/documentview/default.aspx?ref="+selectedRow.ref1);
}
//**********************************************************************//
