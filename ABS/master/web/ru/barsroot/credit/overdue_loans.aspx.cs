using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

public partial class credit_overdue_loans : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnStart_Click(object sender, EventArgs e)
    {
        OracleConnection con = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();
        OracleCommand cmd = con.CreateCommand();
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        OracleCommand tab_cmd = con.CreateCommand();

        tab_cmd.CommandText = "select to_char(tabid) from meta_tables where tabname = 'V_PAY1'";
        OracleDataReader reader = tab_cmd.ExecuteReader();

        String tab_id = "";
        while (reader.Read())
        {
            tab_id += reader.GetString(0);
        }

        cmd.CommandText = "pul_dat";
        cmd.Parameters.Clear();
        cmd.Parameters.Add("sFdat1", OracleDbType.Varchar2, String.Format("{0:dd.MM.yyyy}", DATE_FROM.Value), System.Data.ParameterDirection.Input);
        cmd.Parameters.Add("sFdat2", OracleDbType.Varchar2, String.Empty, System.Data.ParameterDirection.Input);

        cmd.ExecuteNonQuery();

        con.Close();
        con.Dispose();

        Response.Redirect(String.Format("/barsroot/barsweb/references/refbook.aspx?tabid=" + tab_id + "&mode=RO&force=1"));
    }
}