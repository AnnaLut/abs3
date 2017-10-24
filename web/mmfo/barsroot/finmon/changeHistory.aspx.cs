using System;
using Bars.Classes;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class finmon_changeHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        tbRef.Text = "Документ № " + Request["ref"];
        FillGrid();
    }

    private void FillGrid()
    {
        changeHistoryDataSource.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        changeHistoryDataSource.PreliminaryStatement = OraConnector.Handler.IOraConnection.GetSetRoleCommand("");
        changeHistoryDataSource.SelectParameters.Clear();
        changeHistoryDataSource.SelectParameters.Add("p_id", DbType.Decimal, Request["id"]);

        changeHistoryDataSource.SelectCommand = @"SELECT f.mod_date, f.mod_type, t.mod_name as NAME, f.user_id, f.user_name, substr(f.mod_value, 1, 1000) as OLD_VALUE
                                                    FROM finmon_que_modification f, finmon_que_modtype t
                                                    WHERE f.mod_type = t.mod_type AND f.id =:p_id";
    }
}