/* 
 * Infragistics Web Chart window viewer Script 
 * Author: Kamal Verma
 * Version 4.00.20041.28
 * Last modified: Mon Jul 28 09:57:31  2003
 * Copyright(c) 2001-2004 Infragistics, Inc. All Rights Reserved.
 * The JavaScript functions in this file are intended for the internal use of the Intragistics Web Controls only.
 */
 
function IGWindowViewer(id, imageId, vuid, srcBounds, destBounds) 
{
	this.SourceBounds = srcBounds;
	this.DestBounds	= destBounds;
	this.ImageId	= imageId;
	this.VUId		= vuid;

	// Common Global Infrastructure related begin
	ID2OBJECT[this.ID]= this; // save id's ref.
	this.Parent		  = null; // for parent child relationship
	this.HTML		  = "";   // debugging purposes
	this.Listener	  = new Array();
	this.AddListener  = function(type, function_ref) 
	{
		// does nothing
	}
	// Common Global Infrastructure related end

	this.MoveBy=function(x,y)
	{
		this.SourceBounds.X += x;
		this.SourceBounds.Y += y;
		this.Render();
	}

	this.Render=function()
	{
		var imgref = IGB.GetObject(this.ImageId);
		var vuwref = IGB.GetObject(this.VUId);
		
		// Viewing transform (scaling=1)
		//  1) Translate (-x, -y); img
		//  3) Translate (x1, y1); vu

		IGB.SetX(imgref, - this.SourceBounds.X);
		IGB.SetY(imgref, - this.SourceBounds.Y);

		IGB.SetStyle(vuwref, "clip", "rect(0,"+this.SourceBounds.Width+","+this.SourceBounds.Height+", 0)");

		IGB.SetX(vuwref, this.DestBounds.X);
		IGB.SetY(vuwref, this.DestBounds.Y);
	}
}



