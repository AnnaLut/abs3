using System;
using System.Web.UI;
using Oracle.DataAccess.Client;
using Bars.Classes;
using Bars.UserControls;
using Bars.Oracle;
using System.Data;

public partial class swi_positioner_mt : Bars.BarsPage
{


    private void FillData()
    {
        Response.Redirect(String.Format("/barsroot/swi/positioner_mt.aspx?acc={0}&ref={1}", Request["ACC"], Request["REF"]));
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            OracleConnection con = OraConnector.Handler.UserConnection;
            String Result = String.Empty;

            try
            {
                InitOraConnection();

                if (Request["ACC"] != null & Request["REF"] != null)
                {
                    //declare variable
                    String df103SndBic = String.Empty;
                    String df103SndName = String.Empty;
                    String df103RcvBic = String.Empty;
                    String df103RcvName = String.Empty;
                    String df202RcvBic = String.Empty;
                    String df202RcvName = String.Empty;

                    //Create oracle command
                    OracleCommand cmd = con.CreateCommand();

                    //Run procedure
                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "bars_swift_msg.docmsg_document_get103covhdr";
                    cmd.Parameters.Add("nRefNos", OracleDbType.Int64, Request["REF"], ParameterDirection.Input);
                    cmd.Parameters.Add("df103SndBic", OracleDbType.Varchar2, 4000, df103SndBic, ParameterDirection.Output);
                    cmd.Parameters.Add("df103SndName", OracleDbType.Varchar2, 4000, df103SndName, ParameterDirection.Output);
                    cmd.Parameters.Add("df103RcvBic", OracleDbType.Varchar2, 4000, df103RcvBic, ParameterDirection.Output);
                    cmd.Parameters.Add("df103RcvName", OracleDbType.Varchar2, 4000, df103RcvName, ParameterDirection.Output);
                    cmd.Parameters.Add("df202RcvBic", OracleDbType.Varchar2, 4000, df202RcvBic, ParameterDirection.Output);
                    cmd.Parameters.Add("df202RcvName", OracleDbType.Varchar2, 4000, df202RcvName, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    //Write into variable
                    df103SndBic = Convert.ToString(cmd.Parameters["df103SndBic"].Value);
                    df103SndName = Convert.ToString(cmd.Parameters["df103SndName"].Value);
                    df103RcvBic = Convert.ToString(cmd.Parameters["df103RcvBic"].Value);
                    df103RcvName = Convert.ToString(cmd.Parameters["df103RcvName"].Value);
                    df202RcvBic = Convert.ToString(cmd.Parameters["df202RcvBic"].Value);
                    df202RcvName = Convert.ToString(cmd.Parameters["df202RcvName"].Value);

                    //Set into labels
                    lbSenderBic103.Text = df103SndBic.Replace("null", "Не визначено");
                    lbSenderName103.Text = df103SndName.Replace("null", "Не визначено");
                    /*lbReciverBic103.Text = df103RcvBic.Replace("null", "Не визначено");
                    lbReciverName103.Text = df103RcvName.Replace("null", "Не визначено");*/
                    refReciverBic103.Value = df103RcvBic.Replace("null", "Не визначено");
                    tbReciverName103.Value = df103RcvName.Replace("null", "Не визначено");
                    lbSenderBic202.Text = df103SndBic.Replace("null", "Не визначено");
                    lbSenderName202.Text = df103SndName.Replace("null", "Не визначено");
                    /*lbReciverBic202.Text = df202RcvBic.Replace("null", "Не визначено");
                    lbReciverName202.Text = df202RcvName.Replace("null", "Не визначено");*/
                    refReciverBic202.Value = df202RcvBic.Replace("null", "Не визначено");
                    tbReciverName202.Value = df202RcvName.Replace("null", "Не визначено");


                }
            }
            finally
            {
                con.Close();
            }

        }
    }

    protected void btPay_Click(object sender, EventArgs e)
    {
        InitOraConnection();
        try
        {
           

            ClearParameters();

            SetParameters("ref", DB_TYPE.Int64, Request["REF"], DIRECTION.Input);
            SetParameters("reciv103", DB_TYPE.Varchar2, refReciverBic103.Value, DIRECTION.Input);
            SetParameters("reciv202", DB_TYPE.Varchar2, refReciverBic202.Value, DIRECTION.Input);
            SetParameters("ref2", DB_TYPE.Int64, Request["REF"], DIRECTION.Input);

            SQL_NONQUERY(@"begin 
                                  bars_swift_msg.docmsg_document_set103covhdr(:ref, :reciv103, :reciv202);
                                   bars_swift_msg.docmsg_process_document2(:ref2, '2');

                               end;");

        }
        finally
        {
            DisposeOraConnection();
        }

        //Close Dialog
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.returnValue = true;window.close();", true);
    }


    protected void btClose_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }
    protected void refReciverBic103_ValueChanged(object sender, EventArgs e)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        TextBoxRefer Bic103 = (sender as TextBoxRefer);

        //TextBox Name103 = (frmGenerateMT.FindControl("tbReciverName103") as TextBox);

        try
        {
            if (!String.IsNullOrEmpty(Bic103.Value))
            {
                cmd.CommandText = "select * from sw_banks v where v.bic = :bic";
                cmd.Parameters.Add("bic", OracleDbType.Varchar2, Bic103.Value, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        tbReciverName103.Value = (String)reader[1].ToString();
                    }
                }
            }
        }
        finally
        {
            cmd.Dispose();
            con.Dispose();
            con.Close();
        }

    }
    protected void refReciverBic202_ValueChanged(object sender, EventArgs e)
    {
        IOraConnection icon = (IOraConnection)Context.Application["OracleConnectClass"];
        OracleConnection con = icon.GetUserConnection(Context);
        OracleCommand cmd = con.CreateCommand();

        TextBoxRefer Bic202 = (sender as TextBoxRefer);

        //TextBox Name103 = (frmGenerateMT.FindControl("tbReciverName103") as TextBox);

        try
        {
            if (!String.IsNullOrEmpty(Bic202.Value))
            {
                cmd.CommandText = "select * from sw_banks v where v.bic = :bic";
                cmd.Parameters.Add("bic", OracleDbType.Varchar2, Bic202.Value, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        tbReciverName202.Value = (String)reader[1].ToString();
                    }
                }
            }
        }
        finally
        {
            cmd.Dispose();
            con.Dispose();
            con.Close();
        }
    }
}