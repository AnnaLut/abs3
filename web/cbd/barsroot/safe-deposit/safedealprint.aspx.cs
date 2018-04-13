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
using Bars.Classes;

public partial class safe_deposit_safedealprint : System.Web.UI.Page
{
    private int row_counter = 0;
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["nd"] == null || Request["safe_id"] == null)
            Response.Redirect("safeportfolio.aspx");

        deal_id.Value = Convert.ToString(Request["nd"]);
        RegisterClientScript();

        if (!IsPostBack)
        {
            lbTitle.Text = lbTitle.Text.Replace("%s", 
                safe_deposit.GetNumById(Convert.ToDecimal(Convert.ToString(Request["safe_id"]))));
            lbTitle.Text = lbTitle.Text.Replace("%d", Convert.ToString(Request["nd"]));
            FillGrid();
        }
        else
        {
            if (!String.IsNullOrEmpty(insert.Value))
            {
                safe_deposit sdpt = new safe_deposit();
                sdpt.InsertNewDoc(Convert.ToDecimal(deal_id.Value),
                    template.Value);

                insert.Value = String.Empty;
                template.Value = String.Empty;

                FillGrid();
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sourceControl"></param>
    /// <param name="eventArgument"></param>
    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        if (sourceControl.GetType().Name == "BarsGridView" || (eventArgument != null && eventArgument.Length > 4 && eventArgument.Substring(0, eventArgument.IndexOf("$")) == "Bars"))
        { FillGrid(); }

        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
    /// <summary>
    /// 
    /// </summary>
    private void FillGrid()
    {
        dsDeals.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsDeals.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN,BASIC_INFO");
        dsDeals.SelectParameters.Clear();

        String selectCommand = "SELECT '<A href=# onclick=\"ShowDoc('''||D.ID||''','||D.ND||','||D.ADDS||')\">Просмотр</a>' AS T, " +
            "D.ID ID, S.NAME NAME, D.ADDS ADDS, " +
            "D.VERSION VERSION, decode(D.STATE,1,'ні',2,'так') STATE, " +
            "u.fio FIO, D.COMM COMM " +
            " FROM CC_DOCS D, DOC_SCHEME S, staff u " +
            " WHERE D.ID=S.ID AND D.ND=:ND " +  
            "   AND d.doneby=u.logname(+) " +
            " ORDER BY D.VERSION, S.NAME";

        dsDeals.SelectParameters.Add("ND", TypeCode.Decimal, Convert.ToString(Request["nd"]));

        dsDeals.SelectCommand = selectCommand;
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btRefresh_Click(object sender, EventArgs e)
    {
        FillGrid();
    }
    /// <summary>
    /// Клієнтський скріпт, який
    /// при виборі рядка таблиці
    /// виділяє його кольором
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id,adds,template)
			{
			 if(selectedRow != null) selectedRow.style.backgroundColor = '';
             document.getElementById('r_'+id).style.backgroundColor = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);

			 document.getElementById('adds').value = adds;
             document.getElementById('template').value = template;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script_A", script);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void gridDocs_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
            e.Row.Cells[1].Visible = false;
        else if (e != null && e.Row.RowType == DataControlRowType.DataRow)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            GridViewRow row = e.Row;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter + "','" +
                row.Cells[3].Text + "','" + row.Cells[1].Text + "')");

            e.Row.Cells[1].Visible = false;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void btSign_Click(object sender, EventArgs e)
    {
        safe_deposit sdpt = new safe_deposit();
        sdpt.SignDoc(Convert.ToDecimal(deal_id.Value),
            Convert.ToDecimal(adds.Value),
            template.Value);

        FillGrid();

        template.Value = String.Empty;
        adds.Value = String.Empty;
    }
}
