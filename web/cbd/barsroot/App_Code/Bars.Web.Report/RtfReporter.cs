using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Data;
using System.Web;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;

namespace Bars.Web.Report
{
	/// <summary>
	/// Summary description for RtfReporter.
	/// </summary>
	public class RtfReporter
	{
		private HttpContext _ctx;	        // ������� HTTP ��������
		string _strBuf = null;
		private string _strTemplateID;	    // ID �������
		private bool _isTemplateCompressed;	// ����: true-������ ����, false-��������
		private long _nContractNumber;      // ����� ��������		        
        private long _nAdds = 0;            // �������� ADDS ��� ��������		        
        /// <summary>
        /// ����� ��������� �����
        /// ���� ��� ������� - ����� ����.
        /// </summary>
        private string _strReportFile;	    // ��� ����� �������� ������
        private string _strHeaderFile;      // ��� ����� ��������� �����������
        private string _strFooterFile;      // ��� ����� �������� �����������
        private string _strHeaderExFile;    // ��� ����� ��������� ����������� �����������

		private string _strDataFile;        // ��� ����� ������
		private string _strTempFile;        // ��� ���������� �����
		private string _strCompressedFile;  // ��� ������� �����

		private string _strTempDir;	        // ��������� ����������
		private string _strTemplateFile;    // ��� ����� �������
		private string _strParamListFile;   // ��� ����� ������ ����������

		private string _strRoleList;	    // ������ ����� ����� �������

		OracleConnection _con;
		OracleCommand _cmd;
		OracleDataReader _reader;

		long _nEvent = -1;	                //	��� ������� ��� ���������� ������ Oracle
		long _nLevel = -1;	                //  ������� ����������� ������� ���������� ������ Oracle

        /// <summary>
        /// ����������� ��� ���������
        /// !!! �� ��������������� !!!
        /// </summary>
		private RtfReporter(){}
        /// <summary>
        /// �����������
        /// </summary>
        /// <param name="ctx">�������� ��������</param>
		public RtfReporter(HttpContext ctx)
		{
			_ctx = ctx;
			//-- ���� � ���� ����� ������, �� ������ ������ ������ �������� ���� 
			//-- ���� ��� �������� �������� �� ����� (�������� tvSukhov)
			string strFilePrefix = Path.GetTempPath().Replace("Documents and Settings", "DOCUME~1").Replace("Local Settings", "LOCALS~1");
            
			if ('\\' != strFilePrefix[strFilePrefix.Length - 1])
				strFilePrefix += "\\";

			if (_ctx.Session == null)
				throw new ApplicationException("�� ������������ ����!");

			_strTempDir = strFilePrefix + _ctx.Session.SessionID + ".rep";

			Directory.CreateDirectory(_strTempDir);

			_strTemplateFile = _strTempDir + "\\" + "ole_tmp.rtf";
			_strReportFile = _strTempDir + "\\" + "report.rtf";
            _strHeaderFile = _strTempDir + "\\" + "header.rtf";
            _strFooterFile = _strTempDir + "\\" + "footer.rtf";
            _strHeaderExFile = _strTempDir + "\\" + "headerex.rtf";
			_strDataFile = _strTempDir + "\\" + "bindvar.dat";
			_strTempFile = _strTempDir + "\\" + "raw.tmp";
			_strCompressedFile = _strTempDir + "\\" + "archive.zip";
			_strParamListFile = _strTempDir + "\\" + "param.lst";

			_cmd = new OracleCommand();
			_reader = null;

			IOraConnection icon = (IOraConnection)_ctx.Application["OracleConnectClass"];
            _con = icon.GetUserConnection();
			_cmd.Connection = _con;
		}
		/// <summary>
		/// ��������� ������������� ������� ��� ������ (DOC_SCHEME.ID)
		/// </summary>
		public string TemplateID
		{
			get
			{
				return _strTemplateID;
			}
			set
			{
				_strTemplateID = value;
			}
		}
		/// <summary>
		/// ����� ��������
		/// </summary>
		public long ContractNumber
		{
			get
			{
				return _nContractNumber;
			}
			set
			{
				_nContractNumber = value;
			}
		}
        /// <summary>
        /// �������������� ��������
        /// </summary>
        public long ADDS
        {
            get
            {
                return _nAdds;
            }
            set
            {
                _nAdds = value;
            }
        }
		/// <summary>
		/// ��� ����� �������� ������
		/// </summary>
		public string ReportFile
		{
			get
			{
				return _strReportFile;
			}
		}
        /// <summary>
        /// ��� ����� ��������� �����������
        /// </summary>
        public string HeaderFile
        {
            get { return _strHeaderFile; }
        }
        /// <summary>
        /// ��� ����� �������� �����������
        /// </summary>
        public string FooterFile
        {
            get { return _strFooterFile; }
        }
        /// <summary>
        /// ��� ����� ��������� ����������� �����������
        /// </summary>
        public string HeaderExFile
        {
            get { return _strHeaderExFile; }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="nEvent"></param>
        /// <param name="nLevel"></param>
		public void SetEvent(long nEvent, long nLevel)
		{
			_nEvent = nEvent;
			_nLevel = nLevel;
		}
		/// <summary>
		/// ���������� ��� ���� ��������/������ � ����.
		/// ��� ����� ������ ����� �������� �� �������� ReportFile
		/// </summary>
		public void Generate()
		{
			try
			{
                OracleClob clob = null;

				try
				{
					if (_nEvent != -1 && _nLevel != -1)
					{
						_cmd.CommandText = "ALTER SESSION SET EVENTS '" + _nEvent.ToString() +
							" trace name context forever, level " + _nLevel.ToString() + "'";
						_cmd.ExecuteNonQuery();
						_nLevel = -1;
						_nEvent = -1;
					}
					//_cmd.CommandText = "set role "+_strRoleList;
					string[] _roles = RoleList.Split(',');
					IOraConnection icon = (IOraConnection)_ctx.Application["OracleConnectClass"];

					foreach (string role in _roles)
					{
						_cmd.CommandText = icon.GetSetRoleCommand(role);
						_cmd.ExecuteNonQuery();
					}
					// ���������� ������
					_cmd.CommandText = "SELECT id, template FROM doc_scheme " +
						"WHERE upper(ID)=upper('" + _strTemplateID + "')";
					_reader = _cmd.ExecuteReader();
					if (!_reader.Read())	// ������ �� �����?
					{
						throw new ReportException(
							"������ '" + _strTemplateID + "' �� ������.");
					}

                    if (_reader.GetValue(1) == DBNull.Value)
                        throw new ApplicationException("������ �������� ����!");
                    clob = _reader.GetOracleClob(1);
                    _strBuf = clob.Value;

					//-- ������� �� ������ ����� ������� � ���� ��� ����� 504B, 
					//-- �� ������������ ������ ��� ������					
					if(_strBuf.StartsWith("504B")) _isTemplateCompressed = true;
					else _isTemplateCompressed = false;

					

					// ����� ����� � ����
					Dump2Disk();
					// ������� ���� ������
					MakeDataFile();
					// ������� ��������� ���� �� ��������� ������� � ������
					MakeReport(_strReportFile);
				}
				finally
				{
                    clob.Close();
                    clob.Dispose();

                    _reader.Close();
                    _reader.Dispose();
					_cmd.Dispose();
					if (_con.State != ConnectionState.Closed)   _con.Close();
                    _con.Dispose();
				}
			}
            catch (System.Exception)
			{	// ���� ������� ������
				throw;
			}
		}
        /// <summary>
        /// ����������� ������
        /// ����������
        /// </summary>
        public void GenerateHeader()
        {
            try
            {
                IOraConnection icon = (IOraConnection)_ctx.Application["OracleConnectClass"];

                /// ������������ ���
                string[] _roles = RoleList.Split(',');
                foreach (string role in _roles)
                {
                    _cmd.CommandText = icon.GetSetRoleCommand(role);
                    _cmd.ExecuteNonQuery();
                }

                /// ������� ����� �� ������� ������ ��������� �����������
                _cmd.CommandText = "SELECT id, header FROM doc_scheme WHERE upper(ID)=upper('" + _strTemplateID + "')";
                _reader = _cmd.ExecuteReader();
                
                /// �� �������� ������
                if (!_reader.Read())	
                {
                    throw new ReportException("������� ���������� ��� ������� '" + _strTemplateID + "' �� ������");
                }

                /// ���� ���� ������ - ����� ��������� - 
                /// ������� ��������� ����� �� �������
                /// �� �� � ����������� �����
                if (_reader.GetValue(1) == DBNull.Value) 
                { 
                    _strHeaderFile = String.Empty; 
                    return; 
                }
                    
                OracleClob clob = _reader.GetOracleClob(1);
                _strBuf = clob.Value;
                
                _reader.Close();

                /// �������� ����� � ����
                Dump2Disk();
                /// �������� ���� �����
                MakeDataFile();
                /// �������� ���� ��������� �����������
                MakeReport(_strHeaderFile);
            }
            finally
            {
                if (null != _reader) _reader.Dispose();
                _cmd.Dispose();
                if (_con.State != ConnectionState.Closed) _con.Close();
                _con.Dispose();
            }
        }
        /// <summary>
        /// ����������� ����� 
        /// ����������
        /// </summary>
        public void GenerateFooter()
        {
            try
            {
                IOraConnection icon = (IOraConnection)_ctx.Application["OracleConnectClass"];

                /// ������������ ���
                string[] _roles = RoleList.Split(',');
                foreach (string role in _roles)
                {
                    _cmd.CommandText = icon.GetSetRoleCommand(role);
                    _cmd.ExecuteNonQuery();
                }

                /// ������� ����� �� ������� ������ �������� �����������
                _cmd.CommandText = "SELECT id, footer FROM doc_scheme WHERE upper(ID)=upper('" + _strTemplateID + "')";
                _reader = _cmd.ExecuteReader();

                /// �� �������� ������
                if (!_reader.Read())
                {
                    throw new ReportException("������ ���������� ��� ������� '" + _strTemplateID + "' �� ������");
                }

                /// ���� ���� ������ - ����� ��������� - 
                /// ������� ��������� ����� �� �������
                /// �� �� � ����������� �����
                if (_reader.GetValue(1) == DBNull.Value)
                {
                    _strFooterFile = String.Empty;
                    return;
                }

                OracleClob clob = _reader.GetOracleClob(1);
                _strBuf = clob.Value;

                _reader.Close();

                /// �������� ����� � ����
                Dump2Disk();
                /// �������� ���� �����
                MakeDataFile();
                /// �������� ���� �������� �����������
                MakeReport(_strFooterFile);
            }
            finally
            {
                if (null != _reader) _reader.Dispose();
                _cmd.Dispose();
                if (_con.State != ConnectionState.Closed) _con.Close();
                _con.Dispose();
            }
        }
        /// <summary>
        /// ����������� 
        /// ������ ���������� ����������
        /// </summary>
        public void GenerateHeaderEx()
        {
            try
            {
                IOraConnection icon = (IOraConnection)_ctx.Application["OracleConnectClass"];

                /// ������������ ���
                string[] _roles = RoleList.Split(',');
                foreach (string role in _roles)
                {
                    _cmd.CommandText = icon.GetSetRoleCommand(role);
                    _cmd.ExecuteNonQuery();
                }

                /// ������� ����� �� ������� ������ ����������� ��������� �����������
                _cmd.CommandText = "SELECT id, header FROM doc_scheme WHERE upper(ID)=upper('" + _strTemplateID + "')";
                _reader = _cmd.ExecuteReader();

                /// �� �������� ������
                if (!_reader.Read())
                {
                    throw new ReportException("����������� ������� ���������� ��� ������� '" + _strTemplateID + "' �� ������");
                }

                /// ���� ���� ������ - ����� ��������� - 
                /// ������� ��������� ����� �� �������
                /// �� �� � ����������� �����
                if (_reader.GetValue(1) == DBNull.Value)
                {
                    _strHeaderExFile = String.Empty;
                    return;
                }

                OracleClob clob = _reader.GetOracleClob(1);
                _strBuf = clob.Value;

                

                /// �������� ����� � ����
                Dump2Disk();
                /// �������� ���� �����
                MakeDataFile();
                /// �������� ���� ����������� ��������� �����������
                MakeReport(_strHeaderExFile);
            }
            finally
            {
                _reader.Close();
                _reader.Dispose();
                _cmd.Dispose();
                if (_con.State != ConnectionState.Closed) _con.Close();
                _con.Dispose();
            }
        }
		/// <summary>
		/// ������ �������� ����� �� ����
		/// �� ���� �����������, ���� ����
		/// </summary>
		private void Dump2Disk()
		{
			if(_isTemplateCompressed)
			{	// ������� ���������
				StreamWriter sw = File.CreateText(_strTempFile);
				sw.Write(_strBuf);
				sw.Close();
				// ������������ � �������� ���
				ToBin(_strTempFile);
				// ��������� �����
				Unpack(_strTempFile);
			}
			else
			{	// ����� ��� ����
				StreamWriter sw = File.CreateText(_strTemplateFile);
				sw.Write(_strBuf);
				sw.Close();
			}
		}
		/// <summary>
		/// �������������� ���� ������
		/// </summary>
		private void MakeDataFile()
		{
			Encoding enc = Encoding.GetEncoding(1251);

			// ������� ���������� ����-������ ��������� ����������
			string strParams = "/parse " + _strTemplateFile + " " + _strParamListFile;

			ProcessStartInfo psinfo = new ProcessStartInfo("RtfConv.exe", strParams);
			psinfo.UseShellExecute = false;
			psinfo.RedirectStandardError = true;
			Process proc = Process.Start(psinfo);
			string strError = proc.StandardError.ReadToEnd();
			bool flagTerm = proc.WaitForExit(15000);
			if (!flagTerm)
			{
				proc.Kill();
				throw new ReportException(
					"������� 'RtfConv.exe' �� �������� ������ � ���������� �����(15 ���).");
			}
			int nExitCode = proc.ExitCode;
			if (0 != nExitCode)
			{
				throw new ReportException(
					"������� 'RtfConv.exe' �������� �������� ������. ��� " + nExitCode + "."
					+ "�������� ���� �������� �� ������ ������: " + strError);

			}

			// ������ ������ ���������� �� �����, ���������� ��������� �� ��
			// � ����� ���� ������ ��� ������
			TextReader parfile = File.OpenText(_strParamListFile);

			// ������� ���� ������
			FileStream datfile = File.Create(_strDataFile);
			Encoding encoder = Encoding.GetEncoding(1251);
			try
			{
				while (-1 != parfile.Peek())
				{
					string strParamName = parfile.ReadLine();

					_cmd.CommandText = @"select f_doc_attr(:v_param,:v_nd) from dual";
					_cmd.Parameters.Clear();
					_cmd.Parameters.Add("v_param", OracleDbType.Varchar2,
						strParamName, ParameterDirection.Input);
					_cmd.Parameters.Add("v_nd", OracleDbType.Long,
						_nContractNumber, ParameterDirection.Input);
                    if (_nAdds != 0)
                    {
                        _cmd.CommandText = "select f_doc_attr(:v_param,:v_nd, :v_adds) from dual";
                        _cmd.Parameters.Add("v_adds", OracleDbType.Long, _nAdds, ParameterDirection.Input);
                    }

					string strParamValue = "";
					try
					{
						// ���� ������ ������ NULL �� ���������� ������,
						// ������ ���������� ������ ������									
                        try
                        {
                            strParamValue = (string)_cmd.ExecuteScalar();
                        }
                        catch (InvalidCastException) { }
					}
					catch (OracleException oe)
					{
						if (oe.Message.IndexOf("ORA-01403: no data found") >= 0)
							strParamValue = "{{" + strParamName + "}}";
						else
							throw;
					}
					// ����� � ����					
					string strParamLine = "|0:" + strParamName + ":" + strParamValue + "\n";
					byte[] bt = encoder.GetBytes(strParamLine);
					datfile.Write(bt, 0, bt.Length);
				}
			}
			finally
			{
				datfile.Close();
				parfile.Close();
			}
		}
		/// <summary>
		/// �������������� Hex --> Bin
		/// </summary>
		/// <param name="strFileName">��� �������������� �����</param>
		private void ToBin(string strFileName)
		{
			Process proc = Process.Start("ToBin.exe", strFileName);
			bool flagTerm = proc.WaitForExit(15000);
			if (!flagTerm)
			{
				proc.Kill();
				throw new ReportException(
					"������� 'ToBin.exe' �� �������� ������ � ���������� �����(15 ���).");
			}
		}
		/// <summary>
		/// ���������� ZIP-������
		/// </summary>
		/// <param name="strArchive">��� ��������� ������</param>
		private void Unpack(string strArchive)
		{
			string args = "-extract -over=all -path=specify -nofix -silent -NoZipExtension "
				+ strArchive + " " + _strTempDir;

			ProcessStartInfo psinfo = new ProcessStartInfo("pkzip25.exe", args);
			psinfo.UseShellExecute = false;
			psinfo.RedirectStandardError = true;
			Process proc = Process.Start(psinfo);
			string strError = proc.StandardError.ReadToEnd();
			bool flagTerm = proc.WaitForExit(15000);
			if (!flagTerm)
			{
				proc.Kill();
				throw new ReportException(
					"������� 'pkzip25.exe' �� �������� ������ � ���������� �����(15 ���).");
			}
			int nExitCode = proc.ExitCode;
			if (0 != nExitCode)
			{
				throw new ReportException(
					"������� 'pkzip25.exe' �������� �������� ������. ��� " + nExitCode + "."
					+ "�������� ���� �������� �� ������ ������: " + strError);
			}
		}

		private void MakeReport(string strReportFile)
		{
			string strParams = "/generate " + _strTemplateFile +
				" " + _strDataFile + " " + strReportFile;
			ProcessStartInfo psinfo = new ProcessStartInfo("RtfConv.exe", strParams);
			psinfo.UseShellExecute = false;
			psinfo.RedirectStandardError = true;
			Process proc = Process.Start(psinfo);
			string strError = proc.StandardError.ReadToEnd();
			bool flagTerm = proc.WaitForExit(15000);
			if (!flagTerm)
			{
				proc.Kill();
				throw new ReportException(
					"������� 'RtfConv.exe' �� �������� ������ � ���������� �����(15 ���).");
			}
			int nExitCode = proc.ExitCode;
			if (0 != nExitCode)
			{
				throw new ReportException(
					"������� 'RtfConv.exe' �������� �������� ������. ��� " + nExitCode + "."
					+ "�������� ���� �������� �� ������ ������: " + strError);
			}
		}
		/// <summary>
		/// ������� �������� ���� �������� ������
		/// </summary>
		public void DeleteReportFiles()
		{
			try
			{	// ������� ��������� ���������� � ��� ��� ������
				Directory.Delete(_strTempDir, true);
			}
            catch (System.Exception)
			{	// ����� ��� ����������
			}
		}

		/// <summary>
		/// ����� �����, ����������� �������
		/// </summary>
		public string RoleList
		{
			get
			{
				return _strRoleList;
			}
			set
			{
				_strRoleList = value;
			}
		}

	}
}
