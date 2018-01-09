using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Threading;
using System.Resources;
using System.Globalization;
using Oracle.DataAccess.Client;
using Bars.Oracle;

namespace barsweb
{
	/// <summary>
	/// Summary description for SetUserCash.
	/// </summary>
	public partial class SetUserCash : Bars.BarsPage
	{
		protected ResourceManager rm;
	
		/*/// <summary>
		/// устанавлмваем культуру данной машины или пользователя(а не сервера)
		/// </summary>
		private void SetCurLang()
		{
			// устанавлмваем культуру данной машины или пользователя(а не сервера)
			IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
			OracleConnection con = icon.GetUserConnection(Context);

			OracleCommand cmd = new OracleCommand();
			OracleDataAdapter adapter = new OracleDataAdapter();
			adapter.SelectCommand = cmd;
            
			cmd.Connection = con;			
			OracleDataReader MyReader = null;
			try
			{   
				cmd.CommandText = "set role basic_info";
				cmd.ExecuteNonQuery();
				
				cmd.CommandText = "SELECT VAL "+
					"FROM V_WEB_USERPARAMS " +
					"WHERE PAR = 'LANGUAGE'";
				MyReader = cmd.ExecuteReader();
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
			}
			finally
			{   
				cmd.Dispose();
				con.Close();
				con.Dispose();
			}			
		}*/

		protected void Page_Load(object sender, System.EventArgs e)
		{
			/*rm = new ResourceManager(
				GetType().BaseType.FullName, 
				GetType().BaseType.Assembly);
			SetCurLang();
			LabelCurrentCash.Text	= rm.GetString("LabelCurrentCash.Text");
			LabelSetupCash.Text		= rm.GetString("LabelSetupCash.Text");
			LabelChoose.Text		= rm.GetString("LabelChoose.Text");
			dg.Columns[0].HeaderText	= rm.GetString("dg.Columns[0].HeaderText");
			dg.Columns[1].HeaderText	= rm.GetString("dg.Columns[1].HeaderText");
			dg.Columns[2].HeaderText	= rm.GetString("dg.Columns[2].HeaderText");*/
		}

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

		private void FillListNLS()
		{
			IOraConnection icon = (IOraConnection)Application["OracleConnectClass"];
			OracleConnection con = icon.GetUserConnection(Context);
			try
			{
				OracleCommand cmd = new OracleCommand();
				cmd.Connection = con;
				cmd.CommandText = "set role basic_info";
				cmd.ExecuteNonQuery();
				cmd.CommandText = 				
				 " select distinct nls from V_USERCASHTOBO"
				+" union all"
				+" select null as nls from dual"
				+" order by nls";
				OracleDataAdapter ad = new OracleDataAdapter(cmd);
				DataSet ds = new DataSet();
				ad.Fill(ds, "CASHNLS");
				listNLS.DataSource = ds;
				listNLS.DataMember = "CASHNLS";
				listNLS.DataValueField = "NLS";
				listNLS.DataTextField = "NLS";
				listNLS.DataBind();
				cmd.CommandText = "select GetUserCash from dual";
				object obj = cmd.ExecuteScalar();
				if(null!=obj && obj.GetType().Name!="DBNull") 
				{
					textCurrentCash.Text = (string)obj;
					try
					{
						listNLS.SelectedValue = (string)obj;
					}
					catch(ArgumentOutOfRangeException outrange)
					{
						listNLS.SelectedValue = string.Empty;
					}
					cmd.CommandText = "select kv,nls,nms from V_USERCASHTOBO where nls=:p_nls order by kv";
					cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, (string)obj, ParameterDirection.Input);
					OracleDataAdapter adl = new OracleDataAdapter(cmd);
					DataSet dsl = new DataSet();
					adl.Fill(dsl, "CASHLIST");
					dg.DataSource = dsl;
					dg.DataMember = "CASHLIST";
					dg.DataBind();
					cmd.CommandText = "select GetUserCashNms from dual";
					textCurrentCash.ToolTip = (String)cmd.ExecuteScalar();
				}
				else
				{
					listNLS.SelectedValue = string.Empty;
					textCurrentCash.Text = string.Empty;
				}				
			}
			finally
			{
				con.Close();
				con.Dispose();
			}		
		}
		protected void listNLS_Load(object sender, System.EventArgs e)
		{
			if(!this.IsPostBack) FillListNLS();
		}

		protected void listNLS_SelectedIndexChanged(object sender, System.EventArgs e)
		{
			IOraConnection icon = (IOraConnection)Application["OracleConnectClass"];
			OracleConnection con = icon.GetUserConnection(Context);
			try
			{
				OracleCommand cmd = new OracleCommand();
				cmd.Connection = con;
				cmd.CommandText = "set role basic_info";
				cmd.ExecuteNonQuery();
				cmd.CommandText = "begin SetUserCash(:p_nls); end;";
				cmd.Parameters.Add("p_nls", OracleDbType.Varchar2, listNLS.SelectedValue, ParameterDirection.Input);
				cmd.ExecuteNonQuery();
			}
			finally
			{
				con.Close();
				con.Dispose();
			}
			FillListNLS();
		}
	}
}
