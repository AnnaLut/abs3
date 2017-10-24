using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Bars.UserControls;
using Bars.Oracle;
using System.Data;

public partial class crkr_forms_rebranch : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        sdsBranchFrom.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        sdsBranchTo.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();

    }

    protected void bt_refresh_Click(object sender, EventArgs e)
    {
        OracleConnection con = OraConnector.Handler.UserConnection;
        InitOraConnection();
        try
        {
            String res = String.Empty;

          
            OracleCommand cmd = con.CreateCommand();

            //Run procedure
            cmd.Parameters.Clear();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "crkr_compen_web.rebranch_crca";
            cmd.Parameters.Add("from", OracleDbType.Varchar2, ddlFrom.SelectedValue, ParameterDirection.Input);
            cmd.Parameters.Add("to", OracleDbType.Varchar2, ddlTo.SelectedValue, ParameterDirection.Input);
            cmd.Parameters.Add("res", OracleDbType.Varchar2, 4000, res, ParameterDirection.Output);
           


            cmd.ExecuteNonQuery();

            //Write into variable
            res = Convert.ToString(cmd.Parameters["res"].Value);
            lbMess.Text = res;
            lbMess.ForeColor = System.Drawing.Color.Blue;


        }
        finally
        {
            con.Close();
            DisposeOraConnection();
        }
    }
}