/* 
Infragistics UltraWebGrid Script 
Version 3.0.20041.11
Copyright (c) 2001-2004 Infragistics, Inc. All Rights Reserved.
*/

function igtbl_hideEdit(gn)
{
	var g = igtbl_getGridById(gn);
	var oEditor = g.editorControl;
	if(oEditor)
	{
		oEditor.Element.removeAttribute("noOnBlur");
		if(igtbl_endCustomEdit.apply)
			igtbl_endCustomEdit.apply(oEditor);
		else if(oEditor.endEditCell)
			oEditor.endEditCell();
		else
			oEditor.setVisible(false);
		g.editorControl = null;
		return;
	}
	var sel=igtbl_getElementById(gn+"_vl");
	if(sel && sel.style.display=="")
	{
		sel.removeAttribute("noOnBlur");
		var evnt=new igtbl_initEvent(sel);
		igtbl_dropDownListFocusOut(evnt,gn);
		delete evnt;
	}
	var tb=igtbl_getElementById(gn+"_tb");
	if(tb && tb.style.display=="")
	{
		tb.removeAttribute("noOnBlur");
		var evnt=new igtbl_initEvent(tb);
		igtbl_editBoxFocusOut(evnt,gn);
		delete evnt;
	}
	var ta=igtbl_getElementById(gn+"_ta");
	if(ta && ta.style.display=="")
	{
		ta.removeAttribute("noOnBlur");
		var evnt=new igtbl_initEvent(ta);
		igtbl_editBoxMLFocusOut(evnt,gn);
		delete evnt;
	}
}

function igtbl_editBoxKeyDown(evnt)
{
	if(typeof(event)!="undefined")
		evnt=event;
	var se=igtbl_srcElement(evnt);
	var gn=se.getAttribute("gn");
	var gs=igtbl_getGridById(gn);
	var cell=igtbl_getElementById(se.getAttribute("currentCell"));
	se.setAttribute("noOnBlur",true);
	window.setTimeout("igtbl_cancelNoOnBlurTB('"+gn+"')",100);
	if(igtbl_fireEvent(gn,gs.Events.EditKeyDown,"(\""+gn+"\",\""+cell.id+"\","+evnt.keyCode+")")==true)
		return true;
	if(evnt.keyCode==13 || evnt.keyCode==9)
	{
		se.removeAttribute("noOnBlur");
		igtbl_hideEdit(gn);
		if(gs.activeRect)
		{
			if(evnt.keyCode==9 && evnt.shiftKey)
				igtbl_ActivatePrevCell(gn);
			else
				igtbl_ActivateNextCell(gn);
			if(igtbl_getCellClickAction(gn,cell.parentNode.parentNode.parentNode.getAttribute("bandNo"))==1)
				igtbl_EnterEditMode(gn);
			return igtbl_cancelEvent(evnt);
		}
		return false;
	}
	else if(evnt.keyCode==113)
		igtbl_hideEdit(gn);
	else if(evnt.keyCode==27)
	{
		if(cell.getAttribute("unmaskedValue"))
			se.value=cell.getAttribute("unmaskedValue");
		else
			se.value=se.getAttribute("oldInnerText");
		igtbl_hideEdit(gn);
	}
	else
		cell.setAttribute("igCellText",se.value);
}

function igtbl_editBoxMLKeyDown(evnt)
{
	if(typeof(event)!="undefined")
		evnt=event;
	var se=igtbl_srcElement(evnt);
	var gn=se.getAttribute("gn");
	var gs=igtbl_getGridById(gn);
	var cell=igtbl_getElementById(se.getAttribute("currentCell"));
	if(igtbl_fireEvent(gn,gs.Events.EditKeyDown,"(\""+gn+"\",\""+cell.id+"\","+evnt.keyCode+")")==true)
		return true;
	if(evnt.keyCode==9)
	{
		igtbl_hideEdit(gn);
		if(gs.activeRect)
		{
			if(evnt.shiftKey)
				igtbl_ActivatePrevCell(gn);
			else
				igtbl_ActivateNextCell(gn);
			if(igtbl_getCellClickAction(gn,cell.parentNode.parentNode.parentNode.getAttribute("bandNo"))==1)
				igtbl_EnterEditMode(gn);
		}
		return false;
	}
	else if(evnt.keyCode==113)
		igtbl_hideEdit(gn);
	else if(evnt.keyCode==27)
	{
		if(cell.getAttribute("unmaskedValue"))
			se.value=cell.getAttribute("unmaskedValue");
		else
			se.value=se.getAttribute("oldInnerText");
		igtbl_hideEdit(gn);
	}
	else
		cell.setAttribute("igCellText",se.value);
}

function igtbl_dropDownListKeyDown(evnt)
{
	if(typeof(event)!="undefined")
		evnt=event;
	var se=igtbl_srcElement(evnt);
	var gn=se.getAttribute("gn");
	var gs=igtbl_getGridById(gn);
	var cell=igtbl_getElementById(se.getAttribute("currentCell"));
	if(igtbl_fireEvent(gn,gs.Events.EditKeyDown,"(\""+gn+"\",\""+cell.id+"\","+evnt.keyCode+")")==true)
		return true;
	if(evnt.keyCode==13 || evnt.keyCode==9)
	{
		igtbl_hideEdit(gn);
		if(gs.activeRect)
		{
			if(evnt.keyCode==9 && evnt.shiftKey)
				igtbl_ActivatePrevCell(gn);
			else
				igtbl_ActivateNextCell(gn);
			if(igtbl_getCellClickAction(gn,cell.parentNode.parentNode.parentNode.getAttribute("bandNo"))==1)
				igtbl_EnterEditMode(gn);
		}
		return false;
	}
	else if(evnt.keyCode==113)
	{
		igtbl_hideEdit(gn);
		return false;
	}
	else if(evnt.keyCode==27)
	{
		for(var i=0;i<se.options.length;i++)
			if(igtbl_getInnerText(se.options[i])==se.getAttribute("oldInnerText"))
			{
				se.options[i].selected=true;
				break;
			}
		igtbl_hideEdit(gn);
	}
}

function igtbl_editBoxKeyUp(evnt)
{
	if(typeof(event)!="undefined")
		evnt=event;
	var se=igtbl_srcElement(evnt);
	var gn=se.getAttribute("gn");
	var gs=igtbl_getGridById(gn);
	var cell=igtbl_getElementById(se.getAttribute("currentCell"));
	igtbl_fireEvent(gn,gs.Events.EditKeyUp,"(\""+gn+"\",\""+cell.id+"\","+evnt.keyCode+")");
}

function igtbl_editBoxMLKeyUp(evnt)
{
	igtbl_editBoxKeyUp(evnt);
}

function igtbl_editCell(evnt,gn,cell,keyCode)
{
	var table=cell.parentNode.parentNode.parentNode;
	var bandNo=table.getAttribute("bandNo");
	var columnNo=table.rows[0].cells[cell.cellIndex].getAttribute("columnNo");
	var gs=igtbl_getGridById(gn);
	var cellObj=igtbl_getCellById(cell.id);
	if(!cellObj)
		return;
	if(gs.exitEditCancel || !cellObj.isEditable())
		return;
	var te=gs.Element;
	var column=cellObj.Column;
	if(column.Type==3 || column.Type==7)
		return;
	if(igtbl_fireEvent(gn,gs.Events.BeforeEnterEditMode,"(\""+gn+"\",\""+cell.id+"\")")==true)
		return;
	if(column.EditorControlID)
	{
		gs.editorControl=igtbl_getElementById(column.EditorControlID);
		if(!gs.editorControl)
			return;
		gs.editorControl=gs.editorControl.Object
		if(!gs.editorControl)
			return;
		if(!column.editorControl)
			column.editorControl=gs.editorControl;
		var oEditor=gs.editorControl;
		var eEditor=oEditor.Element;
		eEditor.setAttribute("editorControl",true);
		eEditor.setAttribute("currentCell",cell.id);
		eEditor.setAttribute("oldInnerText",igtbl_getInnerText(cell));
		eEditor.setAttribute("noOnBlur",true);
		oEditor.setValue(cellObj.getValue(),false);
		cellObj.scrollToView();
		var mainGrid=igtbl_getElementById(gn+"_main");
		var left;
		var top = cell.offsetTop;
		var parent = cell.offsetParent;
		while(!(parent==null || parent.style.position=="relative")) {
			top += parent.offsetTop;
			if(parent!=mainGrid && parent.tagName=="TABLE" && parent.style.position=="absolute")
				break;
			parent = parent.offsetParent;
		}
		top -= te.offsetParent.scrollTop;
		
		left = cell.offsetLeft;
		var parent = cell.offsetParent;
		while(!(parent==null || parent.style.position=="relative")) {
			left += parent.offsetLeft;
			if(parent!=mainGrid && parent.tagName=="TABLE" && parent.style.position=="absolute")
				break;
			parent = parent.offsetParent;
		}
		left -= te.offsetParent.scrollLeft;
		
		eEditor.style.position="absolute";
		if(mainGrid.style.zIndex)
			eEditor.style.zIndex=mainGrid.style.zIndex+1;
		oEditor.setVisible(true,left,top,igtbl_clientWidth(cell),igtbl_clientHeight(cell));
		
		oEditor.webGrid = gs;
		
		oEditor.addEventListener("blur",igtbl_endCustomEdit,gs);
		oEditor.addEventListener("keydown",igtbl_endCustomEdit,gs);

		window.setTimeout("igtbl_cancelNoOnBlurDD('"+gn+"')",100);
	}
	else if(column.ValueList.length>0)
	{
		var fireSelChange=true;
		var sel=igtbl_getElementById(gn+"_vl");
		if(sel)
			igtbl_hideEdit(gn);
		sel=igtbl_getElementById(gn+"_vl");
		if(sel)
			return;
		var ih=igtbl_getInnerText(cell);
		cell.width=cell.offsetWidth;
		cell.height=cell.offsetHeight;
		sel=document.createElement("select");
		sel.id=gn+"_vl";
		sel.setAttribute("currentCell",cell.id);
		sel.setAttribute("gn",gn);
		sel.onkeydown=igtbl_dropDownListKeyDown;
		sel.onkeyup=igtbl_editBoxKeyUp;
		if(sel.addEventListener)
			sel.addEventListener('blur',igtbl_dropDownListFocusOut,false);
		sel.setAttribute("noOnBlur",true);
		sel.onmousedown=function()
		{
			this.setAttribute("noOnBlur",true);
			window.setTimeout("igtbl_cancelNoOnBlurTB('"+this.id.substr(0,this.id.length-3)+"')",100);
		}
		window.setTimeout("igtbl_cancelNoOnBlurTB('"+gn+"')",100);
		if(cell.childNodes && cell.childNodes.length>0 && cell.childNodes[0].tagName=="A")
		{
			sel.setAttribute("hasHref","true");
			sel.setAttribute("oldInnerText",igtbl_getInnerText(cell.childNodes[0]));
			ih=igtbl_getInnerText(cell.childNodes[0]);
		}
		else
			sel.setAttribute("oldInnerText",igtbl_getInnerText(cell));
		cell.innerHTML="";
		cell.appendChild(sel);
		cell.setAttribute("igCellText",ih);
		if(column.ValueListPrompt!="")
		{
			var oOption = document.createElement("OPTION");
			sel.appendChild(oOption);
			oOption.value=column.ValueListPrompt;
			igtbl_setInnerText(oOption,column.ValueListPrompt);
			fireSelChange=false;
		}
		sel.inited=false;
		for(var i=0;i<column.ValueList.length;i++)
		{
			if(column.ValueList[i])
			{
				var oOption = document.createElement("OPTION");
				sel.appendChild(oOption);
				oOption.value=column.ValueList[i][0];
				igtbl_setInnerText(oOption,column.ValueList[i][1]);
				if(!sel.inited)
				{
					if(cell.getAttribute("igDataValue"))
					{
						if(cell.getAttribute("igDataValue")==igtbl_trim(column.ValueList[i][0]))
						{
							oOption.selected=true;
							fireSelChange=false;
							sel.inited=true;
						}
					}
					else if(ih==igtbl_trim(column.ValueList[i][1]))
					{
						oOption.selected=true;
						fireSelChange=false;
						sel.inited=true;
					}
				}
			}
		}
		if(column.ValueListClass!="")
			sel.className=column.ValueListClass;
		sel.style.left=igtbl_getLeftPos(cell)-igtbl_adjustLeft(te);
		sel.style.top=igtbl_getTopPos(cell)+cell.offsetHeight/2-sel.offsetHeight/2-igtbl_adjustTop(te);
		sel.style.width='100%';
		if(cell.width!=cell.offsetWidth)
		{
			cell.style.width=cell.width;
			cell.style.height=cell.height;
		}
		if(fireSelChange)
			igtbl_fireEvent(gn,gs.Events.ValueListSelChange,"(\""+gn+"\",\""+gn+"_vl\",\""+sel.getAttribute("currentCell")+"\");");
	}
	else if(column.CellMultiline==1)
	{
		var textArea=igtbl_getElementById(gn+"_ta");
		if(textArea)
			igtbl_hideEdit(gn);
		textArea=igtbl_getElementById(gn+"_ta");
		if(textArea)
			return;
		var ih=cell.innerHTML;
		cell.width=cell.offsetWidth;
		cell.height=cell.offsetHeight;
		textArea=document.createElement("textarea");
		textArea.id=gn+"_ta";
		textArea.setAttribute("currentCell",cell.id);
		textArea.setAttribute("gn",gn);
		textArea.onkeydown=igtbl_editBoxMLKeyDown;
		textArea.onkeyup=igtbl_editBoxMLKeyUp;
		if(textArea.addEventListener)
			textArea.addEventListener('blur',igtbl_editBoxMLFocusOut,false);
		if(cell.childNodes && cell.childNodes.length>0)
		{
			if(cell.childNodes[0].tagName=="A")
			{
				textArea.setAttribute("hasHref","true");
				textArea.setAttribute("oldInnerText",igtbl_getInnerText(cell.childNodes[0]));
				ih=igtbl_getInnerText(cell.childNodes[0]);
			}
			else if(cell.childNodes[0].tagName=="NOBR")
				ih=igtbl_getInnerText(cell.childNodes[0]);
		}
		else
			textArea.setAttribute("oldInnerText",igtbl_getInnerText(cell));
		cell.innerHTML="";
		cell.appendChild(textArea);
		cell.setAttribute("igCellText",ih);
		var str=ih;
		str=str.replace(/<br>/g,"\r\n");
		textArea.value=str;
		if(igtbl_getEditCellClass(gn,bandNo)!="")
			textArea.className=igtbl_getEditCellClass(gn,bandNo);
		textArea.style.width=cell.width;
		textArea.style.height=cell.height;
		if(cell.width!=cell.offsetWidth)
		{
			cell.style.width=cell.width;
			cell.style.height=cell.height;
		}
		textArea.select();
	}
	else
	{
		var textBox=igtbl_getElementById(gn+"_tb");
		if(textBox)
			igtbl_hideEdit(gn);
		textBox=igtbl_getElementById(gn+"_tb");
		if(textBox)
			return;
		var ih=igtbl_getInnerText(cell);
		cell.width=cell.offsetWidth;
		cell.height=cell.offsetHeight;
		textBox=document.createElement("input");
		textBox.id=gn+"_tb";
		textBox.type="text";
		textBox.setAttribute("currentCell",cell.id);
		textBox.setAttribute("gn",gn);
		if(textBox.addEventListener)
			textBox.addEventListener("keydown",igtbl_editBoxKeyDown,false);
		else
			textBox.onkeydown=igtbl_editBoxKeyDown;
		textBox.onkeyup=igtbl_editBoxKeyUp;
		if(textBox.addEventListener)
			textBox.addEventListener('blur',igtbl_editBoxFocusOut,false);
		textBox.setAttribute("noOnBlur",true);
		if(cell.childNodes && cell.childNodes.length>0)
		{
			if(cell.childNodes[0].tagName=="A")
			{
				textBox.setAttribute("hasHref","true");
				textBox.setAttribute("oldInnerText",igtbl_getInnerText(cell.childNodes[0]));
				ih=igtbl_getInnerText(cell.childNodes[0]);
			}
			else if(cell.childNodes[0].tagName=="NOBR")
				ih=igtbl_getInnerText(cell.childNodes[0]);
		}
		else
			textBox.setAttribute("oldInnerText",igtbl_getInnerText(cell));
		cell.innerHTML="";
		cell.appendChild(textBox);
		cell.setAttribute("igCellText",ih);
		if(column.FieldLength>0)
			textBox.maxLength=column.FieldLength;
		else
			textBox.maxLength=2147483647;
		if(cell.getAttribute("unmaskedValue"))
			textBox.value=cell.getAttribute("unmaskedValue");
		else
			textBox.value=ih;
		if(igtbl_getEditCellClass(gn,bandNo)!="")
			textBox.className=igtbl_getEditCellClass(gn,bandNo);
		textBox.style.width=cell.width;
		textBox.style.height=cell.height;
		if(cell.width!=cell.offsetWidth)
		{
			cell.style.width=cell.width;
			cell.style.height=cell.height;
		}
		textBox.select();
		window.setTimeout("igtbl_cancelNoOnBlurTB('"+gn+"')",100);
	}
	igtbl_fireEvent(gn,gs.Events.AfterEnterEditMode,"(\""+gn+"\",\""+cell.id+"\");");
}

function igtbl_endCellEdit()
{
	if(this.webCombo != null) {
		var eCombo = this.webCombo.Element
		var cell=igtbl_getElementById(eCombo.getAttribute("currentCell"));
		if(!cell)
			return;
		var gn = this.Id;
		var gs=igtbl_getGridById(gn);
		var oldText=igtbl_getInnerText(cell);

		var hasHref=false;
		if(cell.childNodes && cell.childNodes.length>0 && cell.childNodes[0].tagName=="A")
		{
			hasHref=true;
			oldText=igtbl_getInnerText(cell.childNodes[0]);
		}
		if(!cell.getAttribute("oldValue"))
			cell.setAttribute("oldValue",oldText);
		var changed=false;
		var column=igtbl_getColumnById(cell.id);
		var displayValue=this.webCombo.getDisplayValue();
		this.webCombo.setDropDown(false);
		if(!this.webCombo.Prompt || this.webCombo.getSelectedIndex()>0)
		{	
			if(hasHref)
				changed=(igtbl_getInnerText(cell.childNodes[0])!=displayValue);
			else
				changed=(igtbl_getInnerText(cell)!=displayValue);
		}
		if(changed && !gs.insideBeforeUpdate)
		{
			gs.insideBeforeUpdate=true;
			var value=igtbl_fireEvent(gn,gs.Events.BeforeCellUpdate,"(\""+gn+"\",\""+cell.id+"\",\""+value+"\")");
			gs.insideBeforeUpdate=false;
			if(value==true)
				changed=false;
		}
		if(changed)
		{
			if(!displayValue)
				displayValue=this.webCombo.getDisplayValue();
			if(displayValue=="")
				displayValue=" ";
			if(hasHref)
			{
				igtbl_setInnerText(cell.childNodes[0],displayValue);
				cell.childNodes[0].href=(value.indexOf('@')>=0?"mailto:":"")+cell.childNodes[0].innerText;
			}
			else if(cell.childNodes.length>0 && cell.childNodes[0].tagName=="NOBR")
				igtbl_setInnerText(cell.childNodes[0],displayValue);
			else
				igtbl_setInnerText(cell.childNodes[0],displayValue);
			if(displayValue==" ")
				displayValue="";
			if(displayValue!=eCombo.getAttribute("oldInnerText"))
				igtbl_saveChangedCell(gs,cell.parentNode.id,cell.id,this.webCombo.getDataValue());
		}
		if(igtbl_fireEvent(gn,gs.Events.BeforeExitEditMode,"(\""+gn+"\",\""+cell.id+"\")")==true)
		{
			if(!gs.exitEditCancel && !gs.insideSetActive)
			{
				gs.insideSetActive=true;
				igtbl_setActiveCell(gn,igtbl_getElementById(eCombo.getAttribute("currentCell")));
				gs.insideSetActive=false;
			}
			gs.exitEditCancel=true;
			return;
		}
		this.webCombo.setVisible(false);
		igcmbo_displaying=null;
		gs.exitEditCancel=false;
		eCombo.removeAttribute("currentCell");
		eCombo.removeAttribute("oldInnerText");
		if(gs.ActiveCell!="")
			igtbl_setActiveCell(gn,igtbl_getElementById(gs.ActiveCell));
		else if(gs.ActiveRow!="")
			igtbl_setActiveRow(gn,igtbl_getElementById(gs.ActiveRow));

		igtbl_fireEvent(gn,gs.Events.AfterExitEditMode,"(\""+gn+"\",\""+cell.id+"\");");
		if(changed)
		{
			igtbl_fireEvent(gn,gs.Events.AfterCellUpdate,"(\""+gn+"\",\""+cell.id+"\");");
			if(gs.NeedPostBack)
			{
				gs.GridIsLoaded=false;
				igtbl_doPostBack(gn);
			}
		}
		this.webCombo = null;
		return;		
	}
}

function igtbl_dropDownListFocusOut(evnt,gn)
{
	var se=igtbl_srcElement(evnt);
	if(typeof(gn)=="undefined")
		gn=se.id.substr(0,se.id.length-3);
	var cell=igtbl_getElementById(se.getAttribute("currentCell"));
	if(!cell || se.getAttribute("noOnBlur"))
		return;
	var gs=igtbl_getGridById(gn);
	var oldText=se.getAttribute("oldInnerText");
	if(!cell.getAttribute("oldValue"))
		cell.setAttribute("oldValue",oldText);
	var column=igtbl_getColumnById(cell.id);
	var value=igtbl_getInnerText(se.options[se.selectedIndex]);
	var changed=(oldText!=value);
	if(changed && value!=column.ValueListPrompt)
	{
		value=igtbl_fireEvent(gn,gs.Events.BeforeCellUpdate,"(\""+gn+"\",\""+cell.id+"\",\""+value+"\")");
		if(value==true)
			changed=false;
	}
	if(igtbl_fireEvent(gn,gs.Events.BeforeExitEditMode,"(\""+gn+"\",\""+cell.id+"\")")==true)
	{
		if(!gs.exitEditCancel && !gs.insideSetActive)
		{
			gs.insideSetActive=true;
			igtbl_setActiveCell(gn,igtbl_getElementById(se.getAttribute("currentCell")));
			gs.insideSetActive=false;
		}
		gs.exitEditCancel=true;
		return;
	}
	gs.exitEditCancel=false;
	if(changed)
	{
		if(value==false || value==undefined)
			value=igtbl_getInnerText(se.options[se.selectedIndex]);
		if(value=="")
			value=" ";
		if(column.ValueListPrompt!="" && se.selectedIndex==0)
			value=se.getAttribute("oldInnerText");
		if(se.getAttribute("hasHref"))
		{
			cell.innerHTML="";
			var l=document.createElement("A");
			l.href=(value.indexOf('@')>=0?"mailto:":"")+value;
			igtbl_setInnerText(l,value);
			cell.appendChild(l);
		}
		else if(cell.childNodes.length>0 && cell.childNodes[0].tagName=="NOBR")
			igtbl_setInnerText(cell.childNodes[0],value);
		else
			igtbl_setInnerText(cell,value);
		if(value==" ")
			value="";
		igtbl_saveChangedCell(gs,cell.parentNode.id,cell.id,value);
	}
	else
	{
		if(se.getAttribute("hasHref"))
		{
			cell.innerHTML="";
			var l=document.createElement("A");
			l.href=(oldText.indexOf('@')>=0?"mailto:":"")+oldText;
			igtbl_setInnerText(l,oldText);
			cell.appendChild(l);
		}
		else
			igtbl_setInnerText(cell,oldText);
	}
	cell.removeAttribute("igCellText");
	if(gs.ActiveCell!="")
		igtbl_setActiveCell(gn,igtbl_getElementById(gs.ActiveCell));
	else if(gs.ActiveRow!="")
		igtbl_setActiveRow(gn,igtbl_getElementById(gs.ActiveRow));
	igtbl_fireEvent(gn,gs.Events.AfterExitEditMode,"(\""+gn+"\",\""+cell.id+"\");");
	if(changed)
	{
		igtbl_fireEvent(gn,gs.Events.AfterCellUpdate,"(\""+gn+"\",\""+cell.id+"\");");
		if(gs.NeedPostBack)
			igtbl_doPostBack(gn);
	}
}

function igtbl_editBoxFocusOut(evnt,gn)
{
	var se=igtbl_srcElement(evnt);
	if(typeof(gn)=="undefined")
		gn=se.id.substr(0,se.id.length-3);
	var cell=igtbl_getElementById(se.getAttribute("currentCell"));
	if(!cell || se.getAttribute("noOnBlur"))
		return;
	var gs=igtbl_getGridById(gn);
	var oldText=se.getAttribute("oldInnerText");
	if(!cell.getAttribute("oldValue"))
		cell.setAttribute("oldValue",oldText);
	var value=se.value;
	var column=gs.Bands[cell.parentNode.parentNode.parentNode.getAttribute("bandNo")].Columns[igtbl_getColumnNo(gn,cell)];
	if(column.MaskDisplay!="")
	{
		value=igtbl_Mask(gn,value,column.DataType,column.MaskDisplay);
		if(value=="")
			value=oldText;
	}
	if(column.Case==1)
		value=value.toLowerCase();
	else if(column.Case==2)
		value=value.toUpperCase();
	var changed=(oldText!=value);
	if(changed)
	{
		value=igtbl_fireEvent(gn,gs.Events.BeforeCellUpdate,"(\""+gn+"\",\""+cell.id+"\",\""+value+"\")");
		if(value==true)
			changed=false;
	}
	if(igtbl_fireEvent(gn,gs.Events.BeforeExitEditMode,"(\""+gn+"\",\""+cell.id+"\")")==true)
	{
		if(!gs.exitEditCancel && !gs.insideSetActive)
		{
			gs.insideSetActive=true;
			igtbl_setActiveCell(gn,igtbl_getElementById(se.getAttribute("currentCell")));
			gs.insideSetActive=false;
		}
		gs.exitEditCancel=true;
		return;
	}
	gs.exitEditCancel=false;
	if(changed)
	{
		var iValue=se.value;
		if(value==false || value==undefined)
		{
			value=iValue;
			if(column.MaskDisplay!="")
			{
				value=igtbl_Mask(gn,value,column.DataType,column.MaskDisplay);
				if(value=="")
					value=oldText;
			}
			if(column.Case==1)
				value=value.toLowerCase();
			else if(column.Case==2)
				value=value.toUpperCase();
		}
		if(value=="")
			value=" ";
		if(se.getAttribute("hasHref"))
		{
			cell.innerHTML="";
			var l=document.createElement("A");
			l.href=(value.indexOf('@')>=0?"mailto:":"")+value;
			igtbl_setInnerText(l,value);
			cell.appendChild(l);
		}
		else if(cell.childNodes.length>0 && cell.childNodes[0].tagName=="NOBR")
			igtbl_setInnerText(cell.childNodes[0],value);
		else
			igtbl_setInnerText(cell,value);
		if(value==" ")
			value="";
		if(column.MaskDisplay!="")
		{
			value=igtbl_clarifyInput(gn,iValue.toString(),column.DataType);
			cell.setAttribute("unmaskedValue",value);
		}
		else if(column.FieldLength!=0 || column.Case!=0)
		{
			value=se.value;
			cell.setAttribute("unmaskedValue",value);
		}
		igtbl_saveChangedCell(gs,cell.parentNode.id,cell.id,value);
	}
	else
	{
		if(se.getAttribute("hasHref"))
		{
			cell.innerHTML="";
			var l=document.createElement("A");
			l.href=(oldText.indexOf('@')>=0?"mailto:":"")+oldText;
			igtbl_setInnerText(l,oldText);
			cell.appendChild(l);
		}
		else
			igtbl_setInnerText(cell,oldText);
	}
	cell.removeAttribute("igCellText");
	if(gs.ActiveCell!="")
		igtbl_setActiveCell(gn,igtbl_getElementById(gs.ActiveCell));
	else if(gs.ActiveRow!="")
		igtbl_setActiveRow(gn,igtbl_getElementById(gs.ActiveRow));
	igtbl_fireEvent(gn,gs.Events.AfterExitEditMode,"(\""+gn+"\",\""+cell.id+"\");");
	if(changed)
	{
		igtbl_fireEvent(gn,gs.Events.AfterCellUpdate,"(\""+gn+"\",\""+cell.id+"\");");
		if(gs.NeedPostBack)
			igtbl_doPostBack(gn);
	}
}

function igtbl_editBoxMLFocusOut(evnt,gn)
{
	var se=igtbl_srcElement(evnt);
	if(typeof(gn)=="undefined")
		gn=se.id.substr(0,se.id.length-3);
	var cell=igtbl_getElementById(se.getAttribute("currentCell"));
	if(!cell || se.getAttribute("noOnBlur"))
		return;
	var gs=igtbl_getGridById(gn);
	var oldText=cell.innerHTML.replace(/<BR>/g,"\r\n");
	if(!cell.getAttribute("oldValue"))
		cell.setAttribute("oldValue",oldText);
	var value=se.value;
	var column=gs.Bands[cell.parentNode.parentNode.parentNode.getAttribute("bandNo")].Columns[igtbl_getColumnNo(gn,cell)];
	if(column.MaskDisplay!="")
	{
		value=igtbl_Mask(gn,value,column.DataType,column.MaskDisplay);
		if(value=="")
			value=oldText;
	}
	if(column.FieldLength>0)
		value=value.substr(0,column.FieldLength);
	if(column.Case==1)
		value=value.toLowerCase();
	else if(column.Case==2)
		value=value.toUpperCase();
	var changed=(oldText!=value);
	if(changed)
	{
		value=igtbl_fireEvent(gn,gs.Events.BeforeCellUpdate,"(\""+gn+"\",\""+cell.id+"\",\""+value+"\")");
		if(value==true)
			changed=false;
	}
	if(igtbl_fireEvent(gn,gs.Events.BeforeExitEditMode,"(\""+gn+"\",\""+cell.id+"\")")==true)
	{
		if(!gs.exitEditCancel && !gs.insideSetActive)
		{
			gs.insideSetActive=true;
			igtbl_setActiveCell(gn,igtbl_getElementById(se.getAttribute("currentCell")));
			gs.insideSetActive=false;
		}
		gs.exitEditCancel=true;
		return;
	}
	gs.exitEditCancel=false;
	if(changed)
	{
		var iValue=se.value;
		if(value==false || value==undefined)
		{
			value=iValue;
			if(column.MaskDisplay!="")
			{
				value=igtbl_Mask(gn,value,column.DataType,column.MaskDisplay);
				if(value=="")
					value=oldText;
			}
			if(column.FieldLength>0)
				value=value.substr(0,column.FieldLength);
			if(column.Case==1)
				value=value.toLowerCase();
			else if(column.Case==2)
				value=value.toUpperCase();
		}
		if(value=="")
			value=" ";
		if(se.getAttribute("hasHref"))
		{
			cell.innerHTML="";
			var l=document.createElement("A");
			l.href=(value.indexOf('@')>=0?"mailto:":"")+value;
			l.innerHTML=value.replace(/\r\n/g,"<BR>");
			cell.appendChild(l);
		}
		else if(cell.childNodes.length>0 && cell.childNodes[0].tagName=="NOBR")
			cell.childNodes[0].innerHTML=value.replace(/\r\n/g,"<BR>");
		else
			cell.innerHTML=value.replace(/\r\n/g,"<BR>");
		if(value==" ")
			value="";
		if(column.MaskDisplay!="")
		{
			value=igtbl_clarifyInput(gn,value.toString(),column.DataType);
			cell.setAttribute("unmaskedValue",value);
		}
		else if(column.FieldLength!=0 || column.Case!=0)
		{
			value=se.value;
			cell.setAttribute("unmaskedValue",value);
		}
		igtbl_saveChangedCell(gs,cell.parentNode.id,cell.id,value);
	}
	else
	{
		if(se.getAttribute("hasHref"))
		{
			cell.innerHTML="";
			var l=document.createElement("A");
			l.href=(oldText.indexOf('@')>=0?"mailto:":"")+oldText;
			l.innerHTML=oldText.replace(/\r\n/g,"<BR>");
			cell.appendChild(l);
		}
		else
			cell.innerHTML=oldText.replace(/\r\n/g,"<BR>");
	}
	cell.removeAttribute("igCellText");
	if(gs.ActiveCell!="")
		igtbl_setActiveCell(gn,igtbl_getElementById(gs.ActiveCell));
	else if(gs.ActiveRow!="")
		igtbl_setActiveRow(gn,igtbl_getElementById(gs.ActiveRow));
	igtbl_fireEvent(gn,gs.Events.AfterExitEditMode,"(\""+gn+"\",\""+cell.id+"\");");
	if(changed)
	{
		igtbl_fireEvent(gn,gs.Events.AfterCellUpdate,"(\""+gn+"\",\""+cell.id+"\");");
		if(gs.NeedPostBack)
			igtbl_doPostBack(gn);
	}
}

function igtbl_getOffsetX(evnt,e)
{
	return evnt.clientX-igtbl_getLeftPos(e);
}

function igtbl_getOffsetY(evnt,e)
{
	return evnt.clientY-igtbl_getTopPos(e);
}

function igtbl_onResize(gn)
{
}

function igtbl_isDisabled(elem)
{
	return elem.getAttribute("disabled") && elem.getAttribute("disabled").toString()=="true";
}

function igtbl_setDisabled(elem,b)
{
	elem.setAttribute("disabled",b);
}

function igtbl_activate(gn)
{
}
