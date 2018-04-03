using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Web;
using System.Web.Services;
using System.Net;
using System.IO;
using System.Xml;
using System.Web.Services.Protocols;
using System.Configuration;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Oracle;
using System.Security.Cryptography.X509Certificates;
using System.Globalization;
using Bars.Logger;

namespace mobinet
{
	/// <summary>
	/// Summary description for PhoneService.
	/// </summary>
	public class PhoneService : Bars.BarsWebService
	{
		public PhoneService()
		{
			//CODEGEN: This call is required by the ASP.NET Web Services Designer
			InitializeComponent();
		}

		#region Component Designer generated code
		
		//Required by the Web Services Designer 
		private IContainer components = null;
				
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if(disposing && components != null)
			{
				components.Dispose();
			}
			base.Dispose(disposing);		
		}
		
		#endregion

		/// <summary>
		/// Получение ФИО владельца телефона по его номеру
		/// </summary>
		/// <param name="strPhone">номер телефона</param>
		/// <returns>ФИО</returns>
		[WebMethod(EnableSession = true)]
		public string GetNamePhoneOwner(string strPhone)
		{	string strName = null;
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			try
			{
				OracleCommand command = new OracleCommand();
				command.Connection = connect;

				// устанавливаем роль
				command.CommandText = @"set role mobinet";
				command.ExecuteNonQuery();
				command.CommandText = @"select mobi.getNamePhoneOwner(:strPhone) from dual";
				command.Parameters.Clear();
				command.Parameters.Add("strPhone", OracleDbType.Varchar2,strPhone, ParameterDirection.Input);
				OracleDataReader reader = command.ExecuteReader();
				if(reader.Read()) 
				{
					if(!reader.IsDBNull(0)) strName = reader.GetString(0);
				}						
				reader.Close();
			}
			finally
			{	
				connect.Close();
				connect.Dispose();
			}
			return strName;
		}

		/// <summary>
		/// Выполнение запроса к мобильному оператору по HTTPS
		/// </summary>
		/// <param name="urlParams">параметры URL в виде param1=value1&param2=value2&...</param>
		/// <returns>строка XML ответа</returns>
		private string MobipayInvoke(string urlParams)
		{
			HttpWebRequest HttpWReq   = null;
			HttpWebResponse HttpWResp = null;
			Stream receiveStream = null;
			StreamReader readStream = null;
			CertificateValidation certValidation = new CertificateValidation();
			string strResponse = "";
			Exception erp = null;
			string strMobipayURL = "";
			string strFullURL = "";
			try
			{
				ServicePointManager.CertificatePolicy = certValidation;

				strMobipayURL = ConfigurationSettings.AppSettings["Mobipay.URL"];
				strFullURL = strMobipayURL + "?" + urlParams;
				HttpWReq = (HttpWebRequest)WebRequest.Create(strFullURL);
				
				bool requiredAuth = false;
				string strRequiredAuth = ConfigurationSettings.AppSettings["Mobipay.Auth.Required"];
				if(null!=strRequiredAuth) requiredAuth = System.Boolean.Parse(strRequiredAuth);
				if(requiredAuth)
				{
					string strAuthType     = ConfigurationSettings.AppSettings["Mobipay.Auth.Type"];
					string strAuthDomain   = ConfigurationSettings.AppSettings["Mobipay.Auth.Domain"];
					string strAuthUsername = ConfigurationSettings.AppSettings["Mobipay.Auth.Username"];
					string strAuthPassword = ConfigurationSettings.AppSettings["Mobipay.Auth.Password"];
					CredentialCache credentialCache = new CredentialCache();
					NetworkCredential credentials = null;
					if(null!=strAuthDomain)
						credentials = new NetworkCredential(strAuthUsername,strAuthPassword,strAuthDomain);
					else
						credentials = new NetworkCredential(strAuthUsername,strAuthPassword);
					credentialCache.Add(new Uri(strFullURL), strAuthType, credentials);
					HttpWReq.Credentials = credentialCache;
				}
				
				HttpWReq.KeepAlive = false;

				HttpWResp = (HttpWebResponse)HttpWReq.GetResponse();

				receiveStream = HttpWResp.GetResponseStream();
				System.Text.Encoding encode = System.Text.Encoding.GetEncoding("windows-1251");
				readStream = new StreamReader( receiveStream, encode );
				int nMaxChars = 4096;
				char[] read = new char[nMaxChars];
				int count = readStream.Read( read, 0, nMaxChars );
				while (count > 0) 
				{
					String str = new String(read, 0, count);
					strResponse = strResponse + str;
					count = readStream.Read(read, 0, nMaxChars);
				}
			}
			catch(WebException we)
			{				
				erp = new WebException(certValidation.GetProblemMsg(), we);
				throw erp;
			}
			finally
			{				
				if(null!=HttpWResp)	HttpWResp.Close();
				if(null!=readStream) readStream.Close();
				// пишем протокол !!
				if(null!=erp)
				{
					DBLogger.Error("Mobipay: Invoke: "+RestrictURL(strFullURL));
				}
				else
				{
					DBLogger.Info("Mobipay: Invoke: "+RestrictURL(strFullURL)+"\n"
						+"Result:\n"+strResponse);
				}
			}
			return strResponse;
		}
		/// <summary>
		/// Замена значения пароля на xxx
		/// </summary>
		/// <param name="strURL"></param>
		/// <returns></returns>
		private string RestrictURL(string strURL)
		{		
			string newURL = "";
			int indx = strURL.IndexOf("PASSWORD=");
			if(indx>=0)
			{	newURL = strURL.Substring(0,indx+9)+"xxx";
				int indx2 = strURL.IndexOf("&", indx);
				if(indx2>=0) newURL = newURL + strURL.Substring(indx2);
			}
			return newURL;
		}
		/// <summary>
		/// Получение Id транзакции у Киевстар, запись его в БД
		/// </summary>
		/// <param name="strPhone">номер телефона</param>
		/// <param name="numSum">сумма</param>
		/// <param name="strName">ФИО</param>
		/// <returns>Id транзакции для пополнения</returns>
		[WebMethod(EnableSession = true)]
		public void InitTrans(string strPhone, long numSum, string strName, long vdatflag,
			out long pay_id, out string time_stamp, out int status_code, out string status_msg)
		{	
			DBLogger.Info("Mobipay: Начало пополнения тел. "
				+strPhone+" на сумму "+numSum+" грн.");
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			string strUsername = "";
			string strPassword = "";
			string strMFO = "";
			string strTOBO = "";
			pay_id      = 0;
			time_stamp  = "";
			status_code = 0;
			status_msg  = "";			
			// Сумма изначально в гривнах, переводим в копейки
			long unitSum = numSum*100;
			try
			{
				// получаем данные из БД
				OracleCommand command = new OracleCommand();
				command.Connection = connect;				
				command.CommandText = @"set role mobinet";
				command.ExecuteNonQuery();
				command.CommandText = @"select mobi.GetMobUsername, mobi.GetMobPassword,
										mobi.GetMFO, mobi.GetTOBOB040 from dual";				
				OracleDataReader reader = command.ExecuteReader();
				if(reader.Read()) 
				{
					if(!reader.IsDBNull(0)) strUsername = reader.GetString(0);
					if(!reader.IsDBNull(1)) strPassword = reader.GetString(1);
					if(!reader.IsDBNull(2)) strMFO      = reader.GetString(2);
					if(!reader.IsDBNull(3)) strTOBO     = reader.GetString(3);
				}						
				reader.Close();
                string urlParams =
                    "USERNAME=" + strUsername
                    + "&PASSWORD=" + strPassword
                    + "&ACT=0"
                    + "&MSISDN=" + strPhone
                    + "&PAY_AMOUNT=" + numSum.ToString() + ".00"
                    + "&BRANCH=" + strMFO
                    + "&TRADE_POINT=" + strTOBO
                    + "&SOURCE_TYPE=1";
                Random r = new Random();
                urlParams += "&rnd=" + r.Next(10, 100).ToString();

				// обращаемся к мобильному оператору
				string strXml = MobipayInvoke(urlParams);
				// разбираем ответ
				XmlDocument xmlDoc = new XmlDocument();
				xmlDoc.LoadXml(strXml);
				XmlNode node_status_code = xmlDoc.SelectSingleNode("/pay-response/status_code");
				XmlNode node_time_stamp  = xmlDoc.SelectSingleNode("/pay-response/time_stamp");
				Int32   v_status_code = Int32.Parse(node_status_code.InnerText);				
				string  v_time_stamp  = "";
				if(null!=node_time_stamp) v_time_stamp  = node_time_stamp.InnerText;
				Int64   v_pay_id = 0;
				if(v_status_code>0)
				{
					XmlNode node_pay_id      = xmlDoc.SelectSingleNode("/pay-response/pay_id");
					if(null==node_pay_id) throw new MobipayException("Узел \"/pay-response/pay_id\" не найден.");
					v_pay_id = Int64.Parse(node_pay_id.InnerText);
				}				
				pay_id      = v_pay_id;
				time_stamp  = v_time_stamp;
				status_code = v_status_code;
				status_msg  = GetMobipayMessage(v_status_code);
				// записать результат в БД
				OracleTransaction tx = connect.BeginTransaction();
				bool txCommited = false;
				try
				{
					command.CommandText = "begin mobi.InitTrans("
						+":p_phone,"
						+":p_sum,"
						+":p_name,"
						+":p_pay_id,"
						+":p_time_stamp,"
						+":p_status_code,"						
						+":p_vdatflag);"
						+"end;";
					command.Parameters.Clear();
					command.Parameters.Add("p_phone", OracleDbType.Varchar2, strPhone, ParameterDirection.Input);
					command.Parameters.Add("p_sum", OracleDbType.Long, unitSum, ParameterDirection.Input);
					command.Parameters.Add("p_name", OracleDbType.Varchar2, strName, ParameterDirection.Input);
					command.Parameters.Add("p_pay_id", OracleDbType.Long, pay_id, ParameterDirection.Input);
					if(time_stamp != string.Empty)
					{
						CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
						cinfo.DateTimeFormat.FullDateTimePattern = "dd.MM.yyyy HH:mm:ss";
						cinfo.DateTimeFormat.DateSeparator = ".";
						cinfo.DateTimeFormat.TimeSeparator = ":";
						DateTime dt_time_stamp = Convert.ToDateTime(time_stamp, cinfo.DateTimeFormat);				
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, dt_time_stamp, ParameterDirection.Input);
					}
					else 
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, null, ParameterDirection.Input)						;
					command.Parameters.Add("p_status_code",OracleDbType.Int32,status_code,ParameterDirection.Input);
					command.Parameters.Add("p_vdatflag",OracleDbType.Long,vdatflag,ParameterDirection.Input);
					command.ExecuteNonQuery();
					tx.Commit();
					txCommited = true;
				}
				finally
				{
					if(!txCommited) tx.Rollback();
				}
				DBLogger.Info("Mobipay: Получен № транзакции: "+pay_id);
			}
			finally
			{
				connect.Close();
				connect.Dispose();
			}			
		}
		/// <summary>
		/// проверка транзакции на возможность проведения
		/// </summary>
		/// <param name="pay_id"></param>
		/// <param name="time_stamp"></param>
		/// <param name="status_code"></param>
		/// <param name="status_msg"></param>
		[WebMethod(EnableSession = true)]
		public void CheckTrans(long pay_id, 
			out string time_stamp, out int status_code, out string status_msg)
		{
			DBLogger.Info("Mobipay: Инициирована проверка транзакции № "+pay_id);
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			string strUsername = "";
			string strPassword = "";
			time_stamp  = "";
			status_code = 0;
			status_msg  = "";
			try
			{
				// получаем данные из БД
				OracleCommand command = new OracleCommand();
				command.Connection = connect;				
				command.CommandText = @"set role mobinet";
				command.ExecuteNonQuery();
				command.CommandText = @"select mobi.GetMobUsername, mobi.GetMobPassword from dual";
				OracleDataReader reader = command.ExecuteReader();
				if(reader.Read()) 
				{
					if(!reader.IsDBNull(0)) strUsername = reader.GetString(0);
					if(!reader.IsDBNull(1)) strPassword = reader.GetString(1);					
				}						
				reader.Close();
				string urlParams = 					
					  "USERNAME=" +strUsername
					+"&PASSWORD=" +strPassword
					+"&ACT=4"
					+"&PAY_ID="+pay_id;
				// обращаемся к мобильному оператору
				string strXml = MobipayInvoke(urlParams);
				// разбираем ответ
				XmlDocument xmlDoc = new XmlDocument();
				xmlDoc.LoadXml(strXml);
				XmlNode node_status_code = xmlDoc.SelectSingleNode("/pay-response/status_code");
				XmlNode node_time_stamp  = xmlDoc.SelectSingleNode("/pay-response/time_stamp");
				Int32   v_status_code = Int32.Parse(node_status_code.InnerText);				
				string  v_time_stamp  = "";
				if(null!=node_time_stamp) v_time_stamp  = node_time_stamp.InnerText;				
				XmlNode node_account = xmlDoc.SelectSingleNode("/pay-response/account");
				XmlNode node_balance = xmlDoc.SelectSingleNode("/pay-response/balance");
				XmlNode node_name    = xmlDoc.SelectSingleNode("/pay-response/name");
				string s_account = "";
				if(null!=node_account) s_account = node_account.InnerText;
				string s_balance = "";
				long num_balance = -1;
				decimal d_balance = -1;
				if(null!=node_balance) 
				{
					s_balance = node_balance.InnerText;
					CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
					cinfo.NumberFormat.NumberDecimalSeparator = ".";
					d_balance = decimal.Parse(s_balance,NumberStyles.Number,cinfo.NumberFormat);
					num_balance = (long)d_balance*100;  // переводим в копейки
				}
				string s_name = "";
				if(null!=node_name) s_name = node_name.InnerText;
				
				time_stamp  = v_time_stamp;
				status_code = v_status_code;
				status_msg  = GetMobipayMessage(v_status_code);
				// записать результат в БД
				OracleTransaction tx = connect.BeginTransaction();
				bool txCommited = false;
				try
				{
					command.CommandText = "begin mobi.CheckTrans("
						+":p_pay_id,"
						+":p_time_stamp,"
						+":p_status_code,"
						+":p_account,"
						+":p_balance,"
						+":p_name"
						+");"
						+"end;";

					command.Parameters.Clear();
					command.Parameters.Add("p_pay_id", OracleDbType.Long, pay_id, ParameterDirection.Input);
					if(time_stamp != string.Empty)
					{
						CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
						cinfo.DateTimeFormat.FullDateTimePattern = "dd.MM.yyyy HH:mm:ss";
						cinfo.DateTimeFormat.DateSeparator = ".";
						cinfo.DateTimeFormat.TimeSeparator = ":";
						DateTime dt_time_stamp = Convert.ToDateTime(time_stamp, cinfo.DateTimeFormat);				
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, dt_time_stamp, ParameterDirection.Input);
					}
					else 
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, null, ParameterDirection.Input);
					command.Parameters.Add("p_status_code",OracleDbType.Int32,status_code,ParameterDirection.Input);
					command.Parameters.Add("p_account",OracleDbType.Varchar2,s_account,ParameterDirection.Input);
					command.Parameters.Add("p_balance",OracleDbType.Long,num_balance,ParameterDirection.Input);
					command.Parameters.Add("p_name",OracleDbType.Varchar2,s_name,ParameterDirection.Input);
					command.ExecuteNonQuery();
					tx.Commit();
					txCommited = true;
				}
				finally
				{
					if(!txCommited) tx.Rollback();
				}
				DBLogger.Info("Mobipay: Проверка транзакции № "+pay_id
					+" вернула код "+status_code+"("+status_msg+")");
			}
			finally
			{
				connect.Close();
				connect.Dispose();
			}
		}
		/// <summary>
		/// откат транзакции
		/// </summary>
		/// <param name="pay_id"></param>
		/// <param name="time_stamp"></param>
		/// <param name="status_code"></param>
		/// <param name="status_msg"></param>
		[WebMethod(EnableSession = true)]
		public void RollbackTrans(long pay_id, 
			out string time_stamp, out int status_code, out string status_msg)
		{
			DBLogger.Info("Mobipay: Инициирован откат транзакции № "+pay_id);
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			string strUsername = "";
			string strPassword = "";
			time_stamp  = "";
			status_code = 0;
			status_msg  = "";
			try
			{
				// получаем данные из БД
				OracleCommand command = new OracleCommand();
				command.Connection = connect;				
				command.CommandText = @"set role mobinet";
				command.ExecuteNonQuery();
				command.CommandText = @"select mobi.GetMobUsername, mobi.GetMobPassword from dual";
				OracleDataReader reader = command.ExecuteReader();
				if(reader.Read()) 
				{
					if(!reader.IsDBNull(0)) strUsername = reader.GetString(0);
					if(!reader.IsDBNull(1)) strPassword = reader.GetString(1);					
				}						
				reader.Close();
				string urlParams = 					
					"USERNAME="+strUsername
					+"&PASSWORD="+strPassword
					+"&ACT=2"
					+"&PAY_ID="+pay_id;
				// обращаемся к мобильному оператору
				string strXml = MobipayInvoke(urlParams);
				// разбираем ответ
				XmlDocument xmlDoc = new XmlDocument();
				xmlDoc.LoadXml(strXml);
				XmlNode node_status_code = xmlDoc.SelectSingleNode("/pay-response/status_code");
				XmlNode node_time_stamp  = xmlDoc.SelectSingleNode("/pay-response/time_stamp");
				Int32   v_status_code = Int32.Parse(node_status_code.InnerText);				
				string  v_time_stamp  = "";
				if(null!=node_time_stamp) v_time_stamp  = node_time_stamp.InnerText;
				
				time_stamp  = v_time_stamp;
				status_code = v_status_code;
				status_msg  = GetMobipayMessage(v_status_code);
				// записать результат в БД
				OracleTransaction tx = connect.BeginTransaction();
				bool txCommited = false;
				try
				{
					command.CommandText = "begin mobi.RollbackTrans("
						+":p_pay_id,"
						+":p_time_stamp,"
						+":p_status_code"
						+");"
						+"end;";

					command.Parameters.Clear();
					command.Parameters.Add("p_pay_id", OracleDbType.Long, pay_id, ParameterDirection.Input);
					if(time_stamp != string.Empty)
					{
						CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
						cinfo.DateTimeFormat.FullDateTimePattern = "dd.MM.yyyy HH:mm:ss";
						cinfo.DateTimeFormat.DateSeparator = ".";
						cinfo.DateTimeFormat.TimeSeparator = ":";
						DateTime dt_time_stamp = Convert.ToDateTime(time_stamp, cinfo.DateTimeFormat);				
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, dt_time_stamp, ParameterDirection.Input);
					}
					else 
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, null, ParameterDirection.Input);
					command.Parameters.Add("p_status_code",OracleDbType.Int32,status_code,ParameterDirection.Input);
					command.ExecuteNonQuery();
					tx.Commit();
					txCommited = true;
				}
				finally
				{
					if(!txCommited) tx.Rollback();
				}
				DBLogger.Info("Mobipay: Результат отката транзакции № "+pay_id
					+": "+status_code+"("+status_msg+")");
			}
			finally
			{
				connect.Close();
				connect.Dispose();
			}
		}
		/// <summary>
		/// запись информации о подтверждении транзакции
		/// </summary>
		/// <param name="pay_id"></param>
		/// <param name="time_stamp"></param>
		/// <param name="status_code"></param>
		/// <param name="status_msg"></param>
		/// <param name="receipt"></param>		
		[WebMethod(EnableSession = true)]
		public void CommitTrans(long pay_id, 
			out string time_stamp, out int status_code, out string status_msg,
			out long receipt)
		{
			DBLogger.Info("Mobipay: Инициировано подтверждение транзакции № "+pay_id);
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			string strUsername = "";
			string strPassword = "";
			time_stamp  = "";
			status_code = 0;
			status_msg  = "";
			receipt = 0;
			try
			{
				// получаем данные из БД
				OracleCommand command = new OracleCommand();
				command.Connection = connect;				
				command.CommandText = @"set role mobinet";
				command.ExecuteNonQuery();
				command.CommandText = @"select mobi.GetMobUsername, mobi.GetMobPassword from dual";
				OracleDataReader reader = command.ExecuteReader();
				if(reader.Read()) 
				{
					if(!reader.IsDBNull(0)) strUsername = reader.GetString(0);
					if(!reader.IsDBNull(1)) strPassword = reader.GetString(1);					
				}						
				reader.Close();
				string urlParams = 
					"USERNAME="+strUsername
					+"&PASSWORD="+strPassword
					+"&ACT=1"
					+"&PAY_ID="+pay_id;
				// обращаемся к мобильному оператору
				string strXml = MobipayInvoke(urlParams);
				// разбираем ответ
				XmlDocument xmlDoc = new XmlDocument();
				xmlDoc.LoadXml(strXml);
				XmlNode node_status_code = xmlDoc.SelectSingleNode("/pay-response/status_code");
				XmlNode node_time_stamp  = xmlDoc.SelectSingleNode("/pay-response/time_stamp");
				XmlNode node_receipt  = xmlDoc.SelectSingleNode("/pay-response/receipt");
				Int32   v_status_code = Int32.Parse(node_status_code.InnerText);				
				string  v_time_stamp  = "";
				if(null!=node_time_stamp) v_time_stamp  = node_time_stamp.InnerText;
				if(null!=node_receipt) receipt = Int64.Parse(node_receipt.InnerText);

				time_stamp  = v_time_stamp;
				status_code = v_status_code;
				status_msg  = GetMobipayMessage(v_status_code);
				// записать результат в БД
				OracleTransaction tx = connect.BeginTransaction();
				bool txCommited = false;
				try
				{
					command.CommandText = "begin mobi.CommitTrans("
						+":p_pay_id,"
						+":p_time_stamp,"
						+":p_status_code,"
						+":p_receipt"
						+");"
						+"end;";

					command.Parameters.Clear();
					command.Parameters.Add("p_pay_id", OracleDbType.Long, pay_id, ParameterDirection.Input);
					if(time_stamp != string.Empty)
					{
						CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
						cinfo.DateTimeFormat.FullDateTimePattern = "dd.MM.yyyy HH:mm:ss";
						cinfo.DateTimeFormat.DateSeparator = ".";
						cinfo.DateTimeFormat.TimeSeparator = ":";
						DateTime dt_time_stamp = Convert.ToDateTime(time_stamp, cinfo.DateTimeFormat);				
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, dt_time_stamp, ParameterDirection.Input);
					}
					else
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, null, ParameterDirection.Input);
					command.Parameters.Add("p_status_code",OracleDbType.Int32,status_code,ParameterDirection.Input);
					command.Parameters.Add("p_receipt",OracleDbType.Int64,receipt,ParameterDirection.Input);
					command.ExecuteNonQuery();
					tx.Commit();
					txCommited = true;
				}
				finally
				{
					if(!txCommited) tx.Rollback();
				}
				DBLogger.Info("Mobipay: Результат подтверждения транзакции № "+pay_id
					+": "+status_code+"("+status_msg+")");
			}
			finally
			{
				connect.Close();
				connect.Dispose();
			}
		}
		/// <summary>
		/// Аннулирование зафиксированной транзакции
		/// </summary>
		/// <param name="pay_id"></param>
		/// <param name="time_stamp"></param>
		/// <param name="status_code"></param>
		/// <param name="status_msg"></param>
		[WebMethod(EnableSession = true)]
		public void RevokeTrans(int act, long pay_id, 
			out string time_stamp, out int status_code, out string status_msg)
		{
			DBLogger.Info("Mobipay: Инициировано аннулирование транзакции № "+pay_id);
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			string strUsername = "";
			string strPassword = "";
			time_stamp  = "";
			status_code = 0;
			status_msg  = "";
			string msisdn = "";
			long receipt = 0;
			long pay_amount = 0;
			string role_name = "";
			string table_name = "";
			if(2==act || 3==act) 
			{
				role_name = "mobinet_admin";
				table_name = "mobi_trans";
			}
			else if(0==act || 1==act)
			{
				role_name = "mobinet";
				table_name = "v_mobi_trans";
			}
			else
			{
				throw new Exception("Недопустимое значение параметра act");
			}
			try
			{
				// получаем данные из БД
				OracleCommand command = new OracleCommand();
				command.Connection = connect;				
				command.CommandText = @"set role "+role_name;
				command.ExecuteNonQuery();
				command.CommandText = @"select mobi.GetMobUsername,mobi.GetMobPassword,phone,receipt,s/100,sep_ref from "+table_name+" where trans=:pay_id";
				command.Parameters.Clear();
				command.Parameters.Add("pay_id", OracleDbType.Long, pay_id, ParameterDirection.Input);
				OracleDataReader reader = command.ExecuteReader();
				if(reader.Read()) 
				{
					if(!reader.IsDBNull(0)) strUsername = reader.GetString(0);
					if(!reader.IsDBNull(1)) strPassword = reader.GetString(1);
					if(!reader.IsDBNull(2)) msisdn = reader.GetString(2).Trim();
					if(!reader.IsDBNull(3)) receipt = (long)reader.GetDecimal(3);
					if(!reader.IsDBNull(4)) pay_amount = (long)reader.GetDecimal(4);
					if(!reader.IsDBNull(5)) throw new Exception("Транзакция "+pay_id+" уже входит в документ СЭП. Аннулирование невозможно.");

				}
				else
				{
					throw new Exception("Транзакция "+pay_id+" не найдена.");
				}
				reader.Close();
				string urlParams = 
					"USERNAME="+strUsername
					+"&PASSWORD="+strPassword
					+"&ACT=6"
					+"&PAY_ID="+pay_id
					+"&MSISDN="+msisdn
					+"&RECEIPT_NUM="+receipt
					+"&PAY_AMOUNT="+pay_amount+".00";
				// обращаемся к мобильному оператору
				string strXml = MobipayInvoke(urlParams);
				// разбираем ответ
				XmlDocument xmlDoc = new XmlDocument();
				xmlDoc.LoadXml(strXml);
				XmlNode node_status_code = xmlDoc.SelectSingleNode("/pay-response/status_code");
				XmlNode node_time_stamp  = xmlDoc.SelectSingleNode("/pay-response/time_stamp");
				Int32   v_status_code = Int32.Parse(node_status_code.InnerText);
				string  v_time_stamp  = "";
				if(null!=node_time_stamp) v_time_stamp  = node_time_stamp.InnerText;				

				time_stamp  = v_time_stamp;
				status_code = v_status_code;
				status_msg  = GetMobipayMessage(v_status_code);
				// записать результат в БД и сторнировать операцию
				OracleTransaction tx = connect.BeginTransaction();
				bool txCommited = false;
				try
				{
					command.CommandText = "begin mobi.RevokeTrans("
						+":p_pay_id,"
						+":p_time_stamp,"
						+":p_status_code"
						+");"
						+"end;";

					command.Parameters.Clear();
					command.Parameters.Add("p_pay_id", OracleDbType.Long, pay_id, ParameterDirection.Input);
					if(time_stamp != string.Empty)
					{
						CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
						cinfo.DateTimeFormat.FullDateTimePattern = "dd.MM.yyyy HH:mm:ss";
						cinfo.DateTimeFormat.DateSeparator = ".";
						cinfo.DateTimeFormat.TimeSeparator = ":";
						DateTime dt_time_stamp = Convert.ToDateTime(time_stamp, cinfo.DateTimeFormat);
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, dt_time_stamp, ParameterDirection.Input);
					}
					else
						command.Parameters.Add("p_time_stamp",OracleDbType.Date, null, ParameterDirection.Input);
					command.Parameters.Add("p_status_code",OracleDbType.Int32,status_code,ParameterDirection.Input);					
					command.ExecuteNonQuery();
					tx.Commit();
					txCommited = true;
				}
				finally
				{
					if(!txCommited) tx.Rollback();
				}
				DBLogger.Info("Mobipay: Результат аннулирования транзакции № "+pay_id
					+": "+status_code+"("+status_msg+")");
			}
			finally
			{
				connect.Close();
				connect.Dispose();
			}
		}

		[WebMethod(EnableSession = true)]
		public void ViewStatus(long pay_id, 
			out string time_stamp, 
			out int pay_status, out string pay_msg,
			out int status_code, out string status_msg)
		{
			DBLogger.Info("Mobipay: Инициирован запрос состояния транзакции № "+pay_id);
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			string strUsername = "";
			string strPassword = "";
			time_stamp  = "";
			pay_status = 0;
			pay_msg = "";
			status_code = 0;
			status_msg  = "";
			try
			{
				// получаем данные из БД
				OracleCommand command = new OracleCommand();
				command.Connection = connect;				
				command.CommandText = @"set role mobinet";
				command.ExecuteNonQuery();
				command.CommandText = @"select mobi.GetMobUsername, mobi.GetMobPassword from dual";
				OracleDataReader reader = command.ExecuteReader();
				if(reader.Read()) 
				{
					if(!reader.IsDBNull(0)) strUsername = reader.GetString(0);
					if(!reader.IsDBNull(1)) strPassword = reader.GetString(1);					
				}						
				reader.Close();
				string urlParams = 					
					"USERNAME="+strUsername
					+"&PASSWORD="+strPassword
					+"&ACT=3"
					+"&PAY_ID="+pay_id;
				// обращаемся к мобильному оператору
				string strXml = MobipayInvoke(urlParams);
				// разбираем ответ
				XmlDocument xmlDoc = new XmlDocument();
				xmlDoc.LoadXml(strXml);
				XmlNode node_status_code = xmlDoc.SelectSingleNode("/pay-response/status_code");
				XmlNode node_time_stamp  = xmlDoc.SelectSingleNode("/pay-response/time_stamp");
				Int32   v_status_code = Int32.Parse(node_status_code.InnerText);				
				string  v_time_stamp  = "";
				if(null!=node_time_stamp) v_time_stamp  = node_time_stamp.InnerText;				
				time_stamp  = v_time_stamp;
				status_code = v_status_code;
				status_msg  = GetMobipayMessage(v_status_code);
				XmlNode node_pay_status = xmlDoc.SelectSingleNode("/pay-response/pay_status");
				if(null!=node_pay_status) 
				{
					pay_status = Int32.Parse(node_pay_status.InnerText);
					pay_msg = GetMobipayMessage(pay_status);
				}
				DBLogger.Info("Mobipay: Результат запроса состояния транзакции № "+pay_id
					+": "+pay_status+"("+pay_msg+")"
					+": "+status_code+"("+status_msg+")");
			}
			finally
			{
				connect.Close();
				connect.Dispose();
			}
		}

		[WebMethod(EnableSession = true)]
		public void GetState(string strPhone, 
			out string balance, out string stored_name, out string account,
			out string time_stamp, out int status_code, out string status_msg)
		{
			DBLogger.Info("Mobipay: Инициирован запрос инф. об абоненте "+strPhone);
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			string strUsername = "";
			string strPassword = "";
			time_stamp  = "";
			status_code = 0;
			status_msg  = "";
			balance     = "";
			stored_name = "";
			account		= "";
			try
			{
				// получаем данные из БД
				OracleCommand command = new OracleCommand();
				command.Connection = connect;				
				command.CommandText = @"set role mobinet";
				command.ExecuteNonQuery();
				command.CommandText = @"select mobi.GetMobUsername, mobi.GetMobPassword from dual";
				OracleDataReader reader = command.ExecuteReader();
				if(reader.Read()) 
				{
					if(!reader.IsDBNull(0)) strUsername = reader.GetString(0);
					if(!reader.IsDBNull(1)) strPassword = reader.GetString(1);					
				}						
				reader.Close();
			}
			finally
			{
				if(ConnectionState.Closed!=connect.State) connect.Close();
			}
			string urlParams = 					
				"USERNAME="+strUsername
				+"&PASSWORD="+strPassword
				+"&ACT=7"
				+"&MSISDN="+strPhone;
			// обращаемся к мобильному оператору
			string strXml = MobipayInvoke(urlParams);
			// разбираем ответ
			XmlDocument xmlDoc = new XmlDocument();
			xmlDoc.LoadXml(strXml);
			XmlNode node_status_code = xmlDoc.SelectSingleNode("/pay-response/status_code");
			XmlNode node_time_stamp  = xmlDoc.SelectSingleNode("/pay-response/time_stamp");
			Int32   v_status_code = Int32.Parse(node_status_code.InnerText);				
			string  v_time_stamp  = "";
			if(null!=node_time_stamp) v_time_stamp  = node_time_stamp.InnerText;				
			time_stamp  = v_time_stamp;
			status_code = v_status_code;
			status_msg  = GetMobipayMessage(v_status_code);

			XmlNode node_balance = xmlDoc.SelectSingleNode("/pay-response/balance");
			if(null!=node_balance) balance = node_balance.InnerText;
			XmlNode node_name = xmlDoc.SelectSingleNode("/pay-response/name");
			if(null!=node_name) stored_name = node_name.InnerText;
			XmlNode node_account = xmlDoc.SelectSingleNode("/pay-response/account");
			if(null!=node_account) account = node_account.InnerText;
			DBLogger.Info("Mobipay: Абонент "+strPhone
				//balance, out string stored_name, out string account,
				+": Баланс="+balance
				+", Имя="+stored_name
				+", Лиц. счет="+account
				);

		}

		/// <summary>
		/// Оплата транзакции (порождение проводки)
		/// </summary>
		/// <param name="pay_id"></param>
		/// <param name="bank_ref"></param>
		[WebMethod(EnableSession = true)]
		public void PayTrans(long pay_id, long vdatflag, out long bank_ref)
		{
			DBLogger.Info("Mobipay: Инициирована оплата транзакции "+pay_id
				+", дата валютирования - "+(vdatflag==1?"будущая":"текущая"));
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			bank_ref = 0;
			try
			{
				// получаем данные из БД
				OracleCommand command = new OracleCommand();
				command.Connection = connect;				
				command.CommandText = @"set role mobinet";
				command.ExecuteNonQuery();								
				OracleTransaction tx = connect.BeginTransaction();
				bool txCommited = false;
				try
				{
					command.CommandText = "begin mobi.PayTrans("
						+":p_pay_id,"
						+":p_vdatflag,"
						+":p_bank_ref"
						+");"
						+"end;";

					command.Parameters.Clear();
					command.Parameters.Add("p_pay_id", OracleDbType.Long, pay_id, ParameterDirection.Input);
					command.Parameters.Add("p_vdatflag", OracleDbType.Long, vdatflag, ParameterDirection.Input);
					command.Parameters.Add("p_bank_ref",OracleDbType.Int64, bank_ref, ParameterDirection.Output);
					command.ExecuteNonQuery();
					
					bank_ref = ((OracleDecimal)command.Parameters["p_bank_ref"].Value).ToInt64();

					tx.Commit();
					txCommited = true;
				}
				finally
				{
					if(!txCommited) tx.Rollback();
				}
				DBLogger.Info("Mobipay: Транзакция "+pay_id
					+" оплачена. REF="+bank_ref);
			}
			finally
			{
				connect.Close();
				connect.Dispose();
			}			
		}

        /// <summary>
        /// Проверка доступа пользователя к операции и счетам
        /// </summary>
        [WebMethod(EnableSession = true)]
        public void CheckUserAccess()
        {
            DBLogger.Info("Mobipay: Проверка доступа пользователя к операции и счетам");
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;            
            try
            {                
                OracleCommand command = new OracleCommand();
                command.Connection = connect;
                command.CommandText = @"set role mobinet";
                command.ExecuteNonQuery();              
                command.CommandText = "begin mobi.CheckUserAccess; end;";
                command.ExecuteNonQuery();                
                DBLogger.Info("Mobipay: Проверка прошла успешно");
            }
            finally
            {
                connect.Close();
                connect.Dispose();
            }
        }

		/// <summary>
		/// Сформировать платеж в СЭП
		/// </summary>
		/// <param name="bank_ref"></param>
		[WebMethod(EnableSession = true)]
		public long[] MakeSEPPayment(string date1, string date2)
		{
			DBLogger.Info("Mobipay: Инициировано формирование платежа в СЭП c "
				+date1+" по "+date2);
			CultureInfo cinfo = CultureInfo.CreateSpecificCulture("en-GB");
			cinfo.DateTimeFormat.FullDateTimePattern = "dd.MM.yyyy HH:mm:ss";
			cinfo.DateTimeFormat.DateSeparator = ".";
			cinfo.DateTimeFormat.TimeSeparator = ":";
			DateTime dt1 = Convert.ToDateTime(date1, cinfo.DateTimeFormat);
			DateTime dt2 = Convert.ToDateTime(date2, cinfo.DateTimeFormat);

			string ref_list = new string(' ',4096);

            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			try
			{
				// получаем данные из БД
				OracleCommand command = new OracleCommand();
				command.Connection = connect;				
				command.CommandText = @"set role mobinet_admin";
				command.ExecuteNonQuery();								
				OracleTransaction tx = connect.BeginTransaction();
				bool txCommited = false;
				try
				{
					command.CommandText = "begin mobi.MakeSEPPayment(:p_date1,:p_date2,:ref_list); end;";

					command.Parameters.Clear();
					command.Parameters.Add("p_date1", OracleDbType.Date, dt1, ParameterDirection.Input);
					command.Parameters.Add("p_date2", OracleDbType.Date, dt2, ParameterDirection.Input);
					command.Parameters.Add("ref_list",OracleDbType.Varchar2, 4096, ref_list, ParameterDirection.Output);
					command.ExecuteNonQuery();
					
					if(command.Parameters["ref_list"].Status==OracleParameterStatus.NullFetched)
						ref_list = string.Empty;
					else
						ref_list = (string)((Oracle.DataAccess.Types.OracleString)command.Parameters["ref_list"].Value).Value;

					tx.Commit();
					txCommited = true;
				}
				finally
				{
					if(!txCommited) tx.Rollback();
				}
			}
			finally
			{
				connect.Close();
				connect.Dispose();
			}
			if(string.Empty == ref_list) return null;
			string[] str_refs = ref_list.Split(',');
			long[] refs = new long[str_refs.Length];
			for(int i=0;i<refs.Length;i++) refs[i] = long.Parse(str_refs[i]);
			DBLogger.Info("Mobipay: Платеж в СЭП успешно сформирован");
			return refs;
		}
		/// <summary>
		/// возвращает описание кода ошибки MobiPay
		/// </summary>
		/// <param name="code"></param>
		/// <returns></returns>
		[WebMethod(EnableSession = true)]
		public string GetMobipayMessage(int code)
		{
			string strMsg = null;
            OracleConnection connect = Bars.Classes.OraConnector.Handler.UserConnection;
			try
			{
				OracleCommand command = new OracleCommand();
				command.Connection = connect;

				// устанавливаем роль
				command.CommandText = @"set role mobinet";
				command.ExecuteNonQuery();
				command.CommandText = @"select mobi.GetErrorMsg(:code) from dual";
				command.Parameters.Clear();
				command.Parameters.Add("code", OracleDbType.Int64, code, ParameterDirection.Input);
				OracleDataReader reader = command.ExecuteReader();
				if(reader.Read()) 
				{
					if(!reader.IsDBNull(0)) strMsg = reader.GetString(0);
				}						
				reader.Close();
			}
			finally
			{	
				connect.Close();
				connect.Dispose();
			}
			return strMsg;
		}
	}
	internal  enum    CertificateProblem  : uint
	{	
		CertEXPIRED                   = 0x800B0101,
		CertVALIDITYPERIODNESTING     = 0x800B0102,
		CertROLE                      = 0x800B0103,
		CertPATHLENCONST              = 0x800B0104,
		CertCRITICAL                  = 0x800B0105,
		CertPURPOSE                   = 0x800B0106,
		CertISSUERCHAINING            = 0x800B0107,
		CertMALFORMED                 = 0x800B0108,
		CertUNTRUSTEDROOT             = 0x800B0109,
		CertCHAINING                  = 0x800B010A,
		CertREVOKED                   = 0x800B010C,
		CertUNTRUSTEDTESTROOT         = 0x800B010D,
		CertREVOCATION_FAILURE        = 0x800B010E,
		CertCN_NO_MATCH               = 0x800B010F,
		CertWRONG_USAGE               = 0x800B0110,
		CertUNTRUSTEDCA               = 0x800B0112
	}

	internal class CertificateValidation : ICertificatePolicy
	{
		private int     _nProblem;
		private string  _strProblem;

		public int GetProblemCode()
		{
			return _nProblem;
		}
		public string GetProblemMsg()
		{
			return _strProblem;
		}
		public bool CheckValidationResult(ServicePoint sp, X509Certificate cert,
			WebRequest request, int problem)
		{        
			if(0==problem) return true;
			else
			{	
				bool allowUntrustedRoot = false;
				bool allowNoMatch = false;
				bool ignoreCertError = false;
				string strUntrustedRoot = ConfigurationSettings.AppSettings["Mobipay.AllowUntrustedRoot"];
				if(null!=strUntrustedRoot)
					allowUntrustedRoot = System.Boolean.Parse(strUntrustedRoot);

				string strNoMatch = ConfigurationSettings.AppSettings["Mobipay.AllowNoMatch"];
				if(null!=strNoMatch)
					allowNoMatch = System.Boolean.Parse(strNoMatch);

				string strIgnoreCertError = ConfigurationSettings.AppSettings["Mobipay.IgnoreCertError"];
				if(null!=strIgnoreCertError)
					ignoreCertError = System.Boolean.Parse(strIgnoreCertError);
				// если неудостоверенные сертификаты от мобильного оператора разрешены ==>
				// игнорировать предупреждение
				if(allowUntrustedRoot 
				&& CertificateProblem.CertUNTRUSTEDROOT==(CertificateProblem)problem) return true;
			
				if(allowNoMatch 
					&& CertificateProblem.CertCN_NO_MATCH==(CertificateProblem)problem) return true;

				if(ignoreCertError) return true;
				_nProblem = problem;
				_strProblem = "Certificate Problem with accessing URL via HTTPS"+"\n"
					+string.Format("Problem code 0x{0:X8},",(int)problem)+"\n"
					+GetProblemMessage((CertificateProblem)problem)+"\n";
				return false;
			}
		}
    
		private String GetProblemMessage(CertificateProblem Problem)
		{
			String ProblemMessage = "";
			String ProblemCodeName = Enum.GetName(typeof(CertificateProblem),Problem);
			if(ProblemCodeName != null)
				ProblemMessage = ProblemMessage + "Certificateproblem:" +
					ProblemCodeName;
			else
				ProblemMessage = "Unknown Certificate Problem";
			return ProblemMessage;
		}
	}
	internal class MobipayException : Exception
	{		
		public MobipayException() : base() 
		{
		}
		public MobipayException(string message) : base(message) 
		{
		}
		public MobipayException(string message, Exception innerException) : 
			base(message, innerException) 
		{
		}
		public MobipayException(System.Runtime.Serialization.SerializationInfo info, 
			System.Runtime.Serialization.StreamingContext context) : 
			base(info, context) 
		{
		}
	}
}
