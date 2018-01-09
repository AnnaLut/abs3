using System;
using System.Data;
using System.IO;
using System.Web;
using Bars.Oracle;
using Bars.Web.Report;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

/// <summary>
/// Summary description for TechAcc
/// </summary>
public class TechAcc
{
    private Decimal _dpt_id = Decimal.MinValue;
    public Decimal dpt_id
    {
        get { return _dpt_id; }
        set { _dpt_id = value; }
    }
	public TechAcc(Decimal dptid)
    {
        dpt_id = dptid;
    }

    public void WriteContractText(String[] _templates)
    {
        OracleConnection connect = new OracleConnection();

        try
        {
            IOraConnection conn = (IOraConnection)HttpContext.Current.Application["OracleConnectClass"];
            connect = conn.GetUserConnection();
            
            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();


            decimal mainContractFlag = 0;

            foreach (String template in _templates)
            {
                RtfReporter rep = new RtfReporter(HttpContext.Current);
                rep.RoleList = "reporter,dpt_role,cc_doc";
                rep.ContractNumber = (long)dpt_id;
                rep.TemplateID = template;
                OracleClob repText = new OracleClob(connect);

                try
                {
                    OracleCommand cmdCkSign = connect.CreateCommand();
                    cmdCkSign.CommandText = "select nvl(state,0) from cc_docs " +
                        "where nd=:dpt_id and adds=0 and id=:template";
                    cmdCkSign.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                    cmdCkSign.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
                    String result = Convert.ToString(cmdCkSign.ExecuteScalar());

                    if (result != String.Empty)
                    {
                        /// Повторне формування
                        /// спочатку видаляємо попередній
                        OracleCommand cmdDelPrevDpt = connect.CreateCommand();
                        cmdDelPrevDpt.CommandText = "delete from cc_docs " +
                            "where nd=:dpt_id and adds=0 and state=1 and id=:template";
                        cmdDelPrevDpt.Parameters.Add("dpt_id", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                        cmdDelPrevDpt.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
                        cmdDelPrevDpt.ExecuteNonQuery();
                    }

                    rep.Generate();

                    StreamReader sr = new StreamReader(rep.ReportFile);
                    char[] text;
                    String str = sr.ReadToEnd();
                    sr.Close();
                    text = str.ToCharArray();

                    File.Delete(rep.ReportFile);

                    repText.Write(text, 0, text.Length);

                    OracleCommand cmdInsDoc = connect.CreateCommand();
                    cmdInsDoc.CommandText = conn.GetSetRoleCommand("REPORTER");
                    cmdInsDoc.ExecuteNonQuery();
                    cmdInsDoc.CommandText = conn.GetSetRoleCommand("DPT_ROLE");
                    cmdInsDoc.ExecuteNonQuery();
                    cmdInsDoc.CommandText = conn.GetSetRoleCommand("CC_DOC");
                    cmdInsDoc.ExecuteNonQuery();

                    cmdInsDoc.CommandText = "insert into cc_docs(id, nd, adds, text, version) values (:template, :dptid, :adds, :txt, sysdate)";
                    cmdInsDoc.Parameters.Add("template", OracleDbType.Varchar2, template, ParameterDirection.Input);
                    cmdInsDoc.Parameters.Add("dptid", OracleDbType.Decimal, dpt_id, ParameterDirection.Input);
                    cmdInsDoc.Parameters.Add("adds", OracleDbType.Decimal, mainContractFlag, ParameterDirection.Input);
                    cmdInsDoc.Parameters.Add("txt", OracleDbType.Clob, repText, ParameterDirection.Input);
                    cmdInsDoc.ExecuteNonQuery();
                    cmdInsDoc.Dispose();
                }
                finally
                {
                    repText.Close();
                    repText.Dispose();
                    rep.DeleteReportFiles();
                }
            }
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
            { connect.Close(); connect.Dispose(); }
        }
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="d_op"></param>
    /// <param name="t"></param>
    /// <returns></returns>
    public static String GetTechTT(DPT_OP d_op, TECH_TYPE t, Decimal kv)
    {
        String tt = String.Empty;
        OracleConnection connect = new OracleConnection();

        try
        {
            connect = OraConnector.Handler.IOraConnection.GetUserConnection();                      

            OracleCommand cmdSetRole = connect.CreateCommand();
            cmdSetRole.CommandText = OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
            cmdSetRole.ExecuteNonQuery();

            OracleCommand cmd = connect.CreateCommand();
            if (t == TECH_TYPE.TT_COMISS)
                cmd.CommandText = "select tt_comiss from v_techacc_operations where op_id = :d_op";
            else if (kv == 980)
                cmd.CommandText = "select tt_main_nc from v_techacc_operations where op_id = :d_op";
            else
                cmd.CommandText = "select tt_main_fc from v_techacc_operations where op_id = :d_op";

            cmd.Parameters.Add("d_op", OracleDbType.Decimal, d_op, ParameterDirection.Input);

            tt = Convert.ToString(cmd.ExecuteScalar());

            return tt;
        }
        finally
        {
            if (connect.State != ConnectionState.Closed)
                connect.Close(); connect.Dispose();
        }
    }

}
