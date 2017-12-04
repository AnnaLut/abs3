using Oracle.DataAccess.Client;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class pcur_reqinfo : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["PCUR_RNK"] = null;
            gv.DataBind();
            pnButtons.Visible = false;
            dvGridTitle.Visible = false;
            gv.Visible = false;
        }
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btFind_Click(object sender, EventArgs e)
    {
        decimal? pRnk = null;
        decimal? pReqId = null;

        if (!String.IsNullOrEmpty(tbRnk.Text))
        {
            pRnk = Convert.ToDecimal(tbRnk.Text);
        }
        if (!String.IsNullOrEmpty(tbReqlId.Text))
        {
            pReqId = Convert.ToDecimal(tbReqlId.Text);
        }
        string pInn = tbInn.Text;

        if (pRnk == null && pReqId == null && string.IsNullOrWhiteSpace(pInn))
        {
            return;
        }

        DataTable dt = new DataTable();
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = CommandType.Text;
        const string sqlTemplate = @"select pr.id,
                 pcd.rnk,
                 pcd.fio,
                 pcd.bdate,
                 pcd.inn,
                 dt.name as doc_type_name,
                 prs.name as state_name,
                 prs.ord
            from pir_requests pr
                 left join pir_req_clients_data pcd on pr.id = pcd.req_id
                 left join passp dt on pcd.doc_type = dt.passp
                 left join pir_req_states prs on prs.id = pr.state_id
            where {0}
            order by prs.ord";

        string whereSql = "";
        if (pReqId != null)
        {
            whereSql = "pr.id = :reqId";
            cmd.Parameters.Add("reqId", pReqId);
        }
        if (pRnk != null)
        {
            if (!string.IsNullOrWhiteSpace(whereSql))
            {
                whereSql += " and ";
            }
            whereSql = "pcd.rnk like '%' || :rnk || '%'";
            cmd.Parameters.Add("rnk", pRnk);
        }
        if (!string.IsNullOrEmpty(pInn))
        {
            if (!string.IsNullOrWhiteSpace(whereSql))
            {
                whereSql += " and ";
            }
            whereSql += "pcd.inn like '%' || :inn || '%'";
            cmd.Parameters.Add("inn", pInn);
        }

        cmd.CommandText = string.Format(sqlTemplate, whereSql);
        OracleDataAdapter adapter = new OracleDataAdapter {SelectCommand = cmd};
        adapter.Fill(dt);
        
        if (dt.Rows.Count > 0)
        {
            pnButtons.Visible = true;
            dvGridTitle.Visible = true;
            gv.Visible = true;

            gv.DataSource = dt;
            gv.DataBind();
        }
        else
        {
            pnButtons.Visible = false;
            dvGridTitle.Visible = false;
            gv.Visible = false;
        }

    }
    protected void btNext_Click(object sender, EventArgs e)
    {
        if (gv.SelectedRows.Count != 0)
        {
            string reqId= gv.DataKeys[gv.SelectedRows[0]]["ID"].ToString();

            Session["PCUR_REQID"] = reqId;

            Response.Redirect("/barsroot/pir/reqdetails.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Не вибрано жодної заявки');", true);
        }
    }
}
