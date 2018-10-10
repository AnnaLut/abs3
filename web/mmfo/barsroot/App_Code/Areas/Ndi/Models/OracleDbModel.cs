using System;
using System.Data;
using Bars.Classes;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using BarsWeb.Areas.Ndi.Infrastructure.Repository.Helpers;

namespace BarsWeb.Areas.Ndi.Models
{
    /// <summary>
    /// Summary description for OracleDbModel
    /// </summary>
    public class OracleDbModel : IDisposable
    {
        public OracleClob CommandClob { get; set; }
        public byte[] ParmeterBytes;
        public OracleDbModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        private OracleConnection _conn = null;

        //private static OracleDbModel thisInstance;
        //public static OracleDbModel OracleDbModelFactory
        //{
        //    get
        //    {
        //        if (thisInstance == null)
        //            thisInstance = new OracleDbModel();
        //        return thisInstance;
        //    }
        //}
        public void CreateAndSetConn()
        {
            if (_conn == null || _conn.State != ConnectionState.Open)
                _conn = OraConnector.Handler.UserConnection;
        }

        public OracleConnection GetConnOrCreate
        {
            get { return _conn ?? (_conn = OraConnector.Handler.UserConnection); }
        }
        private OracleCommand _command = null;

        public bool IsOpenConnection { get { return _conn != null && _conn.State == ConnectionState.Open; } }
        public OracleCommand GetCommandOrCreate
        {
            get
            {
                if (_command == null)
                {
                    if (_conn == null)
                        _conn = OraConnector.Handler.UserConnection;
                    _command = _conn.CreateCommand();
                }
                return _command;
            }

        }
        public OracleCommand CreateCommand
        {
            get
            {
                if (_command != null)
                    DisposeCommand();
                if (_conn == null)
                    _conn = OraConnector.Handler.UserConnection;
                 _command = _conn.CreateCommand();
                return _command;
            }

        }
        public OracleCommand GetCommand
        {
            get
            {
                return _command;
            }

        }
        public OracleCommand GetCommandWithBeginTransaction
        {
            get
            {
                if (_command == null)
                {
                    if (_conn == null)
                        _conn = OraConnector.Handler.UserConnection;
                    _command = _conn.CreateCommand();
                
                if (_myTransaction == null)
                    _myTransaction = _conn.BeginTransaction();
                _command.Transaction = _myTransaction;
                }
                return _command;
            }

        }
        public OracleConnection GetConnectionWithBeginTransaction
        {
            get
            {
                if (_conn == null)
                {
                    _conn = OraConnector.Handler.UserConnection;
                    _myTransaction = _conn.BeginTransaction();
                }

                return _conn;
            }
        }

        private OracleTransaction _myTransaction;

        public OracleTransaction MyTransaction
        {
            get { return _myTransaction; }
            set { _myTransaction = value; }
        }

        public bool CommitTransaction()
        {
            this._myTransaction.Commit();
            return true;
        }
        private void DisposeCommand()
        {
            if (_command != null)
            {
                _command.Dispose();
                _command = null;
            }
        }
        public void Dispose()
        {
            if (_command != null)
            {
                DisposeCommand();
            }

            if (CommandClob != null)
            {
                CommandClob.Close();
                CommandClob.Dispose();
                CommandClob = null;
                ParmeterBytes = null;
            }
              
        
            if (_conn != null && _conn.State == ConnectionState.Open)
            {
                _conn.Close();
                _conn.Dispose();
                _conn = null;
            }
            if (_myTransaction != null)
            {
                _myTransaction.Dispose();
                _myTransaction = null;
            }

        }
        /*
        * Create this parameter when you want to pass Oracle User-Defined Type (Custom Type) which is table of Oracle User-Defined Types.                  
        * This way you can pass mutiple records at once.
        * 
        * Parameters:
        * name - Name of the UDT Parameter name in the Stored Procedure.
        * oracleUDTName - Name of the Oracle User Defined Type with Schema Name. (Make sure this is all caps. For ex: DESTINY.COMPANYINFOLIST)
        * 
        * */
        public static OracleParameter CreateCustomTypeArrayInputParameter(string name, string oracleUDTName, object value)
        {
            OracleParameter parameter = new OracleParameter();
            parameter.ParameterName = name;
            parameter.OracleDbType = OracleDbType.Array;
            parameter.Direction = ParameterDirection.Input;
            parameter.UdtTypeName = oracleUDTName;
            parameter.Value = value;
            return parameter;
        }

        public OracleCommand CreateCommandWithParams(string sql, CommandType type, params OracleParameter[] parameters)
        {
            var command = CreateCommand;
            command.CommandText = sql;
            command.CommandType = type;
            if (parameters != null && parameters.Length > 0)
            {
                OracleParameterCollection cmdParams = command.Parameters;
                for (var i = 0; i < parameters.Length; i++) { cmdParams.Add(parameters[i]); }
            }
            return command;
        }
        public OracleDataReader GetDataReader(string storedProcedure, params OracleParameter[] parameters)
        {
            return CreateCommandWithParams(storedProcedure, CommandType.StoredProcedure, parameters).ExecuteReader();
        }

        public static OracleParameter CreateCursorParameter(string name)
        {
            OracleParameter prm = new OracleParameter(name, OracleDbType.RefCursor);
            prm.Direction = ParameterDirection.Output;
            return prm;
        }

        public void DisposeWithTransaction(bool result)
        {
            if (_conn !=null && _conn.State == ConnectionState.Open &&  _myTransaction != null)
            {
                if (result)
                    _myTransaction.Commit();
                else
                    _myTransaction.Rollback();
            }
            this.Dispose();
        }
    }
}