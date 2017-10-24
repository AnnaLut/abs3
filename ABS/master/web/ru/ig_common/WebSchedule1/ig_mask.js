/* 
Infragistics MaskEdit Script 
Version 1.1.20041.10
Copyright (c) 2003-2004 Infragistics, Inc. All Rights Reserved.
*/
var igmask_all = new Array();
// public: Obtains the Calendar object using its id
function igmask_getById(id)
{
	var o = igmask_all[id];
	if(o != null) return o;
	for(var i = igmask_all.length; i >= 0; i--) if((o = igmask_all[i]) != null)
		if(o.id == id) return o;
	return null;
}
// public: Date-editor
// Params:
// NOTE: any/all param(s) can be null
//   e - reference to <INPUT>
//   v - initial text
//   id - id that is used to get this object by igmask_getById
//   pe - parent html-element. It is used only when e-param is null
//   x - left of element
//   y - top of element
//   w - width of element
//   y - height of element
//   z - z-index of element
// Returns: new instance of date-edit
function igmask_edit(e, v, id, pe, x, y, w, h, z)
{return new igmask_new(e, v, id, pe, x, y, w, h, z);}
// public: Date-editor
// Params:
// NOTE: any/all param(s) can be null
//   e - reference to <INPUT>
//   di - container of format values. See ig_DateFormatInfo.
//   v - initial date value.
//   lf - True: long date-format, false: short date format
//   id - id that is used to get this object by igmask_getById
//   pe - parent html-element. It is used only when e-param is null
//   x - left of element
//   y - top of element
//   w - width of element
//   y - height of element
//   z - z-index of element
// Returns: new instance of date-edit
function igmask_date(e, di, v, lf, id, pe, x, y, w, h, z)
{
	var me = new igmask_new(e, null, id, pe, x, y, w, h, z);
	// 1 - d, 2 - m, 3 - y
	// 00007 - 1st
	// 00070 - 2nd
	// 00700 - 3rd
	// 01000 - dd
	// 02000 - mm
	// 04000 - yyyy
	me.order = 7370;//2 | (1 << 3) | (3 << 6) | (1 << 10) | (1 << 11) | (1 << 12)
	me.sepCh = "/";
	me.sep = 47;
	me.autoCentury = true;
	me.setLongFormat = function(v){this.longFormat = v;}
	me.getLongFormat = function(){return this.longFormat;}
	me.setDateInfo = function(v){this.info = v; this.setInputMask(null);}
	me.getDateInfo = function(){return this.info;}
	me.setInputMask = function(v)
	{
		var sep0 = null;
		if(v == null && this.info != null)
		{
			v = this.info.ShortDatePattern;
			if(ig_csom.isEmpty(sep0 = this.info.DateSeparator)) sep0 = null;
		}
		if(v == null || v.length < 3) v = "MM/dd/yyyy";
		var ii = v.length;
		var y = 0, m = 0, d = 0, sep = 0, i = -1, o = 0;
		while(++i < ii)
		{
			var ch = v.charAt(i);
			if(ch == 'd')
			{
				if(d++ > 0){o |= 1024; continue;}
				o |= 1 << (sep++ * 3);
			}
			else if(ch == 'm' || ch == 'M')
			{
				if(m++ > 0){o |= 2048; continue;}
				o |= 2 << (sep++ * 3);
			}
			else if(ch == 'y')
			{
				if(y++ > 0){if(y > 2) o |= 4096; continue;}
				o |= 3 << (sep++ * 3);
			}
			else if(sep == 1 && sep0 == null) sep0 = ch;
		}
		if(sep0 != null)
		{
			this.sepCh = sep0;
			this.sep = sep0.charCodeAt(0);
		}
		if(m == 0) o |= 1 << (sep++ * 3);
		if(d == 0) o |= 2 << (sep++ * 3);
		if(y == 0) o |= 3 << (sep++ * 3);
		this.order = o;
		this.mask = v;
	}
	me.setGood = function()
	{
		var d = this.date;
		if(d == null)
		{
			if(this.elem.value.length > 0) d = this.toDate();
			if(d == null && !this.allowNull) d = new Date();
			this.date = d;
		}
		this.good = d;
	}
	me.focusText = function()
	{
		var v, i = -1, t = "", d = this.date;
		if(d == null){if(this.allowNull) return t; this.date = d = new Date();}
		while(++i < 3)
		{
			if((v = (this.order >> i * 3) & 3) == 0) break;
			if(i > 0) t += this.sepCh;
			switch(v)
			{
				case 1: v = d.getDate();
					if(v < 10 && (this.order & 1024) != 0) t += 0;
					break;
				case 2: v = d.getMonth() + 1;
					if(v < 10 && (this.order & 2048) != 0) t += 0;
					break;
				case 3: v = d.getFullYear();
					if((this.order & 4096) == 0) v %= 100;
					break;
			}
			t += v;
		}
		return t;
	}
	me.setText = function(v){this.setDate(this.toDate(v));}
	me.toDate = function(t, inv)
	{
		if(t == null) t = this.elem.value;
		var ii = t.length;
		if(ii == 0 && this.allowNull) return null;
		var y = -1, m = -1, d = -1, sep = 0, i = -1, f = 0;
		while(++i <= ii)
		{
			var ch = (i < ii) ? t.charCodeAt(i) : this.sep;
			if(ch == this.sep)
			{
				if(i + 1 == ii) break;
				switch((this.order >> sep * 3) & 3)
				{
					case 1: d = f; break;
					case 2: m = f; break;
					case 3: y = f; break;
				}
				sep++;
			}
			ch -= 48;
			if(ch >= 0 && ch <= 9) f = f * 10 + ch;
			else f = 0;
		}
		f = null;
		i = 0;
		this.extra.year = y; this.extra.month = m; this.extra.day = d; this.extra.reason = (ii > 0) ? 2 : 1;
		if(sep != 3) i++;
		else
		{
			if(d < 1 || d > 31 || m < 1 || m > 12 || y < 0 || y > 9998) i++;
			else
			{
				if(m == 2 && d > 29) i = d = 29;
				if(this.autoCentury){if(y < 37) y += 2000; else if(y < 100) y += 1900;}
				f = new Date(y, m - 1, d);
				if(y < 100 && f.setFullYear != null) f.setFullYear(y);
				if(f.getDate() != d)
				{
					delete(f); f = new Date(i = y, m - 1, d - 1);
					if(y < 100 && f.setFullYear != null) f.setFullYear(y);
				}
				d = f.getTime();
				if((m = this.max) != null) if(d > m.getTime()){delete(f); f = m; if(i++ == 0) this.extra.reason = 0;}
				if((m = this.min) != null) if(d < m.getTime()){delete(f); f = m; if(i++ == 0) this.extra.reason = 0;}
			}
		}
		this.extra.date = f;
		if(inv && i > 0) if(this.fireEvt(11, null)) f = this.date;
		return f;
	}
	me.spin = function(v)
	{
		var d = this.toDate();
		if(d == null) d = new Date();
		this.setDate(new Date(d.getFullYear(), d.getMonth(), d.getDate() + v));
	}
	me.isValid = function(){return this.toDate() != null;}
	me.repaint = function(fire)
	{
		var t = null;
		if(!this.getReadOnly() && this.getEnabled())
		{
			if(this.foc) t = this.focusText();
			else if(this.changed)
			{
				var d = this.toDate(null, true);
				if(d != null || this.allowNull) this.date = d;
			}
		}
		this.text = (t == null) ? this.staticText() : t;
		this.repaint0(fire);
	}
	me.staticText = function()
	{
		if(this.date == null)
		{
			if(this.useLastGoodValue && this.good != null && this.text.length > 0) this.date = this.good;
			else{if(this.allowNull) return this.nullText; this.date = new Date();}
		}
		var t = this.info;
		if(t != null) t = this.longFormat ? t.LongDatePattern : t.ShortDatePattern;
		else if(this.longFormat && this.date.toLocaleDateString != null) return this.date.toLocaleDateString();
		if(t == null || t.length < 2) t = this.mask;
		var f = "yyyy", v = this.date.getFullYear();
		if(t.indexOf(f) < 0)
		{
			if(t.indexOf(f = "yy") < 0) v = -1;
			else v %= 100;
		}
		if(v != -1) t = t.replace(f, v);
		f = "MMM";
		v = this.date.getMonth() + 1;
		var mm = null, dd = null;
		if(t.indexOf(f) < 0)
		{
			if(t.indexOf(f = "MM") < 0){if(t.indexOf(f = "M") < 0) v = -1;}
			else if(v < 10) v = "0" + v;
			if(v != -1) t = t.replace(f, v);
		}
		else
		{
			if(t.indexOf("MMMM") >= 0) f = "MMMM";
			if(this.info != null) mm = (f.length == 4) ? this.info.MonthNames : this.info.AbbreviatedMonthNames;
			if(mm != null) mm = (mm.length >= v) ? mm[v - 1] : null;
			t = t.replace(f, (mm == null) ? ("" + v) : "[]");
		}
		f = "ddd";
		v = "";
		if(t.indexOf(f) >= 0)
		{
			if(t.indexOf("dddd") >= 0) f = "dddd";
			if(this.info != null) dd = (f.length == 4) ? this.info.DayNames : this.info.AbbreviatedDayNames;
			v += this.date.getDay();
			if(dd != null) dd = (dd.length >= v) ? dd[v] : null;
			t = t.replace(f, (dd == null) ? v : "()");
		}
		f = "dd";
		v = this.date.getDate();
		if(t.indexOf(f) < 0){if(t.indexOf(f = "d") < 0) v = -1;}
		else if(v < 10) v = "0" + v;
		if(v != -1) t = t.replace(f, v);
		if(mm != null) t = t.replace("[]", mm);
		if(dd != null) t = t.replace("()", dd);
		return t;
	}
	me.getDate = function(){return this.foc ? this.toDate() : this.date;}
	me.setDate = function(v)
	{
		if(v == null && !this.allowNull) if((v = this.date) == null) v = new Date();
		if(v != null)
		{
			var m, d = v.getTime();
			if((m = this.max) != null) if(d > m.getTime()) v = m;
			if((m = this.min) != null) if(d < m.getTime()) v = m;
		}
		else this.good = null;
		if(this.date == v) return;
		this.date = v;
		this.text = this.foc ? this.focusText() : this.staticText();
		this.repaint0(true);
	}
	// return char that can be added or -1
	me.canAdd = function(k, t)
	{
		var ii = t.length - 1;
		if(ii < 0) return (k == this.sep) ? -1 : k;
		if(t.charCodeAt(ii) == this.sep)
			return (k == this.sep) ? -1 : k;
		var f = 0, sep = 0, i = -1, n = 0;
		while(++i <= ii)
		{
			var ch = t.charCodeAt(i);
			if(ch == this.sep){if(sep++ > 1) return -1; n = f = 0; continue;}
			n++;
			f = f * 10 + ch - 48;
		}
		if(sep > 1 && k == this.sep) return -1;
		i = (this.order >> sep * 3) & 3;
		if(i == 1){if(n > 1 || f * 10 + k - 48 > 31) n = 4;}
		if(i == 2){if(n > 1 || f * 10 + k - 48 > 12) n = 4;}
		return (n < 4) ? k : ((sep > 1) ? -1 : this.sep);
	}
	me.afterKey = function(k, fix)
	{
		var t = this.elem.value;
		if(fix)
		{
			var sep = 0, i = -1, f = 0, i0 = 0, ii = t.length, tt = "";
			while(++i <= ii)
			{
				var ch = (i < ii) ? t.charCodeAt(i) : this.sep;
				if(ch == this.sep)
				{
					switch((this.order >> sep * 3) & 3)
					{
						case 1: if(f > 31){while(f > 31) f = Math.floor(f / 10);} else f = -1; break;
						case 2: if(f > 12){while(f > 12) f = Math.floor(f / 10);} else f = -1; break;
						case 3: if(f < 9999) f = -1; else while(f > 9999) f = Math.floor(f / 10); break;
					}
					if(f < 0) tt += t.substring(i0, i);
					else tt += f;
					if(i < ii) tt += this.sepCh;
					sep++;
					i0 = i + 1;
				}
				ch -= 48;
				if(ch >= 0 && ch <= 9) f = f * 10 + ch;
				else f = 0;
			}
			t = tt;
		}
		if(this.k0 > 0) if(this.canAdd(48, t) == this.sep) t += this.sepCh;
		this.elem.value = t;
	}
	me.filterKey = function(k, fix)
	{
		if(k != this.sep && (k < 48 || k > 57))
			// check for -_\/space.,:;"%
			if(this.tr != null && this.isSep(k)) k = this.sep;
			else return 0;
		if(fix && this.canAdd(k, this.elem.value) != k) k = 0;
		return k;
	}
	me.isSep = function(k){return k == this.sep || k == 45 || k == 92 || k == 95 || k == 47 || k == 32 || k == 46 || k == 44 || k == 58 || k == 59;}
	me.paste = function(old)
	{
		var ch, sep = true, v = "", f = 0;
		for(var i = 0; i < old.length; i++)
		{
			ch = old.charCodeAt(i);
			if(ch >= 48 && ch <= 57) sep = false;
			else{if(!this.isSep(ch)) continue; if(f > 1) break; if(sep) continue; sep = true; f++;}
			v += sep ? this.sepCh : old.charAt(i);
		}
		this.text = "";
		this.setText(v);
	}
	me.setLongFormat(lf);
	me.setDateInfo(di);
	me.setDate(v);
	return me;
}
function igmask_new(e, v, id, pe, x, y, w, h, z)
{
	this.foc = false;
	this.changed = false;
	this.extra = new Object();
	//
	this.repaint0 = function(fire)
	{
		if(this.elem.value == this.text) return;
		this.elem.value = this.text;
		if(!fire) return;
		this.changed = true;
		this.fireEvt(10, null);
	}
	this.repaint = function(fire){this.repaint0(fire);}
	if(e == null){e = document.createElement("INPUT"); if(pe == null) pe = document.forms[0];}
	else{pe = null; id = e.id;}
	var iAll = igmask_all.length;
	if(ig_csom.isEmpty(id)) id = "_mask_" + iAll;
	while(igmask_getById(id) != null) id += "x";
	//
	ig_csom.addEventListener(e, "keydown", igmask_event, false);
	ig_csom.addEventListener(e, "keypress", igmask_event, false);
	ig_csom.addEventListener(e, "keyup", igmask_event, false);
	ig_csom.addEventListener(e, "focus", igmask_event, false);
	ig_csom.addEventListener(e, "blur", igmask_event, false);
	ig_csom.addEventListener(e, "mousedown", igmask_event, false);
	ig_csom.addEventListener(e, "mouseup", igmask_event, false);
	ig_csom.addEventListener(e, "mousemove", igmask_event, false);
	ig_csom.addEventListener(e, "mouseover", igmask_event, false);
	ig_csom.addEventListener(e, "mouseout", igmask_event, false);
	this.id = id;
	e.setAttribute("maskID", id);
	if(pe != null) pe.appendChild(e);
	this.elem = e;
	if(e.createTextRange != null) this.tr = e.createTextRange();
	this.getElement = function(){return this.elem;}
	//
	this.setBounds = function(x, y, w, h, z)
	{
		var s = this.elem.style;
		if(x != null)
		{
			s.position = "absolute";
			s.left = x;
			s.top = y;
		}
		if(w != null) s.width = w;
		if(h != null) s.height = h;
		if(z != null) s.zIndex = z;
	}
	this.setBounds(x, y, w, h, z);
	//
	this.k0 = -2;
	this.k1 = 0;
	this.fixKey = 0;
	this.allowNull = true;
	this.useLastGoodValue = true;
	this.getAllowNull = function(){return this.allowNull;}
	this.setAllowNull = function(v){this.allowNull = v; repaint(true);}
	this.enabled = true;
	this.getEnabled = function(){return this.enabled;}
	this.setEnabled = function(v){this.enabled = v;}
	this.getVisible = function(){return this.elem.style.display != "none";}
	this.setVisible = function(v){this.elem.style.display = v ? "" : "none";}
	this.getReadOnly = function(){return this.elem.readOnly;}
	this.setReadOnly = function(v){this.elem.readOnly = v;}
	this.getInputMask = function(){return this.mask;}
	this.setInputMask = function(v){this.mask = v;}
	this.getText = function(){return this.text;}
	this.setText = function(v){this.text = v; this.repaint(true);}
	this.getMaxValue = function(){return this.max;}
	this.setMaxValue = function(v){this.max = v;}
	this.getMinValue = function(){return this.min;}
	this.setMinValue = function(v){this.min = v;}
	this.nullText = "null";
	this.getNullText = function(){return this.nullText;}
	this.setNullText = function(v){this.nullText = v;}
	this.isValid = function(){return true;}
	this.delta = 1;
	this.setSpinDelta = function(v){this.delta = v;}
	this.getSpinDelta = function(){return this.delta;}
	this.spin = function(v){}
//	this.prompt = "_";
//	this.getPromptChar = function(){return this.prompt;}
//	this.setPromptChar = function(v){this.prompt = v;}
	//
	this.doKey = function(e, a)
	{
		if(e == null || this.getReadOnly() || !this.getEnabled()) return;
		if(a == 1 && (e.ctrlKey || e.altKey)) return;
		var k = e.keyCode;
		if(k == 0 || k == null) if((k = e.which) == null) return;
		if(k < 32 && k != 8) return;
		if(a == 1) this.k1 = k;
		var t0 = this.text, t1 = this.elem.value;
		var i = t1.length;
		if(a == 2)
		{
			this.k1 = 0;
			if(this.k0 < 32) return;
			if(t0 != t1)
			{
				this.changed = true;
				if(this.fixKey > 0 || i == 1) this.afterKey(k, this.fixKey++ == 1);
				else if(this.fixKey == 0) if(i-- == 0){this.fixKey = 2; return;}
			}
			this.k0 = -2;
			return;
		}
		switch(k)
		{
			//end//right//home//left
			case 35: case 39: case 36: case 37: if(this.k1 == k) return;
				break;
			//back//del
			case 8: case 46: if(this.k1 == k) return;
				break;
			//esc//enter
			case 27: case 13: if(this.k1 == k) return;
				break;
			//up//down
			case 38: case 40:
				if(a == 1 && this.delta != 0 && !e.shiftKey) this.spin((k == 38) ? this.delta : -this.delta);
				if(this.k1 == k) return;
				break;
		}
		if(a == 1)
		{
			t0 = this.getSelectedText();
			if(t0.length > 0 || this.sel0 < i) this.fixKey = 0;
			else if(this.fixKey == 0 && this.sel0 == i) this.fixKey = 1;
			return;
		}
		// fast typing!
		if(this.k0 > 0)
		{
			if(t0 != t1) this.changed = true;
			if(this.fixKey > 0)
				this.afterKey(this.k0, this.fixKey > 0);
		}
		var newK = this.filterKey(k, this.fixKey > 0);
		if(newK != k && this.tr == null) newK = 0;
		if(newK == 0) ig_cancelEvent(e);
		else if(newK != k && this.tr != null) e.keyCode = newK;
		this.k0 = newK;
	}
	this.afterKey = function(k, fix){}
	this.filterKey = function(k, fix){return k;}
	this.stoi = function(s)
	{
		switch(s.toLowerCase())
		{
			case "keypress": return 0;
			case "keydown": return 1;
			case "keyup": return 2;
			case "mousedown": return 3;
			case "mouseup": return 4;
			case "mousemove": return 5;
			case "mouseover": return 6;
			case "mouseout": return 7;
			case "focus": return 8;
			case "blur": return 9;
			case "invalidvalue": return 11;
		}
		return 10;//valuechanged
	}
	this.paste = function(v)
	{
		this.text = "";
		this.setText(v);
	}
	this.setGood = function(){}
	this.doEvt = function(e)
	{
		var v, a = this.stoi(e.type);
		this.fireEvt(a, e);
		if(a < 3) this.doKey(e, a);
		else if(a >= 8)
		{
			if((a == 8) == this.foc) return;
			this.foc = (a == 8);
			if(a == 8)
			{
				if(this.useLastGoodValue) this.setGood();
				if((v = this.elem.value) != this.text){this.paste(v); return;}
			}
			this.repaint();
			if(this.foc){this.changed = false; this.select();}
			return;
		}
		if((v = this.elem.value) != this.text)
		{
			if(a > 3 && this.k1 == 0){this.paste(v); return;}
			this.text = v;
			this.changed = true;
			this.fireEvt(10, e);
		}
	}
	this.events = new Array(11);
	this.evtH = function(n, f, add)
	{
		n = this.stoi(n);
		var e = this.events[n];
		if(e == null){if(add) e = this.events[n] = new Array(); else return;}
		n = e.length;
		while(n-- > 0) if(e[n] == f){if(!add) e[n] = null; return;}
		if(add) e[e.length] = f;
	}
	this.removeEventHandler = function(name, fref){this.evtH(name, fref, false);}
	this.addEventHandler = function(name, fref){this.evtH(name, fref, true);}
	this.fireEvt = function(id, e)
	{
		var evts = this.events[id];
		var i = (evts == null) ? 0 : evts.length;
		if(i == 0) return false;
		var evt = this.Event;
		if(evt == null) evt = this.Event = new ig_EventObject();
		var cancel = false;
		while(i-- > 0)
		{
			if(evts[i] == null) continue;
			evt.reset();
			evt.event = e;
			evts[i](this, this.elem.value, evt, this.extra);
			if(evt.cancel) cancel = true;
		}
		return cancel;
	}
	this.select = function(s0, s1)
	{
		var i = this.elem.value.length;
		if(s1 == null) if((s1 = s0) == null){s0 = 0; s1 = i;}
		if(s1 >= i) s1 = i;
		else if(s1 < s0) s1 = s0;
		if(s0 > s1) s0 = s1;
		this.sel0 = s0; this.sel1 = s1;
		if(this.elem.selectionStart != null)
		{
			this.elem.selectionStart = s0;
			this.elem.selectionEnd = s1;
		}
		if(this.tr == null) return;
		s1 -= s0;
		this.tr.move("textedit", -1);
		this.tr.move("character", s0);
		if(s1 > 0) this.tr.moveEnd("character", s1);
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
		if(this.tr == null) return r;
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
	if(v == null) this.text = "";
	else this.setText(v);
	igmask_all[iAll] = igmask_all[id] = this;
}
function igmask_event(e)
{
	if(e == null) if((e = window.event) == null) return;
	var c = null, id = null, i = 0, o = e.srcElement;
	if(o == null) if((o = e.target) == null) o = this;
	while(true)
	{
		if(o == null || i++ > 2) return;
		try{if(o.getAttribute != null) id = o.getAttribute("maskID");}catch(ex){}
		if(!ig_csom.isEmpty(id)){c = igmask_getById(id); break;}
		if((c = o.parentNode) != null) o = c;
		else o = o.parentElement;
	}
	if(c != null) c.doEvt(e);
}
