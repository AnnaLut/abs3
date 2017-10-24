using System;
using System.Data;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Bars.Exception;

public partial class DocumentPrint : Page
{
    protected DataSet dsContract;
    protected OracleDataAdapter adapterSearchContract;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["dpt_id"] == null)
            throw new TechAccountsException("Сторінка викликана з некоректними параметрами!");

        _ID.Value = Convert.ToString(Request["dpt_id"]);
        Decimal dpt_id = Convert.ToDecimal(_ID.Value.ToString());
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = "select '<A href=# onclick=\"print_tech_agr('''||c.id||''')\">Друк</a>',s.name,to_char(c.version,'dd/mm/yyyy') " +
                "FROM CC_DOCS c, DOC_SCHEME s, v_techacctemplates t " +
                "WHERE c.nd=:dpt_id AND c.id = t.id AND c.adds = 0 AND c.id=s.id";
            cmdSearch.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);

            dsContract = new DataSet();
            adapterSearchContract = new OracleDataAdapter();
            adapterSearchContract.SelectCommand = cmdSearch;
            adapterSearchContract.Fill(dsContract);

            dsContract.Tables[0].Columns[0].ColumnName = "*";
            dsContract.Tables[0].Columns[1].ColumnName = "Назва";
            dsContract.Tables[0].Columns[2].ColumnName = "Версія";

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
}
