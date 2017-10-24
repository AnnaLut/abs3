/* 
Infragistics UltraWebGrid Script 
Version 3.0.20041.11
Copyright (c) 2001-2004 Infragistics, Inc. All Rights Reserved.
*/

var igtbl_gridState=[];

function igtbl_grid(_gridElement,gridProps,gridEvents)
{
	this.SelectedRows=[];
	this.SelectedColumns=[];
	this.SelectedCells=[];
	this.SelectedCellsRows=[];
	this.ExpandedRows=[];
	this.CollapsedRows=[];
	
	this.ResizedColumns=[];
	this.ResizedRows=[];
	
	this.ChangedRows=[];
	this.ChangedCells=[];
	
	this.AddedRows=[];
	this.DeletedRows=[];
	
	this.ViewState=ig_ClientState.addNode(ig_ClientState.createRootNode(),"WEBGRID");
	
	this.ActiveCell="";
	this.ActiveRow="";
	
	this.grid=this;
	this.lastSelectedRow="";
	this.ScrollPos=0;
	this.activeRect=null;
	this.currentTriImg=null;
	this.newImg=null;
	
	this.NeedPostBack=false;
	this.CancelPostBack=false;
	this.GridIsLoaded=false;
	
	this.exitEditCancel=false;
	this.noCellChange=false;
	this.insideSetActive=false;
	this.CaseSensitiveSort=false;
	
    this.Id = _gridElement.id.substr(2);
	this.Element = _gridElement;

	this.props=gridProps;
	this.AddNewBoxVisible=gridProps[0];
	this.AddNewBoxView=gridProps[1];
	this.AllowAddNew=gridProps[2];
	this.AllowColSizing=gridProps[3];
	this.AllowDelete=gridProps[4];
	this.AllowSort=gridProps[5];
	this.ItemClass=gridProps[6];
	this.AltClass=gridProps[7];
	this.AllowUpdate=gridProps[8];
	this.CellClickAction=gridProps[9];
	this.EditCellClass=gridProps[10];
	this.Expandable=gridProps[11];
	this.FooterClass=gridProps[12];
	this.GroupByRowClass=gridProps[13];
	this.GroupCount=gridProps[14];
	this.HeaderClass=gridProps[15];
	this.HeaderClickAction=gridProps[16];
	this.Indentation=gridProps[17];
	this.NullText=gridProps[18];
	this.ExpAreaClass=gridProps[19];
	this.RowLabelClass=gridProps[20];
	this.SelGroupByRowClass=gridProps[21];
	this.SelHeadClass=gridProps[22];
	this.SelCellClass=gridProps[23];
	this.RowSizing=gridProps[24];
	this.SelectTypeCell=gridProps[25];
	this.SelectTypeColumn=gridProps[26];
	this.SelectTypeRow=gridProps[27];
	this.ShowBandLabels=gridProps[28];
	this.ViewType=gridProps[29];
	this.AllowPaging=gridProps[30];
	this.PageCount=gridProps[31];
	this.CurrentPageIndex=gridProps[32];
	this.PageSize=gridProps[33];
	this.CollapseImage=gridProps[34];
	this.ExpandImage=gridProps[35];
	this.CurrentRowImage=gridProps[36];
	this.CurrentEditRowImage=gridProps[37];
	this.NewRowImage=gridProps[38];
	this.BlankImage=gridProps[39];
	this.SortAscImg=gridProps[40];
	this.SortDscImg=gridProps[41];
	this.Activation=new igtbl_initActivation(gridProps[42]);
	this.cultureInfo=gridProps[43].split("|");
	this.RowSelectors=gridProps[44];
	this.UniqueID=gridProps[45];
	this.StationaryMargins=gridProps[46];
	this.LoadOnDemand=gridProps[47];
	this.RowLabelBlankImage=gridProps[48];
	this.EIRM=gridProps[49];
	this.TabDirection=gridProps[50];

	var cse=new init_Events(gridEvents);
	this.Events=cse;

	this.sortColumn=igtbl_sortColumn;
	this.addSortColumn=igtbl_addSortColumn;
	this.getActiveCell=igtbl_gGetActiveCell;
	this.setActiveCell=igtbl_gSetActiveCell;
	this.getActiveRow=igtbl_gGetActiveRow;
	this.setActiveRow=igtbl_gSetActiveRow;
	this.deleteSelectedRows=igtbl_gDeleteSelectedRows;
	this.unloadGrid=igtbl_gUnloadGrid;
	this.beginEditTemplate=igtbl_gEditTempl;
	this.endEditTemplate=igtbl_gEndEditTempl;
	this.GroupByBox=new igtbl_initGroupByBox(this);
	this.find=igtbl_gFind;
	this.findNext=igtbl_gFindNext;
	this.alignGrid=igtbl_gAlignGrid;
	this.alignStatMargins=igtbl_gAlignStatMargins;
	this.selectCellRegion=igtbl_gSelectCellRegion;
	this.selectRowRegion=igtbl_gSelectRowRegion;
	this.selectColRegion=igtbl_gSelectColRegion;
	this.startHourGlass=igtbl_gStartHourGlass;
	this.stopHourGlass=igtbl_gEndHourGlass;
	this.clearSelectionAll=igtbl_gClearSelectionAll;
	
	this.regExp=null;
	this.backwardSearch=false;
	this.lastSearchedCell=null;
	
    this.lastSortedColumn="";
    
	this.SuspendUpdates=false;
	this.suspendUpdates=igtbl_gSuspendUpdates;
	
	this.beginEdit=function()
	{
		if(this.activeCell)
			this.activeCell.beginEdit();
	}
	this.endEdit=function()
	{
		igtbl_hideEdit(this.Id);
	}
	this.fireEvent=function(eventName,args)
	{
		igtbl_fireEvent(this.Id,eventName,args);
	}
	this.setNewRowImg=function(row)
	{
		if(row)
			row.setNewRowImg();
		else
			igtbl_setNewRowImg(this.Id,null);
	}
	this.colButtonMouseOut=function()
	{
		igtbl_colButtonMouseOut(this.Id);
	}
	this.updateAddNewBox=function()
	{
		igtbl_updateAddNewBox(this.Id);
	}
	this.update=function()
	{
		var p=igtbl_getElementById(this.Id);
		if(!p) return;
		var node;
		if(igtbl_getLength(this.AddedRows)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"AddedRows");
			for(var row in this.AddedRows)
			{
				var rowObj=igtbl_getElementById(row);
				if(rowObj && this.AddedRows[row])
				{
					var rn=ig_ClientState.addNode(node,row);
					if(rowObj.getAttribute("level"))
						rn.setAttribute("level",rowObj.getAttribute("level"));
				}
			}
		}
		if(igtbl_getLength(this.SelectedRows)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"SelectedRows");
			for(var row in this.SelectedRows)
			{
				var rowObj=igtbl_getElementById(row);
				if(rowObj && this.SelectedRows[row])
				{
					var rn=ig_ClientState.addNode(node,row);
					if(rowObj.getAttribute("level"))
						rn.setAttribute("level",rowObj.getAttribute("level"));
				}
			}
		}
		if(igtbl_getLength(this.ExpandedRows)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"ExpandedRows");
			for(var row in this.ExpandedRows)
			{
				var rowObj=igtbl_getElementById(row);
				if(rowObj && this.ExpandedRows[row])
				{
					var rn=ig_ClientState.addNode(node,row);
					if(rowObj.getAttribute("level"))
						rn.setAttribute("level",rowObj.getAttribute("level"));
				}
			}
		}
		if(igtbl_getLength(this.CollapsedRows)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"CollapsedRows");
			for(var row in this.CollapsedRows)
			{
				var rowObj=igtbl_getElementById(row);
				if(rowObj && this.CollapsedRows[row])
				{
					var rn=ig_ClientState.addNode(node,row);
					if(rowObj.getAttribute("level"))
						rn.setAttribute("level",rowObj.getAttribute("level"));
				}
			}
		}
		if(igtbl_getLength(this.ResizedRows)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"ResizedRows");
			for(row in this.ResizedRows)
			{
				var rowObj=igtbl_getElementById(row);
				if(rowObj)
				{
					var rn=ig_ClientState.addNode(node,row);
					if(rowObj.getAttribute("level"))
						rn.setAttribute("level",rowObj.getAttribute("level"));
					rn.setAttribute("value",this.ResizedRows[row]);
				}
			}
		}
		if(igtbl_getLength(this.SelectedColumns)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"SelectedColumns");
			for(var column in this.SelectedColumns)
			{
				columnObj=igtbl_getElementById(column);
				if(columnObj && this.SelectedColumns[column]==true)
					ig_ClientState.addNode(node,column);
			}
		}
		if(igtbl_getLength(this.ResizedColumns)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"ResizedColumns");
			for(column in this.ResizedColumns)
				ig_ClientState.addNode(node,column).setAttribute("value",this.ResizedColumns[column]);
		}
		if(igtbl_getLength(this.SelectedCells)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"SelectedCells");
			for(var cell in this.SelectedCells)
			{
				cellObj=igtbl_getElementById(cell);
				if(cellObj && this.SelectedCells[cell]==true)
				{
					var cn=ig_ClientState.addNode(node,cell);
					if(cellObj.getAttribute("level"))
						cn.setAttribute("level",cellObj.getAttribute("level"));
				}
			}
		}
		if(igtbl_getLength(this.ChangedCells)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"ChangedCells");
			for(var cell in this.ChangedCells)
			{
				cellObj=igtbl_getElementById(cell);
				if(cellObj)
				{
					var cn=ig_ClientState.addNode(node,cell);
					if(cellObj.getAttribute("level"))
						cn.setAttribute("level",cellObj.getAttribute("level"));
					var val=this.ChangedCells[cell];
					if(val!=null && val!="")
						cn.setAttribute("value",val);
				}
			}
		}
		if(this.oActiveCell)
		{
			var ac=ig_ClientState.addNode(this.ViewState,"ActiveCell");
			ac.setAttribute("value",this.oActiveCell.Element.id);
			if(this.oActiveCell.Element.getAttribute("level"))
				ac.setAttribute("level",this.oActiveCell.Element.getAttribute("level"));
		}
		else if(this.oActiveRow)
		{
			var ar=ig_ClientState.addNode(this.ViewState,"ActiveRow");
			ar.setAttribute("value",this.oActiveRow.Element.id);
			if(this.oActiveRow.Element.getAttribute("level"))
				ar.setAttribute("level",this.oActiveRow.Element.getAttribute("level"));
		}
		if(igtbl_getLength(this.DeletedRows)>0)
		{
			node=ig_ClientState.addNode(this.ViewState,"DeletedRows");
			for(var row in this.DeletedRows)
			{
				if(this.DeletedRows[row])
					ig_ClientState.addNode(node,row);
			}
		}
		node=null;
		for(var i=0;i<this.Bands.length;i++)
		{
			var band=this.Bands[i];
			if(!node && band.SortedColumns && band.SortedColumns.length>0)
				node=ig_ClientState.addNode(this.ViewState,"SortedColumns");
			for(var j=0;j<band.SortedColumns.length;j++)
			{
				var col=band.SortedColumns[j];
				var cn=ig_ClientState.addNode(node,col);
				cn.setAttribute("sortIndicator",band.Columns[igtbl_colNoFromColId(col)].SortIndicator);
				cn.setAttribute("lastSorted",(col==this.lastSortedColumn).toString());
			}
		}
		ig_ClientState.addNode(this.ViewState,"ScrollLeft").setAttribute("value",this.Element.parentNode.scrollLeft);
		ig_ClientState.addNode(this.ViewState,"ScrollTop").setAttribute("value",this.Element.parentNode.scrollTop);
		if(this.moveBackPostField)
			this.ViewState.appendChild(ig_ClientState.removeNode(this.ViewState,this.moveBackPostField));
		p.value=ig_ClientState.getText(this.ViewState.parentNode);
	}
	this.goToPage=function(page)
	{
		if(!this.AllowPaging || this.CurrentPage==page || page<1 || page>this.PageCount)
			return;
		igtbl_doPostBack(this.Id,"Page:"+page.toString());
	}
	
	delete gridProps;
	delete gridEvents;
	
	var thisForm=this.Element.parentNode;
	while(thisForm && thisForm.tagName!="FORM")
		thisForm=thisForm.parentNode;
	if(thisForm)
	{
		this.thisForm=thisForm;
		if(thisForm.igtblGrid)
			this.oldIgtblGrid=thisForm.igtblGrid;
		else
		{
			if(thisForm.addEventListener)
				thisForm.addEventListener('submit',igtbl_submit,false);
			else if(thisForm.onsubmit!=igtbl_submit)
			{
				thisForm.oldOnSubmit=thisForm.onsubmit;
				thisForm.onsubmit=igtbl_submit;
			}
			window.__doPostBackOld=window.__doPostBack;
			window.__doPostBack=igtbl_submit;
			window.__thisForm=thisForm;
		}
		thisForm.igtblGrid=this;
	}
	
	/*v30 1*/
}

var igtbl_bInsideOldOnSubmit=false;
function igtbl_submit()
{
	if(arguments.length==0)
	{
		if(this.oldOnSubmit && !igtbl_bInsideOldOnSubmit)
		{
			igtbl_bInsideOldOnSubmit=true;
			this.oldOnSubmit();
			igtbl_bInsideOldOnSubmit=false;
		}
		igtbl_updateGridsPost(this.igtblGrid);
	}
	else if(typeof(window.__doPostBackOld)!="undefined")
	{
		igtbl_updateGridsPost(window.__thisForm.igtblGrid);
		window.__doPostBackOld(arguments[0],arguments[1]);
	}
}

function igtbl_updateGridsPost(grid)
{
	if(!grid) return;
	igtbl_updateGridsPost(grid.oldIgtblGrid);
	grid.update();
}
	
function igtbl_initActivation(aa)
{
	this.AllowActivation=aa[0];
	this.BorderColor=aa[1];
	this.BorderStyle=aa[2];
	this.BorderWidth=aa[3];
}

function igtbl_gGetActiveCell()
{
	return this.oActiveCell;
}

function igtbl_gSetActiveCell(cell,force)
{
	if(!this.Activation.AllowActivation || this.insideSetActive)
		return;
	if(!cell || !cell.Element || cell.Element.tagName!="TD")
		cell=null;
	if(!force && (this.oActiveCell==cell || this.exitEditCancel))
	{
		this.noCellChange=true;
		return;
	}
	if(!cell)
	{
		this.ActiveCell="";
		this.ActiveRow="";
		var row=null;
		if(this.oActiveCell)
			row=this.oActiveCell.Row;
		else if(this.oActiveRow)
			row=this.oActiveRow;
		row.setSelectedRowImg(false);
		if(this.oActiveCell)
			this.oActiveCell.renderActive(false);
		if(this.oActiveRow)
			this.oActiveRow.renderActive(false);
		this.oActiveCell=null;
		this.oActiveRow=null;
		if(this.AddNewBoxVisible)
			this.updateAddNewBox();
		return;
	}
	var change=true;
	var oldACell=this.oActiveCell;
	var oldARow=this.oActiveRow;
	if(!oldARow && oldACell)
		oldARow=oldACell.Row;
	this.endEdit();
	
	if(this.exitEditCancel || this.fireEvent(this.Events.BeforeCellChange,"(\""+this.Id+"\",\""+cell.Element.id+"\")")==true)
		change=false;
	if(cell.Row!=oldARow)
		if(this.exitEditCancel || this.fireEvent(this.Events.BeforeRowActivate,"(\""+this.Id+"\",\""+cell.Row.Element.id+"\")")==true)
			change=false;
	if(!change)
	{
		this.noCellChange=true;
		return;
	}
	this.noCellChange=false;
	if(this.oActiveCell)
		this.oActiveCell.renderActive(false);
	if(this.oActiveRow)
		this.oActiveRow.renderActive(false);
	this.oActiveCell=cell;
	this.ActiveCell=cell.Element.id;
	this.oActiveRow=null;
	this.ActiveRow="";
	this.oActiveCell.renderActive();
	if(this.oActiveCell.Row!=oldARow)
		this.setNewRowImg(null);
	this.oActiveCell.Row.setSelectedRowImg();
	this.colButtonMouseOut();
	if(this.AddNewBoxVisible)
		this.updateAddNewBox();
	this.fireEvent(this.Events.CellChange,"(\""+this.Id+"\",\""+this.oActiveCell.Element.id+"\");");
	if(this.oActiveCell.Row!=oldARow)
		this.fireEvent(this.Events.AfterRowActivate,"(\""+this.Id+"\",\""+this.oActiveCell.Row.Element.id+"\");");
}

function igtbl_gGetActiveRow()
{
	return this.oActiveRow;
}

function igtbl_gSetActiveRow(row,force)
{
	if(!this.Activation.AllowActivation || this.insideSetActive)
		return;
	if(!row || !row.Element || row.Element.tagName!="TR")
		row=null;
	if(!force && (this.oActiveRow==row || this.exitEditCancel))
	{
		this.noCellChange=true;
		return;
	}
	if(!row)
	{
		this.ActiveCell="";
		this.ActiveRow="";
		var row=null;
		if(this.oActiveCell)
			row=this.oActiveCell.Row;
		else if(this.oActiveRow)
			row=this.oActiveRow;
		row.setSelectedRowImg(false);
		if(this.oActiveCell)
			this.oActiveCell.renderActive(false);
		if(this.oActiveRow)
			this.oActiveRow.renderActive(false);
		this.oActiveCell=null;
		this.oActiveRow=null;
		if(this.AddNewBoxVisible)
			this.updateAddNewBox();
		return;
	}
	var change=true;
	var oldACell=this.oActiveCell;
	var oldARow=this.oActiveRow;
	if(!oldARow && oldACell)
		oldARow=oldACell.Row;
	this.endEdit();

	if(this.exitEditCancel || this.fireEvent(this.Events.BeforeRowActivate,"(\""+this.Id+"\",\""+row.Element.id+"\")")==true)
		change=false;
	if(!change)
	{
		this.noCellChange=true;
		return;
	}
	this.noCellChange=false;
	if(this.oActiveCell)
		this.oActiveCell.renderActive(false);
	if(this.oActiveRow)
		this.oActiveRow.renderActive(false);
	this.oActiveRow=row;
	this.ActiveRow=row.Element.id;
	this.oActiveCell=null;
	this.ActiveCell="";
	this.oActiveRow.renderActive();
	this.oActiveRow.setSelectedRowImg();
	this.colButtonMouseOut();
	if(this.AddNewBoxVisible)
		this.updateAddNewBox();
	this.fireEvent(this.Events.AfterRowActivate,"(\""+this.Id+"\",\""+row.Element.id+"\");");
}

function igtbl_gDeleteSelectedRows()
{
	igtbl_deleteSelRows(this.Id);
	igtbl_activate(this.Id);
}

function igtbl_gUnloadGrid()
{
	igtbl_unloadGrid(this.Id);
}

function igtbl_deleteSelRows(gn)
{
	var gs=igtbl_getGridById(gn);
	var del=false;
	var ar=gs.getActiveRow();
	var r=null;
	if(igtbl_inEditMode(gn))
	{
		igtbl_hideEdit(gn);
		if(igtbl_inEditMode(gn))
			return;
	}
	if(ar && !gs.getActiveCell())
	{
		r=ar.getNextRow();
		while(r && r.getSelected())
			r=r.getNextRow();
		if(!r)
		{
			r=ar.getPrevRow();
			while(r && r.getSelected())
				r=r.getPrevRow();
		}
		if(!r)
			r=ar.ParentRow;
	}
	for(var rowId in gs.SelectedRows)
	{
		if(gs.SelectedRows[rowId])
		{
			var row=igtbl_getRowById(rowId);
			if(row && row.deleteRow(true))
				del=true;
		}
	}
	ar=gs.getActiveRow();
	if(!del && ar && !gs.SelectedRows[ar.Element.id])
	{
		del=ar.deleteRow(true);
		if(del) ar=null;
	}
	if(del)
	{
		if(r && igtbl_getElementById(r.Element.id))
		{
			r.setSelected();
			r.activate();
			ar=r;
		}
		else
			ar=null;
	}
	if(!ar)
		gs.setActiveRow(null);
	gs.alignStatMargins();
	if(gs.NeedPostBack)
		igtbl_doPostBack(gn);
}

function igtbl_deleteRow(gn,rowId)
{
	var row=igtbl_getRowById(rowId);
	if(!row)
		return false;
	return row.deleteRow();
}

function igtbl_gEditTempl()
{
	var row=this.getActiveRow();
	if(row)
		row.editRow();
}

function igtbl_gEndEditTempl(saveChanges)
{
	var row=this.getActiveRow();
	if(row)
		row.endEditRow(saveChanges);
}

function igtbl_gFind(re,back)
{
	var g=this;
	if(re)
		g.regExp=re;
	if(!g.regExp)
		return null;
	g.lastSearchedCell=null;
	if(back==true || back==false)
		g.backwardSearch=back;
	var row=null;
	if(!g.backwardSearch)
	{
		row=g.Rows.getRow(0);
		if(row && row.getHidden())
			row=row.getNextRow();
		while(row && row.find()==null)
			row=row.getNextTabRow(false,true);
	}
	else
	{
		var rows=g.Rows;
		while(rows)
		{
			row=rows.getRow(rows.length-1);
			if(row && row.getHidden())
				row=row.getPrevRow();
			if(row && row.Expandable)
				rows=row.Rows;
			else
			{
				if(!row)
					row=rows.ParentRow;
				rows=null;
			}
		}
		while(row && row.find()==null)
			row=row.getNextTabRow(true,true);
	}
	return g.lastSearchedCell;
}

function igtbl_gFindNext(re,back)
{
	var g=this;
	if(!g.lastSearchedCell)
		return this.find(re,back);
	if(re)
		g.regExp=re;
	if(!g.regExp)
		return null;
	if(back==true || back==false)
		g.backwardSearch=back;
	var row=g.lastSearchedCell.Row;
	while(row && row.findNext()==null)
		row=row.getNextTabRow(g.backwardSearch,true);
	return g.lastSearchedCell;
}

function igtbl_gAlignGrid()
{
}

function igtbl_gAlignStatMargins()
{
	if(this.StatHeader)
		this.StatHeader.ScrollTo(this.Element.parentNode.scrollLeft);
	if(this.StatFooter)
		this.StatFooter.ScrollTo(this.Element.parentNode.scrollLeft);
}

function igtbl_gSelectCellRegion(startCell,endCell)
{
	var sCol=startCell.Column,eCol=endCell.Column;
	if(sCol.Index>eCol.Index)
	{
		var c=sCol;
		sCol=eCol;
		eCol=c;
	}
	var sRow=startCell.Row,sRowIndex=sRow.getIndex(),eRow=endCell.Row,eRowIndex=eRow.getIndex();
	if(sRowIndex>eRowIndex)
	{
		var c=sRow;
		sRow=eRow;
		eRow=c;
		var i=sRowIndex;
		sRowIndex=eRowIndex;
		eRowIndex=i;
	}
	var pc=sRow.OwnerCollection;
	var band=sCol.Band;
	var selArray=new Array();
	for(var i=sRowIndex;i<=eRowIndex;i++)
	{
		var row=pc.getRow(i);
		if(!row.getHidden())
			for(var j=sCol.Index;j<=eCol.Index;j++)
			{
				var col=band.Columns[j];
				if(!col.getHidden())
				{
					var cell=row.getCellByColumn(col);
					if(cell)
						selArray[selArray.length]=cell.Element.id;
				}
			}
	}
	if(selArray.length>0)
		igtbl_gSelectArray(this.Id,0,selArray);
	delete selArray;
}

function igtbl_gSelectRowRegion(startRow,endRow)
{
	var sRowIndex=startRow.getIndex(),eRowIndex=endRow.getIndex();
	if(sRowIndex>eRowIndex)
	{
		var r=startRow;
		startRow=endRow;
		endRow=r;
		var i=sRowIndex;
		sRowIndex=eRowIndex;
		eRowIndex=i;
	}
	var pc=startRow.OwnerCollection;
	var selArray=new Array();
	for(var i=sRowIndex;i<=eRowIndex;i++)
	{
		var row=pc.getRow(i);
		if(!row.getHidden())
			selArray[selArray.length]=row.Element.id;
	}
	if(selArray.length>0)
		igtbl_gSelectArray(this.Id,1,selArray);
	delete selArray;
}

function igtbl_gSelectColRegion(startCol,endCol)
{
	if(startCol.Index>endCol.Index)
	{
		var c=startCol;
		startCol=endCol;
		endCol=c;
	}
	var band=startCol.Band;
	var selArray=new Array();
	for(var i=startCol.Index;i<=endCol.Index;i++)
	{
		var col=band.Columns[i];
		if(!col.getHidden())
			selArray[selArray.length]=col.Id;
	}
	if(selArray.length>0)
		igtbl_gSelectArray(this.Id,2,selArray);
	delete selArray;
}

var igtbl_waitDiv=null;
var igtbl_wndOldCursor="";

function igtbl_gStartHourGlass()
{
	if(!igtbl_waitDiv)
	{
		igtbl_waitDiv=document.createElement("div");
		document.body.appendChild(igtbl_waitDiv);
		igtbl_waitDiv.style.zIndex=10000;
		igtbl_waitDiv.style.position="absolute";
		igtbl_waitDiv.style.left=0;
		igtbl_waitDiv.style.top=0;
		igtbl_waitDiv.style.backgroundColor="transparent";
	}
	igtbl_waitDiv.style.display="";
	igtbl_waitDiv.style.width=document.body.clientWidth;
	igtbl_waitDiv.style.height=document.body.clientHeight;
	igtbl_waitDiv.style.cursor="wait";
	igtbl_wndOldCursor=document.body.style.cursor;
	document.body.style.cursor="wait";
}

function igtbl_gEndHourGlass()
{
	if(igtbl_waitDiv)
	{
		igtbl_waitDiv.style.cursor="";
		igtbl_waitDiv.style.display="none";
		document.body.style.cursor=igtbl_wndOldCursor;
	}
}

function igtbl_gClearSelectionAll()
{
	igtbl_clearSelectionAll(this.Id);
}

function igtbl_gSuspendUpdates(suspend)
{
	if(suspend==false)
	{
		this.SuspendUpdates=false;
	}
	else
		this.SuspendUpdates=true;
}

function igtbl_gSelectArray(gn,elem,array)
{
	var gs=igtbl_getGridById(gn);
	gs.noCellChange=false;
	if(elem==0)
	{
		var oldSelCells=gs.SelectedCells;
		gs.SelectedCells=[];
		for(var i=0;i<array.length;i++)
			if(!oldSelCells[array[i]])
				igtbl_selectCell(gn,array[i]);
			else
				gs.SelectedCells[array[i]]=true;
		for(var cell in oldSelCells)
			if(!gs.SelectedCells[cell])
				igtbl_selectCell(gn,cell,false,false);
		for(var cell in oldSelCells)
			delete oldSelCells[cell];
	}
	else if(elem==1)
	{
		var oldSelRows=gs.SelectedRows;
		gs.SelectedRows=[];
		for(var i=0;i<array.length;i++)
			if(!oldSelRows[array[i]])
				igtbl_selectRow(gn,array[i]);
			else
				gs.SelectedRows[array[i]]=true;
		for(var row in oldSelRows)
			if(!gs.SelectedRows[row])
				igtbl_selectRow(gn,row,false,false);
		for(var row in oldSelRows)
			delete oldSelRows[row];
	}
	else
	{
		var oldSelCols=gs.SelectedColumns;
		gs.SelectedColumns=[];
		for(var i=0;i<array.length;i++)
			if(!oldSelCols[array[i]])
				igtbl_selectColumn(gn,array[i]);
			else
				gs.SelectedColumns[array[i]]=true;
		for(var col in oldSelCols)
			if(!gs.SelectedColumns[col])
				igtbl_selectColumn(gn,col,false,false);
		for(var col in oldSelCols)
			delete oldSelCols[col];
	}
}

function init_Events(ge)
{
	this.AfterCellUpdate=ge[0];
	this.AfterColumnMove=ge[1];
	this.AfterColumnSizeChange=ge[2];
	this.AfterEnterEditMode=ge[3];
	this.AfterExitEditMode=ge[4];
	this.AfterRowActivate=ge[5];
	this.AfterRowCollapsed=ge[6];
	this.AfterRowDeleted=ge[7];
	this.AfterRowTemplateClose=ge[8];
	this.AfterRowTemplateOpen=ge[9];
	this.AfterRowExpanded=ge[10];
	this.AfterRowInsert=ge[11];
	this.AfterRowSizeChange=ge[12];
	this.AfterSelectChange=ge[13];
	this.AfterSortColumn=ge[14];
	this.BeforeCellChange=ge[15];
	this.BeforeCellUpdate=ge[16];
	this.BeforeColumnMove=ge[17];
	this.BeforeColumnSizeChange=ge[18];
	this.BeforeEnterEditMode=ge[19];
	this.BeforeExitEditMode=ge[20];
	this.BeforeRowActivate=ge[21];
	this.BeforeRowCollapsed=ge[22];
	this.BeforeRowDeleted=ge[23];
	this.BeforeRowTemplateClose=ge[24];
	this.BeforeRowTemplateOpen=ge[25];
	this.BeforeRowExpanded=ge[26];
	this.BeforeRowInsert=ge[27];
	this.BeforeRowSizeChange=ge[28];
	this.BeforeSelectChange=ge[29];
	this.BeforeSortColumn=ge[30];
	this.ClickCellButton=ge[31];
	this.CellChange=ge[32];
	this.CellClick=ge[33];
	this.ColumnDrag=ge[34];
	this.ColumnHeaderClick=ge[35];
	this.DblClick=ge[36];
	this.EditKeyDown=ge[37];
	this.EditKeyUp=ge[38];
	this.InitializeLayout=ge[39];
	this.InitializeRow=ge[40];
	this.KeyDown=ge[41];
	this.KeyUp=ge[42];
	this.MouseDown=ge[43];
	this.MouseOver=ge[44];
	this.MouseOut=ge[45];
	this.MouseUp=ge[46];
	this.RowSelectorClick=ge[47];
	this.TemplateUpdateCells=ge[48];
	this.TemplateUpdateControls=ge[49];
	this.ValueListSelChange=ge[50];
}

function igtbl_band(grid, bandArray, count) 
{
    this.Grid=grid;
	this.bnd=bandArray;
	this.Key=bandArray[0];
	this.AllowAddNew=bandArray[1];
	this.AllowColSizing=bandArray[2];
	this.AllowDelete=bandArray[3];
	this.AllowSort=bandArray[4];
	this.ItemClass=bandArray[5];
	this.AltClass=bandArray[6];
	this.AllowUpdate=bandArray[7];
	this.CellClickAction=bandArray[8];
	this.ColHeadersVisible=bandArray[9];
	this.ColFootersVisible=bandArray[10];
	this.CollapseImage=bandArray[11];
	this.CurrentRowImage=bandArray[12];
	this.CurrentEditRowImage=bandArray[13];
	this.DefaultRowHeight=bandArray[14];
	this.EditCellClass=bandArray[15];
	this.Expandable=bandArray[16];
	this.ExpandImage=bandArray[17];
	this.FooterClass=bandArray[18];
	this.GroupByRowClass=bandArray[19];
	this.GroupCount=bandArray[20];
	this.HeaderClass=bandArray[21];
	this.HeaderClickAction=bandArray[22];
	this.Visible=bandArray[23];
	this.IsGrouped=bandArray[24];
	this.ExpAreaClass=bandArray[25];
	this.NonSelHeaderClass=bandArray[26];
	this.RowLabelClass=bandArray[27];
	this.SelGroupByRowClass=bandArray[28];
	this.SelHeadClass=bandArray[29];
	this.SelCellClass=bandArray[30];
	this.RowSizing=bandArray[31];
	this.SelectTypeCell=bandArray[32];
	this.SelectTypeColumn=bandArray[33];
	this.SelectTypeRow=bandArray[34];
	this.RowSelectors=bandArray[35];
	this.getRowSelectors=function()
	{
		var res=this.Grid.RowSelectors;
		if(this.RowSelectors!=0)
			res=this.RowSelectors;
		return res;
	};
	this.NullText=bandArray[36];
	this.RowTemplate=bandArray[37];
	if(this.RowTemplate!="")
		this.ExpandEffects=new igtree_expandEffects(bandArray[38]);
	this.AllowColumnMoving=bandArray[39];
	this.ClientSortEnabled=bandArray[40];
	this.Indentation=bandArray[41];
	this.RowLabelWidth=bandArray[42];
	
	if(this.ClientSortEnabled)
		this.Grid.sort=igtbl_sortGrid;

	this.VisibleColumnsCount=0;
	this.Index=parseInt(count,10);
	
	var colsArray = eval("igtbl_" + grid.Id + "_Columns_" + count);
	var colCount =  colsArray.length;
	this.Columns = new Array(colCount);
	var i;
	for(var i = 0; i < colCount; i++) {
		this.Columns[i] = new igtbl_column(this, colsArray[i], i);
		if(!this.Columns[i].Hidden)
			this.VisibleColumnsCount++;
	}
	delete colsArray;
	delete bandArray;

	if(grid.AddNewBoxVisible)
	{
		if(count==0)
			this.curTable=grid.Element;
		var addNew=igtbl_getElementById(grid.Id+"_addBox");
		if(grid.AddNewBoxView==0)
			this.addNewElem = addNew.childNodes[0].rows[0].cells[1].childNodes[0].rows[count].cells[count].childNodes[0];
		else
			this.addNewElem = addNew.childNodes[0].rows[0].cells[1].childNodes[0].rows[0].cells[count*2].childNodes[0];
	}

	this.SortedColumns=new Array();
	this.getSelectTypeRow=igtbl_gGetBandSelectTypeRow;
	this.getSelectTypeCell=igtbl_gGetBandSelectTypeCell;
	this.getSelectTypeColumn=igtbl_gGetBandSelectTypeColumn;
	this.getColumnFromKey=igtbl_gGetBandColumnFromKey;
	this.getExpandImage=igtbl_gGetBandExpandImage;
	this.getCollapseImage=igtbl_gGetBandCollapseImage;
	this.getRowStyleClassName=igtbl_gGetBandItemClass;
	this.getRowAltClassName=igtbl_gGetBandAltClass;
	this.getExpandable=igtbl_gGetBandExpandable;
	this.getCellClickAction=igtbl_gGetBandCellClickAction;
}

function igtbl_gGetBandSelectTypeRow()
{
	var res=this.Grid.SelectTypeRow;
	if(this.SelectTypeRow!=0)
		res=this.SelectTypeRow;
	return res;
}

function igtbl_gGetBandSelectTypeCell()
{
	var res=this.Grid.SelectTypeCell;
	if(this.SelectTypeCell!=0)
		res=this.SelectTypeCell;
	return res;
}

function igtbl_gGetBandSelectTypeColumn()
{
	var res=this.Grid.SelectTypeColumn;
	if(this.SelectTypeColumn!=0)
		res=this.SelectTypeColumn;
	return res;
}

function igtbl_gGetBandColumnFromKey(key)
{
	var column=null;
	for(var i=0;i<this.Columns.length;i++)
		if(this.Columns[i].Key==key)
		{
			column=this.Columns[i];
			break;
		}
	return column;
}

function igtbl_gGetBandExpandImage()
{
	return igtbl_getExpandImage(this.Grid.Id,this.Index);
}

function igtbl_gGetBandCollapseImage()
{
	return igtbl_getCollapseImage(this.Grid.Id,this.Index);
}

function igtbl_gGetBandItemClass()
{
	if(this.ItemClass!="")
		return this.ItemClass;
	return this.Grid.ItemClass;
}

function igtbl_gGetBandAltClass()
{
	if(this.AltClass!="")
		return this.AltClass;
	return this.Grid.AltClass;
}

function igtbl_gGetBandExpandable()
{
	if(this.Expandable!=0)
		return this.Expandable;
	else return this.Grid.Expandable;
}

function igtbl_gGetBandCellClickAction()
{
	return igtbl_getCellClickAction(this.Grid.Id,this.Index);
}

function igtree_expandEffects(values)
{
	this.Delay=values[0];
	this.Duration=values[1];
	this.Opacity=values[2];
	this.ShadowColor=values[3];
	this.ShadowWidth=values[4];
	this.Type=values[5];
}

// Constuctor for the column object
function igtbl_column(band, colArray, index)
{
	this.Band=band;
	this.Index=index;
	this.Id=band.Grid.Id+"c_"+band.Index.toString()+"_"+index.toString();
    this.Key=colArray[0];
    this.HeaderText=colArray[1];
    this.DataType=parseInt(colArray[2],10);
    this.CellMultiline=colArray[3];
    this.Hidden=colArray[4];
    this.AllowGroupBy=colArray[5];
    this.AllowColResizing=colArray[6];
    this.AllowUpdate=colArray[7];
    this.Case=colArray[8];
    this.FieldLength=parseInt(colArray[9],10);
    this.CellButtonDisplay=colArray[10];
    this.HeaderClickAction=colArray[11];
    this.IsGroupBy=colArray[12];
    this.MaskDisplay=colArray[13];
    this.Selected=colArray[14];
    this.SortIndicator=colArray[15];
	this.NullText=colArray[16];
    this.ButtonClass=colArray[17];
    this.SelCellClass=colArray[18];
    this.SelHeadClass=colArray[19];
    this.Type=colArray[20];
    this.ValueListPrompt=colArray[21];
    this.ValueList=colArray[22];
    this.ValueListClass=colArray[23];
    this.EditorControlID=colArray[24];
	this.editorControl=igtbl_getElementById(this.EditorControlID);
	if(this.editorControl)
		this.editorControl=this.editorControl.Object;
    this.WebComboId=this.EditorControlID;
    this.DefaultValue=colArray[25];
    this.TemplatedColumn=colArray[26];
    this.Validators=colArray[27];
    this.CssClass=colArray[28];
    this.Style=colArray[29];
    this.Width=colArray[30];
    this.AllowNull=colArray[31];
    this.Wrap=colArray[32];
    this.ServerOnly=colArray[33];
    
	this.getAllowUpdate=igtbl_gGetColAllowUpdate;
	this.getHidden=igtbl_gGetHidden;
	this.setHidden=igtbl_gSetHidden;
	this.getNullText=igtbl_gGetColNullText;
    delete colArray;

	this.find=igtbl_gColFind;
	this.findNext=igtbl_gColFindNext;
	this.getFooterText=igtbl_gGetFooterText;
	this.setFooterText=igtbl_gSetFooterText;
	
	if(this.Validators.length>0 && typeof(Page_Validators)!="undefined")
	{
		for(var i=0;i<this.Validators.length;i++)
		{
			var val=igtbl_getElementById(this.Validators[i]);
			if(val)
				val.enabled=false;
		}
	}
}

function igtbl_gGetColAllowUpdate()
{
	var g=this.Band.Grid;
	var res=g.AllowUpdate;
	if(this.Band.AllowUpdate!=0)
		res=this.Band.AllowUpdate;
	if(this.AllowUpdate!=0)
		res=this.AllowUpdate;
	if(this.TemplatedColumn)
		res=2;
	return res;
}

function igtbl_gGetHidden()
{
	return this.Hidden;
}

function igtbl_gSetHidden(h)
{
	if(this.Band.Index==0)
	{
		if(this.Band.Grid.StatHeader)
		{
			var el=this.Band.Grid.StatHeader.getElementByColumn(this);
			el.style.display=(h?"none":"");
		}
		if(this.Band.Grid.StatFooter)
		{
			var el=this.Band.Grid.StatFooter.getElementByColumn(this);
			el.style.display=(h?"none":"");
		}
	}
	igtbl_hideColumn(this.Band.Grid.Rows,this,h);
	this.Hidden=h;
	if(this.Band.Index==0)
		this.Band.Grid.alignStatMargins();
	var ac=this.Band.Grid.getActiveCell();
	if(ac && ac.Column==this && h)
		this.Band.Grid.setActiveCell(null);
	else
		this.Band.Grid.alignGrid();
}

function igtbl_hideColumn(rows,col,hide)
{
	var g=col.Band.Grid;
	if(col.Band.Index==rows.Band.Index && rows.Element.previousSibling)
	{
		var tBody=rows.Element.previousSibling;
		var realIndex=-1;
		for(var i=0;i<tBody.childNodes[0].cells.length;i++)
		{
			if(tBody.childNodes[0].cells[i].style.display=="")
				realIndex++;
			if(tBody.childNodes[0].cells[i].id==col.Id)
			{
				tBody.childNodes[0].cells[i].style.display=(hide?"none":"");
				if(tBody.nextSibling.nextSibling)
					tBody.nextSibling.nextSibling.childNodes[0].childNodes[i].style.display=(hide?"none":"");
				var chn=tBody.previousSibling.childNodes;
				if(hide)
				{
					col.Width=chn[realIndex].width;
					for(var j=realIndex;j<chn.length-1 && chn[j+1].style.display=="";j++)
						chn[j].width=chn[j+1].width;
					chn[j].width=1;
					chn[j].style.display="none";
					if(tBody.nextSibling.nextSibling)
						tBody.nextSibling.nextSibling.childNodes[0].childNodes[chn.length-1].width=col.Width;
				}
				else
				{
					for(var j=chn.length-2;j>=i;j--)
					{
						chn[j+1].width=chn[j].width;
						if(chn[j+1].style.display=="none" && chn[j].style.display=="")
							chn[j+1].style.display="";
					}
					if(chn[i].style.display=="none")
						chn[i].style.display="";
					chn[i].width=col.Width;
					if(tBody.nextSibling.nextSibling)
						tBody.nextSibling.nextSibling.childNodes[0].childNodes[i].width=col.Width;
				}
				break;
			}
		}
	}
	for(var i=0;i<rows.length;i++)
	{
		var row=rows.getRow(i);
		if(col.Band.Index==rows.Band.Index && !row.GroupByRow)
		{
			var cell=row.getCellByColumn(col);
			if(hide)
			{
				cell.Element.style.display="none";
				if(col.Band.Grid.getActiveRow()==row)
				{
					if(typeof(cell.oldBorderLeftStyle)!="undefined")
					{
						cell.renderActiveLeft(false);
						for(var j=col.Index+1;j<col.Band.Columns.length;j++)
							if(!col.Band.Columns[j].getHidden())
							{
								row.getCellByColumn(col.Band.Columns[j]).renderActiveLeft();
								break;
							}
					}
					if(typeof(cell.oldBorderRightStyle)!="undefined")
					{
						cell.renderActiveRight(false);
						for(var j=col.Index-1;j>=0;j--)
							if(!col.Band.Columns[j].getHidden())
							{
								row.getCellByColumn(col.Band.Columns[j]).renderActiveRight();
								break;
							}
					}
				}
			}
			else
			{
				cell.Element.style.display="";
				if(col.Band.Grid.getActiveRow()==row)
				{
					var j=0;
					for(j=0;j<col.Band.Columns.length;j++)
						if(!col.Band.Columns[j].getHidden())
							break;
					if(j>col.Index)
					{
						row.getCellByColumn(col.Band.Columns[j]).renderActiveLeft(false);
						cell.renderActiveLeft();
					}
					for(j=col.Band.Columns.length-1;j>=0;j--)
						if(!col.Band.Columns[j].getHidden())
							break;
					if(j<col.Index)
					{
						row.getCellByColumn(col.Band.Columns[j]).renderActiveRight(false);
						cell.renderActiveRight();
					}
				}
			}
		}
		else if(col.Band.Index>=rows.Band.Index && row.Expandable)
		{
			if(row.GroupByRow || col.Band.Index>rows.Band.Index)
				igtbl_hideColumn(row.Rows,col,hide);
		}
	}
}

function igtbl_gGetColNullText()
{
	return igtbl_getNullText(this.Band.Grid.Id,this.Band.Index,this.Index);
}

function igtbl_gColFind(re,back)
{
	var g=this.Band.Grid;
	if(re)
		g.regExp=re;
	if(!g.regExp || this.IsGroupBy)
		return null;
	g.lastSearchedCell=null;
	if(back==true || back==false)
		g.backwardSearch=back;
	var row=null;
	if(!g.backwardSearch)
	{
		row=g.Rows.getRow(0);
		if(row && row.getHidden())
			row=row.getNextRow();
		while(row && (row.Band!=this.Band || row.getCellByColumn(this).getValue(true).search(g.regExp)==-1))
			row=row.getNextTabRow(false,true);
	}
	else
	{
		var rows=g.Rows;
		while(rows)
		{
			row=rows.getRow(rows.length-1);
			if(row && row.getHidden())
				row=row.getPrevRow();
			if(row && row.Expandable)
				rows=row.Rows;
			else
			{
				if(!row)
					row=rows.ParentRow;
				rows=null;
			}
		}
		while(row && (row.Band!=this.Band || row.getCellByColumn(this).getValue(true).search(g.regExp)==-1))
			row=row.getNextTabRow(true,true);
	}
	g.lastSearchedCell=(row?row.getCellByColumn(this):null);
	return g.lastSearchedCell;
}

function igtbl_gColFindNext(re,back)
{
	var g=this.Band.Grid;
	if(!g.lastSearchedCell || g.lastSearchedCell.Column!=this)
		return this.find(re,back);
	if(re)
		g.regExp=re;
	if(!g.regExp)
		return null;
	if(back==true || back==false)
		g.backwardSearch=back;
	var row=g.lastSearchedCell.Row.getNextTabRow(g.backwardSearch,true);
	while(row && (row.Band!=this.Band || row.getCellByColumn(this).getValue(true).search(g.regExp)==-1))
		row=row.getNextTabRow(g.backwardSearch,true);
	g.lastSearchedCell=(row?row.getCellByColumn(this):null);
	return g.lastSearchedCell;
}

function igtbl_gGetFooterText()
{
	var fId=this.Band.Grid.Id+"f_"+this.Band.Index+"_"+this.Index;
	var foot=igtbl_getElementById(fId);
	if(foot)
		return igtbl_getInnerText(foot);
	return "";
}

function igtbl_gSetFooterText(value)
{
	var fId=this.Band.Grid.Id+"f_"+this.Band.Index+"_"+this.Index;
	var foot=igtbl_getDocumentElement(fId);
	if(foot)
	{
		if(igtbl_trim(value)=="")
			value="&nbsp;";
		if(foot.length)
		{
			if(foot[0].childNodes.length>0 && foot[0].childNodes[0].tagName=="NOBR")
				value="<nobr>"+value+"</nobr>";
			for(var i=0;i<foot.length;i++)
				foot[i].innerHTML=value;
		}
		else
		{
			if(foot.childNodes.length>0 && foot.childNodes[0].tagName=="NOBR")
				value="<nobr>"+value+"</nobr>";
			foot.innerHTML=value;
		}
	}
}

function igtbl_initGroupByBox(grid)
{
	this.Element=igtbl_getElementById(grid.Id+"_groupBox");
	this.pimgUp=igtbl_getElementById(grid.Id+"_pimgUp");
	if(this.pimgUp)
		this.pimgUp.style.zIndex=10000;
	this.pimgDn=igtbl_getElementById(grid.Id+"_pimgDn");
	if(this.pimgDn)
		this.pimgDn.style.zIndex=10000;
	this.postString="";
	this.moveString="";
	if(this.Element)
	{
		this.groups=new Array();
		var gt=this.Element.childNodes[0];
		if(gt.tagName=="TABLE")
			for(var i=0;i<gt.rows.length;i++)
				this.groups[i]=new igtbl_initGroupMember(gt.rows[i].cells[i]);
	}
}

function igtbl_initGroupMember(e)
{
	var d=e.childNodes[0];
	if(!d.getAttribute("groupInfo"))
		return null;
	this.Element=d;
	this.groupInfo=d.getAttribute("groupInfo").split(":");
	this.groupInfo[1]=parseInt(this.groupInfo[1],10);
	if(this.groupInfo[0]=="col")
		this.groupInfo[2]=parseInt(this.groupInfo[2],10);
}

function igtbl_initRowsCollection(parentRow,grid,bandNo)
{
	this.Grid=grid;
	this.Band=grid.Bands[parseInt(bandNo,10)];
	this.rows=new Array();
	if(parentRow)
	{
		this.ParentRow=parentRow;
		this.Element=null;
		/*v30 2*/
		{
			this.length=parentRow.ChildRowsCount;
			if(this.length>0)
			{
				if(parentRow.GroupByRow)
					this.Element=parentRow.Element.childNodes[0].childNodes[0].tBodies[0].childNodes[1].childNodes[0].childNodes[0].tBodies[0];
				else
					this.Element=parentRow.Element.nextSibling.childNodes[parentRow.Band.firstActiveCell].childNodes[0].tBodies[0];
			}
		}
	}
	else
	{
		this.ParentRow=null;
		this.Element=grid.Element.tBodies[0];
		/*v30 3*/
		{
			this.length=this.Element.childNodes.length;
			for(var i=0;i<this.Element.childNodes.length;i++)
				if(this.Element.childNodes[i].getAttribute("hiddenRow"))
					this.length--;
		}
	}
	/*v30 4*/
	this.initialLength=this.length;
	this.getRow=igtbl_clctnGetRow;
	this.getRowById=igtbl_clctnGetRowById;
	this.indexOf=igtbl_clctnIndexOf;
	this.insert=igtbl_clctnInsert;
	this.remove=igtbl_clctnRemove;
	if(this.Band.Grid.sort)
		this.sort=igtbl_clctnSort;
	this.getFooterText=igtbl_clctnGetFooterText;
	this.setFooterText=igtbl_clctnSetFooterText;
}

function igtbl_clctnGetRow(rowNo)
{
	/*v30 5*/
	if(rowNo<0 || !this.Element || !this.Element.childNodes)
		return null;
	var addNum=0;
	if(rowNo>=this.length)
	{
		addNum=this.length-this.rows.length;
		for(var i=0;i<addNum;i++)
			this.rows[this.rows.length]=null;
		return null;
	}
	if(rowNo>=this.rows.length)
	{
		addNum=rowNo-this.rows.length+1;
		for(var i=0;i<addNum;i++)
			this.rows[this.rows.length]=null;
	}
	if(!this.rows[rowNo])
	{
		/*v30 6*/
		{
			var row=null;
			var cr=0;
			for(var i=0;i<this.Element.childNodes.length;i++)
				if(!this.Element.childNodes[i].getAttribute("hiddenRow"))
				{
					if(rowNo==cr)
					{
						row=this.Element.childNodes[i];
						break;
					}
					cr++;
				}
			if(!row)
				return null;
			this.rows[rowNo]=new igtbl_initRowInfo(this.Grid.Id,row,this);
		}
	}
	return this.rows[rowNo];
}

function igtbl_clctnGetRowById(rowId)
{
	for(var i=0;i<this.length;i++)
	{
		var row=this.getRow(i);
		if(row.Element.id==rowId)
			return row;
	}
	return null;
}

function igtbl_clctnIndexOf(row)
{
	/*v30 7*/
	for(var i=0;i<this.length;i++)
		if(this.getRow(i).Element.id==row.Element.id)
			return i;
	return -1;
}

function igtbl_clctnInsert(row,rowNo)
{
	/*v30 8*/
	{
		var row1=this.getRow(rowNo);
		if(row1)
		{
			if(this.rows.splice)
				this.rows.splice(rowNo,0,row);
			else
				this.rows=this.rows.slice(0,rowNo).concat(row,this.rows.slice(rowNo));
			this.Element.insertBefore(row.Element,row1.Element);
			if(row.Expandable && row.HiddenElement)
				this.Element.insertBefore(row.HiddenElement,row1.Element);
		}
		else
		{
			this.rows[this.rows.length]=row;
			this.Element.appendChild(row.Element);
			if(row.Expandable && row.HiddenElement)
				this.Element.appendChild(row.HiddenElement);
		}
	}
	this.length++;
}

function igtbl_clctnRemove(rowNo)
{
	var row=this.getRow(rowNo);
	if(!row)
		return;
	/*v30 9*/
	{
		this.Element.removeChild(row.Element);
		if(row.Expandable && row.HiddenElement)
			this.Element.removeChild(row.HiddenElement);
	}
	if(this.rows.splice)
		this.rows.splice(rowNo,1);
	else
		this.rows=this.rows.slice(0,rowNo).concat(this.rows.slice(rowNo+1));
	this.length--;
	return row;
}

function igtbl_clctnGetFooterText(columnKey)
{
	var tFoot;
	if(this.Band.Index==0 && this.Grid.StatFooter)
		tFoot=this.Grid.StatFooter.Element;
	else
		tFoot=this.Element.nextSibling;
	var col=this.Band.getColumnFromKey(columnKey);
	if(tFoot && tFoot.tagName=="TFOOT" && col)
	{
		var fId=this.Grid.Id+"f_"+this.Band.Index+"_"+col.Index;
		for(var i=0;i<tFoot.rows[0].childNodes.length;i++)
			if(tFoot.rows[0].childNodes[i].id==fId)
				return igtbl_getInnerText(tFoot.rows[0].childNodes[i]);
	}
	return "";
}

function igtbl_clctnSetFooterText(columnKey,value)
{
	var tFoot;
	if(this.Band.Index==0 && this.Grid.StatFooter)
		tFoot=this.Grid.StatFooter.Element;
	else
		tFoot=this.Element.nextSibling;
	var col=this.Band.getColumnFromKey(columnKey);
	if(tFoot && tFoot.tagName=="TFOOT" && col)
	{
		var fId=this.Grid.Id+"f_"+this.Band.Index+"_"+col.Index;
		for(var i=0;i<tFoot.rows[0].childNodes.length;i++)
			if(tFoot.rows[0].childNodes[i].id==fId)
			{
				if(igtbl_trim(value)=="")
					value="&nbsp;";
				if(tFoot.rows[0].childNodes[i].childNodes.length>0 && tFoot.rows[0].childNodes[i].childNodes[0].tagName=="NOBR")
					value="<nobr>"+value+"</nobr>";
				tFoot.rows[0].childNodes[i].innerHTML=value;
				break;
			}
	}
}
	
function igtbl_initStatHeader(gn)
{
	var gs=igtbl_getGridById(gn);
	this.gridId=gn;
	this.Element=gs.Element.parentNode.parentNode.parentNode.previousSibling.childNodes[0].childNodes[0].childNodes[0].childNodes[0];
	this.Element.parentNode.parentNode.style.height=this.Element.parentNode.offsetHeight;
	var j=0;
	var comWidth=0;
	for(var i=0;i<this.Element.childNodes[0].childNodes.length;i++)
	{
		var col=this.Element.childNodes[0].childNodes[i];
		if(col.style.display=="" && gs.Element.childNodes[0].childNodes[j].offsetWidth>0)
		{
			var colW=gs.Element.childNodes[0].childNodes[j].offsetWidth;
			col.style.width=colW;
			comWidth+=colW;
		}
		if(col.getAttribute("columnNo"))
		{
			var colNo=parseInt(col.getAttribute("columnNo"));
			gs.Bands[0].Columns[colNo].Element=col;
			if(!gs.Bands[0].Columns[colNo].getHidden())
				j++;
		}
		else
			j++;
	}
	this.Element.parentNode.style.width=comWidth;
	this.ScrollTo=igtbl_scrollStatHeader;
	this.getElementByColumn=igtbl_shGetElemByCol;
}

function igtbl_scrollStatHeader(scrollLeft)
{
	var gs=igtbl_getGridById(this.gridId);
	this.Element.parentNode.style.left=-scrollLeft;
	var el=gs.StatHeader.Element.childNodes[0];
	var j=0;
	var comWidth=0;
	for(var i=0;i<el.childNodes.length;i++)
	{
		var col=el.childNodes[i];
		if(col.style.display=="")
		{
			var colW=gs.Element.childNodes[0].childNodes[j].offsetWidth;
			if(col.offsetWidth!=colW)
				col.style.width=colW;
			comWidth+=colW;
			j++;
		}
	}
	this.Element.parentNode.style.width=comWidth;
}

function igtbl_shGetElemByCol(col)
{
	if(col.IsGroupBy)
		return null;
	var j=0;
	for(var i=0;i<col.Index;i++)
	{
		if(!col.Band.Columns[i].IsGroupBy)
			j++;
	}
	return this.Element.childNodes[0].childNodes[j+col.Band.firstActiveCell];
}

function igtbl_initStatFooter(gn)
{
	var gs=igtbl_getGridById(gn);
	this.gridId=gn;
	this.Element=gs.Element.parentNode.parentNode.parentNode.nextSibling.childNodes[0].childNodes[0].childNodes[0].childNodes[0];
	this.Element.parentNode.parentNode.style.height=this.Element.parentNode.offsetHeight;
	var j=0;
	var comWidth=0;
	for(var i=0;i<this.Element.childNodes[0].childNodes.length;i++)
	{
		var col=this.Element.childNodes[0].childNodes[i];
		var colW=0;
		if(col.style.display=="")
		{
			colW=gs.Element.childNodes[0].childNodes[j++].offsetWidth;
			col.style.width=colW;
			comWidth+=colW;
		}
	}
	this.Element.parentNode.style.width=comWidth;
	this.ScrollTo=igtbl_scrollStatFooter;
	this.Resize=igtbl_resizeStatFooter;
	this.getElementByColumn=igtbl_sfGetElemByCol;
}

function igtbl_scrollStatFooter(scrollLeft)
{
	var gs=igtbl_getGridById(this.gridId);
	this.Element.parentNode.style.left=-scrollLeft;
	var el=gs.StatFooter.Element.childNodes[0];
	var j=0;
	var comWidth=0;
	for(var i=0;i<el.childNodes.length;i++)
	{
		var col=el.childNodes[i];
		if(col.style.display=="")
		{
			var colW=gs.Element.childNodes[0].childNodes[j].offsetWidth;
			if(col.offsetWidth!=colW)
				col.style.width=colW;
			comWidth+=colW;
			j++;
		}
	}
	this.Element.parentNode.style.width=comWidth;
}

function igtbl_resizeStatFooter(index,width)
{
	var gs=igtbl_getGridById(this.gridId);
	var el=igtbl_getElemVis(gs.StatFooter.Element.childNodes[0].childNodes,index);
	this.Element.parentNode.style.width=this.Element.parentNode.offsetWidth+(width-el.offsetWidth);
	el.style.width=width;
}

function igtbl_sfGetElemByCol(col)
{
	if(col.IsGroupBy)
		return null;
	var j=0;
	for(var i=0;i<col.Index;i++)
	{
		if(!col.Band.Columns[i].IsGroupBy)
			j++;
	}
	return this.Element.childNodes[0].childNodes[j+col.Band.firstActiveCell];
}

function igtbl_initRowInfo(gn,row,rowsClctn,index)
{
	var gs=igtbl_getGridById(gn);
	this.gridId=gn;
	this.Element=row;
	this.OwnerCollection=rowsClctn;
	this.Band=this.OwnerCollection.Band;
	this.getIndex=igtbl_gRowGetIndex;
	this.toggleRow=igtbl_gToggleRow;
	this.getExpanded=igtbl_gRowGetExpanded;
	this.setExpanded=igtbl_gRowSetExpanded;
	/*v30 10*/
	{
		this.GroupByRow=false;
		this.GroupColId=null;
		if(row.getAttribute("groupRow"))
		{
			this.GroupByRow=true;
			this.GroupColId=row.getAttribute("groupRow");
			var sTd=row.childNodes[0].childNodes[0].tBodies[0].childNodes[0].childNodes[0];
			this.MaskedValue=sTd.getAttribute("cellValue");
			this.Value=this.MaskedValue;
			if(sTd.getAttribute("unmaskedValue"))
				this.Value=sTd.getAttribute("unmaskedValue");
			this.Value=igtbl_valueFromString(this.Value,igtbl_getColumnById(this.GroupColId).DataType);
		}
		else
			this.GroupByRow=false;
		var fr=igtbl_getFirstRow(row);
		this.Expandable=((fr.nextSibling && fr.nextSibling.getAttribute("hiddenRow") || this.Element.getAttribute("showExpand")));
		this.ChildRowsCount=0;
		this.VisChildRowsCount=0;
		if(this.Expandable)
		{
			if(!this.GroupByRow && !this.Element.getAttribute("showExpand"))
				this.HiddenElement=this.Element.nextSibling;
			if(fr.nextSibling && fr.nextSibling.getAttribute("hiddenRow"))
			{
				this.ChildRowsCount=igtbl_rowsCount(igtbl_getChildRows(gn,row));
				this.VisChildRowsCount=igtbl_visRowsCount(igtbl_getChildRows(gn,row));
				this.Rows=new igtbl_initRowsCollection(this,gs,this.Band.Index+(this.GroupByRow?0:1));
				this.FirstChildRow=this.Rows.getRow(0);
			}
		}
		this.FirstRow=fr;
		if(this.OwnerCollection)
			this.ParentRow=this.OwnerCollection.ParentRow;

		if(!this.GroupByRow)
			this.cells=new Array(this.Element.cells.length-this.Band.firstActiveCell);
	}
		
	this.getCell=igtbl_getCell;
	this.getCellByColumn=igtbl_getCellByColumn;
	this.getCellFromKey=igtbl_getCellFrom;
	this.getChildRow=igtbl_getChildRow;
	this.compare=igtbl_rowCompare;
	this.remove=igtbl_rowRemove;
	this.getNextTabRow=igtbl_gGetNextTabRow;
	this.getSelected=igtbl_gGetRowSelected;
	this.setSelected=igtbl_gSetRowSelected;
	this.getNextRow=igtbl_gGetNextRow;
	this.getPrevRow=igtbl_gGetPrevRow;
	this.activate=igtbl_gRowActivate;
	this.isActive=function()
	{
		return this.Band.Grid.getActiveRow()==this;
	}
	this.scrollToView=igtbl_gRowScrollToView;
	this.deleteRow=igtbl_gRowDelete;
	this.getLeft=igtbl_getRowLeft;
	this.getTop=igtbl_getRowTop;
	this.editRow=igtbl_gRowEdit;
	this.endEditRow=igtbl_gRowEndEdit;
	this.getHidden=igtbl_gRowGetHidden;
	this.setHidden=igtbl_gRowSetHidden;
	this.find=igtbl_gRowFind;
	this.findNext=igtbl_gRowFindNext;
	
	this.setSelectedRowImg=function(hide)
	{
		igtbl_setSelectedRowImg(this.gridId,this.Element,hide);
	}
	this.renderActive=function(render)
	{
		var g=this.Band.Grid;
		if(!g.Activation.AllowActivation)
			return;
		if(this.GroupByRow)
		{
			if(ig_csom.IsNetscape ||  ig_csom.IsNetscape6)
			{
				igtbl_changeBorder(g,this.FirstRow.firstChild.style,this,"Left",render);
				igtbl_changeBorder(g,this.FirstRow.firstChild.style,this,"Top",render);
				igtbl_changeBorder(g,this.FirstRow.firstChild.style,this,"Right",render);
				igtbl_changeBorder(g,this.FirstRow.firstChild.style,this,"Bottom",render);
			}
			else
				igtbl_changeBorder(g,this.FirstRow.firstChild.runtimeStyle,this,"",render);
		}
		else
		{
			if(this.cells.length==0)
				return;
 			if(render==false)
			{
				var i=0;
				var cell=this.getCell(i);
				while(cell.Column.getHidden() && i<this.cells.length)
					cell=this.getCell(i++);
				if(i<this.cells.length)
					cell.renderActiveLeft(false);
				for(i=0;i<this.cells.length;i++)
				{
					cell=this.getCell(i);
					cell.renderActiveTop(false);
					cell.renderActiveBottom(false);
				}
				i=this.cells.length-1;
				cell=this.getCell(i);
				while(cell.Column.getHidden() && i>=0)
					cell=this.getCell(i--);
				if(i>=0)
					cell.renderActiveRight(false);
			}
			else
			{
				var i=0;
				var cell=this.getCell(i);
				while(cell.Column.getHidden() && i<this.cells.length)
					cell=this.getCell(i++);
				if(i<this.cells.length)
					cell.renderActiveLeft();
				for(var i=0;i<this.cells.length;i++)
				{
					cell=this.getCell(i);
					cell.renderActiveTop();
					cell.renderActiveBottom();
				}
				i=this.cells.length-1;
				cell=this.getCell(i);
				while(cell.Column.getHidden() && i>=0)
					cell=this.getCell(i--);
				if(i>=0)
					cell.renderActiveRight();
			}
		}
	}
	
	this.Expanded=this.getExpanded();
}

function igtbl_gRowGetIndex()
{
	if(this.OwnerCollection)
		return this.OwnerCollection.indexOf(this);
	return -1;
}

function igtbl_rowCompare(row)
{
	if(this.OwnerCollection!=row.OwnerCollection)
		return 0;
	if(this.GroupByRow)
		return igtbl_getColumnById(this.GroupColId).compareRows(this,row);
	else
	{
		var sc=this.OwnerCollection.Band.SortedColumns;
		for(var i=0;i<sc.length;i++)
		{
			var col=igtbl_getColumnById(sc[i]);
			if(!col.IsGroupBy)
			{
				var cell1=this.getCellByColumn(col);
				var cell2=row.getCellByColumn(col);
				var res=col.compareCells(cell1,cell2);
				if(res!=0)
				{
					return res;
				}
			}
		}
	}
	return 0;
}

function igtbl_rowGetValue(colId)
{
	
}

function igtbl_rowRemove()
{
	return this.OwnerCollection.remove(this.OwnerCollection.indexOf(this));
}

function igtbl_getCell(index)
{
	if(index<0 || !this.cells || index>this.cells.length)
		return null;
	if(!this.cells[index] && (/*v30 11*/this.Element.cells[this.Band.firstActiveCell+parseInt(index)]))
		this.cells[index]=new igtbl_initCellInfo(this,index);
	return this.cells[index];
}

function igtbl_getCellByColumn(col)
{
	if(!this.cells)
		return null;
	for(var i=0;i<this.cells.length;i++)
	{
		var cell=this.getCell(i);
		if(cell.Column==col)
			return cell;
	}
	return null;
}

function igtbl_getCellFrom(key)
{
	var cell=null;
	var col=this.Band.getColumnFromKey(key);
	if(col)
		cell=this.getCellByColumn(col);
	return cell;
}

function igtbl_gGetNextTabRow(shift,ignoreCollapse)
{
	var row=null;
	if(shift)
	{
		row=this.getPrevRow();
		if(row)
		{
			while(row.getExpanded() || ignoreCollapse && row.Expandable)
				row=row.Rows.getRow(row.Rows.length-1);
		}
		else if(this.ParentRow)
			row=this.ParentRow;
	}
	else
	{
		if(this.getExpanded() || ignoreCollapse && this.Expandable)
			row=this.Rows.getRow(0);
		else
		{
			row=this.getNextRow();
			if(!row && this.ParentRow)
			{
				var pr=this.ParentRow;
				while(!row && pr)
				{
					row=pr.getNextRow();
					pr=pr.ParentRow;
				}
			}
		}
	}
	return row;
}

function igtbl_gRowGetExpanded(expand)
{
	/*v30 12*/
	return (this.Expandable && igtbl_getGridById(this.gridId).ExpandedRows[this.FirstRow.id]);
}

function igtbl_gRowSetExpanded(expand)
{
	if(this.Band.getExpandable()!=1 || !this.Expandable)
		return;
	if(expand!=false)
		expand=true;
	/*v30 13*/
	{
		var gn=this.gridId;
		var srcRow=this.FirstRow.id;
		var sr = igtbl_getElementById(srcRow);
		var hr = sr.nextSibling;
		var gs=igtbl_getGridById(gn);
		var cancel=false;
		if(expand!=false) 
		{
			if(igtbl_fireEvent(gn,gs.Events.BeforeRowExpanded,"(\""+gn+"\",\""+srcRow+"\");")==true)
				cancel=true;
			if(!cancel)
			{
				if(!gs.NeedPostBack || (gs.LoadOnDemand==1 || gs.LoadOnDemand==2) && this.Rows && this.Rows.length>0)
				{
					gs.NeedPostBack=false;
					if(hr && hr.getAttribute("hiddenRow"))
						hr.style.display = "";
					sr.childNodes[0].childNodes[0].src=this.Band.getCollapseImage();
				}
				igtbl_stateExpandRow(gn,srcRow,true);
				if(!gs.NeedPostBack)
					igtbl_fireEvent(gn,gs.Events.AfterRowExpanded,"(\""+gn+"\",\""+srcRow+"\");");
			}
		}
		else
		{
			if(igtbl_fireEvent(gn,gs.Events.BeforeRowCollapsed,"(\""+gn+"\",\""+srcRow+"\")")==true)
				cancel=true;
			if(!cancel)
			{
				if(!gs.NeedPostBack)
				{
					if(hr && hr.getAttribute("hiddenRow"))
						hr.style.display = "none";
					sr.childNodes[0].childNodes[0].src=this.Band.getExpandImage();
				}
				igtbl_stateExpandRow(gn,srcRow,false);
				if(!gs.NeedPostBack)
					igtbl_fireEvent(gn,gs.Events.AfterRowCollapsed,"(\""+gn+"\",\""+srcRow+"\");");
			}
		}
		if(!cancel)
		{
			if(gs.NeedPostBack)
			{
				if(expand!=false) 
					igtbl_moveBackPostField(gn,"ExpandedRows");
				else
					igtbl_moveBackPostField(gn,"CollapsedRows");
			}
		}
		if(gs.NeedPostBack)
			igtbl_doPostBack(gn);
	}
}

function igtbl_gToggleRow()
{
	this.setExpanded(!this.getExpanded());
}

function igtbl_gGetRowSelected()
{
	if(igtbl_getGridById(this.gridId).SelectedRows[this.FirstRow.id])
		return true;
	return false;
}

function igtbl_gSetRowSelected(select)
{
	var str=this.Band.getSelectTypeRow();
	if(str>1)
	{
		if(str==2)
			this.Band.Grid.clearSelectionAll();
		igtbl_selectRow(this.gridId,this,select);
	}
}

function igtbl_gGetNextRow()
{
	var nr=this.getIndex()+1;
	while(nr<this.OwnerCollection.length && this.OwnerCollection.getRow(nr).getHidden())
		nr++;
	if(nr<this.OwnerCollection.length)
		return this.OwnerCollection.getRow(nr);
	return null;
}

function igtbl_gGetPrevRow()
{
	var pr=this.getIndex()-1;
	while(pr>=0 && this.OwnerCollection.getRow(pr).getHidden())
		pr--;
	if(pr>=0)
		return this.OwnerCollection.getRow(pr);
	return null;
}

function igtbl_gRowActivate()
{
	this.Band.Grid.setActiveRow(this);
}

function igtbl_gRowScrollToView()
{
	igtbl_scrollToView(this.gridId,this.Element);
}

function igtbl_gRowDelete(dontAlign)
{
	var gs=igtbl_getGridById(this.gridId);
	var del=false;
	var rowId=this.Element.id;
	if(this.Band.AllowDelete==1 || this.Band.AllowDelete==0 && gs.AllowDelete==1)
	{
		if(igtbl_inEditMode(this.gridId))
		{
			igtbl_hideEdit(this.gridId);
			if(igtbl_inEditMode(this.gridId))
				return false;
		}
		if(igtbl_fireEvent(this.gridId,gs.Events.BeforeRowDeleted,"(\""+this.gridId+"\",\""+rowId+"\")")==true)
			return false;
		gs.Element.parentNode.scrollLeft=0;
		del=true;
		if(gs.SelectedRows[rowId])
			delete gs.SelectedRows[rowId];
		if(gs.SelectedCellsRows[rowId])
		{
			for(var cell in gs.SelectedCellsRows[rowId])
			{
				delete gs.SelectedCells[cell];
				delete gs.SelectedCellsRows[rowId][cell];
			}
			delete gs.SelectedCellsRows[rowId];
		}
		if(gs.ChangedRows[rowId])
		{
			for(var cell in gs.ChangedRows[rowId])
			{
				delete gs.ChangedCells[cell];
				delete gs.ChangedRows[rowId][cell];
			}
			delete gs.ChangedRows[rowId];
		}
		if(gs.ResizedRows[rowId])
			delete gs.ResizedRows[rowId];
		var prevAdded=typeof(gs.AddedRows[rowId])!="undefined";
		if(this.getExpanded())
			this.toggleRow();
		if(!this.OwnerCollection.deletedRows)
			this.OwnerCollection.deletedRows=new Array();
		gs.DeletedRows[rowId]=true;
		this.Element.setAttribute("deleted",true);
		var ar=this.Band.Grid.getActiveRow();
		var needPB=false;
		for(var i=0;i<this.Band.Columns.length;i++)
		{
			var cell=this.getCellByColumn(this.Band.Columns[i]);
			if(!cell && !this.Band.Columns[i].ServerOnly && !this.Band.Columns[i].IsGroupBy)
			{
				var row=this;
				while(row.getPrevRow() && !cell)
				{
					row=row.getPrevRow();
					cell=row.getCellByColumn(this.Band.Columns[i]);
				}
				if(row==this || !cell || cell.Element.rowSpan==1)
				{
					needPB=true;
					break;
				}
			}
			else if(cell && cell.Element.rowSpan>1)
			{
				needPB=true;
				break;
			}
			if(cell && cell.Element.rowSpan>1)
				cell.Element.rowSpan--;
		}
		if(!needPB)
		{
			if(this.getIndex()==this.OwnerCollection.length-1 && prevAdded)
				this.OwnerCollection.initialLength--;
			this.OwnerCollection.deletedRows[this.OwnerCollection.deletedRows.length]=this.remove();
			var pr=this.ParentRow;
			if(pr)
			{
				pr.VisChildRowsCount--;
				pr.ChildRowsCount--;
			}
			while(pr)
			{
				if(pr.Expandable && pr.Rows.length==0)
				{
					pr.setExpanded(false);
					if(pr.GroupByRow)
					{
						gs.DeletedRows[pr.Element.id]=true;
						pr.Element.setAttribute("deleted",true);
						this.OwnerCollection.deletedRows[this.OwnerCollection.deletedRows.length]=pr.remove();
						delete gs.SelectedRows[pr.Element.id];
					}
					else
						pr.Element.childNodes[0].childNodes[0].style.display="none";
				}
				pr=pr.ParentRow;
			}
			if(!dontAlign)
			{
				if(ar==this)
					this.Band.Grid.setActiveRow(null);
				else
					this.Band.Grid.alignGrid();
			}
		}
		else
			igtbl_needPostBack(this.gridId);
		igtbl_fireEvent(this.gridId,gs.Events.AfterRowDeleted,"(\""+this.gridId+"\",\""+rowId+"\");");
	}
	return del;
}

function igtbl_getRowLeft(offsetElement)
{
	return igtbl_getLeftPos(igtbl_getElemVis(this.Element.cells,igtbl_getBandFAC(this.gridId,this.Element)),true,offsetElement);
}

function igtbl_getRowTop(offsetElement)
{
	var t=igtbl_getTopPos(this.Element,true,offsetElement);
	return t;
}

var igtbl_oldMouseDown=null;
var igtbl_currentEditTempl="";
var igtbl_justAssigned=false;
var igtbl_focusedElement=null;

function igtbl_gRowEdit()
{
	var au=igtbl_getAllowUpdate(this.gridId,this.Band.Index);
	if(igtbl_currentEditTempl!="" || au!=1 && au!=3)
		return;
	var editTempl=igtbl_getElementById(this.Band.RowTemplate);
	if(!editTempl)
		return;
	if(igtbl_fireEvent(this.gridId,igtbl_getGridById(this.gridId).Events.BeforeRowTemplateOpen,"(\""+this.gridId+"\",\""+this.Element.id+"\",\""+this.Band.RowTemplate+"\")"))
		return;
	if(editTempl.style.filter!=null && this.Band.ExpandEffects)
	{
		var ee=this.Band.ExpandEffects;
		if(ee.Type!='NotSet')
		{
			editTempl.style.filter="progid:DXImageTransform.Microsoft."+ee.Type+"(duration="+ee.Duration/1000+");"
			if(ee.ShadowWidth>0)
				editTempl.style.filter+=" progid:DXImageTransform.Microsoft.Shadow(Direction=135, Strength="+ee.ShadowWidth+",color="+ee.ShadowColor+");"
			if(ee.Opacity<100)
				editTempl.style.filter+=" progid:DXImageTransform.Microsoft.Alpha(Opacity="+ee.Opacity+");"
			if(editTempl.filters[0]!=null)
				editTempl.filters[0].apply();
			if(editTempl.filters[0]!=null)
				editTempl.filters[0].play();
		}
		else
		{
			if(ee.ShadowWidth>0)
				editTempl.runtimeStyle.filter="progid:DXImageTransform.Microsoft.Shadow(Direction=135, Strength="+ee.ShadowWidth+",ee.Color="+ee.ShadowColor+");"
			if(ee.Opacity<100)
				editTempl.runtimeStyle.filter+=" progid:DXImageTransform.Microsoft.Alpha(Opacity="+ee.Opacity+");"
		}
	}
	var offsetElement=editTempl.offsetParent;
	while(offsetElement)
	{
		if(offsetElement.tagName=="TABLE")
			break;
		offsetElement=offsetElement.offsetParent;
	}
	editTempl.style.display="";
	editTempl.setAttribute("noHide",true);
	editTempl.style.left=this.getLeft(offsetElement)+this.Band.Grid.Element.parentNode.scrollLeft-1;
	var tw=igtbl_clientWidth(editTempl);
	var bw=document.body.clientWidth;
	if(editTempl.offsetLeft+tw>bw)
		if(bw-tw+document.body.scrollLeft>0)
			editTempl.style.left=bw-tw+document.body.scrollLeft;
		else
			editTempl.style.left=0;
	editTempl.style.top=this.getTop(offsetElement)+this.Element.offsetHeight-1;
	var th=igtbl_clientHeight(editTempl);
	var bh=document.body.clientHeight;
	if(editTempl.offsetTop+th>bh)
		if(bh-th+document.body.scrollTop>0)
			editTempl.style.top=bh-th+document.body.scrollTop;
		else
			editTempl.style.top=0;
	editTempl.setAttribute("editRow",this.Element.id);
	igtbl_fillEditTemplate(this,editTempl.childNodes);
	if(igtbl_focusedElement && igtbl_isVisible(igtbl_focusedElement))
	{
		igtbl_focusedElement.focus();
		if(igtbl_focusedElement.select)
			igtbl_focusedElement.select();
		igtbl_focusedElement=null;
	}
	igtbl_currentEditTempl=this.Band.RowTemplate;
	igtbl_oldMouseDown=document.onmousedown;
	document.onmousedown=igtbl_gRowEditMouseDown;
	igtbl_justAssigned=true;
	window.setTimeout(igtbl_resetJustAssigned,100);
	editTempl.removeAttribute("noHide");
	igtbl_fireEvent(this.gridId,igtbl_getGridById(this.gridId).Events.AfterRowTemplateOpen,"(\""+this.gridId+"\",\""+this.Element.id+"\")");
}

function igtbl_resetJustAssigned()
{
	igtbl_justAssigned=false;
}

function igtbl_fillEditTemplate(row,childNodes)
{
	for(var i=childNodes.length-1;i>=0;i--)
	{
		var el=childNodes[i];
		if(!el.getAttribute)
			continue;
		var colKey=el.getAttribute("columnKey");
		var column=row.Band.getColumnFromKey(colKey);
		if(column)
		{
			var cell=row.getCellByColumn(column);
			if(!cell)
			{
				if(!el.isDisabled)
				{
					el.setAttribute("disabledBefore",true);
					el.disabled=true;
				}
				el.value="";
				continue;
			}
			else if(el.isDisabled && el.getAttribute("disabledBefore"))
			{
				el.disabled=false;
				el.removeAttribute("disabledBefore");
			}
			var cellValue=cell.getValue();
			var cellText="";
			var nullText="";
			if(cellValue==null)
			{
				nullText=cell.Column.getNullText();
				cellText=nullText;
			}
			else
				cellText=cellValue.toString();
			var s="(\""+row.gridId+"\",\""+el.id+"\",\""+cell.Element.id+"\",\""+cellText+"\")";
			s=s.replace(/\r\n/g,"\\r\\n");
			if(!igtbl_fireEvent(row.gridId,igtbl_getGridById(row.gridId).Events.TemplateUpdateControls,s))
			{
				if(el.tagName=="SELECT")
				{
					for(var j=0;j<el.childNodes.length;j++)
						if(el.childNodes[j].tagName=="OPTION")
							if(el.childNodes[j].value==cellText)
							{
								el.childNodes[j].selected=true;
								break;
							}
				}
				else if(el.tagName=="INPUT" && el.type=="checkbox")
				{
					if(!cellValue || cellText.toLowerCase()=="false")
						el.checked=false;
					else
						el.checked=true;
				}
				else if(el.tagName=="DIV" || el.tagName=="SPAN")
				{
					for(var j=0;j<el.childNodes.length;j++)
					{
						if(el.childNodes[j].tagName=="INPUT" && el.childNodes[j].type=="radio")
							if(el.childNodes[j].value==cellText)
							{
								el.childNodes[j].checked=true;
								break;
							}
					}
				}
				else
					el.value=cellText;
				if(!el.isDisabled)
					igtbl_focusedElement=el;
			}
		}
		else if(el.childNodes && el.childNodes.length>0)
			igtbl_fillEditTemplate(row,el.childNodes);
	}
}

function igtbl_gRowEndEdit(saveChanges)
{
	if(arguments.length==0)
		saveChanges=false;
	var gs=igtbl_getGridById(this.gridId);
	var editTempl=igtbl_getElementById(this.Band.RowTemplate);
	if(!editTempl || editTempl.style.display!="")
		return;
	if(editTempl.getAttribute("noHide"))
		return;
	if(igtbl_fireEvent(this.gridId,gs.Events.BeforeRowTemplateClose,"(\""+this.gridId+"\",\""+this.Element.id+"\","+saveChanges.toString()+")"))
		return;
	editTempl.style.display="none";
	igtbl_currentEditTempl="";
	document.onmousedown=igtbl_oldMouseDown;
	if(saveChanges)
		igtbl_unloadEditTemplate(this,editTempl.childNodes);
	igtbl_fireEvent(this.gridId,gs.Events.AfterRowTemplateClose,"(\""+this.gridId+"\",\""+this.Element.id+"\","+saveChanges.toString()+")");
	if(gs.NeedPostBack)
		igtbl_doPostBack(gs.Id);
}

function igtbl_unloadEditTemplate(row,childNodes)
{
	for(var i=0;i<childNodes.length;i++)
	{
		var el=childNodes[i];
		if(!el.getAttribute)
			continue;
		var colKey=el.getAttribute("columnKey");
		var column=row.Band.getColumnFromKey(colKey);
		if(column)
		{
			var cell=row.getCellByColumn(column);
			if(cell && !igtbl_fireEvent(row.gridId,igtbl_getGridById(row.gridId).Events.TemplateUpdateCells,"(\""+row.gridId+"\",\""+el.id+"\",\""+cell.Element.id+"\")"))
			{
				if(cell.isEditable() || cell.Column.getAllowUpdate()==3)
				{
					if(el.tagName=="SELECT")
						cell.setValue(el.options[el.selectedIndex].value);
					else if(el.tagName=="INPUT" && el.type=="checkbox")
						cell.setValue(el.checked);
					else if(el.tagName=="DIV" || el.tagName=="SPAN")
					{
						for(var j=0;j<el.childNodes.length;j++)
						{
							if(el.childNodes[j].tagName=="INPUT" && el.childNodes[j].type=="radio")
								if(el.childNodes[j].checked)
								{
									cell.setValue(el.childNodes[j].value);
									break;
								}
						}
					}
					else if(typeof(el.value)!="undefined")
						cell.setValue(el.value);
				}
			}
		}
		else if(el.childNodes && el.childNodes.length>0)
			igtbl_unloadEditTemplate(row,el.childNodes);
	}
}

function igtbl_gRowEditMouseDown(evnt)
{
	if(igtbl_justAssigned)
	{
		igtbl_justAssigned=false;
		return;
	}
	if(!evnt)
		evnt=event;
	var src=igtbl_srcElement(evnt);
	var editTempl=igtbl_getElementById(igtbl_currentEditTempl);
	if(editTempl && !igtbl_contains(editTempl,src))
	{
		var rId=editTempl.getAttribute("editRow");
		var row=igtbl_getRowById(rId);
		row.endEditRow();
	}
}

function igtbl_contains(e1,e2)
{
	if(e1.contains)
		return e1.contains(e2);
	var contains=false;
	var p=e2;
	while(p && p!=e1)
		p=p.parentNode;
	return p==e1;
}

function igtbl_gRowEditButtonClick(evnt)
{
	if(!evnt)
		evnt=event;
	var src=igtbl_srcElement(evnt);
	var editTempl=igtbl_getElementById(igtbl_currentEditTempl);
	if(editTempl)
	{
		var rId=editTempl.getAttribute("editRow");
		var row=igtbl_getRowById(rId);
		if(src.id=="igtbl_reOkBtn")
			row.endEditRow(true);
		else if(src.id=="igtbl_reCancelBtn")
			row.endEditRow();
	}
}

function igtbl_gRowGetHidden()
{
	return (this.Element.style.display=="none");
}

function igtbl_gRowSetHidden(h)
{
	this.Element.style.display=(h?"none":"");
	if(this.ParentRow)
		this.ParentRow.VisChildRowsCount+=(h?-1:1);
	var ac=this.Band.Grid.getActiveCell();
	if(ac && ac.Row==this && h)
		this.Band.Grid.setActiveCell(null);
	else
	{
		var ar=this.Band.Grid.getActiveRow();
		if(ar && ar==this && h)
			this.Band.Grid.setActiveRow(null);
		else
			this.Band.Grid.alignGrid();
	}
}

function igtbl_gRowFind(re,back)
{
	var g=this.Band.Grid;
	if(re)
		g.regExp=re;
	if(!g.regExp)
		return null;
	g.lastSearchedCell=null;
	if(back==true || back==false)
		g.backwardSearch=back;
	var cell=null;
	if(!g.backwardSearch)
	{
		cell=this.getCell(0);
		if(cell && cell.Column.getHidden())
			cell=cell.getNextCell();
		while(cell && cell.getValue(true).search(g.regExp)==-1)
			cell=cell.getNextCell();
	}
	else
	{
		cell=this.getCell(this.cells.length-1);
		if(cell && cell.Column.getHidden())
			cell=cell.getPrevCell();
		while(cell && cell.getValue(true).search(g.regExp)==-1)
			cell=cell.getPrevCell();
	}
	if(cell)
		g.lastSearchedCell=cell;
	return g.lastSearchedCell;
}

function igtbl_gRowFindNext(re,back)
{
	var g=this.Band.Grid;
	if(!g.lastSearchedCell || g.lastSearchedCell.Row!=this)
		return this.find(re,back);
	if(re)
		g.regExp=re;
	if(!g.regExp)
		return null;
	if(back==true || back==false)
		g.backwardSearch=back;
	var cell=null;
	if(!g.backwardSearch)
	{
		cell=g.lastSearchedCell.getNextCell();
		while(cell && cell.getValue(true).search(g.regExp)==-1)
			cell=cell.getNextCell();
	}
	else
	{
		cell=g.lastSearchedCell.getPrevCell();
		while(cell && cell.getValue(true).search(g.regExp)==-1)
			cell=cell.getPrevCell();
	}
	if(cell)
		g.lastSearchedCell=cell;
	else
		g.lastSearchedCell=null;
	return g.lastSearchedCell;
}

function igtbl_initCellInfo(row,index)
{
	var gs=igtbl_getGridById(row.gridId);
	/*v30 14*/
	{
		var cell=row.Element.cells[row.Band.firstActiveCell+parseInt(index)];
		if(!cell)
			return null;
		this.Element=cell;
		this.Column=igtbl_getColumnById(cell.id);
		this.NextSibling=cell.nextSibling;
		if(cell.cellIndex==igtbl_getBandFAC(row.gridId,cell))
			this.PrevSibling=null;
		else
			this.PrevSibling=cell.previousSibling;
		this.MaskedValue=igtbl_getInnerText(cell);
	}
	this.Row=row;
	this.Band=row.Band;
	this.getValue=igtbl_getCellValue;
	this.setValue=igtbl_setCellValue;
	this.getRow=igtbl_getCellRow;
	this.Index=index;
	this.getNextTabCell=igtbl_gGetNextTabCell;
	this.beginEdit=igtbl_gEditCell;
	this.endEdit=igtbl_gEndEditCell;
	this.getSelected=igtbl_gGetCellSelected;
	this.setSelected=igtbl_gSetCellSelected;
	this.getNextCell=igtbl_gGetNextCell;
	this.getPrevCell=igtbl_gGetPrevCell;
	this.activate=igtbl_gCellActivate;
	this.scrollToView=igtbl_gCellScrollToView;
	this.isEditable=igtbl_gCellIsEditable;
	
	this.renderActive=function(render)
	{
		var g=this.Row.Band.Grid;
		if(!g.Activation.AllowActivation)
			return;
		if(ig_csom.IsNetscape6 || ig_csom.IsNetscape)
		{
			this.renderActiveLeft(render);
			this.renderActiveTop(render);
			this.renderActiveRight(render);
			this.renderActiveBottom(render);
		}
		else
			igtbl_changeBorder(g,this.Element.runtimeStyle,this,"",render);
	}
	this.renderActiveLeft=function(render)
	{
		var g=this.Row.Band.Grid;
		if(!g.Activation.AllowActivation)
			return;
		var styleTS=this.Element.style;
		if(!(ig_csom.IsNetscape6 || ig_csom.IsNetscape))
			styleTS=this.Element.runtimeStyle;
		igtbl_changeBorder(g,styleTS,this,"Left",render);
		if(render==false && !(ig_csom.IsNetscape6 || ig_csom.IsNetscape) && styleTS.cssText.length>0)
			styleTS.cssText=styleTS.cssText.replace(/BORDER-LEFT/g,"");

	}
	this.renderActiveTop=function(render)
	{
		var g=this.Row.Band.Grid;
		if(!g.Activation.AllowActivation)
			return;
		var styleTS=this.Element.style;
		if(!(ig_csom.IsNetscape6 || ig_csom.IsNetscape))
			styleTS=this.Element.runtimeStyle;
		igtbl_changeBorder(g,styleTS,this,"Top",render);
		if(render==false && !(ig_csom.IsNetscape6 || ig_csom.IsNetscape) && styleTS.cssText.length>0)
			styleTS.cssText=styleTS.cssText.replace(/BORDER-TOP/g,"");
	}
	this.renderActiveRight=function(render)
	{
		var g=this.Row.Band.Grid;
		if(!g.Activation.AllowActivation)
			return;
		var styleTS=this.Element.style;
		if(!(ig_csom.IsNetscape6 || ig_csom.IsNetscape))
			styleTS=this.Element.runtimeStyle;
		igtbl_changeBorder(g,styleTS,this,"Right",render);
		if(render==false && !(ig_csom.IsNetscape6 || ig_csom.IsNetscape) && styleTS.cssText.length>0)
			styleTS.cssText=styleTS.cssText.replace(/BORDER-RIGHT/g,"");
	}
	this.renderActiveBottom=function(render)
	{
		var g=this.Row.Band.Grid;
		if(!g.Activation.AllowActivation)
			return;
		var styleTS=this.Element.style;
		if(!(ig_csom.IsNetscape6 || ig_csom.IsNetscape))
			styleTS=this.Element.runtimeStyle;
		igtbl_changeBorder(g,styleTS,this,"Bottom",render);
		if(render==false && !(ig_csom.IsNetscape6 || ig_csom.IsNetscape) && styleTS.cssText.length>0)
			styleTS.cssText=styleTS.cssText.replace(/BORDER-BOTTOM/g,"");
	}
}

function igtbl_changeBorder(g,elem,obj,attr,render)
{
	var attrStyle;
	if(attr)
		attrStyle="border"+attr+"Style";
	else
		attrStyle="borderStyle";
	var attrColor;
	if(attr)
		attrColor="border"+attr+"Color";
	else
		attrColor="borderColor";
	var attrWidth;
	if(attr)
		attrWidth="border"+attr+"Width";
	else
		attrWidth="borderWidth";
	if(render==false)
	{
		if(typeof(obj["old"+attrStyle])!="undefined")
		{
			elem[attrStyle]=obj["old"+attrStyle];
			delete obj["old"+attrStyle];
			elem[attrColor]=obj["old"+attrColor];
			delete obj["old"+attrColor];
			elem[attrWidth]=obj["old"+attrWidth];
			delete obj["old"+attrWidth];
		}
	}
	else
	{
		if(typeof(obj["old"+attrStyle])=="undefined")
			obj["old"+attrStyle]=elem[attrStyle];
		elem[attrStyle]=g.Activation.BorderStyle;
		if(typeof(obj["old"+attrColor])=="undefined")
			obj["old"+attrColor]=elem[attrColor];
		elem[attrColor]=g.Activation.BorderColor;
		if(typeof(obj["old"+attrWidth])=="undefined")
			obj["old"+attrWidth]=elem[attrWidth];
		elem[attrWidth]=g.Activation.BorderWidth;
	}
}

function igtbl_valueFromString(value,dataType)
{
	if(typeof(value)=="undefined" || value==null)
		return value;
	switch(dataType)
	{
		case 2: // integer
		case 3:
		case 16:
		case 17:
		case 18:
		case 19:
		case 20:
		case 21:
			if(typeof(value)=="number")
				return value;
			if(typeof(value)=="boolean")
				return (value?1:0);
			value=parseInt(value.toString(),10);
			if(value.toString()=="NaN")
				value=0;
			break;
		case 4: // float
		case 5:
		case 14:
			if(typeof(value)=="float")
				return value;
			value=parseFloat(value.toString());
			if(value.toString()=="NaN")
				value=0.0;
			break;
		case 11: // boolean
			if(!value || value.toString()=="0" || value.toString().toLowerCase()=="false")
				value=false;
			else
				value=true;
			break;
		case 7: // datetime
			var d=new Date(value);
			if(d.toString()!="NaN" && d.toString()!="Invalid Date")
				value=d;
			else
				value=igtbl_trim(value.toString());
			delete d;
			break;
		case 8:
			break;
		default:
			value=igtbl_trim(value.toString());
	}
	return value;
}

function igtbl_getCellValue(textValue)
{
	var value;
	/*v30 15*/
	{
	value=this.Element.getAttribute("igCellText");
	if(!value)
	{
		value=this.Element.getAttribute("unmaskedValue");
		if(typeof(value)=="undefined" || value==null)
		{
			if(this.Element.childNodes.length>0 && this.Element.childNodes[0].tagName=="NOBR")
				value=igtbl_getInnerText(this.Element.childNodes[0]);
			else
				value=igtbl_getInnerText(this.Element);
		}
		else if(textValue)
		{
			if(this.MaskedValue)
				value=this.MaskedValue;
			else
				value=value.toString();
		}
		var oCombo=null;
		if(this.Column.WebComboId && typeof(igcmbo_getComboById)!="undefined")
			oCombo=igcmbo_getComboById(this.Column.WebComboId);
		if(oCombo)
		{
			if(!textValue)
			{
				var oCombo=igcmbo_getComboById(this.Column.WebComboId);
				if(oCombo && oCombo.DataTextField)
				{
					var re=new RegExp("^"+igtbl_getRegExpSafe(value)+"$","gi");
					var column=oCombo.grid.Bands[0].getColumnFromKey(oCombo.DataTextField);
					var cell=column.find(re);
					if(cell && oCombo.DataValueField)
						value=cell.Row.getCellByColumn(oCombo.grid.Bands[0].getColumnFromKey(oCombo.DataValueField)).getValue(true);
					delete re;
				}
			}
		}
		else if(this.Column.Type==3 && this.Element.childNodes.length>0)
		{
			var chBox=this.Element.childNodes[0];
			while(chBox && chBox.tagName!="INPUT")
				chBox=chBox.childNodes[0];
			value=false;
			if(chBox)
				value=chBox.checked;
			if(textValue)
				value=value.toString();
		}
		else if(this.Column.Type==5 && this.Column.ValueList.length>0)
		{
			if(!textValue)
				for(var i=0;i<this.Column.ValueList.length;i++)
					if(this.Column.ValueList[i][1]==value)
					{
						value=this.Column.ValueList[i][0];
						break;
					}
		}
		else if(this.Column.Type==7 && this.Element.childNodes.length>0)
		{
			var button=this.Element.childNodes[0];
			while(button && button.tagName!="INPUT")
				button=button.childNodes[0];
			if(button)
				value=button.value;
		}
		if(typeof(value)=="string" && this.Column.AllowNull && igtbl_trim(value)==this.Column.getNullText() && !textValue)
			value=null;
	}
	}
	if(!textValue)
		value=igtbl_valueFromString(value,this.Column.DataType);
	return value;
}

function igtbl_setCellValue(value)
{
	var gn=this.Row.gridId;
	var gs=igtbl_getGridById(gn);
	if(this.Column.DataType!=8 && typeof(value)=="string")
		value=igtbl_trim(value);
	if(!gs.insideBeforeUpdate)
	{
		gs.insideBeforeUpdate=true;
		res=igtbl_fireEvent(gn,gs.Events.BeforeCellUpdate,"(\""+gn+"\",\""+this.Element.id+"\",\""+(value==null?this.Column.getNullText():value.toString().replace(/\r\n/g,"\\r\\n"))+"\")");
		gs.insideBeforeUpdate=false;
		if(res==true)
			return;
	}
	var v=value;
	if(typeof(value)!="undefined" && value!=null)
	{
		if(value.getMonth)
			value=(value.getMonth()+1).toString()+"/"+value.getDate().toString()+"/"+value.getFullYear()+" "+(value.getHours()==0?"12":(value.getHours()%12).toString())+":"+(value.getMinutes()<10?"0":"")+value.getMinutes()+":"+(value.getSeconds()<10?"0":"")+value.getSeconds()+" "+(value.getHours()<12?"AM":"PM");
	}
	var oldValue=this.getValue();
	if(this.Element.getAttribute("igCellText"))
		this.Element.setAttribute("igCellText",value);
	else 
	{
		var rendVal=null;
		if(this.Column.editorControl && this.Column.editorControl.getRenderedValue && (rendVal=this.Column.editorControl.getRenderedValue(v))!=null)
		{
			v=rendVal;
			if(value!=null)
				this.Element.setAttribute("unmaskedValue",value.toString());
			else
				this.Element.removeAttribute("unmaskedValue");
			this.MaskedValue=v;
		}
		else 
		{
			if(this.Column.AllowNull && (typeof(v)=="undefined" || v==null || v=="" || v==this.Column.getNullText()))
			{
				v=this.Column.getNullText();
				value="";
			}
			else
				v=value.toString();
			if(this.Column.MaskDisplay!="")
			{
				if(this.Column.AllowNull && v==this.Column.getNullText())
				{
					this.Element.setAttribute("unmaskedValue",null);
					this.MaskedValue=(v==""?" ":v);
				}
				else
				{
					v=igtbl_Mask(gn,v,this.Column.DataType,this.Column.MaskDisplay);
					if(v=="")
					{
						var umv=this.Element.getAttribute("unmaskedValue");
						if(typeof(umv)!="undefined" && umv!=null)
							v=igtbl_Mask(gn,umv,this.Column.DataType,this.Column.MaskDisplay);
						else
						{
							v=this.Column.getNullText();
							value="";
						}
					}
					else
					{
						if(this.Column.MaskDisplay=="MM/dd/yyyy" || this.Column.MaskDisplay=="MM/dd/yy" || this.Column.MaskDisplay=="hh:mm" || this.Column.MaskDisplay=="HH:mm" || this.Column.MaskDisplay=="hh:mm tt")
							value=v;
						this.Element.setAttribute("unmaskedValue",value);
						this.MaskedValue=v;
					}
				}
			}
			if(!(this.Column.AllowNull && v==this.Column.getNullText()))
			{
				if(this.Column.MaskDisplay=="")
				{
					if(typeof(value)!="undefined" && value!=null && this.Column.DataType!=7)
						v=igtbl_valueFromString(value,this.Column.DataType).toString();
					if(this.Column.FieldLength>0)
					{
						v=v.substr(0,this.Column.FieldLength);
						value=v;
					}
					if(this.Column.Case==1)
						v=v.toLowerCase();
					else if(this.Column.Case==2)
						v=v.toUpperCase();
				}
			}
		}
		var setInner=true;
		if(this.Column.WebComboId && typeof(igcmbo_getComboById)!="undefined")
		{
			var oCombo=igcmbo_getComboById(this.Column.WebComboId);
			if(oCombo && oCombo.DataValueField)
			{
				var re=new RegExp("^"+igtbl_getRegExpSafe(value)+"$","gi");
				var column=oCombo.grid.Bands[0].getColumnFromKey(oCombo.DataValueField);
				var cell=column.find(re);
				if(cell && oCombo.DataTextField)
					v=cell.Row.getCellByColumn(oCombo.grid.Bands[0].getColumnFromKey(oCombo.DataTextField)).getValue(true);
				this.Element.setAttribute("igDataValue",value);
				this.Element.setAttribute("unmaskedValue",value.toString());
				delete re;
			}
		}
		else if(this.Column.Type==3 && this.Element.childNodes.length>0)
		{
			igtbl_dontHandleChkBoxChange=true;
			var chBox=this.Element.childNodes[0];
			while(chBox && chBox.tagName!="INPUT")
				chBox=chBox.childNodes[0];
			if(chBox)
			{
				if(!value || value.toString().toLowerCase()=="false")
					chBox.checked=false;
				else
					chBox.checked=true;
			}
			igtbl_dontHandleChkBoxChange=false;
			setInner=false;
		}
		else if(this.Column.Type==5 && this.Column.ValueList.length>0)
		{
			for(var i=0;i<this.Column.ValueList.length;i++)
				if(this.Column.ValueList[i][0]==value)
				{
					v=this.Column.ValueList[i][1];
					this.Element.setAttribute("igDataValue",value);
					break;
				}
		}
		else if(this.Column.Type==7 && this.Element.childNodes.length>0)
		{
			var button=this.Element.childNodes[0];
			while(button && button.tagName!="INPUT")
				button=button.childNodes[0];
			if(button)
			{
				button.value=v;
				setInner=false;
			}
			else
			{
				button=igtbl_getElementById(gn+"_bt");
				if(button)
					button.value=v;
			}
		}
		if(setInner)
		{
			if(this.Element.childNodes.length>0 && this.Element.childNodes[0].tagName=="NOBR")
			{
				if(this.Element.childNodes[0].childNodes.length>0 && this.Element.childNodes[0].childNodes[0].tagName=="A")
				{
					igtbl_setInnerText(this.Element.childNodes[0].childNodes[0],(v==""?" ":v));
					this.Element.childNodes[0].childNodes[0].href=(v.indexOf('@')>=0?"mailto:":"")+v;
				}
				else
					igtbl_setInnerText(this.Element.childNodes[0],(v==""?" ":v));
			}
			else if(this.Element.childNodes.length>0 && this.Element.childNodes[0].tagName=="A")
			{
				igtbl_setInnerText(this.Element.childNodes[0],(v==""?" ":v));
				this.Element.childNodes[0].href=(v.indexOf('@')>=0?"mailto:":"")+v;
			}
			else
				igtbl_setInnerText(this.Element,(v==""?" ":v));
		}
	}
	var newValue=this.getValue();
	if(!((typeof(newValue)=="undefined" || newValue==null) && (typeof(oldValue)=="undefined" || oldValue==null) || newValue!=null && oldValue!=null && newValue.valueOf()==oldValue.valueOf()))
	{
		igtbl_saveChangedCell(gs,this.Row.Element.id,this.Element.id,value);
		igtbl_fireEvent(gn,gs.Events.AfterCellUpdate,"(\""+gn+"\",\""+this.Element.id+"\")");
	}
}

function igtbl_getCellRow()
{
	return this.Row;
}
	
function igtbl_getChildRow(index)
{
	if(!this.Expandable)
		return null;
	if(index<0 || index>=this.ChildRowsCount || !this.FirstChildRow)
		return null;
	var i=0;
	var r=this.FirstChildRow.Element;
	while(i<index && r)
	{
		r=igtbl_getNextSibRow(this.gridId,r);
		i++;
	}
	if(!r)
		return null;
	return igtbl_getRowById(r.id);
}

function igtbl_gGetNextTabCell(shift)
{
	var g=this.Row.Band.Grid;
	var cell=null;
	switch(g.TabDirection)
	{
		case 0:
		case 1:
			if(shift && g.TabDirection==0 || !shift && g.TabDirection==1)
			{
				cell=this.getPrevCell();
				if(!cell)
				{
					var row=this.Row.getNextTabRow(true);
					if(row)
					{
						cell=row.getCell(row.cells.length-1);
						if(cell.Column.getHidden())
							cell=cell.getPrevCell();
					}
				}
			}
			else
			{
				cell=this.getNextCell();
				if(!cell)
				{
					var row=this.Row.getNextTabRow(false);
					if(row && !row.GroupByRow)
					{
						cell=row.getCell(0);
						if(cell.Column.getHidden())
							cell=cell.getNextCell();
					}
				}
			}
			break;
		case 2:
		case 3:
			if(shift && g.TabDirection==2 || !shift && g.TabDirection==3)
			{
				var row=this.Row.getPrevRow();
				if(row && row.getExpanded())
				{
					row=this.Row.getNextTabRow(true);
					cell=row.getCell(row.cells.length-1);
				}
				else if(row)
					cell=row.getCell(this.Index);
				else
				{
					if(this.Index==0)
					{
						row=this.Row.getNextTabRow(true);
						if(row)
							cell=row.getCell(row.cells.length-1);
					}
					else
						cell=this.Row.OwnerCollection.getRow(this.Row.OwnerCollection.length-1).getCell(this.Index-1);
				}
			}
			else
			{
				if(this.Row.getExpanded())
					cell=this.Row.Rows.getRow(0).getCell(0);
				else
				{
					var row=this.Row.getNextRow();
					if(row)
						cell=row.getCell(this.Index);
					else if(this.Index<this.Row.cells.length-1)
						cell=this.Row.OwnerCollection.getRow(0).getCell(this.Index+1);
					else
					{
						row=this.Row.getNextTabRow(false);
						if(row)
							cell=row.getCell(0);
					}
				}
			}
			break;
	}
	return cell;
}

function igtbl_gEditCell(keyCode)
{
	igtbl_editCell((typeof(event)!="undefined"?event:null),this.Row.gridId,this.Element,keyCode);
}

function igtbl_gEndEditCell()
{
	igtbl_hideEdit(this.Row.gridId);
}

function igtbl_gGetCellSelected()
{
	if(igtbl_getGridById(this.Row.gridId).SelectedCells[this.Element.id])
		return true;
	return false;
}

function igtbl_gSetCellSelected(select)
{
	var stc=this.Band.getSelectTypeCell();
	if(stc>1)
	{
		if(stc==2)
			this.Band.Grid.clearSelectionAll();
		igtbl_selectCell(this.Row.gridId,this,select);
	}
}

function igtbl_gGetNextCell()
{
	var nc=this.Index+1;
	while(nc<this.Row.cells.length && this.Row.getCell(nc).Column.getHidden())
		nc++;
	if(nc<this.Row.cells.length)
		return this.Row.getCell(nc);
	return null;
}

function igtbl_gGetPrevCell()
{
	var pc=this.Index-1;
	while(pc>=0 && this.Row.getCell(pc).Column.getHidden())
		pc--;
	if(pc>=0)
		return this.Row.getCell(pc);
	return null;
}

function igtbl_gCellActivate()
{
	this.Row.Band.Grid.setActiveCell(this);
}

function igtbl_gCellScrollToView()
{
	igtbl_scrollToView(this.Row.gridId,this.Element);
}

function igtbl_gCellIsEditable()
{
	if(this.Element.getAttribute("allowedit")=='no')
		return false;
	if(this.Element.getAttribute("allowedit")=='yes')
		return true;
	return igtbl_getAllowUpdate(this.Row.gridId,this.Column.Band.Index,this.Column.Index)==1;
}
