/* 
Infragistics Tab Script 
Version 2.1.20041.11
Copyright (c) 2004 Infragistics, Inc. All Rights Reserved.
*/
//viktors
//==========
// public:
var igtab_all = new Array();
// public:
// Get the UltraWebTab object using its html-id
function igtab_getTabById(id)
{
	var o = igtab_all[id];
	if(o == null) for(var i = igtab_all.length; i >= 0; i--)
		if((o = igtab_all[i]) != null)
			if(o.ID == id || o.uniqueId == id) break;
	return o;
}
// public:
// Get html child-element of owner by its id(s).
// owner - reference to the html-element that contains requested child element. If null, then window.document is used.
// id - the id or list of ids separated by space-character starting from the id of requested element:
//   Example of list: "ID_of_element ID_of_userControl ID_of_userControlParent ID_of_superParent ID_of_etc"
function igtab_getElementById(id, owner)
{
	if(owner == null) owner = window.document;
	var e, ids = (id.charAt == null) ? id : id.split(" ");
	if(ids.length == 1 && owner.forms != null)
	{
		if(owner.getElementById != null) if((e = owner.getElementById(id)) != null) return e;
		if((e = owner.all) != null) if((e = e[id]) != null) return e;
		return null;
	}
	var nodes = owner.childNodes;
	var i = nodes.length;
	while(i-- > 0)
	{
		e = nodes[i];
		var i0 = 0, j = ids.length;
		if((id = e.id) != null) if(id.length > 0)
		{
			while(j-- > 0)
			{
				if(ids[j].length < 1) continue;
				if((i0 = id.indexOf(ids[j], i0)) < 0) break;
				if(i0 > 0) if(id.charAt(i0 - 1) != '_') break;
				i0 += ids[j].length;
				if(i0 < id.length) if(id.charAt(i0) != '_') break;
			}
			if(j < 0 && i0 == id.length) return e;
		}
		if((e = igtab_getElementById(ids, e)) != null) return e;
	}
	return null;
}
//===========
// private: all below
function igtab_init(id, index, seps, prop, evts)
{
	var elem = igtab_getElementById("igtab" + id);
	if(elem == null) return;
	var o = new igtab_new(elem, id, seps, prop, evts);
	// hashtable and [i]
	igtab_all[igtab_all.length] = igtab_all[id] = o;
	igtab_selectTab(o, index);
	o.fireEvt(o, o.Events.initializeTabs, null);
}
// constructor for UltraWebTab and methods
function igtab_new(elem, id, seps, prop, evts)
{
	if(!igtab_not0(prop)) return;
	this.sep1 = (seps.length > 0) ? seps.substring(0, 1) : "\01";
	this.sep2 = (seps.length > 1) ? seps.substring(1, 2) : "\02";
	var prop0 = prop[0].split(this.sep1);
	this.ID = id;
	this.element = elem;
	this.elemViewState = igtab_getElementById(id);
	this.elemEmpty = igtab_getElementById(id + "_empty");
	this.selected = -2;
	this.hover = null;
	elem.setAttribute("tabID", id);
	// 0 - id of UltraWebTab
	// 1 - enabled: '1' or none
	// 2 - autoPostBack: '1' or none
	// 3 - loadAllUrls
	// 4 - customCss: none or "defCss+hovCss+selCss+disCss"
	// 5 - rounded image
	if(prop0.length < 6) return;
	this.uniqueId = prop0[0];
	this.enabled = igtab_not0(prop0[1]);
	this.autoPost = igtab_not0(prop0[2]);
	this.doPost = this.autoPost;
	this.loadAllUrls = igtab_not0(prop0[3]);
	this.noHov = igtab_not0(prop0[6]);
	var round = 0;
	if(igtab_not0(prop0[5]))
	{
		round = parseInt(prop0[5]);
		if((round & 1) != 0)
		{
			this.leftImg = [id + "DefTL", id + "HovTL", id + "SelTL", id + (((round & 4) != 0) ? "DisTL" : "DefTL")];
			if(this.noHov) this.leftImg[1] = this.leftImg[0];
		}
		if((round & 2) != 0)
		{
			this.rightImg = [id + "DefTR", id + "HovTR", id + "SelTR", id + (((round & 4) != 0) ? "DisTR" : "DefTR")];
			if(this.noHov) this.rightImg[1] = this.rightImg[0];
		}
	}
	this.doCss = function(prop)
	{
		var cs = new Array();
		prop = igtab_not0(prop) ? prop.split("+") : null;
		var j = -1;
		if(igtab_not0(prop)) while(++j < 4)
			cs[j] = igtab_val(prop, j);
		return cs;
	}
	var css = this.doCss(prop0[4]);
	this.dummy = igtab_val(prop0, 7);
	//
	this.getUniqueId = function(){return this.uniqueId;}
	this.getEnabled = function(){return this.enabled;}//1
	this.setEnabled = function(value){return this.setEnabled0(this, value);}
	this.setEnabled0 = function(o, value)
	{
		if(o.enabled == (value == true)) return;
		o.enabled = (value == true);
		var x = 0, owner = o.owner;
		if(owner == null) owner = o;
		else x = o.index + 1;
		owner.update(x, 1, value ? "1" : "");
		if(x > 0)
		{
			o.setState(o.enabled ? 0 : 3, null);
			o.fixSel();
		}
		else while(x < owner.Tabs.length) owner.Tabs[x++].doState(-1);
	}
	this.getAutoPostBack = function(){return this.autoPost;}
	this.setAutoPostBack = function(value){this.autoPost = (value == true);}
	this.getSelectedIndex = function(){return this.selected;}
	this.setSelectedIndex = function(value){igtab_selectTab(this, value);}
	this.getSelectedTab = function(){return (this.selected < 0) ? null : this.Tabs[this.selected];}
	this.setSelectedTab = function(value){igtab_selectTab(this, (value == null) ? -1 : value.index);}
	//
	prop0 = igtab_not0(evts) ? evts.split(this.sep1) : null;
	evts = new Object();
	evts.afterSelectedTabChange = igtab_val(prop0, 0);
	evts.beforeSelectedTabChange = igtab_val(prop0, 1);
	evts.initializeTabs = igtab_val(prop0, 2);
	evts.mouseOut = igtab_val(prop0, 3);
	evts.mouseOver = igtab_val(prop0, 4);
	this.Events = evts;
	this.Tabs = new Array();
	//
	this.addLsnr = function(e, s)
	{
		if(e == null) return;
		igtab_evtLsnr(e, "select", igtab_kill);
		igtab_evtLsnr(e, "selectstart", igtab_kill);
		if(s) return;
		igtab_evtLsnr(e, "mouseout", igtab_mouseout);
		igtab_evtLsnr(e, "mouseover", igtab_mouseover);
		igtab_evtLsnr(e, "click", igtab_click);
	}
	this.addLsnr(igtab_getElementById(id + "_tbl"), true);
	//
	var i = -1;
	while(++i < prop.length - 1)
	{
		if((elem = igtab_getElementById(id + "td" + i)) == null) continue;
		elem.setAttribute("tabID", id + "," + i);
		var tab = new igtab_newT(id, prop[i + 1].split(this.sep1), i, css, this);
		tab.element = elem;
		tab.tooltip = elem.title;
		while(tab.text.indexOf(this.sep2) > 0)
			tab.text = tab.text.replace(this.sep2, "\"");
		this.addLsnr(elem, false);
		this.Tabs[i] = tab;
		if(igtab_not0(tab.Key)) this.Tabs[tab.Key] = tab;
		if((round & 1) != 0) if((elem = igtab_getElementById(id + "td" + i + "L")) != null)
		{
			elem.setAttribute("tabID", id + "," + i);
			tab.elemLeft = elem;
			this.addLsnr(elem, false);
		}
		if((round & 2) != 0) if((elem = igtab_getElementById(id + "td" + i + "R")) != null)
		{
			elem.setAttribute("tabID", id + "," + i);
			tab.elemRight = elem;
			this.addLsnr(elem, false);
		}
	}
	this.findControl=function(id)
	{
		var control;//= ig.findControl(this.element,id,false);
		var tabIndex=0;
		while(this.Tabs[tabIndex]!=null)
		{
			control=this.Tabs[tabIndex].findControl(id);
			if(control!=null)return control;
			tabIndex++;
		}
	}

	//
	this.update = function(x, y, v)
	{
		if(this.elemViewState == null) return;
		var val, sep1 = this.sep1, sep2 = this.sep2, old = this.elemViewState.value;
		var i0 = old.indexOf(sep1);
		if(x < 0)
		{
			val = this.selected;
			if(i0 > 0) val += sep1 + old.substring(i0 + 1);
			this.elemViewState.value = val;
			return;
		}
		x = val = "" + x;
		x += sep2;
		var xx = old.split(sep1);
		var i = xx.length;
		while(--i > 0) if(xx[i].indexOf(x) == 0) break;
		if(i > 0) old = old.replace(sep1 + (val = xx[i]), "");
		xx = val.split(sep2);
		i = xx.length;
		while(--i > 0) if((i & 1) != 0) if(xx[i] == y) break;
		if(i > 0) val = val.replace(sep2 + y + sep2 + xx[i + 1], "");
		this.elemViewState.value = old + sep1 + val + sep2 + y + sep2 + v;
	}
	//
	this.fireEvt = function(o, evtName, e)
	{
		var owner = o.owner;
		if(owner == null) owner = o;
		if(!igtab_not0(evtName)) return false;
		var evt = owner.Event;
		if(evt == null) evt = owner.Event = new ig_EventObject();
		evt.reset();
		if((evt.event = e) == null) ig_fireEvent(owner, evtName);
		else ig_fireEvent(owner, evtName, o, evt);
		owner.doPost = (evt.needPostBack == true) || (owner.autoPost && evt.cancelPostBack == false);
		return evt.cancel;
	}
}
// constructor for Tab and methods
function igtab_newT(id, prop, i, css0, own)
{
	this.owner = own;
	var o = igtab_getElementById(id + "_div" + i);
	this.elemDiv = (o == null)? own.elemEmpty : o;
	this.elemIframe = igtab_getElementById(id + "_frame" + i);
	this.index = i;
	// 0 - visible: none - false, 1 - true
	// 1 - enabled: none - false, 1 - true
	this.visible = igtab_not0(igtab_val(prop, 0));
	this.enabled = igtab_not0(igtab_val(prop, 1));
	this.state = this.enabled ? 0 : 3;
	// css
	// 2 - style flags: 0..15 (1-defStyle, 2-hovStyle, 4-selStyle, 8-disStyle)
	// 3 - customCss: none or "defCss+hovCss+selCss+disCss"
	o = igtab_val(prop, 2);
	var st = igtab_not0(o) ? parseInt(o) : 0;
	var cssT = own.doCss(igtab_val(prop, 3));
	var defCss = id + "DefT";
	if((st & 1) != 0) defCss += i;
	if(igtab_not0(o = igtab_val(cssT, 0))) defCss += " " + o;
	if(igtab_not0(o = igtab_val(css0, 0))) defCss += " " + o;
	var hovCss = id + "HovT";
	if((st & 2) != 0) hovCss += i;
	else
	{
		if(own.noHov) hovCss = id + "DefT";
		if((st & 1) != 0) hovCss += i;
	}
	if(igtab_not0(o = igtab_val(cssT, 1))) hovCss += " " + o;
	if(igtab_not0(o = igtab_val(css0, 1))) hovCss += " " + o;
	var selCss = id + "SelT";
	if((st & 4) != 0) selCss += i;
	if(igtab_not0(o = igtab_val(cssT, 2))) selCss += " " + o;
	if(igtab_not0(o = igtab_val(css0, 2))) selCss += " " + o;
	var disCss = id + "DisT";
	if((st & 8) != 0) disCss += i;
	if(igtab_not0(o = igtab_val(cssT, 3))) disCss += " " + o;
	if(igtab_not0(o = igtab_val(css0, 3))) disCss += " " + o;
	this.css = [defCss, hovCss, selCss, disCss];
	// 4 - TargetUrl: none or "value"
	// 5 - images: none or "defImg;hovImg;selImg;disImg"
	// 6 - text: none or "value" filtered for \"
	// 7 - backColor
	// 8 - key
	// 9 - ImgAlign
	this.targetUrl = igtab_val(prop, 4);
	o = igtab_val(prop, 5).split(";");
	this.img = [igtab_val(o, 0), igtab_val(o, 1), igtab_val(o, 2), igtab_val(o, 3)];
	if(!igtab_not0(this.img[3])) this.img[3] = this.img[0];
	this.text = igtab_val(prop, 6);
	this.selColor = igtab_val(prop, 7);
	this.Key = igtab_val(prop, 8);
	this.imgAlign = igtab_val(prop, 9);
	//
	this.getIndex = function(){return this.index;}
	this.getElement = function(){return this.element;}
	this.getOwner = function(){return this.owner;}
	this.getTargetUrlDocument = function()
	{
		var d, f = this.elemIframe;
		if(f == null) return null;
		if((d = f.contentWindow) != null) if((d = d.document) != null) return d;
		if((d = f.contentDocument) != null) return d;
		return null;
	}
	this.getVisible = function(){return this.visible;}//0
	this.setVisible = function(value)
	{
		if(this.visible == (value == true)) return;
		this.visible = (value == true);
		this.vis(this.element, this.visible ? "" : null);
		this.vis(this.elemLeft, this.visible ? "" : null);
		this.vis(this.elemRight, this.visible ? "" : null);
		this.fixSel();
		this.owner.update(this.index + 1, 0, value ? "1" : "");
	}
	this.getEnabled = function(){return this.enabled;}//1
	this.setEnabled = function(value){return this.owner.setEnabled0(this, value);}
	this.getText = function(){return this.text;}//2
	this.setText = function(value)
	{
		if(this.text == value || !igtab_hasLen(value)) return;
		this.text = value;
		this.element.innerHTML = " " + value + " ";
		this.fixImg(-1);
		this.owner.update(this.index + 1, 2, this.text);
	}
	this.getTooltip = function(){return this.tooltip;}//3
	this.setTooltip = function(value)
	{
		if(igtab_hasLen(value)) this.element.title = this.tooltip = value;
		this.owner.update(this.index + 1, 3, value);
	}
	this.getTargetUrl = function(){return this.targetUrl;}//4
	this.setTargetUrl = function(value)
	{
		if(value == null || value == this.owner.dummy) value = "";
		if(this.targetUrl == value || this.elemIframe == null) return;
		this.targetUrl = value;
		this.elemIframe.src = (value.length == 0) ? this.owner.dummy : value;
		if(this.state == 2) if((value.length == 0) != (this.elemIframe.style.display == "none"))
		{
			this.vis(this.elemDiv, (value.length == 0) ? "block" : null);
			this.vis(this.elemIframe, (value.length > 0) ? "block" : null);
		}
		this.owner.update(this.index + 1, 4, value);
	}
	this.getDefaultImage = function(){return this.img[0];}//5
	this.setDefaultImage = function(value){this.doImg(value, 0);}
	this.getHoverImage = function(){return this.img[1];}//6
	this.setHoverImage = function(value){this.doImg(value, 1);}
	this.getSelectedImage = function(){return this.img[2];}//7
	this.setSelectedImage = function(value){this.doImg(value, 2);}
	this.getDisabledImage = function(){return this.img[3];}//8
	this.setDisabledImage = function(value){this.doImg(value, 3);}
	this.doImg = function(value, state)
	{
		if(value == null) value = "";
		if(this.img[state] == value) return;
		this.img[state] = value;
		if(this.state == state) this.fixImg(-2);
		this.owner.update(this.index + 1, 5 + state, value);
	}
	this.fixImg = function(state)
	{
		if(this.state == state || (state >= -1 && !igtab_not0(this.img[0] + this.img[1] + this.img[2] + this.img[3]))) return;
		var c = this.element;
		var im, imgC = null, nodes = c.childNodes;
		if(nodes == null) return;
		var i = nodes.length;
		while(i-- > 0){im = nodes[i].tagName; if(im == "IMG" || im == "img"){imgC = nodes[i]; break;}}
		if(state < 0 || state > 3) state = this.state;
		if(!igtab_not0(im = this.img[state])) im = this.img[0];
		if(igtab_not0(im))
		{
			if(imgC == null)
			{
				if((imgC = document.createElement("IMG")) != null)
				{
					if((i = c.lastChild) != null) c.removeChild(i);
					imgC = c.appendChild(imgC);
					if(i != null) c.appendChild(i);
				}
				if(imgC != null)
				{
					imgC.border = 0;
					if(igtab_not0(this.imgAlign)) imgC.align = this.imgAlign;
				}
			}
			if(imgC != null) imgC.src = im;
		}
		else if(imgC != null) c.removeChild(imgC);
	}
	//
	this.fixSel = function()
	{
		if(this.visible && this.enabled) return;
		if(this.owner.selected != this.index) return;
		if(!this.visible)
		{
			this.vis(this.elemDiv);
			this.vis(this.elemIframe);
		}
		var o, i = this.index;
		while(i-- > 0)
		{
			o = this.owner.Tabs[i];
			if(o.visible && o.enabled){igtab_selectTab(o.owner, o.index); return;}
		}
		i = this.index;
		while(++i < this.owner.Tabs.length)
		{
			o = this.owner.Tabs[i];
			if(o.visible && o.enabled){igtab_selectTab(o.owner, o.index); return;}
		}
		igtab_selectTab(this.owner, -1);
	}
	//
	this.rect = function(o, s)
	{
		if(s == 0)//w
		{
			if((s = o.offsetWidth) != null) return s;
			return ((s = o.style.pixelWidth) != null) ? s : -10000;
		}
		if(s == 1)//h
		{
			if((s = o.offsetHeight) != null) return s;
			return ((s = o.style.pixelHeight) != null) ? s : -10000;
		}
		if(s == 2)//x
		{
			if((s = o.offsetLeft) != null) return s;
			return ((s = o.style.pixelLeft) != null) ? s : -10000;
		}
		if(s == 3)//y
		{
			if((s = o.offsetTop) != null) return s;
			return ((s = o.style.pixelTop) != null) ? s : -10000;
		}
	}
	//
	this.setState = function(state, e)
	{
		if(state < 0 || state > 3 || state == this.state) return;
		if(e != null)
		{
			if(state == 1)
			{
				if(this.owner.hover == this) return;
				if(this.owner.hover != null && this.owner.hover.state == 1)
					this.owner.hover.setState(0, e);
			}
			this.owner.hover = (state == 1 || state == 2) ? this : null;
			if(this.state == 3 || !this.owner.enabled) return;
		}
		if(state == 2)
		{
			if(e != null)
			{
				this.owner.doPost = this.owner.autoPost;
				if(this.owner.fireEvt(this, this.owner.Events.beforeSelectedTabChange, e)) return;
				if(this.owner.doPost)
				try{__doPostBack(this.owner.uniqueId, "" + this.index); return;}catch(ex){}
			}
			igtab_selectTab(this.owner, this.index);
			if(e != null) this.owner.fireEvt(this, this.owner.Events.afterSelectedTabChange, e);
			return;
		}
		if(e != null && state < 2)
		{
			this.owner.fireEvt(this, (state == 0) ? this.owner.Events.mouseOut : this.owner.Events.mouseOver, e);
			if(this.owner.selected == this.index) return;
		}
		this.doState(state);
		this.state = state;
	}
	this.doState = function(state)
	{
		if(state < 0) state = (this.owner.enabled || this.state == 2) ? this.state : 3;
		this.fixImg(state);
		if(this.element.className != this.css[state]) this.element.className = this.css[state];
		if(this.elemLeft != null && this.elemLeft.className != this.owner.leftImg[state]) this.elemLeft.className = this.owner.leftImg[state];
		if(this.elemRight != null && this.elemRight.className != this.owner.rightImg[state]) this.elemRight.className = this.owner.rightImg[state];
	}
	this.findControl = function(id)
	{
		var c = ig.findControl(this.elemDiv, id);
		if(c == null) if((c = this.getTargetUrlDocument()) != null) c = ig.findControl(c, id);
		return c;
	}
	this.vis = function(e, v){if(e == null) return; e.style.display = (v == null) ? "none" : v; e.style.visibility = (v == null) ? "hidden" : "visible";}
}
//
function igtab_selectTab(owner, index)
{
	if(owner == null) return;
	var o, i = owner.selected;
	if(i == null)
	{
		if((owner = igtab_getTabById(owner)) == null) return;
		if((i = owner.selected) == null) return;
	}
	if(index == i || index < -1 || owner.Tabs.length <= index) return;
	// unselect old tab
	var obj = owner.elemEmpty;
	if(i >= 0)
	{
		o = owner.Tabs[i];
		o.vis(o.elemDiv);
		if(o.elemIframe != null)
		{
			o.vis(o.elemIframe);
			if(!owner.loadAllUrls) o.elemIframe.src = owner.dummy;
		}
		o.setState(o.enabled ? 0 : 3, null);
	}
	else if(obj != null){obj.style.display = "none"; obj.style.visibility = "hidden";}
	// select new tab
	owner.selected = index;
	owner.update(-1, -1, 0);
	if(index < 0)
	{
		if(obj != null){obj.style.display = "block"; obj.style.visibility = "visible";}
		return;
	}
	if((obj = owner.Tabs[index]) == null) return;
	if(!obj.enabled) obj.setEnabled(true);
	if(!obj.visible) obj.setVisible(true);
	obj.fixImg(2);
	obj.element.className = obj.css[2];
	if(obj.elemLeft != null) obj.elemLeft.className = owner.leftImg[2];
	if(obj.elemRight != null) obj.elemRight.className = owner.rightImg[2];
	obj.state = 2;
	o = obj.targetUrl;
	if(o.length > 2 && obj.elemIframe != null)
	{
		if(obj.elemIframe.src != o) obj.elemIframe.src = o;
		obj.vis(obj.elemIframe, "block");
	}
	else obj.vis(obj.elemDiv, "block");
	// set backcolor
	if((o = igtab_getElementById(owner.ID + "_cp")) != null)
	{
		i = obj.element.className.indexOf(" ");
		o.className = (i > 2) ? obj.element.className.substring(i + 1) : "";
		o.bgColor = obj.selColor;
		if(o.style != null) o.style.backgroundColor = obj.selColor;
	}
}
function igtab_getTabFromElement(e)
{
	var t, ids = null, i = 0;
	while(true)
	{
		if(e == null) return null;
		try{if(e.getAttribute != null) ids = e.getAttribute("tabID");}catch(ex){}
		if(igtab_not0(ids)) break;
		if(++i > 1) return null;
		if((t = e.parentNode) != null) e = t;
		else e = e.parentElement;
	}
	if(!igtab_not0(ids = ids.split(","))) return null;
	t = igtab_getTabById(ids[0]);
	if(t == null || ids.length < 2) return t;
	if(!igtab_not0(t.Tabs)) return null;
	return t.Tabs[parseInt(ids[1])];
}
// process events
function igtab_mouseout(e){igtab_event(e, 0);}
function igtab_mouseover(e){igtab_event(e, 1);}
function igtab_click(e){igtab_event(e, 2);}
function igtab_event(e, state)
{
	if(e == null) if((e = window.event) == null) return;
	var o = null;
	if(e.srcElement != null) o = e.srcElement;
	else if(e.target != null) o = e.target;
	else o = this;
	if(state == 2 && (e.button > 0 || e.ctrlKey || e.shiftKey || e.altKey)) return;
	if((o = igtab_getTabFromElement(o)) == null) return;
	if(state > 0){o.setState(state, e); return;}
	var z, w = o.rect(o.element, 0), h = o.rect(o.element, 1);
	var x = o.rect(o.element, 2), y = o.rect(o.element, 3);
	if(o.elemLeft != null)
	{
		if((z = o.rect(o.elemLeft, 2)) < x){w += (x - z); x = z;}
		if((z = o.rect(o.elemLeft, 3)) < y){h += (y - z); y = z;}
	}
	if(o.elemRight != null)
	{
		if(o.rect(o.elemRight, 2) > x) w += o.rect(o.elemRight, 0);
		if(o.rect(o.elemRight, 3) > y) h += o.rect(o.elemRight, 1);
	}
	z = o.element;
	while((z = z.offsetParent) != null){x += o.rect(z, 2); y += o.rect(z, 3);}
	if(e.clientX < x + 3 || e.clientY < y + 3 || e.clientX + 3 > x + w || e.clientY + 3 > y + h)
		o.setState(0, e);
}
function igtab_kill(e)
{
	if(e == null) if((e = window.event) == null) return;
	e.cancelBubble = true;
	e.returnValue = false;
}
function igtab_evtLsnr(o, en, f)
{ 
	if(o.addEventListener != null) o.addEventListener(en, f, false);
	else if(o.attachEvent != null) o.attachEvent("on" + en, f);
	else try{eval("o.on" + en + "=" + f);}catch(ex){}
}
// util
function igtab_hasLen(o){return o != null && o.length != null;}
function igtab_not0(o){return igtab_hasLen(o) && o.length > 0;}
function igtab_val(o, i){return (o == null || o.length <= i) ? "" : o[i];}
