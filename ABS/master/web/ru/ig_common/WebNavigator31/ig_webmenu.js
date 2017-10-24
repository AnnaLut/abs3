/* 
Infragistics Hierarchical Menu Script 
Version 3.1.20041.20
Copyright (c) 2001-2004 Infragistics, Inc. All Rights Reserved.
Comments:
Functions marked public are for use by developers and are documented and supported.
Functions marked private are for the internal use of the UltraWebMenu component and are not 
documented for use by developers and are not supported for use by developers
*/

var ig_currentMenu;
var ig_menuPopup = null;
var ig_menuObject = null;
var igmenu_initialized = false;

var statcount = 0;
// public - Obtains a menu Item object using its id
function igmenu_getItemById(itemId) {
	var oItem = igmenu_itemarray[itemId];
	if(oItem)
		return oItem;	
	var item=igmenu_getElementById(itemId);
	if(!item)
		return null;
	oItem = new igmenu_initItem(item);
	igmenu_itemarray[itemId] = oItem;
	return oItem;
}

// public - Obtains a menu object using its id
function igmenu_getMenuById(menuId) {
	return igmenu_array[menuId];
}

// public - returns the menu object for the Item Id
function igmenu_getMenuByItemId(itemId) {
	var mn = igmenu_getMenuNameByItemId(itemId);  
	return igmenu_array[mn];
}

// public - returns the Menu Name (mn) from an itemId
function igmenu_getMenuNameByItemId(itemId) {
   var menuName = itemId;
   var strArray = menuName.split("_");
   menuName = strArray[0];
   return menuName;
}

// public - Retrieves an element by its tag name in a browser independant way
function igmenu_getElementById(id) {
	return ig_csom.getElementById(id);
}

// Warning: Private functions for internal component usage only
// The functions in this section are not intended for general use and are not supported
// or documented.

// private - Performed on page initialization
function igmenu_initialize() {
	var agentName=navigator.userAgent.toLowerCase();
	ig_csom.addEventListener(document, "mousedown", igmenu_mouseDown, true);
	ig_csom.addEventListener(document, "mouseup", igmenu_mouseUp, true);
	ig_currentMenu = null;
	ig_menuPopup = null;
}

var igmenu_array=[];
var igmenu_itemarray=[];
var igmenu_dropDowns;

// private - initializes the menu object on the client
function igmenu_initMenu(menuId) {
	
   if(!igmenu_initialized) {
	  igmenu_initialize();
	  igmenu_intialized = true;
   }

   var menuElement = igmenu_getElementById(menuId+"_MainM");
   var menu = new igmenu_menu(menuElement,eval("igmenu_"+menuId+"_Menu"));
   igmenu_array[menuId] = menu;
   menu.fireEvent(menu.Events.InitializeMenu,"(\""+menuId+"\");");
   
   if(!ig_csom.IsIE)
		menu.HideDropDowns = false;
		
   if(!ig_csom.IsIE55Plus && menu.HideDropDowns==true && igmenu_dropDowns==null) {
		igmenu_dropDowns = document.all.tags("SELECT");
   }
   menu.MenuLoaded=true;
   return menu;
}

// private - constructor for the menu scroll object
function igmenu_scroller(subMenuElement) {
	this.subMenu = subMenuElement;
	this.fullHeight = this.subMenu.offsetHeight;
	this.active = false;
	this.ms = igmenu_getMenuByItemId(this.subMenu.id);
	
	// private - implements the showing and hiding of submenus
	this.addScroll = function() {
		this.scrollDiv = this.subMenu.firstChild
		this.table = this.scrollDiv.firstChild;
		this.topDiv = window.document.createElement("DIV");
		this.topDiv.topDiv = true;
		this.bottomDiv = window.document.createElement("DIV");
		this.bottomDiv.bottomDiv = true;
		
		this.topDiv.style.cssText = "padding-left:46%;";
		this.bottomDiv.style.cssText = "padding-left:46%;";
		
		// add image elements to top and bottom divs
		var img = window.document.createElement("IMG");
		img.src = this.ms.ScrollImageTopDisabled;
		this.topDiv.appendChild(img);
		img = window.document.createElement("IMG");
		img.src = this.ms.ScrollImageBottom;
		this.bottomDiv.appendChild(img);
		
		// top and bottom divs to the document object
		this.subMenu.insertBefore(this.topDiv, this.subMenu.firstChild);
		this.subMenu.appendChild(this.bottomDiv);
		
		if(!ig_csom.isEmpty(this.ms.DefaultItemClass)) {
			this.topDiv.className = this.ms.DefaultItemClass;
			this.bottomDiv.className = this.ms.DefaultItemClass;
		}
		// Add mouse event listeners to top and bottom divs
		ig_csom.addEventListener(this.topDiv, "mouseover", igmenu_onScrollMouseOver, true);
		ig_csom.addEventListener(this.bottomDiv, "mouseover", igmenu_onScrollMouseOver, true);
		ig_csom.addEventListener(this.topDiv, "mouseout", igmenu_onScrollMouseOut, true);
		ig_csom.addEventListener(this.bottomDiv, "mouseout", igmenu_onScrollMouseOut, true);
	}
	this.setScrollHeight = function(scrollHeight) {
		if(scrollHeight >= 0)
			this.scrollDiv.style.height=scrollHeight;
	}
	this.getScrollHeight = function() {
		return this.scrollDiv.style.height;
	}
	this.show = function() {
		if(this.topDiv.innerHTML.indexOf(this.ms.ScrollImageTopDisabled) == -1)
			this.topDiv.innerHTML = "<img src='" + this.ms.ScrollImageTopDisabled + "'>"
		if(this.bottomDiv.innerHTML.indexOf(this.ms.ScrollImageBottom) == -1)
			this.bottomDiv.innerHTML = "<img src='" + this.ms.ScrollImageBottom + "'>"

		this.scrollDiv.scrollTop = 0;
		this.scrollDiv.style.overflow="hidden";
		this.topDiv.style.display="";
		this.topDiv.style.visibility="visible";
		this.bottomDiv.style.display="";
		this.bottomDiv.style.visibility="visible";
		this.active = true;
	}
	this.hide = function() {
		this.topDiv.style.display="none";
		this.topDiv.style.visibility="hidden";
		this.bottomDiv.style.display="none";
		this.bottomDiv.style.visibility="hidden";
		this.subMenu.style.height = this.fullHeight;
		this.scrollDiv.style.overflow="";
		this.active = false;
	}
	this.addScroll();
}
// private - constructor for the menu object
function igmenu_menu(menuElement,menuProps) {
	this.MenuId = menuElement.id;
	this.MenuElement = menuElement;
	this.Id = menuElement.id;
	this.Element = menuElement;
	this.UniqueId=menuProps[0];
	this.MenuTarget=menuProps[1];
	this.WebMenuStyle=menuProps[2];
	this.HoverClass=menuProps[4];
	this.TopSelectedClass=menuProps[5];
	this.ExpandEffects = new igmenu_expandEffects(menuProps[8], menuProps[9], menuProps[10], menuProps[11], menuProps[12], menuProps[13], menuProps[14]);
	this.CheckedImage=menuProps[15];
	this.UncheckedImage=menuProps[16];
	this.DisabledClass=menuProps[17];
	this.DefaultItemClass=menuProps[18];
	this.ScrollImageTop=menuProps[19];
	this.ScrollImageTopDisabled=menuProps[20];
	this.ScrollImageBottom=menuProps[21];
	this.ScrollImageBottomDisabled=menuProps[22];
	this.LeftHandDisplay=menuProps[23];
	this.CurrentLeftHandDisplay=this.LeftHandDisplay
	this.HideDropDowns=menuProps[24];
	this.TargetUrl=menuProps[25];
	this.TargetFrame=menuProps[26];
	this.getItems = function ()	{
		var itemAr=new Array();
		var itemCount=0;
		var uniqueId = this.getClientUniqueId();
		var item=igmenu_getItemById(uniqueId+"_1");
		while(item)	{
			itemAr[itemCount++]=igmenu_getItemById(item.Id);
			item=item.getNextSibling();
		}
		return itemAr;
	}

	// private
	this.getClientUniqueId = function() {
		var u = this.UniqueId.replace(/:/gi, "");
		u = u.replace(/_/gi, "");
		return u;
	}
	var uniqueId = this.getClientUniqueId();
	this.Events=new igmenu_events(eval("igmenu_"+uniqueId+"_Events"));
	this.MenuLoaded=false;
	this.NeedPostBack=false;
	this.CancelPostBack=false;
	this.TopHoverStarted=false;
	
	// private - Fires an event to client-side script and then to the server if necessary
	this.fireEvent = function (eventObj,eventString)
	{
		var result=false;
		if(eventObj[0]!="")
			result=eval(eventObj[0]+eventString);
		if(this.MenuLoaded && result!=true && eventObj[1]==1 && !this.CancelPostBack)
			this.NeedPostBack=true;
		this.CancelPostBack=false;
		return result;
	}

	// private - displays top level submenus for horizontal positioning
	this.displayHorizontalSubMenu = function (parentItem, MenuId) {
		var subMenu = igmenu_getElementById(MenuId);
		subMenu.parentMenu = igmenu_getSubMenu(parentItem);
		igmenu_treeCreate(this, subMenu);
		this.displaySubMenu(subMenu, parentItem, false);
	}
	
	// private - displays top level submenus for vertical positioning
	this.displayVerticalSubMenu = function (parentItem, MenuId) {
		var subMenu = igmenu_getElementById(MenuId);
		subMenu.parentMenu = igmenu_getSubMenu(parentItem);
		igmenu_treeCreate(this, subMenu);
		this.hoverItem(parentItem);
		this.displaySubMenu(subMenu, parentItem, true);
	}
	
	// private - displays sub menus beneath top-level submenus.
	this.displaySubSubMenu = function (parentItem, MenuId) {
		var subMenu = igmenu_getElementById(MenuId);
		subMenu.parentMenu = igmenu_getSubMenu(parentItem);
		this.clearDescendants(subMenu.parentMenu, true);
		this.displaySubMenu(subMenu, parentItem, true);
		igmenu_menuTreeAdd(subMenu);
	}
	
	// private - implements the showing and hiding of submenus
	this.displaySubMenu = function(subMenu, parentItem, vertical) {
		var type		= this.ExpandEffects.Type;
		var duration	= this.ExpandEffects.Duration/1000;;
		var opacity		= this.ExpandEffects.Opacity;
		var shadowWidth = this.ExpandEffects.ShadowWidth;
		var shadowColor = this.ExpandEffects.ShadowColor;
		if(subMenu.style.visibility != "hidden")
			return;
			
		if(ig_csom.IsIE55Plus && this.HideDropDowns) {	
			if(subMenu.transPanel==null) {	
				subMenu.transPanel=ig_csom.createTransparentPanel();
			}
		}
		igmenu_callDisplayMenu(true, subMenu.id);
		var mn=igmenu_getMenuNameByItemId(subMenu.id);
		if(this.fireEvent(this.Events.SubMenuDisplay,"(\""+mn+"\",\""+subMenu.id+"\", true)"))
			return;


		if(ig_csom.IsMac || (subMenu.style.filter == null)) {
			subMenu.style.visibility='visible';
			subMenu.style.display="";
		}
		else
		if(type != 'NotSet') {
			subMenu.style.filter = "progid:DXImageTransform.Microsoft."+type+"(duration="+duration+");"
			if(shadowWidth > 0)
				subMenu.style.filter += " progid:DXImageTransform.Microsoft.Shadow(Direction=135, Strength="+shadowWidth+",color="+shadowColor+");"
			if(opacity < 100)
				subMenu.style.filter += " progid:DXImageTransform.Microsoft.Alpha(Opacity="+opacity+");"
			if(subMenu.filters[0] != null)
	        	subMenu.filters[0].apply();
			subMenu.style.visibility='visible'
			subMenu.style.display="";
			if(subMenu.filters[0] != null)
				subMenu.filters[0].play();
		}
		else {
			if(shadowWidth > 0)
				subMenu.runtimeStyle.filter = "progid:DXImageTransform.Microsoft.Shadow(Direction=135, Strength="+shadowWidth+",color="+shadowColor+");"
			if(opacity < 100)
				subMenu.runtimeStyle.filter += " progid:DXImageTransform.Microsoft.Alpha(Opacity="+opacity+");"
			subMenu.style.visibility='visible';
			subMenu.style.display="";
		}
				
		if(subMenu.style.width == "") {
			subMenu.style.width = subMenu.offsetWidth + 15;
			if(ig_csom.IsNetscape6 || ig_csom.IsMac) {
				if(subMenu.childNodes.length == 1) {
					subMenu.childNodes[0].style.width = subMenu.style.width;
					subMenu.childNodes[0].childNodes[0].style.width = subMenu.style.width;
			   	}
				else {
					subMenu.childNodes[1].style.width = subMenu.style.width;
					subMenu.childNodes[1].childNodes[0].style.width = subMenu.style.width;
			   	}
			}
			else {
				if(ig_csom.IsIE55Plus) {
					if(subMenu.firstChild != null) {
						subMenu.firstChild.style.width = subMenu.style.width;
						if(subMenu.firstChild.firstChild != null)
							subMenu.firstChild.firstChild.style.width = subMenu.style.width;
					}
				}
			}
		}
		
		// set submenu position	
		var pageWidth	= document.body.clientWidth;
		var menuWidth	= subMenu.clientWidth;
		var pageHeight	= document.body.clientHeight;
		var menuHeight	= subMenu.offsetHeight;
		var scrollTop	= document.body.scrollTop;
		var scrollLeft	= document.body.scrollLeft;
		var menuX		= 0;
		var menuY		= 0;
		
		if(parentItem == null) { // popup menu
			menuX = subMenu.offsetLeft;	
			menuY = subMenu.offsetTop;	
		}
		else 
		if(vertical) { // display next to vertical menu
			menuY = igmenu_getTopPos(parentItem);	
			if(subMenu.parentMenu.scroller != null && subMenu.parentMenu.scroller.active) {
				menuY = menuY - subMenu.parentMenu.scroller.scrollDiv.scrollTop;
			}
			if(this.CurrentLeftHandDisplay==false)
				menuX = igmenu_getLeftPos(parentItem) + parentItem.offsetWidth - 4; 	
			else
				menuX = igmenu_getLeftPos(parentItem) - menuWidth; 	
			
			var switched = this.CurrentLeftHandDisplay != this.LeftHandDisplay; 
			// Check which way to align the menu
			if(this.CurrentLeftHandDisplay==false && !switched) { // align right
				if((menuX + menuWidth) > pageWidth + scrollLeft) {
						this.CurrentLeftHandDisplay=true; // change to left
					menuX = igmenu_getLeftPos(parentItem) - menuWidth; 
				}
			}
			else
			if(this.CurrentLeftHandDisplay==true && !switched) { // aligned left
				if((menuX < 0)) { //- menuWidth) < 0) {
					this.CurrentLeftHandDisplay=false; // change to right
					menuX = igmenu_getLeftPos(parentItem) + parentItem.offsetWidth; 
				}
			}
		}
		else { // display under horizontal menu
			menuX = igmenu_getLeftPos(parentItem); 
			menuY = igmenu_getTopPos(parentItem) + parentItem.offsetHeight+1;	
		}
		
		if(ig_csom.IsIE) {
			var scrollHeight;
			if(!subMenu.scroller)
				scrollHeight = subMenu.firstChild.firstChild.scrollHeight;
			else
				scrollHeight = subMenu.scroller.table.scrollHeight;
			if(scrollHeight > pageHeight - 4) {
				if(!subMenu.scroller) {
	 				subMenu.scroller = new igmenu_scroller(subMenu);
				}
				subMenu.scroller.show();
				var divsHeight = subMenu.scroller.topDiv.offsetHeight + subMenu.scroller.bottomDiv.offsetHeight + 8;
				subMenu.scroller.setScrollHeight(pageHeight - divsHeight);
				menuHeight = subMenu.offsetHeight;
			}
			else {
				if(subMenu.scroller) {
					subMenu.scroller.hide();
				}
			}			
		}
		
		if(menuX + menuWidth > pageWidth + scrollLeft)
			menuX = pageWidth - menuWidth + scrollLeft - 8;
		if(menuX < scrollLeft)
			menuX = scrollLeft;
		
		if(menuY + menuHeight > pageHeight + scrollTop)
			menuY = pageHeight - menuHeight + scrollTop - 8;
		if(menuY < scrollTop)
			menuY = scrollTop;
				
		subMenu.style.top=menuY;
		subMenu.style.left=menuX;
		if(ig_csom.IsIE55Plus && subMenu.transPanel!=null) {	
			subMenu.transPanel.setPosition(subMenu.offsetTop, subMenu.offsetLeft, subMenu.offsetWidth, subMenu.offsetHeight);
			subMenu.transPanel.show();
		}
	}
	
	// private - implements the showing and hiding of submenus
	this.hideSubMenu = function(subMenu) {
		igmenu_callDisplayMenu(false, subMenu.id);
		var mn=igmenu_getMenuNameByItemId(subMenu.id);
		if(this.fireEvent(this.Events.SubMenuDisplay,"(\""+mn+"\",\""+subMenu.id+"\", false)"))
			return;
		subMenu.style.visibility = "hidden";
		subMenu.style.display = "none";
		if(ig_csom.IsIE && subMenu.transPanel!=null) {	
			subMenu.transPanel.hide();
		}
		
	}

	// private - Update internal buffer for items that are checked on or off
	this.updateItemCheck = function(itemId, bChecked){
		var formControl = igmenu_getElementById(this.UniqueId);
		if(formControl == null)
			return;
		var menuState = formControl.value;

		var newValue;
		var oldValue;
		if(bChecked){
			oldValue = "0";	newValue = "1";
		}
		else{
			oldValue = "1";	newValue = "0";
		}
		var oldString = itemId + ":Chck=" + oldValue + "<%;";
		var newString = itemId + ":Chck=" + newValue + "<%;";
		if(menuState.search(oldString) >= 0)
			menuState = menuState.replace(oldString, newString);
		else {
		oldString = itemId + ":Chck=" + newValue + "<%;";
		if(menuState.search(oldString) >= 0){
			menuState = menuState.replace(oldString, newString);
		}
		else
			menuState += newString;
		}
		formControl.value = menuState; 
	}
	
	// private - clears all submenus from display
	this.clearMenuTree = function(menu, clearAttribs) {
		if(menu == null) {
			if(ig_menuObject == null)
				return;
			menu = ig_menuObject.Element;
			// UnHover the top menu item
			var currentItemId = menu.igCurrentItem;
			if(currentItemId != null && currentItemId.length > 0) {
				this.unhoverItem(igmenu_getElementById(currentItemId));
			}
			
			if(clearAttribs) {
				menu.igCurrentChild = null;
				menu.igCurrentItem = null;
			}
			
			igmenu_displayItem = null;
			this.CurrentLeftHandDisplay=this.LeftHandDisplay;
		}

		var childId = menu.childMenuId;
		menu.childMenuId = null;

		while(childId != null && childId.length > 0) {
			var child = igmenu_getElementById(childId);
			if(ig_menuObject != null)
				ig_menuObject.hideSubMenu(child);
			childId = child.childMenuId;
			child.childMenuId = null;
						
			if(clearAttribs) 
				child.igCurrentChild=null;
			
			var currentItemId = child.igCurrentItem;
			if(currentItemId != null && currentItemId.length > 0) {
				this.unhoverItem(igmenu_getElementById(currentItemId));
			}
			if(clearAttribs) 
				child.igCurrentItem=null;
		}
	}

	// private - clears the descendants of the passed in menu from display
	this.clearDescendants = function(menu, clearAttribs) {
		this.clearMenuTree(menu, clearAttribs);
		ig_currentMenu = menu;
	}
	
	// private - displays menu item using the hover styles
	this.hoverItem = function(item)
	{
		var hoverClass = item.getAttribute("igHov");
		var topItem = item.getAttribute("igTop");
		clearCurrentMenu = false;
		var mn=igmenu_getMenuNameByItemId(item.id);
		if(this.fireEvent(this.Events.ItemHover,"(\""+mn+"\",\""+item.id+"\", true)"))
			return;

		var td = this.cellFromRow(item);
		if(hoverClass == null || hoverClass.length == 0) {
				hoverClass = this.HoverClass;
		}
		
		if((topItem != null && topItem.length > 0) 
			&& (this.MenuTarget == 1 && this.WebMenuStyle >= 2 && this.TopHoverStarted == true) && this.TopSelectedClass.length > 0) {
				hoverClass = this.TopSelectedClass;
				var topHover = item.getAttribute("igHov");
				if(td.className != "TopHover")
					td.igClass = td.className;
		}
		else
		if(td.className != null && td.className.length > 0) {
			if(hoverClass == td.className)
				return;
			td.igClass = td.className;
		}

		var igDisabled = item.getAttribute("igDisabled");
		if(igDisabled != null && igDisabled.length > 0) {
			hoverClass = td.className;
		}
		
		if(hoverClass!=null && hoverClass.length > 0) 
			td.className = hoverClass;
			
		var hoverimage = item.getAttribute("ighovimage");
		if(igDisabled != null && igDisabled.length > 0) 
			return;
		if(hoverimage != null && hoverimage.length > 0) {
			var imgElem = this.getImageElement(item);
			if(imgElem != null) {
				item.setAttribute("igoldhovimage", imgElem.src);
				imgElem.src=hoverimage;
			}
		}
	}

	// private - displays the item using non-hover styles
	this.unhoverItem = function (item) {
		var mn=igmenu_getMenuNameByItemId(item.id);
		if(this.MenuLoaded == false)
			return;
		if(this.fireEvent(this.Events.ItemHover,"(\""+mn+"\",\""+item.id+"\", false)"))
			return;
			
		var td = this.cellFromRow(item);
		td.className = "";
		var prevClass = item.getAttribute("igPrevClass");
		if(prevClass == null) {
			if(td.igClass != null)
				td.className = td.igClass;
		}
		else {
			td.className = prevClass;
		}
		var hoverimage = item.getAttribute("igoldhovimage");
		if(hoverimage != null && hoverimage.length > 0) {
			var imgElem = this.getImageElement(item);
			if(imgElem != null) {
				imgElem.src=hoverimage;
			}
		}
	}

	// private - obtain the element containing the item image tag
	this.getImageElement = function (item) {
		var topItem = item.getAttribute("igTop");
		var e = null;
		if(topItem == "1" && this.MenuTarget == 1)
			e = item.childNodes[0];
		else
			e = item.childNodes[0].childNodes[0];
		if(e==null || e.tagName!="IMG")
			return null;
		return e;
	}

	// private - browser independant table cell from table row
	this.cellFromRow = function(item) {
		if(ig_csom.IsIE) {
			if(item.tagName == "TR")
				return item.childNodes[0];
			else 
				return item;
		}
		else {
			if(item.tagName == "TR") {
				var x=0;
				for(x=0;x<item.childNodes.length;x++) {
					if(item.childNodes[x].tagName!=null && item.childNodes[x].tagName=="TD")
						return item.childNodes[x];
				}
			}
			else 
				return item;
		}
	}
}

// private - handles mouse over for scrollable submenus
var igmenu_scrollTimerId;
var igmenu_scrollMenu;
function igmenu_onScrollMouseOver(evnt) {
	var e; 
	if(ig_csom.IsNetscape6)  {
		e = evnt.target;
	}
	else
		e = evnt.srcElement;
	
	if(e.tagName == "IMG")
		e = e.parentNode;
	ig_inMenu = true;	
	clearTimeout(igmenu_clearMenuId);
	clearCurrentMenu = false;
	igmenu_scrollMenu = e.parentNode;
	
	var ms = igmenu_getMenuByItemId(e.parentNode.id);
	ms.hoverItem(e);

	if(e.topDiv) {
		igmenu_scrollMenu.scrollInc = -4;
	}
	else
	if(e.bottomDiv) {
		igmenu_scrollMenu.scrollInc = 4;
	}
	clearInterval(igmenu_scrollTimerId);
	igmenu_scrollTimerId = setInterval(igmenu_onMenuScroll, 30, igmenu_scrollMenu);
}

// private - handles mouse out for scrollable submenus
function igmenu_onScrollMouseOut(evnt) {
	var e;
	if(ig_csom.IsNetscape6)  {
		e = evnt.target;
	}
	else
		e = evnt.srcElement;
	
	if(e.tagName == "IMG") {
		e = e.parentNode;
	}
	var ms = igmenu_getMenuByItemId(e.parentNode.id);
	ms.unhoverItem(e);
	clearInterval(igmenu_scrollTimerId);
	igmenu_scrollMenu = null;
	clearCurrentMenu = true;
	clearTimeout(igmenu_clearMenuId);
	igmenu_clearMenuId = setTimeout('TimerExpired()', ms.ExpandEffects.RemovalDelay);
}

// private - handles scrolling for scrollable submenus
function igmenu_onMenuScroll() {
	if(igmenu_scrollMenu != null) {
		var scrollDiv = igmenu_scrollMenu.childNodes[1];
		
		// save the current scrollTop position
		var oldValue = scrollDiv.scrollTop;
		
		// increment the scrollTop property of the scrollDiv
		scrollDiv.scrollTop += igmenu_scrollMenu.scrollInc;

		// get references to the top and bottom divs and the menu object
		var topDiv = igmenu_scrollMenu.scroller.topDiv;
		var bottomDiv = igmenu_scrollMenu.scroller.bottomDiv;
		var ms = igmenu_scrollMenu.scroller.ms;

		// If at the top, display disabled up arrow
		if(scrollDiv.scrollTop == 0) {
			if(topDiv.innerHTML.indexOf(ms.ScrollImageTopDisabled) == -1) {
				topDiv.innerHTML = "<img src='" + ms.ScrollImageTopDisabled + "'>"
				clearInterval(igmenu_scrollTimerId);
			}
		}
		else {
			if(topDiv.innerHTML.indexOf(ms.ScrollImageTop) == -1)
				topDiv.innerHTML = "<img src='" + ms.ScrollImageTop + "'>"
		}
		
		// If at the bottom, display disabled down arrow
		if(oldValue == scrollDiv.scrollTop && oldValue > 0) {
			if(bottomDiv.innerHTML.indexOf(ms.ScrollImageBottomDisabled) == -1) {
				bottomDiv.innerHTML = "<img src='" + ms.ScrollImageBottomDisabled + "'>"
				clearInterval(igmenu_scrollTimerId);
			}
		}
		else {
			if(bottomDiv.innerHTML.indexOf(ms.ScrollImageBottom) == -1)
				bottomDiv.innerHTML = "<img src='" + ms.ScrollImageBottom + "'>"
		}
	}
}

// private - event initialization for menu object
function igmenu_events(events)
{
	this.InitializeMenu=events[0];
	this.ItemCheck=events[1];
	this.ItemClick=events[2];
	this.SubMenuDisplay=events[3];
	this.ItemHover=events[4];
}

// private - event initialization for menu object
function igmenu_expandEffects(duration, opacity, type, shadowColor, shadowWidth, delay, removalDelay)
{
	this.Duration=duration;
	this.Opacity=opacity;
	this.Type=type;
	this.ShadowColor=shadowColor;
	this.ShadowWidth=shadowWidth;
	this.Delay=delay;
	this.RemovalDelay = removalDelay
}

// private - 1.0 compatibility function for hiding select boxes
var igmenu_displayMenu = null;
function igmenu_callDisplayMenu(bShow, id) {
	if(igmenu_displayMenu != null)
		igmenu_displayMenu(bShow, id);
}

// private - hides all dropdown select controls for the document.
var ig_hidden=false;
function igmenu_hideDropDowns(bHide) { 
	 if(igmenu_dropDowns == null)
		return;
     if(bHide){
		if(ig_hidden)
			return;
		ig_hidden = true;
         for (i=0; i<igmenu_dropDowns.length;i++)
                 igmenu_dropDowns[i].style.visibility='hidden';
     }
     else {
         for (i=0; i<igmenu_dropDowns.length;i++){
                 igmenu_dropDowns[i].style.visibility='visible';
         }
         ig_hidden = false;
     }
}

// private - creates an internal menu tree that has the top level menu as it's first element and adds one table
// object to the chain by setting the "childMenuId" property of the main menu to the id
// of the table that is the second link of the chain.
function igmenu_treeCreate(ms, tableItem) {
	ms.clearMenuTree(null);
	var menuObj = igmenu_getMenuByItemId(tableItem.id);
	var menuElement = menuObj.MenuElement;
	menuElement.childMenuId = tableItem.id;
	ig_currentMenu = tableItem;
	ig_menuObject = ms;
	if(!ig_csom.IsIE55Plus && ms.HideDropDowns) {
		igmenu_hideDropDowns(true);
	}
}

// private - adds a menu to the internal menu tree
function igmenu_menuTreeAdd(subMenu) {
	ig_currentMenu.childMenuId = subMenu.id;
	ig_currentMenu = subMenu;
}

// private - implements mouseover event handling for the menu
function igmenu_mouseover(table, evnt) {
	var item = igmenu_getTblRow(evnt);
	ig_inMenu = true;	
	if(item == null) {
		var main;  // = ig_csom.getSourceElement(evnt).getAttribute("igLevel");
		if(ig_csom.IsIE)  {
			main = evnt.srcElement.getAttribute("igLevel");
			if(main!=null && main.length>0 && main=="0")
				clearCurrentMenu=false;
		}
		//else
			//clearCurrentMenu=false;
		return;
	}

	var ms=igmenu_getMenuByItemId(item.id);
	if(ms == null || ms.MenuLoaded == false)
		return;
	
	clearCurrentMenu = false;
	clearTimeout(igmenu_clearMenuId);
	
	// no longer needed?
	//igmenu_clearMenuId = setTimeout('TimerExpired()', ms.ExpandEffects.RemovalDelay);
	
	var currItemId = igmenu_getSubMenu(item).igCurrentItem;
	if(currItemId != null && currItemId.length > 0) {
		var childItem = igmenu_getElementById(currItemId)
		ms.unhoverItem(childItem);
		var thisMenu = igmenu_getSubMenu(item);
		if(ig_csom.notEmpty(thisMenu.igCurrentChild)) {
			var eCurrentChild = ig_csom.getElementById(thisMenu.igCurrentChild);
			eCurrentChild.igCurrentChild = null;
		}
	}
	var igSeparator = item.getAttribute("igSep");
	if(igSeparator != null && igSeparator.length > 0) {
		clearCurrentMenu = false;
		return;
	}
	ms.hoverItem(item);
	var childId = item.getAttribute("igChildId");

	// Check that the child is not already being displayed.
	var currentChildId = igmenu_getSubMenu(item).igCurrentChild;
	if(ig_csom.notEmpty(childId) && childId==currentChildId) {
		ms.clearDescendants(igmenu_getElementById(currentChildId), true);
		var childItemId = igmenu_getElementById(childId).igCurrentItem;
		if(ig_csom.notEmpty(childItemId)) {
			ms.unhoverItem(igmenu_getElementById(childItemId));
		}
		return;

	}
	if(childId != null) {
		var igDisabled = item.getAttribute("igDisabled");
		var igtop = item.getAttribute("igTop");
		if(igDisabled != null && igDisabled.length > 0) {
			if(igtop!=null && igtop.length > 0) {
				ms.clearMenuTree(null);
			}
			igmenu_getSubMenu(item).igCurrentItem = item.id;
			return;
		}
		if(ms.MenuTarget == 1) {
			if(ms.WebMenuStyle>=2 && ms.TopHoverStarted==false && igtop!=null && igtop.length > 0) {
				return;
			}
		}

		if(ms.MenuTarget == 1 && ms.WebMenuStyle>=1 && igtop!=null && igtop.length > 0) {
			clearTimeout(igmenu_timerId);
			ms.displayHorizontalSubMenu(item, childId);
			igmenu_getSubMenu(item).igCurrentChild = childId;
			igmenu_getSubMenu(item).igCurrentItem = item.id;
		}
		else {
			if(igmenu_displayItem != item) {
				igmenu_displayItem = item;
				igmenu_displayChildId = childId;
				clearTimeout(igmenu_timerId);
				clearTimeout(igmenu_clearMenuId);
				igmenu_timerId = setTimeout('igmenu_displayTimeOut()', ms.ExpandEffects.Delay);
			}
			else { 
				if(ig_csom.notEmpty(igtop) && (item.previousSibling==null && item.nextSibling==null)){
					igmenu_displayChildId = childId;
					clearTimeout(igmenu_timerId);
					clearTimeout(igmenu_clearMenuId);
					igmenu_timerId = setTimeout('igmenu_displayTimeOut()', ms.ExpandEffects.Delay);
				}
			}
		}
	}
	else {
		if(igmenu_getSubMenu(item).igCurrentChild !=null) {
			ms.clearDescendants(igmenu_getSubMenu(item), true);
			clearTimeout(igmenu_timerId);
			igmenu_getSubMenu(item).igCurrentChild=null;
			igmenu_displayItem = null;
			igmenu_getSubMenu(item).igCurrentItem=null;
		}
	}
}

var igmenu_timerId;
var igmenu_displayItem;
var igmenu_displayChildId;
// private - displays submenus after time expiration
function igmenu_displayTimeOut() {
	if(igmenu_displayItem == null)
		return;

	igmenu_getSubMenu(igmenu_displayItem).igCurrentChild = igmenu_displayChildId;
	igmenu_getSubMenu(igmenu_displayItem).igCurrentItem = igmenu_displayItem.id;
	var ms=igmenu_getMenuByItemId(igmenu_displayItem.id);
	var igtop = igmenu_displayItem.getAttribute("igTop");
	if(ms.MenuTarget >= 2 && igtop != null && igtop.length > 0) {
		ms.displayVerticalSubMenu(igmenu_displayItem, igmenu_displayChildId, 4);
	}
	else
		ms.displaySubSubMenu(igmenu_displayItem, igmenu_displayChildId, 2);
		
}

var igmenu_clearMenuId;
// private - implements mouseout event handling
function igmenu_mouseout(submenu, evnt) {
	ig_inMenu = false;	
	var item = igmenu_getTblRow(evnt);
	if(item == null) {
		clearCurrentMenu = true;
		clearTimeout(igmenu_clearMenuId);
		if(ig_menuObject)
			igmenu_clearMenuId = setTimeout('TimerExpired()', ig_menuObject.ExpandEffects.RemovalDelay);
		return;
	}
		
	var igSeparator = item.getAttribute("igSep");
	var ms = igmenu_getMenuByItemId(item.id);
	if(igSeparator != null && igSeparator.length > 0) {
		clearCurrentMenu = true;
		if(ig_csom.IsIE) {
			clearTimeout(igmenu_clearMenuId);
			igmenu_clearMenuId = setTimeout('TimerExpired()', ms.ExpandEffects.RemovalDelay);
		}
		return;
	}

	var currItemId = igmenu_getSubMenu(item).igCurrentItem;
	var currentChildId = igmenu_getSubMenu(item).igCurrentChild
	var childId = item.getAttribute("igChildId");
	if(ig_csom.isEmpty(childId) || ig_csom.isEmpty(currentChildId) || childId != currentChildId)  {
	//if(currItemId == null || currItemId.length == 0) { // commented to allow all unhoverings to occur
		ms.unhoverItem(item);
	}
	igmenu_displayItem = null; 
	clearCurrentMenu = true;
	clearTimeout(igmenu_clearMenuId);
	igmenu_clearMenuId = setTimeout('TimerExpired()', ms.ExpandEffects.RemovalDelay);
}

// Gets the table row object for which a TD or other element event fired.
// private - obtains the row element associated with the event
function igmenu_getTblRow(evnt) { 
	var item;
	if(ig_csom.IsNetscape6)  {
		item = evnt.target;
	}
	else
		item = evnt.srcElement;
	//var item = ig_csom.getSourceElement(evnt);
	while(item.tagName != "TR") {
		if(item.getAttribute != null) {
			var attrib = item.getAttribute("igTop");
			var submenu = item.getAttribute("submenu");
			if(submenu == "1")
				return null;
			if(item.tagName == "TD" && attrib != null && attrib.length > 0)
				return item;
		}
		if(item == null)
			return null;
		if(item.tagName == "TABLE")
			return null;
		item = item.parentNode;
	}
	return item;		
}

// private - Gets the table object for which a TD or other element event fired.
function igmenu_getSubMenu(item) {
	submenu = false;
	while(!submenu)  {
		var a = item.getAttribute("submenu");
		if(item.getAttribute("submenu") == '1')
			submenu = true;
		else
			item = item.parentNode;
	}
	return item;
}

// private
function igmenu_getRightPos(e) {
    var x = e.offsetRight;
    var tmpE = e.offsetParent;
    while (tmpE != null) {
        x += tmpE.offsetRight;
        tmpE = tmpE.offsetParent;
    }
    return x;
}
// private
function igmenu_getLeftPos(element) {
    var x = 0;
    var parent = element;
    while (parent != null) {
		//if(parent.style.position=="relative") //commented due to IE crash with SmartNavigation on
		//	break;
        x += parent.offsetLeft;
        parent = parent.offsetParent;
    }
    return x;
}
// private
function igmenu_getTopPos(element) {
    var y = 0;
    var parent = element;
    while(parent != null) {
		//if(parent.style.position=="relative") //commented due to IE crash with SmartNavigation on
		//	break;
		y += parent.offsetTop;
        parent = parent.offsetParent;
	}
    return y;
}

var clearCurrentMenu = true;
// private - Clears submenus at timer expiration
function TimerExpired() {
	if(clearCurrentMenu && ig_menuObject != null) {
		ig_menuObject.clearMenuTree(null, true);
		clearTimeout(igmenu_timerId);
		igmenu_hideDropDowns(false);
	}
}

// private - Handles the mouse down event
function igmenu_mousedown(table, evnt) {
	var item=igmenu_getTblRow(evnt);
	if(item!=null) {
		ig_inMenu = true;
		var igDisabled = item.getAttribute("igDisabled");
		if(igDisabled != null && igDisabled.length > 0) {
			return;
		}
	}
	else
		return;
	var ms=igmenu_getMenuByItemId(item.id);
	if(ms == null || ms.MenuLoaded == false)
		return;

	var attrib = item.getAttribute("igTop");
	if(ms.MenuTarget == 1 && ms.WebMenuStyle>=2 && attrib!=null && attrib.length > 0){
		var childId = item.getAttribute("igChildId");
		if(childId!=null && childId.length > 0) {
			var currentChildId = igmenu_getSubMenu(item).igCurrentChild;
			if(childId != null && childId.length > 0 && childId == currentChildId) {
				ms.clearMenuTree(null, true);
				ig_startClick=false;
				ms.TopHoverStarted = false;
				ms.hoverItem(item)
				return;
			}
			var oldClass = item.igClass;
			item.setAttribute("igPrevClass", oldClass);
			clearTimeout(igmenu_timerId);
			ms.TopHoverStarted = true;
			ms.hoverItem(item)
			ms.displayHorizontalSubMenu(item, childId);
			igmenu_getSubMenu(item).igCurrentChild = childId;
			igmenu_getSubMenu(item).igCurrentItem = item.id;
			return;
		}
	}
	ms.TopHoverStarted=false;
	ig_startClick = true;	
	if(evnt.stopPropagation != null) evnt.stopPropagation();
	if(evnt.preventDefault != null) evnt.preventDefault();
	evnt.cancelBubble = true;
	evnt.returnValue = false;
}

var	ig_startClick = false;
// private - Handles the mouse up event
function igmenu_mouseup(table, evnt) {
	var item=igmenu_getTblRow(evnt);
	if(item==null){return;}
	
	var ms=igmenu_getMenuByItemId(item.id);
	var igDisabled = item.getAttribute("igDisabled");
	var igTop = item.getAttribute("igTop");
	var igChildId = item.getAttribute("igChildId");
	var igUrl=item.getAttribute("igUrl");
	if(igDisabled != null && igDisabled.length > 0) 
		return;
	var igSeparator = item.getAttribute("igSep");
	if(igSeparator != null && igSeparator.length > 0) {
		clearCurrentMenu = false;
		return;
	}
	if(igTop == null || igTop.length > 0) 
		if(igChildId != null && igChildId.length > 0) 
			if(igUrl == null || igUrl.length == 0) {
				ms.fireEvent(ms.Events.ItemClick,"(\""+mn+"\",\""+item.id+"\")");
				return;
			}

	if(ig_startClick==true){
		var mn=igmenu_getMenuNameByItemId(item.id);
		var checked=item.getAttribute("igChk");
		var checkbox=item.getAttribute("igChkBx");
		ms.clearMenuTree(null, true);
		if(checkbox!=null && checkbox.length>0) {
			var bCheck=(checked != null) && (checked == '0');
			var postCommand="";
			if(ms.fireEvent(ms.Events.ItemCheck,"(\""+mn+"\",\""+item.id+"\","+bCheck+")"))
				return;
			
			var bHorizontal;
			var bTop = item.getAttribute("igTop");
			if(bTop != null && bTop.length > 0)
				bTop = true;
			else
				bTop = false;
				
			if(ms.MenuTarget==1 && bTop)
				bHorizontal = true;
			var checkElement;
			if(bHorizontal)
				checkElement = item.childNodes[0];
			else
				checkElement = item.childNodes[0].childNodes[0];
			if(checked!=null && checked=="1") {
				bCheck=false;
				postCommand=":Uncheck";
				if(checkElement.tagName == "IMG")
					checkElement.src=ms.UncheckedImage;
				else
				if(checkElement.tagName == "SPAN")
					checkElement.innerHTML = "";
				item.setAttribute("igChk", "0");
			}
			else {
				if(checkElement.tagName == "IMG")
					checkElement.src=ms.CheckedImage;
				else
				if(checkElement.tagName == "SPAN")
					checkElement.innerHTML = "a";
				bCheck=true;
				postCommand=":Check";
				item.setAttribute("igChk", "1");
			}
			
			if(ms.NeedPostBack)	{
				__doPostBack(ms.UniqueId,item.id+postCommand);
			}
			ms.clearMenuTree(null, true);
			ms.updateItemCheck(item.id, bCheck);
			ig_startClick=false;
			if(ig_menuPopup != null) {
				ms.hideSubMenu(ig_menuPopup);			
				ig_menuPopup = null;
			}
			return;
		}
		if(ms.fireEvent(ms.Events.ItemClick,"(\""+mn+"\",\""+item.id+"\")"))
			return;
		ms.clearMenuTree(null, true);
		
		// Reset current item tracking
		igmenu_getSubMenu(item).igCurrentChild=null;
		igmenu_displayItem = null;
		igmenu_getSubMenu(item).igCurrentItem=null;

		igmenu_hideDropDowns(false);
		if(ig_menuPopup != null) {
			ms.hideSubMenu(ig_menuPopup);			
			ig_menuPopup = null;
		}
		ig_startClick=false;
		var igFrame=item.getAttribute("igFrame");
		if(igUrl!=null) {
			ig.navigateUrl(igUrl,igFrame);
			return;
		}
		if(ms.NeedPostBack)	{
			__doPostBack(ms.UniqueId,item.id+":MenuClick");
			return;
		}
	}
}

var ig_inMenu=false;
// private - Handles the mouse down event
function igmenu_mouseDown() {
	if(ig_inMenu == true) 
		return;		
	var	ms = ig_menuObject;
	if(ig_menuObject != null) {
		ms.TopHoverStarted=false;
	}
	ig_startClick = false;
	ig_inMenu = false;		
	if(ig_menuPopup != null) {
		if(ms != null)
			ms.clearMenuTree(null, true);
		ig_menuPopup.menuObject.hideSubMenu(ig_menuPopup);
		ig_menuPopup = null;
		igmenu_hideDropDowns(false);
	}
	else {
		if(ms != null)
			ms.clearMenuTree(null, true);
		igmenu_hideDropDowns(false);
	}
}

// private - Handles the mouse up event
function igmenu_mouseUp() {
	return;
}

// private - Handles mouse selection for the menu
function igmenu_selectStart() {
	window.event.cancelBubble = true; 
	window.event.returnValue = false; 
	return false;	
}

// private - Displays a submenu in the appropriate position
function igmenu_hideMenu(name, evnt, x, y) {

}

// private - Displays a submenu in the appropriate position
function igmenu_showMenu(name, evnt, x, y) {
	if(ig_menuPopup != null) {
		if(ig_menuObject)
			ig_menuObject.clearMenuTree(null, true);
		ig_menuPopup.style.visibility = 'hidden';
		ig_menuPopup = null;
		igmenu_hideDropDowns(false);
	}
	var item = igmenu_getElementById(name + "_MainM");
	if(evnt == null)
		evnt = window.event;
	if(item != null) {
		if(x && y) {
			item.style.left = x;
			item.style.top = y;	
		}
		else {
			if(ig_csom.IsIE) {
				
				y = evnt.y - 2 + document.body.scrollTop;	
				x = evnt.x - 2 + document.body.scrollLeft;
			}
			else {
				y = evnt.clientY - 2 + document.body.scrollTop;	
				x = evnt.clientX - 2 + document.body.scrollLeft;
			}
			var src = ig_csom.getSourceElement(evnt);
			if(src) {
				var parent = src;
				var tmpX = x;
				var tmpY = y;
				var set = false;
				while (parent != null) {
					if(parent.style.position=="relative") {
						set = true;
					}
					tmpX += parent.offsetLeft;
					tmpY += parent.offsetTop;
					parent = parent.offsetParent;
				}
				if(set) {
					x = tmpX;
					y = tmpY;
				}
			}
			item.style.top  = y;	
			item.style.left = x;
		}
		ig_menuPopup = item;

		var ms = igmenu_getMenuById(name);
		if(ms==null)
			return;
		if(!ig_csom.IsIE55Plus && ms.HideDropDowns) 
			igmenu_hideDropDowns(true);
		ms.displaySubMenu(item, null, true);
		ig_menuPopup.menuObject = ms;
	}
}

// private - Initializes an Item object with properties and method references
function igmenu_initItem(item)
{
	this.element=item;
	this.Element=item;
	this.Id = item.id;
	this.WebMenu = igmenu_getMenuByItemId(this.Id);
	this.getElement=igmenu_getElement;
	this.getMenuId=igmenu_getMenuId;
	this.getText=igmenu_getText;
	this.setText=igmenu_setText;
	this.getTag=igmenu_getTag;
	this.setTag=igmenu_setTag;
	this.getHoverClass=igmenu_getHoverClass;
	this.setHoverClass=igmenu_setHoverClass;
	this.getEnabled=igmenu_getEnabled;
	this.setEnabled=igmenu_setEnabled;
	this.getTargetFrame=igmenu_getTargetFrame;
	this.setTargetFrame=igmenu_setTargetFrame;
	this.getTargetUrl=igmenu_getTargetUrl;
	this.setTargetUrl=igmenu_setTargetUrl;
	this.getNextSibling=igmenu_getItemNextSibling;
	this.getPrevSibling=igmenu_getItemPrevSibling;
	this.getFirstChild=igmenu_getItemFirstChild;
	this.getParent=igmenu_getItemParent;
	this.getItems=igmenu_getItemItems;
	this.setChecked=igmenu_setChecked;
	this.getChecked=igmenu_getChecked;
	this.getLevel = function () {
		var itemName=this.element.id.split("_")
		if(itemName.length>1)
		{
			return itemName.length - 2;			
		}
	}
	this.getIndex = function () {
		var index=0;
		var itemName=this.element.id.split("_")
		if(itemName.length>1)
		{
			index = parseInt(itemName[itemName.length-1]);
			return index-1;
		}
	}
}

// private
function igmenu_getElement() {
	return this.item;
}
// private
function igmenu_getMenuId() {
	var menuName = this.element.id;
	var strArray = menuName.split("_");
	menuName = strArray[0];
	return menuName;
}
// private
function igmenu_getText() {
	if(this.element.tagName == "TR"){
		var i = 0;
		var td;
		if(ig_csom.IsIE)
			td = this.element.childNodes[0]
		else
			td = this.element.childNodes[1]
		while(td.childNodes[i] != null) {
			if(td.childNodes[i].tagName == "DIV") {
				var txt = td.childNodes[i].getAttribute("igtxt");
				if(txt != null)
					return td.childNodes[i].innerHTML;
			}
			i++;
		}
		return null;
	}
	else
		return this.element.innerHTML;
}
// private
function igmenu_setText(text) {
	if(this.element.tagName == "TR") {
		var i = 0;
		var td = this.element.childNodes[0]
		while(td.childNodes[i] != null) {
			if(td.childNodes[i].tagName == "DIV") {
				var txt = td.childNodes[i].getAttribute("igtxt");
				if(txt != null)
					td.childNodes[i].innerHTML = text;
			}
			i++;
		}
		return null;
	}
	else
		this.element.innerHTML = text;
}
// private
function igmenu_getTag() {
	var a = this.element.getAttribute("igTag");
	if(a!=null && a.length>0)
		return a;
	else
		return null;
}
// private
function igmenu_setTag(text) {
	this.element.setAttribute("igTag", text);
}
// private
function igmenu_getHoverClass() {
	return this.element.getAttribute("igHov")
}
// private
function igmenu_setHoverClass(hoverClass) {
	this.element.setAttribute("igHov", hoverClass)
}

// private
function igmenu_getItemTdTag(e) {
	if(e.tagName=="TD")
		return e;
	var i = e.childNodes.length;
	while(i-- >= 0) {
		if(e.childNodes[i].tagName == "TD")
			return e.childNodes[i];
	}
}
// private
function igmenu_getEnabled() {
	if(this.element != null) {
		return(this.element.getAttribute("igDisabled")?false:true);
		//var e;
		//var top = this.element.getAttribute("igTop");
		//if(top == null)
		//	e = this.element.childNodes[1];
		//else
		//	e = this.element;
	}
}
// private
function igmenu_setEnabled(enabled) {
	if(this.element != null) {
		var e = igmenu_getItemTdTag(this.element);
		
		if(enabled == true) {
			this.element.removeAttribute("igDisabled");
			var oldClass=e.getAttribute("oldEnabledClass");
			e.className=oldClass;
			e.removeAttribute("oldEnabledClass");
		}
		else {
			var ms = igmenu_getMenuById(this.getMenuId());
			var disabledClass = ms.DisabledClass;
			this.element.setAttribute("igDisabled", "1");
			var oldClass = e.className;
			e.className=disabledClass;
			e.setAttribute("oldEnabledClass", oldClass);
			e.removeAttribute("igtInitClass");
		}
	}
}
// private
function igmenu_getTargetFrame() {
	var frame = this.element.getAttribute("igFrame");
	if(ig_csom.notEmpty(frame))
		return frame;
	else
	if(ig_csom.notEmpty(this.WebMenu.TargetFrame)) {
		return this.WebMenu.TargetFrame;
	}
	else
		return null;
}
// private
function igmenu_setTargetFrame(frame) {
	this.element.setAttribute("igFrame", frame)
}
// private
function igmenu_getTargetUrl() {
	var url = this.element.getAttribute("igUrl");
	if(ig_csom.notEmpty(url))
		return url;
	else
	if(ig_csom.notEmpty(this.WebMenu.TargetUrl)) {
		return this.WebMenu.TargetUrl;
	}
	else
		return null;
}
// private
function igmenu_setTargetUrl(url) {
	this.element.setAttribute("igUrl", url)
}
// private
function igmenu_setChecked(bChecked) {
	var ms=igmenu_getMenuByItemId(this.element.id);
	var item = this.element;
	var checkbox=item.getAttribute("igChkBx");
	if(checkbox==null && checkbox.length==0) 
		return;

	var topItem = item.getAttribute("igTop");
	var checkElement = null;
	if(topItem == "1" && ms.MenuTarget == 1)
		checkElement = item.childNodes[0];
	else
		checkElement = item.childNodes[0].childNodes[0];

	if(!bChecked) {
		if(checkElement.tagName == "IMG")
			checkElement.src=ms.UncheckedImage;
		else
		if(checkElement.tagName == "SPAN")
			checkElement.innerHTML = "";
		item.setAttribute("igChk", "0");
	}
	else {
		if(checkElement.tagName == "IMG")
			checkElement.src=ms.CheckedImage;
		else
		if(checkElement.tagName == "SPAN")
			checkElement.innerHTML = "a";
		item.setAttribute("igChk", "1");
	}
	ms.updateItemCheck(this.element.id,bChecked);
}
// private
function igmenu_getChecked(bChecked) {
	var item = this.element;
	var checked=item.getAttribute("igChk");
	var checkbox=item.getAttribute("igChkBx");
	if(checkbox!=null && checkbox.length>0) 
		if(checked!=null && checked.length>0 && checked == '1') 
			return true;
	return false;			
}
// private - Implements GetNextSibling for the Item object
function igmenu_getItemNextSibling()
{
	var item = this.element.nextSibling;
	if(item && item.nodeName == "#text")
		item = this.element.nextSibling;
	if(item)
		item=igmenu_getItemById(item.id);
	return item;
}

// private - Implements GetPrevSibling for the Item object
function igmenu_getItemPrevSibling()
{
	var item = this.element.prevSibling;
	if(item && item.nodeName == "#text")
		item = this.element.prevSibling;
	if(item)
		item=igmenu_getItemById(item.id);
	return item;
}

// private
function igmenu_getItemFirstChild()
{
	var item=null;
	item=igmenu_getItemById(this.element.id+"_1");
	return item;
}

// private
function igmenu_getItemParent()
{
	var item=null;
	var itemName=this.element.id.split("_")
	if(itemName.length>1)
	{
		var parentName=this.element.id.substr(0,this.element.id.length-itemName[itemName.length-1].length-1);
		item=igmenu_getItemById(parentName);
	}
	return item;
}

// private
function igmenu_getItemItems()
{
	var itemAr=new Array();
	var itemCount=0;
	var item=this.getFirstChild();
	while(item)	{
		itemAr[itemCount++]=item;
		item=item.getNextSibling();
	}
	return itemAr;
}

