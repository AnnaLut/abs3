/* 
Infragistics UltraWebGrid Script 
Version 3.0.20041.11
Copyright (c) 2001-2004 Infragistics, Inc. All Rights Reserved.
*/

function igtbl_getElementById(tagId)
{
	var obj;
	if(document.all)
		obj=document.all[tagId];
	else
		obj=document.getElementById(tagId);
	if(obj && obj.length && obj[0].id==tagId)
		obj=obj[0];
	return obj;
}

function igtbl_srcElement(evnt)
{
	var se=null;
	if(evnt.srcElement)
		se=evnt.srcElement;
	else if(evnt.target)
		se=evnt.target;
	while(se && !se.tagName)
		se=se.parentNode;
	return se;
}

function igtblro_button(evnt)
{
	if(evnt.srcElement)
	{
		if(evnt.button==1)
			return 0;
		else if(evnt.button==4)
			return 1;
		else if(evnt.button==2)
			return 2;
	}
	else
		return evnt.button;
	return -1;
}

function igtbl_getLeftPos(e,cc) 
{
    var x = e.offsetLeft;
    if(e.clientLeft && cc!=false)
	    x += e.clientLeft;
    var tmpE = e.offsetParent;
    while (tmpE != null) 
    {
        x += tmpE.offsetLeft;
        if((tmpE.tagName=="DIV" || tmpE.tagName=="TD") && tmpE.style.borderLeftWidth)
	        x += parseInt(tmpE.style.borderLeftWidth);
        if(tmpE.tagName!="BODY" && tmpE.scrollLeft)
			x-=tmpE.scrollLeft;
		if(tmpE.clientLeft && cc!=false)
			x += tmpE.clientLeft;
        tmpE = tmpE.offsetParent;
    }
    return x;
}

function igtbl_getOffsetX(evnt,e)
{
	if(evnt.offsetX)
		return evnt.offsetX;
	return evnt.clientX-igtbl_getLeftPos(e);
}

function igtblro_toggleRow(gn,srcRow,expImg,colImg,expand)
{
	var sr = igtbl_getElementById(srcRow);
	var hr = sr.nextSibling;
	if(hr.getAttribute("hiddenRow"))
	{
		if(hr.style.display == "none" && expand!=false)
		{
			hr.style.display = "";
			sr.childNodes[0].childNodes[0].src=colImg;
		}
		else if(expand!=true)
		{
			hr.style.display = "none";
			sr.childNodes[0].childNodes[0].src=expImg;
		}
	}
}

var igtbl_resizeColumnId="";
function igtblro_headerClickDown(evnt)
{
	var se=igtbl_srcElement(evnt);
	while(se && se.tagName!="TH")
		se=se.parentNode;
	if(!se || !se.id || se.id=="")
		return;
	if(igtbl_getOffsetX(evnt,se)>(se.clientWidth?se.clientWidth:se.offsetWidth)-4 && se.getAttribute("resizable"))
	{
		igtbl_resizeColumnId=se.id;
		if(se.parentNode.parentNode.getAttribute("stationary"))
			igtblro_prepareColumnResize(se);
		else
		{
			var cg=se.parentNode.parentNode.previousSibling;
			if(cg)
			{
				cg.parentNode.style.width="";
				for(var i=0;i<cg.childNodes.length;i++)
					cg.childNodes[i].width=cg.childNodes[i].offsetWidth;
			}
		}
		return;
	}
}

function igtblro_headerClickUp(evnt,gn)
{
	var se=igtbl_srcElement(evnt);
	while(se && se.tagName!="TH")
		se=se.parentNode;
	if(!se || !se.id || se.id=="")
		return;
	if(igtbl_resizeColumnId!="")
	{
		igtbl_resizeColumnId="";
		var cursorName = se.getAttribute("oldCursor");
		if(cursorName != null)
		{
			se.style.cursor=cursorName;
			se.removeAttribute("oldCursor");
		}
	}
	else if(se.getAttribute("sortable"))
		__doPostBack(gn,"Sort:"+se.getAttribute("sortable")+":"+evnt.shiftKey);
	return true;
}

function igtblro_headerMouseMove(evnt)
{
	var se=igtbl_srcElement(evnt);
	while(se && se.tagName!="TH")
		se=se.parentNode;
	if(!se || !se.id || se.id=="")
		return;
	var btn=igtblro_button(evnt);
	if(igtbl_resizeColumnId!="" && btn==0)
	{
		var column = igtbl_getElementById(igtbl_resizeColumnId);
		if(!column)
			return;
		var resCol=column;
		var cg=se.parentNode.parentNode.previousSibling;
		var co=resCol;
		if(cg)
			co=cg.childNodes[column.cellIndex];
		var c1w=co.offsetWidth+(evnt.clientX-(igtbl_getLeftPos(resCol)+co.offsetWidth));
		igtblro_resizeColumn(resCol.id,c1w);
		var cursorName = se.getAttribute("oldCursor");
		if(cursorName == null)
			se.setAttribute("oldCursor", se.style.cursor);
		se.style.cursor="w-resize";
	}
	else 
	{
		if(igtbl_getOffsetX(evnt,se)>(se.clientWidth?se.clientWidth:se.offsetWidth)-4 && se.getAttribute("resizable"))
		{
			var cursorName = se.getAttribute("oldCursor");
			if(cursorName == null)
				se.setAttribute("oldCursor", se.style.cursor);
			se.style.cursor="w-resize";
		}
		else
		{
			var cursorName = se.getAttribute("oldCursor");
			if(cursorName != null)
			{
				se.style.cursor=cursorName;
				se.removeAttribute("oldCursor");
			}
		}
	}
	return true;
}

function igtblro_resizeColumn(colId,width)
{
	var res=false;
	var colObj=igtbl_getElementById(colId);
	if(!colObj)
		return res;
	var c1w=width;
	if(c1w>0)
	{
		var columns=null;
		if(document.all)
			columns=document.all[colObj.id];
		else
			columns=document.getElementById(colObj.id);
		if(columns.length)
			for(var i=0;i<columns.length;i++)
			{
				var cg=columns[i].parentNode.parentNode.previousSibling;
				if(cg)
					cg.childNodes[colObj.cellIndex].width=c1w;
				else
					columns[i].style.width=c1w;
			}
		else
		{
			var cg=colObj.parentNode.parentNode.previousSibling;
			if(cg)
				cg.childNodes[colObj.cellIndex].width=c1w;
			else
				colObj.width=c1w;
		}
	}
	return res;
}
