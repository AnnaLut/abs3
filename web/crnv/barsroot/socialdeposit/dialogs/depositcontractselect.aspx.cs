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
using Oracle.DataAccess.Client;
using Bars.Oracle;
using Bars.Logger;

public partial class DepositContractSelect : Bars.BarsPage
{
    protected System.Data.DataSet dsContract;
    protected Oracle.DataAccess.Client.OracleDataAdapter adapterSearchContract;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Request["dpt_id"] == null)
        {
            Response.Write("<script>alert('Не задано номеру депозита');</script>");
            return;
        }
        _ID.Value = Convert.ToString(Request["dpt_id"]);
        Decimal dpt_id = Convert.ToDecimal(_ID.Value.ToString());
        OracleConnection connect = new OracleConnection();
        try
        {
            // Открываем соединение с БД
            IOraConnection conn = (IOraConnection)this.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = new OracleCommand();
            cmdSetRole.Connection = connect;
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = "select s.name,to_char(c.version,'dd/mm/yyyy'),'<input type=button value=''Перегляд'' onclick=\"Print('''||c.id||''')\">' " +
                "from cc_docs c, doc_scheme s " +
                "where c.nd=:dpt_id and c.adds = 0 and c.id=s.id";
            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            adapterSearchContract = new OracleDataAdapter();
            adapterSearchContract.SelectCommand = cmdSearch;
            adapterSearchContract.Fill(dsContract);

            dsContract.Tables[0].Columns[0].ColumnName = "Найменування";
            dsContract.Tables[0].Columns[1].ColumnName = "Версія";
            dsContract.Tables[0].Columns[2].ColumnName = "*";

            gridContract.DataSource = dsContract;
            gridContract.DataBind();
            gridContract.HeaderStyle.BackColor = Color.Gray;
            gridContract.HeaderStyle.Font.Bold = true;
            gridContract.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
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
        this.dsContract = new System.Data.DataSet();
        ((System.ComponentModel.ISupportInitialize)(this.dsContract)).BeginInit();
        // 
        // dsContract
        // 
        this.dsContract.DataSetName = "NewDataSet";
        this.dsContract.Locale = new System.Globalization.CultureInfo("uk-UA");
        this.Load += new System.EventHandler(this.Page_Load);
        ((System.ComponentModel.ISupportInitialize)(this.dsContract)).EndInit();

    }
    #endregion
    protected void gridContract_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            e.Item.Cells[1].HorizontalAlign = HorizontalAlign.Center;
            e.Item.Cells[2].HorizontalAlign = HorizontalAlign.Center;
        }
    }
}

