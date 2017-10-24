using System;
using System.Data;
using System.Globalization;
using System.Resources;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Exception;
using Bars.Oracle;
using Oracle.DataAccess.Client;


namespace barsweb.References
{
	/// <summary>
	/// Summary description for RefList.
	/// </summary>
	public partial class RefList : Bars.BarsPage
	{
		protected ResourceManager rm;
	
		protected void Page_Load(object sender, EventArgs e)
		{
			if(null==Request.Params["app"]) throw new BarsException("Параметр 'app' не найден в строке URL.");
			rm  = new ResourceManager(GetType().BaseType.ToString(), GetType().BaseType.Assembly);
			//SetCurLang();
			//ReadResources();
			TreeLoad();
		}

		/*/// <summary>
		/// устанавлмваем культуру данной машины или пользователя(а не сервера)
		/// </summary>
		private void SetCurLang()
		{
			// устанавлмваем культуру данной машины или пользователя(а не сервера)
			IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
			OracleConnection con = icon.GetUserConnection(Context);

			try
			{   
				OracleCommand cmd = new OracleCommand();
				cmd.Connection = con;

				cmd.CommandText = "set role basic_info";
				cmd.ExecuteNonQuery();
				
				cmd.CommandText = "SELECT VAL "+
					"FROM V_WEB_USERPARAMS " +
					"WHERE PAR = 'LANGUAGE'";
				OracleDataReader MyReader = cmd.ExecuteReader();
				if(MyReader.Read())
				{
					string a = MyReader.GetString(0);
					//если в таблице есть языковые настроики
					Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(MyReader.GetString(0));						
					Thread.CurrentThread.CurrentUICulture = new CultureInfo(MyReader.GetString(0));
				}
				else
				{
					//если параметр "язык" отсутствует, то устанавливаем текущий язык
					Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(Request.UserLanguages[0]);						
					Thread.CurrentThread.CurrentUICulture = new CultureInfo(Request.UserLanguages[0]);
				}
				MyReader.Close();
			}
			finally
			{   				
				con.Close();
				con.Dispose();
			}			
		}*/

		/*/// <summary>
		/// выбираем строковые константы 
		/// для данной культуры(языка)
		/// вызывается один раз
		/// </summary>
		private void ReadResources()
		{	
			LabelReferences.Text = rm.GetString("LabelReferences.Text");
		}*/

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    

		}
		#endregion

		private void TreeLoad()
		{
			IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
			OracleConnection con = icon.GetUserConnection(Context);

			try
			{   
				OracleCommand cmd = new OracleCommand();
				cmd.Connection = con;

				/*cmd.CommandText = "set role wr_refread";
				cmd.ExecuteNonQuery();*/
				
				cmd.CommandText = "SELECT r.tabid, t.NAME, m.tabname, m.semantic, TRIM(p.acode) "
				+"FROM REFERENCES r, refapp p, typeref t, meta_tables m "
				+"WHERE r.tabid = m.tabid "
				+"	AND r.TYPE = t.TYPE "
				+"	AND p.tabid = r.tabid "
				+"	AND TRIM(p.codeapp) = :app "
				+"ORDER BY 2, 4 ";
				cmd.Parameters.Add("app", OracleDbType.Varchar2, Request.Params["app"].Trim(), ParameterDirection.Input);
				OracleDataReader rdr = cmd.ExecuteReader();
				
				string strLastGroup = string.Empty;
				string img = string.Empty;
				string url = string.Empty;
				while(rdr.Read())
				{
					string strGroup = rdr.GetOracleString(1).Value;
					if(strGroup!=strLastGroup)  // новая группа справочников
					{
						if("" != strGroup)
							listRef.Controls.Add(new LiteralControl("</DIV>"));
						listRef.Controls.Add(new LiteralControl("<DIV>"));
						listRef.Controls.Add(new LiteralControl("<img id='i_"+rdr.GetOracleValue(0).ToString()+"' onclick=\"subMenu('"+rdr.GetOracleValue(0).ToString()+"')\" align=\"absmiddle\" src=\"/Common/Images/book_closed.gif\" />"));
						listRef.Controls.Add(new LiteralControl("&nbsp<span ondblclick=\"subMenu('"+rdr.GetOracleValue(0).ToString()+"')\" onselectstart='return false;' onmouseleave=\"this.style.textDecoration='none'\" onmousemove=\"this.style.textDecoration='underline'\" style=\"cursor:hand;font-family:verdana;font-size:10pt;\">"+strGroup+"</span>"));
						listRef.Controls.Add(new LiteralControl("</DIV>"));
						listRef.Controls.Add(new LiteralControl("<DIV id='o_"+rdr.GetOracleValue(0).ToString()+"' style=\"display:none;margin-left:15px;\">"));
						strLastGroup = strGroup;
					}
					
					url = "/barsroot/barsweb/References/RefBook.aspx?tabid="+
                        rdr.GetDecimal(0).ToString() + "&mode=" +
						rdr.GetOracleString(4).Value;
					
					//url = "/barsweb/References/RefView.aspx?tabname="+Convert.ToString(rdr.GetOracleString(2).Value);

					if(rdr.GetOracleString(4).Value=="RW")
						img = "/Common/Images/ref_edit.gif";
					else
						img = "/Common/Images/ref_view.gif";

					listRef.Controls.Add(new LiteralControl("<DIV>"));	
					listRef.Controls.Add(new LiteralControl("<img src='"+img+"' />"));
					listRef.Controls.Add(new LiteralControl("&nbsp<span onselectstart='return false;' onmouseleave=\"this.style.textDecoration='none'\" onmousemove=\"this.style.textDecoration='underline'\" onclick=\"document.location.href='"+url+"'\" style=\"cursor:hand;font-family:verdana;font-size:10pt;\">"+rdr.GetOracleString(3).Value+"</span>"));
					listRef.Controls.Add(new LiteralControl("</DIV>"));	
				}
				rdr.Close();
			}
			finally
			{   				
				con.Close();
				con.Dispose();
			}
		}

	}
}
