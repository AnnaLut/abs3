/// Copyright (c) UNITY-BARS. 
/// 
/// ����������� ���������� �������� ��������� ������.
/// ���������� ������ �������� ��� �� ���� �#, 
/// ��� � �� ������� �������
///
/// ����������� (ORACLE):
///  - ����� �������� BARSWEB_SESSION
///  - ������� BARSWEB_SESSION_DATA
/// 
///  ����������� (C#):
///  - Bars.Oracle.dll
///  
///  �������� ������������� ��. Solution Items\readme.txt

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
    /// ������ ��� ����������� ����������� � ����
    /// </summary>
    internal class OraConnectHelper
    {
        private OracleConnection oraConnection;
        private Bars.Oracle.Connection barsOracle;

        /// <summary>
        /// ����������� ������������ ������������ ����������. � �������� ������ ����� ������������ ���.
        /// </summary>
        /// <param name="Connection">��������� ������������� ����������</param>
        public OraConnectHelper(OracleConnection Connection)
        {
            oraConnection = Connection;
        }
        /// <summary>
        /// ����������� ��-���������. � �������� ������ ������� ����� �����������.
        /// </summary>
        public OraConnectHelper()
        {
            barsOracle = new Bars.Oracle.Connection();
        }

        /// <summary>
        /// ���������� ���������������� ����������� � ����.
        /// ���� ����������� ���������� - ��� ����� �������� ������������
        /// </summary>
        public void InitializeConnection()
        {
            if (null == oraConnection)
                oraConnection = barsOracle.GetUserConnection();
        }

        /// <summary>
        /// ��������� ����������� � ��
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
        /// ���������� ��������� ������� ����������
        /// </summary>
        public OracleConnection Connection
        {
            get { return oraConnection; }
        }
    }

    /// <summary>
    /// ������, ��������������� ����������� ������ � ����������� ������ ���
    /// �� ������� ASP.NET, ��� � �� ORACLE. 
    /// ORACLE: ������ �������������� ����������� ������ BARSWEB_SESSION 
    /// ASP.NET: ����������� ��������-����������� ������� ������
    /// </summary>
    public class BarsSession
    {
        #region private members

        private OraConnectHelper db;
        private bool isWorkStarted;
        private bool isExternalConnectionUsed;

        /// <summary>
        /// ��������������� ������ � ������ � �������� ���������������
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        private string convertToString(object val)
        {
            string res = String.Empty;

            CultureInfo cinfo = SessionCulture;

            //����, ������� ������� �� culture info
            if (val.GetType() == typeof(DateTime))
                res = ((DateTime)val).ToString(cinfo);
            if (val.GetType() == typeof(Single))
                res = ((Single)val).ToString(cinfo);
            if (val.GetType() == typeof(Double))
                res = ((double)val).ToString(cinfo);
            if (val.GetType() == typeof(Decimal))
                res = ((decimal)val).ToString(cinfo); 

            //����������� �� culture info ����
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
        /// ���������� ������������ ��� �������� CultureInfo
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
        /// ����������� ��-���������. � �������� ������ ������� ����� �����������.
        /// </summary>
        public BarsSession()
        {
            db = new OraConnectHelper();
        }

        /// <summary>
        /// �����������, ������������ ������������ ����������. � �������� ������ ����� ������������ ���.
        /// </summary>
        /// <param name="Connection">��������� ������������� ����������</param>
        public BarsSession(OracleConnection Connection)
        {
            db = new OraConnectHelper(Connection);
            isExternalConnectionUsed = null != Connection;
        }

        /// <summary>
        /// ������� ���� ���������� ��� �������� ������������ � ������
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
        /// ��������-���������� ��� ������� � ��������� ���������� ������.
        /// ���� ����� ������� �� ��� ������ ����� BeginWork(), 
        /// ������ ������/������ ����� ������������ ����������� � ��
        /// </summary>
        /// <param name="name">��� ����������</param>
        /// <returns>�������� ����������</returns>
        public object this[string name]
        {
            get 
            {
                //������������ ���� ��� ����� �� �������
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
                    //�� ����������� ���� ��� ������ ����� BeginWork()
                    if (!isWorkStarted && !isExternalConnectionUsed)
                        db.DisposeConnection();
                }
                
            }
            set 
            {
                if (String.IsNullOrEmpty(name))
                    throw new ArgumentException(Resources.Bars.Web.Session.Resource.NameIsNullException);

                string val = convertToString(value);

                //������������ ���� ��� ����� �� �������
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
                    //�� ����������� ���� ��� ������ ����� BeginWork()
                    if (!isWorkStarted && !isExternalConnectionUsed)
                        db.DisposeConnection();
                }
            }
        }

        /// <summary>
        /// ������ ������ � ����������� ������. 
        /// ���� ���������� ����������� - ��� ����� �������.
        /// ����� ������������ ��� �������, ����� � ����� ���������� ����� 
        /// ������������ ���������/������ ���������� ������. ��� ��������� ������
        /// ���������� ������� ����� EndWork()
        /// </summary>
        public void BeginWork()
        {
            db.InitializeConnection();
            isWorkStarted = true;
        }

        /// <summary>
        /// ����� ������ � ����������� ������ (��������� ����������)
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
