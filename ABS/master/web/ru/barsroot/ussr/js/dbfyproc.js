function SelectRow()
{
	var obj = window.event.srcElement;
	if(obj.tagName=="INPUT")    //this is a checkbox
	{
	    checkRowOfObject(obj);
	}
	else if (obj.tagName=="TD") //this a table cell
	{
	    var row = obj.parentNode;
	    var chk = row.cells[0].firstChild;
	    chk.checked = !chk.checked;
	    if (chk.checked)
	    {
	        if ("selectedRow"!=row.className)
	            row.style.filter = row.className;
	        row.className="selectedRow";
	    }
	    else
	    {
	       if("selectedRow"==row.className)
	            row.className=row.style.filter;
	    }
	}
}
function checkRowOfObject(obj)
{
    if (obj.checked)
    {
        if ("selectedRow"!=obj.parentNode.parentNode.className)
            obj.parentNode.parentNode.style.filter = obj.parentNode.parentNode.className;  
        obj.parentNode.parentNode.className="selectedRow";
    }
    else
    {
       if ("selectedRow"==obj.parentNode.parentNode.className) 
         obj.parentNode.parentNode.className=obj.parentNode.parentNode.style.filter;
    }
}
function DeSelectAllRows()
{
    var obj = window.event.srcElement;
    if (!obj) return;
    for(var i=1;i<gv.rows.length;i++)
    {
        var chk = gv.rows[i].cells[0].firstChild;
        if (!chk) continue;
   		if(obj.id!=chk.id) 
            if (chk) chk.checked=false;

        checkRowOfObject(chk);
    }
}

function isRowChecked()
{
    for(var i=1;i<gv.rows.length;i++)
    {
        var chk = gv.rows[i].cells[0].firstChild;
        if (!chk) continue;
        if (chk.checked) {
          return true;
          break;
        }
    }
    return false;
}
