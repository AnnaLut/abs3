var prev_row;
window.onfocus = fnFocus;
//**********************************************************************//
window.onload = function()
{
  //parent.AddToList("NAZN1","nms","mfo","nlsb",100,1);
  //parent.AddToList("NAZN2","nms","mfo","nlsb",10,0);
  //parent.AddToList("NAZN3","nms","mfo","nlsb",50,2);
}
//**********************************************************************//
function fnFocus()
{
  document.all.Oper.focus();
  if(row_id)
	SR(row_id)
  else{
   if(document.all.Oper.rows.length == 1)  return;
   for(var i = 1; i < 20; i++)
	if(document.getElementById("r_"+i)){
		document.getElementById("r_"+i).fireEvent("onclick");
		break;
	}	
  }	
}

var selectedRow;
var row_id;
//**********************************************************************//
//Выделение строки
function SR(id)
{
 if(selectedRow != null) selectedRow.style.background = '';
 document.getElementById("r_"+id).style.background = '#d3d3d3';
 selectedRow = document.getElementById("r_"+id);
 row_id = id;
}
//**********************************************************************//
function fnFindNextRow()
{
  for(var i = 1; i < 20; i++ )
  {
    if(document.getElementById('r_'+eval(row_id+i))){
	  SR(row_id+i);
	  return true;
	}  
  }
  return false;
}
//**********************************************************************//
function fnFindPrevRow()
{
  for(var i = 1; i < row_id; i++ )
  {
    if(document.getElementById('r_'+eval(row_id-i))){
	  SR(row_id-i);
	  break;
	}  
  }
}
//**********************************************************************//
function KPress()
{
 if(event.keyCode == 40)
	fnFindNextRow();
 else if(event.keyCode == 38)
	fnFindPrevRow();
 else if(event.keyCode == 13)
  document.getElementById('r_'+row_id).fireEvent("ondblclick");	 
 //DEL - удалить строчку
 if(event.keyCode == 46)  
	document.getElementById('id_'+row_id).fireEvent("onclick");
 //ALT+CTRL+T - оттиск
 if(event.altKey && event.ctrlKey && event.keyCode == 84)
	document.getElementById('io_'+row_id).fireEvent("onclick");
 //ALT+CTRL+D - карточка документа
 if(event.altKey && event.ctrlKey && event.keyCode == 68)
	document.getElementById('ik_'+row_id).fireEvent("onclick");
 //ALT+CTRL+P - тикет
 if(event.altKey && event.ctrlKey && event.keyCode == 80)
	document.getElementById('it_'+row_id).fireEvent("onclick");	
}
//**********************************************************************//
function PrintRow(id)
{
 if(document.getElementById("it_"+id.substr(2)).style.visibility == 'hidden') return;
 var ref = document.getElementById(id).ref;
 if(ref == "") return;
 parent.Print(new Array(ref,""));
}
//**********************************************************************//
function ShowDoc(id)
{
 var ref = document.getElementById(id).ref;
 if(ref != "")
   window.open("/barsroot/documentview/default.aspx?ref="+ref,"","height="+(window.screen.height-200)+",width="+(window.screen.width-10)+",status=no,toolbar=no,menubar=no,location=no,left=0,top=0");
}
//**********************************************************************//
function fnHotKeyMain()
{
  parent.fnGlobalHotKey(event);
}
//**********************************************************************//
function DelRow(id,sum,kom)
{
  if(document.getElementById("id_"+id.substr(2)).style.visibility == 'hidden') return;
  if(Dialog(LocalizedString('Mes29')/*"Удалить операцию ?"*/,"confirm") == 1){
	var curr_row;
	for (curr_row = 1; curr_row<Oper.rows.length; curr_row++)
	{
		if(Oper.rows[curr_row].id == id) break; 
	}
	Oper.deleteRow(curr_row);
	row_id = null;
	selectedRow = null;
	if(ParseF(parent.tbTotal.value) != 0)
		parent.tbTotal.value -= eval(sum) + eval(kom);
	if(parent.tbTotalKol.value != 0)	
		parent.tbTotalKol.value -= 1; 
    parent.tbTotal.fireEvent("onfocusout");
    parent.fnConvSum(); 
    parent.allDocs.splice(id-1,2);
  }  
}
//**********************************************************************//