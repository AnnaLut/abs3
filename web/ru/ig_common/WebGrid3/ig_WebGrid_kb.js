/* 
Infragistics UltraWebGrid Script 
Version 3.0.20041.11
Copyright (c) 2001-2004 Infragistics, Inc. All Rights Reserved.
*/

function igtbl_onKeyDown(evnt,gn)
{
	var gs=igtbl_getGridById(gn);
	if(!gs)
		return;
	var processed=false;
	if(!gs.Activation.AllowActivation)
		return;
	var tb=igtbl_getElementById(gn+"_tb");
	if(tb && tb.style.display=="")
		return;
	var ta=igtbl_getElementById(gn+"_ta");
	if(ta && ta.style.display=="")
		return;
	var vl=igtbl_getElementById(gn+"_vl");
	if(vl && vl.style.display=="")
		return true;
	var te=gs.Element;
	var cell=gs.getActiveCell();
	var row=gs.getActiveRow();
	var nextCell=null,nextRow=null;
	var elId;
	if(cell)
		elId=cell.Element.id;
	else if(row)
		elId=row.Element.id;
	else 
		return;
	if(igtbl_fireEvent(gn,gs.Events.KeyDown,"(\""+gn+"\",\""+elId+"\","+evnt.keyCode+")")==true)
		return;
	switch(evnt.keyCode)
	{
		case 9: //Tab
			if(cell)
			{
				if(evnt.ctrlKey)
					nextRow=cell.Row;
				else
					nextCell=cell.getNextTabCell(evnt.shiftKey);
			}
			else
			{
				if(evnt.ctrlKey)
					nextCell=row.getCell(0);
				else
					nextRow=row.getNextTabRow(evnt.shiftKey);
			}
			if(evnt.shiftKey)
			{
				if(nextCell)
				{
					te.setAttribute("startPointCell",nextCell.Element.id);
					te.setAttribute("selectMethod","cell");
					te.setAttribute("selectTable",nextCell.Row.Element.parentNode.parentNode.id);
					te.setAttribute("startPointRow",nextCell.Row.Element.id);
				}
				else if(nextRow)
				{
					te.setAttribute("selectMethod","row");
					te.setAttribute("selectTable",nextRow.Element.parentNode.parentNode.id);
					te.setAttribute("startPointRow",nextRow.Element.id);
				}
			}
			if(nextCell || nextRow)
				processed=true;
			break;
		case 13: //Enter
			var b=igtbl_getElementById(gn+"_bt");
			if(b && b.style.display!="none")
			{
				processed=true;
				igtbl_colButtonClick(evnt,gn);
			}
			else if(cell)
			{
				processed=true;
				if(cell.Column.Type==3)
					cell.setValue(!cell.getValue());
				else if(cell.Column.Type==7)
				{
					if(cell.Column.CellButtonDisplay==0)
						b.fireEvent("onclick");
					else
						cell.Element.childNodes[0].fireEvent("onclick");
				}
				else if(cell.Column.Type==9)
					location.href=cell.getValue();
				else
					cell.beginEdit();
			}
			else if(row && row.GroupByRow)
			{
				processed=true;
				row.toggleRow();
			}
			break;
		case 16: //Shift
			processed=true;
			if(cell)
			{
				te.setAttribute("startPointCell",cell.Element.id);
				te.setAttribute("selectMethod","cell");
				row=cell.Row;
			}
			else
				te.setAttribute("selectMethod","row");
			te.setAttribute("selectTable",row.Element.parentNode.parentNode.id);
			te.setAttribute("startPointRow",row.Element.id);
			break;
		case 32: //Space
			if(cell)
			{
				processed=true;
				cell.setSelected(!cell.getSelected());
			}
			else
			{
				processed=true;
				row.setSelected(!row.getSelected());
			}
			break;
		case 35: //End
			if(cell)
			{
				nextCell=cell.Row.getCell(cell.Row.cells.length-1);
				if(nextCell.Column.getHidden())
					nextCell=nextCell.getPrevCell();
				if(nextCell==cell)
					nextCell=null;
			}
			else
			{
				nextRow=row.OwnerCollection.getRow(row.OwnerCollection.length-1);
				if(nextRow.getHidden())
					nextRow=nextRow.getPrevRow();
				if(nextRow==row)
					nextRow=null;
			}
			if(nextCell || nextRow)
				processed=true;
			break;
		case 36: //Home
			if(cell)
			{
				nextCell=cell.Row.getCell(0);
				if(nextCell.Column.getHidden())
					nextCell=nextCell.getNextCell();
				if(nextCell==cell)
					nextCell=null;
			}
			else
			{
				nextRow=row.OwnerCollection.getRow(0);
				if(nextRow.getHidden())
					nextRow=nextRow.getNextRow();
				if(nextRow==row)
					nextRow=null;
			}
			if(nextCell || nextRow)
				processed=true;
			break;
		case 37: //Left
			if(cell)
			{
				if(cell.getPrevCell())
					nextCell=cell.getPrevCell();
				else if(cell.Row.getPrevRow())
				{
					nextCell=cell.Row.getPrevRow().getCell(cell.Row.getPrevRow().cells.length-1);
					if(nextCell.Column.getHidden())
						nextCell=nextCell.getPrevCell();
				}
				if(nextCell)
					processed=true;
			}
			else if(row.Band.getExpandable()==1)
			{
				processed=true;
				row.setExpanded(false);
			}
			break;
		case 39: //Right
			if(cell)
			{
				if(cell.getNextCell())
					nextCell=cell.getNextCell();
				else if(cell.Row.getNextRow())
				{
					nextCell=cell.Row.getNextRow().getCell(0);
					if(nextCell.Column.getHidden())
						nextCell=nextCell.getNextCell();
				}
				if(nextCell)
					processed=true;
			}
			else if(row.Band.getExpandable()==1)
			{
				processed=true;
				row.setExpanded(true);
			}
			break;
		case 38: //Up
			if(cell && cell.Row.getPrevRow())
			{
				var nr=cell.Row.getPrevRow();
				while(!nextCell && nr)
				{
					nextCell=nr.getCellByColumn(cell.Column);
					nr=nr.getPrevRow();
				}
			}
			else if(row)
				nextRow=row.getPrevRow();
			if(nextCell || nextRow)
				processed=true;
			break;
		case 40: //Down
			if(cell && cell.Row.getNextRow())
			{
				var nr=cell.Row.getNextRow();
				while(!nextCell && nr)
				{
					nextCell=nr.getCellByColumn(cell.Column);
					nr=nr.getNextRow();
				}
			}
			else if(row)
				nextRow=row.getNextRow();
			if(nextCell || nextRow)
				processed=true;
			break;
		case 46: //Del
			processed=true;
			gs.deleteSelectedRows();
			break;
		default:
			if(evnt.keyCode>=48 && evnt.keyCode<=57 || evnt.keyCode>=54 && evnt.keyCode<=90 || evnt.keyCode>=96 && evnt.keyCode<=111 || evnt.keyCode>=186 && evnt.keyCode<=192 || evnt.keyCode>=219 && evnt.keyCode<=222 || evnt.keyCode==113 || evnt.keyCode==107 || evnt.keyCode==109)
			{
				if((evnt.keyCode==107 || evnt.keyCode==109) && (!cell || !cell.isEditable())) //Plus or Minus
				{
					if(cell && cell.Row.Band.getExpandable()==1)
					{
						processed=true;
						cell.Row.setExpanded(evnt.keyCode==107);
					}
					else if(row && row.Band.getExpandable()==1)
					{
						processed=true;
						row.setExpanded(evnt.keyCode==107);
					}
					break;
				}
				else if(cell)
				{
					if(cell.isEditable())
						cell.beginEdit(evnt.keyCode);
					else if(cell.Column.getAllowUpdate()==3)
						cell.Row.editRow();
				}
				else if(row && evnt.keyCode==113)
					row.editRow();
			}
			break;
	}
	if(nextCell || nextRow)
	{
		if(nextCell)
		{
			var stc=nextCell.Row.Band.getSelectTypeCell();
			if((!evnt.shiftKey || evnt.keyCode==9) && (!evnt.ctrlKey || stc!=3))
				igtbl_clearSelectionAll(gn);
			if(evnt.shiftKey && evnt.keyCode!=9)
				igtbl_selectRegion(gn,nextCell.Element);
			else if(!evnt.ctrlKey && stc==3 || stc==2)
				nextCell.setSelected();
			nextCell.activate();
			nextCell.scrollToView();
			if(nextCell.Column.Type==7 && nextCell.Column.CellButtonDisplay==0)
				igtbl_showColButton(gn,nextCell.Element);
			else if(evnt.keyCode==9 && nextCell.Row.Band.getCellClickAction()==1)
				igtbl_EnterEditMode(gn);
		}
		else
		{
			var str=nextRow.Band.getSelectTypeRow();
			if((!evnt.shiftKey || evnt.keyCode==9) && (!evnt.ctrlKey || str!=3))
				igtbl_clearSelectionAll(gn);
			if(evnt.shiftKey && evnt.keyCode!=9)
				igtbl_selectRegion(gn,igtbl_getFirstCell(gn,nextRow.Element).previousSibling);
			else if(!evnt.ctrlKey && str==3 || str==2)
				nextRow.setSelected();
			igtbl_setActiveRow(gn,nextRow.FirstRow);
			nextRow.scrollToView();
		}
		if(gs.NeedPostBack)
			igtbl_doPostBack(gn);
	}
	if(processed)
	{
		if(evnt.keyCode!=16 && !evnt.shiftKey)
		{
			te.removeAttribute("selectMethod");
			te.removeAttribute("selectTable");
			te.removeAttribute("startPointRow");
			te.removeAttribute("startPointCell");
		}
		if(document.all)
		{
			event.cancelBubble=true;
			event.returnValue=false;
			return true;
		}
		else
		{
			evnt.stopPropagation();
			evnt.preventDefault();
			return false;
		}
	}
}

function igtbl_onKeyUp(evnt,gn)
{
	var gs=igtbl_getGridById(gn);
	if(!gs || !gs.Activation.AllowActivation)
		return;
	var tb=igtbl_getElementById(gn+"_tb");
	if(tb && tb.style.display=="")
		return;
	var ta=igtbl_getElementById(gn+"_ta");
	if(ta && ta.style.display=="")
		return;
	var vl=igtbl_getElementById(gn+"_vl");
	if(vl && vl.style.display=="")
		return;
	var te=gs.Element;
	var cell=gs.oActiveCell;
	if(!cell)
		cell=gs.oActiveRow;
	if(cell)
		gs.fireEvent(gs.Events.KeyUp,"(\""+gs.Id+"\",\""+cell.Element.id+"\","+evnt.keyCode+");");
}

function igtbl_rowFromRows(rows,n)
{
	if(n<0 || !rows)
		return null;
	var i=0,j=0;
	var row=rows[0];
	while(row && i<n)
	{
		if(i>=rows.length-1)
			return null;
		row=rows[++j];
		if(row && (row.getAttribute("hiddenRow") || row.parentNode.tagName=="TFOOT"))
			row=rows[++j];
		i++;
	}
	return row;
}

function igtbl_getRowInfo(gn,l)
{
	var row=igtbl_getRow(gn,l);
	if(!row)
		return;
	return new igtbl_initRowInfo(gn,row);
}

function igtbl_getFirstCell(gn,row)
{
	if(row.getAttribute("groupRow"))
		return row.childNodes[0].childNodes[0].childNodes[0].rows[0].cells[0];
	else
		return row.cells[igtbl_getBandFAC(gn,row)];
}

function igtbl_getParentRow(gn,row)
{
	var l=igtbl_getRowLevel(row.id);
	if(l.length==1)
	{
		delete l;
		return null;
	}
	var pl=igtbl_copyArray(l,l.length-1);
	var pr=igtbl_getRow(gn,pl);
	delete pl;
	delete l;
	return pr;
}

function igtbl_getCurRow(c)
{
	var r=null;
	while(c && !r)
		if(c.tagName=="TR" && !c.getAttribute("hiddenRow"))
			r=c;
		else
			c=c.parentNode;
	if(r && r.getAttribute("groupRow"))
		r=r.parentNode.parentNode.parentNode.parentNode;
	return r;
}

function igtbl_getFirstSibRow(gn,row)
{
	var rl=igtbl_getRowLevel(row.id);
	var rlns=igtbl_copyArray(rl);
	rlns[rlns.length-1]=0;
	var ns=igtbl_getRow(gn,rlns);
	while(ns && (ns.getAttribute("deleted") || ns.style.display=="none"))
	{
		rlns[rlns.length-1]++;
		ns=igtbl_getRow(gn,rlns);
	}
	delete rlns;
	delete rl;
	return ns;
}

function igtbl_getLastSibRow(gn,row)
{
	var lastRow=row;
	var ns=igtbl_getNextSibRow(gn,lastRow);
	while(ns)
	{
		lastRow=ns;
		ns=igtbl_getNextSibRow(gn,lastRow);
	}
	return lastRow;
}

function igtbl_getFirstChildRow(gn,row)
{
	var rl=igtbl_getRowLevel(row.id);
	var rlc=igtbl_copyArray(rl);
	rlc[rlc.length]=0;
	var ns=igtbl_getRow(gn,rlc);
	if(ns && (ns.getAttribute("deleted") || ns.style.display=="none"))
		ns=igtbl_getNextSibRow(gn,ns);
	delete rlc;
	delete rl;
	return ns;
}

function igtbl_getLastChildRow(gn,row)
{
	var ns=igtbl_getFirstChildRow(gn,row);
	if(ns)
	{
		var r=igtbl_getNextSibRow(gn,ns);
		while(r)
		{
			ns=r;
			r=igtbl_getNextSibRow(gn,ns);
		}
	}
	return ns;
}

function igtbl_getNextTabRow(gn,row,shiftKey)
{
	var rowInfo=new igtbl_initRowInfo(gn,row);
	if(shiftKey)
	{
		var rowBefore=igtbl_getPrevSibRow(gn,row);
		if(rowBefore)
		{
			var rbInfo=new igtbl_initRowInfo(gn,rowBefore);
			while(rbInfo.getExpanded())
			{
				rowBefore=igtbl_getLastChildRow(gn,rowBefore);
				rbInfo=new igtbl_initRowInfo(gn,rowBefore);
			}
		}
		else if(rowInfo.RowLevel.length>1)
			rowBefore=igtbl_getParentRow(gn,row);
		return rowBefore;
	}
	else
	{
		var rowAfter=igtbl_getNextSibRow(gn,row);
		var nextRow=null;
		if(rowInfo.Expanded)
		{
			nextRow=igtbl_getFirstChildRow(gn,row);
			if(!nextRow)
				nextRow=rowAfter;
		}
		else if(rowAfter)
			nextRow=rowAfter;
		else if(rowInfo.RowLevel.length>1)
		{
			while(!rowAfter)
			{
				var pr=igtbl_getParentRow(gn,row);
				if(!pr)
					break;
				rowAfter=igtbl_getNextSibRow(gn,pr);
				row=pr;
			}
			nextRow=rowAfter;
		}
		return nextRow;
	}
}

function igtbl_getNextTabCell(gn,cell,shiftKey)
{
	var row=cell.parentNode;
	if(!row)
		return;
	if(shiftKey)
	{
		var prevCell=null;
		if(cell.previousSibling && cell.previousSibling.cellIndex>=igtbl_getBandFAC(gn,cell))
			prevCell=cell.previousSibling;
		else
		{
			var rowBefore=igtbl_getNextTabRow(gn,row,shiftKey);
			if(rowBefore)
				prevCell=rowBefore.cells[rowBefore.cells.length-1];
		}
		return prevCell;
	}
	else
	{
		var nextCell=null;
		if(cell.nextSibling)
			nextCell=cell.nextSibling;
		else
		{
			var rowAfter=igtbl_getNextTabRow(gn,row,shiftKey);
			if(rowAfter)
				nextCell=rowAfter.cells[igtbl_getBandFAC(gn,rowAfter)];
		}
		return nextCell;
	}
	return null;
}

function igtbl_ActivateNextCell(gn)
{
	var gs=igtbl_getGridById(gn);
	if(!gs || !gs.Activation.AllowActivation)
		return null;
	var cell=gs.oActiveCell;
	if(!cell)
		return null;
	var nextCell=cell.getNextTabCell(false);
	if(nextCell)
	{
		igtbl_setActiveCell(gn,nextCell.Element);
		if(gs.getActiveCell()==nextCell)
		{
			igtbl_clearSelectionAll(gn);
			igtbl_selectCell(gn,nextCell);
			igtbl_scrollToView(gn,nextCell.Element);
			if(gs.NeedPostBack)
				igtbl_doPostBack(gn);
			return nextCell.Element;
		}
		else
			return cell.Element;
	}
	return null;
}

function igtbl_ActivatePrevCell(gn)
{
	var gs=igtbl_getGridById(gn);
	if(!gs || !gs.Activation.AllowActivation)
		return null;
	var cell=gs.oActiveCell;
	if(!cell)
		return null;
	var prevCell=cell.getNextTabCell(true);
	if(prevCell)
	{
		igtbl_setActiveCell(gn,prevCell.Element);
		if(gs.getActiveCell()==prevCell)
		{
			igtbl_clearSelectionAll(gn);
			igtbl_selectCell(gn,prevCell);
			igtbl_scrollToView(gn,prevCell.Element);
			if(gs.NeedPostBack)
				igtbl_doPostBack(gn);
			return prevCell.Element;
		}
		else
			return cell.Element;
	}
	return null;
}

function igtbl_EnterEditMode(gn)
{
	var gs=igtbl_getGridById(gn);
	if(!gs || !gs.Activation.AllowActivation)
		return;
	var cell=gs.oActiveCell;
	if(!cell)
		return;
	cell.beginEdit();
}

function igtbl_EndEditMode(gn)
{
	igtbl_hideEdit(gn);
}

function igtbl_getActiveCell(gn)
{
	var gs=igtbl_getGridById(gn);
	if(!gs || !gs.Activation.AllowActivation)
		return null;
	return gs.getActiveCell();
}

function igtbl_getActiveRow(gn)
{
	var gs=igtbl_getGridById(gn);
	if(!gs || !gs.Activation.AllowActivation)
		return null;
	return gs.getActiveRow();
}

function igtbl_getRowLevel(rowId)
{
	var rowObj=igtbl_getElementById(rowId);
	if(rowObj.getAttribute("level"))
		rowId=rowObj.getAttribute("level");
	var rn=rowId.split("_");
	var fn=rn.length-1;
	while(fn>=0)
	{
		if(!parseInt(rn[fn],10) && rn[fn]!="0")
			break;
		fn--;
	}
	fn++;
	var res=new Array();
	for(var i=fn;i<rn.length;i++)
		res[i-fn]=parseInt(rn[i],10);
	return res;
}

function igtbl_getNextSibRow(gn,row)
{
	var rl=igtbl_getRowLevel(row.id);
	var rlns=igtbl_copyArray(rl);
	rlns[rlns.length-1]++;
	var ns=igtbl_getRow(gn,rlns);
	while(ns && (ns.getAttribute("deleted") || ns.style.display=="none"))
	{
		rlns[rlns.length-1]++;
		ns=igtbl_getRow(gn,rlns);
	}
	delete rlns;
	delete rl;
	return ns;
}

function igtbl_getPrevSibRow(gn,row)
{
	var rl=igtbl_getRowLevel(row.id);
	var rlps=igtbl_copyArray(rl);
	rlps[rlps.length-1]--;
	var ps=igtbl_getRow(gn,rlps);
	while(ps && (ps.getAttribute("deleted") || ps.style.display=="none"))
	{
		rlps[rlps.length-1]--;
		ps=igtbl_getRow(gn,rlps);
	}
	delete rlps;
	delete rl;
	return ps;
}

function igtbl_copyArray(src,count)
{
	if(!count)
		count=src.length;
	var dest=new Array();
	for(var i=0;i<count;i++)
		dest[i]=src[i];
	return dest;
}

function igtbl_getRow(gn,l)
{
	if(!l.length || !l[0] && l[0]!=0)
		return null;
	var te=igtbl_getGridById(gn).Element;
	var clr=te.tBodies[0].rows;
	var row=igtbl_rowFromRows(clr,l[0]);
	if(row && row.parentNode.tagName=="TFOOT")
		return;
	for(var i=1;i<l.length;i++)
		if(!row || !l[i] && l[i]!=0)
			break;
		else
		{
			clr=igtbl_getChildRows(gn,row);
			row=igtbl_rowFromRows(clr,l[i]);
		}
	return row;
}

