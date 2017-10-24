/* 
 * Infragistics Web Chart cross hair Script 
 * Author: Kamal Verma
 * Version 4.00.20041.28
 * Last modified: Mon Jul 28 09:57:31  2003
 * Copyright(c) 2001-2004 Infragistics, Inc. All Rights Reserved.
 * The JavaScript functions in this file are intended for the internal use of the Intragistics Web Controls only.
 */
function IGCrossHair(id, toggleOnClick)
{
	this.ID					= id;
	this.ToggleOnClick		= toggleOnClick;
	this.Visible			= false;

	// must set properties
	this.SpanImageObject	= null;
	this.HairHorizontal		= null;
	this.HairVertical		= null;

	// Common Global Infrastructure related begin
	ID2OBJECT[this.ID]= this; // save id's ref.
	this.Parent		  = null; // for parent child relationship
	this.HTML		  = "";   // debugging purposes
	this.Listener	  = new Array();
	this.AddListener  = function(type, function_ref) 
	{
		// no events supported yet.
	}
	// Common Global Infrastructure related end

	this.Render=function(b)
	{
		IGB.SetX(this.HairHorizontal, b.X);
		IGB.SetY(this.HairVertical, b.Y);
		IGB.SetWidth(this.HairHorizontal, b.Width);
		IGB.SetHeight(this.HairHorizontal, 1);
		IGB.SetHeight(this.HairVertical, b.Height);
		IGB.SetWidth(this.HairVertical, 1);
	}

	this.Update=function(x, y)
	{
		if(this.Visible==true)
		{
			IGB.ShowObject(this.HairHorizontal);
			IGB.ShowObject(this.HairVertical);
		}
		else 
		{
			IGB.HideObject(this.HairHorizontal);
			IGB.HideObject(this.HairVertical);
		}

		if (x && y)
		{
			IGB.SetX(this.HairVertical, x);
			IGB.SetY(this.HairHorizontal, y);
		}
	}
}



