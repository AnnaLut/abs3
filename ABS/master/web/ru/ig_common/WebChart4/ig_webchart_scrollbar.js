/* 
 * Infragistics Web Chart Scrollbar Script 
 * Author: Kamal Verma
 * Version 4.00.20041.28
 * Last modified: Mon Jul 28 09:57:31  2003
 * Copyright(c) 2001-2004 Infragistics, Inc. All Rights Reserved.
 * The JavaScript functions in this file are intended for the internal use of the Intragistics Web Controls only.
 */
 
function IGScrollBar(id, width, height, scrollerLength, url, orientation) 
{
	this.Orientation = orientation==null?'horizontal':orientation;
	this.ID			 = id;
	this.ImageURL	 = url;
	this.Width		 = width;
	this.Height		 = height;
	this.ScrollerLen = scrollerLength;

	this.Location	 = new IGPoint(0,0);

	// Behaviour
	this.Minimum	 = 0;
	this.Maximum	 = 100;
	this.Value		 = 0;
	this.SmallChange  = 5;
	this.LargeChange  = 15;

	// Common Global Infrastructure related begin
	ID2OBJECT[this.ID]= this; // save id's ref.
	this.Parent		  = null; // for parent child relationship
	this.HTML		  = "";   // debugging purposes
	this.Listener	  = new Array();
	this.AddListener  = function(type, function_ref) 
	{
		this.Listener[type] = function_ref; // save listener into array.
	}
	// Common Global Infrastructure related end

	this.Render = function(where) 
	{
		var where_ref = IGB.GetObject(where); 
		if (where_ref == null) return;

		if (this.Location)
		{
			IGB.SetX(where_ref, this.Location.X);
			IGB.SetY(where_ref, this.Location.Y);
		}
		

		if ((this.Orientation != null)&&(this.Orientation=='vertical'))
		{
			var scrl = this.Height - 2 * this.Width - this.ScrollerLen - 1;

			this.HTML ="<table OnMouseWheel=ScrollbarMouseWheel('"+this.ID+"') id='"+this.ID+"' width="+this.Width+" height="+this.Height+" border=0 cellpadding=0 cellspacing=0 style='table-layout:fixed'>";
			this.HTML += "<tr>";
			this.HTML += "<td valign=top>";
			this.HTML += "<img						width="+this.Width+"px height="+this.Width+"px			src='"+this.ImageURL+"/"+this.ID+"_top_.jpg'		OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_top_over.jpg';\"		OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_top_.jpg';\"		OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_top_down.jpg'; ScrollItV('"+this.ID+"', -"+this.SmallChange+"); Repeating(true, ScrollItV, ['"+this.ID+"', -"+this.SmallChange+"]); \"	OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_top_.jpg';\" ><br>";
			this.HTML += "<img id='"+this.ID+"_1'	width="+this.Width+"px height=1px						src='"+this.ImageURL+"/"+this.ID+"_back_v_.jpg'		OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_v_over.jpg';\"	OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_v_.jpg';\"	OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_v_down.jpg'; ScrollItV('"+this.ID+"', -"+this.LargeChange+"); Repeating(true, ScrollItV, ['"+this.ID+"', -"+this.LargeChange+"]);\"	OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_v_.jpg';\" ><br>";
			this.HTML += "<img						width="+this.Width+"px height="+this.ScrollerLen+"px	src='"+this.ImageURL+"/"+this.ID+"_scroll_v_.jpg'	OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_scroll_v_over.jpg';\"	OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_scroll_v_.jpg';\"	OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_scroll_v_down.jpg'; EngageObject('"+this.ID+"');\"																						OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_scroll_v_.jpg';\" ><br>";
			this.HTML += "<img id='"+this.ID+"_3'	width="+this.Width+"px height="+scrl+"px				src='"+this.ImageURL+"/"+this.ID+"_back_v_.jpg'		OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_v_over.jpg';\"	OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_v_.jpg';\"	OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_v_down.jpg'; ScrollItV('"+this.ID+"', "+this.LargeChange+"); Repeating(true, ScrollItV, ['"+this.ID+"', "+this.LargeChange+"]); \"	OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_v_.jpg';\" ><br>";
			this.HTML += "<img						width="+this.Width+"px height="+this.Width+"px			src='"+this.ImageURL+"/"+this.ID+"_bottom_.jpg'		OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_bottom_over.jpg';\"	OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_bottom_.jpg';\"	OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_bottom_down.jpg'; ScrollItV('"+this.ID+"', "+this.SmallChange+"); Repeating(true, ScrollItV, ['"+this.ID+"', "+this.SmallChange+"]); \"	OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_bottom_.jpg';\" >";
			this.HTML += "</td></tr>";
			this.HTML += "</table>";	
		}
		else 
		{
			var scrl = this.Width - 2 * this.Height - this.ScrollerLen - 1;

			this.HTML ="<table OnMouseWheel=ScrollbarMouseWheel('"+this.ID+"') id='"+this.ID+"' width="+this.Width+" height="+this.Height+" border=0 cellpadding=0 cellspacing=0 style='table-layout:fixed'>";
			this.HTML += "<tr>";
			this.HTML += "<td  width="+this.Height+"px		height="+this.Height+"px>";
			this.HTML += "<img width="+this.Height+"px		height="+this.Height+"px						src='"+this.ImageURL+"/"+this.ID+"_left_.jpg'		OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_left_over.jpg';\"		OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_left_.jpg';\"		OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_left_.jpg';\"		OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_left_down.jpg'; ScrollItH('"+this.ID+"', -"+this.SmallChange+");		Repeating(true, ScrollItH, ['"+this.ID+"', -"+this.SmallChange+"]); \" ></td>";
			this.HTML += "<td  width=1px					height="+this.Height+"px id='"+this.ID+"_1'>"; 
			this.HTML += "<img width=1px					height="+this.Height+"px id='"+this.ID+"_2'		src='"+this.ImageURL+"/"+this.ID+"_back_h_.jpg'		OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_h_over.jpg';\"	OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_h_.jpg';\"	OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_h_.jpg';\"		OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_h_down.jpg'; ScrollItH('"+this.ID+"', -"+this.LargeChange+");	Repeating(true, ScrollItH, ['"+this.ID+"', -"+this.LargeChange+"]);\" ></td>";
			this.HTML += "<td  width="+this.ScrollerLen+"px height="+this.Height+"px>";
			this.HTML += "<img width="+this.ScrollerLen+"px height="+this.Height+"px id='"+this.ID+"_engagable' src='"+this.ImageURL+"/"+this.ID+"_scroll_h_.jpg'	OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_scroll_h_over.jpg';\" OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_scroll_h_.jpg';\"  OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_scroll_h_.jpg';\"	OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_scroll_h_down.jpg'; EngageObject('"+this.ID+"');\"   ></td>";
			this.HTML += "<td  width="+scrl+"px				height="+this.Height+"px id='"+this.ID+"_3'>";
			this.HTML += "<img width="+scrl+"px				height="+this.Height+"px id='"+this.ID+"_4'		src='"+this.ImageURL+"/"+this.ID+"_back_h_.jpg'		OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_h_over.jpg';\"	OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_h_.jpg';\"	OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_h_.jpg';\"		OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_back_h_down.jpg'; ScrollItH('"+this.ID+"', "+this.LargeChange+");		Repeating(true, ScrollItH, ['"+this.ID+"', "+this.LargeChange+"]); \" ></td>";
			this.HTML += "<td  width="+this.Height+"px		height="+this.Height+"px>";
			this.HTML += "<img width="+this.Height+"px		height="+this.Height+"px						src='"+this.ImageURL+"/"+this.ID+"_right_.jpg'		OnMouseOver=\"this.src='"+this.ImageURL+"/"+this.ID+"_right_over.jpg';\"	OnMouseOut=\"this.src='"+this.ImageURL+"/"+this.ID+"_right_.jpg';\"		OnMouseUp=\"this.src='"+this.ImageURL+"/"+this.ID+"_right_.jpg';\"		OnMouseDown=\"this.src='"+this.ImageURL+"/"+this.ID+"_right_down.jpg'; ScrollItH('"+this.ID+"', "+this.SmallChange+");		Repeating(true, ScrollItH, ['"+this.ID+"', "+this.SmallChange+"]); \" ></td>";
			this.HTML += "</tr>";
			this.HTML += "</table>";

		}
		IGB.InsertHTML(where_ref, this.HTML, "afterBegin");
		this.SetValue(this.Value);
	}

	this.SetValue = function(val)
	{
		this.Value = val;
		var id = this.ID;

		var id1 = IGB.GetObject(id+"_1");
		var id2 = IGB.GetObject(id+"_2");
		var id3 = IGB.GetObject(id+"_3");
		var id4 = IGB.GetObject(id+"_4");

		var cwid1 = 0;
		var cwid3 = 0;

		if ((this.Orientation != null)&&(this.Orientation=='vertical'))
		{
			cwid1 = IGB.GetHeight(id1);
			cwid3 = IGB.GetHeight(id3);
		}
		else 
		{
			cwid1 = IGB.GetWidth(id1);
			cwid3 = IGB.GetWidth(id3);
		}

		var totwid = cwid1 + cwid3 -1;

		if (this.Maximum != this.Minimum)
		{
			nuwid1 = (val - this.Minimum) * (totwid-1) / (this.Maximum - this.Minimum) + 1 ;
		}
		else 
		{
			nuwid1 = totwid
		}

		if (nuwid1 > totwid) nuwid1 = totwid;
		if (nuwid1 < 1) nuwid1 = 1;

		var nuwid3 = totwid - nuwid1;
		if (nuwid3 > totwid) nuwid3 = totwid;
		if (nuwid3 < 1) nuwid3 = 1;


		if ((this.Orientation != null)&&(this.Orientation=='vertical'))
		{
			IGB.SetWidth(id1, nuwid1);
			IGB.SetWidth(id3, nuwid3);
		}
		else 
		{
			IGB.SetWidth(id1, nuwid1);
			IGB.SetWidth(id2, nuwid1);

			IGB.SetWidth(id3, nuwid3);
			IGB.SetWidth(id4, nuwid3);
		}
	}
}

function ScrollItH(id, scroll) 
{
	var id1 = IGB.GetObject(id+"_1");
	var id2 = IGB.GetObject(id+"_2");
	var id3 = IGB.GetObject(id+"_3");
	var id4 = IGB.GetObject(id+"_4");

	var cwid1 = IGB.GetWidth(id1);
	var cwid3 = IGB.GetWidth(id3);

	var totwid = cwid1 + cwid3 -1;

	var nuwid1 = cwid1 + scroll;
	if (nuwid1 > totwid) nuwid1 = totwid;
	if (nuwid1 < 1) nuwid1 = 1;

	var nuwid3 = cwid3 - scroll;
	if (nuwid3 > totwid) nuwid3 = totwid;
	if (nuwid3 < 1) nuwid3 = 1;

	// repeating sanity
	if (nuwid1==1 || nuwid3 == 1)
	{
		Repeating(false); // clear timer
	}

	IGB.SetWidth(id1, nuwid1);
	IGB.SetWidth(id2, nuwid1);

	IGB.SetWidth(id3, nuwid3);
	IGB.SetWidth(id4, nuwid3);

	// update the value
	var obj = ID2OBJECT[id];
	obj.Value = obj.Minimum + ((nuwid1-1)/(totwid-1))*(obj.Maximum - obj.Minimum);
	
	// Fire events.
	var listener = obj.Listener["scroll"];
	if (listener)
	{
		listener.apply(this, ["scroll", IGB.GetObject(id), obj]);
	}
}

function ScrollItV(id, scroll) 
{
	var id1 = IGB.GetObject(id+"_1");
	var id3 = IGB.GetObject(id+"_3");

	var cwid1 = IGB.GetHeight(id1);
	var cwid3 = IGB.GetHeight(id3);

	var totwid = cwid1 + cwid3 -1;

	var nuwid1 = cwid1 + scroll;
	if (nuwid1 > totwid) nuwid1 = totwid;
	if (nuwid1 < 1) nuwid1 = 1;

	var nuwid3 = cwid3 - scroll;
	if (nuwid3 > totwid) nuwid3 = totwid;
	if (nuwid3 < 1) nuwid3 = 1;

	// repeating sanity
	if (nuwid1==1 || nuwid3 == 1)
	{
		Repeating(false); // clear timer
	}

	IGB.SetHeight(id1, nuwid1);
	IGB.SetHeight(id3, nuwid3);

	// update the value
	var obj = ID2OBJECT[id];
	obj.Value = obj.Minimum + ((nuwid1-1)/(totwid-1))*(obj.Maximum - obj.Minimum);

	// Fire events.
	var listener = obj.Listener["scroll"];
	if (listener)
	{
		listener.apply(this, ["scroll", IGB.GetObject(id), obj]);
	}
}

var EngagedObject=null;
var OldMouseDown;
var OldMouseMove;
var OldMouseUp;
var MouseDownX, MouseDownY;

function EngageObject(which) 
{
	EngagedObject = ID2OBJECT[which]; 
}
function ReleaseObject() 
{
	EngagedObject = null;
}

function NewMouseDown(evt) 
{
	if (OldMouseDown) OldMouseDown(evt);
	if (IGB.IsNetscape6) 
	{
		MouseDownX = evt.pageX;
		MouseDownY = evt.pageY;

		if (evt && evt.target && evt.target.id && (evt.target.id.indexOf('engagable')>-1))
		{
			return false;	
		}
	} else {
		MouseDownX = window.event.clientX;
		MouseDownY = window.event.clientY;
	}
	return true;
}
function NewMouseMove(evt) 
{
	if (OldMouseMove) OldMouseMove(evt);
	if( EngagedObject!=null) 
	{
		var scroll = 0;
		if ((EngagedObject.Orientation != null)&&(EngagedObject.Orientation=='vertical')) 
		{
			if (IGB.IsNetscape6) 
			{
                scroll = (evt.pageY - MouseDownY);
				MouseDownY = evt.pageY;
            } 
			else 
			{
                scroll = (window.event.clientY - MouseDownY);
				MouseDownY = window.event.clientY;
            }
			ScrollItV(EngagedObject.ID, scroll);
		}
		else 
		{
			if (IGB.IsNetscape6) 
			{
                scroll = (evt.pageX - MouseDownX);
				MouseDownX = evt.pageX;
            } 
			else 
			{
                scroll = (window.event.clientX - MouseDownX);
				MouseDownX = window.event.clientX;
            }
			ScrollItH(EngagedObject.ID, scroll);
		}
		return false;
	}
	return true;
}
function NewMouseUp(evt) 
{
	Repeating(false); // clear timer
	if (OldMouseUp) OldMouseUp(evt);
	ReleaseObject();
	return true;
}

function ScrollbarMouseWheel(id)
{
	var obj = ID2OBJECT[id];
	var scroll = 0;
	if		(event.wheelDelta >=  120) { scroll = -10;  }
    else if (event.wheelDelta <= -120) { scroll = +10;  }
	if ((obj.Orientation != null)&&(obj.Orientation=='vertical'))
	{
		ScrollItV(id, scroll);
	}
	else
	{
		ScrollItH(id, scroll);
	}	
	return false;
}

function InitilizeScrollbar() 
{
	if( OldMouseDown==null && IGB.FunctionName(document.OnMouseDown)!="NewMouseDown")
	{
		OldMouseDown=document.onmousedown;
	}
	if( OldMouseUp==null && IGB.FunctionName(document.OnMouseUp)!="NewMouseUp")
	{
		OldMouseUp=document.onmouseup;
	}
	if( OldMouseMove==null && IGB.FunctionName(document.OnMouseMove)!="NewMouseMove")
	{
		OldMouseMove=document.onmousemove;
	}

	document.onmousedown = NewMouseDown;
	document.onmouseup   = NewMouseUp;
	document.onmousemove = NewMouseMove;

	if (IGB.IsNetscape6) 
	{
        document.captureEvents(Event.MOUSEDOWN | Event.MOUSEMOVE | Event.MOUSEUP)
    }
}


