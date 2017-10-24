function SelectRow()
{
	var obj = window.event.srcElement;
	if(obj.tagName=="INPUT")    //this is a checkbox
	{
	    DeSelectAllRows();
	    checkRowOfObject(obj);
	}
	else if (obj.tagName=="TD") //this a table cell
	{
	    var row = obj.parentNode;
	    var chk = row.cells[0].firstChild;
	    DeSelectAllRows();
	    chk.checked = !chk.checked;
	    if (chk.checked)
	    {
	        if ("SelectedRow"!=row.className)
	            row.style.filter = row.className;
	        row.className="SelectedRow";
	    }
	    else
	    {
	       if("SelectedRow"==row.className)
	            row.className=row.style.filter;
	    }
	}
}
function checkRowOfObject(obj)
{
    if (obj.checked)
    {
        if ("SelectedRow"!=obj.parentNode.parentNode.className)
            obj.parentNode.parentNode.style.filter = obj.parentNode.parentNode.className;  
        obj.parentNode.parentNode.className="SelectedRow";
    }
    else
    {
       if ("SelectedRow"==obj.parentNode.parentNode.className) 
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
        if (obj.id != chk.id) 
            try { chk.checked=false;} catch (e) {}

        checkRowOfObject(chk);
    }
}
