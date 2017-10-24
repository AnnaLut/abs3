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
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Configuration;
using WebChart;

public partial class UCAgeAnalysis : BarsWebPart
{
    private string sNBS = "";
    string sRole = "WR_AGEANALYSIS";

    public UCAgeAnalysis()
    {
        this.Title = "Анализ по срокам";
        this.Description = "Графическое отображение анализа по срокам";
    }
    protected void Page_Load(object sender, EventArgs e) 
    {
        if (IsPostBack)
        {
            if (!string.IsNullOrEmpty(lbNBS.SelectedValue))
                sNBS = lbNBS.SelectedValue.Trim().Substring(0, lbNBS.SelectedValue.Trim().Length - 1);
        }
    }
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);


        OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand com = new OracleCommand("select 'Empty Command' from dual", con);
        OracleDataAdapter adp = new OracleDataAdapter(com);
        DataTable dtData = new DataTable(), dtTmpData = new DataTable(), dtKV = new DataTable(), dtNBSs = new DataTable();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sRole);
            com.ExecuteNonQuery();

            if (!IsPostBack)
            {
                // Валюты
                com.Parameters.Clear();
                com.CommandText = @"select KV as ID, KV || ' - ' || LCV as NAME from TABVAL order by KV";
                adp.Fill(dtKV);

                ddlKV.DataSource = dtKV;
                ddlKV.DataValueField = "ID";
                ddlKV.DataTextField = "NAME";
                ddlKV.DataBind();
                ddlKV.Items.Insert(0, new ListItem("Все", "0"));
                ddlKV.SelectedIndex = 0;
            }

            // Балансовые счета
            com.Parameters.Clear();
            com.Parameters.Add(":pnbs", OracleDbType.Varchar2, (sNBS.Length == 4) ? (sNBS.Substring(0, 3)) : (sNBS), ParameterDirection.Input);
            com.Parameters.Add(":pnbsl", OracleDbType.Int32, ((sNBS.Length == 4) ? (sNBS.Substring(0, 3)) : (sNBS)).Length + 1, ParameterDirection.Input);
            com.CommandText = @"select NBS as ID, NBS || ' - ' || NAME as NAME from PS where NBS like :pnbs || '%' and length(trim(NBS)) = :pnbsl";
            dtNBSs.Clear();
            adp.Fill(dtNBSs);
        }
        finally
        {
            con.Close();
        }

        // Балансовые счета
        lbNBS.DataSource = dtNBSs;
        lbNBS.DataValueField = "ID";
        lbNBS.DataTextField = "NAME";
        lbNBS.DataBind();
        if (dtNBSs.Rows.Count > 0) lbNBS.SelectedIndex = 0;

        if (!IsPostBack)
        {
            btGraph_Click(null, null);
        }
    }
    protected void btFrw_Click(object sender, EventArgs e)
    {
        sNBS = lbNBS.SelectedValue.Trim();
        lbNBSNo.Text = sNBS;
        lbNBSNo.Text = lbNBSNo.Text.PadRight(4, '*');

        btBck.Enabled = true;
    }
    protected void btBck_Click(object sender, EventArgs e)
    {
        if (lbNBS.SelectedValue.Trim().Length == 1) sNBS = "";
        else sNBS = lbNBS.SelectedValue.Trim().Substring(0, lbNBS.SelectedValue.Trim().Length - 2);
        lbNBSNo.Text = (sNBS == "") ? ("Все") : (sNBS);
        lbNBSNo.Text = lbNBSNo.Text.PadRight(4, '*');

        if (sNBS.Length == 0) btBck.Enabled = false;
    }
    protected void btGraph_Click(object sender, EventArgs e)
    {
        mvMain.ActiveViewIndex = 1;

        OracleConnection con = Bars.Classes.OraConnector.Handler.UserConnection;
        OracleCommand com = new OracleCommand("select 'Empty Command' from dual", con);
        OracleDataAdapter adp = new OracleDataAdapter(com);
        DataTable dtData = new DataTable(), dtTmpData = new DataTable(), dtKV = new DataTable(), dtNBSs = new DataTable();

        if (con.State != ConnectionState.Open) con.Open();
        try
        {
            com.CommandText = Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand(sRole);
            com.ExecuteNonQuery();

            com.Parameters.Clear();
            com.Parameters.Add(":ppap", OracleDbType.Varchar2, rblPAP.SelectedValue, ParameterDirection.Input);
            com.Parameters.Add(":pkv", OracleDbType.Int32, Convert.ToInt32(ddlKV.SelectedValue), ParameterDirection.Input);
            com.Parameters.Add(":ptkv", OracleDbType.Int32, Convert.ToInt32(ddlKV.SelectedValue), ParameterDirection.Input);
            com.Parameters.Add(":pnbs", OracleDbType.Varchar2, sNBS, ParameterDirection.Input);
            com.CommandText = @"select Sum(G01)/100 G01, Sum(G02)/100 G02, Sum(G03)/100 G03, Sum(G04)/100 G04,
                                    Sum(G05)/100 G05, Sum(G06)/100 G06, Sum(G07)/100 G07, Sum(G0A)/100 G0A,
                                    Sum(G0B)/100 G0B, Sum(G0C)/100 G0C, Sum(G0D)/100 G0D, Sum(G0E)/100 G0E,
                                    Sum(G0F)/100 G0F, Sum(G0G)/100 G0G, Sum(G0H)/100 G0H, Sum(G00)/100 G00
                                from V_AGEANALYSIS
                                where PAP = :ppap and decode(:pkv, 0, KV, :ptkv) = KV and NLS like :pnbs||'%'";
            adp.Fill(dtData);
        }
        finally
        {
            con.Close();
        }

        // Преобразование данных
        string[] aHeaders = { "G01", "G02", "G03", "G04", "G05", "G06", "G07", "G0A", "G0B", "G0C", "G0D", "G0E", "G0F", "G0G", "G0H" };
        string[] aHeadersText = { "До востр.", "Овернайт", "2-7 дн.", "8-21 дн.", "22-31 дн.", "32-92 дн.", "93-183 дн.", "184-274 дн.", "275-365 дн.", "1-1.5 г.", "1.5-2 г.", "2-3 г.", "3-5 л.", "5-10 л.", "более 10 л." };

        if (dtData.Rows[0]["G00"] != DBNull.Value)
        {
            dtTmpData.Columns.Add("ID", typeof(string));
            dtTmpData.Columns.Add("VAL", typeof(decimal));

            for (int i = 0; i < aHeaders.Length; i++)
            {
                DataRow row = dtTmpData.NewRow();
                row["ID"] = aHeadersText[i];
                row["VAL"] = Convert.ToDecimal(dtData.Rows[0][aHeaders[i]]);
                dtTmpData.Rows.Add(row);
            }
        }

        // Отбрасываем минимальные
        decimal dGSum = 0;
        for (int i = 0; i < dtTmpData.Rows.Count; i++) dGSum += Convert.ToDecimal(dtTmpData.Rows[i]["VAL"]);

        if (dGSum > 0)
        {
            DataRow rOthers = dtTmpData.NewRow();
            rOthers["ID"] = "Другие";
            rOthers["VAL"] = 0;

            for (int i = 0; i < dtTmpData.Rows.Count; i++)
            {
                if (Convert.ToDecimal(dtTmpData.Rows[i]["VAL"]) == 0)
                {
                    dtTmpData.Rows.RemoveAt(i);
                    i--;
                }
                else if (Convert.ToDecimal(dtTmpData.Rows[i]["VAL"]) / dGSum < (decimal)0.02)
                {
                    rOthers["VAL"] = Convert.ToDecimal(rOthers["VAL"]) + Convert.ToDecimal(dtTmpData.Rows[i]["VAL"]);
                    dtTmpData.Rows.RemoveAt(i);
                    i--;
                }
            }

            if (Convert.ToDecimal(rOthers["VAL"]) > 0 && Convert.ToDecimal(rOthers["VAL"]) / dGSum > (decimal)0.05) dtTmpData.Rows.Add(rOthers);
        }

        PieChart chart = (PieChart)chrtData.Charts.FindChart("MainChart");
        chart.Legend = "ID";
        chart.DataSource = dtTmpData.DefaultView;
        chart.DataXValueField = "ID";
        chart.DataYValueField = "VAL";
        chart.DataBind();
        chrtData.RedrawChart();
    }
    protected void btBack_Click(object sender, EventArgs e)
    {
        mvMain.ActiveViewIndex = 0;
    }
    
}
