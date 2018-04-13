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
using Bars.Oracle;
using Bars.Logger;
using Oracle.DataAccess.Client;
using Bars.Exception;
using Bars.Classes;

/// <summary>
/// Summary description for DepositCancelAgreement.
/// </summary>
public partial class DepositCancelAgreement : Bars.BarsPage
{
    private OracleDataAdapter adapterSearchAgreement;
    protected System.Data.DataSet dsAgreement;
    private int row_counter = 0;
    private void Page_Load(object sender, System.EventArgs e)
    {
        Page.Header.Title = Resources.Deposit.GlobalResources.hDepositCancelAgreement;
        OracleConnection connect = new OracleConnection();

        try
        {
            if (Request["dpt_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

            if (Request["agr_id"] == null)
                Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

            //if (Request["template"] == null)
            //    Response.Redirect("DepositSearch.aspx?action=agreement&extended=0");

            RegisterClientScript();

            Decimal dpt_id_v = Convert.ToDecimal(Request["dpt_id"]);
            Decimal agr_id_v = Convert.ToDecimal(Request["agr_id"]);
            //String template_id = Convert.ToString(Request["template"]);

            dpt_id.Value = dpt_id_v.ToString();
            agr_id.Value = agr_id_v.ToString();
            // template.Value = template_id;

            btCancel.Attributes["onclick"] = "javascript:if (rnk_ck())";

            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();

            cmdSearch.CommandText = @"select AGRMNT_NUM as adds, AGRMNT_DATE as version, AGRMNT_TYPE as agr_id,
                AGRMNT_TYPENAME as agr_name, TEMPLATE_ID as template, TRUSTEE_ID as rnk_tr, 
                TRUSTEE_NAME as nmk, COMMENTS as comm, TRUST_ID
                from v_dpt_agreements
                where DPT_ID = :dpt_id and AGRMNT_TYPE = :agr_id and agrmnt_state = 1
                order by AGRMNT_NUM desc";

            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id_v, ParameterDirection.Input);
            cmdSearch.Parameters.Add("agr_id", OracleDbType.Decimal, agr_id_v - 1, ParameterDirection.Input);

            adapterSearchAgreement = new OracleDataAdapter();
            adapterSearchAgreement.SelectCommand = cmdSearch;
            adapterSearchAgreement.Fill(dsAgreement);

            gridAgreement.DataSource = dsAgreement;
            gridAgreement.DataBind();

            gridAgreement.HeaderStyle.BackColor = Color.Gray;
            gridAgreement.HeaderStyle.Font.Bold = true;
            gridAgreement.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Локализация грида
    /// </summary>
    protected override void OnPreRender(EventArgs evt)
    {
        // Локализируем грид
        if (gridAgreement.Controls.Count > 0)
        {
            Table tb = gridAgreement.Controls[0] as Table;
            tb.Rows[0].Cells[1].Text = Resources.Deposit.GlobalResources.tb65;
            tb.Rows[0].Cells[3].Text = Resources.Deposit.GlobalResources.tb66;
            tb.Rows[0].Cells[6].Text = Resources.Deposit.GlobalResources.tb67;
            tb.Rows[0].Cells[7].Text = Resources.Deposit.GlobalResources.tb68;
        }
    }
    /// <summary>
    /// Клієнтський скріпт, який при виборі рядка таблиці виділяє його кольором
    /// </summary>
    private void RegisterClientScript()
    {
        string script = @"<script language='javascript'>
			var selectedRow;
			function S_A(id,val,TRUST_ID)
			{
			 if(selectedRow != null) selectedRow.style.background = '';
			 document.getElementById('r_'+id).style.background = '#d3d3d3';
			 selectedRow = document.getElementById('r_'+id);
			 document.getElementById('rnk').value = val;
             document.getElementById('TRUST_ID').value = TRUST_ID;
			}
			</script>";
        ClientScript.RegisterStartupScript(this.GetType(), ID + "Script", script);
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
        this.dsAgreement = new System.Data.DataSet();
        ((System.ComponentModel.ISupportInitialize)(this.dsAgreement)).BeginInit();
        this.gridAgreement.ItemDataBound += new System.Web.UI.WebControls.DataGridItemEventHandler(this.gridAgreement_ItemDataBound);
        this.btCancel.ServerClick += new System.EventHandler(this.btCancel_ServerClick);
        // 
        // dsAgreement
        // 
        this.dsAgreement.DataSetName = "NewDataSet";
        this.dsAgreement.Locale = new System.Globalization.CultureInfo("uk-UA");
        ;
        ((System.ComponentModel.ISupportInitialize)(this.dsAgreement)).EndInit();

    }
    #endregion
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void gridAgreement_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            row_counter++;
            string row_id = "r_" + row_counter.ToString();
            DataGridItem row = e.Item;
            row.Attributes.Add("id", row_id);
            row.Attributes.Add("onclick", "S_A('" + row_counter +
                "','" + row.Cells[5].Text + "','" + row.Cells[8].Text + "')");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void btCancel_ServerClick(object sender, System.EventArgs e)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            Decimal agr_id = Convert.ToDecimal(Request["agr_id"]);
            Decimal dpt_id = Convert.ToDecimal(Request["dpt_id"]);
            String rnkstr = Convert.ToString(rnk.Value);
            String id_trust = Convert.ToString(TRUST_ID.Value);

            DBLogger.Info("Пользователь выбрал для отмены доп. соглашение тип=" + agr_id
                + " ,номер депозитного договора =" + dpt_id
                + " ,рнк 3 лица=" + rnkstr,
                "deposit");

            String dest = "DepositAgreementPrint.aspx?dpt_id=" + Convert.ToString(dpt_id) +
                "&agr_id=" + Convert.ToString(agr_id) +
                // "&template=" + Convert.ToString(Request["template"]) +
                "&rnk=" + rnkstr +
                "&idtr=" + id_trust;
            
            if (Request["scheme"] != null)
                dest += "&scheme=" + Request.QueryString["scheme"];

            OracleCommand cmd = connect.CreateCommand();
            cmd.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmd.ExecuteNonQuery();

            cmd.CommandText = "select nvl(main_tt,'') from dpt_vidd_flags where id=:agr_id";
            cmd.Parameters.Add("agr_id", OracleDbType.Decimal, Convert.ToDecimal(agr_id), ParameterDirection.Input);

            String TT = Convert.ToString(cmd.ExecuteScalar());

            if (TT != String.Empty && String.IsNullOrEmpty(Convert.ToString(Session["NO_COMISSION"])))
            {
                cmd.Parameters.Clear();
                cmd.CommandText = "select s.nls, s.kv from dpt_deposit d, saldo s where d.deposit_id = :dpt_id and d.acc = s.acc";
                cmd.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

                OracleDataReader rdr = cmd.ExecuteReader();

                if (!rdr.Read())
                    throw new DepositException("Депозитний договір №" + Convert.ToString(dpt_id) + " не знайдено!");

                String nls = Convert.ToString(rdr.GetOracleString(0).Value);
                Decimal kv = Convert.ToDecimal(rdr.GetOracleDecimal(1).Value);

                if (!rdr.IsClosed)
                    rdr.Close();

                Decimal cl_id;
                if (Request["rnk_tr"] != null)
                    cl_id = Convert.ToDecimal(Convert.ToString(Request["rnk_tr"]));
                else
                {
                    Deposit dpt_dop = new Deposit(dpt_id);
                    cl_id = dpt_dop.Client.ID;
                }

                Random r = new Random();
                String dop_rec = "&RNK=" + Convert.ToString(cl_id) +
                    "&Code=" + Convert.ToString(r.Next());

                string url = "\"/barsroot/DocInput/DocInput.aspx?tt=" + TT + "&nd=" +
                    Convert.ToString(dpt_id) + "&SumC_t=1&APROC=" + 
                    OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE") +
                    "@" + "begin dpt_web.fill_dpt_payments(" + dpt_id + ",:REF);end;";

                string script = "<script>window.showModalDialog(encodeURI(" + url + dop_rec + "\"" + "),null," +
                    "'dialogWidth:700px; dialogHeight:800px; center:yes; status:no');";

                script += "location.replace('" + dest + "');";

                script += "</script>";
                Response.Write(script);
                Response.Flush();
                return;
            }
            else
            {
                String script = "<script>location.replace('" + dest + "');";

                script += "</script>";
                Response.Write(script);
                Response.Flush();
                return;
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
}
