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
using ibank.core;
using ibank.objlayer;
using System.Collections.Generic;
using System.Web.Configuration;
using Oracle.DataAccess.Types;
using Bars;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Bars.Oracle;

public partial class admin_sync_import_corps : BarsPage
{
    String role_name = "IBANK_ADMIN";
    /// <summary>
    /// Клієнти
    /// </summary>
    private VSyncCustomers _customers;
    private VSyncCustomers customers
    {
        get
        {
            if (_customers == null)
                _customers = new VSyncCustomers(
                    new BbConnection(Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString())
                 );

            return _customers;
        }
    }
    /// <summary>
    /// Рахунки
    /// </summary>
    private VSyncAccounts _accounts;
    private VSyncAccounts accounts
    {
        get
        {
            if (_accounts == null)
                _accounts = new VSyncAccounts(
                    new BbConnection(Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString())
                 );

            return _accounts;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session[Constant.StateKeys.SYNC_SELECTED_RNK] = null;
            Session[Constant.StateKeys.SYNC_SELECTED_KF] = null;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreRender(EventArgs e)
    {
        dsCustomers.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsCustomers.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(role_name);

        dsCustomers.SelectCommand = @"select KF,CUST_RNK,CUST_ID,NAME,CUST_CODE,ADDRESS,DATE_ON,LEGAL_NAME,CHIEF_NAME,CHIEF_PHONE,BOOKKEEPER_NAME,BOOKKEEPER_PHONE,BRANCH_CODE,BRANCH_NAME,IMPORTED 
                                    from barsaq.v_sync_customers where cust_type_id = 2";

        gvCustomers.DataBind();

        dsAccounts.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        dsAccounts.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(role_name);

        dsAccounts.SelectCommand = @"select CUST_ID,ACC,ACC_ID,ACC_NUM,NAME,CUR_CODE,OPENED,LAST_MOVEMENT,CLOSED,BALANCE,DEBIT_TURNS,CREDIT_TURNS,EXEC_NAME,BRANCH_ID,BRANCH_NAME,IMPORTED 
                                    from barsaq.v_sync_accounts where cust_id = :cust_id";

        // Якщо відфільтрували рахунки
        if (Session[Constant.StateKeys.SYNC_SELECTED_RNK] != null)
        {
            String rnk = Convert.ToString(Session[Constant.StateKeys.SYNC_SELECTED_RNK]);

            dsAccounts.SelectParameters.Clear();
            dsAccounts.SelectParameters.Add("cust_id", DbType.Decimal, rnk);
        }
        else
        {
            dsAccounts.SelectParameters.Clear();
            dsAccounts.SelectParameters.Add("cust_id", DbType.Decimal, "-1");
        }

        gvAccounts.DataBind();

        base.OnPreRender(e);
    }
    /// <summary>
    /// 
    /// </summary>
    protected void gvCustomers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "GET_ACCOUNTS")
        {
            String[] obj = e.CommandArgument.ToString().Split(':');

            Session[Constant.StateKeys.SYNC_SELECTED_RNK] = obj[0];
            Session[Constant.StateKeys.SYNC_SELECTED_KF] = obj[1];

            lbAccounts.Text = "Рахунки клієнта " + obj[0];
            btExportAll.Enabled = true;
            btExportSelected.Enabled = true;
        }
        else if (e.CommandName == "IMPORT_CLIENT")
        {
            if (String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            String[] obj = e.CommandArgument.ToString().Split(':');

            int rnk = Convert.ToInt32(obj[0]);
            string kf = obj[1];

            InitOraConnection();
            try
            {
                SetRole(role_name);
                SetParameters("kf", DB_TYPE.Varchar2, kf, DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Decimal, rnk, DIRECTION.Input);
                SQL_NONQUERY("begin barsaq.data_import.add_company(:kf,:rnk); end;");

                string msg = "alert('Клієнт " + Convert.ToString(rnk) + " успішно експортований');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "export_client_corp", msg, true); 
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else if (e.CommandName == "BIND_CLIENT")
        {
            String[] obj = e.CommandArgument.ToString().Split(':');

            Response.Redirect("bind_client.aspx?rnk=" + obj[0] + "&kf=" + obj[1] + "&type=2");
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvAccounts_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "IMPORT_ACCOUNT")
        {
            if (String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            int acc = Convert.ToInt32(Convert.ToString(e.CommandArgument));

            InitOraConnection();
            try
            {
                SetRole(role_name);
                SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                SQL_NONQUERY("begin barsaq.data_import.add_account_and_sync(:acc); end;");

                string msg = "alert('Рахунок " + Convert.ToString(acc) + " успішно експортований');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "export_account_corp", msg, true); 
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else if (e.CommandName == "SYNC_ACCOUNT")
        {
            if (String.IsNullOrEmpty(Convert.ToString(e.CommandArgument)))
                return;

            int acc = Convert.ToInt32(Convert.ToString(e.CommandArgument));

            InitOraConnection();
            try
            {
                SetRole(role_name);
                SetParameters("acc", DB_TYPE.Decimal, acc, DIRECTION.Input);
                SetParameters("p_startdate", DB_TYPE.Date, start_date.SelectedDate, DIRECTION.Input);
                SQL_NONQUERY("begin barsaq.data_import.job_sync_account_stmt(:acc,:p_startdate); end;");

                string msg = "alert('Синхронізація виписки по рахуноку " + Convert.ToString(acc) + " розпочата');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "sync_account", msg, true);
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btExportAll_Click(object sender, EventArgs e)
    {
        if (Session[Constant.StateKeys.SYNC_SELECTED_RNK] != null)
        {
            InitOraConnection();
            try
            {
                SetRole(role_name);
                SetParameters("kf", DB_TYPE.Varchar2, Convert.ToString(Session[Constant.StateKeys.SYNC_SELECTED_KF]), DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Decimal, Convert.ToDecimal(Session[Constant.StateKeys.SYNC_SELECTED_RNK]), DIRECTION.Input);
                SQL_NONQUERY("begin barsaq.data_import.import_cust_accounts_and_sync(:kf,:rnk); end;");

                string msg = "alert('Всі доступні рахуноки клієнта " + Convert.ToString(Session[Constant.StateKeys.SYNC_SELECTED_RNK]) + " успішно експортовано');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "export_all_accounts_corp", msg, true);
            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btSync_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
            SetRole(role_name);
            SetParameters("p_startdate", DB_TYPE.Date, start_date.SelectedDate, DIRECTION.Input);
            SQL_NONQUERY("begin barsaq.data_import.job_sync_all_account_stmt(:p_startdate); end;");

            string msg = "alert('Синхронізація виписка по всіх рахуноках розпочата');";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "sync_all_accounts_corp", msg, true);
        }
        finally
        {
            DisposeOraConnection();
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btExportSelected_Click(object sender, EventArgs e)
    {
        if (gvAccounts.SelectedRows.Count > 0)
        {
            int delta = 0;
            if (gvAccounts.ShowFilter) delta += 1;

            Decimal[] acc_array = new Decimal[gvAccounts.SelectedRows.Count];
            for (int i = 0; i < gvAccounts.SelectedRows.Count; i++)
            {
                try
                {
                    acc_array[i] = Convert.ToDecimal(gvAccounts.Rows[gvAccounts.SelectedRows[i] + delta].Cells[3].Text);
                }
                catch (InvalidCastException) { }
            }

            OracleConnection connect = new OracleConnection();
            try
            {
                IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
                connect = conn.GetUserConnection();

                OracleCommand cmd = connect.CreateCommand();
                cmd.CommandText = conn.GetSetRoleCommand(role_name);
                cmd.ExecuteNonQuery();

                cmd.CommandText = "begin barsaq.data_import.add_account_and_sync_group(:acc); end;";

                cmd.Parameters.Clear();
                cmd.BindByName = true;

                OracleParameter acc = cmd.Parameters.Add("acc", OracleDbType.Decimal);
                acc.Direction = ParameterDirection.Input;
                acc.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                acc.Value = acc_array;
                acc.Size = acc_array.Length;

                cmd.ExecuteNonQuery();

                string msg = "alert('Вибрані рахунки успішно експортовані');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "export_selected_accounts", msg, true);
            }
            finally
            {
                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
    }
}
