using System;
using System.Resources;
using System.Threading;
using System.Web;
using System.Reflection;
using System.Web.SessionState;

namespace Bars.Web.Print
{
	/// <summary>
	/// Сторінка з кнопкою
	/// друку
	/// </summary>
    public class BarsHead : IHttpHandler, IRequiresSessionState 
	{
		public BarsHead(){}
		bool IHttpHandler.IsReusable { get{return true;} }
		void IHttpHandler.ProcessRequest(HttpContext context)
		{
			HttpRequest Request = context.Request;
			HttpResponse Response = context.Response;

			string strDisable = "";
			if(Request.Params.Get("acode") != null)
				switch (Request.Params.Get("acode"))
				{
					case "RO" : strDisable = " disabled "; break;
				}

			String script = @"<script language='javascript'>function printcmd() {
				try { parent.frames['contents'].focus(); parent.frames['contents'].print();}
				catch(e){alert(e.message);}} 
                function exportToFile()
                { var filename=location.search.substr(10);
                  window.open('dialog.aspx?type=show_rtf_file&filename=' + filename + '&reportname=report', '', 'left=0,top=0,width=1,height=1');  
                }
                </script>";
			Response.Write(script);
			String innerHtml = @"<TABLE style='LEFT: 0px; POSITION: absolute; TOP: 0px' width='100%'>
				<TR>
					<TD align='center' nowrap>
						<INPUT type='button' id='btPrint' value='     " + getResource("Print") + @"     ' 
							onclick='printcmd()' " + strDisable + @">
                        <INPUT type='button' id='btExport' value='   Зберегти   ' onclick='exportToFile()' " + strDisable + @">
					</TD>
                    <TD>
                        
                    </TD>
				</TR>";

			Response.Write(innerHtml);

			Response.End();
		}
        private string getResource(string key)
        {
            ResourceManager rm = Resources.Bars.Web.Print.Localization.ResourceManager;
            return rm.GetString(key + "_" + Thread.CurrentThread.CurrentUICulture.Name.Substring(0, 2));
        }
	}
}
