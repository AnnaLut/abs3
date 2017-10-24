using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class ussr_deposit_showdoc : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["dpt_id"] == null)
            Response.Redirect("default.aspx");

        FillGrid();
    }
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    private void FillGrid()
    {
        dsDptDocs.ConnectionString = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString();
        //dsDptDocs.PreliminaryStatement = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        dsDptDocs.PreliminaryStatement = "begin " +
            Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
            " begin set_full_access; end; end;";
        
        dsDptDocs.SelectCommand = " select '<A href=# onclick=''ShowDocCard('||REF||')''>'||REF||'</a>' AS REF, " +
            " to_char(datd,'dd/mm/yyyy') DATD, NLS_A, KV_A, to_char(s_a/100,'999999999990.99') S_A, NLS_B, KV_B, to_char(s_b/100,'999999999990.99') S_B, NAZN, SOS, TRANSH_ID, TT " +
            " from v_dpt_documents_ext " +
            " where dpt_id = :dpt_id order by REF ";
        dsDptDocs.SelectParameters.Clear();
        dsDptDocs.SelectParameters.Add("dpt_id", TypeCode.Decimal, Convert.ToString(Request["dpt_id"]));
    }
    protected void gridDocs_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            GridViewRow row = e.Row;
            switch (row.Cells[11].Text)
            {
                case "SSI": row.Style.Add(HtmlTextWriterStyle.BackgroundColor, "#FFFF00"); break;
                default:
                    {
                        switch (row.Cells[9].Text)
                        {
                            case "1": row.Style.Add(HtmlTextWriterStyle.Color, "#008000"); break;
                            case "5": row.Style.Add(HtmlTextWriterStyle.Color, "#000000"); break;
                            case "-1": row.Style.Add(HtmlTextWriterStyle.Color, "#FF0000"); break;
                            case "-2": row.Style.Add(HtmlTextWriterStyle.Color, "#FF0000"); break;
                            case "0": row.Style.Add(HtmlTextWriterStyle.Color, "#008080"); break;
                            case "3": row.Style.Add(HtmlTextWriterStyle.Color, "#0000FF"); break;
                        }
                    }; break;
            }
            if (Convert.ToDecimal(row.Cells[10].Text) < 0)
            {
                row.Style.Add(HtmlTextWriterStyle.Color, "#FF0000");
            }            
        }
    }
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        FillGrid();
    }
}
