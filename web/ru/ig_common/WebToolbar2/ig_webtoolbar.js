/* 
Infragistics Toolbar Script 
Version 2.1.20041.11
Copyright (c) 2003-2004 Infragistics, Inc. All Rights Reserved.
*/
var CurrentX;
var CurrentY;
var NewX;
var NewY;
var DistanceX;
var DistanceY;
var AllowMove=0;
var ToolbarSource;
var igtbar_positionZ=100;

var ig_dom;
var ig_IE;
var igtbr_state=[];

function igtbar_initialize(tbName)
{
	var propArray=eval("igtbar_"+tbName+"_Props");
	this.Id=tbName;
	this.Element=ig.getElementById(tbName);
	this.OnTop=propArray[0];
	this.Enabled=propArray[1];
	this.PostBackButton=propArray[2];
	this.PostBackGroup=propArray[3];
	var itemsArray=eval("igtbar_"+tbName+"_Items");
	this.Items=new Array();
	this.Items.fromKey = function (key) {
		for(i=0; i<this.length; i++) {
			if(this[i].Key == key)
				return this[i];
		}
		return null;
	}
	for(var i=0;i<itemsArray.length;i++)
	{
		var item=new igtbar_initItem(this,itemsArray[i],i);
		this.Items[i]=item;
		var id = tbName+"_Item_"+i;
		
		var e = ig.getElementById(id);
		if(e!=null) {
			item.Element=e;
		}
		item.Id=id;
	}
	
	this.ClientSideEvents=new igtbar_initEvents(eval("igtbar_"+tbName+"_Events"));
	
	var eventObj=new ig_EventObject();
	ig_fireEvent(this,this.ClientSideEvents.InitializeToolbar,eventObj);
	delete eventObj;
	igtbr_state[tbName] = this;
}

function igtbar_initItem(tb,item,index)
{
	this.Toolbar=tb;
	if(item[0]==0) // Toolbar Button
	{
		this.Type=item[0];
		this.Selected=item[1];
		this.Enabled=item[2];
		this.ToggleButton=item[3];
		this.DefaultStyleClassName=item[4];
		this.HoverStyleClassName=item[5];
		this.SelectedStyleClassName=item[6];
		this.DefaultImage=item[7];
		this.HoverImage=item[8];
		this.SelectedImage=item[9];
		this.DisabledImage=item[10]
		this.AutoPostBack=item[11];
		this.Key=item[12];
		this.Tag=item[13];
		this.IsGroupButton=false;
		this.getText=function(){
			var e = igtbar_getTextElem(this.Element);
			if(e!=null)
				return ig.getText(e);
			else 
				return null;
		}
		this.setText=function(text){
			var e = igtbar_getTextElem(this.Element);
			if(e!=null)
				ig.setText(e, text);
		}
		
		this.setTargetUrl=function(targetUrl){this.Element.setAttribute("igUrl", targetUrl);}
		this.getTargetUrl=function(){return this.Element.getAttribute("igUrl");}
		this.setTargetFrame=function(targetFrame){this.Element.setAttribute("igFrame", targetFrame);}
		this.getTargetFrame=function(){return this.Element.getAttribute("igFrame");}
		
		this.setEnabled=function(bEnabled)
		{
			this.Enabled=bEnabled;
			if(bEnabled)
			{
				igtbar_DefaultItem(this);
			}
			else
			{
				if(this.DisabledImage&&this.DisabledImage.length&&this.DisabledImage.length>0)
				{	
					var image=ig.getElementById(item.id+"_img");
					if(image)image.src=this.DisabledImage;
				}
			}
			ig.setEnabled(this.Element, bEnabled);
		}
		this.getEnabled=function(){return this.Enabled}
		this.setSelected=function(bSelected){
			//this.Selected=bSelected;
			if(this.ToggleButton)
				igtbar_toggleButtonState(this.Element,false);
			else
			if(this.IsGroupButton) {
				igtbar_groupButtonDown(this.Element,null,true,this.Parent.Element.id,false)
			}
		}
		this.getSelected=function(){return this.Selected;}
		this.getPropertyEx=function(nm){
			if(nm){
			  nm=nm.toLowerCase();
			  var fnd=false;
			  var i=12;
			  while(!fnd&&item.length>++i&&item[i]){
				var pn;
				try{pn=item[i].substr(1);}catch(ex){;}
				fnd=(pn==nm);
				++i;
			  }
			  if(fnd){return item[i];}
			} 
			return nm;
		}
		this.setPropertyEx=function(nm,newVal){
			if(nm){
			  nm=nm.toLowerCase();
			  var fnd=false;
			  var i=12;
			  while(!fnd&&item.length>++i&&item[i]){
				var pn;
				try{pn=item[i].substr(1);}catch(ex){;}
				fnd=(pn==nm);
				++i;
			  }
			  if(fnd){item[i]=newVal;}
			}
		}
	}
	else if(item[0]==1) // Button Group
	{
		this.Type=item[0];
		this.Items=new Array();
		this.Items.fromKey = function (key) {
			for(i=0; i<this.length; i++) {
				if(this[i].Key == key)
					return this[i];
			}
			return null;
		}

		var i=0;
		for(i=1;i<item.length && item[i] && item[i].length && typeof(item[i])!="string";i++)
		{
			var oitem = new igtbar_initItem(tb,item[i],i);
			this.Items[i-1]=oitem;
			var id=tb.Id+"_Group_"+index+"_"+(i-1).toString();
			oitem.Element=ig.getElementById(id);
			oitem.Id=id;
			oitem.Parent=this;
			oitem.IsGroupButton=true;
		}
		var selButton=null;
		for(var j=0;j<this.Items.length && !selButton;j++)
			if(this.Items[j].Element.id==item[i])
				selButton=this.Items[j];
		this.SelectedButton=selButton;
		this.Selected=item[++i];
		this.Key=item[++i];
		this.Tag=item[++i];
	}
	else 
	if(item[0]==4) // Textbox
	{
		this.Type=item[0];
		this.Key=item[1];
		this.Tag=item[2];
		this.getText=function(){return this.Element.value;}
		this.setText=function(text){this.Element.value = text;}
		this.setEnabled=function(bEnabled){this.Enabled=bEnabled;ig.setEnabled(this.Element, bEnabled);}
		this.getEnabled=function(){return ig.getEnabled(this.Element);}
	}
	else
	{
		this.Type=item[0];
		this.Key=item[1];
		this.Tag=item[2];
	}
	this.Index=index;
}

function igtbar_getTextElem(e) {
	c=e.childNodes.length;
	for(i=0;i<c;i++){
		var c1 = e.childNodes[i];
		if(c1.getAttribute!=null) {
			var txt = c1.getAttribute("igtxt");
			if(txt!=null && txt.length>0)
				return c1;
		}
	}
}
function igtbar_getImageElem(e) {
	c=e.childNodes.length;
	for(i=0;i<c;i++){
		var c1 = e.childNodes[i];
		if(c1.getAttribute!=null) {
			var txt = c1.getAttribute("igimg");
			if(txt!=null && txt.length>0)
				return c1;
		}
	}
}
function igtbar_initEvents(events)
{
	this.Click=events[0];
	this.InitializeToolbar=events[1];
	this.MouseOut=events[2];
	this.MouseOver=events[3];
}

function igtbar_getItemById(id)
{
	var bName=id.split("_");
	var tb=igtbar_getToolbarById(bName[0]);
	if(!tb)
		return null;
	for(var i=0;i<tb.Items.length;i++)
	{
		if(tb.Items[i].Element && tb.Items[i].Element.id==id)
			return tb.Items[i];
		if(tb.Items[i].Items)
		{
			for(var j=0;j<tb.Items[i].Items.length;j++)
				if(tb.Items[i].Items[j].Element && tb.Items[i].Items[j].Element.id==id)
					return tb.Items[i].Items[j];
		}
	}
	return null;
}

function ig_initialize()
{
	ig_dom = (document.getElementById) ? true : false;
	ig_IE = (document.all) ? true : false;
	ig_IE4 = ig_IE && !ig_dom;
	ig_IE5 = ig_IE && ig_dom;
	ig_Mac = (navigator.appVersion.indexOf("Mac") != -1);
	ig_IE5M = ig_IE5 && ig_Mac;
	ig_IEW = ig_IE && !ig_Mac;
	ig_IE4W = ig_IE4 && ig_IEW;
	ig_IE5W = ig_IE5 && ig_IEW;
	ig_NS = navigator.appName == ("Netscape");
	ig_NS4 = (document.layers) ? true : false;
	ig_NS6 = navigator.vendor == ("Netscape6");
	if(ig_IE5M)
	{
		ig_DOM = false;
		ig_IE4 = true;
	}
}

function igtbar_getToolbarById(id)
{
	return eval("o"+id);
}

// Function called when movable graphic image is first clicked
function igtbar_pickUp(toolbarId, evt)
{
    ToolbarSource = ig_csom.getElementById(toolbarId);
    if(ToolbarSource != null && ToolbarSource.mouseHooked == null){
		ig_csom.addEventListener(document, "mouseup", igtbar_drop, false);
		ToolbarSource.mouseHooked = true;
    }
	AllowMove=1;
	evt = (evt) ? evt : ((window.event) ? window.event : "")
	if(evt)
	{
		CurrentX = (evt.clientX + document.body.scrollLeft);
		CurrentY = (evt.clientY + document.body.scrollTop);
		igtbar_positionZ=ToolbarSource.style.zIndex;	
	}
	return true;
}

// Indicates to drop the toolbar.
function igtbar_drop()
{
	if(AllowMove==1)
	{
		AllowMove=0;
		ToolbarSource.style.zIndex=igtbar_positionZ;
	}
	return true;
}

// Occurs when mouse is moved and the mouse has been clicked on the movable graphic image
function igtbar_moveMe(e)
{
	evt=e?e:event;
	if(AllowMove==1)
	{
		if(!e)
		{//Check for IE.  If button is not down, drop.
			if(evt.button!=1)
			{
				igtbar_drop();
				return false;
			}
		}
		var cx,cy,left,top;
		var tb=igtbar_getToolbarById(ToolbarSource.id);
		NewX = evt.pageX?evt.pageX:(document.body.scrollLeft+evt.clientX);
		NewY = evt.pageY?evt.pageY:(document.body.scrollTop+evt.clientY);
		DistanceX = (NewX - CurrentX);
		DistanceY = (NewY - CurrentY);
		CurrentX = NewX;
		CurrentY = NewY;
		ToolbarSource.style.zIndex=(tb.OnTop==true?1000:1);
		left=ToolbarSource.style.left;
		top=ToolbarSource.style.top;
		cx=(parseInt(left.length>0?left:0)+DistanceX).toString();
		cy=(parseInt(top.length>0?top:0)+DistanceY).toString();
		ToolbarSource.style.left=cx+"px";
		ToolbarSource.style.top=cy+"px";
		//Fix bug in Netscape6, movement is choppy unless this is done.
		if(e)
		{
			window.status=NewX.toString()+","+NewY.toString();
			window.status=window.defaultStatus;
		}
		if(ig.getElementById(ToolbarSource.id+"_position")==null)
			return true;
		ig.getElementById(ToolbarSource.id+"_position").value=cx+","+cy;
	}
	return true;
}

function igtbar_groupButtonDown(button,evnt,enabled,groupID,shouldToggle)
{
	var tbar=button.id.split("_");
	var tb=igtbar_getToolbarById(tbar[0]);
	if(tb.Enabled && enabled==true)
	{
		var group=igtbar_getItemById(groupID);
		var b=igtbar_getItemById(button.id);
		var selButton=null;
		if(group.SelectedButton)
			selButton=group.SelectedButton.Element;
			
		var eventObj=new ig_EventObject();
		eventObj.event=evnt;
		eventObj.needPostBack=tb.PostBackGroup;
		ig_fireEvent(tb,tb.ClientSideEvents.Click,b,eventObj);
		if(eventObj.Cancel)
			return;

		if(!(selButton==button&&!shouldToggle))
		{
			if(selButton!=null)
			{
				group.SelectedButton.Selected=false;
				igtbar_DefaultItem(selButton);
				igtbar_removeFromList(selButton);
			}
			if(selButton==button)
			{
				group.SelectedButton=null;
				igtbar_removeFromList(selButton);
			}
			else
			{
				group.SelectedButton=igtbar_getItemById(button.id);
				igtbar_mouseDown(button,evnt,true);
			}
		}

		var url = b.getTargetUrl();
		var frame = b.getTargetFrame();
		if(url!=null&&url.length>0) {
			ig.navigateUrl(url, frame);
		}
		else
		if(eventObj.needPostBack) {
			__doPostBack(eval(tbar[0]+"UniqueID"),button.id+":GROUP:"+((button==selButton)?"UP":"DOWN"));
		}
		delete eventObj;
	}
}

function igtbar_removeFromList(button)
{
	var buttonstring=button.id.split("_");
	var isGroupButton=(buttonstring[1]=="Group");
	var newitems="";
	if(ig.getElementById(buttonstring[0]+"_hidden")==null)
		return;
	var items=ig.getElementById(buttonstring[0]+"_hidden").value.split(";");
	if(isGroupButton==true)
	{
		var groupnum=buttonstring[2];
		var buttonnum=buttonstring[3];
		var count=0;
		for(var i=0;(i<items.length&&items!=null&&items[i]!=null); i++)
			if(items[i]!=new String(groupnum+","+buttonnum))
				newitems=newitems+items[i]+";";
	}
	else
	{
		var buttonnum=buttonstring[2];
		var count=0;
		for(var i=0;(i<items.length&&items!=null&&items[i]!=null); i++)
			if(items[i]!=new String(buttonnum))
				newitems=newitems+items[i]+";";
	}
	ig.getElementById(buttonstring[0]+"_hidden").value=newitems;
}

function igtbar_addToList(button)
{
	var buttonstring=button.id.split("_");
	var isGroupButton=(buttonstring[1]=="Group");
	if(ig.getElementById(buttonstring[0]+"_hidden")==null)
		return;
	var items=ig.getElementById(buttonstring[0]+"_hidden").value.split(";");
	var count=0;
	var found=false;

	if(isGroupButton==true)
	{
		var groupnum=buttonstring[2];
		var buttonnum=buttonstring[3];
		for(count=0;(count<items.length&&items!=null&&items[count]!=null); count++)
			if(items[count]==new String(groupnum+","+buttonnum))
				found=true;
		if(!found)
			items[count]=new String(groupnum+","+buttonnum);
	}
	else
	{
		var buttonnum=buttonstring[2];
		for(count=0;(count<items.length&&items!=null&&items[count]!=null); count++)
			if(items[count]==new String(buttonnum))
				found=true;
		if(!found)
			items[count]=buttonnum;
	}
	var newbuttonstring="";
	for(var i=0;i<items.length&&items[i]!=null;i++)
		if(items[i]!="")
			newbuttonstring=(newbuttonstring+items[i]+";");
		else
			items[i]=null;
	ig.getElementById(buttonstring[0]+"_hidden").value=newbuttonstring;
}

function igtbar_mouseDown(src,evnt,enabled,toggle)
{
	var tbName=src.id.split("_");
	var tb=igtbr_state[tbName[0]];
	if(tb == null)
		return;
		
	if(enabled)
		igtbar_toggleButtonState(src,toggle);
}

function igtbar_toggleButtonState(item,toggle)
{
	var b=igtbar_getItemById(item.id);
	var tbar=b.Toolbar;
	var isDown=b.Selected;
	if(!tbar.Enabled)
		return;
	if(tbar.PostBackButton==true && toggle==true)
	{
		if(isDown==true)
			igtbar_ButtonUp(item,true);
		else
		{
			igtbar_SelectItem(item);
			if(b.AutoPostBack)
				__doPostBack(eval(tbar.Id+"UniqueID"),item.id+":DOWN");
			else{
				igtbar_SelectItem(item);
				b.Selected=true;
				igtbar_addToList(item);
			}
		}
	}
	else
	{
		if(isDown==true)
		{
			igtbar_ButtonUp(item,true);
			igtbar_removeFromList(item);
		}
		else
		{
			igtbar_SelectItem(item);
			b.Selected=true;
			igtbar_addToList(item);
		}
	}
}

function igtbar_mouseUp(src,evnt,enabled)
{
	var tbName=src.id.split("_");
	var tb=igtbr_state[tbName[0]];
	if(tb == null)
		return;

	var b=igtbar_getItemById(src.id);
	var eventObj=new ig_EventObject();
	eventObj.event=evnt;
	eventObj.needPostBack=(b.Toolbar.PostBackButton || b.AutoPostBack);
	ig_fireEvent(b.Toolbar,b.Toolbar.ClientSideEvents.Click,b,eventObj);

	if(!b.ToggleButton)
		if(eventObj.cancelPostBack)
			igtbar_ButtonUp(src,enabled,false);
		else
			igtbar_ButtonUp(src,enabled,eventObj.needPostBack);
	delete eventObj;
}

function igtbar_ButtonUp(src,enabled,forcePB)
{
	var b=igtbar_getItemById(src.id);
	if(b.Toolbar.Enabled && enabled)
	{
		b.Selected=false;
		igtbar_HoverItem(src);
		var url = b.getTargetUrl();
		var frame = b.getTargetFrame();
		if(url!=null&&url.length>0) {
			ig.navigateUrl(url, frame);
		}
		else
		if(forcePB != false) {
			if(typeof(forcePB)!="undefined" && forcePB || typeof(forcePB)=="undefined" && b.Toolbar.PostBackButton)
		//if(forcePB && b.Toolbar.PostBackButton)
			__doPostBack(eval(b.Toolbar.Id+"UniqueID"),src.id+":UP");
		}
	}
}

function igtbar_mouseOut(src,evnt,enabled,toggle)
{
	var tbName=src.id.split("_");
	var tb=igtbr_state[tbName[0]];
	if(tb == null)
		return;

	var b=igtbar_getItemById(src.id);
	if(!b)return;
	var target = evnt.toElement;
	if(target != null && (target == b.Element || target.parentNode == b.Element))
		return;
	igtbar_currentItem = null;
	if(b.Toolbar.Enabled && enabled)
	{
		var isDown=b.Selected;
		var buttonstring=src.id.split("_");
		var isGroupButton=(buttonstring[1]=="Group");	

		var eventObj=new ig_EventObject();
		eventObj.event=evnt;
		ig_fireEvent(b.Toolbar,b.Toolbar.ClientSideEvents.MouseOut,b,eventObj);
		if(eventObj.cancel)
		{
			delete eventObj;
			return;
		}
		if(!isDown)
			igtbar_DefaultItem(src);
		//Check if mouseOut occured before buttonUp.  In this case, a normal button's sate
		//needs to be reset back to default.
		if(isDown && !toggle && !isGroupButton)
		{
			igtbar_ButtonUp(src,true, false);
			igtbar_DefaultItem(src);
		}
		delete eventObj;
	}
}

var igtbar_currentItem = null;
function igtbar_mouseOver(src,evnt, enabled)
{
	var tbName=src.id.split("_");
	var tb=igtbr_state[tbName[0]];
	if(tb == null)
		return;

	var b=igtbar_getItemById(src.id);
	if(b == igtbar_currentItem)
		return;
	igtbar_currentItem = b;
	if(b.Toolbar.Enabled && enabled)
	{
		var eventObj=new ig_EventObject();
		eventObj.event=evnt;
		ig_fireEvent(b.Toolbar,b.Toolbar.ClientSideEvents.MouseOver,b,eventObj);
		if(eventObj.cancel)
		{
			delete eventObj;
			return;
		}
		igtbar_HoverItem(src);
		delete eventObj;
	}
}
	
function igtbar_SelectItem(item)
{
	var b=igtbar_getItemById(item.id);
	var style=b.SelectedStyleClassName;
	var image = b.SelectedImage;
	if(style)
		item.className=style;
	if(image)
	{
		item=ig.getElementById(item.id+"_img");
		if(item)
			item.src=image;
	}
}

function igtbar_HoverItem(item)
{
	var b=igtbar_getItemById(item.id);
	if(!b.Selected)
	{
		var style=b.HoverStyleClassName;
		var image=b.HoverImage;
		if(style)
			item.className=style;
		if(image)
		{
			item=ig.getElementById(item.id+"_img");
			if(item)
				item.src=image;
		}
	}
}

function igtbar_DefaultItem(item)
{
	var b=igtbar_getItemById(item.id);
	var style=b.DefaultStyleClassName;
	var image=b.DefaultImage;
	if(style)
		item.className=style;
	if(image)
	{
		item=ig.getElementById(item.id+"_img");
		if(item)
			item.src=image;
	}
}

/***
** This Function is only called when RenderAnchors is true
** It is called when the link is clicked on.  
***/
function igtbar_ItemClicked(item)
{
}

function igtbar_navigate(targetUrl, targetFrame)
{
	ig.navigateUrl(targetUrl, targetFrame);
}

function igtbar_textBoxChange(txtBox)
{
}
