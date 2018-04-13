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

namespace BarsWeb.CheckInner
{
	public partial class _default : Bars.BarsPage
	{
		protected System.Data.DataSet ds;

		//------------------------------------------------------
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(Request.Params.Get("type") != null)
			{
				AppPars Params = new AppPars(Request.Params.Get("type"));
				switch (Request.Params.Get("type"))
				{
					//-- самовиза 
					case "0" : Response.Redirect("documents.aspx?type=0&grpid=self");
						break;
                    //-- кассовые документы 1
                    case "5": Response.Redirect("documents.aspx?type=5&grpid=1");
                        break;
                    //-- кассовые документы 1
                    case "6": Response.Redirect("documents.aspx?type=6&grpid=4");
                        break;
                }				

				DataSet ds = new DataSet();
				InitOraConnection(Context);

				try
				{
					SetRole(Params.Role);

					ds = SQL_SELECT_dataset(@"SELECT GRPID, GRPNAME FROM V_USER_VISA ORDER BY 2");
				}
				finally
				{
					DisposeOraConnection();
				}

				lstb_Visa.DataSource = ds;
				lstb_Visa.DataTextField = "GRPNAME";
				lstb_Visa.DataValueField = "GRPID";
				lstb_Visa.DataBind();			
			
				if(lstb_Visa.Items.Count > 0) lstb_Visa.Items[0].Selected = true;
                else throw new Exception(Resources.checkinner.LocalRes.text_UPolzovateliaNetGrupVizirovania);

                // если у нас всего одна группа визирования
				if(lstb_Visa.Items.Count == 1) 
                {
                    string sGrpId = lstb_Visa.Items[0].Value;
                    string sType = Request.Params.Get("type");
                    if (sType == "3")
                        Response.Redirect("verifdoc.aspx?grpid=" + sGrpId);
                    else
                        Response.Redirect("documents.aspx?type=" + sType + "&grpid=" + sGrpId);                
                }
			}
            else throw new Exception(Resources.checkinner.LocalRes.text_StraVuzvanaBezNeobhParam);
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
			this.ds = new System.Data.DataSet();
			((System.ComponentModel.ISupportInitialize)(this.ds)).BeginInit();
			// 
			// ds
			// 
			this.ds.DataSetName = "ds";
			this.ds.Locale = new System.Globalization.CultureInfo("uk-UA");
			((System.ComponentModel.ISupportInitialize)(this.ds)).EndInit();

		}
		#endregion
	}
}
