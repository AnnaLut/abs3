using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bars.Classes;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Data;
using System.Web;

public partial class swi_reconsilation_tt : Bars.BarsPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        dsMainTT.ConnectionString = OraConnector.Handler.IOraConnection.GetUserConnectionString();
        String SelectCommand = @"SELECT t.tt, t.name 
                                  FROM tts t, staff_tts s 
                                  WHERE s.tt = t.tt AND s.id = user_id() AND 
                                        t.tt IN (SELECT tt from sw_tt_import WHERE io_ind ='O') ";

        dsMainTT.SelectCommand = SelectCommand;
    }

    private void Window_open(String URL)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "open", "window.showModalDialog('" + URL + "',null,'dialogWidth:700px;');", true);
    }

    protected void gvMainTT_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void btCreate_Click(object sender, EventArgs e)
    {
        if (gvMainTT.SelectedRows.Count == 0)
        {
            ClientScript.RegisterStartupScript(GetType(), "Увага!", "alert('Не обрано операцію!');", true);
        }
        else
        {
            OracleConnection con = OraConnector.Handler.UserConnection;

            try
            {
                InitOraConnection();
             
                //declare variable
                String nlsa = String.Empty;
                String nlsb = String.Empty;
                String MsgSender = String.Empty;
                String MsgReceiver = String.Empty;
                String RelMsgRef = String.Empty;
                String RelMsgMt = String.Empty;
                String ISO = String.Empty;
                String s = String.Empty;
                String nazn = String.Empty;
               
                //Create oracle command
                OracleCommand cmd = con.CreateCommand();

                string tt = Convert.ToString((gvMainTT.Rows[gvMainTT.SelectedRows[0]].Cells[0]).Text);

                //Run procedure
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "p_reconsilation_run";
                //Input parameters
                cmd.Parameters.Add("p_stmt_ref", OracleDbType.Int64, Request["STMT_REF"], ParameterDirection.Input);
                cmd.Parameters.Add("p_coln", OracleDbType.Int64, Request["COLN"], ParameterDirection.Input);
                cmd.Parameters.Add("p_tt", OracleDbType.Varchar2, tt, ParameterDirection.Input);
                //Output parameters
                cmd.Parameters.Add("p_nlsa", OracleDbType.Varchar2, 4000, nlsa, ParameterDirection.Output);
                cmd.Parameters.Add("p_nlsb", OracleDbType.Varchar2, 4000, nlsb, ParameterDirection.Output);
                cmd.Parameters.Add("p_MsgSender", OracleDbType.Varchar2, 4000, MsgSender, ParameterDirection.Output);
                cmd.Parameters.Add("p_MsgReceiver", OracleDbType.Varchar2, 4000, MsgReceiver, ParameterDirection.Output);
                cmd.Parameters.Add("p_RelMsgRef", OracleDbType.Varchar2, 4000, RelMsgRef, ParameterDirection.Output);
                cmd.Parameters.Add("p_RelMsgMt", OracleDbType.Varchar2, 4000, RelMsgMt, ParameterDirection.Output);
                cmd.Parameters.Add("p_ISO", OracleDbType.Varchar2, 4000, ISO, ParameterDirection.Output);
                cmd.Parameters.Add("p_s", OracleDbType.Varchar2, 4000, s, ParameterDirection.Output);
                cmd.Parameters.Add("p_nazn", OracleDbType.Varchar2, 4000, nazn, ParameterDirection.Output);
                cmd.ExecuteNonQuery();

                //Write into variable
                nlsa = Convert.ToString(cmd.Parameters["p_nlsa"].Value).Replace("null","");
                nlsb = Convert.ToString(cmd.Parameters["p_nlsb"].Value).Replace("null", "");
                MsgSender = Convert.ToString(cmd.Parameters["p_MsgSender"].Value);
                MsgReceiver = Convert.ToString(cmd.Parameters["p_MsgReceiver"].Value);
                RelMsgRef = Convert.ToString(cmd.Parameters["p_RelMsgRef"].Value);
                RelMsgMt = Convert.ToString(cmd.Parameters["p_RelMsgMt"].Value);
                ISO = Convert.ToString(cmd.Parameters["p_ISO"].Value);
                s = Convert.ToString(cmd.Parameters["p_s"].Value);
                nazn = Convert.ToString(cmd.Parameters["p_nazn"].Value);

                if (nazn!="null")
                { 
                 Window_open(String.Format("/barsroot/docinput/docinput.aspx?tt={0}&nls_a={1}&nls_b={2}&kv_a={3}&kv_b={4}&sumc_t={5}&nazn={6}", tt, nlsa, nlsb, ISO, ISO,s, HttpUtility.UrlEncode( nazn)));
                }
                else
                {
                    Window_open(String.Format("/barsroot/docinput/docinput.aspx?tt={0}&nls_a={1}&nls_b={2}&kv_a={3}&kv_b={4}&sumc_t={5}", tt, nlsa, nlsb, ISO, ISO, s));
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);

                ClearParameters();
                SetParameters("swref", DB_TYPE.Int64, Request["STMT_REF"], DIRECTION.Input);
                SQL_NONQUERY("begin bars_swift.stmt_srcmsg_autolink(:swref); end;");

            }
            finally
            {
                DisposeOraConnection();
            }
        }
    }

    protected void btClose_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "window.close();", true);
    }
}