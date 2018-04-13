using System;
using System.Web;
using System.IO;
using System.Web.SessionState;

namespace Bars.Web.Print
{
	/// <summary>
	/// Клас друку
	/// </summary>
	public class BarsPrint: IHttpHandler, IRequiresSessionState 
	{
		public BarsPrint(){}
		bool IHttpHandler.IsReusable { get{return true;} }
		/// <summary>
		/// 
		/// </summary>
		/// <param name="context"></param>
		void IHttpHandler.ProcessRequest(HttpContext context)
		{
			HttpRequest Request = context.Request;
			HttpResponse Response = context.Response;

			String script =
            @"<script language='javascript'>
            function getURL() 
			{
                parent.contents.location.href = 'WebPage.aspx' + location.search;                
                parent.header.location.href = 'WebHead.aspx' + location.search;
			}
            </script>";
            Response.Write(script);
			Response.Write("	<frameset id='mFrameSet' rows='30,*' cols='*' onload='getURL();' frameborder='yes'> " +
				"<frame frameBorder='0' name='header' width='100%' src='javascript:parent.blank' scrolling='no' noresize> " +
                "<frame frameBorder='0' name='contents' src='WebPage.aspx' scrolling='yes'> " +
				"</frameset> ");
			Response.End();
		}
	}
}
