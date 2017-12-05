using System;
using System.Data;
// using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Bars;
using Bars.Oracle;
using BarsWeb.Core.Logger;
using Oracle.DataAccess.Client;

namespace barsroot.udeposit
{
	public partial class DptDealParams : BarsPage
	{
	
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                try 
                {
                    InitOraConnection();
                    ddProduct.DataSource = SQL_SELECT_dataset("select TYPE_ID, TYPE_NAME from DPU_TYPES where FL_ACTIVE=1 order by SORT_ORD");
                    ddProduct.DataBind();
                    ddProduct.Items.Insert(0, new ListItem("", "", true));
                    ddProduct.SelectedValue = "";

                    ddKv.DataSource = SQL_SELECT_dataset("select kv, name from TABVAL where d_close is null and kv in (select distinct kv from DPU_VIDD where FLAG = 1 )");
                    ddKv.DataBind();
                    ddKv.Items.Insert(0, new ListItem("", "", true));
                    ddKv.SelectedValue = "";
                }
                finally
                {
                    DisposeOraConnection();
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
            // this.btPrint.ServerClick += new ImageClickEventHandler(this.btPrint_ServerClick);
		}
		#endregion

        protected void btPrint_ServerClick(object sender, EventArgs e)
        {
            string template = tbTempalte.Value;
            
            var dbLogger = DbLoggerConstruct.NewDbLogger();

            dbLogger.Info("PrintFrx: Entry with (" + template + ").");

            if (String.IsNullOrWhiteSpace(template))
            {
                String script = "bars.ui.alert({ text: 'Не вказано шаблон для друку договору!' })";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "Error", script, true);
            }
            else
            {
                try
                {
                    Int64 dpuID = Convert.ToInt64(Request.QueryString["dpu_id"]);

                    if (dpuID > 0)
                    {
                        // Друк
                        FrxParameters pars = new FrxParameters();
                        pars.Add(new FrxParameter("dpu_id", TypeCode.Int64, dpuID));

                        // Page page = (Page)HttpContext.Current.Handler;

                        FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(template)), pars, this.Page );

                        // выбрасываем в поток в формате PDF
                        doc.Print(FrxExportTypes.Pdf);
                    }
                }
                catch (Exception ex)
                {
                    dbLogger.Info("PrintFrx: Error => " + ex.Message);
                    String script = "bars.ui.alert({ text: '" + ex.Message + "' })";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "Error", script, true);
                }
            }

            dbLogger.Info("PrintFrx: Exit.");
        }
}
}
