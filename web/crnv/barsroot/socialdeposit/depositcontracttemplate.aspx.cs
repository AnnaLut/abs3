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

public partial class DepositContractTemplate : Bars.BarsPage
{
    protected System.Data.DataSet dsTemplates;
    protected Oracle.DataAccess.Client.OracleDataAdapter adapterSearchTemplate;
    private void Page_Load(object sender, System.EventArgs e)
    {
        if (Request["type"] == null)
            return;

        OracleConnection connect = new OracleConnection();
        Decimal type = Convert.ToDecimal(Convert.ToString(Request["type"]));

        try
        {
            InitOraConnection();
            SetRole("DPT_ROLE");

            SetParameters("type_id", DB_TYPE.Decimal, type, DIRECTION.Input);
            DataSet ds = SQL_SELECT_dataset("select null,id,name from v_socialtemplate where flag_id=1 and type_id=:type_id order by type_id,name");
            
            ds.Tables[0].Columns[0].ColumnName = "*";
            ds.Tables[0].Columns[1].ColumnName = "Шаблон";
            ds.Tables[0].Columns[2].ColumnName = "Им'я шаблону";

            gridTemplates.DataSource = ds;
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
        this.Load += new System.EventHandler(this.Page_Load);
    }
    #endregion

    protected void gridTemplates_ItemDataBound(object sender, System.Web.UI.WebControls.DataGridItemEventArgs e)
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

