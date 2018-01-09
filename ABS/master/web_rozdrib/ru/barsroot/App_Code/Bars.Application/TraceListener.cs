using System;
using System.Web;
using System.Diagnostics;

namespace Bars.Application
{
	public class TraceListener:DefaultTraceListener
	{
		public TraceListener()
		{
			
		}
		public override void Write(string message)
		{
			Write(message,null);
		}
		public override void Write(string message, string message2)
		{
			if("On" == message)
				HttpContext.Current.Trace.IsEnabled = true;
			else 
				HttpContext.Current.Trace.IsEnabled = false;
			return;
		}
	}
}
