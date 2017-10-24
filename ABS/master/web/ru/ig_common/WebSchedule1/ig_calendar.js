/* 
Infragistics Calendar Script 
Version 1.1.20041.10
Copyright (c) 2003-2004 Infragistics, Inc. All Rights Reserved.
Note:
	Only functions marked by "public:" are documented and supported.
*/
var igcal_all = new Array();
// public: Obtains the Calendar object using its id
function igcal_getCalendarById(id, e)
{
	var o, i1 = -2;
	if(e != null)
	{
		while(true)
		{
			if(e == null) return null;
			try{if(e.getAttribute != null) id = e.getAttribute("calID");}catch(ex){}
			if(!ig_csom.isEmpty(id)) break;
			if(++i1 > 1) return null;
			if((o = e.parentNode) != null) e = o;
			else e = e.parentElement;
		}
		var ids = id.split(",");
		if(ig_csom.isEmpty(ids)) return null;
		id = ids[0];
		i1 = (ids.length > 1) ? parseInt(ids[1]) : -1;
		delete(ids);
	}
	var i = igcal_all.length;
	if((o = igcal_all[id]) == null) while(i-- > 0) if((o = igcal_all[i]) != null) if(o.ID == id || o.uniqueId == id) break;
	if(o == null || i == -1) return null;
	if(i1 > -2) o.elemID = i1;
	return o;
}
//
// private: all below
function igcal_init(id, dates, prop, str) 
{
	var elem = ig_csom.getElementById("igcal" + id);
	if(elem == null) return;
	var o = new igcal_new(elem, id, dates, prop, str);
	// hashtable and [i]
	igcal_all[igcal_all.length] = igcal_all[id] = o;
	id = o.Events.initializeCalendar;
	if(!ig_csom.isEmpty(id)) o.fireEvt(o, id, null, false);
}
//
function igcal_new(elem, id, dates, prop, str)
{
	if(ig_csom.isEmpty(prop)) return;
	this.valI = function(o, i){o = (o == null || o.length <= i) ? null : o[i]; return (o == null) ? "" : o;}
	this.intI = function(o, i){return ig_csom.isEmpty(o = this.valI(o, i)) ? -1 : parseInt(o);}
	// init flag
	this.elemID = -10;
	this.ID = id;
	this.element = elem;
	this.elemViewState = ig_csom.getElementById(id);
	elem.setAttribute("calID", id);
	this.viewState = ig_ClientState.createRootNode();
	var sep = ",";
	var i, prop0 = dates.split(sep);
	this.nd = function(y, m, d)
	{
		d = new Date(y, --m, d);
		if(y < 100 && d.setFullYear != null) d.setFullYear(y);
		return d;
	}
	//
	this.df = function(d, i)
	{
		if(i == 0) return d.getFullYear();
		if(i == 1) return d.getMonth() + 1;
		return (i == 2) ? d.getDate() : d.getDay();
	}
	this.Days = new Array(42);
	var o = new Date();
	this.today = new Array(3);
	this.today[0] = this.df(o, 0);
	this.today[1] = this.df(o, 1);
	this.today[2] = this.df(o, 2);
	delete(o);
	//
	this.selDate = new Array(4);
	this.selDate[0] = this.intI(prop0, 0);
	this.selDate[1] = this.intI(prop0, 1);
	this.selDate[2] = this.intI(prop0, 2);
	this.selDate[3] = -1;
	var year = this.intI(prop0, 3), month = this.intI(prop0, 4);
	this.MinDate = this.nd(this.intI(prop0, 5), this.intI(prop0, 6), this.intI(prop0, 7));
	this.MaxDate = this.nd(this.intI(prop0, 8), this.intI(prop0, 9), this.intI(prop0, 10));
	//
	this.setText = function(e, t)
	{
		var ii = (e.childNodes == null) ? 0 : e.childNodes.length;
		for(var i = -1; i < ii; i++)
		{
			var ei = (i < 0) ? e : e.childNodes[i];
			if(ei.nodeName == "#text")
			{
				if(t != null){ei.nodeValue = t; t = null;}
				else ei.nodeValue = "";
			}
		}
		if(t == null) return;
		if(e.text != null){e.text = t; return;}
		if(e.innerText != null){e.innerText = t; return;}
		if(e.innerHTML != null) e.innerHTML = t;
	}
	this.getText = function(e)
	{
		var ii = (e.childNodes == null) ? 0 : e.childNodes.length;
		var v = null;
		for(var i = -1; i < ii; i++)
		{
			var ei = (i < 0) ? e : e.childNodes[i];
			if(ei.nodeName == "#text")
				v = (v == null) ? ei.nodeValue : v + " " + ei.nodeValue1;
		}
		if(v != null) return v;
		if((v = e.text) != null) return v;
		if((v = e.innerText) != null) return v;
		if((v = e.innerHTML) != null) return v;
		return "";
	}
	//
	this.doPost = function(){if(this.post){this.post = false; try{__doPostBack(this.uniqueId, this.elemViewState.value);}catch(ex){}}}
	this.buf = new Object();
	this.fireEvt = function(o, evtName, e, del, sel)
	{
		var evt = this.Event;
		if(evt == null) evt = this.Event = new ig_EventObject();
		evt.reset();
		evt.needPostBack = this.post;
		if(e == null) o = evt = null;
		else if(sel == null) evt.event = e;
		else
		{
			this.buf.year = o.year;
			this.buf.month = o.month;
			this.buf.day = o.day;
			this.buf.index = o.index;
			this.buf.dow = (this.dow + (o.index % 7)) % 7;
			this.buf.element = o.element;
			this.buf.text = "" + o.day;
			this.buf.css = e;
			o = this.buf;
			o.selected = sel;
		}
		ig_fireEvent(this, evtName, o, evt);
		if(del && o != null) delete(o);
		if(evt == null) return false;
		this.post = (evt.needPostBack && !evt.cancelPostBack);
		return evt.cancel;
	}
	//
	this.isSelected = function(year, month, day, i)
	{
		if(this.selDate[0] == year && this.selDate[1] == month && this.selDate[2] == day)
		{if(i >= 0) this.selDate[3] = i; return true;}
		return false;
	}
	this.isSel = function(i){return this.selDate[3] == i;}
	// already checked for old sel
	this.select = function(year, month, day, date, toggle, i, e, add)
	{
		if(toggle == null)
		{
			this.selDate[0] = year;
			this.selDate[1] = month;
			this.selDate[2] = day;
			this.selDate[3] = -1;
			return;
		}
		var id = this.Events.valueChanging;
		var del = (!toggle && date == null);
		if(!ig_csom.isEmpty(id))
		{
			if(this.fireEvt(del ? this.nd(year, month, day) : date, id, e, del))
				return;
			this.doPost();
		}
		// unselect
		id = this.Events.renderDay;
		var o, text = null, sel = this.selDate[3];
		if(sel >= 0)
		{
			o = this.Days[sel];
			sel = this.ID + o.css;
			if(id.length > 0)
			{
				if(this.fireEvt(o, id, sel, false, false)) o = null;
				else
				{
					text = this.buf.text;
					sel = this.buf.css;
				}
			}
			if(o != null)
			{
				o.element.className = sel;
				if(text != null) this.setText(o.element, text);
			}
		}
		if(toggle){month = year = day = -1;}
		this.selDate[0] = year;
		this.selDate[1] = month;
		this.selDate[2] = day;
		this.selDate[3] = -1;
		// select
		if(!toggle)
		{
			// flag to calculate i
			if(i < -1)
			{
				if(year != this.Days[15].year || month != this.Days[15].month)
				{if(i < -2) this.repaint(year, month, false, e);}
				else for(i = 41; i >= 0; i--)
					if(year == this.Days[i].year && month == this.Days[i].month && day == this.Days[i].day)
						break;
			}
			if(i > -2) if((this.selDate[3] = i) >= 0)
			{
				o = this.Days[i];
				sel = this.ID + this.getCss(1);
				text = null;
				if(id.length > 0)
				{
					if(this.fireEvt(o, id, sel, false, true)) o = null;
					else
					{
						text = this.buf.text;
						sel = this.buf.css;
					}
				}
				if(o != null)
				{
					o.element.className = sel;
					if(text != null) this.setText(o.element, text);
				}
			}
		}
		this.update();
		if(this.onValueChanged != null) this.onValueChanged(this, del ? this.nd(year, month, day) : date);
		this.post = this.postSel;
		if(!ig_csom.isEmpty(id = this.Events.valueChanged))
			this.fireEvt(del ? this.nd(year, month, day) : date, id, e, del);
		this.doPost();
//this.setFirstDayOfWeek(3);
//this.update("BackColor", "Red", "DayStyle");
	}
	//
	delete(prop0);
	prop0 = prop.split(sep);
	this.uniqueId = prop0[0];
	this.enabled = !ig_csom.isEmpty(prop0[1]);
	this.allowNull = !ig_csom.isEmpty(prop0[2]);
	this.readOnly = !ig_csom.isEmpty(prop0[3]);
	this.titleFormat = !ig_csom.isEmpty(prop0[4]);
	this.dow = this.intI(prop0, 5);
	this.nextFormat = this.intI(prop0, 6);
	this.fixVis = !ig_csom.isEmpty(prop0[7]);
	this.postSel = !ig_csom.isEmpty(prop0[8]);
	this.postVis = !ig_csom.isEmpty(prop0[9]);
	this.DayNameFormat = this.intI(prop0, 10);
	this.VisibleDayNames = this.intI(prop0, 11);
	for(i = 12; i < 18; i++) if(!ig_csom.isEmpty(o = prop0[i]))
	{if(this.css == null) this.css = new Array(6); this.css[i - 12] = " " + o;}
	this.getCss = function(i){return "" + i + this.valI(this.css, i);}
	//
	delete(prop0);
	prop0 = ig_csom.isEmpty(str) ? null : str.split(sep);
	this.info = new Object();
	var aa = new Array(12);
	for(i = 0; i < 12; i++) aa[i] = this.valI(prop0, i);
	this.info.MonthNames = aa;
	o = new Object();
	o.initializeCalendar = this.valI(prop0, i);
	o.dateClicked = this.valI(prop0, ++i);
	o.monthChanged = this.valI(prop0, ++i);
	o.monthChanging = this.valI(prop0, ++i);
	o.valueChanged = this.valI(prop0, ++i);
	o.valueChanging = this.valI(prop0, ++i);
	o.renderDay = this.valI(prop0, ++i);
	this.Events = o;
	if(this.nextFormat > 0)
	{
		aa = new Array(12);
		for(o = 0; o < 12; o++)
		{
			if(this.nextFormat != 1) aa[o] = this.info.MonthNames[o];
			else if(ig_csom.isEmpty(aa[o] = this.valI(prop0, ++i)))
				aa[o] = this.info.MonthNames[o].substring(0, 3);
		}
		this.info.AbbreviatedMonthNames = aa;
	}
	if(prop0 != null) delete(prop0);
	//
	this.addLsnr = function(e, s)
	{
		if(e == null) return;
		ig_csom.addEventListener(e, "select", ig_cancelEvent, false);
		ig_csom.addEventListener(e, "selectstart", ig_cancelEvent, false);
		if(s) return;
		ig_csom.addEventListener(e, "mousedown", ig_cancelEvent, false);
		ig_csom.addEventListener(e, "click", igcal_event, false);
	}
	this.addLsnr(elem, true);
	//
	// 0=500 - prevMonth
	// 1=502 - nextMonth
	// 2=504 - MonthDrop
	// 3=506 - YearDrop
	// 4=508 - Footer
	// 5=510 - Title
	// 6=512 - Calendar
	// 7=514 - Dow
	this.elems = new Array(8);
	for(i = 0; i < 8; i++)
	{
		if((elem = ig_csom.getElementById(id + "_" + (500 + i * 2))) != null)
		{
			this.elems[i] = elem;
			elem.setAttribute("calID", id + "," + (500 + i * 2));
			if(i > 4) continue;
			if(i == 2 || i == 3) ig_csom.addEventListener(elem, "change", igcal_event, false);
			else this.addLsnr(elem, false);
		}
	}
	this.getCellSpacing = function(){return this.elems[6].cellSpacing;}
	this.setCellSpacing = function(v){this.update("CellSpacing", this.elems[6].cellSpacing = v);}
	this.getCellPadding = function(){return this.elems[6].cellPadding;}
	this.setCellPadding = function(v){this.update("CellPadding", this.elems[6].cellPadding = v);}
	this.getGridLineColor = function(){return this.elems[6].borderColor;}
	this.setGridLineColor = function(v){this.update("GridLineColor", this.elems[6].borderColor = v);}
	this.getShowGridLines = function()
	{
		var s = this.elems[6].rules;
		if(s == "cols") return 1;
		else if(s == "rows") return 2;
		else if(s == "all") return 3;
		return 0;
	}
	this.setShowGridLines = function(v)
	{
		var s = "none";
		if(v == 1) s = "cols";
		else if(v == 2) s = "rows";
		else if(v == 3) s = "all";
		else v = 0;
		this.elems[6].border = (v == 0) ? 0 : 1;
		this.elems[6].rules = s;
		this.update("ShowGridLines", v);
	}
	this.ShowNextPrevMonth = this.elems[0] != null;
	this.ShowTitle = this.elems[5] != null;
	//
	this.minMax = function(y, m, d)
	{
		m = this.nd(y, m, d);
		d = m.getTime();
		delete(m);
		if(d > this.MaxDate.getTime()) return this.MaxDate;
		if(d < this.MinDate.getTime()) return this.MinDate;
		return null;
	}
	this.repaint = function(year, month, check, e)
	{
		var id = (year == null);
		if(id || year < 1) year = this.Days[15].year;
		if(month == null) month = this.Days[15].month;
		if(check == null) check = false;
		if(month < 1){month = 12; year--;}
		if(month > 12){month -= 12; year++;}
		var i, o, d = this.minMax(year, month, 1);
		if(d != null){year = this.df(d, 0); month = this.df(d, 1);}
		//
		if(e != null && !ig_csom.isEmpty(o = this.Events.monthChanging))
		{
			if(this.fireEvt((d == null) ? this.nd(year, month, 1) : d, o, e, true))
			{
				if((o = this.elems[2]) != null) o.selectedIndex = this.Days[15].month - 1;
				if((o = this.elems[3]) != null) o.selectedIndex = this.Days[15].year - this.year0;
				return;
			}
			this.doPost();
		}
		//
		if((o = this.elems[2]) != null) o.selectedIndex = month - 1;
		if((o = this.elems[3]) != null) if(this.year0 == null) if((d = o.options) != null)
			if((d = d[0]) != null) try{this.year0 = parseInt(this.getText(d));}catch(ex){}
		if(this.year0 != null)
		{
			i = o.options.length;
			var y = year - (i >> 1);
			d = this.df(this.MinDate, 0);
			if(y < d) y = d;
			else if(y + i > (d = this.df(this.MaxDate, 0))) y = d - i + 1;
			if(this.year0 != y)
			{
				while(i-- > 0)
				{
					d = (y + i > 999) ? "" : ((y + i > 99) ? "0" : "00");
					this.setText(o.options[i], d + (y + i));
				}
				o.selectedIndex = -1;
			}
			o.selectedIndex = year - (this.year0 = y);
		}
		//
		if((o = this.Days[15]) != null)
		{
			if(o.year == year && o.month == month){if(check) return;}
			else check = true;
		}
		else check = false;
		//
		var numDays = (month == 2) ? 28 : 30;
		d = this.nd(year, month, numDays + 1);
		if(this.df(d, 1) == month) numDays++;
		delete(d);
		d = this.nd(year, month, 1);
		i = this.df(d, 3) - this.dow;
		delete(d);
		var day1 = (i < 0) ? i + 7 : i;
		// after init
		if(this.elemID > -10)
		{
			if(this.nextFormat > 0)
			{
				o = this.info.AbbreviatedMonthNames;
				this.setText(this.elems[1], o[(month + 12) % 12]);
				this.setText(this.elems[0], o[(month + 10) % 12]);
			}
			if(this.elems[5] != null && (id || this.Days[15].month != month || this.Days[15].year != year))
			{
				o = "";
				if(this.titleFormat)
				{
					if(year < 1000){o = "0"; if(year < 100) o = "00";}
					o = " " + o + year;
				}
				this.setText(this.elems[5], this.info.MonthNames[month - 1] + o);
			}
		}
		id = this.Events.renderDay;
		d = this.nd(year, month, 0);
		var day0 = this.df(d, 2) - day1 + 1;
		delete(d);
		this.selDate[3] = -1;
		var sun = (7 - this.dow) % 7;
		for(i = 0; i < 42; i++)
		{
			// init
			if(this.elemID == -10)
			{
				var elem = null;
				if((elem = ig_csom.getElementById(this.ID + "_d" + i)) == null) continue;
				elem.setAttribute("calID", this.ID + "," + i);
				this.addLsnr(elem, false);
				o = this.Days[i] = new Object();
				o.element = elem;
				o.calendar = this;
				o.index = i;
			}
			else o = this.Days[i];
			o.year = year;
			o.month = month;
			if(i < day1)
			{
				o.day = day0 + i;
				if(--o.month < 1){o.month = 12; o.year--;}
				o.css = this.getCss((i % 7 == sun || i % 7 == (sun + 6) % 7) ? 3 : 2);
			}
			else if(i < day1 + numDays)
			{
				o.day = i - day1 + 1;
				o.css = this.getCss((i % 7 == sun || i % 7 == (sun + 6) % 7) ? 4 : 0);
			}
			else
			{
				o.day = i + 1 - (day1 + numDays);
				if(++o.month > 12){o.month = 1; o.year++;}
				o.css = this.getCss((i % 7 == sun || i % 7 == (sun + 6) % 7) ? 3 : 2);
			}
			if(o.day == this.today[2] && o.month == this.today[1] && o.year == this.today[0])
				o.css = this.getCss(5);
			var text = o.day, sel = this.isSelected(o.year, o.month, o.day, i);
			d = this.ID + (sel ? this.getCss(1) : o.css);
			if(id.length > 0)
			{
				if(this.fireEvt(o, id, d, false, sel)) continue;
				o = this.buf;
				d = this.buf.css;
				text = this.buf.text;
			}
			// init
			else if(this.elemID == -10) continue;
			o.element.className = d;
			this.setText(o.element, text);
		}
		if(this.elemID != -10) this.update();
		if(!check || e == null) return;
		this.post = this.postVis;
		if(!ig_csom.isEmpty(o = this.Events.monthChanged))
			this.fireEvt(this.nd(year, month, 1), o, e, true);
		this.doPost();
	}
	this.repaint(year, month);
	this.click = function(e)
	{
		if(this.element.disabled) return;
		var o = this.Days[15];
		var y = o.year, m = o.month;
		var id = this.elemID;
		// drop
		if(id == 504 || id == 506)
		{
			if(id == 504) m = this.elems[2].selectedIndex + 1;
			else
			{
				if((y = this.year0) == null) return;
				y += this.elems[3].selectedIndex;
			}
			this.repaint(y, m, true, e);
			return;
		}
		// cal
		if(id < 0) return;
		// prev/next
		if(id >= 500 && id <= 502) this.repaint(y, m + id - 501, true, e);
		if(this.readOnly) return;
		// -3 - request to scroll vis month
		var d, i = -3, toggle = e.ctrlKey;
		// today
		if(id == 508){y = this.today[0]; m = this.today[1]; d = this.today[2]; toggle = false;}
		else
		{
			if(id >= 42) return;
			// days
			o = this.Days[id];
			id = this.Events.dateClicked;
			y = o.year; m = o.month; d = o.day;
			if(!ig_csom.isEmpty(id)) this.fireEvt(this.nd(y, m, d), id, e, true);
			this.doPost();
			if(this.isSel(o.index)){if(!toggle) return;}
			else toggle = false;
			if(!this.fixVis || this.Days[15].month == m) i = o.index;
		}
		if(this.minMax(y, m, d) != null) return;
		this.select(y, m, d, null, this.allowNull && toggle, i, e, false);
	}
	// end init
	this.elemID = -1;
	// public: all methods below
	this.getVisibleMonth = function(){return this.nd(this.Days[15].year, this.Days[15].month, 1);}
	this.setVisibleMonth = function(d){if(d != null) this.repaint(this.df(d, 0), this.df(d, 1), true);}
	this.getSelectedDate = function()
	{return (this.selDate[2] < 0) ? null : this.nd(this.selDate[0], this.selDate[1], this.selDate[2]);}
	this.setSelectedDate = function(date)
	{
		var y = -1, m = -1, d = -1;
		if(date != null){y = this.df(date, 0); m = this.df(date, 1); d = this.df(date, 2);}
		else if(!this.allowNull){y = this.today[0]; m = this.today[1]; d = this.today[2];}
		if(this.isSelected(y, m, d, -1)) return;
		if(d > 0) date = this.minMax(y, m, d);
		if(date != null)
		{
			if(date != null){y = this.df(date, 0); m = this.df(date, 1); d = this.df(date, 2);}
			if(this.isSelected(y, m, d, -1)) return;
		}
		this.select(y, m, d, date, d < 1, -3, null, false);
//		this.select(y, m, d, date, false, show ? -3 : -2, null, false);
	}
	this.getFirstDayOfWeek = function(){return this.dow;}
	this.setFirstDayOfWeek = function(v)
	{
		if(v == null) return;
		v = (v + 7) % 7;
		if(v == this.dow || v < 0) return;
		var i = -1, x = (v + 7 - this.dow) % 7, old = new Array(7);
		while(++i < 7) old[i] = this.getText(this.elems[7].cells[i]);
		while(--i >= 0) this.setText(this.elems[7].cells[i], old[(i + x) % 7]);
		delete(old);
		this.dow = v;
		this.repaint();
		this.update("FirstDayOfWeek", v);
	}
	this.update = function(p, v, p0)
	{
		if(this.elemViewState == null) return "";
		var n0 = ig_ClientState.findNode(this.viewState, "CALENDAR");
		if(n0 == null) n0 = ig_ClientState.addNode(this.viewState, "CALENDAR");
		var n = n0;
		if(p == null)
		{
			p = "PostData";
			v = this.Days[15].year + "x" + this.Days[15].month + "x" + this.selDate[0] + "x" + this.selDate[1] + "x" + this.selDate[2];
		}
		else
		{
			if((n = ig_ClientState.findNode(n0, "LAYOUT")) == null)
				n = ig_ClientState.addNode(n0, "LAYOUT");
			if(p0 != null) if((n = ig_ClientState.findNode(n0 = n, p0)) == null)
				n = ig_ClientState.addNode(n0, p0);
		}
		ig_ClientState.setPropertyValue(n, p, v);
		return this.elemViewState.value = ig_ClientState.getText(this.viewState);
	}
	this.getDateInfo = function(){return this.info;}
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
}
//
function igcal_event(e)
{
	if(e == null) if((e = window.event) == null) return;
	var o = e.srcElement;
	if(o == null) if((o = e.target) == null) o = this;
	if(e.type != "change") if(e.button > 1 || e.shiftKey || e.altKey) return;
	if((o = igcal_getCalendarById(null, o)) != null) if(o.click != null) o.click(e);
}
