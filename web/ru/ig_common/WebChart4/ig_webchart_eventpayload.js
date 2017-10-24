/* 
 * Infragistics Web Chart Payload Script 
 * Author: Kamal Verma
 * Version 4.00.20041.28
 * Last modified: Mon Jul 28 09:57:31  2003
 * Copyright(c) 2001-2004 Infragistics, Inc. All Rights Reserved.
 * The JavaScript functions in this file are intended for the internal use of the Intragistics Web Controls only.
 */
 
function Payload(id, pload)
{
	this.ID = id;
	this.Load = pload;
	this.Parent = null; // set by render call
}

function PayLoadHandler(id)
{
	this.ID					= id;

	// public properties
	this.Payload = null;

	// Common Global Infrastructure related begin
	ID2OBJECT[this.ID]= this; // save id's ref.
	this.Parent		  = null; // for parent child relationship
	this.HTML		  = "";   // debugging purposes
	this.Listener	  = new Array();
	this.AddListener  = function(type, function_ref) 
	{
		this.Listener[type] = function_ref;
	}
	// Common Global Infrastructure related end

	this.OnGetEvent = function(evt) 
	{
		var elementName;
		if (IGB.IsNetscape6) 
		{
			elementName = evt.target.id;
		}
		else
		{
			elementName = evt.srcElement.id;
		}
		
		var payload = ID2OBJECT[elementName];

		var this_object = payload.Parent;
		
		// Fire events.
		var listener = this_object.Listener[evt.type];
		if (listener)
		{
			return listener.apply(this, [evt, IGB.GetObject(elementName), this_object, payload]);
		}
	}

	// private constant
	this.EventThatCanBeAttached = ['mousemove', 'mouseover', 'mouseout', 'click'];
	this.Render = function() 
	{
		if (this.Payload != null && this.Payload.length>0)
		{
			for(var i = 0; i < this.Payload.length; i++) 
			{
				var payload_id = this.Payload[i].ID;
				var where_ref = IGB.GetObject(payload_id);

				// save parent
				this.Payload[i].Parent = this;

				// save payloads
				ID2OBJECT[payload_id] = this.Payload[i];

				for(var j = 0; j < this.EventThatCanBeAttached.length; j++) 
				{
					if (this.Listener[this.EventThatCanBeAttached[j]])
					{
						//alert('attaching '+this.EventThatCanBeAttached[j]+' on '+payload_id);
						IGB.AddEventListener(where_ref, this.EventThatCanBeAttached[j],  this.OnGetEvent, true);
					}
				}
			}
		}
	}
}


