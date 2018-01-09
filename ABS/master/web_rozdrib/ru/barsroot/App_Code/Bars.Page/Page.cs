using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Globalization;
using System.Threading;
using Bars.Exception;
using Bars.Oracle;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Bars.Configuration;

namespace Bars
{
	public class BarsPage : Page
	{ 
		IOraConnection	 _hsql;
		OracleConnection _connect;
		OracleCommand    _command;
		OracleDataReader _reader;
		OracleTransaction _transaction;
        //-----------------------------------------------
		public BarsPage(){}

		public IOraConnection hsql
		{
			get
			{
				if(_hsql == null)
				{
					_hsql  = OraConnector.Handler.IOraConnection;
				}
				return _hsql;
			}
		}
		
		/// <summary>
		/// Начать транзакцию
		/// </summary>
		public void BeginTransaction()
		{
			_transaction = _connect.BeginTransaction();
		}
		/// <summary>
		/// Commit транзакции
		/// </summary>
		public void commitTransaction()
		{
			_transaction.Commit();
		}
		/// <summary>
		/// Rollback  транзакции
		/// </summary>
		public void RollbackTransaction()
		{
			_transaction.Rollback();
		}
		/// <summary>
		/// Строка соединения
		/// </summary>
		/// <param name="ctx">Контекст</param>
		/// <returns>строка соединения</returns>
		public string ConnectionString(HttpContext ctx)
		{
			return hsql.GetUserConnectionString();
		}

        /// <summary>
        /// Инициализация работы с базой для технического пользователя
        /// </summary>
        public void InitWebTechConnection()
        {
            if (_connect == null)
            {
                _connect = new OracleConnection(Bars.Configuration.ConfigurationSettings.GetTechConnectionString());
                _connect.Open();
            }
            _command = new OracleCommand();
        }


		/// <summary>
		/// Инициализация работы с базой
		/// </summary>
		/// <param name="ctx">Контекст</param>
		public void InitOraConnection(HttpContext ctx)
		{
            if (_connect == null)
                _connect = hsql.GetUserConnection();
			_command = new OracleCommand();
		}
		/// <summary>
		/// Инициализация работы с базой
		/// </summary>
		/// <param name="connstr">строка соединения</param>
		public void InitOraConnection(string connstr)
		{
            if (_connect == null)
			    _connect = new OracleConnection(connstr);
			_connect.Open();
			_command = new OracleCommand();
		}
		/// <summary>
		/// Инициализация работы с базой
		/// </summary>
		public void InitOraConnection()
		{
            if (_connect == null)
			    _connect = hsql.GetUserConnection();
			_command = new OracleCommand();
		}
		public void SetLONGFetchSize(int size)
		{
			_command.InitialLONGFetchSize = size;
		}
		public void SetLOBFetchSize(int size)
		{
			_command.InitialLOBFetchSize = size;
		}	
		public void SetFetchSize(int size)
		{
			_command.FetchSize = size;
		}
		/// <summary>
		/// Установка роли
		/// </summary>
		/// <param name="role">имя роли</param>
		public void SetRole(string role)
		{
			_command.Connection = _connect;
			_command.CommandText = hsql.GetSetRoleCommand(role.ToUpper());
			try
			{
				_command.ExecuteNonQuery();
			}
			catch(System.Exception ex)
			{
				throw(new RoleException(role,ex));
			}
		}
		/// <summary>
		/// Взять глобальный параметр из таблицы Params
		/// </summary>
		/// <param name="parName"></param>
		/// <returns></returns>
		public string GetGlobalParam(string parName,string roleName)
		{
			if(_connect == null)  InitOraConnection();
			object parValue = AppDomain.CurrentDomain.GetData("WPARAM_"+parName);
			if(parValue == null)
			{
				SetRole(roleName);
				_command.Parameters.Add("par",OracleDbType.Varchar2,parName,ParameterDirection.Input);
				_command.CommandText = "select val from params where par=:par";
				parValue = _command.ExecuteScalar();
				_command.Parameters.Clear();
				AppDomain.CurrentDomain.SetData("WPARAM_"+parName,parValue);
			}
			return Convert.ToString(parValue);
		}
		/// <summary>
		/// Commit текущего соединения
		/// </summary>
		public void Commit()
		{
			_command.Connection = _connect;
			_command.CommandText = "commit";
			_command.ExecuteNonQuery();
		}
		/// <summary>
		/// Добавить параметр запроса
		/// </summary>
		/// <param name="name">имя параметра</param>
		/// <param name="type">тип(перечисление DB_TYPE)</param>
		/// <param name="val">значение параметра</param>
		/// <param name="direct">direction(перечисление DIRECTION)</param>
		public void SetParameters(string name,DB_TYPE type,object val,DIRECTION direct)
		{
			_command.Parameters.Add(name,(OracleDbType)type,val,(ParameterDirection)direct);
		}

        /// <summary>
        /// Добавить параметр запроса
        /// </summary>
        /// <param name="name">имя параметра</param>
        /// <param name="type">тип(перечисление DB_TYPE)</param>
        /// <param name="direct">direction(перечисление DIRECTION)</param>
        public void SetParameters(string name, DB_TYPE type, DIRECTION direct)
        {
            _command.Parameters.Add(name, (OracleDbType)type, (ParameterDirection)direct);
        }

        /// <summary>
		/// Удалить все параметры текущего OracleCommand 
		/// </summary>
		public void ClearParameters()
		{
			_command.Parameters.Clear(); 
		}
		/// <summary>
		/// Получить параметр
		/// </summary>
		/// <param name="name">имя параметра</param>
		/// <returns>значение параметра</returns>
		public object GetParameter(string name)
		{
			return _command.Parameters[name].Value;
		}
		/// <summary>
		/// Заполняет DataSet заданым запросом
		/// </summary>
		/// <param name="query">запрос</param>
		/// <returns>DataSet</returns>
		public DataSet SQL_SELECT_dataset(string query)
		{
			OracleDataAdapter adapter = new OracleDataAdapter();
			DataSet ds = new DataSet("NewDataSet");
			_command.Connection = _connect;
			adapter.SelectCommand = _command;
			_command.CommandText = query;
			adapter.Fill(ds);
            adapter.Dispose();
			return ds;
		}
		/// <summary>
		/// Заполняет DataSet строками начиная с номера [startpos] и количеством [maxpos] строк
		/// </summary>
		/// <param name="query">запрос</param>
		/// <param name="startpos">начальный номер строки</param>
		/// <param name="maxpos">количество строк</param>
		/// <returns></returns>
		public DataSet SQL_SELECT_dataset(string query,int startpos,int maxpos)
		{
			OracleDataAdapter adapter = new OracleDataAdapter();
			DataSet ds = new DataSet("NewDataSet");
			_command.Connection = _connect;
			adapter.SelectCommand = _command;
			_command.CommandText = query;
			adapter.Fill(ds,startpos,maxpos,"Table");
            adapter.Dispose();
			return ds;
		}
		/// <summary>
		/// Возвращает скалярный результат выполнения запроса
		/// </summary>
		/// <param name="query">запрос</param>
		/// <returns>значение</returns>
		public object SQL_SELECT_scalar(string query)
		{
			OracleDataReader reader = null;
			_command.Connection = _connect;
			_command.CommandText = query;
			object temp = null;
			reader = _command.ExecuteReader();
			if(reader.Read())
			{ 
				if(reader.IsDBNull(0)) temp = null;
				else temp = reader.GetValue(0);	
			}
            reader.Close();
            reader.Dispose();
			return temp;
		}

		/// <summary>
		/// Возвращает массив результатов выполнения запроса(первая строчка таблицы)
		/// </summary>
		/// <param name="query">запрос</param>
		/// <returns>ArrayList значений</returns>
		public ArrayList SQL_reader(string query)
		{
			ArrayList array = new ArrayList();
			OracleDataReader reader = null;
			_command.Connection = _connect;
			_command.CommandText = query;
			reader = _command.ExecuteReader();
			if(reader.Read())
			{
				for(int i = 0; i < reader.FieldCount; i++)
				{
					if(reader.IsDBNull(i)) array.Insert(i,"");
					else array.Insert(i,reader.GetValue(i));
				}
			}
            reader.Close();
            reader.Dispose();
			return array;
		}
		/// <summary>
		/// Возвращает массив результатов выполнения запроса (первая строчка таблицы)
		/// </summary>
		/// <param name="query">запрос</param>
		/// <returns>масив object[1000] значений</returns>
		public object[] SQL_SELECT_reader(string query)
		{
			OracleDataReader reader = null;
			_command.Connection = _connect;
			_command.CommandText = query;
			object[] temp = new object[1000];
			reader = _command.ExecuteReader();
			if(reader.Read())
			{
				for(int i = 0; i < reader.FieldCount; i++)
				{
					if(reader.IsDBNull(i)) temp[i] = null;
					else temp[i] = reader.GetValue(i);
				}
			}
			else 
				temp = null;
            reader.Close();
            reader.Dispose();
			return temp;
		}

		/// <summary>
		/// Выполнить Reader
		/// </summary>
		/// <param name="query">запрос</param>
		public void SQL_Reader_Exec(string query)
		{
			_command.Connection = _connect;
			_command.CommandText = query;
			_reader = _command.ExecuteReader();
		}
		/// <summary>
		/// Чтение Reader
		/// </summary>
		/// <returns></returns>
		public bool SQL_Reader_Read()
		{
			return _reader.Read();
		}
		/// <summary>
		/// Вычитка значения текущей строчки
		/// </summary>
		/// <returns>ArrayList значений</returns>
		public ArrayList SQL_Reader_GetValues()
		{
			ArrayList array = new ArrayList();
			for(int i = 0; i < _reader.FieldCount; i++)
			{
				if(_reader.IsDBNull(i)) array.Insert(i,"");
				else array.Insert(i,_reader.GetValue(i));
			}
			return array;
		}
		/// <summary>
		/// Закрыть Reader
		/// </summary>
		public void SQL_Reader_Close()
		{
			_reader.Close();
			_reader.Dispose();
		}

		/// <summary>
		/// Возвращает строчку значений первого столбца разделенных ';'
		/// </summary>
		/// <param name="query">запрос</param>
		/// <returns>строка значений</returns>
		public string SQL_SELECT_list(string query)
		{
			OracleDataReader reader = null;
			_command.Connection = _connect;
			_command.CommandText = query;
			string temp = ""; 
			reader = _command.ExecuteReader();
			while(reader.Read())
			{
				temp += Convert.ToString(reader.GetValue(0))+";";
			}
            reader.Close();
            reader.Dispose();
			return temp;
		}
		/// <summary>
		/// Выполняет SQL-выражение
		/// </summary>
		/// <param name="query">выражение</param>
		/// <returns>количество измененных строк</returns>
		public int SQL_NONQUERY(string query)
		{
			int pos = -1;
			_command.Connection = _connect;
			_command.CommandText = query;
			pos = _command.ExecuteNonQuery();			
			return pos;
		}
		/// <summary>
		/// Выполняет процедуру по имени
		/// </summary>
		/// <param name="proc_name">имя процедуры</param>
		/// <returns></returns>
		public int SQL_PROCEDURE(string proc_name)
		{
			int pos = -1;
			_command.Connection = _connect;
			_command.CommandType = CommandType.StoredProcedure;
			_command.CommandText = proc_name;
			pos = _command.ExecuteNonQuery();
			_command.CommandType = CommandType.Text;
			return pos;
		}
		/// <summary>
		/// Закрыть текущее соединение
		/// </summary>
		public void DisposeOraConnection()
		{
			if(_connect != null)
			{
				_connect.Close();
				_connect.Dispose();
                _connect = null;
			}	
			if(_command != null)
				_command.Dispose();
            if (_reader != null)
            {
                _reader.Close();
                _reader.Dispose();
            }
		} 

		//Перечисления
		//-----------------------------------------------
		public enum DB_TYPE
		{
			Byte = OracleDbType.Byte,
			Char = OracleDbType.Char,
			Date = OracleDbType.Date,
			Decimal = OracleDbType.Decimal,
			Double = OracleDbType.Double,
			Int16 = OracleDbType.Int16,
			Int32 = OracleDbType.Int32,
			Int64 = OracleDbType.Int64,
			Varchar2 = OracleDbType.Varchar2,
			XmlType = OracleDbType.XmlType,
			RefCursor = OracleDbType.XmlType,
			Clob = OracleDbType.Clob,
			BFile = OracleDbType.BFile,
			Blob = OracleDbType.Blob,
			Long = OracleDbType.Long,
			LongRaw = OracleDbType.LongRaw,
			NChar = OracleDbType.NChar,
			NClob = OracleDbType.NClob,
			NVarchar2 = OracleDbType.NVarchar2,
			Raw = OracleDbType.Raw,
			TimeStamp = OracleDbType.TimeStamp
		};
		public enum DIRECTION
		{
			Input = ParameterDirection.Input,
			InputOutput = ParameterDirection.InputOutput,
			Output = ParameterDirection.Output,
			ReturnValue = ParameterDirection.ReturnValue
		};
		//Константы из Century
		public enum CUST_TYPE 
		{
			BANK=1,
			CORPS,
			PERSON
		};
		public enum ACC_TYPE 
		{
			ACTIV=1,
			PASSIV,
			ACTIVPASSIV
		};
		public enum OPER_TYPE 
		{
			DEBET=0,
			KREDIT,
			DEBET_INFO,
			KREDIT_INFO
		};
		public enum VIEWACC_TYPE 
		{
			ALL_ACCOUNTS=0,
			CUST_ACCOUNTS,
			TECH_ACCOUNTS,
			TECH_ACCOUNTS_EX,
			USER_ACCOUNTS,
			NALOG_ACCOUNTS,
			LNK_ACCOUNTS
		};
		public enum AVIEW 
		{
			AVIEW_TECH=0x0001,
			AVIEW_CUST = 0x0002,
			AVIEW_USER = 0x0004,
			AVIEW_ALL  = 0x0008,
			AVIEW_ReadOnly  = 0x0010,
			AVIEW_ExistOnly  = 0x0400,
			AVIEW_NoClose    = 0x8000,
			AVIEW_NoOpen     = 0x10000,
			AVIEW_NoUpdate   = 0x20000,
			AVIEW_NoEdit     = 0x40000,
			AVIEW_Financial  = 0x0020,
			AVIEW_Linked 	 = 0x0040,
			AVIEW_Limit  	 = 0x0080,
			AVIEW_Access 	 = 0x0100,
			AVIEW_Special	 = 0x0200,
			AVIEW_Blocked    = 0x0800,
			AVIEW_AllOptions = 0x2BE0,
			AVIEW_Interest   = 0x2000,
			AVIEW_NoHistory  = 0x1000,
			AVIEW_NoTurns    = 0x4000,
			AVIEW_TAX    = 0x0201,
			AVIEW_LINKED = 0x0202,
			AVIEW_HIST = 0x0100
		};	
		public enum ACCESS 
		{
			ACCESS_FULL=1,
			ACCESS_READONLY,
			ACCESS_HOLDING
		};
	}
}
