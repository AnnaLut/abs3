/* 
Infragistics Listbar Script 
Version 2.1.20041.10
Copyright (c) 2002-2004 Infragistics, Inc. All Rights Reserved.
*/

var iglbar_AllowMove=0;
var iglbar_SourceGroup;
var iglbar_CloneGroup;
var iglbar_CurrentX=0;
var iglbar_CurrentY=0;

//Return an UltraWebListbar object
function iglbar_getListbarById(id){
	lbid=id.split("_")[0];
	lbarObj=eval(lbid+"_obj");
	if(lbarObj==null){
		lbarObj= new UltraWebListbar(lbid,eval(lbid+"_groupsArray"));
		lbarObj.Element.style.display="";
		if(lbarObj.Events!=null&&lbarObj.Events.InitializeListbar!=null)ig_fireEvent(lbarObj,lbarObj.Events.InitializeListbar[0]);
	}
	return lbarObj;
}
//Return an iglbar_Group object associated with the specified id. 
function iglbar_getGroupById(id){
	var parts=id.split("_");
	var barId=parts[0];
	var bar=iglbar_getListbarById(barId);
	return bar.Groups[parts[2]];
}
//Return an iglbar_Item object associated with the specified id.
function iglbar_getItemById(id){
	var parts=id.split("_");
	var barId=parts[0];
	var bar=iglbar_getListbarById(barId);
	return bar.Groups[parts[1]].Items[parts[3]];	
}
//Arranges Listbar group buttons so that selected button is the last button shown
//in the Top button area, and shows it's items.
function iglbar_adjust(lbar){
	var i=0;
	var moveToBottom=false;
	var group=new Array(2);
	while(lbar.Groups[i]!=null){
		group[0]=ig.getElementById(lbar.Groups[i].Id+"_top_tr");
		group[1]=ig.getElementById(lbar.Groups[i].Id+"_bottom_tr");
		
		ig.getElementById(lbar.Id+"_Items_"+i.toString()).style.display="none";
		if(!moveToBottom){
			if(lbar.Groups[i]==lbar.SelectedGroup){
				moveToBottom=true;
				ig.getElementById(lbar.Id+"_Items_"+i.toString()).style.display="";
			}
			group[0].style.display="";
			group[1].style.display="none";
		}
		else{
			if(ig.getElementById(lbar.Id+"_BotGroup").style.display=="none")ig.getElementById(lbar.Id+"_BotGroup").style.display="";
			group[1].style.display="";
			group[0].style.display="none";
		}
		i++; 
	}
	ig.getElementById(lbar.Id+"_Items").className=lbar.SelectedGroup.GroupStyleClassName;
}

//Internal Use Only
function iglbar_groupHeaderMouseOver(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var group=iglbar_getGroupById(src.id);
	var oEvent=iglbar_fireEvent(group.Control,group.Control.Events.MouseOver[0],group,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	delete(oEvent);
	if(group==null||!group.getExpanded()||!group.getEnabled())return;
	src.className=group.HeaderAppearance.HoverAppearance.ClassName;
}
//Internal Use Only
function iglbar_groupHeaderMouseOut(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var group=iglbar_getGroupById(src.id);
	var oEvent=iglbar_fireEvent(group.Control,group.Control.Events.MouseOut[0],group,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	delete(oEvent);
	if(group==null||!group.getEnabled())return;
	if(group.getExpanded())
		src.className=group.HeaderAppearance.ExpandedAppearance.ClassName;
	else src.className=group.HeaderAppearance.CollapsedAppearance.ClassName;
}
//Internal Use Only
function iglbar_headerClick(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var group=iglbar_getGroupById(src.id);
	var oEvent=iglbar_fireEvent(group.Control,group.Control.Events.HeaderClick[0],group,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	delete(oEvent);	
	if(group.getEnabled())iglbar_navigate(group.TargetUrl,group.TargetFrame);
	if(group.Control.HeaderClickAction==0&&group.getEnabled())
		iglbar_toggleGroup(e,src);
}
//Internal Use Only
function iglbar_headerDoubleClick(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var group=iglbar_getGroupById(src.id);
	var oEvent=iglbar_fireEvent(group.Control,group.Control.Events.HeaderDoubleClick[0],group,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	delete(oEvent);
	if(group.Control.HeaderClickAction!=2&&group.getEnabled())
		iglbar_toggleGroup(e,src);
}
//Internal Use Only
function iglbar_groupButtonClicked(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var group=iglbar_getGroupById(src.id);
	if(group==null||group.Control==null||group==group.Control.SelectedGroup||!group.getEnabled())return;
/*BeforeGroupSelected*/
	var oEvent=iglbar_fireEvent(group.Control,group.Control.Events.BeforeGroupSelected[0],group,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	group.setSelected(true);	
	iglbar_navigate(group.TargetUrl,group.TargetFrame);
/*AfterGroupSelected*/
	if(oEvent==null)oEvent=new ig_EventObject();
	oEvent.reset();
	oEvent.event=e;
	iglbar_fireEvent(group.Control,group.Control.Events.AfterGroupSelected[0],group,e,oEvent);
	if(oEvent!=null&&oEvent.needPostBack)__doPostBack(eval(group.Control.Id+"UniqueID"),group.Id+":GroupSelected");
	delete(oEvent);
}
//Internal Use Only
function iglbar_groupButtonMouseOver(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var group=iglbar_getGroupById(src.id);
	if(group==null||group.getSelected()||!group.getEnabled())return;
	var oEvent=iglbar_fireEvent(group.Control,group.Control.Events.MouseOver[0],group,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	delete(oEvent);
	src.className=group.ButtonHoverStyleClassName;
}
//Internal Use Only
function iglbar_groupButtonMouseOut(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var group=iglbar_getGroupById(src.id);
	var oEvent=iglbar_fireEvent(group.Control,group.Control.Events.MouseOut[0],group,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	delete(oEvent);
	if(group==null||group.getSelected()||!group.getEnabled())return;
	src.className=group.ButtonStyleClassName;
}

//Internal Use Only
function iglbar_itemClicked(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var item=iglbar_getItemById(src.id);
	if(!item.getEnabled())return;
	if(item==null||item.getSelected())return;
/*BeforeItemSelected*/
	var oEvent=iglbar_fireEvent(item.Group.Control,item.Group.Control.Events.BeforeItemSelected[0],item,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	item.setSelected(true);
/*AfterItemSelected*/
	if(oEvent==null)oEvent=new ig_EventObject();
	oEvent.reset();
	oEvent.event=e;
	iglbar_fireEvent(item.Group.Control,item.Group.Control.Events.AfterItemSelected[0],item,e,oEvent);
	if(oEvent!=null&&oEvent.needPostBack)__doPostBack(eval(item.Group.Control.Id+"UniqueID"),item.Id+":ItemSelected");
	delete(oEvent);
}
//Internal Use Only
function iglbar_itemMouseOver(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var item=iglbar_getItemById(src.id);
	var oEvent=iglbar_fireEvent(item.Group.Control,item.Group.Control.Events.MouseOver[0],item,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	delete(oEvent);
	if(item.getSelected()||!item.getEnabled())return;
	if(item.Group.ItemSelectionStyle==1&&item.getImage()!=null)
		item.getImage().className=item.HoverStyleClassName;
	else src.className=item.HoverStyleClassName;

}
//Internal Use Only
function iglbar_itemMouseOut(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");
	var item=iglbar_getItemById(src.id);
	var oEvent=iglbar_fireEvent(item.Group.Control,item.Group.Control.Events.MouseOut[0],item,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	delete(oEvent);
	if(item.getSelected()||!item.getEnabled())return;
	if(item.Group.ItemSelectionStyle==1&&item.getImage()!=null)
		item.getImage().className=item.DefaultStyleClassName;
	else src.className=item.DefaultStyleClassName;
}

function iglbar_navigate(targetUrl,targetFrame){
	ig.navigateUrl(targetUrl,targetFrame);
}

/**
* Listbar constructor.  Creates a new Listbar object with the specified id
* and Groups array.
* @param id - id of the Listbar control.
* @param groups - array of groups.  Depending on the ViewType, the groups
* could either be of type iglbar_ExplorerBarGroup or iglbar_ListbarGroup
**/

function UltraWebListbar(id,groups){
	this.Element=ig.getElementById(id);
	var props=eval(id+"_propsArray");
	this.Id=id;
	this.uniqueID=eval(id+"UniqueID");
	this.Groups=groups;
	this.Groups.valueChanged=false;
	var events=eval(id+"_eventArray");
	if(events==null)return;
	this.Events=new iglbar_Events(events);
	this.SelectedGroup=this.Groups[props[1]];
	if(this.SelectedGroup!=null)this.SelectedGroup.selected=true;
	this.SelectedItem=this.SelectedGroup.Items[props[2]];
	this.ViewType=props[3];
	this.findControl=function(id)
	{
		var control;
		var groupIndex=0;
		while(this.Groups[groupIndex]!=null)
		{
			control=this.Groups[groupIndex].findControl(id);
			if(control!=null)return control;
			groupIndex++;
		}
	}
	this.enabled=props[4];
	this.getEnabled=iglbar_getEnabled;
	this.setEnabled=iglbar_setEnabled;
	if(props[3]==1){
		this.AllowGroupMoving=props[5];
		this.HeaderClickAction=props[6];
		this.GroupExpandEffect=props[7];
	}
	if(this.SelectedItem!=null)this.SelectedItem.selected=true;
	var i=0;
	while(groups[i]!=null){
		groups[i].Control=this;
		if(groups[i].Key!=null&&groups[i].Key.length>0)
			groups[groups[i].Key]=groups[i];
		i++;
	}
	//this.Groups[SelectedGroup].Selected=true;
}
function iglbar_Events(events){
	this.AfterGroupSelected=events[0];
	this.AfterGroupCollapsed=events[1];
	this.AfterGroupExpanded=events[2];
	this.AfterItemSelected=events[3];
	this.BeforeGroupSelected=events[4];
	this.BeforeGroupCollapsed=events[5];
	this.BeforeGroupExpanded=events[6];
	this.BeforeItemSelected=events[7];
	this.InitializeListbar=events[8];
	this.MouseOver=events[9];
	this.MouseOut=events[10];
	this.BeforeGroupMove=events[11];
	this.AfterGroupMove=events[12];
	this.GroupDrag=events[13];
	this.HeaderClick=events[14];
	this.HeaderDoubleClick=events[15];
}

function iglbar_HeaderStyle(style,xpndImage,image,leftImage,rightImage){
	this.ClassName=style;
	this.ExpansionIndicatorImageUrl=xpndImage;
	this.ImageUrl=image;
	this.LeftCornerImageUrl=leftImage;
	this.RightCornerImageUrl=rightImage;
}
function iglbar_Header(xpnd,clpse,hover,xpandId,imageId,leftId,rightId){
	this.ExpandedAppearance=xpnd;
	this.CollapsedAppearance=clpse;
	this.HoverAppearance=hover;
	this.ExpansionIndicator=ig.getElementById(xpandId);
	this.Image=ig.getElementById(imageId);
	this.LeftCornerImage=ig.getElementById(leftId);
	this.RightCornerImage=ig.getElementById(rightId);
}
function iglbar_ExplorerBarGroup(id,text,key,enabled,groupStyle,headerAppearance,itemIconStyle,itemSelectionStyle,expanded,targetUrl,targetFrame,items){
	this.Id=id;
	this.Element=ig.getElementById(id+"_group");
	this.getText=iglbar_getGroupText;
	this.setText=iglbar_setGroupText;
	this.Key=key;
	this.enabled=enabled;
	this.getEnabled=iglbar_isGroupEnabled;
	this.setEnabled=iglbar_setEnabled;
	this.GroupStyleClassName=groupStyle;
	this.HeaderAppearance=headerAppearance;
	this.ItemIconStyle=itemIconStyle;
	this.ItemSelectionStyle=itemSelectionStyle;
	this.Items=items;
	this.Items.ValueChanged=false;
	this.TargetUrl=targetUrl;
	this.TargetFrame=targetFrame;
	this.findControl=function(id){
		return ig.findControl(this.Element,id);
	}
	this.expanded=expanded;
	this.getExpanded=iglbar_getExpanded;
	this.setExpanded=iglbar_expandGroup;
	this.getVisibleIndex=iglbar_getVisibleIndex;
	this.itemsHeight=null;
	var header=ig.getElementById(id+"_header");
	if(this.HeaderAppearance!=null&&header!=null){
		this.HeaderAppearance.Element=header;
		this.HeaderAppearance.Id=id+"_header";
	}
	this.valueChanged=false;
	var i=0;
	this.Control=null;
	if(items!=null){
		while(items[i]){
			items[i].Group=this;
			if(items[i].Key!=null&&items[i].Key.length>0)
				items[items[i].Key]=items[i];
			i++;
		}
	}
}
function iglbar_getExpanded(){
	return this.expanded;
}
function iglbar_ListbarGroup(id,text,key,enabled,groupStyle,buttonStyle,buttonHovStyle,buttonSelStyle,itemIconStyle,itemSelectionStyle,targetUrl,targetFrame,items){
	this.Id=id;
	this.topElement=ig.getElementById(id+"_top");
	this.bottomElement=ig.getElementById(id+"_bottom");
	this.Element=new Array(2);
	this.Element[0]=this.topElement;
	this.Element[1]=this.bottomElement;
	this.getText=iglbar_getGroupText;
	this.setText=iglbar_setGroupText;
	this.Key=key;
	this.enabled=enabled;
	this.getEnabled=iglbar_isGroupEnabled;
	this.setEnabled=iglbar_setEnabled;
	this.GroupStyleClassName=groupStyle;
	this.ButtonStyleClassName=buttonStyle;
	this.ButtonHoverStyleClassName=buttonHovStyle;
	this.ButtonSelectedStyleClassName=buttonSelStyle;
	this.ItemIconStyle=itemIconStyle;
	this.ItemSelectionStyle=itemSelectionStyle;
	this.Items=items;
	this.Items.ValueChanged=false;
	this.findControl=function(controlId){
		var grpIndex=this.Id.split("_");
		return ig.findControl(ig.getElementById(grpIndex[0]+"_Items_"+grpIndex[2]),controlId);
	}
	this.selected=false;
	this.getSelected=iglbar_getSelected;
	this.TargetUrl=targetUrl;
	this.TargetFrame=targetFrame;
	this.setSelected=iglbar_selectGroup;
	this.valueChanged=false;
	var i=0;
	this.Control=null;
	if(items!=null){
		while(items[i]){
			items[i].Group=this;
			if(items[i].Key!=null&&items[i].Key.length>0)
				items[items[i].Key]=items[i];
			i++;
		}
	}
}

function iglbar_Item(id,text,key,defStyle,hovStyle,selStyle,targetUrl,targetFrame,image,selectedImage,enabled){
	this.Id=id;
	this.Element=ig.getElementById(id);
	this.getText=iglbar_getItemText;
	this.setText=iglbar_setItemText;
	this.Key=key;
	this.DefaultStyleClassName=defStyle;
	this.HoverStyleClassName=hovStyle;
	this.SelectedStyleClassName=selStyle;
	this.TargetUrl=targetUrl;
	this.TargetFrame=targetFrame;
	this.Group=null;
	this.ImageUrl=image;
	this.SelectedImageUrl=selectedImage;
	this.getImage=iglbar_getImage;
	this.selected=false;
	this.setSelected=iglbar_selectItem;
	this.getSelected=iglbar_getSelected;
	this.valueChanged=false;
	this.enabled=enabled;
	this.getEnabled=iglbar_isItemEnabled;
	this.setEnabled=iglbar_setEnabled;
}
function iglbar_getSelected()
{
	return this.selected;
}
function iglbar_getEnabled(){
	return this.enabled;
}
function iglbar_isGroupEnabled(){
	return this.enabled&&this.Control.getEnabled();
}
function iglbar_isItemEnabled(){
	return this.enabled&&this.Group.getEnabled();
}
function iglbar_setEnabled(enabled){
	this.enabled=enabled;
	if(enabled)this.Element.removeAttribute("disabled");
	else this.Element.setAttribute("disabled","disabled");
}
function iglbar_toggleGroup(e,src){
	e = (e) ? e : ((window.event) ? window.event : "");	
	var group=iglbar_getGroupById(src.id);
	if(!group.getEnabled())return true;
	var oEvent;
	if(group.getExpanded())
		oEvent=iglbar_fireEvent(group.Control,group.Control.Events.BeforeGroupCollapsed[0],group,e);
	else oEvent=iglbar_fireEvent(group.Control,group.Control.Events.BeforeGroupExpanded[0],group,e);
	if(oEvent!=null&&oEvent.cancel){
		delete(oEvent);
		return;
	}
	if(oEvent==null)oEvent=new ig_EventObject();
	oEvent.reset();
	group.setExpanded(!group.getExpanded(),true);
	if(group.getExpanded())
		iglbar_fireEvent(group.Control,group.Control.Events.AfterGroupExpanded[0],group,e,oEvent);
	else iglbar_fireEvent(group.Control,group.Control.Events.AfterGroupCollapsed[0],group,e,oEvent);
	if(oEvent.needPostBack||(group.getExpanded()&&group.Control.Events.AfterGroupExpanded[1])||((!group.getExpanded())&&group.Control.Events.AfterGroupCollapsed[1]))__doPostBack(eval(group.Control.Id+"UniqueID"),group.Id+":"+(group.getExpanded()?"GroupExpanded":"GroupCollapsed"));
	delete(oEvent);
	if(src.tagName=="IMG"){
		e.cancelBubble=true;
		return false;
	}
}
function iglbar_expandGroup(expand,byMouse){
	if((!this.getEnabled())&&byMouse)return;
	this.expanded=expand;
	if(expand){
		ig.getElementById(this.Id+"_items").style.display="";
		this.HeaderAppearance.ExpansionIndicator.src=this.HeaderAppearance.ExpandedAppearance.ExpansionIndicatorImageUrl;
		ig.getElementById(this.Id+"_header").className=this.HeaderAppearance.ExpandedAppearance.ClassName;
		if(this.HeaderAppearance.LeftCornerImage!=null)
			this.HeaderAppearance.LeftCornerImage.src=this.HeaderAppearance.ExpandedAppearance.LeftCornerImageUrl;
		if(this.HeaderAppearance.RightCornerImage!=null)
			this.HeaderAppearance.RightCornerImage.src=this.HeaderAppearance.ExpandedAppearance.RightCornerImageUrl;
		if(this.HeaderAppearance.Image!=null)
			this.HeaderAppearance.Image.src=this.HeaderAppearance.ExpandedAppearance.ImageUrl;
		if(this.Control.GroupExpandEffect==0){
			if(this.ExpandEffect==null)this.ExpandEffect=new iglbar_expandEffect(this);
			this.ExpandEffect.Expand(true);
		}
	}
	else{
		if(this.Control.GroupExpandEffect==0){
			if(this.ExpandEffect==null)this.ExpandEffect=new iglbar_expandEffect(this);
			this.ExpandEffect.Expand(false);
		}else ig.getElementById(this.Id+"_items").style.display="none";
		this.HeaderAppearance.ExpansionIndicator.src=this.HeaderAppearance.CollapsedAppearance.ExpansionIndicatorImageUrl;
		ig.getElementById(this.Id+"_header").className=this.HeaderAppearance.CollapsedAppearance.ClassName;
		if(this.HeaderAppearance.LeftCornerImage!=null)
			this.HeaderAppearance.LeftCornerImage.src=this.HeaderAppearance.CollapsedAppearance.LeftCornerImageUrl;
		if(this.HeaderAppearance.RightCornerImage!=null)
			this.HeaderAppearance.RightCornerImage.src=this.HeaderAppearance.CollapsedAppearance.RightCornerImageUrl;
		if(this.HeaderAppearance.Image!=null)
			this.HeaderAppearance.Image.src=this.HeaderAppearance.CollapsedAppearance.ImageUrl;
	}
	iglbar_updatePostField(this.Control);
	if(byMouse)iglbar_groupHeaderMouseOver(null,this.HeaderAppearance.Element);
}
function iglbar_Slide(expand){
	clearInterval(this.ShrinkProcess);
	if(this.Group.itemsHeight==null)this.Group.itemsHeight=this.ItemsArea.offsetHeight;
	this.AlphaConstant=100/parseInt(this.Group.itemsHeight);
	if(ig.IsIE)this.ItemsArea.style.overflowY="hidden";
	else this.ItemsArea.style.overflow="hidden";
	myid=this.Group.Id;

	if(expand){
		this.ItemsArea.offsetParent.style.filter="alpha(opacity=1)";
		this.ItemsArea.style.height=1;
		this.ItemsArea.offsetParent.style.height=1;
 		this.Opacity=1;
		this.ShrinkProcess=setInterval("iglbar_SlideDown('"+myid+"')",10);
	}
	else{
		this.ItemsArea.offsetParent.style.filter="alpha(opacity=100)";
		this.ItemsArea.style.height=this.Group.itemsHeight;
		this.ItemsArea.offsetParent.style.height=this.Group.itemsHeight;
 		this.Opacity=100;
		this.ShrinkProcess=setInterval("iglbar_SlideUp('"+myid+"')",10);
	}
}
function iglbar_SlideDown(groupId){
	var expandEffect=iglbar_getGroupById(groupId).ExpandEffect;
	var curHeight=parseInt(expandEffect.ItemsArea.style.height);

	if((parseInt(expandEffect.Group.itemsHeight)-curHeight)<11){
		clearInterval(expandEffect.ShrinkProcess);
		expandEffect.ItemsArea.style.height=expandEffect.Group.itemsHeight;//(6*(originalHeight/curHeight));
		expandEffect.ItemsArea.offsetParent.style.height=expandEffect.ItemsArea.style.height;
		if(expandEffect.ItemsArea.filters)expandEffect.ItemsArea.offsetParent.filters[0].opacity=100;
		shrinkProcess=null;
		return;
	}
	expandEffect.ItemsArea.style.height=(parseInt(expandEffect.ItemsArea.style.height)+10);//(6*(originalHeight/curHeight));
	expandEffect.ItemsArea.offsetParent.style.height=expandEffect.ItemsArea.style.height;
	expandEffect.Opacity=expandEffect.Opacity+(10*expandEffect.AlphaConstant);
	if(expandEffect.ItemsArea.filters)expandEffect.ItemsArea.offsetParent.filters[0].opacity=expandEffect.Opacity;//itemsArea.offsetParent.filters[0].opacity-alphaConst;
}
function iglbar_SlideUp(groupId){
	var expandEffect=iglbar_getGroupById(groupId).ExpandEffect;
	var curHeight=parseInt(expandEffect.ItemsArea.style.height);

	if(curHeight<11){
		clearInterval(expandEffect.ShrinkProcess);
		expandEffect.ItemsArea.style.height=1;//(6*(originalHeight/curHeight));
		expandEffect.ItemsArea.offsetParent.style.height=1;
		if(expandEffect.ItemsArea.filters)expandEffect.ItemsArea.offsetParent.filters[0].opacity=0;
		shrinkProcess=null;
		ig.getElementById(expandEffect.Group.Id+"_items").style.display="none";
		return;
	}
	expandEffect.ItemsArea.style.height=(parseInt(expandEffect.ItemsArea.style.height)-10);//(6*(originalHeight/curHeight));
	expandEffect.ItemsArea.offsetParent.style.height=expandEffect.ItemsArea.style.height;
	expandEffect.Opacity=expandEffect.Opacity-(10*expandEffect.AlphaConstant);
	if(expandEffect.ItemsArea.filters)expandEffect.ItemsArea.offsetParent.filters[0].opacity=expandEffect.Opacity;//itemsArea.offsetParent.filters[0].opacity-alphaConst;
}

function iglbar_expandEffect(group){
	this.ShrinkProcess=0;
	this.ItemsArea=ig.getElementById(group.Id+"_items").firstChild;
	while(this.ItemsArea!=null&&this.ItemsArea.tagName!="TD"){this.ItemsArea=this.ItemsArea.nextSibling;}
	if(this.ItemsArea==null||this.ItemsArea.tagName!="TD")return;
	this.ItemsArea=this.ItemsArea.firstChild;
	while(this.ItemsArea!=null&&this.ItemsArea.tagName!="DIV"){this.ItemsArea=this.ItemsArea.nextSibling;}
	
	this.Group=group;
	this.Opacity=100;
	this.Expand=iglbar_Slide;
}
function iglbar_getItemText(){
	return iglbar_getInnerText(ig.getElementById(this.Id));
}
function iglbar_setItemText(text){
	iglbar_setInnerText(ig.getElementById(this.Id),text);
	this.valueChanged=this.Group.Items.valueChanged=this.Group.Control.Groups.valueChanged=true;
	iglbar_updatePostField(this.Group.Control);
}
function iglbar_getImage(){
	return ig.getElementById(this.Id+"_img");
}
function iglbar_getGroupText(){
	if(this.HeaderAppearance)
		return iglbar_getInnerText(ig.getElementById(this.Id+"_text"));
	else
		return iglbar_getInnerText(ig.getElementById(this.Id+"_text_top"));
}
function iglbar_setGroupText(text){
	if(this.HeaderAppearance){
		iglbar_setInnerText(ig.getElementById(this.Id+"_text"),text);
	}else
	{
		var buttonTop=ig.getElementById(this.Id+"_text_top");
		var buttonBot=ig.getElementById(this.Id+"_text_bottom");
		iglbar_setInnerText(buttonTop,text);
		iglbar_setInnerText(buttonBot,text);
	}
	this.valueChanged=true;
	this.Control.Groups.valueChanged=true;
	iglbar_updatePostField(this.Control);
}
function iglbar_selectGroup(select){
/*******
 * We only care about group.Element[0] which is the button which appears in the top
 * Group of buttons.  Since this style is only applied when a group is selected, it
 * will never be applied to the bottom list of groups.
 ******/  
	if(select){
		if(this.Control!=null&&this.Control.Events.AfterGroupSelected[1])__doPostBack(eval(this.Control.Id+"UniqueID"),this.Id+":GroupSelected");
		if(this.Control.SelectedGroup!=null)this.Control.SelectedGroup.setSelected(false);
		this.selected=true;
		this.Control.SelectedGroup=this;
		this.Element[0].className=this.ButtonSelectedStyleClassName;
		this.Element[1].className=this.ButtonStyleClassName; //The button may not receive the mouseout event.  In this case, we need to change the style back to the Default style manually.
		iglbar_updatePostField(this.Control);
		iglbar_adjust(this.Control);
	}else{
		this.selected=false;
		if(this.Control.SelectedGroup==this)this.Control.SelectedGroup=null;
		this.Element[0].className=this.ButtonStyleClassName;
	}
}
function iglbar_selectItem(select){
	if(select){
		if(this.Group.Control!=null&&this.Group.Control.Events.AfterItemSelected[1])__doPostBack(eval(this.Group.Control.Id+"UniqueID"),this.Id+":ItemSelected");
		if(this.Group.Control.SelectedItem!=null)this.Group.Control.SelectedItem.setSelected(false);
		this.Group.Control.SelectedItem=this;
		this.selected=true;
		iglbar_navigate(this.TargetUrl,this.TargetFrame);
		if(this.Group.ItemSelectionStyle==1&&this.getImage()!=null)
			this.getImage().className=this.SelectedStyleClassName;
		else this.Element.className=this.SelectedStyleClassName;
		if(this.SelectedImageUrl!=null&&this.SelectedImageUrl.length>0)
			this.getImage().src=this.SelectedImageUrl;
	}else{
		if(this.Group.Control.SelectedItem!=this)this.Group.Control.SelectedItem=null;
		this.selected=false;
		if(this.Group.ItemSelectionStyle==1&&this.getImage()!=null)
			this.getImage().className=this.DefaultStyleClassName;
		else this.Element.className=this.DefaultStyleClassName;
		if(this.ImageUrl!=null&&this.ImageUrl.length>0)
			this.getImage().src=this.ImageUrl;	
	}
	iglbar_updatePostField(this.Group.Control);
}

function iglbar_updatePostField(listbar){
	if(listbar==null)return;
	var postData="";
	var i=0;

	if(listbar.ViewType==0)postData="SelectGroup\02"+listbar.SelectedGroup.Id+"\01";

	else{
		postData="ExpandGroup";
		while(listbar.Groups!=null&&listbar.Groups[i]!=null){
			var expandedData="\02"+(listbar.Groups[i].getExpanded()?"true":"false");
			postData+=expandedData;
			i++;
		}
		postData+="\01";

	}
	
	if(listbar.SelectedItem!=null)postData+="SelectItem\02"+listbar.SelectedItem.Id+"\01";
	i=0;
	if(listbar.Groups.valueChanged){
		var newOrder="GroupSwapped";
		while(listbar.Groups[i]!=null){
			newOrder+="\02"+listbar.Groups[i].getVisibleIndex().toString();
			if(listbar.Groups[i].valueChanged){
				postData+="GroupTextChanged\02"+listbar.Groups[i].Id+"\02"+listbar.Groups[i].getText()+"\01";
			}
			if(listbar.Groups[i].Items.valueChanged){
				var j=0;
				while(listbar.Groups[i].Items[j]!=null){
					if(listbar.Groups[i].Items[j].valueChanged){
						postData+="ItemTextChanged\02"+listbar.Groups[i].Items[j].Id+"\02"+listbar.Groups[i].Items[j].getText()+"\01";
					}
					j++;
				}
			}
			
			i++;
		}
		postData+=newOrder;
	}
	ig.getElementById(listbar.uniqueID+"_hidden").value=postData;
}

function iglbar_setInnerText(sourceElement,str){
	if(ig.IsIE)
		iglbar_setInnerTextIE(sourceElement,str);
	else
	{
		iglbar_setInnerTextNN(sourceElement,str);
	}

}
function iglbar_setInnerTextIE(sourceElement,str)
{
	sourceElement.innerText=str;
}
function iglbar_setInnerTextNN(sourceElement,str)
{
	var res="";
	for(var i=0;i<str.length;i++)
	{
		switch(str.charAt(i))
		{
			case ' ':
				res+="&nbsp;";
				break;
			case '<':
				res+="&lt;";
				break;
			case '>':
				res+="&gt;";
				break;
			case '&':
				res+="&amp;";
				break;
			case '"':
				res+="&quot;";
				break;
			default:
				res+=str.charAt(i);
				break;
		}
	}
	sourceElement.innerHTML=res;
}

function iglbar_getInnerText(sourceElement){
	if(ig.IsIE)
		return iglbar_getInnerTextIE(sourceElement);
	else
	{
		return iglbar_getInnerTextNN(sourceElement);
	}
}
function iglbar_getInnerTextIE(sourceElement)
{
	return sourceElement.innerText;
}
function iglbar_getInnerTextNN(sourceElement)
{
	var res="";
	var str=sourceElement.innerHTML;
	for(var i=0;i<str.length;i++)
	{
		if(str.length-i>=6 && str.substr(i,6)=="&nbsp;")
		{
			res+=' ';
			i+=6;
		}
		else if(str.length-i>=6 && str.substr(i,6)=="&quot;")
		{
			res+='"';
			i+=6;
		}
		else if(str.length-i>=5 && str.substr(i,5)=="&amp;")
		{
			res+='&';
			i+=5;
		}
		else if(str.length-i>=4 && str.substr(i,4)=="&lt;")
		{
			res+='<';
			i+=4;
		}
		else if(str.length-i>=4 && str.substr(i,4)=="&gt;")
		{
			res+='>';
			i+=4;
		}
		else
			res+=str.charAt(i);
	}
	return res;
}
function iglbar_killEvent(evt){
	evt = (evt) ? evt : ((window.event) ? window.event : "");
	evt.cancelBubble=true;
	return false;
}
function iglbar_pickupGroup(evt,source){
	evt = (evt) ? evt : ((window.event) ? window.event : "");
	if(iglbar_getListbarById(source.id).AllowGroupMoving!=1)return true;
	iglbar_SourceGroup=ig.getElementById(source.id+"_group");
	var oGroup=iglbar_getGroupById(source.id);
	var oEvent=iglbar_fireEvent(oGroup.Control,oGroup.Control.Events.BeforeGroupMove[0],oGroup,evt);
	if(!oGroup.getEnabled()||(oEvent!=null&&oEvent.cancel)){
		delete(oEvent);
		return true;
	}
	iglbar_CurrentX =(evt.pageX?evt.pageX:(evt.clientX + document.body.scrollLeft));
	iglbar_CurrentY =(evt.pageY?evt.pageY:(evt.clientY + document.body.scrollTop));
	if(ig.IsIE){
		iglbar_SourceGroup.onmouseup=iglbar_dropGroup;
		iglbar_SourceGroup.setCapture();
	}else{
		 document.onmouseup=iglbar_dropGroup;
	}
	iglbar_AllowMove=1;
	delete(oEvent);
	return true;
}
function iglbar_MoveGroup(e){
	var evt=e?e:event;
	if(iglbar_AllowMove>0)
	{
		if(!e)
		{//Check for IE.  If button is not down, drop.
			if(evt.button!=1){
				return iglbar_dropGroup(evt);
			}
		}else if(evt.button!=0)return iglbar_dropGroup(evt);
	    
		NewX = evt.pageX?(evt.pageX):(document.body.scrollLeft+evt.clientX);
		NewY = evt.pageY?(evt.pageY):(document.body.scrollTop+evt.clientY);
		DistanceX = (NewX - iglbar_CurrentX);
		DistanceY = (NewY - iglbar_CurrentY);
		if(DistanceX>3||DistanceY>3||DistanceY<-3||DistanceX<-3)
			iglbar_startDrag(evt);
		if(iglbar_AllowMove==1)return;
		var oGroup=iglbar_getGroupById(iglbar_SourceGroup.id);
		
		if(oGroup.Control.Events.GroupDrag[0]!=null&&oGroup.Control.Events.GroupDrag[0].length>0){
			var oEvent=new ig_EventObject();
			oEvent.event=evt;
			ig_fireEvent(oGroup.Control,oGroup.Control.Events.GroupDrag[0],oGroup,iglbar_CloneGroup,evt);
			if(oEvent!=null&&oEvent.cancel){
				delete(oEvent);
				iglbar_dropGroup(evt);
				return;
			}
			delete(oEvent);
		}
		iglbar_CurrentX = NewX;
		iglbar_CurrentY = NewY;
		iglbar_CloneGroup.style.left=(parseInt(iglbar_CloneGroup.style.left)+DistanceX).toString();//+"px";
		iglbar_CloneGroup.style.top=(parseInt(iglbar_CloneGroup.style.top)+DistanceY).toString();//+"px";
	}
	
	return true;

}
function iglbar_startDrag(evt){
	if(iglbar_AllowMove==2)return;
	iglbar_AllowMove=2;
	var groupPosition=iglbar_getPosition(iglbar_SourceGroup);
	var width=iglbar_SourceGroup.offsetWidth;
	iglbar_CloneGroup=iglbar_SourceGroup.cloneNode(true);
	iglbar_CloneGroup.style.position="absolute";
	iglbar_CloneGroup.style.left=groupPosition.x;
	iglbar_CloneGroup.style.top=groupPosition.y;
	iglbar_CloneGroup.style.filter="progid:DXImageTransform.Microsoft.Alpha(opacity=50)";	
	iglbar_CloneGroup.style.width=width;
	iglbar_CloneGroup.style.zIndex=1000;
	document.body.appendChild(iglbar_CloneGroup);
	document.body.style.cursor="move";
}

function iglbar_getPosition(el){
	for (var lx=0,ly=0;el!=null;lx+=(el.offsetLeft-el.scrollLeft),ly+=(el.offsetTop-el.scrollTop),el=el.offsetParent);
	return {x:lx+(window.pageXOffset?window.pageXOffset:(document.body.scrollLeft?document.body.scrollLeft:0)),y:(ly+(window.pageYOffset?window.pageYOffset:(document.body.scrollTop?document.body.scrollTop:0)))}
}
function iglbar_dropGroup(evt){
	evt = (evt) ? evt : ((window.event) ? window.event : "");
	if(iglbar_AllowMove>0){
		var group=iglbar_getGroupById(iglbar_SourceGroup.id);
		if(ig.IsIE){
			iglbar_SourceGroup.onmouseup="";
			iglbar_SourceGroup.releaseCapture();
		}
		if(iglbar_AllowMove==1){
			iglbar_AllowMove=0;
			return true;
		}
		iglbar_AllowMove=0;			
		var listbar=iglbar_getListbarById(iglbar_SourceGroup.id);
		var i=0;
		var insertGroup=iglbar_SourceGroup;
		var oldY=0;
		while(listbar.Groups[i]!=null){
			var newY=parseInt(iglbar_getPosition(listbar.Groups[i].Element).y);
			if(newY<parseInt(iglbar_CloneGroup.style.top)&&newY>oldY&&insertGroup.tagName=="TABLE"){
				insertGroup=listbar.Groups[i].Element;
				oldY=newY;
			}
			i++;
		}
		document.body.removeChild(iglbar_CloneGroup);
		if(iglbar_SourceGroup!=insertGroup||(iglbar_SourceGroup==insertGroup&&oldY==0))
		{
			if(oldY==0)
			{
				insertGroup.offsetParent.insertBefore(iglbar_SourceGroup,insertGroup.offsetParent.firstChild);
			}else if(insertGroup.nextSibling)
			{
				insertAtElement=insertGroup.nextSibling;
				while(insertAtElement!=null&&insertAtElement.tagName!="TABLE")insertAtElement=insertAtElement.nextSibling;
				if(insertAtElement!=null&&insertAtElement.tagName=="TABLE")insertGroup.offsetParent.insertBefore(iglbar_SourceGroup,insertAtElement);
				else insertGroup.offsetParent.appendChild(iglbar_SourceGroup);
			}else insertGroup.offsetParent.appendChild(iglbar_SourceGroup);
			
			listbar.Groups.valueChanged=true;
			iglbar_updatePostField(listbar);
		}
		var image=group.HeaderAppearance.Image;
		if(image!=null)
		{
			image.style.visibility="hidden";
			image.style.visibility="visible";
		}
		if(!(ig.IsIE)){
			iglbar_fixNetscapeImages(listbar.Groups);
		}
		document.body.style.cursor="default";
		var oEvent=(iglbar_fireEvent(group.Control,group.Control.Events.AfterGroupMove[0],group,evt));
		delete(oEvent);
	}
	return true;
}
function iglbar_fixNetscapeImages(Groups){
	var i=0;
	if(Groups==null)return;
	while(Groups[i]!=null){
		if(Groups[i].HeaderAppearance.Image!=null){
			Groups[i].HeaderAppearance.Image.style.visibility="hidden";		
			Groups[i].HeaderAppearance.Image.style.visibility="visible";
		}
		i++;
	}
}

function iglbar_getVisibleIndex(){
	var currentGroup=this.Element.offsetParent.firstChild;
	var i=0;
	while(currentGroup!=null&&currentGroup!=this.Element){if(currentGroup.tagName=="TABLE")i++;currentGroup=currentGroup.nextSibling}
	return i;
}
function iglbar_fireEvent(listbar,name,target,browserEvent){
	var oEvent;
	if(name==null||name.length<=0)return null;
	if(iglbar_fireEvent.arguments.length>4)
		oEvent=iglbar_fireEvent.arguments[4];
	else oEvent=new ig_EventObject();
	oEvent.event=browserEvent;
	ig_fireEvent(listbar,name,target,oEvent);
	return oEvent;
}