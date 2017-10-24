using System;
using System.Data;
using System.Web.UI;
using Bars;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class _Default : BarsPage
{
    protected OracleDataAdapter adapterBranch;
    protected DataSet dsBranch;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["action"] == "close")
        {
            lbTitle.Text = "Закриття технічного рахунку";
            gvTechAccounts.Columns[2].Visible = true;
            gvTechAccounts.Columns[3].Visible = true;
        }
        else if (Request["action"] == "add")
        {
            gvTechAccounts.Columns[2].Visible = false;
            gvTechAccounts.Columns[3].Visible = false;
            lbTitle.Text = "Поповнення технічного рахунку";
        }
        else if (Request["action"] == "pay")
        {
            gvTechAccounts.Columns[2].Visible = false;
            gvTechAccounts.Columns[3].Visible = false;
            lbTitle.Text = "Перерахування коштів з технічного рахунку";
        }

        if (!IsPostBack)
        {
            OracleConnection connect = new OracleConnection();

            try
            {
                IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
                connect = conn.GetUserConnection();
                

                OracleCommand cmdSetRole = connect.CreateCommand();
                cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                cmdSetRole.ExecuteNonQuery();

                adapterBranch = new OracleDataAdapter();
                OracleCommand cmdSelectBranch = connect.CreateCommand();
                cmdSelectBranch.CommandText = "select branch, name from our_branch";
                adapterBranch.SelectCommand = cmdSelectBranch;
                dsBranch = new DataSet();
                adapterBranch.Fill(dsBranch);
                ddBranch.DataSource = dsBranch;
                ddBranch.DataTextField = "name";
                ddBranch.DataValueField = "branch";
                ddBranch.DataBind();

                if (ddBranch.Items.Count < 2)
                    ddBranch.Enabled = false;

                cmdSelectBranch.Dispose();
                adapterBranch.Dispose();
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
        FillGrid();
    }
    /// <summary>
    /// Пошук
    /// </summary>
    protected void btSearch_Click(object sender, ImageClickEventArgs e)
    {
        FillGrid();
    }
    /// <summary>
    /// Наповнення даних
    /// </summary>    
    private void FillGrid()
    {
        String destFunc = String.Empty;
        if (Request["action"] == "close")          destFunc = "ShowOwner";
        else if (Request["action"] == "add")       destFunc = "ShowAdd";
        else if (Request["action"] == "pay")       destFunc = "ShowPay"; 
        else if (Request["action"] == null)        destFunc = "ShowCard";

        dsTechAccounts.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsTechAccounts.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
        String selectCommand = "SELECT '<A href=# onclick=\"" + destFunc +
            "('||TECH_ACCID||','||DPT_ID||','||TECH_CUSTNUM||','''||NVL(to_char(TECH_DAT_END_PLAN),0)||''','''||NVL(to_char(TECH_DAT_END_FACT),0)||''')\">'||TECH_ACCNUM||'</a>' as TECH_ACCNUM, " +
            "TECH_DAT_OPEN AS TECH_DAT_OPEN, " +
            "TO_CHAR(TECH_SALDO/100,'999999999990.99') AS TECH_SALDO, " +
            "TECH_CURRENCY,TECH_CUSTNUM, " +
            "TECH_CUSTOMER,TECH_CUSTID,DPT_ID, DPT_NUM, " +
            "DPT_DAT_BEGIN AS DPT_DAT_BEGIN, " +
            "DPT_DAT_END AS DPT_DAT_END, " +
            "TECH_DAT_END_PLAN AS TECH_DAT_END_PLAN, " +
            "TECH_DAT_END_FACT AS TECH_DAT_END_FACT " +
            "FROM v_dpt_tech_accounts " +
            "WHERE branch_id like '%" + ddBranch.SelectedValue + "%' ";

        dsTechAccounts.SelectParameters.Clear();

        if (textFIO.Text != String.Empty)
        {
            selectCommand += " AND upper(TECH_CUSTOMER) LIKE '%" + textFIO.Text.ToUpper() + "%' ";
        }
        if (textID.Text != String.Empty)
        {
            selectCommand += " AND TECH_CUSTID = :CUST_ID ";
            dsTechAccounts.SelectParameters.Add("CUST_ID", TypeCode.Decimal, textID.Text);
        }
        if (textDptId.Text != String.Empty)
        {
            selectCommand += " AND DPT_NUM = :DPT_NUM ";
            dsTechAccounts.SelectParameters.Add("DPT_NUM", TypeCode.Decimal, textDptId.Text);
        }
        if (textTechNls.Text != String.Empty)
        {
            selectCommand += " AND TECH_ACCNUM LIKE '%" + textTechNls.Text + "%' ";
        }

        dsTechAccounts.SelectCommand = selectCommand;
    }
}
