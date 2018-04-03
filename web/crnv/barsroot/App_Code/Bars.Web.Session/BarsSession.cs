/// Copyright (c) UNITY-BARS. 
/// 
/// Собственная реализация хранения состояния сессии.
/// Переменные сессии доступны как из кода С#, 
/// так и со стороны сервера
///
/// Зависимости (ORACLE):
///  - Пакет процедур BARSWEB_SESSION
///  - Таблица BARSWEB_SESSION_DATA
/// 
///  Зависимости (C#):
///  - Bars.Oracle.dll
///  
///  Описание использования см. Solution Items\readme.txt

using System;
using System.Collections.Generic;
using System.Text;
using Bars.Oracle;
using Oracle.DataAccess.Client;
using System.Web.SessionState;
using System.Globalization;

namespace Bars.Web.Session
{
    /// <summary>
    /// Объект для обеспечения подключения к базе
    /// </summary>
    internal class OraConnectHelper
    {
        private OracleConnection oraConnection;
        private Bars.Oracle.Connection barsOracle;

        /// <summary>
        /// Конструктор использующий существующее соединение. В процессе работы будет использовать его.
        /// </summary>
        /// <param name="Connection">Экземпляр существующего соединения</param>
        public OraConnectHelper(OracleConnection Connection)
        {
            oraConnection = Connection;
        }
        /// <summary>
        /// Конструктор по-умолчанию. В процессе работы создаст новое подключение.
        /// </summary>
        public OraConnectHelper()
        {
            barsOracle = new Bars.Oracle.Connection();
        }

        /// <summary>
        /// Инициирует пользовательское подключение к базе.
        /// Если подключение существует - оно будет повторно использовано
        /// </summary>
        public void InitializeConnection()
        {
            if (null == oraConnection)
                oraConnection = barsOracle.GetUserConnection();
        }

        /// <summary>
        /// Закрывает подключение к БД
        /// </summary>
        public void DisposeConnection()
        {
            if (null != oraConnection)
            {
                oraConnection.Close();
                oraConnection.Dispose();
                oraConnection = null;
            }
        }

        /// <summary>
        /// Возвращает экземпляр объекта соединения
        /// </summary>
        public OracleConnection Connection
        {
            get { return oraConnection; }
        }
    }

    /// <summary>
    /// Объект, предоставляющий возможность работы с переменными сессии как
    /// на стороне ASP.NET, так и из ORACLE. 
    /// ORACLE: доступ осуществляется посредством пакета BARSWEB_SESSION 
    /// ASP.NET: посредством свойства-индексатора данного класса
    /// </summary>
    public class BarsSession
    {
        #region private members

        private OraConnectHelper db;
        private bool isWorkStarted;
        private bool isExternalConnectionUsed;

        /// <summary>
        /// Преобразовывает объект в строку с заданным форматированием
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private string convertToString(object val)
        {
            string res = String.Empty;

            CultureInfo cinfo = SessionCulture;

            //типы, которые зависят от culture info
            if (val.GetType() == typeof(DateTime))
                res = ((DateTime)val).ToString(cinfo);
            if (val.GetType() == typeof(Single))
                res = ((Single)val).ToString(cinfo);
            if (val.GetType() == typeof(Double))
                res = ((double)val).ToString(cinfo);
            if (val.GetType() == typeof(Decimal))
                res = ((decimal)val).ToString(cinfo); 

            //независимые от culture info типы
            if (val.GetType() == typeof(Boolean) ||
                val.GetType() == typeof(Byte)    ||
                val.GetType() == typeof(Int16)   ||
                val.GetType() == typeof(Int32)   ||
                val.GetType() == typeof(UInt16) ||
                val.GetType() == typeof(UInt32)  ||
                val.GetType() == typeof(Int64)   ||
                val.GetType() == typeof(UInt64)  ||
                val.GetType() == typeof(Char)    ||
                val.GetType() == typeof(String))
            {
                res = val.ToString();
            }

            if (String.Empty == res)
                throw new ArgumentException(Resources.Bars.Web.Session.Resource.ObjectsNotAllowedException);

            return res;

        }
        
        #endregion

        #region public members

        /// <summary>
        /// Возвращает используемую для хранения CultureInfo
        /// </summary>
        public CultureInfo SessionCulture
        {
            get 
            {
                CultureInfo cinfo = CultureInfo.CreateSpecificCulture(Resources.Bars.Web.Session.Resource.OurCulture.ToString());
                cinfo.DateTimeFormat.ShortDatePattern = Resources.Bars.Web.Session.Resource.ShortDateFormat;
                cinfo.DateTimeFormat.FullDateTimePattern = Resources.Bars.Web.Session.Resource.FullDateFormat;
                cinfo.DateTimeFormat.DateSeparator = Resources.Bars.Web.Session.Resource.DateSeparator;
                cinfo.DateTimeFormat.TimeSeparator = Resources.Bars.Web.Session.Resource.TimeSeparator;
                cinfo.NumberFormat.CurrencyDecimalSeparator = Resources.Bars.Web.Session.Resource.NumberSeparator;
                cinfo.NumberFormat.NumberDecimalSeparator = Resources.Bars.Web.Session.Resource.NumberSeparator;
                return cinfo;
            }
        }

        /// <summary>
        /// Конструктор по-умолчанию. В процессе работы создаст новое подключение.
        /// </summary>
        public BarsSession()
        {
            db = new OraConnectHelper();
        }

        /// <summary>
        /// Конструктор, использующий существующее соединение. В процессе работы будет использовать его.
        /// </summary>
        /// <param name="Connection">Экземпляр существующего соединения</param>
        public BarsSession(OracleConnection Connection)
        {
            db = new OraConnectHelper(Connection);
            isExternalConnectionUsed = null != Connection;
        }

        /// <summary>
        /// Очистка всех параметров для текущего пользователя и сессии
        /// </summary>
        public void CleanUp()
        {
            db.InitializeConnection();
            try
            {
                OracleCommand command = db.Connection.CreateCommand();
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.CommandText = "barsweb_session.clean_up";
                command.ExecuteNonQuery();
            }
            finally
            {
                db.DisposeConnection();
            }
        }

        /// <summary>
        /// Свойство-индексатор для доступа к значениям переменных сессии.
        /// Если перед вызовом не был вызван метод BeginWork(), 
        /// каждое чтение/запись будет инициировать подключение к БД
        /// </summary>
        /// <param name="name">Имя переменной</param>
        /// <returns>Значение переменной</returns>
        public object this[string name]
        {
            get 
            {
                //подключиться если еще этого не сделали
                db.InitializeConnection();

                try
                {
                    OracleCommand command = db.Connection.CreateCommand();
                    command.CommandText = "select barsweb_session.get_varchar2(:p_name) from dual";
                    command.Parameters.Add("p_name", OracleDbType.Varchar2, 32).Value = name;
                    return command.ExecuteScalar();
                }
                finally
                {
                    //не отключаться если был вызван метод BeginWork()
                    if (!isWorkStarted && !isExternalConnectionUsed)
                        db.DisposeConnection();
                }
                
            }
            set 
            {
                if (String.IsNullOrEmpty(name))
                    throw new ArgumentException(Resources.Bars.Web.Session.Resource.NameIsNullException);

                string val = convertToString(value);

                //подключиться если еще этого не сделали
                db.InitializeConnection();

                try
                {
                    OracleCommand command = db.Connection.CreateCommand();
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.CommandText = "barsweb_session.set_varchar2";
                    command.Parameters.Clear();
                    command.Parameters.Add("p_var_name", OracleDbType.Varchar2, 32).Value = name;
                    command.Parameters.Add("p_var_value", OracleDbType.Varchar2, 4000).Value = val;
                    command.ExecuteNonQuery();
                }
                finally
                {
                    //не отключаться если был вызван метод BeginWork()
                    if (!isWorkStarted && !isExternalConnectionUsed)
                        db.DisposeConnection();
                }
            }
        }

        /// <summary>
        /// Начало работы с переменными сессии. 
        /// Если соединение отсутствует - оно будет открыто.
        /// Метод предназначен для случаев, когда в одном соединении нужно 
        /// неоднократно обновлять/читать переменные сессии. Для окончания работы
        /// необходимо вызвать метод EndWork()
        /// </summary>
        public void BeginWork()
        {
            db.InitializeConnection();
            isWorkStarted = true;
        }

        /// <summary>
        /// Конец работы с переменными сессии (закрывает соединение)
        /// </summary>
        public void EndWork()
        {
            if (isWorkStarted)
            {
                db.DisposeConnection();
                isWorkStarted = false;
            }
        }

        #endregion

    }

}
