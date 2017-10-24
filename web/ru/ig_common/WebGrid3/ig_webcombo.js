/* 
Infragistics Web Combo Script 
Version 3.0.20041.11
Copyright (c) 2001-2004 Infragistics, Inc. All Rights Reserved.
*/

var igcmbo_displaying;
var igcmbo_currentDropped;

// private - hides all dropdown select controls for the document.
var igcmbo_hidden=false;
function igcmbo_hideDropDowns(bHide) { 
	 if(igcmbo_dropDowns == null)
		return;
     if(bHide)
     {
		if(igcmbo_hidden)
			return;
		igcmbo_hidden = true;
         for (i=0; i<igcmbo_dropDowns.length;i++)
              igcmbo_dropDowns[i].style.visibility='hidden';
     }
     else
     {
         for (i=0; i<igcmbo_dropDowns.length;i++)
         {
              igcmbo_dropDowns[i].style.visibility='visible';
         }
         igcmbo_hidden = false;
     }
}

var wccounter=0;
function igcmbo_onmousedown(evnt,id) {
	var src = igcmbo_srcElement(evnt);
	if(src.id == id + "_input")
		return;
	ig_inCombo = true;
	var oCombo = igcmbo_getComboById(id);
	if(!oCombo || !oCombo.Loaded) 
		return;
	oCombo.Element.setAttribute("noOnBlur",true);
	if(igcmbo_currentDropped != null && igcmbo_currentDropped != oCombo)
		igcmbo_currentDropped.setDropDown(false);
	if(oCombo.getDropDown() == true) {
		oCombo.setDropDown(false);
		igcmboObject = oCombo;
		if(document.all)
			setTimeout('igcmbo_focusEdit()', 10);
	}
	else {
		igcmbo_swapImage(oCombo, 2);
		oCombo.setDropDown(true);
	}
	window.setTimeout("igtbl_cancelNoOnBlurDD()",100);
}

var igcmboObject = null;
function igcmbo_focusEdit() {
	igcmboObject.setFocusTop();

}

function igcmbo_onmouseup(evnt,id) {
	var oCombo = igcmbo_getComboById(id);
	if(!oCombo || !oCombo.Loaded) 
		return;
	if(oCombo.Dropped == true) {
		igcmbo_swapImage(oCombo, 1);
	}
	else {
	}
}

function igcmbo_onmouseout(evnt,id) {
	var oCombo = igcmbo_getComboById(id);
	if(!oCombo || !oCombo.Loaded) 
		return;
	if(oCombo.Dropped == true) {
		igcmbo_swapImage(oCombo, 1);
	}
	else {
	}
}

function igcmbo_swapImage(combo, imageNo) {
	var img = igcmbo_getElementById(combo.ClientUniqueId + "_img");
	if(imageNo == 1)
		img.src = combo.DropImage1;
	else
		img.src = combo.DropImage2;
}

function igcmbo_ondblclick(evnt,id) {
	var oCombo = igcmbo_getComboById(id);
	if(!oCombo || !oCombo.Loaded) 
		return;
	if(oCombo.getDropDown() == true) {
		oCombo.setDropDown(false);
	}
}


function igcmbo_onKeyDown(evnt) {
	if(evnt.keyCode == 40) { // down arrow
	}
}

// public - Retrieves the server-side unique id of the combo
function igcmbo_getUniqueId(comboName) {
	var combo = igcmbo_comboState[comboName];
	if(combo != null)
		return combo.UniqueId;
	return null;
}
function igcmbo_getElementById(id) {
        if(document.all)
			return document.all[id];
        else 
			return document.getElementById(id);
}

// public - returns the combo object for the Item Id
function igcmbo_getComboById(itemId) {
	var id = igcmbo_comboIdById(itemId);  
	return igcmbo_comboState[id];
}

// public - returns the combo object from an Item element
function igcmbo_getComboByItem(item) {
	var id = igcmbo_comboIdById(item.id);  
	return igcmbo_comboState[id];
}

// public - returns the combo Name from an itemId
function igcmbo_comboIdById(itemId) {
   var comboName = itemId;
   var strArray = comboName.split("_");
   return strArray[0];
}

function igcmbo_getLeftPos(e) {
	x = e.offsetLeft;
	if(e.style.position=="absolute")
		return x;
	tmpE = e.offsetParent;
	while (tmpE != null) {
		if((tmpE.style.position!="relative") && (tmpE.style.position!="absolute"))
			x += tmpE.offsetLeft;
		tmpE = tmpE.offsetParent;
	}
	return x;
}

function igcmbo_getTopPos(e) {
	y = e.offsetTop;
	if(e.style.position=="absolute")
		return y;
	tmpE = e.offsetParent;
	while (tmpE != null) {
		if((tmpE.style.position!="relative") && (tmpE.style.position!="absolute"))
			y += tmpE.offsetTop;
		tmpE = tmpE.offsetParent;
	}
	return y;
}

// Warning: Private functions for internal component usage only
// The functions in this section are not intended for general use and are not supported
// or documented.


// private - Fires an event to client-side script and then to the server is necessary
function igcmbo_fireEvent(id,eventObj,eventString)
{
	var oCombo=igcmbo_comboState[id];
	var result=false;
	if(eventObj[0]!="")
		result=eval(eventObj[0]+eventString);
	if(oCombo.Loaded && result!=true && eventObj[1]==1 && !oCombo.CancelPostBack)
		oCombo.NeedPostBack = true;
	oCombo.CancelPostBack=false;
	return result;
}

// private - Performed on page initialization
var igcmbo_initialized=false;
function igcmbo_initialize() 
{
	if(!igcmbo_initialized)
	{
		if(typeof(ig_csom)=="undefined" || ig_csom==null)
			return;
		ig_csom.addEventListener(document, "mousedown", igcmbo_mouseDown, false);
		ig_csom.addEventListener(document, "mouseup", igcmbo_mouseUp, false);

		igcmbo_initialized=true;
		ig_currentCombo = null;
	}
}

var igcmbo_comboState=[];
var igcmbo_dropDowns;

// private - initializes the combo object on the client
function igcmbo_initCombo(comboId) {

   var comboElement = igcmbo_getElementById(comboId+"_Main");
   var oCombo = new igcmbo_combo(comboElement,eval("igcmbo_"+comboId+"_Props"));
   igcmbo_comboState[comboId] = oCombo;
   igcmbo_fireEvent(comboId,oCombo.Events.InitializeCombo,"(\""+comboId+"\");");
   if(document.all != null && oCombo.HideDropDowns==true && igcmbo_dropDowns==null) {
		igcmbo_dropDowns = document.all.tags("SELECT");
   }
   oCombo.Loaded = true;
   return oCombo;
}

// private - constructor for the combo object
function igcmbo_combo(comboElement,comboProps) 
{
	igcmbo_initialize();

	this.Id=comboElement.id;
	this.Element=comboElement;
	this.Type="WebCombo";
	this.UniqueId=comboProps[0];
	this.DropDownId=comboProps[1];
	this.DropDownId=this.DropDownId.replace(":", "");
	this.DropDownId=this.DropDownId.replace("_", "x")+ "_main";
	this.DropImage1=comboProps[2];
	this.DropImage2=comboProps[3];
	this.ForeColor=comboProps[9];
	this.BackColor=comboProps[10];
	this.SelForeColor=comboProps[11];
	this.SelBackColor=comboProps[12];
	this.DataTextField=comboProps[13];
	this.DataValueField=comboProps[15];
	this.HideDropDowns=comboProps[17];
	this.Editable=comboProps[18];
	this.ClassName=comboProps[19];
	this.Prompt=comboProps[20];
    
   	var uniqueId = igcmbo_getClientUniqueId(this.UniqueId);
	this.ClientUniqueId = uniqueId;
    
	this.Events= new igcmbo_events(eval("igcmbo_"+uniqueId+"_Events"));
	this.ExpandEffects = new igcmbo_expandEffects(comboProps[4], comboProps[5], comboProps[6], comboProps[7], comboProps[8], comboProps[9]);

	this.Loaded=false;
	this.Dropped = false;
	this.NeedPostBack=false;
	this.CancelPostBack=false;
	this.TopHoverStarted=false;
	
	this.getDropDown = igcmbo_getDropDown;
	this.setDropDown = igcmbo_setDropDown;
	this.getDisplayValue = igcmbo_getDisplayValue;
	this.setDisplayValue = igcmbo_setDisplayValue;
	this.getDataValue = igcmbo_getDataValue;
	this.setDataValue = igcmbo_setDataValue;
	this.setWidth = igcmbo_setWidth;
	this.getWidth = igcmbo_getWidth;
	this.getSelectedIndex = igcmbo_getSelectedIndex;
	this.setSelectedIndex = igcmbo_setSelectedIndex;
	this.selectedIndex = comboProps[21];
	this.setFocusTop = igcmbo_setFocusTop;
	this.updateValue = igcmbo_updateValue;
	this.updatePostField = igcmbo_updatePostField;
	this.setSelectedRow = igcmbo_setSelectedRow;
	this.grid = grid;
	var grid = igtbl_getElementById(this.ClientUniqueId + "xGrid");
	if(grid!=null)
		grid.setAttribute("igComboId", this.ClientUniqueId);
	grid = igtbl_getGridById(this.ClientUniqueId + "xGrid");
	this.grid = grid;
	this.getGrid = igcmbo_getGrid;
	var innerctl;
	if(this.Editable) 
	{
		innerctl = igcmbo_getElementById(this.ClientUniqueId + "_input");
		this.displayValue = innerctl.value;
	}
	else 
	{
		innerctl = igcmbo_getElementById(this.ClientUniqueId + "_value");
		this.displayValue = innerctl.innerHTML;
	}
	this.setWidth(this.Element.offsetWidth);
	
	// begin - editor control support
	igcmbo_getElementById(this.UniqueId).Object=this;
	this.getVisible = igcmbo_getVisible;
	this.setVisible = igcmbo_setVisible;
	this.getValue = igcmbo_getValue;
	this.setValue = igcmbo_setValue;
	this.eventHandlers=new Object();
	this.addEventListener=igcmbo_addEventListener;
	this.removeEventListener=igcmbo_removeEventListener;
	// end - editor control support
}

// public - sets the width of the WebCombo to the passed in value
function igcmbo_setWidth(width) {
	var innerctl;
	if(width==0)
		return;
	var border = 6;
	if(document.all)
		border = this.Element.offsetWidth - this.Element.clientWidth;
	var image = igcmbo_getElementById(this.ClientUniqueId + "_img");
	if(this.Editable) 
		innerctl = igcmbo_getElementById(this.ClientUniqueId + "_input");
	else 
		innerctl = igcmbo_getElementById(this.ClientUniqueId + "_value");
	innerctl.style.width =  width - image.offsetWidth - border;
	this.Element.style.width = width;
}

// public - returns the CSS width of the combo element.
function igcmbo_getWidth() {
	return this.Element.style.width
}

// private - event initialization for menu object
function igcmbo_expandEffects(duration, opacity, type, shadowColor, shadowWidth, delay)
{
	this.Duration=duration;
	this.Opacity=opacity;
	this.Type=type;
	this.ShadowColor=shadowColor;
	this.ShadowWidth=shadowWidth;
	this.Delay=delay;
}

// private - event initialization for combo object
function igcmbo_getDropDown()
{
	return this.Dropped;
}

// private - event initialization for combo object
function igcmbo_setDropDown(bDrop)
{
	if(this.Element.style.display=="none")
		return;
	if(bDrop == true) {
		if(this.Dropped == true)
			return;
		var grid = igcmbo_getElementById(this.ClientUniqueId + "_container");
		var type=this.ExpandEffects.Type;
		var duration=this.ExpandEffects.Duration;
		duration = duration/1000;
		var shadowWidth=this.ExpandEffects.ShadowWidth;
		var opacity=this.ExpandEffects.Opacity;
		var shadowColor=this.ExpandEffects.ShadowColor;
		
		grid.style.top = igcmbo_getTopPos(this.Element) + this.Element.offsetHeight;
		grid.style.left = igcmbo_getLeftPos(this.Element);
 		if(igcmbo_fireEvent(this.ClientUniqueId,this.Events.BeforeDropDown,"(\""+this.ClientUniqueId+"\");")) {
 			return;
		}
		if(document.all) {
			if(this.HideDropDowns)
				igcmbo_hideDropDowns(true);

			if(type != 'NotSet')
				grid.style.filter = "progid:DXImageTransform.Microsoft."+type+"(duration="+duration+");"
			if(shadowWidth > 0) {
				var s = " progid:DXImageTransform.Microsoft.Shadow(Direction=135, Strength="+shadowWidth+",color='"+shadowColor+"')";
				grid.style.filter += s;
			}
			if(opacity < 100)
				grid.style.filter += " progid:DXImageTransform.Microsoft.Alpha(Opacity="+opacity+");"
			if(grid.filters[0] != null)
	       		grid.filters[0].apply();
			grid.style.visibility = 'visible'; 
			grid.style.display = ""; 
			if(grid.filters[0] != null)
				grid.filters[0].play();
		}
		else {
			grid.style.visibility = 'visible'; 
			grid.style.display = ""; 
		}
				
		var dropdowngrid = igcmbo_getElementById(this.ClientUniqueId + "xGrid_main");
		if(document.all && dropdowngrid != null) {
			if(this.webGrid)
				this.webGrid.Element.setAttribute("noOnResize",true);
			igtbl_activate(this.ClientUniqueId + "xGrid");
			if(this.webGrid)
				this.webGrid.Element.removeAttribute("noOnResize");
		}
		this.Element.style.backgroundColor='white';
		this.Dropped = true;
		if(this.grid.getActiveRow())
			igtbl_scrollToView(this.grid.Id,this.grid.getActiveRow().Element);
		igcmbo_currentDropped = this;
 		igcmbo_fireEvent(this.ClientUniqueId,this.Events.AfterDropDown,"(\""+this.ClientUniqueId+"\");");
 		this._internalDrop = true;
 		setTimeout(igcmbo_clearInternalDrop, 100);
	}
	else {
		if(this.Dropped == false)
			return;
		var grid = igcmbo_getElementById(this.ClientUniqueId + "_container");
 		if(igcmbo_fireEvent(this.ClientUniqueId,this.Events.BeforeCloseUp,"(\""+this.ClientUniqueId+"\");")) {
 			return;
		}
		if(this.webGrid)
			this.webGrid.Element.setAttribute("noOnResize",true);
		grid.style.visibility = 'hidden'; 
		grid.style.display = "none"; 
		this.Dropped = false;
		igcmbo_hideDropDowns(false);

		if(this.Editable == true) {
			var inputbox = igcmbo_getElementById(this.ClientUniqueId + "_input");
		}
		else {
			var valuebox = igcmbo_getElementById(this.ClientUniqueId + "_value");
		}
		igcmbo_currentDropped = null;
 		igcmbo_fireEvent(this.ClientUniqueId,this.Events.AfterCloseUp,"(\""+this.ClientUniqueId+"\");");
		if(this.webGrid)
		{
			igcmbo_wgNoResize=this.webGrid;
	 		setTimeout(igcmbo_clearnoOnResize, 100);
		}
	}
}
function igcmbo_clearInternalDrop() {
	if(igcmbo_currentDropped)
		igcmbo_currentDropped._internalDrop = null;
}
var igcmbo_wgNoResize=null;
function igcmbo_clearnoOnResize() {
	if(igcmbo_wgNoResize)
	{
		igcmbo_wgNoResize.Element.removeAttribute("noOnResize");
		igcmbo_wgNoResize=null;
	}
}

function igcmbo_editkeydown(evnt,comboId) {
	var oCombo = igcmbo_getComboById(comboId);
	if(oCombo && oCombo.Loaded) {
		var keyCode = (evnt.keyCode);
		var newValue = igcmbo_srcElement(evnt).value;
    	if(igcmbo_fireEvent(oCombo.ClientUniqueId,oCombo.Events.EditKeyDown,"('"+oCombo.ClientUniqueId+"','"+newValue+"',"+keyCode+");"))
    		return igtbl_cancelEvent(evnt);
		if(oCombo.eventHandlers["keydown"] && oCombo.eventHandlers["keydown"].length>0)
		{
			var ig_event=new ig_EventObject();
			ig_event.event=evnt;
			for(var i=0;i<oCombo.eventHandlers["keydown"].length;i++)
				if(oCombo.eventHandlers["keydown"][i].fListener)
				{
					oCombo.eventHandlers["keydown"][i].fListener(oCombo,ig_event,oCombo.eventHandlers["keydown"][i].oThis);
					if(ig_event.cancel)
						return igtbl_cancelEvent(evnt);
				}
		}
		oCombo.updatePostField(newValue);
		oCombo.displayValue = newValue;
	}
}

function igcmbo_editkeyup(evnt,comboId) {
	var oCombo = igcmbo_getComboById(comboId);
	if(oCombo && oCombo.Loaded) {
		var keyCode = (evnt.keyCode);
		var newValue = igcmbo_srcElement(evnt).value;
    	if(igcmbo_fireEvent(oCombo.ClientUniqueId,oCombo.Events.EditKeyUp,"(\""+oCombo.ClientUniqueId+"\",\""+newValue+"\","+keyCode+");"))
    		return igtbl_cancelEvent(evnt);
		oCombo.updatePostField(newValue);
		oCombo.displayValue = newValue;
	}
}

function igcmbo_keydown(evnt,comboId) {
	var oCombo = igcmbo_getComboById(comboId);
	if(oCombo && oCombo.Loaded) {
		var oGrid = igtbl_getGridById(oCombo.ClientUniqueId + "xGrid");
		if(oGrid == null)
			return;
		var column = null;
		if(oCombo.DataTextField.length > 0) {
			column = oGrid.Bands[0].getColumnFromKey(oCombo.DataTextField)
		}
		else {
			var colNo = 0;
			column = oGrid.Bands[0].Columns[colNo];
		}
		if(column == null)
			return;
		
		if(oCombo.eventHandlers["keydown"] && oCombo.eventHandlers["keydown"].length>0)
		{
			var ig_event=new ig_EventObject();
			ig_event.event=evnt;
			for(var i=0;i<oCombo.eventHandlers["keydown"].length;i++)
				if(oCombo.eventHandlers["keydown"][i].fListener)
				{
					oCombo.eventHandlers["keydown"][i].fListener(oCombo,ig_event,oCombo.eventHandlers["keydown"][i].oThis);
					if(ig_event.cancel)
						return igtbl_cancelEvent(evnt);
				}
		}
		
		var lastKey = oCombo.lastKey;
		var text;
		var cell;
		var oRow
		var s = String.fromCharCode(evnt.keyCode);
		switch(evnt.keyCode) {
			case 40 :
				oRow = oGrid.getActiveRow();
				if(oRow != null) {
					oRow.setSelected(false);
					var oRow = oRow.getNextRow();
					if(oRow != null) {
						oGrid.setActiveRow(oRow);
						oGrid.clearSelectionAll();
						oRow.setSelected(true);
						oCombo.selectedIndex = oRow.getIndex();
						cell = oRow.getCell(column.Index);
						text = cell.getValue(true);
						oCombo.updateValue(text, true);
						if(oCombo.DataValueField)
							oCombo.dataValue=oRow.getCellFromKey(oCombo.DataValueField).getValue();
						igtbl_updatePostField(oGrid.Id);
					}
				}
				return;
				break;
			case 38 :
				oRow = oGrid.getActiveRow();
				if(oRow != null) {
					oRow.setSelected(false);
					var oRow = oRow.getPrevRow();
					if(oRow != null) {
						oGrid.setActiveRow(oRow);
						oGrid.clearSelectionAll();
						oRow.setSelected(true);
						oCombo.selectedIndex = oRow.getIndex();
						cell = oRow.getCell(column.Index);
						text = cell.getValue(true);
						oCombo.updateValue(text, true);
						if(oCombo.DataValueField)
							oCombo.dataValue=oRow.getCellFromKey(oCombo.DataValueField).getValue();
						igtbl_updatePostField(oGrid.Id);
					}
				}
				return;
				break;
		}
		var charFromCode=String.fromCharCode(evnt.keyCode);
		if(charFromCode && evnt.keyCode>=48)
		{
			var re = new RegExp("^" + igtbl_getRegExpSafe(charFromCode), "gi");
			if(lastKey != evnt.keyCode) {
				cell = column.find(re);
			}
			else 
			if(cell == null) {
				cell = column.findNext();
				if(cell == null) {
					cell = column.find(re);
				}
			}
			oCombo.lastKey = evnt.keyCode;
			if(cell != null) {
				text = cell.getValue(true);
				var oRow = oGrid.getActiveRow();
				oGrid.clearSelectionAll();
				if(oRow)
					oRow.setSelected(false);
				oRow = cell.getRow();
				oGrid.setActiveRow(oRow);
				oRow.setSelected(true);
				oCombo.selectedIndex = oRow.getIndex();
				oCombo.updateValue(text, true);
				if(oCombo.DataValueField)
					oCombo.dataValue=oRow.getCellFromKey(oCombo.DataValueField).getValue();
				igtbl_updatePostField(oGrid.Id);
			}
		}
	}
}

function igcmbo_onfocus(evnt,comboId) {
	var oCombo = igcmbo_getComboById(comboId);
	if(!oCombo)
		return;
	oCombo.setFocusTop();
}

function igcmbo_onblur(evnt,comboId) {
	var oCombo = igcmbo_getComboById(comboId);
	if(!oCombo || !oCombo.Loaded || oCombo!=igcmbo_displaying) 
		return;
	if (document.all && oCombo.Element.contains(evnt.toElement)) {
		if(this.Editable == true) {
			var inputbox = igcmbo_getElementById(oCombo.ClientUniqueId + "_input");
		}
		else {
			var valuebox = igcmbo_getElementById(oCombo.ClientUniqueId + "_value");
			valuebox.style.backgroundColor=oCombo.BackColor;
			valuebox.style.color=oCombo.ForeColor;
			valuebox.style.borderStyle='none';
			if(oCombo.ClassName != null)
				valuebox.className = oCombo.ClassName;
		}
    }
    else {
		if(oCombo.Editable == true) {
			var inputbox = igcmbo_getElementById(oCombo.ClientUniqueId + "_input");
		}
		else {
			var valuebox = igcmbo_getElementById(oCombo.ClientUniqueId + "_value");
			valuebox.style.backgroundColor=oCombo.BackColor;
			valuebox.style.color=oCombo.ForeColor;
			valuebox.style.borderStyle='none';
			if(oCombo.ClassName!= null)
				valuebox.className = oCombo.ClassName;
		}
		if(oCombo.webGrid != null) {
			var container = igcmbo_getElementById(oCombo.ClientUniqueId + "_container");
			if(oCombo._internalDrop || oCombo.Element.getAttribute("noOnBlur"))
				return;
			if(oCombo.eventHandlers["blur"] && oCombo.eventHandlers["blur"].length>0)
			{
				var ig_event=new ig_EventObject();
				ig_event.event=evnt;
				for(var i=0;i<oCombo.eventHandlers["blur"].length;i++)
					if(oCombo.eventHandlers["blur"][i].fListener)
					{
						oCombo.eventHandlers["blur"][i].fListener(oCombo,ig_event,oCombo.eventHandlers["blur"][i].oThis);
						if(ig_event.cancel)
							return igtbl_cancelEvent(evnt);
					}
			}
		}
    }
}
function igcmbo_setFocusTop() {
	if(this.Editable == true) {
		var inputbox = igcmbo_getElementById(this.ClientUniqueId + "_input");
		inputbox.select();
		if(document.all)
			inputbox.focus();
	}
	else {
		var valuebox = igcmbo_getElementById(this.ClientUniqueId + "_value");
		valuebox.style.backgroundColor=this.SelBackColor;
		valuebox.style.borderStyle='solid';
		valuebox.style.borderWidth=1;
		valuebox.style.color=this.SelForeColor;
		if(!document.all)
			return;
		valuebox.focus();
	}
}

// private - event initialization for combo object
function igcmbo_events(events)
{
	this.InitializeCombo=events[0];
	this.EditKeyDown=events[1];
	this.EditKeyUp=events[2];
	this.BeforeDropDown=events[3];
	this.AfterDropDown=events[4];
	this.BeforeCloseUp=events[5];
	this.AfterCloseUp=events[6];
	this.BeforeSelectChange=events[7];
	this.AfterSelectChange=events[8];
}

function igcmbo_gridmouseover(gridName, itemId) {
	var grid = igtbl_getGridById(gridName);
	var cell = igtbl_getCellById(itemId);
	if(cell == null)
		return;
	igtbl_clearSelectionAll(gridName);
	igtbl_selectRow(gridName,cell.Row.Element.id);
}

function igcmbo_gridkeydown(gridName, itemId, keyCode) {
	igtbl_clearSelectionAll(gridName);
	var oCombo = igcmbo_currentDropped;
	if(keyCode == 27 || keyCode == 10) {
		oCombo.setDropDown(false);
		oCombo.setFocusTop();
	}
}

function igcmbo_gridrowactivate(gridName, itemId) {
	var oCombo = igcmbo_currentDropped;
	var row = igtbl_getRowById(itemId);
	if(oCombo == null || row == null)
		return;
	if(oCombo.DataTextField.length > 0) {
		cell = row.getCellFromKey(oCombo.DataTextField);
	}
	else
		cell = row.getCell(0);
	if(cell != null) {
		var v = cell.getValue(true);
		oCombo.selectedIndex = row.getIndex();
		oCombo.updateValue(v, true);
	}
}

function igcmbo_setSelectedRow(row) {
	var cell = null;
	if(this.DataValueField.length > 0) 
	{
		cell = row.getCellFromKey(this.DataValueField);
		this.setDataValue(cell.getValue(), false);
		if(this.Element.style.display!="none")
			this.setFocusTop();
	}
}

function igcmbo_gridmouseup(gridName, itemId) {
	var grid = igtbl_getGridById(gridName);
	var row = igtbl_getRowById(itemId);
	if(row == null)
		return;
	var cell = igtbl_getCellById(itemId);
	if(cell == null)
		return;

	var oCombo = igcmbo_currentDropped;
	if(oCombo != null) {
		oCombo.setSelectedRow(row);
		oCombo.setDropDown(false);
	}
}

function igcmbo_getSelectedIndex() {
	return this.selectedIndex;
}

function igcmbo_setSelectedIndex(index)
{
	if(index>=0 && index<this.grid.Rows.length)
		this.setSelectedRow(this.grid.Rows.getRow(index));
}

function igcmbo_getVisible() {
	if(this.Element.style.display == "none" || this.Element.style.visibility == "hidden")
		return false;
	else
		return true;
}

function igcmbo_setVisible(bVisible,left,top,width,height)
{
	if(bVisible)
	{
		this.Element.style.display = "";
		this.Element.style.visibility = "visible";
		igcmbo_displaying=this;
		if(arguments.length>=3)
		{
			this.Element.style.top=top;
			this.Element.style.left=left;
		}
		if(arguments.length>=5)
		{
			this.Element.style.height=height;
			this.setWidth(width);
		}
		if(this.Element.focus)
			this.Element.focus();
	}
	else
	{
		if(this.Dropped)
			this.setDropDown(false);
		this.Element.style.display = "none";
		this.Element.style.visibility = "hidden";
		igcmbo_displaying=null;
	}
}

function igcmbo_getDisplayValue()
{
	return this.displayValue;
}

function igcmbo_getDataValue()
{
	return this.dataValue;
}

function igcmbo_setDisplayValue(newValue, bFireEvent)
{
	this.updateValue(newValue, bFireEvent);
	var re = new RegExp("^"+igtbl_getRegExpSafe(newValue)+"$", "gi");
	var column = null;
	if(this.DataTextField.length > 0) {
		column = this.grid.Bands[0].getColumnFromKey(this.DataTextField)
	}
	else {
		var colNo = 0;
		column = this.grid.Bands[0].Columns[colNo];
	}
	if(column == null)
		return;
	cell = column.find(re);
	if(cell != null) {
		if(this.DataValueField)
			this.dataValue=cell.Row.getCellFromKey(this.DataValueField).getValue();
		igtbl_clearSelectionAll(this.grid.Id);
		this.grid.setActiveRow(cell.Row);
		cell.Row.setSelected(true);
		this.selectedIndex = cell.Row.getIndex();
		igtbl_updatePostField(this.grid.Id);
		this.updatePostField(newValue,false);
	}
	else
	{
		this.dataValue=null;
		igtbl_clearSelectionAll(this.grid.Id);
		this.grid.setActiveRow(null);
		this.selectedIndex = -1;
		igtbl_updatePostField(this.grid.Id);
		this.updatePostField(newValue,false);
	}
	return this.selectedIndex;
}

function igcmbo_setDataValue(newValue, bFireEvent)
{
	this.dataValue=newValue;
	var re = new RegExp("^"+igtbl_getRegExpSafe(newValue)+"$", "gi");
	var column = null;
	if(this.DataTextField.length > 0)
		column = this.grid.Bands[0].getColumnFromKey(this.DataValueField)
	else
		column = this.grid.Bands[0].Columns[0];
	if(column == null)
		return;
	cell = column.find(re);
	if(cell != null)
	{
		if(this.DataTextField)
			this.updateValue(cell.Row.getCellFromKey(this.DataTextField).getValue(),bFireEvent);
		igtbl_clearSelectionAll(this.grid.Id);
		this.grid.setActiveRow(cell.Row);
		cell.Row.setSelected(true);
		this.selectedIndex = cell.Row.getIndex();
		igtbl_updatePostField(this.grid.Id);
		this.updatePostField(newValue,false);
	}
	else
	{
		this.dataValue=null;
		igtbl_clearSelectionAll(this.grid.Id);
		if(this.Prompt)
		{
			var row=this.grid.Rows.getRow(0);
			row.activate();
			row.setSelected();
			if(this.DataTextField && !this.Editable)
			{
				var valuebox = igcmbo_getElementById(this.ClientUniqueId + "_value");
				valuebox.innerHTML = row.getCellFromKey(this.DataTextField).getValue();
			}
		}
		else
		{
			this.grid.setActiveRow(null);
			this.selectedIndex = -1;
			igtbl_updatePostField(this.grid.Id);
			this.updatePostField(newValue,false);
		}
	}
	return this.selectedIndex;
}

function igcmbo_getValue()
{
	if(!this.Prompt || this.getSelectedIndex()>0)
		return this.dataValue;
}

function igcmbo_setValue(newValue, bFireEvent)
{
	var re = new RegExp("^" + igtbl_getRegExpSafe(newValue), "gi");
	var column = null;
	if(this.DataValueField.length > 0)
		column = this.grid.Bands[0].getColumnFromKey(this.DataValueField)
	else
		column = this.grid.Bands[0].Columns[0];
	if(column == null)
		return;
	cell = column.find(re);
	var dispValue=this.Prompt;
	if(cell != null)
	{
		this.dataValue=newValue;
		if(this.DataTextField)
		{
			dispValue=cell.Row.getCellFromKey(this.DataTextField).getValue(true);
			this.updateValue(dispValue, (typeof(bFireEvent)=="undefined" || bFireEvent));
		}
		igtbl_clearSelectionAll(this.grid.Id);
		this.grid.setActiveRow(cell.Row);
		cell.Row.setSelected(true);
		this.selectedIndex = cell.Row.getIndex();
	}
	else
	{
		this.dataValue=null;
		igtbl_clearSelectionAll(this.grid.Id);
		this.grid.setActiveRow(null);
		this.selectedIndex = -1;
	}
	igtbl_updatePostField(this.grid.Id);
	this.updatePostField(dispValue,false);
	if(this.Prompt && this.selectedIndex==-1)
	{
		this.setSelectedIndex(0);
		return -1;
	}
	return this.selectedIndex;
}

function igcmbo_updateValue(newValue, bFireEvent) {
	if(bFireEvent == true) {
    	if(igcmbo_fireEvent(this.ClientUniqueId,this.Events.BeforeSelectChange,"(\""+this.ClientUniqueId+"\");")) {
	    	return false;
	    }
	}
	if(this.Editable == true) {
		var inputbox = igcmbo_getElementById(this.ClientUniqueId + "_input");
		inputbox.value = newValue;
	}
	else {
		var valuebox = igcmbo_getElementById(this.ClientUniqueId + "_value");
		valuebox.innerHTML = newValue;
	}
	this.updatePostField(newValue);
	this.displayValue = newValue;
	if(bFireEvent == true) {
		if(igcmbo_fireEvent(this.ClientUniqueId,this.Events.AfterSelectChange,"(\""+this.ClientUniqueId+"\");"))
			return;
	}
	if(this.NeedPostBack && bFireEvent == true) {
		__doPostBack(this.UniqueId,'AfterSelChange\x02'+this.selectedIndex);
	}
	
}

var ig_inCombo=false;
// private - Handles the mouse down event
function igcmbo_mouseDown(evnt) {
	if(igcmbo_currentDropped == null)
		return;
		
	var grid = igcmbo_getElementById(igcmbo_currentDropped.ClientUniqueId + "_container");
	var elem = igtbl_srcElement(evnt);
	var parent = elem;
	while(true) {
		if(parent == null)
			break;
		if(parent == grid)
			return;
		parent = parent.parentNode;
	}
		
	if(ig_inCombo == true) {
		ig_inCombo = false;
		return;		
	}

	if(igcmbo_currentDropped.eventHandlers["blur"] && igcmbo_currentDropped.eventHandlers["blur"].length>0)
	{
		var ig_event=new ig_EventObject();
		ig_event.event=evnt;
		for(var i=0;igcmbo_currentDropped && i<igcmbo_currentDropped.eventHandlers["blur"].length;i++)
			if(igcmbo_currentDropped.eventHandlers["blur"][i].fListener)
			{
				igcmbo_currentDropped.eventHandlers["blur"][i].fListener(igcmbo_currentDropped,ig_event,igcmbo_currentDropped.eventHandlers["blur"][i].oThis);
				if(ig_event.cancel)
					return igtbl_cancelEvent(evnt);
			}
	}
	if(igcmbo_currentDropped)
		igcmbo_currentDropped.setDropDown(false);
	ig_inCombo = false;
}

// private - Handles the mouse up event
function igcmbo_mouseUp(evnt) {
	return;
}

// private - Obtains the proper source element in relation to an event
function igcmbo_srcElement(evnt)
{
	var se
	if(evnt.target)
		se=evnt.target;
	else if(evnt.srcElement)
		se=evnt.srcElement;
	return se;
}

// private - Updates the PostBackData field
function igcmbo_updatePostField(value)
{
	var formControl = igcmbo_getElementById(this.UniqueId);
	if(!formControl)
		return;
	var index = this.selectedIndex;
	formControl.value = "Select\x02" + index + "\x02Value\x02" + value;
}

// private
function igcmbo_getClientUniqueId(uniqueId) {
	var u = uniqueId.replace(/:/gi, "");
	u = u.replace(/_/gi, "x");
	return u;
}
// private
function igcmbo_getGrid() {
	return this.grid;
}

function igcmbo_addEventListener(eventName,fListener,oThis)
{
	eventName=eventName.toLowerCase();
	if(!this.eventHandlers[eventName])
		this.eventHandlers[eventName]=new Array();
	var index=this.eventHandlers[eventName].length;
	if(index>=15)
		return false;
	for(var i=0;i<this.eventHandlers[eventName].length;i++)
		if(this.eventHandlers[eventName][i]["fListener"]==fListener)
			return false;
	this.eventHandlers[eventName][index]=new Object();
	this.eventHandlers[eventName][index]["fListener"]=fListener;
	this.eventHandlers[eventName][index]["oThis"]=oThis;
	return true;
}

function igcmbo_removeEventListener(eventName,fListener)
{
	if(!this.eventHandlers)
		return false;
	var eventName=eventName.toLowerCase();
	if(!this.eventHandlers[eventName] || this.eventHandlers[eventName].length==0)
		return false;
	for(var i=0;i<this.eventHandlers[eventName].length;i++)
		if(this.eventHandlers[eventName][i]["fListener"]==fListener)
		{
			delete this.eventHandlers[eventName][i]["fListener"];
			delete this.eventHandlers[eventName][i]["oThis"];
			delete this.eventHandlers[eventName][i];
			if(this.eventHandlers[eventName].pop)
				this.eventHandlers[eventName].pop();
			else
				this.eventHandlers[eventName]=this.eventHandlers[eventName].slice(0,-1);
			return true;
		}
	return false;
}

igcmbo_initialize();
