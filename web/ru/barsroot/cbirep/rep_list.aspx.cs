using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Xml;

using Bars.ObjLayer.CbiRep;
using Bars.Classes;
using Bars.UserControls;

using ibank.core;

public partial class cbirep_rep_list : Bars.BarsPage
{
    # region Приватные свойства
    # endregion

    # region События
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ApplyFilterMemory();
        }
    }
    protected void gvVCbirepReplist_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Query":
                Decimal RepID = Convert.ToDecimal(e.CommandArgument);
                Response.Redirect("rep_query.aspx?repid=" + RepID.ToString());
                break;
        }
    }
    protected void gvVCbirepRepresults_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            VCbirepRepresultsRecord rec = (e.Row.DataItem as VCbirepRepresultsRecord);

            // разукрашиваем
            switch (rec.STATUS_ID)
            {
                case "DONE":
                    e.Row.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#C8FFC8");
                    break;
                case "ERROR":
                    e.Row.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#FFC8C8");
                    break;
                case "PRINTED":
                    e.Row.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#C8C8FF");
                    break;
            }

            // параметры
            String Res = String.Empty;

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(rec.XML_PARAMS);

            foreach (XmlNode param in doc.GetElementsByTagName("Param"))
                Res += (String.IsNullOrEmpty(Res) ? "" : ",") + param.Attributes["Value"].Value;

            Label lbParams = (e.Row.FindControl("lbParams") as Label);
            lbParams.Text = Res.Substring(0, (Res.Length > 30 ? 30 : Res.Length)) + (Res.Length > 30 ? "..." : "");
            lbParams.ToolTip = Res;
        }
    }
    protected void gvVCbirepRepresults_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Clear":
                Decimal QUERY_ID = Convert.ToDecimal(e.CommandArgument);
                Rs rs = new Rs(new BbConnection());

                rs.CLEAR_REPORT_QUERY(QUERY_ID);
                gvVCbirepRepresults.DataBind();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert_clear_success", "alert('Дані успішно видалено')", true);

                break;
            case "Print":
                QUERY_ID = Convert.ToDecimal(e.CommandArgument);

                Response.Redirect(String.Format("rep_print.aspx?query_id={0}", QUERY_ID));

                break;
        }
    }
    protected void btApplySearch_Click(object sender, EventArgs e)
    {
        SetFilterMemory();
        gvVCbirepReplist.DataBind();
    }
    protected void tVCbirepRepresults_Tick(object sender, EventArgs e)
    {
        gvVCbirepRepresults.DataBind();
    }
    # endregion

    # region Приватные методы
    private void SetFilterMemory()
    {
        Session["CBIREP_REP_LIST.FILTER.REPDESC"] = tbRepDesc.Value;
        Session["CBIREP_REP_LIST.FILTER.REPID"] = tbSearchRepID.Value;
        Session["CBIREP_REP_LIST.FILTER.REPFOLDER"] = ddlSearchRepfolders.SelectedValue;
    }
    private void ApplyFilterMemory()
    {
        tbRepDesc.Value = (String)Session["CBIREP_REP_LIST.FILTER.REPDESC"];
        tbSearchRepID.Value = (Decimal?)Session["CBIREP_REP_LIST.FILTER.REPID"];
        ddlSearchRepfolders.SelectedValue = (String)Session["CBIREP_REP_LIST.FILTER.REPFOLDER"];
    }
    # endregion
}
