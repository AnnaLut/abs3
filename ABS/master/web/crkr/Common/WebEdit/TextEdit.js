var all_elems = new Array();

function initEdit(id, type, prop, val)
{
	var elem = document.getElementById(id);
	if(elem == null ) return;
		
	prop = prop.split(",");
	var o = null;
	if(type == 0)
		o = new init_text(elem,id,prop);
	else if(type == 1)
		o = init_mask(elem,id,prop,val); 
	else if(type == 2)
		o = init_date(elem,id,prop,val); 
	else if(type == 4)
		o = init_number(elem,id,prop,val); 
	
	
	if(o == null) return;
	all_elems[id] = o;
	//else 
	//	status = "Ошибка обработки скрипта для контрола "+id;
	
	o.setValue(val[0]);
	delete(prop);
	delete(val);
	o.old = o.instant(true);
	o.focus = 0;
	o.fireEvent(10);
}
//////////////////////////////////////////////////////////////////////////////////
function init_text(elem,id,prop)
{
	this.focus = -1;
	this.elemID = -10;
	this.bad = false;
	this.Element = elem;
	elem.Object = this;
	this.focusTxt = function(foc, e)
	{
		if(e != null && !foc)
		{
			this.elemViewState.value = this.elem.value;
			this.elemValue.value = this.elem.value;
		}
		return this.elem.value;
	}
	//Индентификатор события
	this.eventID = function(s)
	{
		switch(s.toLowerCase())
		{
			case "keydown": return 0;
			case "keypress": return 1;
			case "keyup": return 2;
			case "mousedown": return 3;
			case "mouseup": return 4;
			case "mousemove": return 5;
			case "mouseover": return 6;
			case "mouseout": return 7;
			case "focus": return 8;
			case "blur": return 9;
			case "initialize": return 10;
		}
		return -1;
	}
	this.events = new Array(10);
	var o, ii, j, i = 0, e = new Object();
	e.value = String.fromCharCode(30);
	this.elemViewState = e;
	this.elemValue = elem;
	this.uniqueId = id;
	//Propeties
	this.selectionOnFocus = getInt(prop[i++]) - 1;
	this.allowAlt = getBool(prop[i++]);
	this.maxLength = getInt(prop[i++]);
	this.hideEnter = getBool(prop[i++]);
	
	this.repaint = function()
	{
		if(this.elem.value == this.text) return;
		this.elem.value = this.text;
	}
	//
	this.elem = e = elem;
	addEventListener(e, "keydown", callEvent);
	addEventListener(e, "keypress", callEvent);
	addEventListener(e, "keyup", callEvent);
	addEventListener(e, "focus", callEvent);
	addEventListener(e, "blur", callEvent);
	addEventListener(e, "mousedown", callEvent);
	addEventListener(e, "mouseup", callEvent);
	addEventListener(e, "mousemove", callEvent);
	addEventListener(e, "mouseover", callEvent);
	addEventListener(e, "mouseout", callEvent);
	
	this.ID = id;
	this.tr = e.createTextRange();
	this.getEnabled = function(){return !this.elem.disabled;}
	this.setEnabled = function(v)
	{
		if(this.elem.disabled == !v) return; this.elem.disabled = !v;
	}
	this.getVisible = function(){return this.Element.style.display != "none";}
	this.getReadOnly = function(){return this.elem.readOnly;}
	this.setReadOnly = function(v){this.elem.readOnly = v;}
	this.getText = function(){return this.elem.value;}
	this.setText = function(v){this.text = v; this.repaint();}
	this.instant = function(){return this.getText();}
	this.getValue = function(){return this.instant();}
	this.setValue = function(v){this.setText("" + ((v == null) ? "" : v));}
	this.doKey = function(k, c, t, i, sel0, sel1)
	{
		if(sel0 != sel1){t = t.substring(0, sel0) + t.substring(sel1); sel1 = sel0; i = t.length;}
		//7-del,8-back
		else if(k == 7){if(sel1++ >= i || i == 0) return;}
		else if(k == 8){if(sel0-- < 1) return;}
		if(k < 9 || this.maxLength == 0 || this.maxLength > i)
		{
			if(k > 8 && sel1 >= i) t += c;
			else t = t.substring(0, sel0) + c + t.substring(sel1);
		}
		else k = 0;
		//
		this.elem.value = t;
		this.select((k > 10) ? sel1 + 1 : sel0);
	}
	
	this.doKey0 = function(e, a)
	{
		var t0 = this.text, t1 = this.elem.value;
		if(e.ctrlKey){if(t0 != t1) this.paste(t1); return;}
		if(e.altKey){this.k0 = -1; return;}
		var k = e.keyCode;
		if(k == 0 || k == null) if((k = e.which) == null) return;
		if(a == 0) this.k0 = k;
		if(a == 2){if(this.k0 > 0) this.k0 = 0; this.spinF = -1;}
		var i = t1.length;
		if(k <= 46)
		{
			switch(k)
			{
				case 8: case 46://back//del
					if(this.k0 == k && a == 1) a = 2;
					if(a == 0){a = 1; if(k == 46) k = 7;}
					break;
				case 27://esc
					ig_cancelEvent(e); return;
				case 13://enter
					if(this.hideEnter) cancelEvent(e);
					else this.elemValue.value = this.enter0();
					if(this.postEnter) this.doPost(2);
					return;
				case 38: case 40://up//down
					if(this.k0 == k) a = 2;
					break;
			}
		}
		if(!this.bad)
		{
			if(a == 1 && k == this.k0 && ((k < 48 && k > 9 && k != 32) || k > 90)) return;
			if(a != 0) cancelEvent(e);
			if(a == 1 && this.k0 == -1){this.k0 = 0; if(this.allowAlt) this.getSelectedText(); else return;}
			if(a == 0 || k < 9) this.getSelectedText();
			if(a == 1 && k > 6)
			{
				if(k > 31)
				{
					if(this.fireEvent(1, e, k)) return;
					if((a = this.Event) != null) if((a = a.keyCode) != null) k = a;
				}
				this.doKey(k, (k < 10) ? "" : String.fromCharCode(k), t1, i, this.sel0, this.sel1);
			}
		}
	}
	
	this.paste = function(v)
	{
		var m = this.maxLength;
		if(m > 0 && m < v.length) v = v.substring(0, m);
		this.text = "";
		this.setText(v);
		this.fireEvent(12, null);
	}
	//enter-key
	this.enter0 = function(){return this.elem.value;}
	//update post field and fire change event
	this.update = function(post)
	{
		this.text = this.focusTxt(false, "");
		var v = this.instant(true);
		if(v != null && this.old != null) if(v.getTime != null && v.getTime() == this.old.getTime())
			v = this.old;
		if(v != this.old)
		{
			if(this.fireEvent(11, null, this.old))
			{
				this.setValue(this.old);
				this.text = this.focusTxt(false, null);
			}
			else
			{
				this.old = v;
				if(post && (this.Event.id != 11 || !this.Event.cancelPostBack)) this.doPost(3);
			}
		}
	}
	
	this.doEvt = function(e)
	{
		var v = this.elemID, type = this.eventID(e.type);
		//cut from mask
		if(type == 5 && this.focus == 2) this.getSelectedText();
		if(v >= 0){this.doBut(e, type, v); return;}
		if(type != 1) if(this.fireEvent(type, e)) if(type < 4){cancelEvent(e); return;}
		var val = this.elem.value;
		if(type < 3){if(this.focus == 2) this.doKey0(e, type);}
		else if(type >= 8)
		{
			this.spinF = -1;
			var foc = (type == 8);
			if(foc == (this.focus > 0)) return;
			v = (!this.getReadOnly() && this.getEnabled()) ? 2 : 1;
			this.focus = foc ? v : 0;
			if(v == 1) return;
			if(foc)
			{
				if(val != this.text)// && this.k0 <= 0)
					this.paste(val);
				this.text = this.focusTxt(foc, e);
			}
			else this.update(this.postValue);
			this.repaint();
			if(foc) this.select(this.selectionOnFocus * 10000);
			return;
		}
		if(val != this.text)
		{
			if(type > 3 && this.k0 == 0){this.paste(val); return;}
			this.text = val;
			this.fireEvent(12, e);
		}
	}
	//notify listeners and post
	this.fireEvent = function(id, evnt, arg)
	{
		if(id == 12)
		{
			if(this.lastText == (arg = this.elem.value)) return;
			this.lastText = this.text = arg;
			if(this.focus < 2) this.update();
		}
		var evt = this.Event;
		if(evt == null) evt = this.Event = new EventObject();
		evt.id = id;
		var evts = this.events[id];
		var i = (evts == null) ? 0 : evts.length;
		if(i == 0) return;
		var cancel = false, once = true;
		evt.keyCode = null;
		if(arg == null)
		{
			if(id < 3){arg = evnt.keyCode; if(arg == 0 || arg == null) arg = evnt.which;}
			else arg = this.elem.value;
		}
		while(i-- > 0)
		{
			if(evts[i] == null) continue;
			if(once){evt.reset(); evt.event = evnt; once = false;}
			evts[i].fRef(this, arg, evt, evts[i].o);
			if(evt.cancel) cancel = true;
		}
		if(evt.needPostBack && (id != 14 || !this.postButton)) this.doPost(0);
		return cancel;
	}
	this.select = function(sel0, sel1)
	{
		var e = this.elem;
		var i = e.value.length;
		if(sel1 == null){sel1 = sel0; if(sel0 == null || sel0 < 0){sel0 = 0; sel1 = i;}}
		if(sel1 >= i) sel1 = i;
		else if(sel1 < sel0) sel1 = sel0;
		if(sel0 > sel1) sel0 = sel1;
		this.sel0 = sel0; this.sel1 = sel1;
		if(e.selectionStart != null)
		{e.readOnly = true; e.selectionStart = sel0; e.selectionEnd = sel1; e.readOnly = false;}
		if(this.tr == null) return;
		sel1 -= sel0;
		this.tr.move("textedit", -1);
		this.tr.move("character", sel0);
		if(sel1 > 0) this.tr.moveEnd("character", sel1);
		this.tr.select();
	}
	this.getSelectedText = function()
	{
		var r = "";
		this.sel0 = this.sel1 = 0;
		if(this.elem.selectionStart != null)
		{
			if((this.sel0 = this.elem.selectionStart) < (this.sel1 = this.elem.selectionEnd))
				r = this.elem.value.substring(this.sel0, this.sel1);
			return r;
		}
		if(this.tr == null){this.bad = true; return r;}
		var sel = document.selection.createRange();
		r = sel.duplicate();
		r.move("textedit", -1);
		try{while(r.compareEndPoints("StartToStart", sel) < 0)
		{
			if(this.sel0++ > 1000) break;
			r.moveStart("character", 1);
		}}catch(ex){}
		delete(r);
		r = sel.text;
		delete(sel);
		this.sel1 = this.sel0 + r.length;
		return r;
	}
	this.doPost = function(type)
	{
		if(type == 0 || this.Event == null || !this.Event.cancelPostBack)
		{
			if(this.focus == 2) this.update();
			try{__doPostBack(this.uniqueId, type);}catch(ex){}
		}
	}
}


function callEvent(e)
{
	if(e == null) if((e = window.event) == null) return;
	var o = e.srcElement;
	if(o == null) if((o = e.target) == null) o = this;
	if((o = all_elems[o.id]) != null) if(o.doEvt != null) {o.doEvt(e);}
}

this.addEventListener = function(obj,eventName,callbackFunction,flag)
{ 
	if (obj.addEventListener) {
		obj.addEventListener(eventName,callbackFunction,flag);
	}
	else if (obj.attachEvent) {
		obj.attachEvent("on"+eventName,callbackFunction);
	}
	else {
		eval("obj.on"+eventName+"="+callbackFunction);
	}
}

function cancelEvent(e)
{
	if(e == null) if((e = window.event) == null) return;
	if(e.stopPropagation != null) e.stopPropagation();
	if(e.preventDefault != null) e.preventDefault();
	e.cancelBubble = true;
	e.returnValue = false;
}

function EventObject(){
	this.event=null;
	this.cancel=false;
	this.cancelPostBack=false;
	this.needPostBack=false;
	this.reset=resetEvent;
}
function resetEvent(){
	this.event=null;
	this.cancel=false;
	this.cancelPostBack=false;
	this.needPostBack=false;
}

function getBool(o)
{
	return (o==null || o=="" || o==0 || o=="0")? false:true;
} 
function getInt(o)
{
	return (o==null || o=="") ? -1 : parseInt(o);
}
function getVal(o)
{
	return (o == null) ? "" : o;
}
///////////////////////////////////////////
function init_number(elem, id, prop0, prop1)
{
	var me = new init_text(elem, id, prop0);
	var i = 1;
	var j = -1, v = getVal(prop1[i++]);
	if(v.length < 1) v = ".";
	me.decimalSeparator = v;
	me.groupSeparator = getVal(prop1[i++]);
	v = getVal(prop1[i++]);
	if(v.length < 1) v = "-";
	me.minus = v;
	me.symbol = getVal(prop1[i++]);
	me.nullText = getVal(prop1[i++]);
	me.positivePattern = getVal(prop1[i++]);
	me.negativePattern = getVal(prop1[i++]);
	me.mode = getVal(prop1[i++]);
	me.decimals = getVal(prop1[i++]);
	me.minDecimals = getVal(prop1[i++]);
	v = getVal(prop1[i++]);
	if(v == 1) me.min = getVal(prop1[i++]);
	v = getVal(prop1[i++]);
	if(v == 1) me.max = getVal(prop1[i++]);
	me.groups = new Array();
	while(++j < 6){if((v = getVal(prop1[i++])) > 0) me.groups[j] = v; else break;}
	//
	me.getMaxValue = function(){return this.max;}
	me.setMaxValue = function(v){this.max = this.toNum(v, false);}
	me.getMinValue = function(){return this.min;}
	me.setMinValue = function(v){this.min = this.toNum(v, false);}
	//
	me.toNum = function(t, limit, fire)
	{
		var c, num = null, i = -1, div = 1, dec = -1, iLen = 0;
		if(t == null || t.length == null) num = t;
		else
		{
			var neg = false, dot = this.decimalSeparator.charCodeAt(0);
			if(t != null)
			{
				if(t.toUpperCase == null) t = t.toString();
				iLen = t.length;
			}
			while(++i < iLen)
			{
				if(this.isMinus(c = t.charCodeAt(i))){if(neg) break; neg = true;}
				if(c == dot){if(dec >= 0) break; dec = 0;}
				if(c < 48 || c > 57) continue;
				if(num == null) num = 0;
				if(dec < 0) num = num * 10 + c - 48;
				else{dec = dec * 10 + c - 48; div *= 10;}
			}
			if(num != null){if(dec > 0) num += dec / div; if(neg) num = -num;}
		}
		i = limit ? this.limits(num) : num;
		if(fire != true) return i;
		c = "";
		if(i != num || (i == null && iLen > 0))
		{
			fire = new Object();
			fire.value = i;
			fire.text = t;
			fire.type = (num == null) ? ((iLen == 0) ? 2 : 0) : 1;
			c = String.fromCharCode(30);
			c += t + c + fire.type;
			if(this.fireEvent(13, null, fire)) c = "";
			i = fire.value;
		}
		this.value = i;
		t = this.toTxt(i, true, null, "-", ".");
		this.elemViewState.value = t + c;
		this.elemValue.value = t;
		return i;
	}
	me.enter0 = function(){return this.toTxt(null, true, this.elem.value, "-", ".");}
	me.focusTxt = function(foc, e)
	{
		if(e != null && !foc) this.value = this.toNum(this.elem.value, true, true);
		return this.toTxt(this.value, foc);
	}
	me.toTxt = function(v, foc, t, m, dec)
	{
		if(t == null)
		{
			if(v == null) return foc ? "" : this.nullText;
			var neg = (v < 0);
			if(neg) v = -v;
			try{t = v.toFixed(this.decimals);}catch(ex){t = "" + v;}
			return this.toTxt(neg, foc, t.toUpperCase(), (m == null) ? this.minus : m, (dec == null) ? this.decimalSeparator : dec);
		}
		var c, i = -1, iL = t.length;
		if(v == null)
		{
			if(iL == 0) return foc ? t : this.nullText;
			if(v = this.isMinus(t.charCodeAt(0))) t = t.substring(1);
		}
		var iE = t.indexOf("E");
		if(iE < 0) iE = 0;
		else
		{
			iL = parseInt(t.substring(iE + 1));
			t = t.substring(0, iE);
			iE = iL;
		}
		iL = t.length;
		// find and remove dot
		while(++i < iL)
		{
			c = t.charCodeAt(i);
			if(c < 48 || c > 57){t = t.substring(0, i) + t.substring(i + 1); iL--; break;}
		}
		if(iE != 0)
		{
			while(iE-- > 0) if(i++ >= iL) t += "0";
			if(++iE < 0)
			{
				if(i == 0) t = "0" + t;
				while(++iE < 0) t = "0" + t;
				t = "0" + t;
				i = 1;
			}
		}
		iL = i;
		var iDec = 0;
		if(this.decimals > 0 && iL < t.length)
		{
			iDec = t.length - iL;
			t = t.substring(0, iL) + dec + t.substring(iL);
			iL += dec.length + this.decimals;
		}
		if(iL < t.length) t = t.substring(0, iL);
		if((iL = this.minDecimals) != 0)
		{
			if(iDec == 0) t += dec;
			while(iL-- > iDec) t += "0";
		}
		if(foc) return v ? (m + t) : t;
		var g0 = (this.groups.length > 0) ? this.groups[0] : 0;
		var ig = 0, g = g0;
		while(g > 0 && --i > 0) if(--g == 0)
		{
			t = t.substring(0, i) + this.groupSeparator + t.substring(i);
			g = this.groups[++ig];
			if(g == null || g < 1) g = g0;
			else g0 = g;
		}
		var txt = v ? this.negativePattern : this.positivePattern;
		txt = txt.replace("$", me.symbol);
		return txt.replace("n", t);
	}
	me.setText = function(v){this.setValue(v);}
	me.isMinus = function(k){return k == this.minus.charCodeAt(0) || k == 45 || k == 40;}
	me.doKey = function(k, c, t, i, sel0, sel1)
	{
		if(sel0 != sel1){t = t.substring(0, sel0) + t.substring(sel1); sel1 = sel0; i = t.length;}
		//7-del,8-back
		else if(k == 7){if(sel1++ >= i || i == 0) return;}
		else if(k == 8){if(sel0-- < 1) return;}
		if(k < 9 || this.maxLength == 0 || this.maxLength > i)
		{
			var dot = k == this.decimalSeparator.charCodeAt(0);
			var ok = (k > 47 && k < 58) || (sel0 == 0 && this.isMinus(k)) || (dot && this.decimals > 0);
			if(i > 0 && sel0 == 0) if(this.isMinus(t.charCodeAt(0))) ok = false;
			if(k > 8 && !ok) return;
			if(dot) if((dot = t.indexOf(this.decimalSeparator)) >= 0)
			{
				if(dot == sel0 || dot == sel0 - 1) return;
				i--;
				if(dot < sel0) sel0 = --sel1;
				t = t.substring(0, dot) + t.substring(dot + 1);
			}
			if(k > 8 && sel1 >= i) t += c;
			else t = t.substring(0, sel0) + c + t.substring(sel1);
		}
		else k = 0;
		//
		this.elem.value = t;
		this.select((k > 10) ? sel1 + 1 : sel0);
	}
	me.limits = function(v)
	{
		if(v == null && !this.nullable) v = 0;
		if(v != null)
		{
			var i = this.min;
			if(i != null && v < i) v = i;
			if((i = this.max) != null) if(v > i) v = i;
		}
		return v;
	}
	me.getNumber = function(){return this.instant(true, true);}
	me.setNumber = function(v){this.setValue(v);}
	me.instant = function(num, limit)
	{
		var v = (this.focus == 2) ? this.toNum(this.elem.value, limit == true) : this.value;
		return (num || this.mode > 0) ? v : this.toTxt(v, true);
	}
	me.getValue = function(num){return this.instant(num, true);}
	me.setValue = function(v)
	{
		this.text = this.toTxt(this.value = this.toNum(v, true), this.focus == 2);
		this.repaint();
		if(this.focus == 2) this.select(1000);
	}
	me.spin = function(v)
	{
		var val = this.toNum(this.elem.value);
		if(val == null) val = 0;
		this.setValue(val + v);
	}
	me.getRenderedValue = function(v){return this.toTxt(this.toNum(v), false);}
	return me;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function init_mask(elem, id, prop0, prop1)
{
	var me = new init_text(elem, id, prop0);
	var prop = prop1[2];
	me.promptChar = prop.charAt(0);
	me.padChar = prop.charAt(1);
	me.emptyChar = prop.charAt(2);
	me.mode = parseInt(prop.charAt(3));
	me.minF = (prop.length > 4) ? parseInt(prop.charAt(4)) : 3;
	me.good = prop.length > 5;
	//
	me.flag = function(c, u)
	{
		switch(c)
		{
			case '>': return -1;
			case '<': return -2;
			case '&': c = 1; break;
			case 'C': c = 2; break;
			case 'A': c = 7; break;
			case 'a': c = 8; break;
			case 'L': c = 13; break;
			case '?': c = 14; break;
			case '#': case '0': return 19;
			case '9': return 20;
			default: return 0;
		}
		return c + u * 2;
	}
	me.filter = function(flag, s, i, sf)
	{
		if(i >= s.length) return sf;
		var c = s.charCodeAt(i);
		s = s.charAt(i);
		if(c < 21) return sf;
		switch(Math.floor((flag - 1) / 6))
		{
			case 0: break;
			case 1: if(c > 47 && c < 58) return s;
			case 2: if(c > 255 || s.toUpperCase() != s.toLowerCase()) break;
				return sf;
			case 3: return (c > 47 && c < 58) ? s : sf;
		}
		if((flag = Math.floor((flag - 1) / 2) % 3) == 0) return s;
		return (flag == 2) ? s.toLowerCase() : s.toUpperCase();
	}
	me.getTxt = function(vt, prompt, t)
	{
		var flag, mask = this.mask, o = "", non = (t != null);
		if(!non) t = this.txt;
		if(non || this.focus < 0) non = this.minF == 1;
		if(t == null || mask == null) return o;
		for(var i = 0; i < mask.length; i++)
			if((flag = mask.charCodeAt(i)) < 21)
			{
				if(i < t.length && t.charCodeAt(i) >= 21){o += t.charAt(i); non = false;}
				else if(vt % 3 == 2 || (vt % 3 == 1 && (flag & 1) == 1)) o += prompt;
			}
			else if(vt >= 3) o += mask.charAt(i);
		return non ? "" : o;
	}
	me.setTxt = function(v, vt, render)
	{
		var c, flag, j = 0, i = -1, mask = this.mask, t = this.mask;
		if(v != null) while(++i < mask.length)
		{
			if(j >= v.length) break;
			if((flag = mask.charCodeAt(i)) < 21)
			{
				if((c = this.filter(mask.charCodeAt(i), v, j)) != null) t = t.substring(0, i) + c + t.substring(i + 1);
				j++;
			}
			else if(vt >= 3) j++;
		}
		if(render) return t;
		this.txt = t;
		this.text = this.focusTxt(this.focus > 1);
		this.repaint();
	}
	me.getInputMask = function(){return this.m0;}
	me.setInputMask = function(mask)
	{
		if(mask == null) mask = "";
		this.m0 = mask;
		var x, c, i, i0 = 0, u = 0, n = "", t = "";
		var t0 = this.getTxt(0);
		for(i = 0; i < mask.length; i++)
		{
			if((x = this.flag(c = mask.charAt(i), u)) != 0)
			{
				if(x < 0){u = (u == -x) ? 0 : -x; continue;}
				n += (c = String.fromCharCode(x));
				c = this.filter(x, t0, i0++, c);
			}
			else if(c == "\\" && i + 1 < mask.length && this.flag(mask.charAt(i + 1), 0) != 0)
				n += (c = mask.charAt(++i));
			else n += c;
			t += c;
		}
		this.txt = t;
		this.mask = n;
	}
	me.dMask = function(v, d)
	{
		if(this.field0IDs == null) this.field0IDs = new Array();
		if(this.field1IDs == null) this.field1IDs = new Array();
		if(v == null) v = "";
		var x, i, i0 = 0, flag = -1, t = "";
		for(i = 0; i < v.length; i++)
		{
			x = v.charCodeAt(i);
			if(x < 48 || x > 57)
			{
				if(d == true && (flag = v.charAt(i)) == "\\" && i + 1 < v.length)
				{
					if((x = v.charAt(++i)) == "\\") continue;
					if(x == "0" || x == "9") t += flag;
					t += x;
				}
				else t += v.charAt(i);
				continue;
			}
			flag = (x - 48) * 10 + v.charCodeAt(++i) - 48;
			if(d == true){this.field1IDs[i0++] = flag; t += "\01"; continue;}
			this.field0IDs[i0++] = flag;
			if(flag == 14) t += "L"; else if(flag == 15) t += "LL";
			else if(flag == 22) t += "#";
			else
			{
				t += "##";
				if(flag == 3) t += "##";
				while(flag-- > 23) t += "#";
			}
		}
		return t;
	}
	prop = prop1[1];
	if(prop1.length > 3) prop = me.dMask(prop);
	me.setInputMask(prop);
	me.focusTxt = function(foc, e)
	{
		var t = null;
		if(e != null && !foc)
		{
			t = this.txt;
			var inv = t.length;
			var iL = inv - this.elem.value.length, s0 = this.sel0, s1 = this.sel1;
			if(iL > 0 && s1 - s0 == iL)
				this.txt = t = t.substring(0, s0) + this.mask.substring(s0, s1) + t.substring(s1);
			while(inv-- > 0)
			{
				var c = t.charCodeAt(inv);
				if(c < 21 && (c & 1) == 1) break;
			}
			if(inv >= 0) if(this.fireEvent(13)) inv = -1;
			this.elemViewState.value = (t = this.txt) + ((inv < 0) ? "" : String.fromCharCode(30));
			this.elemValue.value = this.getTxt(this.mode, "");
		}
		return this.getTxt(foc ? 5 : 4, foc ? this.promptChar : this.padChar, t);
	}
	me.enter0 = function(){return this.getTxt(this.mode, "");}
	me.setText = function(v){this.setTxt(v, 5);}
	me.key = function(k, c, t, i, s, mask){return -2;}
	me.doKey = function(k, c, t, i, sel0, sel1)
	{
		if(i < 1 || k < 7 || (k > 8 && k < 32)) return;
		t = this.txt;
		var mask = this.mask;
		if(sel0 != sel1){while(--sel1 >= sel0) t = t.substring(0, sel1) + mask.charAt(sel1) + t.substring(sel1 + 1); sel1++;}
		else if(k == 7)//del
		{
			while(sel1 < i && mask.charCodeAt(sel1) >= 21) sel1++;
			if(sel1 >= i) return;
			t = t.substring(0, sel1) + mask.charAt(sel1) + t.substring(sel1 + 1);
			sel1++;
		}
		else if(k == 8)//back
		{
			while(sel1 > 0 && mask.charCodeAt(sel1 - 1) >= 21) sel1--;
			if(sel1-- < 1) return;
			t = t.substring(0, sel1) + mask.charAt(sel1) + t.substring(sel1 + 1);
		}
		if(k > 8 && sel1 < i)
		{
			if(sel1 >= i) return;
			if((sel0 = this.key(k, c, t, i, sel1, mask)) >= 0){t = this.txt; sel1 = sel0;}
			else{if(sel0 == -1) return; while(mask.charCodeAt(sel1) >= 21) if(++sel1 >= i) return;}
			if(sel0 >= 0){t = this.txt; sel1 = sel0;}
			else
			{
				if((c = this.filter(mask.charCodeAt(sel1), c, 0)) == null) return;
				t = t.substring(0, sel1) + c + t.substring(sel1 + 1);
				sel1++;
			}
		}
		this.txt = t;
		this.elem.value = this.focusTxt(true);
		this.select(sel1);
	}
	me.getValueByMode = function(vt){return this.getTxt(vt, this.emptyChar);}
	me.instant = function(){return this.getValueByMode(this.mode);}
	me.getValue = function(){return this.instant();}
	me.setValue = function(v){this.setTxt(v, (this.focus < 0) ? 2 : this.mode);}
	me.getRenderedValue = function(v)
	{
		v = (v == null) ? "" : v.toString();
		return this.getTxt(4, this.padChar, (this.mode == 5) ? v : this.setTxt(v, this.mode, true));
	}
	return me;
}
////////////////////////////////////////////////////
function init_date(elem, id, prop0, prop1)
{
	var me = init_mask(elem, id, prop0, prop1);
	me.mask1 = me.dMask(prop1[3], true);
	me.nullText = prop1[4];
	me.str = getVal(prop1[5]).split(",");
	me.getMaxValue = function(){return this.max;}
	me.setMaxValue = function(v){if(v != null && v.getTime == null) v = this.toDate(v.toString(), true); this.max = v;}
	me.getMinValue = function(){return this.min;}
	me.setMinValue = function(v){if(v != null && v.getTime == null) v = this.toDate(v.toString(), true); this.min = v;}
	me.getAMPM = function(am){var v = getVal(this.str[am ? 0 : 1]); return (v.length > 0) ? v : (am ? "AM" : "PM");}
	me.setAMPM = function(v, am){return this.str[am ? 0 : 1] = v;}
	me.getMonthNameAt = function(i){return getVal(this.str[2 + i % 12]);}
	me.setMonthNameAt = function(v, i){return this.str[2 + i % 12] = v;}
	me.getDowNameAt = function(i){return getVal(this.str[14 + i % 7]);}
	me.setDowNameAt = function(v, i){return this.str[14 + i % 7] = v;}
	me.setNow = function(){this.setValue(new Date());}
	me.date = new Date();
	me.isNull = false;
	me.d_s = 10;
	me.setText = function(v){this.setValue(v, true);}
	me.fieldValue = function(field, d, e, c)
	{
		// 1 - y,  2 - yy, 3 - yyyy
		// 4 - M,  5 - MM, 6 - MMM,  7 - MMMM
		// 8 - d,  9 - dd
		//10 - h, 11 - hh, 12 - H, 13 - HH
		//14 - t, 15 - tt
		//16 - m, 17 - mm
		//18 - s, 19 - ss
		//20 - ddd, 21 - dddd
		//22 - f, 23 - ff, 24 - fff, 25 = ffff, 26 - fffff, 27 - ffffff, 28 - fffffff
		var v, i = (field & 1) * 2;
		if(field < 4){v = d.getFullYear(); if(field == 3) i = 4; else{v %= 100; i = (field == 2) ? 2 : 0;}}
		else if(field < 8){this.d_s = 2; v = d.getMonth() + 1; if(field > 5){field = this.getMonthNameAt(v - 1); if(field.length > 0) return field;}}
		else if(field < 10) v = d.getDate();
		else if(field < 16)
		{
			v = d.getHours();
			if(field > 13)//ampm
			{
				v = this.getAMPM(v < 12);
				if((field -= 13) == (i = v.length)) return v;
				if(i < field) v += " ";
				return v.substring(0, field);
			}
			if(field < 12){v %= 12; if(v == 0) v = 12;}
		}
		else if(field < 18) v = d.getMinutes();
		else if(field < 20) v = d.getSeconds();
		else if(field < 22) return this.getDowNameAt(d.getDay());
		else
		{
			v = d.getMilliseconds();
			var j = i = field - 21;
			while(j-- > 3) v *= 10;
			while(j++ < 2) v = Math.floor(v / 10);
		}
		v = "" + v;
		if(field < 20)
		{
			field = v.length;
			if(e){if(i == 0) i = 2; else e = false;}
			if(i > 0)
			{
				if(i < field) v = v.substring(0, i);
				else while(field++ < i) v = (e ? c : "0") + v;
			}
		}
		return v;
	}
	me.limits = function(d)
	{
		if(d == null) return d;
		var i;
		if(this.min != null) if(d.getTime() < (i = this.min.getTime())){d.setTime(i); return d;}
		if(this.max != null) if(d.getTime() > (i = this.max.getTime())){d.setTime(i); return d;}
		return null;
	}
	me.toDate = function(t, foc, limit, fire)
	{
		var fields = (foc && fire) ? this.fields0(t) : this.fields1(t, foc);
		//n: 3-ymd, 8-invalid, 16-limit, 32-lastGood
		var v, i0, n = 0, i = -1, j = -1, iLen = fields.length;
		var y = -1, mo = -1, day = -1, h = -1, m = -1, s = -1, ms = -1, pm = -1;
		var any = false, arg = new Object();
		while(++i < iLen)
		{
			j++;
			v = fields[i];
			i0 = foc ? this.field0IDs[i] : this.field1IDs[i];
			if(i0 < 4){if((arg.year = y = v) >= 0) n++; if(i0 < 3 && (v < 100 || v == 0)) y += (v < 37) ? 2000 : 1900;}
			else if(i0 < 8){arg.month = mo = v; if(v < 1 || v > 12) n |= 8; else n++;}
			else if(i0 < 10){arg.day = day = v; if(v < 1 || v > 31) n |= 8; else n++;}
			else if(i0 < 14)
			{
				if(v == 24) v = 0;
				if(i0 > 11) pm = -4; else{if(v == 12) v = 0; if(v > 12) n |= 8;}
				if((arg.hours = h = v) > 23) n |= 8;
			}
			else if(i0 < 16){j--; if(v > 0) pm++; continue;}
			else if(i0 < 18){if((arg.minutes = m = v) > 59) n |= 8;}
			else if(i0 < 20){if((arg.seconds = s = v) > 59) n |= 8;}
			else if(i0 < 22){j--;  continue;}
			else{while(i0++ < 24) v *= 10; while(i0-- > 25) v = Math.floor(v / 10); arg.milliseconds = ms = v;}
			if(v >= 0) any = true;
			else if(j < this.minF) n |= 8;
		}
		delete(fields);
		if(pm == 0 && h >= 0 && h < 12) arg.hours = (h += 12);
		var inv = fire ? (":" + y + "," + mo + "," + day + "," + h + "," + m + "," + s + "," + ms + ",") : "";
		var d = null;
		if((n & 3) == 3){d = new Date(y, mo - 1, day); if(y < 100) d.setFullYear(y);}
		else if(n < 8)
		{
			d = new Date();
			d.setTime(this.date.getTime());
			if(y >= 0) d.setFullYear(y); if(mo > 0) d.setMonth(mo - 1); if(day > 0) d.setDate(day);
		}
		if(day > 0 && d != null) if(day != d.getDate()) n |= 8;
		day = this.good;
		if(fire && d == null && !this.nullable)
		{
			d = day;
			if(d == null || d.getTime == null){d = new Date(); n |= 8;}
			else n |= 32;
		}
		if(d != null)
		{
			if(h >= 0) d.setHours(h); if(m >= 0) d.setMinutes(m);
			if(s >= 0) d.setSeconds(s); if(ms >= 0) d.setMilliseconds(ms);
			if(limit){if((d = this.limits(i = d)) != null) n = 16; else d = i;}
		}
		if(fire)
		{
			if(any && d == null && t.length > 0 && day != null && day.getTime != null){d = day; n = 32;}
			arg.date = d;
			if(n < 8 || (n == 8 && !any && this.nullable)) inv = "";
			else
			{
				inv += (arg.type = (n < 16) ? 2 : ((n == 16) ? 1 : 0));
				if(this.fireEvent(13, null, arg)) inv = "";
				d = arg.date;
			}
			if(d != null) inv = "" + d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + "-" + d.getHours() + "-" + d.getMinutes() + "-" + d.getSeconds() + "-" + d.getMilliseconds() + inv;
			this.elemViewState.value = inv;
			this.elemValue.value = (d == null) ? "" : this.toTxt(d, true, "");
			if(day != false) this.good = d;
		}
		delete(arg);
		return d;
	}
	me.enter0 = function()
	{
		var d = this.toDate(this.elem.value, true);
		return (d == null) ? "" : this.toTxt(d, true, "");
	}
	me.toTxt = function(d, foc, prompt, txt)
	{
		var t = "", mask = foc ? this.mask : this.mask1;
		if(d == null) return foc ? this.getTxt(5, prompt, mask) : this.nullText;
		var ids = foc ? this.field0IDs : this.field1IDs;
		var c, k, i = -1, f0 = 0;
		this.d_s = 6;//seconds
		while(++i < mask.length)
		{
			c = mask.charAt(i);
			if((k = mask.charCodeAt(i)) < 21)
			{
				t += this.fieldValue(ids[f0++], d, foc, c);
				if(foc) while(i + 1 < mask.length) if(mask.charCodeAt(i + 1) == k) i++; else break;
			}
			else t += c;
		}
		if(!foc) return t;
		if(txt) this.txt = t;
		return this.getTxt(5, prompt, t);
	}
	me.focusTxt = function(foc, e, t)
	{
		var d = null, prompt = "", mask = foc ? this.mask : this.mask1;
		if(t == null)
		{
			prompt = this.promptChar;
			//key-press
			if(e == null && foc) return this.getTxt(5, prompt);
			if(e != null && !foc)
			{
				d = this.toDate(this.elem.value, false, true, true);
				if(!(this.isNull = (d == null))) this.date = d;
			}
			else if(!this.isNull) d = this.date;
		}
		else d = this.toDate(t, foc, true);
		return this.toTxt(d, foc, prompt, e != null);
	}
	me.fields1 = function(t, foc)
	{
		var ids = foc ? this.field0IDs : this.field1IDs;
		var iLen = ids.length;
		var j, i = -1, v = -1, field = 0, fields = new Array(iLen);
		while(++i < iLen) fields[i] = -1;
		if(t == null) return fields;
		t = t.toUpperCase();
		i = -1;
		while(++i < t.length && field < iLen)
		{
			var k = t.charCodeAt(i) - 48, j = ids[field];
			if(j == 20 || j == 21) j = ids[++field];//dow
			if(j == 14 || j == 15)//ampm
			{
				if(k >= 0 && k <= 9){v = -1; field++; i--; continue;}
				if(this.getAMPM(false).charAt(0).toUpperCase() == t.charAt(i))
				{fields[field++] = 1; v = -1;}
			}
			else
			{
				if(k >= 0 && k <= 9){if(v < 0) v = k; else v = v * 10 + k;}
				else
				{
					if(v >= 0){fields[field++] = v; v = -1;}
					else if(j == 6 || j == 7) while(v-- > -3)//MMM
					{
						for(k = 0; k < 12; k++)
						{
							var m = this.getMonthNameAt(k).toUpperCase();
							if((j = m.length) < 1) continue;
							if(v == -3){if(j < 4) continue; m = m.substring(0, 3);}
							if((j = t.indexOf(m) - 1) > -2) if(j < 0 || t.charAt(j).toLowerCase() == t.charAt(j)) break;
						}
						if(k < 12){fields[field++] = k + 1; break;}
					}
				}
			}
		}
		if(field < iLen) fields[field] = v;
		return fields;
	}
	me.fields0 = function(t)
	{
		var fields = new Array();
		if(t == null) t = "";
		var x, k, i = -1, v = -1, field = -1, n = 22;
		while(++i < this.mask.length)
		{
			if((x = this.mask.charCodeAt(i)) > 21 && n > 21) continue;
			if(x > 21){if(field >= 0) fields[field] = v;}
			else
			{
				if(n > 21){v = -1; field++;}
				if(i >= t.length) continue;
				if(x > 18)
				{
					k = t.charCodeAt(i) - 48;
					if(k >= 0 && k <= 9)
					{
						if(v < 0) v = k;
						else v = v * 10 + k;
					}
				}
				else if(n != x) if(this.getAMPM(false).charAt(0).toUpperCase() == t.charAt(i).toUpperCase())
					v = 1;
			}
			n = x;
		}
		fields[field] = v;
		return fields;
	}
	me.curField = function(s, mask)
	{
		var x, n = 22, field = this.n0 = this.n1 = -1;
		for(var i = 0; i < mask.length; i++)
		{
			if(((x = mask.charCodeAt(i)) > 21) == (n > 21)) continue;
			if(x > 21){if(i >= s) break;}
			else{this.n0 = i; field++;}
			n = x;
		}
		if(this.n0 >= 0) this.n1 = i;
		if((field = this.field0IDs[field]) == null) return -1;
		if(field < 8) return (field < 4) ? 0 : 1;
		if(field < 20) return Math.floor((field - 4) / 2);
		return (field > 21) ? 8 : -1;
	}
	me.key = function(k, c, t, i, s, mask)
	{
		var n = 0, v = -1, field = this.curField(s, mask);
		if(s >= this.n1) if(t.charCodeAt(--s) > 21) return this.key(k, c, t, i, s + 2, mask);
		if(field < 0) return -1;
		if(field == 5)//ampm
		{
			if(s <= this.n0)
			{
				v = this.getAMPM(false);
				if(v.charAt(0).toUpperCase() != c.toUpperCase()) v = this.getAMPM(true);
				if(this.n1 == this.n0 + 1) v = v.charAt(0);
				else if((i = v.length) < 2) v += " "; else if(i > 2) v = v.substring(0, 2);
				this.txt = t.substring(0, this.n0) + v + t.substring(this.n1);
			}
			return this.n1;
		}
		if(k < 48 || k > 57)
		{
			if(k != 47 && k != 58 && (k < 44 || k > 57)) return -1;
			while(s < i)
			{
				if(mask.charCodeAt(s++) >= 21) break;
				t = t.substring(0, s - 1) + mask.charAt(s - 1) + t.substring(s);
			}
			this.txt = t;
			return s;
		}
		k -= 48;
		if(this.n0 == s)
		{
			v = t.charCodeAt(s + 1) - 48;
			//0-y, 1-M, 2-d, 3-h, 4-H, 5-AMPM, 6-m, 7-s, 8-ms
			switch(field)
			{
				case 4: k--; v -= 2;
				case 3: case 1: if(k > 1) n = 1; else if(k == 1 && v > 2) n = 2; break;
				case 2: if(k > 3) n = 1; else if(k == 3 && v > 1) n = 2; break;
				case 6: case 7: if(k > 6) n = 1; else if(k == 6 && v > 0) n = 2; break;
				default: break;
			}
		}
		if(this.n0 + 1 == s)
		{
			v = t.charCodeAt(s - 1) - 48;
			//0-y, 1-M, 2-d, 3-h, 4-H, 5-AMPM, 6-m, 7-s, 8-ms
			switch(field)
			{
				case 4: v--; k -= 2;
				case 3: case 1: if(v > 1 || (v == 1 && k > 2)) n = 3; break;
				case 2: if(v > 3 || (v == 3 && k > 1)) n = 3; break;
				case 6: case 7: if(v > 6 || (v == 6 && k > 0)) n = 3; break;
				default: break;
			}
		}
		if(n == 1){t = t.substring(0, s) + mask.charAt(s) + t.substring(s + 1); s++;}
		if(n == 2) t = t.substring(0, s + 1) + mask.charAt(s + 1) + t.substring(s + 2);
		if(n == 3)
		{
			while(++s < i) if(mask.charCodeAt(s) < 21) break;
			if(s >= i) return -1;
			return this.key(k + 48, c, t, i, s, mask);
		}
		this.txt = t.substring(0, s) + c + t.substring(s + 1);
		return ++s;
	}
	me.spin = function(v)
	{
		var x, i = this.spinF, d = new Date();
		d.setTime(this.date.getTime());
		if(i < 0 || i > 8)
		{
			if(this.focus == 2)
			{
				this.getSelectedText();
				i = this.curField(this.sel0, this.mask);
				if((d = this.toDate(this.elem.value, true, true, true)) == null)
					d = new Date();
				this.spinF = i;
			}
			else this.spinF = i = this.d_s;
		}
		//0-y, 1-M, 2-d, 3-h, 4-H, 5-AMPM, 6-m, 7-s, 8-ms
		if(i == 5) v = (v > 0) ? 12 : -12;
		x = this.spinOnlyOneField;
		switch(i)
		{
			case 0: d.setFullYear(v += d.getFullYear()); if(x && v != d.getFullYear()) i = -1; break;
			case 1: d.setMonth(v += d.getMonth()); if(x && v != d.getMonth()) i = -1; break;
			case 2: d.setDate(v += d.getDate()); if(x && v != d.getDate()) i = -1; break;
			case 3: case 4: case 5: i = d.getDate(); d.setHours(v += d.getHours()); if(x && i != d.getDate()) i = -1; break;
			case 6: d.setMinutes(v += d.getMinutes()); if(x && v != d.getMinutes()) i = -1; break;
			case 7: d.setSeconds(v += d.getSeconds()); if(x && v != d.getSeconds()) i = -1; break;
			case 8: for(i = this.n1 - this.n0; i++ < 3;) v *= 10;
				d.setMilliseconds(v += d.getMilliseconds()); if(x && v != d.getMilliseconds()) i = -1; break;
		}
		if(i < 0 || this.limits(d) != null){delete(d); return;}
		this.text = this.toTxt(d, this.focus == 2, this.promptChar, true);
		delete(this.date);
		this.date = d;
		this.isNull = false;
		this.repaint();
		if(this.focus == 2) this.select(this.sel0);
	}
	me.getDate = function(){return this.instant(true);}
	me.setDate = function(v){this.setValue(v);}
	me.getValueByMode = function(vt, limit)
	{
		var d = (this.focus < 2) ? (this.isNull ? null : this.date) : this.toDate(this.elem.value, true, limit);
		if(vt == 0) return d;
		return this.toTxt(d, vt == 1, this.emptyChar);
	}
	me.instant = function(date, limit)
	{
		return this.getValueByMode(date ? 0 : this.mode, limit == true);
	}
	me.date_7 = function(v)
	{
		if(v.length < 10) return null;
		var y, o = v.split("-");
		if(o.length < 7) return null;
		v = new Date(y = this.intI(o, 0), this.intI(o, 1), this.intI(o, 2), this.intI(o, 3), this.intI(o, 4), this.intI(o, 5), this.intI(o, 6));
		if(y < 100) v.setFullYear(y);
		delete(o);
		return v;
	}
	me.getValue = function(date){return this.instant(date, true);}
	me.setValue = function(v, o)
	{
		if(v != null && v.getTime == null)
		{
			if(this.focus < 0)
			{
				if(v.length < 8) v = "";
				o = v.split(",");
				if(o.length > 2) this.max = this.date_7(o[2]);
				if(o.length > 1) this.min = this.date_7(o[1]);
				v = this.date_7(o[0]);
				delete(o);
			}
			else v = this.toDate(v.toString(), this.mode < 2 && o != true);
		}
		o = v;
		if((v = this.limits(v)) == null) v = o;
		this.txt = this.mask;
		if(this.isNull = (v == null))
			v = new Date();
		else this.toTxt(v, true, "", true);
		delete this.date;
		this.date = v;
		if(this.good != false) this.good = v;
		this.text = this.focusTxt(this.focus > 1);
		this.repaint();
	}
	me.getRenderedValue = function(v)
	{
		if(v != null && v.getTime == null) v = this.toDate(v.toString(), false);
		return this.toTxt(v, false, "");
	}
	return me;
}