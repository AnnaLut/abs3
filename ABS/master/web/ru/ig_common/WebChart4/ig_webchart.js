/* 
 * Infragistics Web Chart Script 
 * Author: Kamal Verma
 * Version 4.00.20041.28
 * Last modified: Mon Jul 28 09:57:31  2003
 * Copyright(c) 2001-2004 Infragistics, Inc. All Rights Reserved.
 * The JavaScript functions in this file are intended for the internal use of the Intragistics Web Controls only.
 */
 
/// <summary>
/// UltraChart CSOM object.
/// </summary>
/// <remarks>
/// <p class="body">This object is intantiated by the control. It can't be used by JavaScript code to create an instance of the chart.</p> 
/// </remarks>
/// <param name="id">chart id</param>
/// <param name="imageUrl">Url to pickup scrollbar images from.</param>
function IGUltraChart(id, imageUrl)
{
	// public properties assined with constructor
	this.ID			= id;
	this.ImageUrl	= imageUrl;
	
	// must be assigned public properties
	this.EnableTooltipFading = false;
	this.EventData	= null;
	this.TooltipData= null;
	this.RowCount = 0;
	this.ColumnCount = 0;
	this.TooltipDisplay = 0; // Never
	this.EnableCrossHair = false;
	this.EnableServerEvent = false;

	// Common Global Infrastructure related begin
	ID2OBJECT[this.ID]= this; // save id's ref.
	this.Parent		  = null; // for parent child relationship
	this.HTML		  = "";   // debugging purposes
	this.Listener	  = new Array();
	this.DEBUG		  = false;
	this.AddListener  = function(type, function_ref) 
	{
		this.Listener[type] = function_ref; // save listener into array.
		// In all these listeners "this" refers to calling IGUltraChart object
		// UltraChart fires following CSOM Events.
		// mousemove(object []arg)
		// mouseout(object []arg)
		// mouseclick(object []arg)
		// showtooltip(string text, object tooltip_ref)
		// hidetooltip(string text, object tooltip_ref)
		// crosshairmove(int x, int y)
		// hidecrosshair(int x, int y)
		// showcrosshair(int x, int y)
		// scroll(IGScrollBar sb)
		
	}
	// Common Global Infrastructure related end

	// private variables
	this.payloadHandler = null;
	this.SB1 = null;
	this.SB2 = null;
	this.igWindowVuer = null;
	this.iGCrossHair = null;
	this.XhairBounds = null;
	this.TooltipFader = null;
	this.TooltipVisible = false;

	/// <summary>
	/// Called by UltraWebChart when it runs at Server.
	/// </summary>
	this.CreateComponents=function(vals)
	{
		// Create instance
		this.SB1				= new IGScrollBar(this.ID+"_SB1", vals[2], vals[3],  30, this.ImageUrl);
		this.SB2				= new IGScrollBar(this.ID+"_SB2", vals[9], vals[10], 30, this.ImageUrl, "vertical");
		this.igWindowVuer		= new IGWindowViewer(this.ID+"_igWindowVuer", this.ID+"_ScrollImage", this.ID+"_igWindowVuer");
		this.iGCrossHair		= new IGCrossHair(this.ID+"_iGCrossHair");
		this.TooltipFader		= new Fader();

		// Set parents for object containment hierarchy.	
		this.SB1.Parent = this;
		this.SB2.Parent = this;
		this.igWindowVuer.Parent = this;
		this.iGCrossHair.Parent = this;

		// cross hair settings
		this.iGCrossHair.SpanImageObject	= IGB.GetObject(this.ID+"_BaseImage");
		this.iGCrossHair.HairHorizontal		= IGB.GetObject(this.ID+"_HairHorizontal");
		this.iGCrossHair.HairVertical		= IGB.GetObject(this.ID+"_HairVertical");
		this.iGCrossHair.Visible			= this.EnableCrossHair;

		// View settings
		this.igWindowVuer.SourceBounds		= vals[4]; 
		this.igWindowVuer.DestBounds		= vals[5]; 
		this.XhairBounds					= vals[0]; 

		// Scrollbar settings
		this.SB1.Location = vals[1];
		this.SB1.AddListener("scroll", this.SB1_Scroll);
		this.SB1.Minimum = vals[6];
		this.SB1.Maximum = vals[7];
		this.SB1.Value	 = vals[6];

		this.SB2.Location = vals[8];
		this.SB2.AddListener("scroll", this.SB2_Scroll);
		this.SB2.Minimum = vals[11];
		this.SB2.Maximum = vals[12];
		this.SB2.Value	 = vals[11]
	}

	/// <summary>
	/// Called by UltraWebChart when it runs at Server.
	/// </summary>
	this.Render=function(vals) 
	{
		if (vals[0]) this.SB1.Render(this.ID+"_SB1_Location");
		if (vals[1]) this.SB2.Render(this.ID+"_SB2_Location");
		if (vals[2]) this.igWindowVuer.Render();
		if (vals[3])this.iGCrossHair.Render(vals[5]);
		
		// Show image after rendering is done
		if (vals[4]) IGB.ShowObject(IGB.GetObject(this.ID+"_ScrollImage"));
	}

	/// <summary>
	/// This handles the Horizontal Scroll functionlity of chart.
	/// </summary>
	this.SB1_Scroll=function(evt, sender_element, sender_object) 
	{
		sender_object.Parent.igWindowVuer.SourceBounds.X = parseInt(sender_object.Value);
		sender_object.Parent.igWindowVuer.Render();
		var function_ref = sender_object.Parent.Listener[evt];
		if (function_ref != null) 
		{
			function_ref.apply(sender_object.Parent, [sender_object]);
		}
	}

	/// <summary>
	/// This handles the Vertical Scroll functionlity of chart.
	/// </summary>
	this.SB2_Scroll=function(evt, sender_element, sender_object) 
	{
		sender_object.Parent.igWindowVuer.SourceBounds.Y = parseInt(sender_object.Value);
		sender_object.Parent.igWindowVuer.Render();
		var function_ref = sender_object.Parent.Listener[evt];
		if (function_ref != null) 
		{
			function_ref.apply(sender_object.Parent, [sender_object]);
		}
	}

	/// <summary>
	/// This handles the Horizontal Scrolling on mouse wheel functionlity of chart.
	/// </summary>
	this.onmousewheel=function(evt, id)
	{
		// works only horizontally.
		if		(evt.wheelDelta >=  120) { this.igWindowVuer.MoveBy(-10,0);  }
		else if (evt.wheelDelta <= -120) { this.igWindowVuer.MoveBy(+10,0);  }

		this.SB1.SetValue(this.igWindowVuer.SourceBounds.X);
	}

	/// <summary>
	/// This handles the On Mouse Move functionlity of chart.
	/// </summary>
	this.onmousemove=function(evt, id)
	{
		var baseImageRef;
		var x,y;
		var oldState = this.iGCrossHair.Visible;
		
		if (IGB.IsNetscape6) 
		{
			baseImageRef = IGB.GetObject(this.ID+"_BaseImage");

			x = evt.pageX - IGB.GetPageX(baseImageRef);
			y = evt.pageY - IGB.GetPageX(baseImageRef);
		} 
		else 
		{
			baseImageRef = IGB.GetObject(this.ID+"_BaseImage");

			x = window.event.clientX - IGB.GetPageX(baseImageRef) + document.body.scrollLeft;
			y = window.event.clientY - IGB.GetPageY(baseImageRef) + document.body.scrollTop;

		}

		if (this.EnableCrossHair)
		{
			this.iGCrossHair.Visible = this.XhairBounds.Inside(x,y);
			this.iGCrossHair.Update(x-5, y-5);
			if (this.iGCrossHair.Visible)
			{
				var function_ref = this.Listener["crosshairmove"];
				if (function_ref != null) 
				{
					function_ref.apply(this, [x-5, y-5]);
				}
			}
		}

		if (oldState != this.iGCrossHair.Visible)
		{
			if (oldState)
			{
				var function_ref = this.Listener["hidecrosshair"];
				if (function_ref != null) 
				{
					function_ref.apply(this, [x-5, y-5]);
				}
			}
			else
			{
				var function_ref = this.Listener["showcrosshair"];
				if (function_ref != null) 
				{
					function_ref.apply(this, [x-5, y-5]);
				}
			}
		}

		x+=15;
		y+=20;

		IGB.SetX(IGB.GetObject(this.ID+"_IGTooltip"),x);
		IGB.SetY(IGB.GetObject(this.ID+"_IGTooltip"),y);
	}

	/// <summary>
	/// This handles the Tooltips functionlity of chart.
	/// </summary>
	this.ShowTooltip=function(evt, id, args)
	{
		var tooltip_ref = IGB.GetObject(this.ID+"_IGTooltip");
		
		var text = "";
		var data_id = args[4]+"_"+args[1]+"_"+args[2];
		
		if (this.DEBUG)
		{
			window.status = data_id;
		}

		if (this.TooltipData!=null)
		{
			text = this.TooltipData[data_id];
		}
				
		IGB.WriteHTML(tooltip_ref, "<nobr>"+text+"</nobr>");
		IGB.ShowObject(tooltip_ref);
		this.TooltipVisible = true;

		if (this.EnableTooltipFading)
		{
			this.TooltipFader.End();
			this.TooltipFader.Start(tooltip_ref, 0, 100, 20);
		}
		var function_ref = this.Listener["showtooltip"];
		if (function_ref != null) 
		{
			function_ref.apply(this, [text, tooltip_ref]);
		}
	}

	/// <summary>
	/// This handles the Tooltips functionlity of chart.
	/// </summary>
	this.HideTooltip=function(evt, id, args)
	{
		// Don't do this until the tooltip was really visible
		if (!this.TooltipVisible) return;
		
		var tooltip_ref = IGB.GetObject(this.ID+"_IGTooltip");
		
		var text = "";
		var data_id = args[4]+"_"+args[1]+"_"+args[2];

		if (this.TooltipData!=null)
		{
			text = this.TooltipData[data_id];
		}

		this.TooltipFader.End();
		IGB.HideObject(tooltip_ref);
		
		var function_ref = this.Listener["hidetooltip"];
		if (function_ref != null) 
		{
			function_ref.apply(this, [text, tooltip_ref]);
		}
	}

	/// <summary>
	/// This handles the functionlity of chart related to all other events. This acts as main dispatcher of client events and Glue between Version 1/3 javascript code.
	/// </summary>
	this.onallevent=function(evt, id, args)
	{

		// args = [this_ref, row, column, event_name, layer_id]
		
		var function_ref = this.Listener[evt.type];
		if (function_ref != null) 
		{
			var v = IGB.DecodeArguments( this.EventData[args[4]+"_"+args[1]+"_"+args[2]] );
			function_ref.apply(this, [this, v[0], v[1], v[2], v[3], v[4], evt.type, args[4] ] );
		}
		
		if (evt.type == "mouseover" && this.TooltipDisplay == 1)
		{
			this.ShowTooltip(evt, id, args);
		}
		else if (evt.type == "click" && this.TooltipDisplay == 2)
		{
			this.ShowTooltip(evt, id, args);
		}
		else if (evt.type == "mouseout" )
		{
			this.HideTooltip(evt, id, args);
		}


		if ((evt.type=="click") && (this.EnableServerEvent))
		{
			// TODO: check to see if right arguments are passed here and on the server after recipt
			// -Kamal 7/8/2003 
			var data = this.EventData[args[4]+"_"+args[1]+"_"+args[2]];
			if (this.DEBUG) window.status = "RawData="+data;
			__doPostBack(this.ID, data);
		}
	}
}
