using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;

public partial class deposit_DptRequestArchive : System.Web.UI.Page
{
    private String BankDate
    {
        get
        {
            return (String)ViewState["BankDate"];
        }
        set
        {
            ViewState["BankDate"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BankDate = BankType.GetBankDate();

            tbDateStart.Text = BankDate;
            tbDateFinish.Text = BankDate;
        }
        else
        {
            dsReqArchive.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
            
            FillGrid();
        }

    }

    // Пошук клієнта
    protected void btnRequestSearch_Click(object sender, EventArgs e)
    {
        Bars.Logger.DBLogger.Info(String.Format("Користувач виконав пошук запитів за період з {0} по {1}.", tbDateStart.Text, tbDateFinish.Text), "deposit");                                        
    }

    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        DateTime DateStart;
        DateTime DateFinish;

        if (!String.IsNullOrEmpty(tbDateStart.Text))
            DateStart = Convert.ToDateTime(tbDateStart.Text, Tools.Cinfo());
        else
            DateStart = Convert.ToDateTime(BankDate, Tools.Cinfo());

        if (!String.IsNullOrEmpty(tbDateFinish.Text))
            DateFinish = Convert.ToDateTime(tbDateFinish.Text, Tools.Cinfo());
        else
            DateFinish = Convert.ToDateTime(BankDate, Tools.Cinfo());
        
        string strQuery = @"select r.REQ_ID, r.REQ_CRDATE, r.REQ_BRANCH, r.TRUSTEE_NAME, 
                                   r.TRUSTEE_TYPE_ID, r.TRUSTEE_TYPE_NAME, 
                                   r.REQ_STATE as STATE_CODE, r.STATE_NAME
                              from V_DPT_ACCESS_REQUESTS r
                             where r.REQ_BDATE between :p_date1 and :p_date2
                               and r.REQ_STATE in (-1, 0, 1 ,2)
                             order by r.REQ_CRDATE, r.REQ_ID";

        dsReqArchive.SelectParameters.Add("p_date1", TypeCode.DateTime, DateStart.ToString("dd/MM/yyyy"));
        dsReqArchive.SelectParameters.Add("p_date2", TypeCode.DateTime, DateFinish.ToString("dd/MM/yyyy"));

        dsReqArchive.SelectCommand = strQuery;
        gvReqArchive.DataBind();
    }

    // Перегляд картки запиту
    protected void gvReqArchive_RowCommand(Object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ShowReqParams")
        {
            Random r = new Random();

            String url = string.Format("window.showModalDialog('DptRequestParameters.aspx?req_id={0}&readonly=true&scheme=DELOITTE&code={1}',null,'dialogWidth:1000px; dialogHeight:600px; center:yes; status:no');", e.CommandArgument, r.Next());

            ScriptManager.RegisterClientScriptBlock(this.Page, Page.GetType(), "ShowReqParams", url, true);
        }

    }

    // розмальовуємо табличку
    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            GridView gv = (sender as GridView);

            Int16 StateCode = Convert.ToInt16(gv.DataKeys[e.Row.DataItemIndex]["STATE_CODE"]);

            switch (StateCode)
            {
                case  1:
                    e.Row.ForeColor = System.Drawing.Color.Green;
                    break;

                case -1:
                    e.Row.ForeColor = System.Drawing.Color.Red;
                    break;

                default:
                    e.Row.ForeColor = System.Drawing.Color.BlueViolet;
                    break;
            }
        }
    }
}