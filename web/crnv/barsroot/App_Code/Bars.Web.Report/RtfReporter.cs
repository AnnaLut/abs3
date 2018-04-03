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
		private HttpContext _ctx;	        // текущий HTTP контекст
		string _strBuf = null;
		private string _strTemplateID;	    // ID шаблона
		private bool _isTemplateCompressed;	// флаг: true-шаблон сжат, false-оригинал
		private long _nContractNumber;      // номер договора		        
        private long _nAdds = 0;            // параметр ADDS для договора		        
        /// <summary>
        /// Імена одержаних файлів
        /// Якщо імя порожне - файла немає.
        /// </summary>
        private string _strReportFile;	    // имя файла готового отчета
        private string _strHeaderFile;      // імя файлу верхнього колонтитула
        private string _strFooterFile;      // імя файлу нижнього колонтитула
        private string _strHeaderExFile;    // імя файлу верхнього розширеного колонтитула

		private string _strDataFile;        // имя файла данных
		private string _strTempFile;        // имя временного файла
		private string _strCompressedFile;  // имя сжатого файла

		private string _strTempDir;	        // временная директория
		private string _strTemplateFile;    // имя файла шаблона
		private string _strParamListFile;   // имя файла списка параметров

		private string _strRoleList;	    // список ролей через запятую

		OracleConnection _con;
		OracleCommand _cmd;
		OracleDataReader _reader;

		long _nEvent = -1;	                //	Код события для трасировки сессии Oracle
		long _nLevel = -1;	                //  Уровень детализации события трасировки сессии Oracle

        /// <summary>
        /// Конструктор без параметрів
        /// !!! Не використовується !!!
        /// </summary>
		private RtfReporter(){}
        /// <summary>
        /// Конструктор
        /// </summary>
        /// <param name="ctx">Поточний контекст</param>
		public RtfReporter(HttpContext ctx)
		{
			_ctx = ctx;
			//-- если в пути будет пробел, то ниодин процес которій получает этот 
			//-- путь как параметр работать не будет (проверил tvSukhov)
			string strFilePrefix = Path.GetTempPath().Replace("Documents and Settings", "DOCUME~1").Replace("Local Settings", "LOCALS~1");
            
			if ('\\' != strFilePrefix[strFilePrefix.Length - 1])
				strFilePrefix += "\\";

			if (_ctx.Session == null)
				throw new ApplicationException("Не ініціалізована сесія!");

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
		/// Строковый идентификатор шаблона для печати (DOC_SCHEME.ID)
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
		/// Номер договора
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
        /// Дополнительный параметр
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
		/// имя файла готового отчета
		/// </summary>
		public string ReportFile
		{
			get
			{
				return _strReportFile;
			}
		}
        /// <summary>
        /// імя файлу верхнього колонтитула
        /// </summary>
        public string HeaderFile
        {
            get { return _strHeaderFile; }
        }
        /// <summary>
        /// імя файлу нижнього колонтитула
        /// </summary>
        public string FooterFile
        {
            get { return _strFooterFile; }
        }
        /// <summary>
        /// імя файлу верхнього розширеного колонтитула
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
		/// Генерирует сам файл договора/отчета в файл.
		/// Имя файла отчета можно получить из свойства ReportFile
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
					// вычитываем шаблон
					_cmd.CommandText = "SELECT id, template FROM doc_scheme " +
						"WHERE upper(ID)=upper('" + _strTemplateID + "')";
					_reader = _cmd.ExecuteReader();
					if (!_reader.Read())	// шаблон не нашли?
					{
						throw new ReportException(
							"Шаблон '" + _strTemplateID + "' не найден.");
					}

                    if (_reader.GetValue(1) == DBNull.Value)
                        throw new ApplicationException("Шаблон договора пуст!");
                    clob = _reader.GetOracleClob(1);
                    _strBuf = clob.Value;

					//-- смотрим на первые байты шаблона и если они равны 504B, 
					//-- то расматриваем шаблон как сжетый					
					if(_strBuf.StartsWith("504B")) _isTemplateCompressed = true;
					else _isTemplateCompressed = false;

					

					// пишем буфер в файл
					Dump2Disk();
					// генерим файл данных
					MakeDataFile();
					// генерим финальный файл на основании шаблона и данных
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
			{	// пока бросаем дальше
				throw;
			}
		}
        /// <summary>
        /// Генеруються верхній
        /// колонтитул
        /// </summary>
        public void GenerateHeader()
        {
            try
            {
                IOraConnection icon = (IOraConnection)_ctx.Application["OracleConnectClass"];

                /// Встановлюємо ролі
                string[] _roles = RoleList.Split(',');
                foreach (string role in _roles)
                {
                    _cmd.CommandText = icon.GetSetRoleCommand(role);
                    _cmd.ExecuteNonQuery();
                }

                /// Формуємо запит на вичитку тексту верхнього колонтитула
                _cmd.CommandText = "SELECT id, header FROM doc_scheme WHERE upper(ID)=upper('" + _strTemplateID + "')";
                _reader = _cmd.ExecuteReader();
                
                /// Не знайдено шаблон
                if (!_reader.Read())	
                {
                    throw new ReportException("Верхний колонтитул для шаблона '" + _strTemplateID + "' не найден");
                }

                /// Якщо поле порожнє - нічого страшного - 
                /// значить формувати нічого не потрібно
                /// це не є обовязковий текст
                if (_reader.GetValue(1) == DBNull.Value) 
                { 
                    _strHeaderFile = String.Empty; 
                    return; 
                }
                    
                OracleClob clob = _reader.GetOracleClob(1);
                _strBuf = clob.Value;
                
                _reader.Close();

                /// записуємо буфер у файл
                Dump2Disk();
                /// генеруємо файл даних
                MakeDataFile();
                /// геренуємо файл верхнього колонтитула
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
        /// Генеруються нижній 
        /// колонтитул
        /// </summary>
        public void GenerateFooter()
        {
            try
            {
                IOraConnection icon = (IOraConnection)_ctx.Application["OracleConnectClass"];

                /// Встановлюємо ролі
                string[] _roles = RoleList.Split(',');
                foreach (string role in _roles)
                {
                    _cmd.CommandText = icon.GetSetRoleCommand(role);
                    _cmd.ExecuteNonQuery();
                }

                /// Формуємо запит на вичитку тексту нижнього колонтитула
                _cmd.CommandText = "SELECT id, footer FROM doc_scheme WHERE upper(ID)=upper('" + _strTemplateID + "')";
                _reader = _cmd.ExecuteReader();

                /// Не знайдено шаблон
                if (!_reader.Read())
                {
                    throw new ReportException("Нижний колонтитул для шаблона '" + _strTemplateID + "' не найден");
                }

                /// Якщо поле порожнє - нічого страшного - 
                /// значить формувати нічого не потрібно
                /// це не є обовязковий текст
                if (_reader.GetValue(1) == DBNull.Value)
                {
                    _strFooterFile = String.Empty;
                    return;
                }

                OracleClob clob = _reader.GetOracleClob(1);
                _strBuf = clob.Value;

                _reader.Close();

                /// записуємо буфер у файл
                Dump2Disk();
                /// генеруємо файл даних
                MakeDataFile();
                /// геренуємо файл нижнього колонтитула
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
        /// Генеруються 
        /// верхній розширений колонтитул
        /// </summary>
        public void GenerateHeaderEx()
        {
            try
            {
                IOraConnection icon = (IOraConnection)_ctx.Application["OracleConnectClass"];

                /// Встановлюємо ролі
                string[] _roles = RoleList.Split(',');
                foreach (string role in _roles)
                {
                    _cmd.CommandText = icon.GetSetRoleCommand(role);
                    _cmd.ExecuteNonQuery();
                }

                /// Формуємо запит на вичитку тексту розширеного верхнього колонтитула
                _cmd.CommandText = "SELECT id, header FROM doc_scheme WHERE upper(ID)=upper('" + _strTemplateID + "')";
                _reader = _cmd.ExecuteReader();

                /// Не знайдено шаблон
                if (!_reader.Read())
                {
                    throw new ReportException("Расширенный верхний колонтитул для шаблона '" + _strTemplateID + "' не найден");
                }

                /// Якщо поле порожнє - нічого страшного - 
                /// значить формувати нічого не потрібно
                /// це не є обовязковий текст
                if (_reader.GetValue(1) == DBNull.Value)
                {
                    _strHeaderExFile = String.Empty;
                    return;
                }

                OracleClob clob = _reader.GetOracleClob(1);
                _strBuf = clob.Value;

                

                /// записуємо буфер у файл
                Dump2Disk();
                /// генеруємо файл даних
                MakeDataFile();
                /// геренуємо файл розширеного верхнього колонтитула
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
		/// Дампим байтовый буфер на диск
		/// По ходу распаковуем, если надо
		/// </summary>
		private void Dump2Disk()
		{
			if(_isTemplateCompressed)
			{	// сначала распакуем
				StreamWriter sw = File.CreateText(_strTempFile);
				sw.Write(_strBuf);
				sw.Close();
				// конвертируем в бинарный вид
				ToBin(_strTempFile);
				// распакуем архив
				Unpack(_strTempFile);
			}
			else
			{	// пишем как есть
				StreamWriter sw = File.CreateText(_strTemplateFile);
				sw.Write(_strBuf);
				sw.Close();
			}
		}
		/// <summary>
		/// Подготавливаем файл данных
		/// </summary>
		private void MakeDataFile()
		{
			Encoding enc = Encoding.GetEncoding(1251);

			// сначала подготовим файл-список требуемых параметров
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
					"Процесс 'RtfConv.exe' не завершил работу в отведенное время(15 сек).");
			}
			int nExitCode = proc.ExitCode;
			if (0 != nExitCode)
			{
				throw new ReportException(
					"Процесс 'RtfConv.exe' аварийно завершил работу. Код " + nExitCode + "."
					+ "Описание кода возврата из потока ошибок: " + strError);

			}

			// читаем список параметров из файла, вычитываем параметры из БД
			// и пишем файл данных для отчета
			TextReader parfile = File.OpenText(_strParamListFile);

			// создаем файл данный
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
						// Если запрос вернет NULL не генерируем ошибку,
						// просто возвращаем пустую строку									
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
					// пишем в файл					
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
		/// Преобразование Hex --> Bin
		/// </summary>
		/// <param name="strFileName">имя преобразуемого файла</param>
		private void ToBin(string strFileName)
		{
			Process proc = Process.Start("ToBin.exe", strFileName);
			bool flagTerm = proc.WaitForExit(15000);
			if (!flagTerm)
			{
				proc.Kill();
				throw new ReportException(
					"Процесс 'ToBin.exe' не завершил работу в отведенное время(15 сек).");
			}
		}
		/// <summary>
		/// Распаковка ZIP-архива
		/// </summary>
		/// <param name="strArchive">имя исходного архива</param>
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
					"Процесс 'pkzip25.exe' не завершил работу в отведенное время(15 сек).");
			}
			int nExitCode = proc.ExitCode;
			if (0 != nExitCode)
			{
				throw new ReportException(
					"Процесс 'pkzip25.exe' аварийно завершил работу. Код " + nExitCode + "."
					+ "Описание кода возврата из потока ошибок: " + strError);
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
					"Процесс 'RtfConv.exe' не завершил работу в отведенное время(15 сек).");
			}
			int nExitCode = proc.ExitCode;
			if (0 != nExitCode)
			{
				throw new ReportException(
					"Процесс 'RtfConv.exe' аварийно завершил работу. Код " + nExitCode + "."
					+ "Описание кода возврата из потока ошибок: " + strError);
			}
		}
		/// <summary>
		/// удаляем выходной файл готового отчета
		/// </summary>
		public void DeleteReportFiles()
		{
			try
			{	// удаляем временную директорию и все что внутри
				Directory.Delete(_strTempDir, true);
			}
            catch (System.Exception)
			{	// давим все исключения
			}
		}

		/// <summary>
		/// набор ролей, разделенных запятой
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
