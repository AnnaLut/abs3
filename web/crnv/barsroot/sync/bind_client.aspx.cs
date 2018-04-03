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
using ibank.objlayer;
using ibank.core;
using Bars.Classes;
using Bars;

public partial class sync_bind_client : BarsPage
{
    String role_name = "IBANK_ADMIN";
    /// <summary>
    /// Клієнти
    /// </summary>
    private VSyncCustomers _selected_customer;
    private VSyncCustomers selected_customer
    {
        get
        {
            if (_selected_customer == null)
                _selected_customer = new VSyncCustomers(
                    new BbConnection(Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString())
                 );

            return _selected_customer;
        }
    }
    /// <summary>
    /// Клієнти
    /// </summary>
    private VCustIndividualsInfo _customers;
    private VCustIndividualsInfo customers
    {
        get
        {
            if (_customers == null)
                _customers = new VCustIndividualsInfo(
                    new BbConnection(Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString())
                 );

            return _customers;
        }
    }
    /// <summary>
    /// Компанії
    /// </summary>
    private VCustCompaniesInfo _companies;
    private VCustCompaniesInfo companies
    {
        get
        {
            if (_companies == null)
                _companies = new VCustCompaniesInfo(
                    new BbConnection(Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnectionString())
                 );

            return _companies;
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        dsCustomers.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(role_name);

        if (Request["type"] == "3")
        {
            customers.SetupDataComponents(dsCustomers, gridCustomers, SetupModes.Auto, OracleProviders.Pure);
            gridCustomers.DataBind();
            btBack.Attributes["onclick"] = "location.replace('import_clients.aspx');";
        }
        else if (Request["type"] == "2")
        {
            companies.SetupDataComponents(dsCustomers, gridCustomers, SetupModes.Auto, OracleProviders.Pure);
            gridCustomers.DataBind();
            btBack.Attributes["onclick"] = "location.replace('import_corps.aspx');";
        }

        selected_customer.Filter.CUST_RNK.Equal(Convert.ToDecimal(Request["rnk"]));
        dsSelectedClient.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand(role_name);
        selected_customer.SetupDataComponents(dsSelectedClient, gvSelectedClient, SetupModes.Auto, OracleProviders.Pure);
        gvSelectedClient.DataBind();
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btBind_Click(object sender, EventArgs e)
    {
        if (gridCustomers.SelectedRows.Count > 0)
        {
            InitOraConnection();
            try
            {
                SetRole(role_name);
                SetParameters("kf", DB_TYPE.Varchar2, Convert.ToString(Request["kf"]), DIRECTION.Input);
                SetParameters("rnk", DB_TYPE.Decimal, Convert.ToDecimal(Request["rnk"]), DIRECTION.Input);
                SetParameters("cust_id", DB_TYPE.Decimal, Convert.ToDecimal(
                    gridCustomers.Rows[gridCustomers.SelectedRows[0]].Cells[1].Text), DIRECTION.InputOutput);

                if (Request["type"] == "3")
                    SQL_NONQUERY("begin barsaq.data_import.add_individual_aux(:kf,:rnk,:cust_id); end;");
                else if (Request["type"] == "2")
                    SQL_NONQUERY("begin barsaq.data_import.add_company_aux(:kf,:rnk,:cust_id); end;");

                string msg = "alert('Клієнт " + Convert.ToString(Request["rnk"]) + " успішно привязаний до клієнта " +
                    gridCustomers.Rows[gridCustomers.SelectedRows[0]].Cells[1].Text + " ');";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "export_all_accounts", msg, true);
            }
            finally
            {
                DisposeOraConnection();
            }
        }
        else
        {
            string msg = "alert('Не вибрано жодне значення');";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "bind_not_selected", msg, true); 
        }
    }
}
