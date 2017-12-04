using System;
// using System.Collections.Generic;
// using System.Linq;
// using System.Web;
// using System.Web.UI;
using System.Web.UI.WebControls;
using Bars;

namespace barsroot.udeposit
{
    public partial class DptCreateAgreement : BarsPage
    {
        # region variables
        // Депозитний договір
        private Int64 dpu_id
        {
            get
            {
                return Convert.ToInt64(ViewState["dpu_id"]);
            }
            set
            {
                ViewState["dpu_id"] = value;
            }
        }
        #endregion
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Int32 freq_id = Convert.ToInt32(Request.QueryString["freq_id"]);

            Int32 stop_id = Convert.ToInt32(Request.QueryString["stop_id"]);

            Int32 term_tp = 1;

            Boolean autoextend = true;
            /*
             DPU_VIDD.TERM_TYPE - як ознака того чи можна змінювати дату (1 - фікований, 2 - діапазон)
             * для діаппазону передаємо min. max. допустимі дати
            */


            if (!IsPostBack)
            {
                if (Request["dpt_id"] == null)
                    Response.Redirect( "DepositSearch.aspx?action=agreement&extended=0");
                else
                {
                    dpu_id = Convert.ToInt64(Request["dpt_id"]);
                }

                if (term_tp == 1)
                {
                    //tbNewDateEnd.Date =
                }
                else
                {
                    // діапазон
                    //tbNewDateEnd.MinDate=
                    //tbNewDateEnd.MaxDate= 
                }
                
                try
                {
                    InitOraConnection();

                    // види додаткових угод
                    ddAgreementTypes.DataSource = SQL_SELECT_dataset("select ID, NAME from DPU_AGREEMENT_TYPES where ACTIVE = 1 order by ID");
                    ddAgreementTypes.DataBind();
                    ddAgreementTypes.Items.Insert(0, new ListItem("", "", true));
                    ddAgreementTypes.SelectedValue = "";

                    if (autoextend)
                    {
                        // Для договорів з автолонгацією не показуємо ДУ про пролонгацію договору
                        ddAgreementTypes.Items.RemoveAt(7);
                    }

                    // 
                    ClearParameters();
                    SetParameters("freq_id", DB_TYPE.Decimal, freq_id, DIRECTION.Input);
                    ddFreqTypes.DataSource = SQL_SELECT_dataset("select FREQ, NAME from FREQ where FREQ <> :freq_id");
                    ddFreqTypes.DataBind();
                    ddFreqTypes.Items.Insert(0, new ListItem("", "", true));
                    ddFreqTypes.SelectedValue = "";

                    // 
                    ClearParameters();
                    SetParameters("stop_id", DB_TYPE.Decimal, stop_id, DIRECTION.Input);
                    ddPenaltyTypes.DataSource = SQL_SELECT_dataset("select ID, NAME from DPT_STOP where (MOD_CODE = 'DPU' or MOD_CODE IS NULL) and ID >=0 and ID <> :stop_id order by ID");
                    ddPenaltyTypes.DataBind();
                    ddPenaltyTypes.Items.Insert(0, new ListItem("", "", true));
                    ddPenaltyTypes.SelectedValue = "";
                }
                finally
                {
                    DisposeOraConnection();
                }
            }
            
            // Населяємо табл. наявних дод.угод
            FillGrid(dpu_id);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="p_type"></param>
        /// <param name="p_cust_id"></param>
        private void FillGrid(Int64 p_dpu_id)
        {
            dsAgreements.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();

            string searchQuery;

            searchQuery = "select AGRMNT_ID, AGRMNT_NUMBER, AGRMNT_BDATE, AGRMNT_TYPE_NAME, AGRMNT_STATE" +
                          "  from V_DPU_AGREEMENTS" +
                          " where AGRMNT_DPU_ID = :p_dpu_id" +
                          " order by AGRMNT_ID desc";

            dsAgreements.WhereParameters.Clear();
            dsAgreements.SelectCommand = searchQuery;
            dsAgreements.WhereParameters.Add("p_dpu_id", TypeCode.Int64, Convert.ToString(p_dpu_id));

            // gvDepositMain.DataSourceID = "dsSearchDeposit";
            gvAgreements.DataBind();

            //if (gvAgreements.Rows.Count == 0)
            //    btSelectContract.Enabled = false;
        }

        /// <summary>
        /// Розмальовуємо табличку
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e != null && e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView gv = (sender as GridView);

                Int32 StateID = Convert.ToInt32(gv.DataKeys[e.Row.DataItemIndex]["AGRMNT_STATE"]);

                if (StateID == -1)
                {
                    e.Row.ForeColor = System.Drawing.Color.Red;
                }

                if (StateID == 0)
                {
                    e.Row.Cells[1].BackColor = System.Drawing.Color.DarkBlue;
                }

                if (StateID == null)
                {
                    e.Row.Cells[1].BackColor = System.Drawing.Color.Yellow;
                }

                if (StateID == 1)
                {
                    e.Row.Cells[1].BackColor = System.Drawing.Color.DarkGreen;
                }
            }
        }
       
        protected void btPrint_Click(object sender, EventArgs e)
        {
            String Template = "EMPTY_TEMPLATE";
            
            // Друк
            FrxParameters pars = new FrxParameters();
            //pars.Add(new FrxParameter("p_dpt_id", TypeCode.Int64, dpt_id));
            //pars.Add(new FrxParameter("p_rnk", TypeCode.Int64, Convert.ToInt64(dpt.Client.ID)));

            FrxDoc doc = new FrxDoc(FrxDoc.GetTemplatePathByFileName(FrxDoc.GetTemplateFileNameByID(Template)), pars, this.Page);

            // выбрасываем в поток в формате PDF
            doc.Print(FrxExportTypes.Pdf);
        }
}
}