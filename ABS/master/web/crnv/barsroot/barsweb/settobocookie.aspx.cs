using System;
using System.Data;
using System.Web;
using Bars;
using Bars.Logger;

namespace barsweb
{
	public partial class SetToboCookie : BarsPage
	{

		protected void Page_Load(object sender, EventArgs e)
		{
			if(!IsPostBack)
			{
                DataSet ds = new DataSet();
				InitOraConnection(Context);
				try
				{
					SetRole("basic_info");

					ds = SQL_SELECT_dataset("SELECT TOBO, NAME FROM V_USER_TOBO ORDER BY NAME");
				}
				finally
				{
					DisposeOraConnection();
				}

                lsb_ToboData.DataSource = ds;
                lsb_ToboData.DataTextField = "NAME";
				lsb_ToboData.DataValueField = "TOBO";
				lsb_ToboData.DataBind();
                
				lsb_ToboData.SelectedIndex = 0;
                if (ds.Tables[0].Rows.Count == 1)
                {
                    bt_Ok_ServerClick(sender, e);
                }
			}
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
			this.bt_Ok.ServerClick += new EventHandler(this.bt_Ok_ServerClick);
			//this.Load += new EventHandler(this.Page_Load);

		}
		#endregion
       
		private void bt_Ok_ServerClick(object sender, EventArgs e)
		{
			if (lsb_ToboData.SelectedIndex < 0)
                lsb_ToboData.SelectedIndex = 0;
            string SelectedTobo = lsb_ToboData.Items[lsb_ToboData.SelectedIndex].Value;
			string CurrentUserId = "";
	
			try
			{
                InitOraConnection(Context);
				SetRole("BASIC_INFO");
				CurrentUserId = SQL_SELECT_scalar("SELECT USER_ID FROM dual").ToString().Trim().ToUpper();
                SetParameters("toboValue", DB_TYPE.Varchar2, SelectedTobo, DIRECTION.Input);
                SQL_NONQUERY("begin tobopack.SetTOBO(:toboValue); end;");
			}
			finally
			{
				DisposeOraConnection();
			}			

			if( Request.Cookies[CurrentUserId] == null )
			{
				HttpCookie newCookie = new HttpCookie(CurrentUserId);
				newCookie.Value = SelectedTobo;
				newCookie.Expires = DateTime.MaxValue;
				Response.Cookies.Add(newCookie);
			} 
			else
			{
				Request.Cookies.Remove(CurrentUserId);
				Response.Cookies.Remove(CurrentUserId);

				HttpCookie newCookie = new HttpCookie(CurrentUserId);
				newCookie.Value = SelectedTobo;
				newCookie.Expires = DateTime.MaxValue;
				Response.Cookies.Add(newCookie);
			}
			DBLogger.Info("Пользователь выбрал отделение " + SelectedTobo, HttpRuntime.AppDomainAppVirtualPath);
            Response.Redirect("default.aspx");
		}
	}
}
