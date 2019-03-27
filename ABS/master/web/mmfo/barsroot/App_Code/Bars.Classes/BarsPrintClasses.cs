using System;
using System.IO;
using System.Data;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;

namespace Bars.Classes
{
	/// <summary>
	/// ���� ��� ����� ��������
	/// ����� ���
	/// </summary>
	public class BarsPrintClass
	{
		public BarsPrintClass(){}
		/// <summary>
		/// ���� ������ ��������
		/// </summary>
		/// <param name="dpt_id">����� ��������</param>
		/// <param name="template">������</param>
		/// <returns>��'� �����</returns>
		public String CreateDptContractFile(Decimal dpt_id,String template)
		{
            OracleConnection connect = new OracleConnection();

            string TempFile = string.Empty;
            String mainDir = Path.GetTempPath() + "dir\\" +
                Bars.Configuration.ConfigurationSettings.GetCurrentUserInfo.dbuser;
            OracleClob clob = null;

            try
            {
                connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

                using (OracleCommand cmdSetRole = connect.CreateCommand())
                {
                    cmdSetRole.CommandText =
                        Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DPT_ROLE");
                    cmdSetRole.ExecuteNonQuery();
                }

                if (Directory.Exists(mainDir))
                {
                    try { Directory.Delete(mainDir, true); }
                    catch { }
                }

                Directory.CreateDirectory(mainDir);
                TempFile = mainDir + "\\report.mht";

                using (OracleCommand cmdSelectContractText = connect.CreateCommand())
                {
                    cmdSelectContractText.InitialLONGFetchSize = 1000000;

                    cmdSelectContractText.CommandText =
                        "select nd, text,id,version,adds from cc_docs where nd = :dptid and id=:template and adds=0 order by version desc";
                    cmdSelectContractText.Parameters.Add("dptid", OracleDbType.Decimal, dpt_id,
                        ParameterDirection.Input);
                    cmdSelectContractText.Parameters.Add("template", OracleDbType.Varchar2, template,
                        ParameterDirection.Input);

                    using (OracleDataReader rdr = cmdSelectContractText.ExecuteReader())
                    {

                        if (!rdr.Read())
                            throw new Bars.Exception.BarsException("ORA-20008:����� �������� �� ��������!");

                        clob = rdr.GetOracleClob(1);
                        char[] ContractText = clob.Value.ToCharArray();
                        using (StreamWriter sw = new StreamWriter(TempFile))
                        {
                            sw.Write(ContractText);
                        }
                    }
                }
                return TempFile;
            }
            finally
            {
                if (clob != null)
                {
                    clob.Close();
                    clob.Dispose();
                }

                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
        public String CreateSkrFile(Decimal nd,String template,Decimal adds)
		{
            OracleConnection connect = new OracleConnection();

            string TempFile = string.Empty;
            String mainDir = Path.GetTempPath() + "dir\\" +
                Bars.Configuration.ConfigurationSettings.GetCurrentUserInfo.dbuser;
            OracleClob clob = null;

            try
            {
                connect = Bars.Classes.OraConnector.Handler.IOraConnection.GetUserConnection();

                using (OracleCommand cmdSetRole = connect.CreateCommand())
                {
                    cmdSetRole.CommandText =
                        Bars.Classes.OraConnector.Handler.IOraConnection.GetSetRoleCommand("DEP_SKRN");
                    cmdSetRole.ExecuteNonQuery();
                }

                if (Directory.Exists(mainDir))
                {
                    try { Directory.Delete(mainDir, true); }
                    catch { }
                }

                Directory.CreateDirectory(mainDir);
                TempFile = mainDir + "\\report.rtf";

                using (OracleCommand cmdSelectContractText = connect.CreateCommand())
                {
                    cmdSelectContractText.InitialLONGFetchSize = 1000000;

                    cmdSelectContractText.CommandText =
                        "select nd, text,id,version,adds from cc_docs where nd = :nd and id=:id and adds=:adds order by version desc";
                    cmdSelectContractText.Parameters.Add("nd", OracleDbType.Decimal, nd, ParameterDirection.Input);
                    cmdSelectContractText.Parameters.Add("id", OracleDbType.Varchar2, template,
                        ParameterDirection.Input);
                    cmdSelectContractText.Parameters.Add("adds", OracleDbType.Decimal, adds, ParameterDirection.Input);

                    using (OracleDataReader rdr = cmdSelectContractText.ExecuteReader())
                    {

                        if (!rdr.Read())
                            throw new Exception.BarsException("����� �������� �� ��������!");

                        clob = rdr.GetOracleClob(1);
                        char[] ContractText = clob.Value.ToCharArray();
                        using (StreamWriter sw = new StreamWriter(TempFile, false,
                            System.Text.Encoding.GetEncoding(1251)))
                        {
                            sw.Write(ContractText);
                        }
                    }
                }
                return TempFile;
            }
            finally
            {
                if (clob != null)
                {
                    clob.Close();
                    clob.Dispose();
                }

                if (connect.State != ConnectionState.Closed)
                { connect.Close(); connect.Dispose(); }
            }
        }
	}
}