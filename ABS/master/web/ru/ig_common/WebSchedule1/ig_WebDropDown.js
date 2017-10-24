/* 
Infragistics WebDropDown script. 
Version 1.1.20041.10
Copyright (c) 2003-2004 Infragistics, Inc. All Rights Reserved.
Comments:
Functions marked public are for use by developers and are documented and supported.
Functions marked private are for the internal use of the WebDateChooser component.  
Functions marked private should not be used directly by developers
and are not documented for use by developers and are not supported for use by developers
*/


var igdrp_displaying;
var igdrp_currentDropped;
var igcmboObject = null;
// private - hides all dropdown select controls for the document.
var igdrp_hidden=false;

function igdrp_hideDropDowns(bHide) { 
	 if(igdrp_dropDowns == null)
		return;
     if(bHide)
     {
		if(igdrp_hidden)
			return;
		igdrp_hidden = true;
         for (i=0; i<igdrp_dropDowns.length;i++)
              igdrp_dropDowns[i].style.visibility='hidden';
     }
     else
     {
         for (i=0; i<igdrp_dropDowns.length;i++)
         {
              igdrp_dropDowns[i].style.visibility='visible';
         }
         igdrp_hidden = false;
     }
}
function igdrp_onmouseover(evnt,id){
	var oCombo=igdrp_getComboById(id);
	oCombo.DropButton.Image.className=oCombo.DropButton.HoverStyleClassName;
}
function igdrp_onmousedown(evnt,id) {
	var src = igdrp_srcElement(evnt);
	ig_inCombo = true;
	var oCombo = igdrp_getComboById(id);
	if(src.id == id + "_input" && oCombo.isEditable())
		return;
	if(!oCombo || !oCombo.Loaded || !oCombo.isEnabled() || oCombo.isReadOnly()) 
		return;
	if(igdrp_currentDropped != null && igdrp_currentDropped != oCombo)
		igdrp_currentDropped.setDropDownVisible(false);
	if(oCombo.isDropDownVisible() == true) {
		oCombo.setDropDownVisible(false);
		igcmboObject = oCombo;
		if(document.all)
			setTimeout('igdrp_focusEdit()', 10);
	}
	else {
		igdrp_swapImage(oCombo, 2);
		oCombo.setDropDownVisible(true);
	}
    evnt.returnValue=false;
    evnt.cancelBubble=true;
	return false;

}
function igdrp_cancelSelection(evnt,id){
	evnt.returnValue=false;
	evnt.cancelBubble=true;
	return false;
}
function igdrp_focusEdit() {
	igcmboObject.setFocusTop();
}

function igdrp_onmouseup(evnt,id) {
	var oCombo = igdrp_getComboById(id);
	if(!oCombo || !oCombo.Loaded || !oCombo.isEnabled() || oCombo.isReadOnly()) 
		return;
	igdrp_swapImage(oCombo, 1);
}

function igdrp_onmouseout(evnt,id) {
	var oCombo = igdrp_getComboById(id);
	if(!oCombo || !oCombo.Loaded || !oCombo.isEnabled() || oCombo.isReadOnly()) 
		return;
	if(oCombo.Dropped == true) {
		igdrp_swapImage(oCombo, 1);
	}
	else {
	}
	oCombo.DropButton.Image.className=oCombo.DropButton.DefaultStyleClassName;
}

function igdrp_swapImage(oCombo, imageNo) {
	oCombo.DropButton.Image.src = (imageNo==1?oCombo.DropButton.ImageUrl1:oCombo.DropButton.ImageUrl2);
}

function igdrp_ondblclick(evnt,id) {
	var oCombo = igdrp_getComboById(id);
	if(!oCombo || !oCombo.Loaded || !oCombo.isEnabled() || oCombo.isReadOnly())return;
	if(oCombo.isDropDownVisible())oCombo.setDropDownVisible(false);
}


// public - Retrieves the server-side unique id of the combo
function igdrp_getUniqueId(comboName) {
	var combo = igdrp_comboState[comboName];
	if(combo != null)
		return combo.UniqueId;
	return null;
}
function igdrp_getElementById(id) {
	return ig_csom.getElementById(id);//(document.all?document.all[id]:document.getElementById(id));
}

// public - returns the combo object for the Item Id
function igdrp_getComboById(itemId) {
	var id = igdrp_comboIdById(itemId);  
	return igdrp_comboState[id];
}

// public - returns the combo object from an Item element
function igdrp_getComboByItem(item) {
	var id = igdrp_comboIdById(item.id);  
	return igdrp_comboState[id];
}

// public - returns the combo Name from an itemId
function igdrp_comboIdById(itemId) {
   var comboName = itemId;
   var strArray = comboName.split("_");
   return strArray[0];
}


// Warning: Private functions for internal component usage only
// The functions in this section are not intended for general use and are not supported
// or documented.
function igdrp_getPosition(el){
	if(el!=null&&(el.style.position=="relative"||el.style.position=="absolute")){
		var lx=0;
		var ly=0;
		if(el.style.left!=null&&el.style.left.length>0)lx=parseInt(el.style.left);
		if(el.style.top!=null&&el.style.top.length>0)ly=parseInt(el.style.top);
		return {x:lx,y:ly}
	}
	for (var lx=0,ly=0;el!=null&&(el.style.position!="relative"&&el.style.position!="absolute"&&el.style.overflow!="auto"&&el.style.overflow!=scroll);lx+=(el.offsetLeft-el.scrollLeft),ly+=(el.offsetTop-el.scrollTop),el=el.offsetParent);
	if(el!=null&&(el.style.overflow=="auto"||el.style.overflow=="scroll")){lx+=(el.offsetLeft-el.scrollLeft);ly+=(el.offsetTop-el.scrollTop);}
	return {x:lx,y:ly}
}
// private - Fires an event to client-side script and then to the server is necessary
function igdrp_fireEvent(oCombo,eventName,param)
{
	var oEvent = new ig_EventObject();
	ig_fireEvent(oCombo,eventName,param,oEvent);
	return oEvent;
}

// private - Performed on page initialization

var igdrp_comboState=[];
var igdrp_dropDowns;

// private - initializes the combo object on the client
function igdrp_initCombo(comboId) {

   var comboElement = igdrp_getElementById(comboId);
   var oCombo = new igdrp_combo(comboElement,eval("igdrp_"+comboId+"_Props"));
   igdrp_comboState[comboId] = oCombo;
   ig_fireEvent(oCombo, oCombo.Events.InitializeCombo[0], oCombo, comboId);
   if(ig.IsIE && oCombo.HideDropDowns==true && igdrp_dropDowns==null) {
		igdrp_dropDowns = document.all.tags("SELECT");
   }
   oCombo.Loaded = true;
   return oCombo;
}

function handl()
{
}

function igdrp_button(props){
	this.ImageUrl1=props[0];
	this.ImageUrl2=props[1];
	this.DefaultStyleClassName=props[2];
	this.HoverStyleClassName=props[3];
}
// private - constructor for the combo object
function igdrp_combo(comboElement,comboProps) {
	this.Id=comboElement.id;
	this.Element		=	comboElement;
	this.Element.Object	=	this;
	this.UniqueId		=	comboProps[0];
	this.DropButton		=	new igdrp_button(comboProps[1])
	this.EditStyleClassName=comboProps[3];
	this.DropDownStyleClassName=comboProps[4];
	this.HideDropDowns	=	comboProps[5];
	this.editable		=	comboProps[6];
	this.readOnly		=	comboProps[7]
	this.dropDownAlignment		=	comboProps[8];
	this.getDropDownAlignment	=	function(){return this.dropDownAlignment;}
	this.setDropDownAlignment	=	function(align){this.dropDownAlignment=align;ig_ClientState.setPropertyValue(this.stateNode,"DropDownAlignment",align);this.updatePostField();}
	this.autoCloseUp	=	comboProps[9];
	this.Dropped		=	comboProps[10];   
	this.getAutoCloseUp	=	function(){return this.autoCloseUp;}
	this.setAutoCloseUp	=	function(auto){this.autoCloseUp=auto;ig_ClientState.setPropertyValue(this.stateNode,"AutoCloseUp",auto);this.updatePostField();}
	this.isEnabled		=	function(){return !this.Element.disabled;}
	this.setEnabled		=	function(enable){this.Element.disabled=!enable;ig_ClientState.setPropertyValue(this.stateNode,"Enabled",enable);this.updatePostField();}
	this.ClientUniqueId =	igdrp_getClientUniqueId(this.UniqueId);
	this.inputBox		=	igdrp_getElementById(this.ClientUniqueId + "_input");
	this.DropButton.Image=	igdrp_getElementById(this.ClientUniqueId + "_img");
	this.postField		=	igdrp_getElementById(this.UniqueId + "_hidden");
	this.container		=	igdrp_getElementById(this.ClientUniqueId + "_container");
	this.transPanel		=	null;
	this.ForeColor		=	this.inputBox.style.color;//comboProps[3];
	this.BackColor		=	this.inputBox.style.backgroundColor;//comboProps[4];
	this.Events			=	new igdrp_events(eval("igdrp_"+this.ClientUniqueId+"_Events"));
	this.Event			=	new ig_EventObject()
	this.Loaded			=	false;
	this.TopHoverStarted=	false;
	//this.innerctl		=	this.Editable? this.inputBox:this.valueBox;
	//this.enabled		=	this.Element.disabled;
   	//this.valueBox		=	igdrp_getElementById(this.ClientUniqueId + "_value");
	this.isEditable		=	function(){return this.editable;}
	this.setEditable	=	function(editable){
		this.editable=editable;
		this.inputBox.readOnly=(!editable)?!editable:this.isReadOnly();
		ig_ClientState.setPropertyValue(this.stateNode,"Editable",editable);
		this.updatePostField();
		if(!editable){
			this.inputBox.onSelect=function(){igdrp_cancelSelection(event,this.Id);}	
			this.inputBox.onSelectStart=function(){igdrp_cancelSelection(event,this.Id);}	
		}
		else{
			this.inputBox.onSelect=this.inputBox.onSelectStart=null;
		}
	}
	this.isReadOnly		=	function(){return this.readOnly;}
	this.setReadOnly	=	function(readOnly)
	{
		this.readOnly=readOnly;
		this.inputBox.readOnly=(readOnly==true?readOnly:!this.isEditable());
		ig_ClientState.setPropertyValue(this.stateNode,"ReadOnly",readOnly);
		this.updatePostField();
	}
	this.getValue	=	function(){return this.value;}
	//this.setValue	=	function(newVal){this.value=value;}
	this.getText	=	function(){return this.inputBox.value;}
	this.setText	=	function(newValue,bFireEvent){this.updateValue(newValue, bFireEvent);}
	this.updatePostField=	function(value){if(this.postField!=null)this.postField.value = ig_ClientState.getText(this.stateItems);}
	this.fireServerEvent=	function(eventName,data){	__doPostBack(this.UniqueId,eventName+":"+data);}
	this.isDropDownVisible	=	function(){return this.Dropped;}
	this.setDropDownVisible	=	function(bDrop,setFocus)
	{
		var evt;
		//if(this.HideDropDowns && ig.IsIE)igdrp_hideDropDowns(bDrop);
		if(bDrop == true &&!this.isReadOnly())
		{
			if(this.transPanel==null && this.HideDropDowns)
			{	
				this.transPanel=ig.createTransparentPanel();
				if(ig.IsIE&&this.transPanel!=null){
					document.body.removeChild(this.transPanel.Element);
					this.container.offsetParent.appendChild(this.transPanel.Element);
					this.transPanel.Element.scrolling="no";
					this.container.style.zIndex=this.transPanel.Element.style.zIndex+1;
				}
			}
			igdrp_setPanelPosition(this.Element,this.container,this.getDropDownAlignment(),this.transPanel);
			evt=igdrp_fireEvent(this, this.Events.BeforeDropDown[0],this.container);
			if(evt.cancel){
				delete evt;
				return;
			}
			this.ExpandEffects.applyFilter();
			if(ig.IsIE){
				if(this.transPanel!=null)this.transPanel.show();
			}else this.container.style.visibility = 'visible'; 
		
			this.Dropped = true;
			igdrp_currentDropped = this;
			igdrp_fireEvent(this, this.Events.AfterDropDown[0], this.container);
		}
		else 
		{
			evt=igdrp_fireEvent(this, this.Events.BeforeCloseUp[0], this.container);
			if (evt.cancel) {
				delete evt;
				return;
			}
			if(setFocus)this.setFocusTop();
			this.container.style.visibility = 'hidden'; 
			this.container.style.display = "none"; 
			if(this.transPanel!=null)this.transPanel.hide();
			this.Dropped = false;
			igdrp_currentDropped = null;
			igdrp_fireEvent(this, this.Events.AfterCloseUp[0], this.container);
			evt=null;
		}
		ig_ClientState.setPropertyValue(this.stateNode,"ShowDropDown",bDrop);this.updatePostField();
	}
	this.getVisible	= function(){return (this.Element.style.display != "none" && this.Element.style.visibility != "hidden");}
	this.setVisible	= function(bVisible,left,top,width,height)
	{
		this.Element.style.display=(bVisible?"":"none");
		this.Element.style.visibility=(bVisible?"visible":"hidden");
		if(this.Dropped&&!bVisible)	this.setDropDownVisible(false);
		if(top!=null&&bVisible==true){
			this.Element.style.position="absolute";
			this.Element.style.top=top-1;
			this.Element.style.left=left;
			this.Element.style.fontSize="0pt";
			this.setHeight(height);
			this.setWidth(width);
		}
		this.setFocusTop();
	}
	this.setWidth	= function(width) 
	{
		if(width==0)
			return;
		var border = (this.Element.clientWidth&&this.Element.clientWidth>0?this.Element.offsetWidth - this.Element.clientWidth:this.Element.style.borderWidth);
		this.inputBox.style.width =  width - this.DropButton.Image.offsetWidth - border;
		this.Element.style.width = width-border;
	}
	this.setHeight	= function(height){
		if(height==0) return;
		var border = (this.Element.clientHeight&&this.Element.clientHeight>0?this.Element.offsetHeight - this.Element.clientHeight:this.Element.style.borderWidth);
		this.inputBox.style.height =  height;
		this.DropButton.Image.style.height=height;
		this.Element.style.height = height-border;
	}
	this.setFocusTop= function()
	{
		if(this.isEditable() == true) {
			this.inputBox.select();
			if(document.all&&this.getVisible())
				this.inputBox.focus();
		}
		else 
		{
			this.inputBox.style.backgroundColor="Highlight";//this.SelBackColor;
			this.inputBox.style.borderStyle='dashed';
			this.inputBox.style.borderWidth=1;
			this.inputBox.style.color="HighlightText";//this.SelForeColor;
			if(document.all) this.inputBox.focus();
		}
	}
	this.updateValue= function(newValue, suppressEvent) 
	{
		ig_ClientState.setPropertyValue(this.stateNode,"Value",(newValue!=null&&newValue.length>0?newValue:(this.getNullDateLabel()!=null&&this.getNullDateLabel().length>0?this.getNullDateLabel():" ")));
		this.updatePostField();
		if(suppressEvent)return;
		var evt=igdrp_fireEvent(this, this.Events.ValueChanged[0], this.getValue());
		if((evt.needPostBack||this.Events.ValueChanged[1]) && !evt.cancelPostBack) {
			if(this.getAutoCloseUp()&&this.isDropDownVisible())this.setDropDownVisible(false);
			this.fireServerEvent('ValueChanged',this.editor.getText());
		}
		delete evt;
	}
	

	this.setWidth(this.Element.offsetWidth);
    //var agt=navigator.userAgent.toLowerCase();
	//if(!(ig_csom.IsIE5 &&	(agt.indexOf("msie 5.0")!=-1))){
		this.stateItems	= ig_ClientState.createRootNode();
		this.stateNode	= ig_ClientState.addNode(this.stateItems,"DateChooser");
	//}
	this.ExpandEffects	= new igdrp_expandEffects(this.container,comboProps[2],this);
	this.onValueChanged=function(oEditor,value,oEvent){
		if(oEditor!=null&&oEditor.parent!=null){
			oEditor.parent.updateValue(oEditor.getText(),(oEditor.getDate()==null));
		}
	}
	this.onLostFocus=function(oEditor,value,oEvent){
		if(!oEditor.parent.isDropDownVisible())
		{
			oEditor.parent.inputBox.style.color="black";
		}else oEditor.parent.setDropDownVisible(false);
	}
	this.onKeyDown=function(oEditor,value,oEvent){
		var oCombo=oEditor.parent;
		var evnt=oEvent.event;
		if(!oCombo.Loaded)return;
		var keyCode = (evnt.keyCode);
		//window.status=keyCode;
		switch(keyCode){
			case 40: //DownArrow
				//window.status=evnt.modifiers;
				if(evnt.altKey){
				oCombo.setDropDownVisible(true);
				oCombo.cancelBubble=true;
				oCombo.returnValue=false;
				return false;
				}break;
			case 27: //Esc
			case 13:
				oCombo.setDropDownVisible(false);
				break;
		}
    	ig_fireEvent(oCombo, oCombo.Events.EditKeyDown[0], keyCode,oEvent);
 		oCombo.fireMulticastEvent("keydown",oEvent);
    	if(oEvent.cancel==true)
    	{
    		evnt.returnValue=false;
    		evnt.cancelBubble=true;
			return false;
		}
	}
	this.onKeyUp=function(oEditor,value,oEvent){
		var oCombo=oEditor.parent;
		if(!oCombo.Loaded)return;
		var keyCode = (oEvent.event.keyCode);
    	ig_fireEvent(oCombo,oCombo.Events.EditKeyUp[0],keyCode,oEvent);
    	if(oEvent.cancel){
    		oEvent.event.returnValue=false;
    		oEvent.event.cancelBubble=true;
			return false;
		}
	}
	this.onBlur=function(oEditor,value,oEvent){
		var oCombo=oEditor.parent;
		if(!oCombo.Loaded)return;		
		if(oEditor.changed)oCombo.updateValue();
		if(!oCombo.isEditable())
		{
			oCombo.inputBox.style.backgroundColor=oCombo.BackColor;
			oCombo.inputBox.style.color=oCombo.ForeColor;
			oCombo.inputBox.style.borderStyle='none';

			if(oCombo.EditStyleClassName != null)
				oCombo.inputBox.className = oCombo.EditStyleClassName;
		}
		if(!oCombo.isDropDownVisible()){
			if(oCombo.endEditCell!=null)oCombo.endEditCell();
			ig_fireEvent(oCombo, oCombo.Events.OnBlur[0], oCombo,oEvent);
			oCombo.fireMulticastEvent("blur",oEvent);
			if(oEvent.cancel){
				return;
			}
		}
	}
	this.onFocus=function(oEditor,value,oEvent){
		//oEditor.parent.setFocusTop();
	}
	if(this.Dropped){
		if(document.all)
			setTimeout('igdrp_getComboById(\"'+this.Id+'\").setFocusTop();', 10);
		window.setTimeout('igdrp_getComboById(\"'+this.Id+'\").setDropDownVisible('+this.Dropped+');', 100);
	}
	this.handlers=new Array(11);
	this.removeEventListener = function(name, fref){
		var evtName=name.toLowerCase();
		if(this.handlers==null)return;
		if(this.handlers[evtName]==null||!(this.handlers[evtName].length))return;
		for( i=0;i<this.handlers[evtName].length;i++){
			var listener=this.handlers[evtName][i];
			if(listener!=null)
				if(listener.handler==fref)
					this.handlers[evtName][i]=null;
		}		
	}
	this.addEventListener = function(name, fref,oParent){
		var evtName=name.toLowerCase();
		var handlerArray=(this.handlers[evtName]);
		if(handlerArray==null)this.handlers[evtName]=handlerArray=new Array();
		handlerArray[handlerArray.length]=new ig_EventListener(fref,oParent);
	}
	this.fireMulticastEvent=function(eventName,evt){
		if(this.handlers==null)return;
		var evtName=eventName.toLowerCase();
		if(evt==null)evt=new ig_EventObject();
		if(this.handlers.length&&this.handlers[evtName]!=null&&this.handlers[evtName].length){
			for(i=0;i<this.handlers[evtName].length;i++){
				var listener=this.handlers[evtName][i];
				if(listener !=null){
					listener.handler.apply(listener.callBackObject,[this,evt,listener.callBackObject]);
					if(evt!=null&&evt.cancel)return evt;
				}
			}
			return evt;
		}
		return null;
	}

}
function ig_EventListener(fref,oCallBackObject){
	this.handler=fref;
	this.callBackObject=oCallBackObject;
}
// private - event initialization for menu object
function igdrp_expandEffects(element,props,oDateChooser)
{
	this.updatePostField=function(){oDateChooser.updatePostField();}
	this.stateNode=ig_ClientState.addNode(oDateChooser.stateNode,"ExpandEffects");
	this.Element=element;
	this.duration=props[0];
	this.opacity=props[1];
	this.type=props[2];
	this.shadowColor=props[3];
	this.shadowWidth=props[4];
	this.delay=props[5];
	this.getDuration	= function(){return this.duration;}
	this.getOpacity		= function(){return this.opacity;}
	this.getType		= function(){return this.type;}
	this.getShadowColor	= function(){return this.shadowColor;}
	this.getShadowWidth	= function(){return this.shadowWidth;}
	this.getDelay		= function(){return this.delay;}
	this.setDuration	= function(value){this.duration=value;		ig_ClientState.setPropertyValue(this.stateNode,"Duration",value);		this.updatePostField();}
	this.setOpacity		= function(value){this.opacity=value;		ig_ClientState.setPropertyValue(this.stateNode,"Opacity",value);		this.updatePostField();}
	this.setType		= function(value){this.type=value;			ig_ClientState.setPropertyValue(this.stateNode,"Type",value);			this.updatePostField();}
	this.setShadowColor	= function(value){this.shadowColor=value;	ig_ClientState.setPropertyValue(this.stateNode,"ShadowColor",value);	this.updatePostField();}
	this.setShadowWidth	= function(value){this.shadowWidth=value;	ig_ClientState.setPropertyValue(this.stateNode,"ShadowWidth",value);	this.updatePostField();}
	this.setDelay		= function(value){this.delay=value;			ig_ClientState.setPropertyValue(this.stateNode,"Delay",value);			this.updatePostField();}
	this.applyFilter	= function(){
		if(!ig.IsIE)return;
		if(this.Type != 'NotSet' && this.Element!=null)
			this.Element.style.filter = "progid:DXImageTransform.Microsoft."+this.type+"(duration="+(this.duration/1000)+");"
		if(this.ShadowWidth > 0) {
			var s = " progid:DXImageTransform.Microsoft.Shadow(Direction=135, Strength="+this.shadowWidth+",color='"+this.shadowColor+"')";
			this.Element.style.filter += s;
		}
		if(this.Opacity < 100)
			this.Element.style.filter += " progid:DXImageTransform.Microsoft.Alpha(Opacity="+this.opacity+");"
		if(this.Element.filters[0] != null)
			this.Element.filters[0].apply();
		this.Element.style.visibility = 'visible'; 
		this.Element.style.display = ""; 
		if(this.Element.filters[0] != null)
			this.Element.filters[0].play();
	}
}
// private - event initialization for combo object
function igdrp_setPanelPosition(element,panel,panelAlignment,transLayer){
	var location=igdrp_getPosition(element);
	var pxTop = element.offsetHeight+location.y;//(element.style.top?parseInt(element.style.top):0);//element.offsetTop + element.offsetHeight;//igdrp_getTopPos(element) + element.offsetHeight;
	var pxLeft = location.x;//0 + (element.style.left?parseInt(element.style.left):0);//element.offsetLeft;
	panel.style.display = ""; 
	var w = (parseInt(element.style.width) - panel.offsetWidth);
	if (panelAlignment == 1) // center
		pxLeft += w/2;
	else if (panelAlignment == 2) //right
		pxLeft += w;	
	var limits=igdrp_getWindowLimits(); 
	panel.style.left=pxLeft=pxLeft+(pxLeft<limits.minX?(limits.minX-pxLeft):0)-(pxLeft+panel.offsetWidth>limits.maxX?((panel.offsetWidth+pxLeft)-limits.maxX):0);
	panel.style.top=pxTop=pxTop-(pxTop+panel.offsetHeight>limits.maxY?(panel.offsetHeight+element.offsetHeight):0);   
	if(transLayer!=null)transLayer.setPosition(pxTop,pxLeft,panel.offsetWidth,panel.offsetHeight);
}
function igdrp_getWindowLimits(){
	return {minX:document.body.scrollLeft,maxX:document.body.scrollLeft+document.body.clientWidth,minY:document.body.scrollTop,maxY:document.body.scrollTop+document.body.clientHeight};
}
function igdrp_keydown(evnt,comboId) {
}
// private - event initialization for combo object
function igdrp_events(events)
{
	this.eventArray=events;
	this.InitializeCombo=events[0];
	this.BeforeDropDown=events[1];
	this.AfterDropDown=events[2];
	this.BeforeCloseUp=events[3];
	this.AfterCloseUp=events[4];
	this.EditKeyDown=events[5];
	this.EditKeyUp=events[6];
	this.ValueChanged=events[7];
	this.TextChanged=events[8];
	this.OnBlur=events[9];
}

var ig_inCombo=false;
// private - Handles the mouse down event
function igdrp_mouseDown(evnt) {
	if(!evnt)evnt=window.event;
	if(!evnt)return;
	if(igdrp_currentDropped == null)
		return true;
		
	var container = igdrp_getElementById(igdrp_currentDropped.ClientUniqueId + "_container");

	var elem = igdrp_srcElement(evnt);//document.elementFromPoint(evnt.clientX, evnt.clientY);
	var parent = elem;
	while(true) {
		if(parent == null)
			break;
		if(parent == container)
			return true;
		parent = parent.parentNode;
	}
		
	if(ig_inCombo == true) {
		ig_inCombo = false;
		//return true;		
	}
	
	igdrp_currentDropped.setDropDownVisible(false);
	ig_inCombo = false;

	return true;
}

// private - Handles the mouse up event
function igdrp_mouseUp() {
	return;
}

// private - Performed on page initialization
function igdrp_initialize() {
	ig_csom.addEventListener(document,"mousedown",igdrp_mouseDown,false);	
	if(document.captureEvent)document.captureEvent(Event.MOUSEDOWN);
}

// private - Obtains the proper source element in relation to an event
function igdrp_srcElement(evnt)
{
	var se
	if(evnt.target)
		se=evnt.target;
	else if(evnt.srcElement)
		se=evnt.srcElement;
	return se;
}

// private
function igdrp_getClientUniqueId(uniqueId) {
	var u = uniqueId.replace(/:/gi, "x");
	u = u.replace(/_/gi, "x");
	return u;
}

