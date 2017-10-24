using System;
using System.Data;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Oracle;
using Oracle.DataAccess.Client;

public partial class DocumentForm : Page
{
    protected DataSet dsTemplates;
    protected OracleDataAdapter adapterSearchTemplate;
    /// <summary>
    /// Завантаження сторінки
    /// </summary>
    protected void Page_Load(object sender, EventArgs e)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmdSearch = connect.CreateCommand();
            cmdSearch.CommandText = "select null,id,name from v_techacctemplates";

            dsTemplates = new DataSet();
            adapterSearchTemplate = new OracleDataAdapter();
            adapterSearchTemplate.SelectCommand = cmdSearch;
            adapterSearchTemplate.Fill(dsTemplates);

            dsTemplates.Tables[0].Columns[0].ColumnName = "*";
            dsTemplates.Tables[0].Columns[1].ColumnName = "Шаблон";
            dsTemplates.Tables[0].Columns[2].ColumnName = "Назва";

            gridTemplates.DataSource = dsTemplates;
            gridTemplates.DataBind();

            gridTemplates.HeaderStyle.BackColor = Color.Gray;
            gridTemplates.HeaderStyle.Font.Bold = true;
            gridTemplates.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// Подія - заповнення гріда даними 
    /// </summary>
    protected void gridTemplates_ItemDataBound(object sender, DataGridItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            CheckBox ck = new CheckBox();
            DataGridItem row = e.Item;
            ck.Attributes.Add("onclick", "Sel('" + row.Cells[1].Text + "')");
            row.Cells[0].Controls.Add(ck);
        }
    }
}
